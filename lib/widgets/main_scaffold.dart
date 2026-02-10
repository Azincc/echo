import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/discover/pages/discover_page.dart';
import '../features/library/pages/library_page.dart';
import '../features/player/widgets/mini_player.dart';

/// 导航状态 Provider
final navigationProvider = StateProvider<int>((ref) => 0);

/// 主骨架 - 包含底部导航和内容区域
class MainScaffold extends ConsumerWidget {
  const MainScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          // Tab 1: 音乐流
          DiscoverPage(),
          // Tab 2: 我的
          LibraryPage(),
        ],
      ),
      // 迷你播放器
      bottomSheet: const MiniPlayer(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          ref.read(navigationProvider.notifier).state = index;
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
    );
  }
}
