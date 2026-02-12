import 'dart:async';

import 'package:dio/dio.dart';
import 'package:echo/data/models/server_address.dart';

/// 地址池：管理一个音乐库的多个地址
class AddressPool {
  final Dio _dio;

  List<ServerAddress> _addresses = [];
  ServerAddress? _activeAddress;

  /// 自动回退开关：手动选择线路后，线路挂掉是否自动切换到可用线路
  bool autoFallback = true;

  // Callback to persist changes (e.g. latency updates)
  final Function(ServerAddress address)? onAddressUpdated;

  // Callback when active address changes
  final Function(ServerAddress? address)? onActiveAddressChanged;

  AddressPool(this._dio, {this.onAddressUpdated, this.onActiveAddressChanged});

  List<ServerAddress> get addresses => List.unmodifiable(_addresses);
  ServerAddress? get activeAddress => _activeAddress;

  /// 当前是否处于手动模式（有锁定的地址）
  bool get isManualMode => _activeAddress?.isLocked == true;

  void setAddresses(List<ServerAddress> newAddresses) {
    _addresses = List.of(newAddresses)
      ..sort((a, b) => a.priority.compareTo(b.priority));

    // If active address is not in new list, reset or pick best
    if (_activeAddress != null &&
        !_addresses.any((a) => a.id == _activeAddress!.id)) {
      _activeAddress = null;
    }

    // 不立即选定 active，而是触发探测让 probeAll 选最优可达地址
    if (_activeAddress == null && _addresses.isNotEmpty) {
      probeAll();
    }
  }

  /// 启动时全量探测，选择最优可达地址
  Future<ServerAddress?> probeAll() async {
    if (_addresses.isEmpty) return null;

    final results = await Future.wait(
      _addresses.map((addr) => probeAddress(addr)),
    );

    // Update local list with new latencies/statuses
    for (int i = 0; i < _addresses.length; i++) {
      _addresses[i] = results[i];
      onAddressUpdated?.call(_addresses[i]);
    }

    // 手动模式下只更新延迟数据，不切换活跃地址
    if (isManualMode) {
      // 更新当前活跃地址的探测结果
      final updatedActive = _addresses.cast<ServerAddress?>().firstWhere(
        (a) => a!.id == _activeAddress!.id,
        orElse: () => null,
      );
      if (updatedActive != null) {
        _activeAddress = updatedActive;
      }
      return _activeAddress;
    }

    // 自动模式：选择最优可达地址
    final newActive = _getNextAvailable();
    if (_activeAddress?.id != newActive?.id) {
      _activeAddress = newActive;
      onActiveAddressChanged?.call(_activeAddress);
    }
    return _activeAddress;
  }

  Future<ServerAddress> probeAddress(ServerAddress address) async {
    final start = DateTime.now();
    try {
      final response = await _dio
          .head(
            '${address.url}/rest/ping',
            options: Options(
              validateStatus: (status) => status != null && status < 500,
              sendTimeout: const Duration(seconds: 5),
              receiveTimeout: const Duration(seconds: 5),
            ),
          )
          .timeout(const Duration(seconds: 5));

      final latency = DateTime.now().difference(start).inMilliseconds;
      if (response.statusCode == 200) {
        return address.copyWith(
          status: ServerAddressStatus.ok,
          lastLatencyMs: latency,
        );
      } else {
        return address.copyWith(
          status: ServerAddressStatus.failed,
          lastLatencyMs: null,
        );
      }
    } catch (e) {
      return address.copyWith(
        status: ServerAddressStatus.failed,
        lastLatencyMs: null,
      );
    }
  }

  /// 标记某地址探测失败
  void markFailed(ServerAddress addr) {
    final index = _addresses.indexWhere((a) => a.id == addr.id);
    if (index != -1) {
      _addresses[index] = _addresses[index].copyWith(
        status: ServerAddressStatus.failed,
      );
      onAddressUpdated?.call(_addresses[index]);
    }
  }

  /// 获取下一个可用地址（按优先级）
  ServerAddress? getNextAvailable() {
    return _getNextAvailable();
  }

  ServerAddress? _getNextAvailable() {
    // Find first OK address
    try {
      return _addresses.firstWhere(
        (a) => a.status == ServerAddressStatus.ok && !a.isLocked,
      );
    } catch (_) {
      // If no OK address, maybe try first one that is Unknown?
      // Or return null if all failed.
      // Plan says: "Fallback: ... automatically try next priority address"

      // If active failed, get next in list
      if (_activeAddress != null) {
        final currentIndex = _addresses.indexWhere(
          (a) => a.id == _activeAddress!.id,
        );
        if (currentIndex != -1 && currentIndex < _addresses.length - 1) {
          return _addresses[currentIndex + 1];
        }
      } else if (_addresses.isNotEmpty) {
        return _addresses.first;
      }
      return null;
    }
  }

  /// 切换到自动模式（解锁所有地址，自动选择最优）
  Future<void> setAutoMode() async {
    for (int i = 0; i < _addresses.length; i++) {
      if (_addresses[i].isLocked) {
        _addresses[i] = _addresses[i].copyWith(isLocked: false);
        onAddressUpdated?.call(_addresses[i]);
      }
    }
    await probeAll();
  }

  /// 切换到手动模式（锁定指定地址）
  Future<void> setManualMode(ServerAddress addr) async {
    // Probe it first to update latency
    final probed = await probeAddress(addr);

    // Update in list and lock it
    for (int i = 0; i < _addresses.length; i++) {
      var a = _addresses[i];
      if (a.id == addr.id) {
        // Update with probed data AND lock it
        _addresses[i] = probed.copyWith(isLocked: true);
        onAddressUpdated?.call(_addresses[i]);
        _activeAddress = _addresses[i];
        onActiveAddressChanged?.call(_activeAddress);
      } else if (a.isLocked) {
        // Unlock others
        _addresses[i] = a.copyWith(isLocked: false);
        onAddressUpdated?.call(_addresses[i]);
      }
    }
  }

  /// 切换到指定地址 (Deprecated: use setManualMode)
  Future<bool> switchTo(ServerAddress addr) async {
    await setManualMode(addr);
    return _activeAddress?.status == ServerAddressStatus.ok;
  }

  /// 用户手动锁定某地址（不参与自动切换）
  void lockAddress(ServerAddress addr) {
    setManualMode(addr);
  }
}
