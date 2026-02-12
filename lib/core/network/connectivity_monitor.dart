import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:echoes/core/network/address_pool.dart';
import 'package:flutter/foundation.dart';

class ConnectivityMonitor {
  final AddressPool _addressPool;
  List<ConnectivityResult> _lastResults = [ConnectivityResult.none];

  ConnectivityMonitor(this._addressPool);

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  void start() {
    _subscription?.cancel();
    _subscription = Connectivity().onConnectivityChanged.listen((results) {
      if (!listEquals(results, _lastResults)) {
        _lastResults = results;
        final hasConnection = results.any((r) => r != ConnectivityResult.none);

        if (hasConnection) {
          debugPrint(
            "Network connection changed: $results. Probing addresses...",
          );
          _addressPool.probeAll();
        }
      }
    });
  }

  void stop() {
    _subscription?.cancel();
  }
}
