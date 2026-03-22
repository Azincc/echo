import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/network/connectivity_monitor.dart';
import '../core/utils/logger.dart';
import '../providers/api_provider.dart';
import '../providers/navigation_provider.dart';

typedef VisibleRemoteRetryCondition = bool Function(WidgetRef ref);
typedef VisibleRemoteRetryAction = FutureOr<void> Function(WidgetRef ref);

class VisibleRemoteRetryScope extends ConsumerStatefulWidget {
  const VisibleRemoteRetryScope({
    super.key,
    required this.child,
    required this.shouldRetry,
    required this.onRetry,
    required this.debugLabel,
    this.branchIndex,
  });

  final Widget child;
  final VisibleRemoteRetryCondition shouldRetry;
  final VisibleRemoteRetryAction onRetry;
  final String debugLabel;
  final int? branchIndex;

  @override
  ConsumerState<VisibleRemoteRetryScope> createState() =>
      _VisibleRemoteRetryScopeState();
}

class _VisibleRemoteRetryScopeState
    extends ConsumerState<VisibleRemoteRetryScope> {
  StreamSubscription<NetworkType>? _networkTypeSubscription;
  NetworkType _lastObservedNetworkType = NetworkType.none;
  bool _retryInProgress = false;

  @override
  void initState() {
    super.initState();
    final connectivityMonitor = ref.read(connectivityMonitorProvider);
    _lastObservedNetworkType = connectivityMonitor.currentNetworkType;
    _networkTypeSubscription = connectivityMonitor.networkTypeStream.listen(
      _handleNetworkTypeChanged,
      onError: (Object error, StackTrace stackTrace) {
        Logger.warnWithTag(
          'PAGE_RETRY',
          'network listener failed for ${widget.debugLabel}',
          error,
        );
      },
    );
  }

  @override
  void dispose() {
    _networkTypeSubscription?.cancel();
    super.dispose();
  }

  void _handleNetworkTypeChanged(NetworkType networkType) {
    final previousType = _lastObservedNetworkType;
    _lastObservedNetworkType = networkType;
    if (networkType == NetworkType.none || previousType == networkType) {
      return;
    }
    unawaited(_retryIfNeeded(previousType, networkType));
  }

  Future<void> _retryIfNeeded(
    NetworkType previousType,
    NetworkType currentType,
  ) async {
    if (!mounted || _retryInProgress || !_isPageVisible()) {
      return;
    }
    if (!widget.shouldRetry(ref)) {
      return;
    }

    _retryInProgress = true;
    Logger.infoWithTag(
      'PAGE_RETRY',
      'retry visible page ${widget.debugLabel} '
          'on connectivity change $previousType->$currentType',
    );
    try {
      await widget.onRetry(ref);
    } catch (e, stackTrace) {
      Logger.warnWithTag(
        'PAGE_RETRY',
        'retry visible page failed: ${widget.debugLabel}',
        e,
      );
      Logger.debugWithTag(
        'PAGE_RETRY',
        'retry visible page stackTrace: ${widget.debugLabel}',
        null,
        stackTrace,
      );
    } finally {
      _retryInProgress = false;
    }
  }

  bool _isPageVisible() {
    final route = ModalRoute.of(context);
    if (route != null && !route.isCurrent) {
      return false;
    }
    final branchIndex = widget.branchIndex;
    if (branchIndex == null) {
      return true;
    }
    return ref.read(currentVisibleBranchIndexProvider) == branchIndex;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
