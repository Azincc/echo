import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';
import '../models/music_library.dart'; // New model
import '../models/server_address.dart'; // New model
import '../sources/subsonic_api_client.dart';
import '../../core/utils/logger.dart';

/// Authentication Repository
/// Handles login verification. Persistence is now handled by LibraryRepository.
class AuthRepository {
  // We handle ephemeral clients internally for verification

  AuthRepository();

  /// Detect Server Capabilities
  Future<ServerCapabilities> detectServerCapabilities(String serverUrl) async {
    try {
      final tempDio = Dio(
        BaseOptions(
          baseUrl: serverUrl,
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
          responseType: ResponseType.json,
        ),
      );

      final tempClient = SubsonicApiClient(dio: tempDio);
      // No setLibrary needed for initial ping if we only check openSubsonic response structure?
      // Actually ping needs auth usually.
      // But OpenSubsonic servers might respond to ping without auth?
      // Let's try with empty auth.

      // We can create a dummy library
      tempClient.setLibrary(
        MusicLibrary(
          id: 'temp',
          name: 'temp',
          authType: MusicLibraryAuthType.token,
          username: '',
          password: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      try {
        final result = await tempClient.ping();
        return ServerCapabilities(
          isOpenSubsonic: result.isOpenSubsonic,
          serverType: result.serverType,
          serverVersion: result.serverVersion,
          supportsApiKey: result.isOpenSubsonic,
        );
      } catch (e) {
        return ServerCapabilities(isOpenSubsonic: false, supportsApiKey: false);
      }
    } catch (e) {
      Logger.error('Failed to detect server capabilities', e);
      rethrow;
    }
  }

  /// Login with Token/Salt (Password)
  Future<LoginResult> loginWithPassword({
    required String serverUrl,
    required String username,
    required String password,
    String? libraryName,
    String? addressLabel,
  }) async {
    return _attemptLogin(
      serverUrl: serverUrl,
      username: username,
      authType: MusicLibraryAuthType.token,
      password: password,
      libraryName: libraryName,
      addressLabel: addressLabel,
    );
  }

  /// Login with API Key
  Future<LoginResult> loginWithApiKey({
    required String serverUrl,
    required String username,
    required String apiKey,
    String? libraryName,
    String? addressLabel,
  }) async {
    return _attemptLogin(
      serverUrl: serverUrl,
      username: username,
      authType: MusicLibraryAuthType.apiKey,
      apiKey: apiKey,
      libraryName: libraryName,
      addressLabel: addressLabel,
    );
  }

  Future<LoginResult> _attemptLogin({
    required String serverUrl,
    required String username,
    required MusicLibraryAuthType authType,
    String? password,
    String? apiKey,
    String? libraryName,
    String? addressLabel,
  }) async {
    try {
      final tempDio = Dio(
        BaseOptions(
          baseUrl: serverUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          responseType: ResponseType.json,
        ),
      );

      final tempClient = SubsonicApiClient(dio: tempDio);

      final tempLib = MusicLibrary(
        id: const Uuid().v4(),
        name: 'Temp',
        authType: authType,
        username: username,
        password: password,
        apiKey: apiKey,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      tempClient.setLibrary(tempLib);

      // Ping
      final pingResult = await tempClient.ping();

      if (!pingResult.success) {
        return LoginResult(
          success: false,
          errorMessage: pingResult.errorMessage ?? 'Connection failed',
        );
      }

      // Get Extensions if OpenSubsonic
      Map<String, dynamic> extensions = {};
      if (pingResult.isOpenSubsonic) {
        try {
          final exts = await tempClient.getOpenSubsonicExtensions();
          // Store as map or list? Model says map.
          // Actually model says Map<String, dynamic> extensions
          // The API returns List<String>.
          // Let's store it as {'list': [...]}?
          // Or change model? The model says Map<String, dynamic>.
          // Let's just say extensions['supported'] = [list]
          extensions = {'supported': exts};
        } catch (_) {}
      }

      // Compute Server Fingerprint
      final fingerprint = await _computeServerFingerprint(tempClient, username);
      extensions['serverFingerprint'] = fingerprint; // Store in extensions

      // Create final MusicLibrary object
      // Define initial address
      final effectiveAddressLabel = (addressLabel ?? '').trim();
      final address = ServerAddress(
        id: const Uuid().v4(),
        libraryId: tempLib.id,
        label: effectiveAddressLabel.isNotEmpty
            ? effectiveAddressLabel
            : 'Primary',
        url: serverUrl,
        priority: 0,
        status: ServerAddressStatus.ok,
        lastLatencyMs: 0, // We could measure this
      );

      final effectiveLibraryName = (libraryName ?? '').trim();
      final finalLib = tempLib.copyWith(
        name: effectiveLibraryName.isNotEmpty
            ? effectiveLibraryName
            : (pingResult.serverType ?? 'Subsonic Server'),
        serverType: pingResult.serverType,
        serverVersion: pingResult.serverVersion,
        isOpenSubsonic: pingResult.isOpenSubsonic,
        extensions: extensions,
        addresses: [address],
        isActive: true, // Will be made active
      );

      return LoginResult(success: true, library: finalLib);
    } catch (e) {
      Logger.error('Login failed', e);
      return LoginResult(success: false, errorMessage: e.toString());
    }
  }

  /// Verify if the new address belongs to the same server as the existing library
  Future<bool> verifyServerIdentity(
    ServerAddress newAddress,
    MusicLibrary existingLibrary,
  ) async {
    try {
      final tempDio = Dio(
        BaseOptions(
          baseUrl: newAddress.url,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          responseType: ResponseType.json,
        ),
      );

      final tempClient = SubsonicApiClient(dio: tempDio);
      tempClient.setLibrary(existingLibrary);

      // We rely on existing credentials working on new address.
      // If ping fails (auth fail), then it's definitely not usable.
      final pingResult = await tempClient.ping();
      if (!pingResult.success) {
        Logger.warn(
          'Verify identity: Ping failed - ${pingResult.errorMessage}',
        );
        return false;
      }

      // 同一 URL（例如重复添加 Primary）直接视为同一服务器。
      final normalizedNewUrl = _normalizeUrl(newAddress.url);
      final hasSameExistingUrl = existingLibrary.addresses.any(
        (a) => _normalizeUrl(a.url) == normalizedNewUrl,
      );
      if (hasSameExistingUrl) {
        return true;
      }

      final username = existingLibrary.username ?? '';
      final newFingerprint = await _computeServerFingerprint(
        tempClient,
        username,
      );

      // 固定使用“首个线路（priority 最小）”作为旧 fingerprint 来源
      final fingerprintSource = _getFingerprintSourceAddress(existingLibrary);
      if (fingerprintSource != null) {
        final oldDio = Dio(
          BaseOptions(
            baseUrl: fingerprintSource.url,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            responseType: ResponseType.json,
          ),
        );
        final oldClient = SubsonicApiClient(dio: oldDio);
        oldClient.setLibrary(existingLibrary);

        final oldPing = await oldClient.ping();
        if (oldPing.success) {
          final oldFingerprint = await _computeServerFingerprint(
            oldClient,
            username,
          );
          if (oldFingerprint == newFingerprint) {
            return true;
          }

          Logger.warn(
            'Verify identity: Fingerprint mismatch. Expected $oldFingerprint, got $newFingerprint',
          );
          return false;
        }
      }

      // 回退：首条线路不可达时，使用历史保存指纹校验
      final storedFingerprint = existingLibrary.extensions['serverFingerprint'];
      if (storedFingerprint != null) {
        final storedFp = storedFingerprint.toString();
        if (storedFp == newFingerprint) {
          return true;
        }
      }

      Logger.warn(
        'Verify identity: Unable to verify with primary fingerprint source',
      );
      return false;
    } catch (e) {
      Logger.error('Verify identity failed', e);
      return false;
    }
  }

  Future<String> _computeServerFingerprint(
    SubsonicApiClient client,
    String username,
  ) async {
    try {
      final folders = await client.getMusicFolders();
      // Sort by ID to ensure deterministic order
      folders.sort((a, b) {
        final idA = a['id'].toString();
        final idB = b['id'].toString();
        return idA.compareTo(idB); // String compare IDs
      });

      final sb = StringBuffer();
      sb.write('user:$username|');
      for (final folder in folders) {
        sb.write('folder:${folder['id']}:${folder['name']}|');
      }
      return sb.toString();
    } catch (e) {
      Logger.warn('Failed to compute fingerprint, defaulting to user only', e);
      return 'user:$username';
    }
  }

  String _normalizeUrl(String url) {
    var u = url.trim();
    if (u.endsWith('/')) {
      u = u.substring(0, u.length - 1);
    }
    return u.toLowerCase();
  }

  ServerAddress? _getFingerprintSourceAddress(MusicLibrary library) {
    if (library.addresses.isEmpty) return null;
    final sorted = List<ServerAddress>.from(library.addresses)
      ..sort((a, b) => a.priority.compareTo(b.priority));
    return sorted.first;
  }

  // Legacy load/logout methods are removed as they are handled by LibraryRepository
}

class ServerCapabilities {
  final bool isOpenSubsonic;
  final String? serverType;
  final String? serverVersion;
  final bool supportsApiKey;

  ServerCapabilities({
    required this.isOpenSubsonic,
    this.serverType,
    this.serverVersion,
    required this.supportsApiKey,
  });
}

class LoginResult {
  final bool success;
  final MusicLibrary? library;
  final String? errorMessage;

  LoginResult({required this.success, this.library, this.errorMessage});
}
