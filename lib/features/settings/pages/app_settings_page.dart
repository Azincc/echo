import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:echoes/core/theme/app_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/services/update_checker.dart';
import '../../../core/utils/logger.dart';
import '../../../data/models/music_library.dart';
import '../../../data/models/server_address.dart';
import '../../../data/sources/local_storage.dart';
import '../../../providers/api_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/theme_provider.dart';
import '../../../widgets/music_chrome.dart';
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

      final timestamp = DateTime.now()
          .toIso8601String()
          .replaceAll(':', '-')
          .split('.')
          .first;
      await Share.shareXFiles([
        XFile.fromData(
          utf8.encode(logContent),
          mimeType: 'text/plain',
          name: 'echoes_log_$timestamp.txt',
        ),
      ], subject: 'echoes 日志导出 $timestamp');

      Logger.infoWithTag(
        'LOG_EXPORT',
        'exported ${Logger.bufferedLineCount} lines to share payload'
            '${kIsWeb ? " (web)" : ""}',
      );
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
              AppIcons.system_update,
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
                    leading: const Icon(AppIcons.download, size: 20),
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
    final addressPool = ref.watch(addressPoolProvider);
    final autoFallback = ref.watch(autoFallbackProvider);
    final themeSettings = ref.watch(themeSettingsProvider);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: MusicChrome.maxContentWidth,
            ),
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                20,
                0,
                20,
                24 + MediaQuery.of(context).padding.bottom,
              ),
              children: [
                MusicPageHeader(
                  padding: const EdgeInsets.fromLTRB(0, 14, 0, 16),
                  title: '设置',
                  subtitle: '连接、播放、外观与诊断',
                  leading: MusicIconButton(
                    icon: AppIcons.arrow_back_ios_new,
                    tooltip: '返回',
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                _settingsSection(
                  context,
                  title: '服务器信息',
                  action: MusicIconButton(
                    tooltip: '编辑服务器设置',
                    icon: AppIcons.edit_outlined,
                    onPressed: library == null
                        ? null
                        : () {
                            context.push('/library/edit/${library.id}');
                          },
                  ),
                  children: [
                    _buildServerInfo(
                      context,
                      library: library,
                      activeAddress: activeAddress,
                      addresses: addressPool.addresses.isNotEmpty
                          ? addressPool.addresses
                          : library?.addresses ?? const [],
                      autoFallback: autoFallback,
                    ),
                  ],
                ),
                _settingsSection(
                  context,
                  title: '应用设置',
                  children: [
                    _settingsRow(
                      context,
                      icon: AppIcons.route_outlined,
                      title: '线路自动回退',
                      subtitle: '手动选择线路不可用时，自动切换到其他可用线路',
                      trailing: Switch(
                        value: autoFallback,
                        onChanged: (value) async {
                          ref.read(autoFallbackProvider.notifier).state = value;
                          ref.read(addressPoolProvider).autoFallback = value;
                          await LocalStorage.setAutoFallback(value);
                        },
                      ),
                      onTap: () async {
                        final value = !autoFallback;
                        ref.read(autoFallbackProvider.notifier).state = value;
                        ref.read(addressPoolProvider).autoFallback = value;
                        await LocalStorage.setAutoFallback(value);
                      },
                    ),
                    _settingsRow(
                      context,
                      icon: AppIcons.palette_outlined,
                      title: '主题设置',
                      subtitle:
                          '${_themeModeText(themeSettings.mode)} · ${_colorHex(themeSettings.seedColor)}',
                      trailing: _colorPreview(context, themeSettings.seedColor),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ThemeSettingsPage(),
                          ),
                        );
                      },
                    ),
                    _settingsRow(
                      context,
                      icon: AppIcons.high_quality_outlined,
                      title: '音质设置',
                      trailing: const Icon(AppIcons.chevron_right),
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
                        final crossfadeMs = ref.watch(
                          crossfadeDurationMsProvider,
                        );
                        final label = crossfadeMs <= 0
                            ? '关闭'
                            : '${(crossfadeMs / 1000).toStringAsFixed(1)} 秒';
                        return Column(
                          children: [
                            _settingsRow(
                              context,
                              icon: AppIcons.swap_horiz_outlined,
                              title: '切歌淡入淡出',
                              subtitle: label,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(58, 0, 12, 8),
                              child: Row(
                                children: [
                                  Text(
                                    '关闭',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelSmall,
                                  ),
                                  Expanded(
                                    child: Slider(
                                      value: crossfadeMs.toDouble(),
                                      min: 0,
                                      max: 3000,
                                      divisions: 6,
                                      label: label,
                                      onChanged: (value) {
                                        ref
                                            .read(
                                              crossfadeDurationMsProvider
                                                  .notifier,
                                            )
                                            .setDuration(value.round());
                                      },
                                    ),
                                  ),
                                  Text(
                                    '3 秒',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelSmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
                _settingsSection(
                  context,
                  title: '内容来源',
                  children: [
                    _settingsRow(
                      context,
                      icon: AppIcons.lyrics_outlined,
                      title: '歌词提供商',
                      trailing: const Icon(AppIcons.chevron_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LyricsProvidersPage(),
                          ),
                        );
                      },
                    ),
                    _settingsRow(
                      context,
                      icon: AppIcons.image_outlined,
                      title: '封面提供商',
                      trailing: const Icon(AppIcons.chevron_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CoverProvidersPage(),
                          ),
                        );
                      },
                    ),
                    _buildCacheManager(context, ref),
                  ],
                ),
                _settingsSection(
                  context,
                  title: '诊断与更新',
                  children: [
                    _settingsRow(
                      context,
                      icon: AppIcons.description_outlined,
                      title: '导出日志',
                      subtitle: '共缓存 ${Logger.bufferedLineCount} 条日志',
                      trailing: _isExportingLogs
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(AppIcons.chevron_right),
                      onTap: _isExportingLogs ? null : _exportLogs,
                    ),
                    _settingsRow(
                      context,
                      icon: AppIcons.system_update_outlined,
                      title: '检查更新',
                      subtitle: '从 GitHub Releases 检查最新版本',
                      trailing: _isCheckingUpdate
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(AppIcons.chevron_right),
                      onTap: _isCheckingUpdate ? null : _checkForUpdates,
                    ),
                    _settingsRow(
                      context,
                      icon: AppIcons.info_outline,
                      title: '关于',
                      trailing: const Icon(AppIcons.chevron_right),
                      onTap: () => _showAppAboutDialog(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCacheManager(BuildContext context, WidgetRef ref) {
    return _settingsRow(
      context,
      icon: AppIcons.storage_outlined,
      title: '缓存管理',
      subtitle: '音频、图片、歌词缓存',
      trailing: const Icon(AppIcons.chevron_right),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CacheManagementPage()),
        );
      },
    );
  }

  Widget _buildServerInfo(
    BuildContext context, {
    required MusicLibrary? library,
    required ServerAddress? activeAddress,
    required List<ServerAddress> addresses,
    required bool autoFallback,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final statusColor = _serverStatusColor(context, activeAddress?.status);
    final statusText = _serverStatusText(activeAddress);
    final totalCount = addresses.length;
    final okCount = addresses
        .where((address) => address.status == ServerAddressStatus.ok)
        .length;
    final isManual = activeAddress?.isLocked == true;
    final latencyText = activeAddress?.lastLatencyMs == null
        ? '未测速'
        : '${activeAddress!.lastLatencyMs} ms';

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: statusColor.withValues(
                    alpha: theme.brightness == Brightness.dark ? 0.18 : 0.11,
                  ),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  _serverStatusIcon(activeAddress?.status),
                  color: statusColor,
                  size: 23,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      library?.name ?? '未连接音乐库',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      activeAddress == null
                          ? '没有可用的服务器线路'
                          : '${activeAddress.label} · $latencyText',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              _serverStatusChip(context, statusText, statusColor),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _serverMetric(context, '线路', '$okCount/$totalCount 可用'),
              _serverMetric(context, '模式', isManual ? '手动锁定' : '自动选择'),
              _serverMetric(context, '回退', autoFallback ? '已开启' : '已关闭'),
            ],
          ),
          const SizedBox(height: 12),
          Divider(color: MusicChrome.hairline(context), height: 1),
          const SizedBox(height: 8),
          _serverInfoRow(
            context,
            '当前线路',
            activeAddress?.label ?? '未连接',
            icon: AppIcons.route_outlined,
          ),
          _serverInfoRow(
            context,
            '服务器地址',
            activeAddress?.url ?? '未设置',
            icon: AppIcons.router,
          ),
          _serverInfoRow(
            context,
            '服务端',
            _serverVersionText(library),
            icon: AppIcons.cloud_outlined,
          ),
          _serverInfoRow(
            context,
            '用户名',
            library?.username?.isNotEmpty == true ? library!.username! : '未设置',
            icon: AppIcons.person_outline,
          ),
          _serverInfoRow(
            context,
            '认证方式',
            _authTypeText(library),
            icon: AppIcons.key,
          ),
        ],
      ),
    );
  }

  Widget _serverStatusChip(BuildContext context, String text, Color color) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(
          alpha: theme.brightness == Brightness.dark ? 0.18 : 0.11,
        ),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: theme.textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _serverMetric(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(
          alpha: theme.brightness == Brightness.dark ? 0.36 : 0.56,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            value,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _serverInfoRow(
    BuildContext context,
    String label,
    String value, {
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 17, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: 9),
          SizedBox(
            width: 72,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              softWrap: true,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                height: 1.28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingsSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
    Widget? action,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(2, 0, 2, 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                if (action != null) action,
              ],
            ),
          ),
          MusicGlassSurface(
            borderRadius: BorderRadius.circular(18),
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _settingsRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return MusicGlassTile(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      title: title,
      subtitle: subtitle,
      onTap: onTap,
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: colorScheme.primary.withValues(
            alpha: theme.brightness == Brightness.dark ? 0.18 : 0.1,
          ),
          borderRadius: BorderRadius.circular(11),
          border: Border.all(
            color: colorScheme.primary.withValues(alpha: 0.14),
            width: 0.7,
          ),
        ),
        child: Icon(icon, color: colorScheme.primary, size: 21),
      ),
      trailing: trailing,
    );
  }

  Widget _colorPreview(BuildContext context, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
        ),
        const SizedBox(width: 8),
        const Icon(AppIcons.chevron_right),
      ],
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

  Color _serverStatusColor(BuildContext context, ServerAddressStatus? status) {
    switch (status) {
      case ServerAddressStatus.ok:
        return Colors.greenAccent.shade400;
      case ServerAddressStatus.failed:
        return Theme.of(context).colorScheme.error;
      case ServerAddressStatus.unknown:
      case null:
        return Theme.of(context).colorScheme.outline;
    }
  }

  IconData _serverStatusIcon(ServerAddressStatus? status) {
    switch (status) {
      case ServerAddressStatus.ok:
        return AppIcons.check_circle;
      case ServerAddressStatus.failed:
        return AppIcons.cloud_off_rounded;
      case ServerAddressStatus.unknown:
      case null:
        return AppIcons.network_check_outlined;
    }
  }

  String _serverStatusText(ServerAddress? address) {
    switch (address?.status) {
      case ServerAddressStatus.ok:
        return '在线';
      case ServerAddressStatus.failed:
        return '异常';
      case ServerAddressStatus.unknown:
        return '检测中';
      case null:
        return '未连接';
    }
  }

  String _serverVersionText(MusicLibrary? library) {
    if (library == null) return '未设置';

    final parts = <String>[];
    final serverType = library.serverType?.trim();
    final serverVersion = library.serverVersion?.trim();
    if (serverType != null && serverType.isNotEmpty) {
      parts.add(serverType);
    }
    if (serverVersion != null && serverVersion.isNotEmpty) {
      parts.add(serverVersion);
    }
    if (library.isOpenSubsonic) {
      parts.add('OpenSubsonic');
    }

    return parts.isEmpty ? 'Subsonic API' : parts.join(' · ');
  }

  String _authTypeText(MusicLibrary? library) {
    switch (library?.authType) {
      case MusicLibraryAuthType.apiKey:
        return 'API Key';
      case MusicLibraryAuthType.token:
        return '密码 / Token';
      case null:
        return '未设置';
    }
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
