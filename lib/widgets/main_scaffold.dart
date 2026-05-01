import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/utils/logger.dart';
import '../features/player/widgets/mini_player.dart';
import '../providers/navigation_provider.dart';
import '../providers/offline_download_provider.dart';
import '../providers/player_provider.dart';
import 'app_drawer.dart';

// GlobalKey used to access Scaffold state (e.g. opening drawer).
final scaffoldKey = GlobalKey<ScaffoldState>();

class MainScaffold extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;
  final List<GlobalKey<NavigatorState>> branchNavigatorKeys;

  const MainScaffold({
    super.key,
    required this.navigationShell,
    required this.branchNavigatorKeys,
  });

  @override
  ConsumerState<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends ConsumerState<MainScaffold> {
  static const double _miniPlayerHeight = 72;
  static const _logTag = 'BACK';
  static const MethodChannel _appLifecycleChannel = MethodChannel(
    'com.az1n.echoes/app_lifecycle',
  );
  int? _lastSyncedBranchIndex;

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
      ref.read(currentVisibleBranchIndexProvider.notifier).state = currentIndex;
    });
  }

  Future<void> _handleBackPressed() async {
    final index = widget.navigationShell.currentIndex;
    final branchCount = widget.branchNavigatorKeys.length;
    Logger.infoWithTag(
      _logTag,
      'back pressed, branchIndex=$index, branchCount=$branchCount',
    );

    // 1. If the drawer is open, close it first.
    final scaffold = scaffoldKey.currentState;
    if (scaffold != null && scaffold.isDrawerOpen) {
      Logger.infoWithTag(_logTag, 'drawer is open, closing drawer');
      scaffold.closeDrawer();
      return;
    }

    // 2. Check if the root navigator can pop (e.g. settings page pushed via
    //    Navigator.push on top of MainScaffold).
    final rootNavigator = Navigator.of(context);
    if (rootNavigator.canPop()) {
      Logger.infoWithTag(_logTag, 'root navigator can pop, popping');
      rootNavigator.pop();
      return;
    }

    // 3. Check if the current branch navigator can pop.
    if (index >= 0 && index < branchCount) {
      final navigatorKey = widget.branchNavigatorKeys[index];
      final navigator = navigatorKey.currentState;
      Logger.infoWithTag(
        _logTag,
        'navigator for branch $index: '
        'key=$navigatorKey, '
        'state=${navigator != null ? "present" : "null"}, '
        'canPop=${navigator?.canPop()}',
      );
      if (navigator != null && navigator.canPop()) {
        Logger.infoWithTag(_logTag, 'branch $index can pop, popping');
        navigator.pop();
        return;
      }
    } else {
      Logger.warnWithTag(
        _logTag,
        'index $index out of range [0, $branchCount)',
      );
    }

    // 4. Only move to background when on the home tab (index 0).
    //    On other tabs, switch back to the home tab instead.
    if (index == 0) {
      Logger.infoWithTag(
        _logTag,
        'home branch root reached (index=0), move app to background',
      );
      await _moveAppToBackground();
    } else {
      Logger.infoWithTag(
        _logTag,
        'non-home branch root reached (index=$index), switching to home tab',
      );
      widget.navigationShell.goBranch(0);
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
    final hasMiniPlayer = ref.watch(
      playerProvider.select((state) => state.currentSong != null),
    );
    final showExploreTab = ref.watch(
      activeEmbedServiceConfigProvider.select((config) {
        return config.isEnabledAndConfigured;
      }),
    );
    final currentBranchIndex = widget.navigationShell.currentIndex;
    final visibleBranchIndices = <int>[
      discoverBranchIndex,
      if (showExploreTab) exploreBranchIndex,
      libraryBranchIndex,
    ];
    final selectedIndex = visibleBranchIndices.indexOf(currentBranchIndex);

    if (selectedIndex == -1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        widget.navigationShell.goBranch(discoverBranchIndex);
      });
    }

    return BackButtonListener(
      onBackButtonPressed: () async {
        await _handleBackPressed();
        return true;
      },
      child: Scaffold(
        key: scaffoldKey,
        drawer: const AppDrawer(),
        body: AnimatedPadding(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(
            bottom: hasMiniPlayer ? _miniPlayerHeight : 0,
          ),
          child: widget.navigationShell,
        ),
        bottomSheet: const MiniPlayer(),
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex == -1 ? 0 : selectedIndex,
          onDestinationSelected: (index) {
            final branchIndex = visibleBranchIndices[index];
            widget.navigationShell.goBranch(
              branchIndex,
              initialLocation: branchIndex == currentBranchIndex,
            );
          },
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.explore_outlined),
              selectedIcon: Icon(Icons.explore),
              label: '音乐流',
            ),
            if (showExploreTab)
              const NavigationDestination(
                icon: Icon(Icons.travel_explore_outlined),
                selectedIcon: Icon(Icons.travel_explore),
                label: '探索',
              ),
            const NavigationDestination(
              icon: Icon(Icons.library_music_outlined),
              selectedIcon: Icon(Icons.library_music),
              label: '我的',
            ),
          ],
        ),
      ),
    );
  }
}
