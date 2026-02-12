import 'dart:async';

import 'package:dio/dio.dart';
import 'package:echo/data/models/server_address.dart';

/// 地址池：管理一个音乐库的多个地址
class AddressPool {
  final Dio _dio;

  List<ServerAddress> _addresses = [];
  ServerAddress? _activeAddress;

  // Callback to persist changes (e.g. latency updates)
  final Function(ServerAddress address)? onAddressUpdated;

  // Callback when active address changes
  final Function(ServerAddress? address)? onActiveAddressChanged;

  AddressPool(this._dio, {this.onAddressUpdated, this.onActiveAddressChanged});

  List<ServerAddress> get addresses => List.unmodifiable(_addresses);
  ServerAddress? get activeAddress => _activeAddress;

  void setAddresses(List<ServerAddress> newAddresses) {
    _addresses = List.of(newAddresses)
      ..sort((a, b) => a.priority.compareTo(b.priority));

    // If active address is not in new list, reset or pick best
    if (_activeAddress != null &&
        !_addresses.any((a) => a.id == _activeAddress!.id)) {
      _activeAddress = null;
    }

    // If no active address, try to set one (usually the first one if known good, or wait for probe)
    if (_activeAddress == null && _addresses.isNotEmpty) {
      // Just pick first for now, or maybe the one with best status?
      // For now, simpler to just set.
      _activeAddress = _addresses.first;
      onActiveAddressChanged?.call(_activeAddress);
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

    // Sort again if needed? Usually priority is static, but maybe we want to sort by latency if priority is equal?
    // Plan says "priority", so we stick to priority.

    // Find first reachable address
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

  /// 切换到指定地址
  Future<bool> switchTo(ServerAddress addr) async {
    final probed = await probeAddress(addr);

    // Update in list
    final index = _addresses.indexWhere((a) => a.id == addr.id);
    if (index != -1) {
      _addresses[index] = probed;
      onAddressUpdated?.call(probed);
    }

    if (probed.status == ServerAddressStatus.ok) {
      _activeAddress = probed;
      onActiveAddressChanged?.call(probed);
      return true;
    }
    return false;
  }

  /// 用户手动锁定某地址（不参与自动切换）
  void lockAddress(ServerAddress addr) {
    // Implementation for locking
    final index = _addresses.indexWhere((a) => a.id == addr.id);
    if (index != -1) {
      _addresses[index] = _addresses[index].copyWith(isLocked: true);
      onAddressUpdated?.call(_addresses[index]);
      _activeAddress = _addresses[index]; // Force switch?
      onActiveAddressChanged?.call(_activeAddress);
    }
  }
}
