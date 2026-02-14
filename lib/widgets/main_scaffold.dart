import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/player/widgets/mini_player.dart';
import 'app_drawer.dart';

// GlobalKey 用于访问 Scaffold 状态（打开侧栏）
final scaffoldKey = GlobalKey<ScaffoldState>();

/// 主骨架 - 包含底部导航和内容区域
class MainScaffold extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffold({super.key, required this.navigationShell});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  DateTime? _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // 如果当前不是在第一个 Tab (首页)，则跳转到首页
        if (widget.navigationShell.currentIndex != 0) {
          widget.navigationShell.goBranch(
            0,
            initialLocation: true,
          );
          return false;
        }

        // 如果在首页，检测两次点击间隔
        final now = DateTime.now();
        if (_lastPressedAt == null ||
            now.difference(_lastPressedAt!) > const Duration(seconds: 2)) {
          _lastPressedAt = now;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('再按一次退出应用'),
              duration: Duration(seconds: 2),
            ),
          );
          return false;
        }
        return true;
      },
      child: Scaffold(
        key: scaffoldKey,
        // 侧栏
        drawer: const AppDrawer(),
        body: widget.navigationShell,
        // 迷你播放器
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
