import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:echoes/core/network/address_pool.dart';
import 'package:echoes/core/utils/logger.dart';
import 'package:flutter/foundation.dart';

/// 网络类型枚举
enum NetworkType { wifi, mobile, none }

class ConnectivityMonitor {
  static const _tag = 'CONNECTIVITY';
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
    Logger.infoWithTag(_tag, 'connectivity monitor started');

    // 初始检测
    Connectivity().checkConnectivity().then((results) {
      _updateNetworkType(results);
    }).catchError((e) {
      Logger.warnWithTag(_tag, 'initial connectivity check failed', e);
    });

    _subscription = Connectivity().onConnectivityChanged.listen((results) {
      if (!listEquals(results, _lastResults)) {
        _lastResults = results;
        Logger.infoWithTag(_tag, 'connectivity changed: $results');
        _updateNetworkType(results);

        final hasConnection = results.any((r) => r != ConnectivityResult.none);
        if (hasConnection) {
          Logger.infoWithTag(
            _tag,
            'connection available, probing address pool',
          );
          _addressPool.probeAll();
        }
      }
    }, onError: (e) {
      Logger.warnWithTag(_tag, 'connectivity stream error', e);
    });
  }

  void _updateNetworkType(List<ConnectivityResult> results) {
    final newType = _resolveNetworkType(results);
    if (newType != _currentNetworkType) {
      _currentNetworkType = newType;
      _networkTypeController.add(newType);
      Logger.infoWithTag(_tag, 'network type changed: $newType');
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
    Logger.infoWithTag(_tag, 'connectivity monitor stopped');
    _networkTypeController.close();
  }
}
