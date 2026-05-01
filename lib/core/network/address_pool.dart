import 'package:dio/dio.dart';
import 'package:echoes/data/models/server_address.dart';
import 'package:echoes/core/utils/logger.dart';

/// 地址池：管理一个音乐库的多个地址
class AddressPool {
  static const _tag = 'ADDR_POOL';
  final Dio _dio;

  List<ServerAddress> _addresses = [];
  ServerAddress? _activeAddress;
  Future<ServerAddress?>? _probeAllFuture;

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
    Logger.infoWithTag(_tag, 'setAddresses count=${newAddresses.length}');
    _addresses = List.of(newAddresses)
      ..sort((a, b) => a.priority.compareTo(b.priority));

    // If active address is not in new list, reset or pick best
    if (_activeAddress != null &&
        !_addresses.any((a) => a.id == _activeAddress!.id)) {
      Logger.warnWithTag(
        _tag,
        'active address removed from pool: ${_activeAddress!.label}',
      );
      _activeAddress = null;
    }

    // 不立即选定 active，而是触发探测让 probeAll 选最优可达地址
    if (_activeAddress == null && _addresses.isNotEmpty) {
      Logger.debugWithTag(_tag, 'no active address, probing all candidates');
      probeAll();
    }
  }

  /// 启动时全量探测，选择最优可达地址
  Future<ServerAddress?> probeAll() async {
    final inFlight = _probeAllFuture;
    if (inFlight != null) {
      Logger.debugWithTag(_tag, 'probeAll joined: existing probe in progress');
      return inFlight;
    }

    final future = _probeAllInternal();
    _probeAllFuture = future;
    future.whenComplete(() {
      if (identical(_probeAllFuture, future)) {
        _probeAllFuture = null;
      }
    });
    return future;
  }

  Future<ServerAddress?> _probeAllInternal() async {
    if (_addresses.isEmpty) {
      Logger.warnWithTag(_tag, 'probeAll skipped: empty address list');
      return null;
    }

    Logger.debugWithTag(
      _tag,
      'probeAll start, count=${_addresses.length} '
      'manualMode=$isManualMode autoFallback=$autoFallback '
      'active=${_activeAddress?.label ?? 'none'} '
      'candidates=${_summarizeCandidates()}',
    );

    await Future.wait(
      _addresses.map((addr) async {
        final probed = await probeAddress(addr);
        _applyProbeResult(probed, allowEarlyActiveSelection: true);
      }),
    );

    // 手动模式下只更新延迟数据，不切换活跃地址
    if (isManualMode) {
      // 更新当前活跃地址的探测结果
      final updatedActive = _addresses
          .where((a) => a.id == _activeAddress!.id)
          .firstOrNull;
      if (updatedActive != null) {
        _setActiveAddress(updatedActive);
        Logger.infoWithTag(
          _tag,
          'manual mode keeps active address: ${updatedActive.label}'
          ' status=${updatedActive.status.name}'
          ' latency=${updatedActive.lastLatencyMs ?? -1}ms',
        );
      }
      return _activeAddress;
    }

    // 自动模式：选择最优可达地址
    final newActive = _getNextAvailable();
    _setActiveAddress(newActive);
    if (newActive == null) {
      Logger.warnWithTag(_tag, 'probeAll completed but no available address');
    }
    return _activeAddress;
  }

  Future<ServerAddress> probeAddress(ServerAddress address) async {
    final start = DateTime.now();
    final uri = Uri.parse('${address.url}/rest/ping');
    final port = uri.hasPort ? uri.port : (uri.scheme == 'https' ? 443 : 80);
    Logger.debugWithTag(
      _tag,
      'probing ${address.label} url=${address.url} '
      'host=${uri.host} port=$port scheme=${uri.scheme} path=${uri.path}',
    );

    await _debugResolveHost(address, uri);

    try {
      final response = await _dio
          .head(
            uri.toString(),
            options: Options(
              validateStatus: (status) => status != null && status < 500,
              sendTimeout: const Duration(seconds: 5),
              receiveTimeout: const Duration(seconds: 5),
            ),
          )
          .timeout(const Duration(seconds: 5));

      final latency = DateTime.now().difference(start).inMilliseconds;
      final contentLength =
          response.headers.value(Headers.contentLengthHeader) ?? '-';
      Logger.debugWithTag(
        _tag,
        'probe response: ${address.label} status=${response.statusCode} '
        'latency=${latency}ms realUri=${response.realUri} '
        'contentLength=$contentLength',
      );
      if (response.statusCode == 200) {
        Logger.debugWithTag(
          _tag,
          'probe success: ${address.label} latency=${latency}ms',
        );
        return address.copyWith(
          status: ServerAddressStatus.ok,
          lastLatencyMs: latency,
        );
      } else {
        Logger.warnWithTag(
          _tag,
          'probe failed (status=${response.statusCode}) for ${address.label}',
        );
        return address.copyWith(
          status: ServerAddressStatus.failed,
          lastLatencyMs: null,
        );
      }
    } catch (e) {
      final latency = DateTime.now().difference(start).inMilliseconds;
      Logger.warnWithTag(
        _tag,
        'probe exception for ${address.label} '
        'latency=${latency}ms url=${uri.toString()}',
        e,
      );
      return address.copyWith(
        status: ServerAddressStatus.failed,
        lastLatencyMs: null,
      );
    }
  }

  Future<void> _debugResolveHost(ServerAddress address, Uri uri) async {
    final host = uri.host;
    if (host.isEmpty) {
      Logger.warnWithTag(
        _tag,
        'probe dns skipped: ${address.label} empty host',
      );
      return;
    }

    Logger.debugWithTag(
      _tag,
      'probe dns skipped: ${address.label} host=$host (platform-neutral build)',
    );
  }

  String _summarizeCandidates() {
    return _addresses
        .map(
          (address) =>
              '${address.label}@${address.url}'
              '[p=${address.priority},'
              'status=${address.status.name},'
              'locked=${address.isLocked},'
              'lat=${address.lastLatencyMs ?? -1}]',
        )
        .join('; ');
  }

  void _applyProbeResult(
    ServerAddress probed, {
    bool allowEarlyActiveSelection = false,
  }) {
    final index = _addresses.indexWhere((a) => a.id == probed.id);
    if (index == -1) return;

    final current = _addresses[index];
    final updated = probed.copyWith(isLocked: current.isLocked);
    _addresses[index] = updated;
    onAddressUpdated?.call(updated);

    if (_activeAddress?.id == updated.id) {
      _setActiveAddress(updated);
    } else if (allowEarlyActiveSelection) {
      _promoteActiveAddressDuringProbe();
    }

    Logger.debugWithTag(
      _tag,
      'updated probe result: ${updated.label}'
      ' status=${updated.status.name}'
      ' latency=${updated.lastLatencyMs ?? -1}ms',
    );
  }

  void _promoteActiveAddressDuringProbe() {
    if (isManualMode) return;

    final current = _activeAddress;
    final hasHealthyActive = current?.status == ServerAddressStatus.ok;
    if (hasHealthyActive) return;

    final next = _getNextAvailable();
    if (next == null) return;
    if (current?.id == next.id &&
        current?.status == next.status &&
        current?.lastLatencyMs == next.lastLatencyMs) {
      return;
    }

    final oldLabel = current?.label ?? 'none';
    _setActiveAddress(next);
    if (current?.id != next.id) {
      Logger.infoWithTag(
        _tag,
        'active address promoted during probe: $oldLabel -> ${next.label}',
      );
    }
  }

  void _setActiveAddress(ServerAddress? newActive) {
    final oldActive = _activeAddress;
    _activeAddress = newActive;

    final changed =
        newActive?.id != oldActive?.id ||
        newActive?.status != oldActive?.status ||
        newActive?.lastLatencyMs != oldActive?.lastLatencyMs ||
        newActive?.url != oldActive?.url;
    if (!changed) return;

    onActiveAddressChanged?.call(_activeAddress);
    if (newActive?.id != oldActive?.id) {
      final oldLabel = oldActive?.label ?? 'none';
      final newLabel = newActive?.label ?? 'none';
      Logger.infoWithTag(
        _tag,
        'active address changed: $oldLabel -> $newLabel',
      );
    }
  }

  /// 应用探测结果到内存状态并持久化（保留锁定状态）
  void updateProbedAddress(ServerAddress probed) {
    _applyProbeResult(probed);
  }

  /// 标记某地址探测失败
  void markFailed(ServerAddress addr) {
    final index = _addresses.indexWhere((a) => a.id == addr.id);
    if (index != -1) {
      Logger.warnWithTag(_tag, 'markFailed: ${addr.label}');
      _addresses[index] = _addresses[index].copyWith(
        status: ServerAddressStatus.failed,
      );
      onAddressUpdated?.call(_addresses[index]);
      if (_activeAddress?.id == addr.id) {
        _activeAddress = _addresses[index];
        onActiveAddressChanged?.call(_activeAddress);
      }
    }
  }

  /// 获取下一个可用地址（按优先级）
  ServerAddress? getNextAvailable() {
    return _getNextAvailable();
  }

  ServerAddress? _getNextAvailable() {
    // Find first OK address
    final okAddress = _addresses
        .where((a) => a.status == ServerAddressStatus.ok && !a.isLocked)
        .firstOrNull;
    if (okAddress != null) return okAddress;

    // No OK address found — try next in list after current active
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

  /// 切换到自动模式（解锁所有地址，自动选择最优）
  Future<void> setAutoMode() async {
    Logger.infoWithTag(_tag, 'switching to auto mode');
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
    Logger.infoWithTag(_tag, 'switching to manual mode: ${addr.label}');
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
        Logger.infoWithTag(
          _tag,
          'manual active address set: ${_activeAddress?.label ?? addr.label}',
        );
      } else if (a.isLocked) {
        // Unlock others
        _addresses[i] = a.copyWith(isLocked: false);
        onAddressUpdated?.call(_addresses[i]);
      }
    }
  }

  /// 切换到指定地址 (Deprecated: use setManualMode)
  Future<bool> switchTo(ServerAddress addr, {bool manual = true}) async {
    Logger.infoWithTag(
      _tag,
      'switchTo requested: ${addr.label}, manual=$manual',
    );
    if (manual) {
      await setManualMode(addr);
      final ok = _activeAddress?.status == ServerAddressStatus.ok;
      Logger.infoWithTag(_tag, 'switchTo(manual) result=$ok');
      return ok;
    }

    final probed = await probeAddress(addr);
    ServerAddress? newActive;

    for (int i = 0; i < _addresses.length; i++) {
      final current = _addresses[i];
      if (current.id == addr.id) {
        _addresses[i] = probed.copyWith(isLocked: false);
        onAddressUpdated?.call(_addresses[i]);
        newActive = _addresses[i];
      } else if (current.isLocked) {
        _addresses[i] = current.copyWith(isLocked: false);
        onAddressUpdated?.call(_addresses[i]);
      }
    }

    if (newActive != null && _activeAddress?.id != newActive.id) {
      _activeAddress = newActive;
      onActiveAddressChanged?.call(_activeAddress);
    } else if (newActive != null) {
      _activeAddress = newActive;
    }

    final ok = _activeAddress?.status == ServerAddressStatus.ok;
    Logger.infoWithTag(_tag, 'switchTo(auto) result=$ok');
    return ok;
  }

  /// 用户手动锁定某地址（不参与自动切换）
  void lockAddress(ServerAddress addr) {
    setManualMode(addr);
  }
}
