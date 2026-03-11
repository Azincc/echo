import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/sources/remote/embed_service_client.dart';
import '../../../providers/offline_download_provider.dart';

class OfflineDownloadStatusPage extends ConsumerStatefulWidget {
  const OfflineDownloadStatusPage({super.key});

  @override
  ConsumerState<OfflineDownloadStatusPage> createState() =>
      _OfflineDownloadStatusPageState();
}

class _OfflineDownloadStatusPageState
    extends ConsumerState<OfflineDownloadStatusPage> {
  bool _selectMode = false;
  final Set<String> _selected = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final config = ref.read(activeEmbedServiceConfigProvider);
      ref.read(offlineDownloadServiceProvider).setConfig(config);
    });
  }

  void _toggleSelectMode() {
    setState(() {
      _selectMode = !_selectMode;
      if (!_selectMode) _selected.clear();
    });
  }

  void _toggleSelection(String jobId) {
    setState(() {
      if (_selected.contains(jobId)) {
        _selected.remove(jobId);
      } else {
        _selected.add(jobId);
      }
    });
  }

  Future<void> _batchDelete() async {
    if (_selected.isEmpty) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('批量删除'),
        content: Text('确定要删除选中的 ${_selected.length} 个任务吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    try {
      await ref
          .read(offlineDownloadServiceProvider)
          .batchDeleteTasks(_selected.toList());
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('已删除 ${_selected.length} 个任务')));
        setState(() {
          _selected.clear();
          _selectMode = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('删除失败: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final jobsAsync = ref.watch(offlineDownloadJobsProvider);
    final summary = ref.watch(offlineDownloadSummaryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectMode ? '已选 ${_selected.length} 项' : '离线下载状态'),
        leading: _selectMode
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: _toggleSelectMode,
              )
            : null,
        actions: _selectMode
            ? [
                IconButton(
                  tooltip: '全选',
                  icon: const Icon(Icons.select_all),
                  onPressed: () {
                    final jobs =
                        ref.read(offlineDownloadJobsProvider).valueOrNull ?? [];
                    setState(() {
                      if (_selected.length == jobs.length) {
                        _selected.clear();
                      } else {
                        _selected.addAll(jobs.map((j) => j.jobId));
                      }
                    });
                  },
                ),
                IconButton(
                  tooltip: '删除选中',
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: _selected.isEmpty ? null : _batchDelete,
                ),
              ]
            : [
                IconButton(
                  tooltip: '刷新',
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    final config = ref.read(activeEmbedServiceConfigProvider);
                    ref
                        .read(offlineDownloadServiceProvider)
                        .refreshNow(config: config);
                  },
                ),
                IconButton(
                  tooltip: '批量管理',
                  icon: const Icon(Icons.checklist),
                  onPressed: _toggleSelectMode,
                ),
              ],
      ),
      body: Column(
        children: [
          _SummaryBar(summary: summary),
          Expanded(
            child: jobsAsync.when(
              data: (jobs) {
                if (jobs.isEmpty) {
                  return const Center(child: Text('暂无离线任务'));
                }

                return ListView.separated(
                  itemCount: jobs.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final job = jobs[index];
                    return _JobTile(
                      job: job,
                      selectMode: _selectMode,
                      selected: _selected.contains(job.jobId),
                      onSelect: () => _toggleSelection(job.jobId),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('加载失败'),
                    const SizedBox(height: 8),
                    FilledButton.tonal(
                      onPressed: () {
                        final config = ref.read(
                          activeEmbedServiceConfigProvider,
                        );
                        ref
                            .read(offlineDownloadServiceProvider)
                            .refreshNow(config: config);
                      },
                      child: const Text('重试'),
                    ),
                  ],
                ),
              ),
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

class _JobTile extends ConsumerWidget {
  final EmbedJobStatus job;
  final bool selectMode;
  final bool selected;
  final VoidCallback onSelect;

  const _JobTile({
    required this.job,
    required this.selectMode,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final percent = (job.progressRatio * 100).clamp(0, 100).toStringAsFixed(0);
    final title = (job.title ?? '').isNotEmpty ? job.title! : job.jobId;
    final subtitleParts = <String>[
      if ((job.artist ?? '').isNotEmpty) job.artist!,
      '${job.statusDisplayName} · $percent%',
      if (job.message != null && job.message!.trim().isNotEmpty) job.message!,
      if (job.isFailed && job.error != null && job.error!.trim().isNotEmpty)
        '❌ ${job.error}',
    ];

    return InkWell(
      onTap: selectMode ? onSelect : null,
      onLongPress: selectMode ? null : () => _showActionsSheet(context, ref),
      child: ListTile(
        leading: selectMode
            ? Checkbox(value: selected, onChanged: (_) => onSelect())
            : Icon(
                job.isDone
                    ? Icons.check_circle
                    : job.isFailed
                    ? Icons.error
                    : job.isCancelled
                    ? Icons.cancel
                    : Icons.downloading,
                color: job.isDone
                    ? Colors.green
                    : job.isFailed
                    ? Colors.red
                    : job.isCancelled
                    ? Colors.grey
                    : Theme.of(context).colorScheme.primary,
              ),
        title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final line in subtitleParts)
              Text(
                line,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            if (job.isActive)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: LinearProgressIndicator(value: job.progressRatio),
              ),
          ],
        ),
        trailing: selectMode
            ? null
            : Text(
                job.album ?? '',
                style: Theme.of(context).textTheme.bodySmall,
              ),
      ),
    );
  }

  void _showActionsSheet(BuildContext context, WidgetRef ref) {
    final actions = <Widget>[];

    if (job.isFailed) {
      actions.add(
        ListTile(
          leading: const Icon(Icons.refresh),
          title: const Text('重试'),
          onTap: () async {
            Navigator.of(context).pop();
            try {
              await ref
                  .read(offlineDownloadServiceProvider)
                  .retryTask(job.jobId);
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
      );
    }

    if (job.isActive) {
      actions.add(
        ListTile(
          leading: Icon(
            Icons.cancel,
            color: Theme.of(context).colorScheme.error,
          ),
          title: Text(
            '取消',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
          onTap: () async {
            Navigator.of(context).pop();
            try {
              await ref
                  .read(offlineDownloadServiceProvider)
                  .cancelTask(job.jobId);
              if (context.mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('任务已取消')));
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('取消失败: $e')));
              }
            }
          },
        ),
      );
    }

    // 删除（任何状态都可以删除）
    actions.add(
      ListTile(
        leading: const Icon(Icons.delete_outline, color: Colors.red),
        title: const Text('删除', style: TextStyle(color: Colors.red)),
        onTap: () async {
          Navigator.of(context).pop();
          final confirmed = await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('删除任务'),
              content: Text(
                '确定要删除「${(job.title ?? '').isNotEmpty ? job.title! : job.jobId}」吗？',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(false),
                  child: const Text('取消'),
                ),
                FilledButton(
                  onPressed: () => Navigator.of(ctx).pop(true),
                  style: FilledButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('删除'),
                ),
              ],
            ),
          );
          if (confirmed == true && context.mounted) {
            try {
              await ref
                  .read(offlineDownloadServiceProvider)
                  .deleteTask(job.jobId);
              if (context.mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('任务已删除')));
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('删除失败: $e')));
              }
            }
          }
        },
      ),
    );

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).padding.bottom + 8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(
                    ctx,
                  ).colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 8),
              ListTile(
                dense: true,
                title: Text(
                  (job.title ?? '').isNotEmpty ? job.title! : job.jobId,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  '${job.artist ?? "未知歌手"} · ${job.statusDisplayName}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Divider(height: 1),
              ...actions,
            ],
          ),
        ),
      ),
    );
  }
}
