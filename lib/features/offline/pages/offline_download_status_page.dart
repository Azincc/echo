import 'package:flutter/material.dart';
import 'package:echoes/widgets/app_back_button.dart';
import 'package:echoes/core/theme/app_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/sources/remote/embed_service_client.dart';
import '../../../providers/offline_download_provider.dart';
import '../../../widgets/music_chrome.dart';

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
            ? MusicIconButton(
                icon: AppIcons.close,
                tooltip: '退出选择',
                margin: const EdgeInsets.only(left: 8),
                onPressed: _toggleSelectMode,
              )
            : const AppBackButton(),
        actions: _selectMode
            ? [
                MusicIconButton(
                  tooltip: '全选',
                  icon: AppIcons.select_all,
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
                MusicIconButton(
                  tooltip: '删除选中',
                  icon: AppIcons.delete,
                  onPressed: _selected.isEmpty ? null : _batchDelete,
                ),
              ]
            : [
                MusicIconButton(
                  tooltip: '刷新',
                  icon: AppIcons.refresh,
                  onPressed: () {
                    final config = ref.read(activeEmbedServiceConfigProvider);
                    ref
                        .read(offlineDownloadServiceProvider)
                        .refreshNow(config: config);
                  },
                ),
                MusicIconButton(
                  tooltip: '批量管理',
                  icon: AppIcons.checklist,
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

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 18),
                  itemCount: jobs.length,
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
              loading: () => const MusicLoadingPane(message: '正在读取离线任务'),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
      child: MusicGlassSurface(
        borderRadius: BorderRadius.circular(20),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        color: MusicChrome.glassFill(context, emphasized: true),
        child: Wrap(
          spacing: 10,
          runSpacing: 8,
          children: [
            _pill(context, '进行中', summary.active),
            _pill(context, '完成', summary.completed),
            _pill(context, '失败', summary.failed),
          ],
        ),
      ),
    );
  }

  Widget _pill(BuildContext context, String label, int value) {
    return MusicGlassPill(label: '$label: $value');
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

  /// 过滤掉包含 URL 的消息
  static bool _isUrl(String text) {
    final t = text.trim().toLowerCase();
    return t.startsWith('http://') ||
        t.startsWith('https://') ||
        t.startsWith('www.') ||
        t.contains('://');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = (job.title ?? '').isNotEmpty ? job.title! : job.jobId;

    // 构建 artist · album 行
    final metaParts = <String>[
      if ((job.artist ?? '').isNotEmpty) job.artist!,
      if ((job.album ?? '').isNotEmpty) job.album!,
    ];
    final metaLine = metaParts.join(' · ');

    // 状态行：活动状态显示百分比，完成/失败状态只显示状态名
    final String statusLine;
    if (job.isActive) {
      final percent = (job.progressRatio * 100)
          .clamp(0, 100)
          .toStringAsFixed(0);
      statusLine = '${job.statusDisplayName} · $percent%';
    } else {
      statusLine = job.statusDisplayName;
    }

    // 过滤掉包含 URL 的 message
    final showMessage =
        job.message != null &&
        job.message!.trim().isNotEmpty &&
        !_isUrl(job.message!);

    final statusColor = job.isDone
        ? Colors.green
        : job.isFailed
        ? Theme.of(context).colorScheme.error
        : job.isCancelled
        ? Theme.of(context).colorScheme.onSurfaceVariant
        : Theme.of(context).colorScheme.primary;

    return MusicGlassTile(
      margin: const EdgeInsets.symmetric(vertical: 5),
      selected: selected,
      onTap: selectMode ? onSelect : null,
      onLongPress: selectMode ? null : () => _showActionsSheet(context, ref),
      leading: selectMode
          ? Checkbox(value: selected, onChanged: (_) => onSelect())
          : Icon(
              job.isDone
                  ? AppIcons.check_circle
                  : job.isFailed
                  ? AppIcons.error
                  : job.isCancelled
                  ? AppIcons.cancel
                  : AppIcons.downloading,
              color: statusColor,
            ),
      title: title,
      titleWidget: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w800),
      ),
      subtitleWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (metaLine.isNotEmpty)
            Text(
              metaLine,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          Text(
            statusLine,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: job.isFailed
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          if (showMessage)
            Text(
              job.message!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          if (job.isFailed && job.error != null && job.error!.trim().isNotEmpty)
            Text(
              '❌ ${job.error}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          if (job.isActive)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: job.progressRatio,
                  minHeight: 4,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showActionsSheet(BuildContext context, WidgetRef ref) {
    final actions = <Widget>[];

    if (job.isFailed) {
      actions.add(
        MusicGlassTile(
          leading: const Icon(AppIcons.refresh),
          title: '重试',
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
        MusicGlassTile(
          leading: Icon(
            AppIcons.cancel,
            color: Theme.of(context).colorScheme.error,
          ),
          title: '取消',
          titleWidget: Text(
            '取消',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.error,
              fontWeight: FontWeight.w800,
            ),
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
      MusicGlassTile(
        leading: Icon(
          AppIcons.delete_outline,
          color: Theme.of(context).colorScheme.error,
        ),
        title: '删除',
        titleWidget: Text(
          '删除',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.w800,
          ),
        ),
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
              MusicGlassTile(
                title: (job.title ?? '').isNotEmpty ? job.title! : job.jobId,
                subtitle: '${job.artist ?? "未知歌手"} · ${job.statusDisplayName}',
              ),
              const SizedBox(height: 4),
              ...actions,
            ],
          ),
        ),
      ),
    );
  }
}
