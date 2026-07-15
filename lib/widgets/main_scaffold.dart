import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/design/echo_design.dart';
import '../core/network/connectivity_monitor.dart';
import '../core/utils/logger.dart';
import '../data/models/server_address.dart';
import '../features/player/widgets/mini_player.dart';
import '../providers/api_provider.dart';
import '../providers/navigation_provider.dart';
import '../providers/offline_download_provider.dart';
import '../providers/player_provider.dart';
import 'app_drawer.dart';
import 'echo_app_shell/echo_app_shell.dart';
import 'echo_app_shell/echo_network_status_bar.dart';
import 'echo_app_shell/echo_shell_navigation.dart';

// GlobalKey used to access Scaffold state (e.g. opening drawer).
final scaffoldKey = GlobalKey<ScaffoldState>();
FocusNode? _appDrawerTriggerFocus;

/// Opens the application drawer while retaining the keyboard focus origin.
///
/// Compact pages and the wide shell share this entry point so a drawer-owned
/// overlay can return focus to the exact menu control that launched it.
void openEchoAppDrawer() {
  final currentFocus = FocusManager.instance.primaryFocus;
  if (currentFocus != null &&
      currentFocus.context != null &&
      currentFocus.canRequestFocus) {
    _appDrawerTriggerFocus = currentFocus;
  }
  scaffoldKey.currentState?.openDrawer();
}

/// Page headers own the drawer trigger only in the compact shell.
///
/// Medium and expanded layouts expose the same action from their persistent
/// navigation surface, so retaining the page-level button would create a
/// duplicate control and a confusing accessibility traversal order.
bool shouldShowPageDrawerTrigger(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  return context.echoBreakpoints.classify(width) == EchoWindowClass.compact;
}

void _restoreEchoAppDrawerFocus() {
  final triggerFocus = _appDrawerTriggerFocus;
  _appDrawerTriggerFocus = null;
  if (triggerFocus == null ||
      triggerFocus.context == null ||
      !triggerFocus.canRequestFocus) {
    return;
  }
  triggerFocus.requestFocus();
}

enum EchoBackAction {
  closeDrawer,
  popRootNavigator,
  popBranchNavigator,
  switchToDiscover,
  moveAppToBackground,
}

@visibleForTesting
EchoBackAction resolveEchoBackAction({
  required bool drawerOpen,
  required bool rootCanPop,
  required bool branchCanPop,
  required int currentBranchIndex,
}) {
  if (drawerOpen) return EchoBackAction.closeDrawer;
  if (rootCanPop) return EchoBackAction.popRootNavigator;
  if (branchCanPop) return EchoBackAction.popBranchNavigator;
  if (currentBranchIndex != discoverBranchIndex) {
    return EchoBackAction.switchToDiscover;
  }
  return EchoBackAction.moveAppToBackground;
}

const EchoShellDestination _discoverDestination = EchoShellDestination(
  branchIndex: discoverBranchIndex,
  label: '音乐流',
  icon: AppIcons.home,
  selectedIcon: AppIcons.homeFilled,
);

const EchoShellDestination _exploreDestination = EchoShellDestination(
  branchIndex: exploreBranchIndex,
  label: '探索',
  icon: AppIcons.discover,
  selectedIcon: AppIcons.discoverFilled,
);

const EchoShellDestination _libraryDestination = EchoShellDestination(
  branchIndex: libraryBranchIndex,
  label: '我的',
  icon: AppIcons.library,
  selectedIcon: AppIcons.libraryFilled,
);

@visibleForTesting
List<EchoShellDestination> echoMainDestinations({
  required bool showExploreTab,
}) {
  return <EchoShellDestination>[
    _discoverDestination,
    if (showExploreTab) _exploreDestination,
    _libraryDestination,
  ];
}

class MainScaffold extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;
  final List<GlobalKey<NavigatorState>> branchNavigatorKeys;

  const MainScaffold({
    super.key,
    required this.navigationShell,
    required this.branchNavigatorKeys,
    this.drawerOverride,
    this.miniPlayerOverride,
    this.showMiniPlayerOverride,
    this.showExploreTabOverride,
    this.networkStatusOverride,
  });

  @visibleForTesting
  final Widget? drawerOverride;

  @visibleForTesting
  final Widget? miniPlayerOverride;

  @visibleForTesting
  final bool? showMiniPlayerOverride;

  @visibleForTesting
  final bool? showExploreTabOverride;

  @visibleForTesting
  final EchoNetworkStatus? networkStatusOverride;

  @override
  ConsumerState<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends ConsumerState<MainScaffold> {
  static const _logTag = 'BACK';
  static const MethodChannel _appLifecycleChannel = MethodChannel(
    'com.az1n.echoes/app_lifecycle',
  );
  int? _lastSyncedBranchIndex;
  bool _branchFallbackScheduled = false;
  StreamSubscription<NetworkType>? _networkTypeSubscription;
  Timer? _initialNetworkStateTimer;
  NetworkType? _observedNetworkType;

  @override
  void initState() {
    super.initState();
    _scheduleVisibleBranchSync();
    if (widget.networkStatusOverride == null) {
      _startNetworkObservation();
    }
  }

  @override
  void didUpdateWidget(covariant MainScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    _scheduleVisibleBranchSync();
    if (oldWidget.networkStatusOverride != widget.networkStatusOverride) {
      if (widget.networkStatusOverride == null) {
        _startNetworkObservation();
      } else {
        _stopNetworkObservation();
      }
    }
  }

  @override
  void dispose() {
    _stopNetworkObservation();
    super.dispose();
  }

  void _startNetworkObservation() {
    _stopNetworkObservation();
    final monitor = ref.read(connectivityMonitorProvider);
    _networkTypeSubscription = monitor.networkTypeStream.listen((networkType) {
      _initialNetworkStateTimer?.cancel();
      if (!mounted || _observedNetworkType == networkType) return;
      setState(() {
        _observedNetworkType = networkType;
      });
    });
    _initialNetworkStateTimer = Timer(const Duration(milliseconds: 450), () {
      if (!mounted || _observedNetworkType != null) return;
      setState(() {
        _observedNetworkType = monitor.currentNetworkType;
      });
    });
  }

  void _stopNetworkObservation() {
    _initialNetworkStateTimer?.cancel();
    _initialNetworkStateTimer = null;
    _networkTypeSubscription?.cancel();
    _networkTypeSubscription = null;
    _observedNetworkType = null;
  }

  EchoNetworkStatus _resolveNetworkStatus({
    required bool activeAddressIsHealthy,
  }) {
    final networkType = _observedNetworkType;
    if (networkType == null) return EchoNetworkStatus.online;
    if (networkType == NetworkType.none) return EchoNetworkStatus.offline;
    if (!activeAddressIsHealthy) return EchoNetworkStatus.weak;
    return EchoNetworkStatus.online;
  }

  void _scheduleVisibleBranchSync() {
    final currentIndex = widget.navigationShell.currentIndex;
    if (_lastSyncedBranchIndex == currentIndex) {
      return;
    }
    _lastSyncedBranchIndex = currentIndex;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (widget.navigationShell.currentIndex != currentIndex) return;
      _syncVisibleBranch(currentIndex);
    });
  }

  void _syncVisibleBranch(int branchIndex) {
    _lastSyncedBranchIndex = branchIndex;
    ref.read(currentVisibleBranchIndexProvider.notifier).state = branchIndex;
  }

  void _goToBranch(int branchIndex, {bool initialLocation = false}) {
    _syncVisibleBranch(branchIndex);
    widget.navigationShell.goBranch(
      branchIndex,
      initialLocation: initialLocation,
    );
  }

  void _scheduleHiddenBranchFallback() {
    if (_branchFallbackScheduled) return;
    _branchFallbackScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _branchFallbackScheduled = false;
      if (!mounted) return;
      final currentIndex = widget.navigationShell.currentIndex;
      final currentDestinations = echoMainDestinations(
        showExploreTab: ref.read(
          activeEmbedServiceConfigProvider.select((config) {
            return config.isEnabledAndConfigured;
          }),
        ),
      );
      final stillHidden = !currentDestinations.any(
        (destination) => destination.branchIndex == currentIndex,
      );
      if (stillHidden) {
        _goToBranch(discoverBranchIndex);
      }
    });
  }

  Future<void> _handleBackPressed() async {
    final index = widget.navigationShell.currentIndex;
    final branchCount = widget.branchNavigatorKeys.length;
    Logger.infoWithTag(
      _logTag,
      'back pressed, branchIndex=$index, branchCount=$branchCount',
    );

    final scaffold = scaffoldKey.currentState;
    final rootNavigator = Navigator.of(context);
    NavigatorState? branchNavigator;
    if (index >= 0 && index < branchCount) {
      final navigatorKey = widget.branchNavigatorKeys[index];
      branchNavigator = navigatorKey.currentState;
      Logger.infoWithTag(
        _logTag,
        'navigator for branch $index: '
        'key=$navigatorKey, '
        'state=${branchNavigator != null ? "present" : "null"}, '
        'canPop=${branchNavigator?.canPop()}',
      );
    } else {
      Logger.warnWithTag(
        _logTag,
        'index $index out of range [0, $branchCount)',
      );
    }

    final action = resolveEchoBackAction(
      drawerOpen: scaffold?.isDrawerOpen ?? false,
      rootCanPop: rootNavigator.canPop(),
      branchCanPop: branchNavigator?.canPop() ?? false,
      currentBranchIndex: index,
    );

    switch (action) {
      case EchoBackAction.closeDrawer:
        Logger.infoWithTag(_logTag, 'drawer is open, closing drawer');
        scaffold?.closeDrawer();
      case EchoBackAction.popRootNavigator:
        Logger.infoWithTag(_logTag, 'root navigator can pop, popping');
        rootNavigator.pop();
      case EchoBackAction.popBranchNavigator:
        Logger.infoWithTag(_logTag, 'branch $index can pop, popping');
        branchNavigator?.pop();
      case EchoBackAction.switchToDiscover:
        Logger.infoWithTag(
          _logTag,
          'non-home branch root reached (index=$index), switching to home tab',
        );
        _goToBranch(discoverBranchIndex);
      case EchoBackAction.moveAppToBackground:
        Logger.infoWithTag(
          _logTag,
          'home branch root reached (index=0), move app to background',
        );
        await _moveAppToBackground();
    }
  }

  Future<void> _moveAppToBackground() async {
    try {
      await _appLifecycleChannel.invokeMethod<void>('moveTaskToBack');
      Logger.infoWithTag(_logTag, 'moveTaskToBack invoked');
    } on MissingPluginException {
      // Ignore on non-Android platforms where this channel is not implemented.
      Logger.warnWithTag(_logTag, 'moveTaskToBack channel missing');
    } on PlatformException {
      // Keep app state unchanged if moving to background fails.
      Logger.warnWithTag(_logTag, 'moveTaskToBack invoke failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    _scheduleVisibleBranchSync();
    final bool hasMiniPlayer = widget.showMiniPlayerOverride != null
        ? widget.showMiniPlayerOverride!
        : ref.watch(
            playerProvider.select((state) => state.currentSong != null),
          );
    final bool showExploreTab = widget.showExploreTabOverride != null
        ? widget.showExploreTabOverride!
        : ref.watch(
            activeEmbedServiceConfigProvider.select((config) {
              return config.isEnabledAndConfigured;
            }),
          );
    final activeAddressIsHealthy = ref.watch(
      activeAddressProvider.select((address) {
        return address?.status == ServerAddressStatus.ok;
      }),
    );
    final networkStatus =
        widget.networkStatusOverride ??
        _resolveNetworkStatus(activeAddressIsHealthy: activeAddressIsHealthy);
    final currentBranchIndex = widget.navigationShell.currentIndex;
    final destinations = echoMainDestinations(showExploreTab: showExploreTab);
    final currentBranchIsVisible = destinations.any(
      (destination) => destination.branchIndex == currentBranchIndex,
    );

    if (!currentBranchIsVisible) {
      _scheduleHiddenBranchFallback();
    }

    return BackButtonListener(
      onBackButtonPressed: () async {
        await _handleBackPressed();
        return true;
      },
      child: EchoAppShell(
        scaffoldKey: scaffoldKey,
        drawer:
            widget.drawerOverride ??
            AppDrawer(onReturnFocus: _restoreEchoAppDrawerFocus),
        body: widget.navigationShell,
        destinations: destinations,
        selectedBranchIndex: currentBranchIsVisible
            ? currentBranchIndex
            : discoverBranchIndex,
        onDestinationSelected: (branchIndex) {
          _goToBranch(
            branchIndex,
            initialLocation: branchIndex == currentBranchIndex,
          );
        },
        miniPlayer: widget.miniPlayerOverride ?? const MiniPlayer(),
        showMiniPlayer: hasMiniPlayer,
        networkStatus: networkStatus,
        onOpenDrawer: openEchoAppDrawer,
      ),
    );
  }
}
