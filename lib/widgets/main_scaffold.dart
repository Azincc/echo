import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/design/echo_design.dart';
import '../core/utils/logger.dart';
import '../features/player/widgets/mini_player.dart';
import '../providers/navigation_provider.dart';
import '../providers/offline_download_provider.dart';
import '../providers/player_provider.dart';
import 'app_drawer.dart';
import 'echo_app_shell/echo_app_shell.dart';
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
  });

  @visibleForTesting
  final Widget? drawerOverride;

  @visibleForTesting
  final Widget? miniPlayerOverride;

  @visibleForTesting
  final bool? showMiniPlayerOverride;

  @visibleForTesting
  final bool? showExploreTabOverride;

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

  @override
  void initState() {
    super.initState();
    _scheduleVisibleBranchSync();
  }

  @override
  void didUpdateWidget(covariant MainScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    _scheduleVisibleBranchSync();
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
        onOpenDrawer: openEchoAppDrawer,
      ),
    );
  }
}
