import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/offline_download_task.dart';
import '../../../providers/offline_download_provider.dart';

class OfflineDownloadStatusPage extends ConsumerWidget {
  const OfflineDownloadStatusPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(offlineDownloadTasksProvider);
    final summary = ref.watch(offlineDownloadSummaryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('离线下载状态'),
        actions: [
          IconButton(
            tooltip: '刷新',
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(offlineDownloadServiceProvider).refreshNow();
            },
          ),
          IconButton(
            tooltip: '清理已完成/失败',
            icon: const Icon(Icons.cleaning_services_outlined),
            onPressed: () {
              ref.read(offlineDownloadServiceProvider).clearFinished();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _SummaryBar(summary: summary),
          Expanded(
            child: tasksAsync.when(
              data: (tasks) {
                if (tasks.isEmpty) {
                  return const Center(child: Text('暂无离线任务'));
                }

                return ListView.separated(
                  itemCount: tasks.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return _TaskTile(task: task);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => const Center(child: Text('加载失败，请稍后重试')),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryBar extends StatelessWidget {
  final OfflineDownloadSummary summary;

  const _SummaryBar({required this.summary});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Wrap(
        spacing: 12,
        runSpacing: 8,
        children: [
          _pill(context, '进行中', summary.active),
          _pill(context, '暂停', summary.paused),
          _pill(context, '完成', summary.completed),
          _pill(context, '失败', summary.failed),
        ],
      ),
    );
  }

  Widget _pill(BuildContext context, String label, int value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text('$label: $value'),
    );
  }
}

class _TaskTile extends ConsumerWidget {
  final OfflineDownloadTask task;

  const _TaskTile({required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final percent = (task.progressRatio * 100).clamp(0, 100).toStringAsFixed(1);
    final subtitleLines = <String>[
      if ((task.artist ?? '').isNotEmpty) task.artist!,
      '${task.status.displayName} · $percent%',
      if (task.statusMessage != null && task.statusMessage!.trim().isNotEmpty)
        task.statusMessage!,
      if (task.qualityLabel != null && task.qualityLabel!.isNotEmpty)
        task.qualityLabel!,
      if (task.errorMessage != null && task.errorMessage!.trim().isNotEmpty)
        '❌ ${task.errorMessage}',
    ];

    final isActive =
        task.status == OfflineDownloadTaskStatus.downloading ||
        task.status == OfflineDownloadTaskStatus.queued ||
        task.status == OfflineDownloadTaskStatus.resolving ||
        task.status == OfflineDownloadTaskStatus.tagging ||
        task.status == OfflineDownloadTaskStatus.moving ||
        task.status == OfflineDownloadTaskStatus.scanning;

    return ListTile(
      leading: task.coverUrl == null || task.coverUrl!.isEmpty
          ? const CircleAvatar(child: Icon(Icons.music_note))
          : CircleAvatar(backgroundImage: NetworkImage(task.coverUrl!)),
      title: Text(task.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final line in subtitleLines)
            Text(line, maxLines: 1, overflow: TextOverflow.ellipsis),
          if (isActive)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: LinearProgressIndicator(value: task.progressRatio),
            ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(task.source, style: Theme.of(context).textTheme.bodySmall),
          if (task.status == OfflineDownloadTaskStatus.failed)
            IconButton(
              icon: const Icon(Icons.refresh, size: 20),
              tooltip: '重试',
              onPressed: () async {
                try {
                  await ref
                      .read(offlineDownloadServiceProvider)
                      .retryTask(task.id);
                  if (context.mounted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('已重新提交任务')));
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('重试失败: $e')));
                  }
                }
              },
            ),
        ],
      ),
    );
  }
}
