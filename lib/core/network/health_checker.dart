import 'dart:async';
import 'package:echo/core/network/address_pool.dart';
import 'package:echo/data/models/server_address.dart';

class HealthChecker {
  final AddressPool _addressPool;
  Timer? _timer;

  HealthChecker(this._addressPool);

  void start() {
    stop();
    _check(); // initial check
    _timer = Timer.periodic(const Duration(seconds: 30), (_) => _check());
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> _check() async {
    final active = _addressPool.activeAddress;

    // Check if current active connection is still good
    if (active != null) {
      final probedCurrent = await _addressPool.probeAddress(active);
      _addressPool.switchTo(probedCurrent); // Updates local state and status

      if (probedCurrent.status != ServerAddressStatus.ok) {
        // Auto fallback is usually triggered by request failure (interceptor).
        // But here we also check proactively.
        // If current failed, try to switch to next.
        final next = _addressPool.getNextAvailable();
        if (next != null) {
          _addressPool.switchTo(next);
        }
      } else {
        // Current is OK.
        // Check if we are using suboptimal connection (fallback).
        // Try to recover to higher priority address if available.

        final sorted = _addressPool.addresses;
        // sorted is by priority (lowest int first)

        if (sorted.isNotEmpty && active.id != sorted.first.id) {
          // We are not on top priority address.
          // Find the highest priority address (could be first or next better than current)
          // Let's just check the absolute best (first one).
          final best = sorted.first;

          // Probe best address
          final bestProbed = await _addressPool.probeAddress(best);

          if (bestProbed.status == ServerAddressStatus.ok) {
            // Switch back to best!
            _addressPool.switchTo(bestProbed);
          }
        }
      }
    } else {
      // No active address. Maybe try to find one?
      _addressPool.probeAll();
    }
  }
}
