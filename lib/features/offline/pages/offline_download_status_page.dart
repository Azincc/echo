import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/echo_design.dart';
import '../../../core/utils/toast_notifier.dart';
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
  final Set<String> _selected = <String>{};

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
      if (!_selected.add(jobId)) _selected.remove(jobId);
    });
  }

  void _toggleSelectAll() {
    final jobs =
        ref.read(offlineDownloadJobsProvider).valueOrNull ??
        const <EmbedJobStatus>[];
    setState(() {
      if (_selected.length == jobs.length) {
        _selected.clear();
      } else {
        _selected
          ..clear()
          ..addAll(jobs.map((job) => job.jobId));
      }
    });
  }

  void _refresh() {
    final config = ref.read(activeEmbedServiceConfigProvider);
    ref.read(offlineDownloadServiceProvider).refreshNow(config: config);
  }

  Future<void> _batchDelete() async {
    if (_selected.isEmpty) return;
    final count = _selected.length;
    final confirmed = await _confirmDelete(
      context: context,
      title: '删除离线任务',
      message: '确定要删除选中的 $count 个任务吗？',
    );
    if (!confirmed || !mounted) return;

    try {
      await ref
          .read(offlineDownloadServiceProvider)
          .batchDeleteTasks(_selected.toList());
      ToastNotifier.show('已删除 $count 个任务');
      if (!mounted) return;
      setState(() {
        _selected.clear();
        _selectMode = false;
      });
    } catch (_) {
      ToastNotifier.show('批量删除失败', kind: EchoMessageKind.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final jobsAsync = ref.watch(offlineDownloadJobsProvider);

    return EchoScaffold(
      topBar: EchoTopBar(
        title: _selectMode ? '已选 ${_selected.length} 项' : '离线下载状态',
        leading: EchoIconButton(
          icon: _selectMode ? AppIcons.close : AppIcons.back,
          label: _selectMode ? '退出批量管理' : '返回',
          onPressed: _selectMode
              ? _toggleSelectMode
              : () => Navigator.maybePop(context),
        ),
        actions: _selectMode
            ? <Widget>[
                EchoIconButton(
                  icon: AppIcons.selectAll,
                  label: '全选或取消全选',
                  onPressed: _toggleSelectAll,
                ),
                EchoIconButton(
                  icon: AppIcons.delete,
                  label: '删除选中任务',
                  foregroundColor: context.echoColors.error,
                  onPressed: _selected.isEmpty ? null : _batchDelete,
                ),
              ]
            : <Widget>[
                EchoIconButton(
                  icon: AppIcons.refresh,
                  label: '刷新离线任务',
                  onPressed: _refresh,
                ),
                EchoIconButton(
                  icon: AppIcons.selectAll,
                  label: '批量管理',
                  onPressed: _toggleSelectMode,
                ),
              ],
      ),
      body: Column(
        children: <Widget>[
          const _OfflineSummaryBar(),
          Expanded(
            child: jobsAsync.when(
              data: (jobs) {
                if (jobs.isEmpty) {
                  return const EchoEmptyState(
                    title: '暂无离线任务',
                    description: '开始离线下载后，这里会显示匹配、转码和写入状态。',
                    icon: AppIcons.offline,
                  );
                }
                return Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 840),
                    child: ListView.builder(
                      padding: EdgeInsets.fromLTRB(
                        context.echoSpacing.md,
                        context.echoSpacing.sm,
                        context.echoSpacing.md,
                        context.echoSpacing.xxl +
                            context.echoShellBottomObstruction,
                      ),
                      itemCount: jobs.length,
                      itemBuilder: (context, index) {
                        final job = jobs[index];
                        return _OfflineJobRow(
                          job: job,
                          selectMode: _selectMode,
                          selected: _selected.contains(job.jobId),
                          onSelect: () => _toggleSelection(job.jobId),
                        );
                      },
                    ),
                  ),
                );
              },
              loading: () => const _OfflineJobsSkeleton(),
              error: (error, stackTrace) => EchoErrorState(
                title: '离线任务加载失败',
                description: '无法读取嵌入服务的任务状态，请重试。',
                actionLabel: '重试',
                onAction: _refresh,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OfflineSummaryBar extends ConsumerWidget {
  const _OfflineSummaryBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(offlineDownloadSummaryProvider);
    return EchoSurface(
      level: EchoSurfaceLevel.raised,
      borderRadius: BorderRadius.zero,
      padding: EdgeInsets.symmetric(
        horizontal: context.echoSpacing.md,
        vertical: context.echoSpacing.xs,
      ),
      child: Wrap(
        spacing: context.echoSpacing.lg,
        runSpacing: context.echoSpacing.xs,
        children: <Widget>[
          _SummaryMetric(
            label: '进行中',
            value: summary.active,
            color: context.echoColors.accent,
          ),
          _SummaryMetric(
            label: '完成',
            value: summary.completed,
            color: context.echoColors.ink,
          ),
          _SummaryMetric(
            label: '失败',
            value: summary.failed,
            color: context.echoColors.error,
          ),
        ],
      ),
    );
  }
}

class _SummaryMetric extends StatelessWidget {
  const _SummaryMetric({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$label，$value',
      child: ExcludeSemantics(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: const SizedBox.square(dimension: 8),
            ),
            SizedBox(width: context.echoSpacing.xs),
            Text(
              '$label $value',
              style: context.echoTypography.label.copyWith(
                fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OfflineJobRow extends ConsumerWidget {
  const _OfflineJobRow({
    required this.job,
    required this.selectMode,
    required this.selected,
    required this.onSelect,
  });

  final EmbedJobStatus job;
  final bool selectMode;
  final bool selected;
  final VoidCallback onSelect;

  static bool _isUrl(String text) {
    final normalized = text.trim().toLowerCase();
    return normalized.startsWith('http://') ||
        normalized.startsWith('https://') ||
        normalized.startsWith('www.') ||
        normalized.contains('://');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = job.title?.trim().isNotEmpty == true
        ? job.title!.trim()
        : job.jobId;
    final metadata = <String>[
      if (job.artist?.trim().isNotEmpty == true) job.artist!.trim(),
      if (job.album?.trim().isNotEmpty == true) job.album!.trim(),
    ].join(' · ');
    final progress = job.progressRatio.clamp(0.0, 1.0).toDouble();
    final percentage = (progress * 100).round();
    final status = job.isActive
        ? '${job.statusDisplayName} · $percentage%'
        : job.statusDisplayName;
    final showMessage =
        job.message?.trim().isNotEmpty == true && !_isUrl(job.message!);
    final presentation = _jobPresentation(context, job);

    return Padding(
      padding: EdgeInsets.only(bottom: context.echoSpacing.xs),
      child: EchoPressable(
        semanticLabel: <String>[
          title,
          if (metadata.isNotEmpty) metadata,
          status,
          if (showMessage) job.message!.trim(),
          if (job.error?.trim().isNotEmpty == true) job.error!.trim(),
          if (selectMode) selected ? '已选择' : '未选择',
        ].join('，'),
        selected: selected,
        onPressed: selectMode ? onSelect : null,
        onLongPress: selectMode
            ? null
            : () => _showActionsSheet(context, ref, title),
        minimumSize: const Size(double.infinity, 72),
        child: AnimatedContainer(
          duration: context.echoMotion.resolve(
            context,
            context.echoMotion.state,
          ),
          curve: context.echoMotion.easeOut,
          padding: EdgeInsets.symmetric(
            horizontal: context.echoSpacing.xs,
            vertical: context.echoSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: selected
                ? context.echoColors.accent.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: context.echoRadii.control,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox.square(
                dimension: context.echoInteraction.minimumTouchTarget,
                child: Center(
                  child: Icon(
                    selectMode
                        ? selected
                              ? AppIcons.checkCircle
                              : AppIcons.radio
                        : presentation.icon,
                    size: 24,
                    color: selectMode && selected
                        ? context.echoColors.accent
                        : presentation.color,
                  ),
                ),
              ),
              SizedBox(width: context.echoSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title, style: context.echoTypography.title),
                    if (metadata.isNotEmpty) ...<Widget>[
                      SizedBox(height: context.echoSpacing.xxs),
                      Text(
                        metadata,
                        style: context.echoTypography.body.copyWith(
                          color: context.echoColors.muted,
                        ),
                      ),
                    ],
                    SizedBox(height: context.echoSpacing.xxs),
                    Text(
                      status,
                      style: context.echoTypography.metadata.copyWith(
                        color: job.isFailed
                            ? context.echoColors.error
                            : context.echoColors.muted,
                        fontFeatures: const <FontFeature>[
                          FontFeature.tabularFigures(),
                        ],
                      ),
                    ),
                    if (showMessage) ...<Widget>[
                      SizedBox(height: context.echoSpacing.xxs),
                      Text(
                        job.message!.trim(),
                        style: context.echoTypography.metadata.copyWith(
                          color: context.echoColors.muted,
                        ),
                      ),
                    ],
                    if (job.error?.trim().isNotEmpty == true) ...<Widget>[
                      SizedBox(height: context.echoSpacing.xxs),
                      Text(
                        job.error!.trim(),
                        style: context.echoTypography.metadata.copyWith(
                          color: context.echoColors.error,
                        ),
                      ),
                    ],
                    if (job.isActive) ...<Widget>[
                      SizedBox(height: context.echoSpacing.xs),
                      EchoProgressBar(
                        value: progress,
                        height: 4,
                        color: presentation.color,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showActionsSheet(
    BuildContext context,
    WidgetRef ref,
    String title,
  ) async {
    final service = ref.read(offlineDownloadServiceProvider);
    await showEchoBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      builder: (sheetContext) => EchoBottomSheet(
        title: title,
        subtitle: job.statusDisplayName,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (job.isFailed)
              EchoActionRow(
                icon: AppIcons.refresh,
                title: '重试',
                onPressed: () {
                  Navigator.of(sheetContext).pop();
                  _runAction(
                    action: () => service.retryTask(job.jobId),
                    successMessage: '已重新提交任务',
                    failureMessage: '重试失败',
                  );
                },
              ),
            if (job.isActive)
              EchoActionRow(
                icon: AppIcons.close,
                title: '取消任务',
                destructive: true,
                onPressed: () {
                  Navigator.of(sheetContext).pop();
                  _runAction(
                    action: () => service.cancelTask(job.jobId),
                    successMessage: '任务已取消',
                    failureMessage: '取消失败',
                  );
                },
              ),
            EchoActionRow(
              icon: AppIcons.delete,
              title: '删除任务',
              destructive: true,
              onPressed: () {
                Navigator.of(sheetContext).pop();
                Future<void>.microtask(() async {
                  if (!context.mounted) return;
                  final confirmed = await _confirmDelete(
                    context: context,
                    title: '删除任务',
                    message: '确定要删除「$title」吗？',
                  );
                  if (!confirmed) return;
                  await _runAction(
                    action: () => service.deleteTask(job.jobId),
                    successMessage: '任务已删除',
                    failureMessage: '删除失败',
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _runAction({
    required Future<void> Function() action,
    required String successMessage,
    required String failureMessage,
  }) async {
    try {
      await action();
      ToastNotifier.show(successMessage);
    } catch (_) {
      ToastNotifier.show(failureMessage, kind: EchoMessageKind.error);
    }
  }
}

class _OfflineJobsSkeleton extends StatelessWidget {
  const _OfflineJobsSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(
        context.echoSpacing.md,
        context.echoSpacing.md,
        context.echoSpacing.md,
        context.echoSpacing.md + context.echoShellBottomObstruction,
      ),
      itemCount: 5,
      separatorBuilder: (context, index) =>
          SizedBox(height: context.echoSpacing.md),
      itemBuilder: (context, index) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const EchoSkeleton.circle(size: 48),
          SizedBox(width: context.echoSpacing.sm),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                EchoSkeleton.line(width: 190),
                SizedBox(height: 8),
                EchoSkeleton.line(width: 130, height: 10),
                SizedBox(height: 8),
                EchoSkeleton.line(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _JobPresentation {
  const _JobPresentation({required this.icon, required this.color});

  final IconData icon;
  final Color color;
}

_JobPresentation _jobPresentation(BuildContext context, EmbedJobStatus job) {
  if (job.isDone) {
    return _JobPresentation(
      icon: AppIcons.checkCircle,
      color: context.echoColors.accent,
    );
  }
  if (job.isFailed) {
    return _JobPresentation(
      icon: AppIcons.error,
      color: context.echoColors.error,
    );
  }
  if (job.isCancelled) {
    return _JobPresentation(
      icon: AppIcons.close,
      color: context.echoColors.muted,
    );
  }
  return _JobPresentation(
    icon: AppIcons.downloadCloud,
    color: context.echoColors.accent,
  );
}

Future<bool> _confirmDelete({
  required BuildContext context,
  required String title,
  required String message,
}) async {
  final confirmed = await showEchoBottomSheet<bool>(
    context: context,
    useRootNavigator: true,
    builder: (sheetContext) => EchoBottomSheet(
      title: title,
      subtitle: '此操作不可恢复。',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            message,
            style: sheetContext.echoTypography.body.copyWith(
              color: sheetContext.echoColors.muted,
            ),
          ),
          SizedBox(height: sheetContext.echoSpacing.lg),
          Row(
            children: <Widget>[
              Expanded(
                child: EchoButton.secondary(
                  label: '取消',
                  onPressed: () => Navigator.of(sheetContext).pop(false),
                ),
              ),
              SizedBox(width: sheetContext.echoSpacing.sm),
              Expanded(
                child: EchoButton.destructive(
                  label: '删除',
                  onPressed: () => Navigator.of(sheetContext).pop(true),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
  return confirmed ?? false;
}
