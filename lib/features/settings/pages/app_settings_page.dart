import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/music_library.dart';
import '../../../data/sources/local_storage.dart';
import '../../../providers/api_provider.dart';
import '../../../providers/audio_cache_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/theme_provider.dart';
import 'audio_quality_page.dart';
import 'cover_providers_page.dart';
import 'lyrics_providers_page.dart';
import 'theme_settings_page.dart';

/// 全屏设置页
class AppSettingsPage extends ConsumerWidget {
  const AppSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final library = authState.currentLibrary;
    final activeAddress = ref.watch(activeAddressProvider);
    final autoFallback = ref.watch(autoFallbackProvider);
    final themeSettings = ref.watch(themeSettingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('设置')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '服务器信息',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildInfoRow('当前连接', activeAddress?.label ?? '未连接'),
          _buildInfoRow('服务器地址', activeAddress?.url ?? '未设置'),
          _buildInfoRow('用户名', library?.username ?? '未设置'),
          _buildInfoRow(
            '认证方式',
            library?.authType == MusicLibraryAuthType.apiKey ? 'API Key' : '密码',
          ),
          const Divider(height: 24),
          Text(
            '应用设置',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('线路自动回退'),
            subtitle: const Text(
              '手动选择线路后，若该线路不可用，自动切换到其他可用线路',
              style: TextStyle(fontSize: 12),
            ),
            value: autoFallback,
            onChanged: (value) async {
              ref.read(autoFallbackProvider.notifier).state = value;
              ref.read(addressPoolProvider).autoFallback = value;
              await LocalStorage.setAutoFallback(value);
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.palette_outlined),
            title: const Text('主题设置'),
            subtitle: Text(
              '${_themeModeText(themeSettings.mode)} · ${_colorHex(themeSettings.seedColor)}',
              style: const TextStyle(fontSize: 12),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ThemeSettingsPage(),
                ),
              );
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.high_quality_outlined),
            title: const Text('音质设置'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AudioQualityPage(),
                ),
              );
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.lyrics_outlined),
            title: const Text('歌词提供商'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LyricsProvidersPage(),
                ),
              );
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.image_outlined),
            title: const Text('封面提供商'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CoverProvidersPage(),
                ),
              );
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.info_outline),
            title: const Text('关于'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showAppAboutDialog(context),
          ),
          const Divider(height: 24),
          Text(
            '缓存管理',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildCacheManager(context, ref),
        ],
      ),
    );
  }

  Widget _buildCacheManager(BuildContext context, WidgetRef ref) {
    final sizeAsync = ref.watch(cacheSizeProvider);
    return sizeAsync.when(
      data: (size) {
        final mb = size / (1024 * 1024);
        final gb = mb / 1024;
        final sizeStr = gb >= 1
            ? '${gb.toStringAsFixed(2)} GB'
            : '${mb.toStringAsFixed(1)} MB';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('当前占用', sizeStr),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('清除缓存'),
                      content: const Text('确定要清除所有音频缓存吗？'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('取消'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('清除'),
                        ),
                      ],
                    ),
                  );

                  if (confirmed == true) {
                    await ref.read(audioCacheServiceProvider).clearAll();
                    ref.invalidate(cacheSizeProvider);
                    if (context.mounted) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(const SnackBar(content: Text('缓存已清除')));
                    }
                  }
                },
                icon: const Icon(Icons.delete_outline),
                label: const Text('清除缓存'),
              ),
            ),
          ],
        );
      },
      loading: () => const Text('正在计算缓存大小...'),
      error: (error, stackTrace) => const Text('无法获取缓存大小'),
    );
  }

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

  void _showAppAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Echoes 回响',
      applicationIcon: const FlutterLogo(size: 40),
      applicationLegalese: '© 2026 Echoes 回响',
      children: const [SizedBox(height: 12), Text('基于 Subsonic API 的音乐客户端。')],
    );
  }

  String _themeModeText(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return '跟随系统';
      case ThemeMode.light:
        return '白色';
      case ThemeMode.dark:
        return '黑色';
    }
  }

  String _colorHex(Color color) {
    final value = color
        .toARGB32()
        .toRadixString(16)
        .padLeft(8, '0')
        .toUpperCase();
    return '#${value.substring(2)}';
  }
}
