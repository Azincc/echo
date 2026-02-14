import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/download_task.dart';
import '../../../providers/download_provider.dart';
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
            onSelected: (value) {
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
            ],
          ),
        ],
      ),
      body: tasksAsync.when(
        data: (tasks) {
          if (tasks.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.download_done, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('暂无下载任务', style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

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

          return ListView(
            children: [
              if (downloading.isNotEmpty) ...[
                _buildSectionHeader(context, '下载中', downloading.length),
                ...downloading.map(
                  (t) => _buildTaskTile(context, ref, t, progress),
                ),
              ],
              if (paused.isNotEmpty) ...[
                _buildSectionHeader(context, '已暂停', paused.length),
                ...paused.map((t) => _buildTaskTile(context, ref, t, progress)),
              ],
              if (failed.isNotEmpty) ...[
                _buildSectionHeader(context, '失败', failed.length),
                ...failed.map((t) => _buildTaskTile(context, ref, t, progress)),
              ],
              if (completed.isNotEmpty) ...[
                _buildSectionHeader(context, '已完成', completed.length),
                ...completed.map(
                  (t) => _buildTaskTile(context, ref, t, progress),
                ),
              ],
            ],
          );
        },
        error: (err, stack) => Center(child: Text('错误: $err')),
        loading: () => const Center(child: CircularProgressIndicator()),
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
      DownloadTaskStatus.completed => IconButton(
        icon: const Icon(Icons.delete_outline, size: 20),
        onPressed: () => service.cancel(task.id),
      ),
    };
  }
}
