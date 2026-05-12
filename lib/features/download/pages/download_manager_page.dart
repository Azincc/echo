import 'package:flutter/material.dart';
import 'package:echoes/widgets/app_back_button.dart';
import 'package:echoes/core/theme/app_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/download_task.dart';
import '../../../data/models/song.dart';
import '../../../providers/download_provider.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../widgets/cover_art_image.dart';
import '../../../widgets/music_chrome.dart';

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
        leading: const AppBackButton(),
        title: const Text('下载管理'),
        actions: [
          PopupMenuButton<String>(
            color: Theme.of(context).colorScheme.surfaceContainerHigh
                .withValues(
                  alpha: Theme.of(context).brightness == Brightness.dark
                      ? 0.94
                      : 0.98,
                ),
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(
                color: MusicChrome.hairline(context),
                width: 0.7,
              ),
            ),
            icon: const Icon(AppIcons.more_horiz),
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
                child: Row(
                  children: [
                    Icon(AppIcons.pause),
                    SizedBox(width: 12),
                    Text('全部暂停'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'resume_all',
                child: Row(
                  children: [
                    Icon(AppIcons.play_arrow),
                    SizedBox(width: 12),
                    Text('全部恢复'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'clear_completed',
                child: Row(
                  children: [
                    Icon(AppIcons.clear_all),
                    SizedBox(width: 12),
                    Text('清除已完成'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'scan_files',
                child: Row(
                  children: [
                    Icon(AppIcons.find_in_page_outlined),
                    SizedBox(width: 12),
                    Text('扫描本地文件'),
                  ],
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
                          AppIcons.folder_outlined,
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
                              AppIcons.download_done,
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
        loading: () => const MusicLoadingPane(message: '正在读取下载任务'),
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
            icon: const Icon(AppIcons.play_arrow),
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

    return MusicGlassTile(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      title: task.title,
      titleWidget: Text(
        task.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w800),
      ),
      subtitleWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (task.artist != null)
            Text(
              task.artist!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          if (task.status == DownloadTaskStatus.downloading)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: currentProgress,
                  minHeight: 4,
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.48),
                ),
              ),
            )
          else
            Text(
              task.status.displayName +
                  (task.status == DownloadTaskStatus.failed &&
                          task.errorMessage != null
                      ? ': ${task.errorMessage}'
                      : ''),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: task.status == DownloadTaskStatus.failed
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
        ],
      ),
      leading: SizedBox(
        width: 48,
        height: 48,
        child: task.coverArt != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CoverArtImage(coverArtId: task.coverArt, size: 48),
              )
            : Container(
                decoration: BoxDecoration(
                  color: MusicChrome.glassFill(context, emphasized: true),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  AppIcons.music_note,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
      ),
      trailing: _buildTrailingActions(context, ref, task),
      onTap: task.status == DownloadTaskStatus.completed
          ? () => _playTask(context, ref, task)
          : null,
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
      DownloadTaskStatus.downloading => MusicIconButton(
        icon: AppIcons.pause,
        tooltip: '暂停',
        size: 38,
        margin: EdgeInsets.zero,
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
          MusicIconButton(
            icon: AppIcons.play_arrow,
            tooltip: '继续',
            size: 38,
            margin: EdgeInsets.zero,
            onPressed: () => service.resume(task.id),
          ),
          MusicIconButton(
            icon: AppIcons.close,
            tooltip: '取消',
            size: 38,
            margin: const EdgeInsets.only(left: 6),
            onPressed: () => service.cancel(task.id),
          ),
        ],
      ),
      DownloadTaskStatus.failed => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MusicIconButton(
            icon: AppIcons.refresh,
            tooltip: '重试',
            size: 38,
            margin: EdgeInsets.zero,
            onPressed: () => service.resume(task.id),
          ),
          MusicIconButton(
            icon: AppIcons.close,
            tooltip: '取消',
            size: 38,
            margin: const EdgeInsets.only(left: 6),
            onPressed: () => service.cancel(task.id),
          ),
        ],
      ),
      DownloadTaskStatus.completed => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MusicIconButton(
            icon: AppIcons.play_arrow,
            tooltip: '播放',
            size: 38,
            margin: EdgeInsets.zero,
            onPressed: () => _playTask(context, ref, task),
          ),
          MusicIconButton(
            icon: AppIcons.delete_outline,
            tooltip: '删除',
            size: 38,
            margin: const EdgeInsets.only(left: 6),
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
      builder: (context) => const MusicLoadingPane(message: '正在扫描本地文件'),
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
          Icon(AppIcons.circle, size: 10, color: color),
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
              leading: const Icon(AppIcons.play_arrow),
              title: const Text('播放'),
              onTap: () {
                Navigator.pop(context);
                _playTask(context, ref, task);
              },
            ),
            ListTile(
              leading: const Icon(AppIcons.delete_outline),
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
