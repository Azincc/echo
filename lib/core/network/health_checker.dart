import 'dart:async';
import 'package:echoes/core/network/address_pool.dart';
import 'package:echoes/core/utils/logger.dart';
import 'package:echoes/data/models/server_address.dart';

class HealthChecker {
  static const _tag = 'HEALTH';
  final AddressPool _addressPool;
  Timer? _timer;

  HealthChecker(this._addressPool);

  void start() {
    stop();
    Logger.infoWithTag(_tag, 'health checker started');
    _check(); // initial check
    _timer = Timer.periodic(const Duration(seconds: 30), (_) => _check());
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    Logger.infoWithTag(_tag, 'health checker stopped');
  }

  Future<void> _check() async {
    final active = _addressPool.activeAddress;
    Logger.debugWithTag(
      _tag,
      'health check tick, active=${active?.label ?? 'none'}',
    );

    // Check if current active connection is still good
    if (active != null) {
      final probedCurrent = await _addressPool.probeAddress(active);
      _addressPool.updateProbedAddress(probedCurrent);

      if (probedCurrent.status != ServerAddressStatus.ok) {
        Logger.warnWithTag(
          _tag,
          'active address unhealthy: ${probedCurrent.label}',
        );
        // 手动模式 + 自动回退关闭时，不自动切换
        if (_addressPool.isManualMode && !_addressPool.autoFallback) {
          Logger.warnWithTag(
            _tag,
            'manual mode with autoFallback disabled, skip recovery',
          );
          return;
        }

        final next = _addressPool.getNextAvailable();
        if (next != null && next.id != probedCurrent.id) {
          Logger.infoWithTag(
            _tag,
            'recovering by switching to ${next.label}',
          );
          await _addressPool.switchTo(next, manual: false);
        }
      } else {
        // Current is OK.
        // 手动模式下不自动回退到更高优先级
        if (_addressPool.isManualMode) {
          return;
        }

        // Check if we are using suboptimal connection (fallback).
        // Try to recover to higher priority address if available.
        final sorted = _addressPool.addresses;

        if (sorted.isNotEmpty && active.id != sorted.first.id) {
          final best = sorted.first;
          final bestProbed = await _addressPool.probeAddress(best);
          _addressPool.updateProbedAddress(bestProbed);

          if (bestProbed.status == ServerAddressStatus.ok) {
            Logger.infoWithTag(
              _tag,
              'promoting higher-priority address: ${bestProbed.label}',
            );
            await _addressPool.switchTo(bestProbed, manual: false);
          }
        }
      }
    } else {
      // No active address. Maybe try to find one?
      Logger.warnWithTag(_tag, 'no active address, triggering probeAll');
      _addressPool.probeAll();
    }
  }
}
