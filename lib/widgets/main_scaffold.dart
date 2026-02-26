import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/utils/logger.dart';
import '../features/player/widgets/mini_player.dart';
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
    'cc.azin.echoes/app_lifecycle',
  );

  Future<void> _handleBackPressed() async {
    final index = widget.navigationShell.currentIndex;
    Logger.infoWithTag(_logTag, 'back pressed, branchIndex=$index');
    if (index >= 0 && index < widget.branchNavigatorKeys.length) {
      final navigator = widget.branchNavigatorKeys[index].currentState;
      if (navigator != null && navigator.canPop()) {
        Logger.infoWithTag(_logTag, 'branch can pop, pop current route');
        navigator.pop();
        return;
      }
    }

    Logger.infoWithTag(_logTag, 'branch root reached, move app to background');
    await _moveAppToBackground();
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
    final hasMiniPlayer = ref.watch(
      playerProvider.select((state) => state.currentSong != null),
    );

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
          selectedIndex: widget.navigationShell.currentIndex,
          onDestinationSelected: (index) {
            widget.navigationShell.goBranch(
              index,
              initialLocation: index == widget.navigationShell.currentIndex,
            );
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.explore_outlined),
              selectedIcon: Icon(Icons.explore),
              label: '音乐流',
            ),
            NavigationDestination(
              icon: Icon(Icons.travel_explore_outlined),
              selectedIcon: Icon(Icons.travel_explore),
              label: '探索',
            ),
            NavigationDestination(
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
