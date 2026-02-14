import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:echoes/core/network/address_pool.dart';
import 'package:flutter/foundation.dart';

/// 网络类型枚举
enum NetworkType { wifi, mobile, none }

class ConnectivityMonitor {
  final AddressPool _addressPool;
  List<ConnectivityResult> _lastResults = [ConnectivityResult.none];

  /// 当前网络类型的 StreamController
  final _networkTypeController = StreamController<NetworkType>.broadcast();

  /// 当前网络类型
  NetworkType _currentNetworkType = NetworkType.none;

  ConnectivityMonitor(this._addressPool);

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  /// 当前网络类型 Stream
  Stream<NetworkType> get networkTypeStream => _networkTypeController.stream;

  /// 当前网络类型
  NetworkType get currentNetworkType => _currentNetworkType;

  void start() {
    _subscription?.cancel();

    // 初始检测
    Connectivity().checkConnectivity().then((results) {
      _updateNetworkType(results);
    });

    _subscription = Connectivity().onConnectivityChanged.listen((results) {
      if (!listEquals(results, _lastResults)) {
        _lastResults = results;
        _updateNetworkType(results);

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

  void _updateNetworkType(List<ConnectivityResult> results) {
    final newType = _resolveNetworkType(results);
    if (newType != _currentNetworkType) {
      _currentNetworkType = newType;
      _networkTypeController.add(newType);
      debugPrint('Network type changed: $newType');
    }
  }

  NetworkType _resolveNetworkType(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.wifi)) {
      return NetworkType.wifi;
    } else if (results.contains(ConnectivityResult.mobile)) {
      return NetworkType.mobile;
    } else if (results.contains(ConnectivityResult.ethernet)) {
      return NetworkType.wifi; // 有线视为 Wi-Fi（不限流量）
    } else if (results.contains(ConnectivityResult.vpn)) {
      // VPN 下保守处理，视为 mobile
      return NetworkType.mobile;
    } else if (results.every((r) => r == ConnectivityResult.none)) {
      return NetworkType.none;
    }
    // 其他情况（bluetooth 等）视为 mobile
    return NetworkType.mobile;
  }

  void stop() {
    _subscription?.cancel();
    _networkTypeController.close();
  }
}
