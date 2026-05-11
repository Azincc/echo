import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:echoes/core/theme/app_icons.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/utils/logger.dart';
import '../features/player/widgets/mini_player.dart';
import '../providers/navigation_provider.dart';
import '../providers/offline_download_provider.dart';
import '../providers/player_provider.dart';
import 'app_drawer.dart';
import 'music_chrome.dart';

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
        bottomNavigationBar: _buildNavigationBar(
          context: context,
          selectedIndex: selectedIndex == -1 ? 0 : selectedIndex,
          visibleBranchIndices: visibleBranchIndices,
          currentBranchIndex: currentBranchIndex,
          showExploreTab: showExploreTab,
        ),
      ),
    );
  }

  Widget _buildNavigationBar({
    required BuildContext context,
    required int selectedIndex,
    required List<int> visibleBranchIndices,
    required int currentBranchIndex,
    required bool showExploreTab,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final destinations = <_GlassTabDestination>[
      const _GlassTabDestination(
        icon: AppIcons.play_circle_outline,
        selectedIcon: AppIcons.play_circle,
        label: '音乐流',
      ),
      if (showExploreTab)
        const _GlassTabDestination(
          icon: AppIcons.search_outlined,
          selectedIcon: AppIcons.search,
          label: '探索',
        ),
      const _GlassTabDestination(
        icon: AppIcons.library_music_outlined,
        selectedIcon: AppIcons.library_music,
        label: '资料库',
      ),
    ];

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withValues(
              alpha: isDark ? 0.74 : 0.82,
            ),
            border: Border(
              top: BorderSide(color: MusicChrome.hairline(context), width: 0.7),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 6, 10, 7),
              child: SizedBox(
                height: 58,
                child: Row(
                  children: [
                    for (var i = 0; i < destinations.length; i++)
                      Expanded(
                        child: _GlassTabItem(
                          destination: destinations[i],
                          selected: i == selectedIndex,
                          onTap: () {
                            final branchIndex = visibleBranchIndices[i];
                            widget.navigationShell.goBranch(
                              branchIndex,
                              initialLocation:
                                  branchIndex == currentBranchIndex,
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassTabDestination {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const _GlassTabDestination({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });
}

class _GlassTabItem extends StatelessWidget {
  final _GlassTabDestination destination;
  final bool selected;
  final VoidCallback onTap;

  const _GlassTabItem({
    required this.destination,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final selectedColor = colorScheme.primary;
    final inactiveColor = colorScheme.onSurfaceVariant.withValues(alpha: 0.82);
    final foregroundColor = selected ? selectedColor : inactiveColor;

    return Semantics(
      button: true,
      selected: selected,
      label: destination.label,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: selected
                    ? selectedColor.withValues(
                        alpha: theme.brightness == Brightness.dark
                            ? 0.13
                            : 0.08,
                      )
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOutCubic,
                    width: selected ? 24 : 8,
                    height: 3,
                    margin: const EdgeInsets.only(bottom: 6),
                    decoration: BoxDecoration(
                      color: selected ? selectedColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  Icon(
                    selected ? destination.selectedIcon : destination.icon,
                    size: 23,
                    color: foregroundColor,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    destination.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: foregroundColor,
                      fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
