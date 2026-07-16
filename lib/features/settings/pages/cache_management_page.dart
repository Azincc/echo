import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/echo_design.dart';
import '../../../core/utils/toast_notifier.dart';
import '../../../providers/audio_cache_provider.dart';
import '../../../providers/download_provider.dart';
import '../../download/pages/download_manager_page.dart';
import '../widgets/echo_settings_components.dart';

class CacheManagementPage extends StatelessWidget {
  const CacheManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EchoScaffold(
      topBar: EchoTopBar.back(context: context, title: '缓存管理'),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 920),
          child: ListView(
            padding: EdgeInsets.fromLTRB(
              context.echoSpacing.md,
              context.echoSpacing.lg,
              context.echoSpacing.md,
              context.echoSpacing.xxl + context.echoShellBottomObstruction,
            ),
            children: <Widget>[
              const _AudioCacheSection(),
              SizedBox(height: context.echoSpacing.xl),
              const _SupportingCacheSection(),
              SizedBox(height: context.echoSpacing.xl),
              const _DownloadDirectorySection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AudioCacheSection extends ConsumerWidget {
  const _AudioCacheSection();

  static const _limits = <(String, int)>[
    ('512 MB', 512 * 1024 * 1024),
    ('1 GB', 1 * 1024 * 1024 * 1024),
    ('2 GB', 2 * 1024 * 1024 * 1024),
    ('4 GB', 4 * 1024 * 1024 * 1024),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sizeAsync = ref.watch(audioCacheSizeProvider);
    final maxCacheSize = ref.watch(maxCacheSizeProvider);

    return EchoSettingsSection(
      title: '音频缓存',
      description: '临时保存播放过的音频，减少重复加载；不会影响明确下载的歌曲。',
      children: <Widget>[
        EchoSurface(
          level: EchoSurfaceLevel.raised,
          borderColor: context.echoColors.controlBoundary,
          padding: EdgeInsets.all(context.echoSpacing.md),
          child: sizeAsync.when(
            data: (size) {
              final progress = maxCacheSize <= 0
                  ? 0.0
                  : (size / maxCacheSize).clamp(0.0, 1.0);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox.square(
                        dimension: context.echoInteraction.minimumTouchTarget,
                        child: Center(
                          child: Icon(
                            AppIcons.music,
                            color: context.echoColors.accent,
                          ),
                        ),
                      ),
                      SizedBox(width: context.echoSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _formatBytes(size),
                              style: context.echoTypography.headline.copyWith(
                                fontFeatures: const <FontFeature>[
                                  FontFeature.tabularFigures(),
                                ],
                              ),
                            ),
                            SizedBox(height: context.echoSpacing.xxs),
                            Text(
                              '上限 ${_formatBytes(maxCacheSize)}',
                              style: context.echoTypography.body.copyWith(
                                color: context.echoColors.muted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.echoSpacing.md),
                  EchoProgressBar(
                    value: progress,
                    height: 6,
                    semanticLabel: '音频缓存占用',
                  ),
                ],
              );
            },
            loading: () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const EchoSkeleton.line(width: 180, height: 28),
                SizedBox(height: context.echoSpacing.sm),
                const EchoSkeleton.line(width: 120),
                SizedBox(height: context.echoSpacing.md),
                const EchoSkeleton(height: 6),
              ],
            ),
            error: (error, stackTrace) => Row(
              children: <Widget>[
                Icon(AppIcons.error, color: context.echoColors.error),
                SizedBox(width: context.echoSpacing.sm),
                Expanded(
                  child: Text('无法计算音频缓存大小', style: context.echoTypography.body),
                ),
                EchoButton.ghost(
                  label: '重试',
                  onPressed: () => ref.invalidate(audioCacheSizeProvider),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: context.echoSpacing.md),
        EchoSectionHeader(title: '缓存上限', description: '达到上限后会优先清理较少使用的临时音频。'),
        SizedBox(height: context.echoSpacing.xs),
        for (final limit in _limits)
          EchoChoiceRow(
            title: limit.$1,
            description: limit.$2 == maxCacheSize ? '当前上限' : null,
            selected: limit.$2 == maxCacheSize,
            icon: AppIcons.storage,
            onPressed: () {
              ref.read(maxCacheSizeProvider.notifier).set(limit.$2);
            },
          ),
        EchoSettingRow(
          icon: AppIcons.delete,
          title: '清除音频缓存',
          description: '移除临时音频，不会删除已经下载的歌曲。',
          destructive: true,
          trailing: Icon(
            AppIcons.delete,
            size: 20,
            color: context.echoColors.error,
          ),
          onPressed: () => _confirmClear(
            context: context,
            title: '清除音频缓存',
            message: '确定要清除所有音频缓存吗？这不会影响已下载的歌曲。',
            onConfirm: () async {
              await ref.read(audioCacheServiceProvider).clearAllAudioCache();
              ref.invalidate(audioCacheSizeProvider);
            },
          ),
        ),
      ],
    );
  }
}

class _SupportingCacheSection extends StatelessWidget {
  const _SupportingCacheSection();

  @override
  Widget build(BuildContext context) {
    return const EchoSettingsSection(
      title: '图片、资源与歌词',
      description: '这些内容会在需要时重新加载，清理不会影响音乐库数据。',
      children: <Widget>[_ImageCacheRows(), _LyricsCacheRows()],
    );
  }
}

class _ImageCacheRows extends ConsumerWidget {
  const _ImageCacheRows();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sizeAsync = ref.watch(imageCacheSizeProvider);
    final value = sizeAsync.when(
      data: _formatBytes,
      loading: () => '正在计算…',
      error: (error, stackTrace) => '获取失败',
    );

    return Column(
      children: <Widget>[
        EchoSettingRow(
          icon: AppIcons.image,
          title: '图片与资源缓存',
          value: value,
          semanticLabel: sizeAsync.hasError ? '图片与资源缓存，获取失败，点击重试' : null,
          onPressed: sizeAsync.hasError
              ? () => ref.invalidate(imageCacheSizeProvider)
              : null,
          trailing: sizeAsync.isLoading
              ? const SizedBox(width: 96, child: EchoSkeleton.line())
              : sizeAsync.hasError
              ? Icon(AppIcons.refresh, color: context.echoColors.error)
              : const SizedBox.shrink(),
        ),
        EchoSettingRow(
          icon: AppIcons.delete,
          title: '清除图片与资源缓存',
          description: '封面等资源会在下次打开时重新加载。',
          destructive: true,
          trailing: Icon(
            AppIcons.delete,
            size: 20,
            color: context.echoColors.error,
          ),
          onPressed: () => _confirmClear(
            context: context,
            title: '清除图片缓存',
            message: '确定要清除所有图片与资源缓存吗？下次打开时会重新加载。',
            onConfirm: () async {
              await ref.read(audioCacheServiceProvider).clearImageCache();
              ref.invalidate(imageCacheSizeProvider);
            },
          ),
        ),
      ],
    );
  }
}

class _LyricsCacheRows extends ConsumerWidget {
  const _LyricsCacheRows();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countAsync = ref.watch(lyricsCacheCountProvider);
    final value = countAsync.when(
      data: (count) => '$count 条',
      loading: () => '正在计算…',
      error: (error, stackTrace) => '获取失败',
    );

    return Column(
      children: <Widget>[
        EchoSettingRow(
          icon: AppIcons.lyrics,
          title: '歌词缓存',
          value: value,
          semanticLabel: countAsync.hasError ? '歌词缓存，获取失败，点击重试' : null,
          onPressed: countAsync.hasError
              ? () => ref.invalidate(lyricsCacheCountProvider)
              : null,
          trailing: countAsync.isLoading
              ? const SizedBox(width: 96, child: EchoSkeleton.line())
              : countAsync.hasError
              ? Icon(AppIcons.refresh, color: context.echoColors.error)
              : const SizedBox.shrink(),
        ),
        EchoSettingRow(
          icon: AppIcons.delete,
          title: '清除歌词缓存',
          description: '歌词会在下次播放时重新获取。',
          destructive: true,
          trailing: Icon(
            AppIcons.delete,
            size: 20,
            color: context.echoColors.error,
          ),
          onPressed: () => _confirmClear(
            context: context,
            title: '清除歌词缓存',
            message: '确定要清除所有歌词缓存吗？下次播放时会重新获取歌词。',
            onConfirm: () async {
              await ref.read(audioCacheServiceProvider).clearLyricsCache();
              ref.invalidate(lyricsCacheCountProvider);
            },
          ),
        ),
      ],
    );
  }
}

class _DownloadDirectorySection extends ConsumerWidget {
  const _DownloadDirectorySection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadedAsync = ref.watch(downloadedSongsProvider);
    final value = downloadedAsync.when(
      data: (songs) => '${songs.length} 首',
      loading: () => '正在读取…',
      error: (error, stackTrace) => '获取失败',
    );

    return EchoSettingsSection(
      title: '下载目录',
      description: '下载内容独立于临时缓存管理，可在下载管理中查看状态和目录。',
      children: <Widget>[
        EchoSettingRow(
          icon: AppIcons.download,
          title: '已下载歌曲',
          value: value,
          semanticLabel: downloadedAsync.hasError ? '已下载歌曲，获取失败，点击重试' : null,
          onPressed: downloadedAsync.hasError
              ? () => ref.invalidate(downloadedSongsProvider)
              : null,
          trailing: downloadedAsync.isLoading
              ? const SizedBox(width: 96, child: EchoSkeleton.line())
              : downloadedAsync.hasError
              ? Icon(AppIcons.refresh, color: context.echoColors.error)
              : const SizedBox.shrink(),
        ),
        EchoSettingRow(
          icon: AppIcons.folderOpen,
          title: '管理下载与目录',
          description: '查看下载任务、失败状态以及设备上的保存位置。',
          onPressed: () => Navigator.of(context).push<void>(
            EchoPageRoute<void>(
              context: context,
              builder: (context) => const DownloadManagerPage(),
            ),
          ),
        ),
      ],
    );
  }
}

Future<void> _confirmClear({
  required BuildContext context,
  required String title,
  required String message,
  required Future<void> Function() onConfirm,
}) async {
  final confirmed = await showEchoBottomSheet<bool>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    builder: (sheetContext) => EchoBottomSheet(
      title: title,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(message, style: sheetContext.echoTypography.body),
            SizedBox(height: sheetContext.echoSpacing.lg),
            Wrap(
              alignment: WrapAlignment.end,
              spacing: sheetContext.echoSpacing.xs,
              runSpacing: sheetContext.echoSpacing.xs,
              children: <Widget>[
                EchoButton.secondary(
                  label: '取消',
                  onPressed: () => Navigator.of(sheetContext).pop(false),
                ),
                EchoButton.destructive(
                  label: '清除',
                  onPressed: () => Navigator.of(sheetContext).pop(true),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
  if (confirmed != true) return;

  await onConfirm();
  if (context.mounted) {
    ToastNotifier.show('$title 完成', kind: EchoMessageKind.success);
  }
}

String _formatBytes(int bytes) {
  if (bytes <= 0) return '0 B';
  const units = <String>['B', 'KB', 'MB', 'GB'];
  var unitIndex = 0;
  var size = bytes.toDouble();
  while (size >= 1024 && unitIndex < units.length - 1) {
    size /= 1024;
    unitIndex++;
  }
  return '${size.toStringAsFixed(unitIndex == 0 ? 0 : 1)} ${units[unitIndex]}';
}
