import 'package:dio/dio.dart';
import 'package:echo/core/constants/api_constants.dart';
import 'package:echo/core/network/address_pool.dart';
import 'package:echo/core/network/connectivity_monitor.dart';
import 'package:echo/core/network/fallback_interceptor.dart';
import 'package:echo/core/network/health_checker.dart';
import 'package:echo/core/utils/logger.dart';

import 'package:echo/data/sources/subsonic_api_client.dart';
import 'package:echo/providers/library_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. Basic Dio Provider
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      responseType: ResponseType.json,
    ),
  );

  // Logging
  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (obj) => Logger.debug(obj.toString()),
    ),
  );

  return dio;
});

// 2. AddressPool Provider
// It listens to activeLibrary and updates addresses
final addressPoolProvider = Provider<AddressPool>((ref) {
  // final dio = ref.watch(dioProvider); // Use same dio or separate?
  // AddressPool needs to probe. It can use the same dio instance,
  // but we must be careful not to trigger FallbackInterceptor RECURSIVELY if we attach it to this dio.
  // Ideally AddressPool uses a clean Dio or a separate one for probing.

  // Let's create a separate simple dio for probing to avoid interference
  final probeDio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  final pool = AddressPool(
    probeDio,
    onAddressUpdated: (addr) {
      ref.read(libraryRepositoryProvider).updateAddress(addr);
    },
    onActiveAddressChanged: (addr) {
      if (addr != null) {
        // Update MAIN dio base URL
        // We can't access 'dioProvider' value inside this callback easily if not captured.
        // But we can use 'ref.read(dioProvider)'.
        // However, 'dioProvider' returns a Dio.
        final mainDio = ref.read(dioProvider);
        if (mainDio.options.baseUrl != addr.url) {
          mainDio.options.baseUrl = addr.url;
          Logger.info("Switched API Base URL to: ${addr.url}");
        }
      }
    },
  );

  return pool;
});

// 3. FallbackInterceptor Logic
// We need to attach the interceptor to the MAIN Dio.
// But Providers are lazy. modifying the provided object instance (Dio) inside another provider is tricky
// if dio is reused.
// A better way is to create a "configuredDioProvider".

final configuredDioProvider = Provider<Dio>((ref) {
  final dio = ref.watch(dioProvider);
  final addressPool = ref.watch(addressPoolProvider);

  // Avoid adding interceptor multiple times
  if (!dio.interceptors.any((i) => i is FallbackInterceptor)) {
    dio.interceptors.add(FallbackInterceptor(addressPool, dio));
  }

  return dio;
});

// 4. Connectivity & Health Monitors
// These should be alive as long as the app is running or we are in a session.
// We can make a "NetworkManager" class or just effect providers.

final networkManagerProvider = Provider<void>((ref) {
  final pool = ref.watch(addressPoolProvider);

  final connectivityMonitor = ConnectivityMonitor(pool);
  connectivityMonitor.start();

  final healthChecker = HealthChecker(pool);
  healthChecker.start();

  ref.onDispose(() {
    connectivityMonitor.stop();
    healthChecker.stop();
  });
});

// 5. Wire Active Library to AddressPool
// This is an effect. When active library changes, we update the pool.
final activeLibrarySynchronizerProvider = Provider<void>((ref) {
  final activeLib = ref.watch(activeLibraryProvider);
  final pool = ref.watch(addressPoolProvider);

  if (activeLib != null) {
    pool.setAddresses(activeLib.addresses);
    // Trigger an initial probe if needed, or AddressPool handles it
    if (pool.activeAddress == null) {
      pool.probeAll();
    }
  } else {
    pool.setAddresses([]);
  }
});

// 6. SubsonicApiClient Provider
final subsonicApiClientProvider = Provider<SubsonicApiClient>((ref) {
  final dio = ref.watch(configuredDioProvider);

  // Ensure monitors are running
  ref.watch(networkManagerProvider);
  ref.watch(activeLibrarySynchronizerProvider);

  final client = SubsonicApiClient(dio: dio);

  // Set config from active library
  final activeLib = ref.watch(activeLibraryProvider);
  client.setLibrary(activeLib);

  return client;
});
