import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/services/update_checker.dart';
import '../../../core/utils/logger.dart';
import '../../../data/models/music_library.dart';
import '../../../data/sources/local_storage.dart';
import '../../../providers/api_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/theme_provider.dart';
import 'audio_quality_page.dart';
import 'cache_management_page.dart';
import 'cover_providers_page.dart';
import 'lyrics_providers_page.dart';
import 'theme_settings_page.dart';
import '../../../providers/crossfade_provider.dart';

/// 全屏设置页
class AppSettingsPage extends ConsumerStatefulWidget {
  const AppSettingsPage({super.key});

  @override
  ConsumerState<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends ConsumerState<AppSettingsPage> {
  bool _isExportingLogs = false;
  bool _isCheckingUpdate = false;

  // ---------------------------------------------------------------------------
  // Log export
  // ---------------------------------------------------------------------------

  Future<void> _exportLogs() async {
    setState(() => _isExportingLogs = true);

    try {
      final logContent = Logger.exportLogs();
      if (logContent.isEmpty) {
        _showSnackBar('暂无日志可导出');
        return;
      }

      final dir = await getTemporaryDirectory();
      final timestamp = DateTime.now()
          .toIso8601String()
          .replaceAll(':', '-')
          .split('.')
          .first;
      final file = File('${dir.path}/echoes_log_$timestamp.txt');
      await file.writeAsString(logContent);

      Logger.infoWithTag(
        'LOG_EXPORT',
        'exported ${Logger.bufferedLineCount} lines to ${file.path}',
      );

      await Share.shareXFiles([
        XFile(file.path),
      ], subject: 'echoes 日志导出 $timestamp');
    } catch (e) {
      Logger.errorWithTag('LOG_EXPORT', 'export failed', e);
      _showSnackBar('日志导出失败: $e');
    } finally {
      if (mounted) setState(() => _isExportingLogs = false);
    }
  }

  // ---------------------------------------------------------------------------
  // Update check
  // ---------------------------------------------------------------------------

  Future<void> _checkForUpdates() async {
    setState(() => _isCheckingUpdate = true);

    try {
      final result = await UpdateChecker.check();
      if (!mounted) return;

      if (result.hasUpdate) {
        _showUpdateDialog(result);
      } else {
        _showSnackBar('当前已是最新版本 (${result.currentVersion})');
      }
    } catch (e) {
      _showSnackBar('检查更新失败: $e');
    } finally {
      if (mounted) setState(() => _isCheckingUpdate = false);
    }
  }

  void _showUpdateDialog(UpdateCheckResult result) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.system_update,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            const Expanded(child: Text('发现新版本')),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _updateInfoRow('当前版本', result.currentVersion),
              _updateInfoRow('最新版本', result.latestVersion),
              if (result.releaseNotes != null &&
                  result.releaseNotes!.isNotEmpty) ...[
                const Divider(height: 16),
                Text(
                  '更新说明',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  result.releaseNotes!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
              if (result.assets.isNotEmpty) ...[
                const Divider(height: 16),
                Text(
                  '下载文件',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                ...result.assets.map((asset) {
                  final sizeMb = (asset.size / (1024 * 1024)).toStringAsFixed(
                    1,
                  );
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    leading: const Icon(Icons.download, size: 20),
                    title: Text(
                      asset.name,
                      style: const TextStyle(fontSize: 13),
                    ),
                    subtitle: Text('$sizeMb MB'),
                    onTap: () => _openUrl(asset.downloadUrl),
                  );
                }),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('稍后再说'),
          ),
          if (result.releaseUrl != null)
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                _openUrl(result.releaseUrl!);
              },
              child: const Text('前往下载'),
            ),
        ],
      ),
    );
  }

  Widget _updateInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 72,
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final library = authState.currentLibrary;
    final activeAddress = ref.watch(activeAddressProvider);
    final autoFallback = ref.watch(autoFallbackProvider);
    final themeSettings = ref.watch(themeSettingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('设置')),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          16 + MediaQuery.of(context).padding.bottom,
        ),
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
          Consumer(
            builder: (context, ref, _) {
              final crossfadeMs = ref.watch(crossfadeDurationMsProvider);
              final label = crossfadeMs <= 0
                  ? '关闭'
                  : '${(crossfadeMs / 1000).toStringAsFixed(1)} 秒';
              return Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.swap_horiz_outlined),
                    title: const Text('切歌淡入淡出'),
                    subtitle: Text(label, style: const TextStyle(fontSize: 12)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const Text('关闭', style: TextStyle(fontSize: 12)),
                        Expanded(
                          child: Slider(
                            value: crossfadeMs.toDouble(),
                            min: 0,
                            max: 3000,
                            divisions: 6,
                            label: label,
                            onChanged: (value) {
                              ref
                                  .read(crossfadeDurationMsProvider.notifier)
                                  .setDuration(value.round());
                            },
                          ),
                        ),
                        const Text('3 秒', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ],
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
          const Divider(height: 24),
          _buildCacheManager(context, ref),
          const Divider(height: 24),
          Text(
            '诊断与更新',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.description_outlined),
            title: const Text('导出日志'),
            subtitle: Text(
              '共缓存 ${Logger.bufferedLineCount} 条日志',
              style: const TextStyle(fontSize: 12),
            ),
            trailing: _isExportingLogs
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.chevron_right),
            onTap: _isExportingLogs ? null : _exportLogs,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.system_update_outlined),
            title: const Text('检查更新'),
            subtitle: const Text(
              '从 GitHub Releases 检查最新版本',
              style: TextStyle(fontSize: 12),
            ),
            trailing: _isCheckingUpdate
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.chevron_right),
            onTap: _isCheckingUpdate ? null : _checkForUpdates,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.info_outline),
            title: const Text('关于'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showAppAboutDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCacheManager(BuildContext context, WidgetRef ref) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.storage_outlined),
      title: const Text('缓存管理'),
      subtitle: const Text('音频、图片、歌词缓存'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CacheManagementPage()),
        );
      },
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
      applicationName: 'echoes',
      applicationIcon: const FlutterLogo(size: 40),
      applicationLegalese: '© 2026 echoes',
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
