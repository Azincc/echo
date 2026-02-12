import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:echo/data/models/music_library.dart';
import '../providers/auth_provider.dart';
import '../providers/player_provider.dart';
import '../providers/playlist_provider.dart';
import '../providers/music_provider.dart';

/// 应用侧栏
class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final library = authState.currentLibrary;
    // Helper to get URL: try active address, or first address, or empty
    final serverUrl = library?.addresses.firstOrNull?.url ?? '';

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // 用户信息头部
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primaryContainer,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              child: Icon(
                Icons.person,
                size: 40,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            accountName: Text(
              library?.username ?? 'Guest',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            accountEmail: Text(serverUrl, style: const TextStyle(fontSize: 12)),
          ),

          // 音乐流
          ListTile(
            leading: const Icon(Icons.explore),
            title: const Text('音乐流'),
            onTap: () {
              Navigator.pop(context);
              context.go('/home');
            },
          ),

          // 我的音乐库
          ListTile(
            leading: const Icon(Icons.library_music),
            title: const Text('我的音乐库'),
            onTap: () {
              Navigator.pop(context);
              context.go('/library');
            },
          ),

          const Divider(),

          // 统计信息
          ListTile(
            leading: const Icon(Icons.analytics_outlined),
            title: const Text('统计信息'),
            onTap: () {
              Navigator.pop(context);
              _showComingSoonDialog(context, '统计信息');
            },
          ),

          // 下载管理
          ListTile(
            leading: const Icon(Icons.download_outlined),
            title: const Text('下载管理'),
            onTap: () {
              Navigator.pop(context);
              _showComingSoonDialog(context, '下载管理');
            },
          ),

          const Divider(),

          // 设置
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('设置'),
            onTap: () {
              Navigator.pop(context);
              _showSettingsDialog(context, ref);
            },
          ),

          // 关于
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('关于'),
            onTap: () {
              Navigator.pop(context);
              _showAboutDialog(context);
            },
          ),

          const Divider(),

          // 登出
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.error,
            ),
            title: Text(
              '登出',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            onTap: () {
              Navigator.pop(context);
              _showLogoutDialog(context, ref);
            },
          ),
        ],
      ),
    );
  }

  /// 显示"即将推出"对话框
  void _showComingSoonDialog(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(feature),
        content: const Text('该功能即将推出，敬请期待！'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  /// 显示设置对话框
  void _showSettingsDialog(BuildContext context, WidgetRef ref) {
    final authState = ref.read(authStateProvider);
    final library = authState.currentLibrary;
    final serverUrl = library?.addresses.firstOrNull?.url ?? '未设置';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('设置'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 服务器信息
              Text(
                '服务器信息',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildInfoRow('服务器地址', serverUrl),
              _buildInfoRow('用户名', library?.username ?? '未设置'),
              _buildInfoRow(
                '认证方式',
                library?.authType == MusicLibraryAuthType.apiKey
                    ? 'API Key'
                    : '密码',
              ),
              const Divider(height: 24),

              // 应用设置
              Text(
                '应用设置',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('音质设置、缓存设置等功能即将推出'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  /// 显示关于对话框
  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Echo',
      applicationVersion: '1.0.0',
      applicationIcon: const FlutterLogo(size: 48),
      applicationLegalese: '© 2026 Echo Music Player',
      children: [
        const SizedBox(height: 16),
        const Text(
          'Echo 是一个基于 Subsonic API 的音乐播放器，'
          '支持 Navidrome、Airsonic 等服务器。',
        ),
        const SizedBox(height: 16),
        const Text('功能特性：'),
        const Text('• 支持多种音频格式（APE/M4A/FLAC 等）'),
        const Text('• 自动转码不支持的格式'),
        const Text('• 后台播放和通知栏控制'),
        const Text('• 收藏和播放列表管理'),
      ],
    );
  }

  /// 显示登出确认对话框
  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认登出'),
        content: const Text('确定要退出登录吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);

              // 清除所有 Provider 状态
              ref.invalidate(playerProvider);
              ref.invalidate(playlistsProvider);
              ref.invalidate(starredProvider);
              ref.invalidate(randomSongsProvider);
              ref.invalidate(recentAlbumsProvider);
              ref.invalidate(frequentAlbumsProvider);

              // 执行登出
              await ref.read(authStateProvider.notifier).logout();

              // 跳转到登录页
              if (context.mounted) {
                context.go('/login');
              }
            },
            child: Text(
              '登出',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建信息行
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}
