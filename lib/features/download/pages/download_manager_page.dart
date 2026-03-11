import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/download_task.dart';
import '../../../data/models/song.dart';
import '../../../providers/download_provider.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../widgets/cover_art_image.dart';

/// 下载管理器页面
class DownloadManagerPage extends ConsumerWidget {
  const DownloadManagerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(downloadTasksProvider);
    final progressAsync = ref.watch(downloadProgressProvider);
    final progress = progressAsync.valueOrNull ?? {};

    return Scaffold(
      appBar: AppBar(
        title: const Text('下载管理'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              final service = ref.read(downloadServiceProvider);
              switch (value) {
                case 'pause_all':
                  service.pauseAll();
                  break;
                case 'resume_all':
                  service.resumeAll();
                  break;
                case 'clear_completed':
                  service.clearCompleted();
                  break;
                case 'scan_files':
                  await _scanLocalFiles(context, ref);
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'pause_all',
                child: ListTile(
                  leading: Icon(Icons.pause),
                  title: Text('全部暂停'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'resume_all',
                child: ListTile(
                  leading: Icon(Icons.play_arrow),
                  title: Text('全部恢复'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'clear_completed',
                child: ListTile(
                  leading: Icon(Icons.clear_all),
                  title: Text('清除已完成'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'scan_files',
                child: ListTile(
                  leading: Icon(Icons.find_in_page_outlined),
                  title: Text('扫描本地文件'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
      body: tasksAsync.when(
        data: (tasks) {
          // 按状态分组
          final downloading = tasks
              .where(
                (t) =>
                    t.status == DownloadTaskStatus.downloading ||
                    t.status == DownloadTaskStatus.pending,
              )
              .toList();
          final paused = tasks
              .where((t) => t.status == DownloadTaskStatus.paused)
              .toList();
          final completed = tasks
              .where((t) => t.status == DownloadTaskStatus.completed)
              .toList();
          final failed = tasks
              .where((t) => t.status == DownloadTaskStatus.failed)
              .toList();

          return Column(
            children: [
              // 下载目录路径展示
              FutureBuilder<String>(
                future: ref.read(downloadServiceProvider).getDownloadDir(),
                builder: (context, snapshot) {
                  final path = snapshot.data ?? '...';
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest
                          .withValues(alpha: 0.5),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.folder_outlined,
                          size: 16,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            path,
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              // 任务列表
              Expanded(
                child: tasks.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.download_done,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              '暂无下载任务',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    : ListView(
                        children: [
                          if (downloading.isNotEmpty) ...[
                            _buildSectionHeader(
                              context,
                              '下载中',
                              downloading.length,
                            ),
                            ...downloading.map(
                              (t) => _buildTaskTile(context, ref, t, progress),
                            ),
                          ],
                          if (paused.isNotEmpty) ...[
                            _buildSectionHeader(context, '已暂停', paused.length),
                            ...paused.map(
                              (t) => _buildTaskTile(context, ref, t, progress),
                            ),
                          ],
                          if (failed.isNotEmpty) ...[
                            _buildSectionHeader(context, '失败', failed.length),
                            ...failed.map(
                              (t) => _buildTaskTile(context, ref, t, progress),
                            ),
                          ],
                          if (completed.isNotEmpty) ...[
                            _buildSectionHeader(
                              context,
                              '已完成',
                              completed.length,
                            ),
                            ...completed.map(
                              (t) => _buildTaskTile(context, ref, t, progress),
                            ),
                          ],
                        ],
                      ),
              ),
            ],
          );
        },
        error: (err, stack) => Center(child: Text('错误: $err')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      // 播放全部已下载歌曲 FAB
      floatingActionButton: tasksAsync.whenOrNull(
        data: (tasks) {
          final completedCount = tasks
              .where((t) => t.status == DownloadTaskStatus.completed)
              .length;
          if (completedCount == 0) return null;
          return FloatingActionButton.extended(
            onPressed: () => _playAllDownloaded(context, ref),
            icon: const Icon(Icons.play_arrow),
            label: const Text('播放全部'),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, int count) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        '$title ($count)',
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTaskTile(
    BuildContext context,
    WidgetRef ref,
    DownloadTask task,
    Map<String, double> progress,
  ) {
    final currentProgress = progress[task.id] ?? task.progress;

    return ListTile(
      leading: SizedBox(
        width: 48,
        height: 48,
        child: task.coverArt != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CoverArtImage(coverArtId: task.coverArt, size: 48),
              )
            : Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(Icons.music_note, color: Colors.grey),
              ),
      ),
      title: Text(task.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (task.artist != null)
            Text(
              task.artist!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            ),
          if (task.status == DownloadTaskStatus.downloading)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: LinearProgressIndicator(
                value: currentProgress,
                minHeight: 3,
              ),
            )
          else
            Text(
              task.status.displayName +
                  (task.status == DownloadTaskStatus.failed &&
                          task.errorMessage != null
                      ? ': ${task.errorMessage}'
                      : ''),
              style: TextStyle(
                fontSize: 11,
                color: task.status == DownloadTaskStatus.failed
                    ? Colors.red
                    : Colors.grey,
              ),
            ),
        ],
      ),
      trailing: _buildTrailingActions(context, ref, task),
      // 点击已完成任务 → 播放
      onTap: task.status == DownloadTaskStatus.completed
          ? () => _playTask(context, ref, task)
          : null,
      // 长按已完成任务 → 操作菜单
      onLongPress: task.status == DownloadTaskStatus.completed
          ? () => _showTaskMenu(context, ref, task)
          : null,
    );
  }

  Widget _buildTrailingActions(
    BuildContext context,
    WidgetRef ref,
    DownloadTask task,
  ) {
    final service = ref.read(downloadServiceProvider);

    return switch (task.status) {
      DownloadTaskStatus.downloading => IconButton(
        icon: const Icon(Icons.pause),
        onPressed: () => service.pause(task.id),
      ),
      DownloadTaskStatus.pending => const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      DownloadTaskStatus.paused => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: () => service.resume(task.id),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: () => service.cancel(task.id),
          ),
        ],
      ),
      DownloadTaskStatus.failed => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => service.resume(task.id),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: () => service.cancel(task.id),
          ),
        ],
      ),
      DownloadTaskStatus.completed => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 播放按钮
          IconButton(
            icon: const Icon(Icons.play_arrow, size: 20),
            tooltip: '播放',
            onPressed: () => _playTask(context, ref, task),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, size: 20),
            tooltip: '删除',
            onPressed: () => service.cancel(task.id),
          ),
        ],
      ),
    };
  }

  // ---------------------------------------------------------------------------
  // 播放联动
  // ---------------------------------------------------------------------------

  /// 播放单个已下载任务（从 API 获取完整 Song 元数据）
  Future<void> _playTask(
    BuildContext context,
    WidgetRef ref,
    DownloadTask task,
  ) async {
    final musicRepo = ref.read(musicRepositoryProvider);
    if (musicRepo == null) return;

    final song = await musicRepo.getSong(task.songId);
    if (song == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('无法获取歌曲信息')));
      }
      return;
    }

    ref.read(playerProvider.notifier).playSong(song);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('正在播放: ${task.title}'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  /// 播放全部已下载歌曲（从 API 获取完整 Song 元数据）
  Future<void> _playAllDownloaded(BuildContext context, WidgetRef ref) async {
    final service = ref.read(downloadServiceProvider);
    final musicRepo = ref.read(musicRepositoryProvider);
    if (musicRepo == null) return;

    final tasks = await service.getDownloadedTasks();
    if (tasks.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('没有已下载的歌曲')));
      }
      return;
    }

    final songs = <Song>[];
    for (final task in tasks) {
      final song = await musicRepo.getSong(task.songId);
      if (song != null) songs.add(song);
    }

    if (songs.isEmpty) return;

    ref
        .read(playerProvider.notifier)
        .playSong(songs.first, queue: songs, index: 0);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('播放 ${songs.length} 首已下载歌曲'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // 文件扫描
  // ---------------------------------------------------------------------------

  Future<void> _scanLocalFiles(BuildContext context, WidgetRef ref) async {
    final service = ref.read(downloadServiceProvider);

    // 显示加载指示
    if (!context.mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final result = await service.scanLocalFiles();

      if (!context.mounted) return;
      Navigator.pop(context); // 关闭加载

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('扫描结果'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _scanResultRow('正常文件', result.valid, Colors.green),
              if (result.missing > 0)
                _scanResultRow('缺失文件', result.missing, Colors.red),
              if (result.orphan > 0)
                _scanResultRow('孤立文件', result.orphan, Colors.orange),
              if (result.missing == 0 && result.orphan == 0)
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    '所有文件状态正常 ✓',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
            ],
          ),
          actions: [
            if (result.orphan > 0)
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  final cleaned = await service.cleanOrphanFiles();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('已清理 $cleaned 个孤立文件')),
                    );
                  }
                },
                child: const Text('清理孤立文件'),
              ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('关闭'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('扫描失败: $e')));
    }
  }

  Widget _scanResultRow(String label, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(Icons.circle, size: 10, color: color),
          const SizedBox(width: 8),
          Text(label),
          const Spacer(),
          Text(
            '$count',
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 长按菜单
  // ---------------------------------------------------------------------------

  void _showTaskMenu(BuildContext context, WidgetRef ref, DownloadTask task) {
    final service = ref.read(downloadServiceProvider);

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.play_arrow),
              title: const Text('播放'),
              onTap: () {
                Navigator.pop(context);
                _playTask(context, ref, task);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text('删除下载'),
              onTap: () {
                Navigator.pop(context);
                service.cancel(task.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
