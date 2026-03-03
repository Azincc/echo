import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/audio_cache_provider.dart';
import '../../../providers/download_provider.dart';
import '../../download/pages/download_manager_page.dart';

/// 缓存管理页面
class CacheManagementPage extends ConsumerWidget {
  const CacheManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('缓存管理')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildAudioCacheSection(context, ref),
          const SizedBox(height: 12),
          _buildImageCacheSection(context, ref),
          const SizedBox(height: 12),
          _buildLyricsCacheSection(context, ref),
          const SizedBox(height: 12),
          _buildDownloadSection(context, ref),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 音频缓存
  // ---------------------------------------------------------------------------

  Widget _buildAudioCacheSection(BuildContext context, WidgetRef ref) {
    final sizeAsync = ref.watch(audioCacheSizeProvider);
    final maxCacheSize = ref.watch(maxCacheSizeProvider);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.music_note_outlined,
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                const Text(
                  '音频缓存',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                const Spacer(),
                sizeAsync.when(
                  data: (size) => Text(
                    '${_formatBytes(size)} / ${_formatBytes(maxCacheSize)}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  loading: () => const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  error: (_, __) => const Text(
                    '获取失败',
                    style: TextStyle(fontSize: 13, color: Colors.red),
                  ),
                ),
              ],
            ),
            // 进度条
            sizeAsync.when(
              data: (size) {
                final progress = maxCacheSize > 0
                    ? (size / maxCacheSize).clamp(0.0, 1.0)
                    : 0.0;
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                    ),
                  ),
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
            const SizedBox(height: 12),
            // 缓存上限选择
            Text(
              '缓存上限',
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                _cacheLimitChip(
                  context,
                  ref,
                  '512 MB',
                  512 * 1024 * 1024,
                  maxCacheSize,
                ),
                _cacheLimitChip(
                  context,
                  ref,
                  '1 GB',
                  1 * 1024 * 1024 * 1024,
                  maxCacheSize,
                ),
                _cacheLimitChip(
                  context,
                  ref,
                  '2 GB',
                  2 * 1024 * 1024 * 1024,
                  maxCacheSize,
                ),
                _cacheLimitChip(
                  context,
                  ref,
                  '4 GB',
                  4 * 1024 * 1024 * 1024,
                  maxCacheSize,
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _confirmClear(
                  context,
                  ref,
                  title: '清除音频缓存',
                  message: '确定要清除所有音频缓存吗？这不会影响已下载的歌曲。',
                  onConfirm: () async {
                    await ref
                        .read(audioCacheServiceProvider)
                        .clearAllAudioCache();
                    ref.invalidate(audioCacheSizeProvider);
                  },
                ),
                icon: const Icon(Icons.delete_outline, size: 18),
                label: const Text('清除音频缓存'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cacheLimitChip(
    BuildContext context,
    WidgetRef ref,
    String label,
    int bytes,
    int currentMax,
  ) {
    final isSelected = currentMax == bytes;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) {
        ref.read(maxCacheSizeProvider.notifier).set(bytes);
      },
      visualDensity: VisualDensity.compact,
    );
  }

  // ---------------------------------------------------------------------------
  // 图片/资源缓存
  // ---------------------------------------------------------------------------

  Widget _buildImageCacheSection(BuildContext context, WidgetRef ref) {
    final sizeAsync = ref.watch(imageCacheSizeProvider);

    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: Icon(
          Icons.image_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: const Text('图片与资源缓存'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            sizeAsync.when(
              data: (size) => Text(
                _formatBytes(size),
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              loading: () => const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              error: (_, __) => const Text(
                '获取失败',
                style: TextStyle(fontSize: 13, color: Colors.red),
              ),
            ),
            const SizedBox(width: 4),
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 20),
              tooltip: '清除图片缓存',
              onPressed: () => _confirmClear(
                context,
                ref,
                title: '清除图片缓存',
                message: '确定要清除所有图片与资源缓存吗？下次打开时会重新加载。',
                onConfirm: () async {
                  await ref.read(audioCacheServiceProvider).clearImageCache();
                  ref.invalidate(imageCacheSizeProvider);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 歌词缓存
  // ---------------------------------------------------------------------------

  Widget _buildLyricsCacheSection(BuildContext context, WidgetRef ref) {
    final countAsync = ref.watch(lyricsCacheCountProvider);

    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: Icon(
          Icons.lyrics_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: const Text('歌词缓存'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            countAsync.when(
              data: (count) => Text(
                '$count 条',
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              loading: () => const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              error: (_, __) => const Text(
                '获取失败',
                style: TextStyle(fontSize: 13, color: Colors.red),
              ),
            ),
            const SizedBox(width: 4),
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 20),
              tooltip: '清除歌词缓存',
              onPressed: () => _confirmClear(
                context,
                ref,
                title: '清除歌词缓存',
                message: '确定要清除所有歌词缓存吗？下次播放时会重新获取歌词。',
                onConfirm: () async {
                  await ref.read(audioCacheServiceProvider).clearLyricsCache();
                  ref.invalidate(lyricsCacheCountProvider);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  // ---------------------------------------------------------------------------
  // 已下载歌曲
  // ---------------------------------------------------------------------------

  Widget _buildDownloadSection(BuildContext context, WidgetRef ref) {
    final downloadedAsync = ref.watch(downloadedSongsProvider);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.download_done_outlined,
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                const Text(
                  '已下载歌曲',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                const Spacer(),
                downloadedAsync.when(
                  data: (songs) => Text(
                    '${songs.length} 首',
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  loading: () => const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  error: (_, __) => const Text(
                    '获取失败',
                    style: TextStyle(fontSize: 13, color: Colors.red),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DownloadManagerPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.folder_open, size: 18),
                label: const Text('管理下载'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  Future<void> _confirmClear(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required String message,
    required Future<void> Function() onConfirm,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
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
      await onConfirm();
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$title 完成')));
      }
    }
  }

  String _formatBytes(int bytes) {
    if (bytes <= 0) return '0 B';
    const units = ['B', 'KB', 'MB', 'GB'];
    int unitIndex = 0;
    double size = bytes.toDouble();
    while (size >= 1024 && unitIndex < units.length - 1) {
      size /= 1024;
      unitIndex++;
    }
    return '${size.toStringAsFixed(unitIndex == 0 ? 0 : 1)} ${units[unitIndex]}';
  }
}
