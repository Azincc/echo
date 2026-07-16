import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/echo_design.dart';
import '../../../core/utils/toast_notifier.dart';
import '../../../data/models/download_task.dart';
import '../../../data/models/song.dart';
import '../../../providers/download_provider.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../widgets/cover_art_image.dart';

typedef _DownloadScanResult = ({int valid, int missing, int orphan});

class DownloadManagerPage extends ConsumerWidget {
  const DownloadManagerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(downloadTasksProvider);
    final completedCount =
        tasksAsync.valueOrNull
            ?.where((task) => task.status == DownloadTaskStatus.completed)
            .length ??
        0;

    return EchoScaffold(
      topBar: EchoTopBar.back(
        context: context,
        title: '下载管理',
        actions: <Widget>[
          EchoIconButton(
            icon: AppIcons.more,
            label: '下载批量操作',
            onPressed: () => _showBulkActions(context, ref),
          ),
        ],
      ),
      bottomBar: completedCount > 0
          ? SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  context.echoSpacing.md,
                  context.echoSpacing.xs,
                  context.echoSpacing.md,
                  context.echoSpacing.sm,
                ),
                child: EchoButton.primary(
                  label: '播放全部已下载歌曲',
                  leadingIcon: AppIcons.play,
                  expand: true,
                  onPressed: () => _playAllDownloaded(context, ref),
                ),
              ),
            )
          : null,
      body: tasksAsync.when(
        data: (tasks) => _DownloadTaskList(tasks: tasks),
        error: (error, stackTrace) => EchoErrorState(
          title: '下载任务加载失败',
          description: '无法读取下载记录，请稍后重试。',
          actionLabel: '重试',
          onAction: () => ref.invalidate(downloadTasksProvider),
        ),
        loading: () => const _DownloadTaskSkeleton(),
      ),
    );
  }

  Future<void> _showBulkActions(BuildContext context, WidgetRef ref) async {
    final service = ref.read(downloadServiceProvider);
    await showEchoBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      builder: (sheetContext) => EchoBottomSheet(
        title: '下载批量操作',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            EchoActionRow(
              icon: AppIcons.pause,
              title: '全部暂停',
              onPressed: () {
                Navigator.of(sheetContext).pop();
                service.pauseAll();
              },
            ),
            EchoActionRow(
              icon: AppIcons.play,
              title: '全部恢复',
              onPressed: () {
                Navigator.of(sheetContext).pop();
                service.resumeAll();
              },
            ),
            EchoActionRow(
              icon: AppIcons.clearAll,
              title: '清除已完成记录',
              onPressed: () {
                Navigator.of(sheetContext).pop();
                service.clearCompleted();
              },
            ),
            EchoActionRow(
              icon: AppIcons.fileSearch,
              title: '扫描本地文件',
              onPressed: () {
                Navigator.of(sheetContext).pop();
                Future<void>.microtask(() {
                  if (!context.mounted) return;
                  _showScanSheet(context, ref);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showScanSheet(BuildContext context, WidgetRef ref) async {
    final service = ref.read(downloadServiceProvider);
    await showEchoBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => _DownloadScanSheet(
        onScan: service.scanLocalFiles,
        onCleanOrphans: service.cleanOrphanFiles,
      ),
    );
  }

  Future<void> _playAllDownloaded(BuildContext context, WidgetRef ref) async {
    final service = ref.read(downloadServiceProvider);
    final repository = ref.read(musicRepositoryProvider);
    if (repository == null) return;

    final tasks = await service.getDownloadedTasks();
    if (tasks.isEmpty) {
      ToastNotifier.show('没有已下载的歌曲');
      return;
    }

    final songs = <Song>[];
    for (final task in tasks) {
      final song = await repository.getSong(task.songId);
      if (song != null) songs.add(song);
    }
    if (songs.isEmpty) {
      ToastNotifier.show('无法读取已下载歌曲的信息');
      return;
    }

    unawaited(
      ref
          .read(playerProvider.notifier)
          .playSong(songs.first, queue: songs, index: 0),
    );
    ToastNotifier.show('播放 ${songs.length} 首已下载歌曲');
  }
}

class _DownloadTaskList extends ConsumerWidget {
  const _DownloadTaskList({required this.tasks});

  final List<DownloadTask> tasks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (tasks.isEmpty) {
      return const EchoEmptyState(
        title: '暂无下载任务',
        description: '在歌曲、专辑或歌单操作中选择下载，任务会显示在这里。',
        icon: AppIcons.downloadCloud,
      );
    }

    final groups = <_TaskGroup>[
      _TaskGroup(
        title: '下载中',
        tasks: tasks
            .where(
              (task) =>
                  task.status == DownloadTaskStatus.downloading ||
                  task.status == DownloadTaskStatus.pending,
            )
            .toList(),
      ),
      _TaskGroup(
        title: '已暂停',
        tasks: tasks
            .where((task) => task.status == DownloadTaskStatus.paused)
            .toList(),
      ),
      _TaskGroup(
        title: '失败',
        tasks: tasks
            .where((task) => task.status == DownloadTaskStatus.failed)
            .toList(),
      ),
      _TaskGroup(
        title: '已完成',
        tasks: tasks
            .where((task) => task.status == DownloadTaskStatus.completed)
            .toList(),
      ),
    ].where((group) => group.tasks.isNotEmpty).toList();

    return Column(
      children: <Widget>[
        FutureBuilder<String>(
          future: ref.read(downloadServiceProvider).getDownloadDir(),
          builder: (context, snapshot) =>
              _DownloadDirectory(path: snapshot.data),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 840),
              child: ListView.builder(
                padding: EdgeInsets.fromLTRB(
                  context.echoSpacing.md,
                  context.echoSpacing.sm,
                  context.echoSpacing.md,
                  context.echoSpacing.xxl + context.echoShellBottomObstruction,
                ),
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  final group = groups[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: context.echoSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        EchoSectionHeader(
                          title: group.title,
                          description: '${group.tasks.length} 项',
                        ),
                        SizedBox(height: context.echoSpacing.xs),
                        for (final task in group.tasks)
                          _DownloadTaskRow(task: task),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DownloadTaskRow extends ConsumerWidget {
  const _DownloadTaskRow({required this.task});

  final DownloadTask task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamedProgress = ref.watch(
      downloadProgressProvider.select((state) => state.valueOrNull?[task.id]),
    );
    final progress = (streamedProgress ?? task.progress)
        .clamp(0.0, 1.0)
        .toDouble();
    final service = ref.read(downloadServiceProvider);
    final isPlayable = task.status == DownloadTaskStatus.completed;

    return Padding(
      padding: EdgeInsets.only(bottom: context.echoSpacing.xs),
      child: EchoPressable(
        semanticLabel: _taskSemanticLabel(task, progress),
        semanticsMode: EchoPressableSemanticsMode.explicitChildren,
        onPressed: isPlayable ? () => _playTask(context, ref, task) : null,
        onLongPress: isPlayable
            ? () => _showTaskActions(context, ref, task)
            : null,
        minimumSize: const Size(double.infinity, 72),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.echoSpacing.xs,
            vertical: context.echoSpacing.xs,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ExcludeSemantics(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: context.echoRadii.detail,
                      child: CoverArtImage(
                        coverArtId: task.coverArt,
                        size: 48,
                        requestSize: 192,
                        semanticLabel: '${task.title} 封面',
                      ),
                    ),
                    SizedBox(width: context.echoSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(task.title, style: context.echoTypography.title),
                          if (task.artist?.trim().isNotEmpty ==
                              true) ...<Widget>[
                            SizedBox(height: context.echoSpacing.xxs),
                            Text(
                              task.artist!.trim(),
                              style: context.echoTypography.body.copyWith(
                                color: context.echoColors.muted,
                              ),
                            ),
                          ],
                          SizedBox(height: context.echoSpacing.xxs),
                          Text(
                            _taskStatusText(task),
                            style: context.echoTypography.metadata.copyWith(
                              color: task.status == DownloadTaskStatus.failed
                                  ? context.echoColors.error
                                  : context.echoColors.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (task.status == DownloadTaskStatus.downloading) ...<Widget>[
                SizedBox(height: context.echoSpacing.xs),
                ExcludeSemantics(
                  child: EchoProgressBar(value: progress, height: 4),
                ),
              ],
              SizedBox(height: context.echoSpacing.xs),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Wrap(
                  spacing: context.echoSpacing.xs,
                  children: _taskActions(
                    task: task,
                    onPause: () => service.pause(task.id),
                    onResume: () => service.resume(task.id),
                    onCancel: () => service.cancel(task.id),
                    onPlay: () => _playTask(context, ref, task),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DownloadDirectory extends StatelessWidget {
  const _DownloadDirectory({this.path});

  final String? path;

  @override
  Widget build(BuildContext context) {
    return EchoSurface(
      level: EchoSurfaceLevel.raised,
      borderRadius: BorderRadius.zero,
      padding: EdgeInsets.symmetric(
        horizontal: context.echoSpacing.md,
        vertical: context.echoSpacing.xs,
      ),
      child: Semantics(
        label: '下载目录，${path ?? '正在读取'}',
        child: ExcludeSemantics(
          child: Row(
            children: <Widget>[
              Icon(
                AppIcons.folderOpen,
                size: 18,
                color: context.echoColors.muted,
              ),
              SizedBox(width: context.echoSpacing.xs),
              Expanded(
                child: Text(
                  path ?? '正在读取下载目录',
                  style: context.echoTypography.metadata.copyWith(
                    color: context.echoColors.muted,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DownloadScanSheet extends StatefulWidget {
  const _DownloadScanSheet({
    required this.onScan,
    required this.onCleanOrphans,
  });

  final Future<_DownloadScanResult> Function() onScan;
  final Future<int> Function() onCleanOrphans;

  @override
  State<_DownloadScanSheet> createState() => _DownloadScanSheetState();
}

class _DownloadScanSheetState extends State<_DownloadScanSheet> {
  late Future<_DownloadScanResult> _scan;
  bool _cleaning = false;

  @override
  void initState() {
    super.initState();
    _scan = widget.onScan();
  }

  void _retry() => setState(() => _scan = widget.onScan());

  Future<void> _cleanOrphans() async {
    if (_cleaning) return;
    setState(() => _cleaning = true);
    try {
      final cleaned = await widget.onCleanOrphans();
      ToastNotifier.show('已清理 $cleaned 个孤立文件');
      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _cleaning = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return EchoBottomSheet(
      title: '扫描本地文件',
      subtitle: '核对下载记录与实际文件。',
      child: FutureBuilder<_DownloadScanResult>(
        future: _scan,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const _ScanSkeleton();
          }
          if (snapshot.hasError || snapshot.data == null) {
            return EchoErrorState(
              title: '扫描失败',
              description: '无法完成本地文件核对，请重试。',
              actionLabel: '重试',
              onAction: _retry,
              padding: const EdgeInsets.all(24),
            );
          }

          final result = snapshot.data!;
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _ScanResultRow(
                label: '正常文件',
                count: result.valid,
                icon: AppIcons.checkCircle,
                color: context.echoColors.accent,
              ),
              _ScanResultRow(
                label: '缺失文件',
                count: result.missing,
                icon: AppIcons.error,
                color: context.echoColors.error,
              ),
              _ScanResultRow(
                label: '孤立文件',
                count: result.orphan,
                icon: AppIcons.warning,
                color: context.echoColors.warning,
              ),
              SizedBox(height: context.echoSpacing.lg),
              if (result.orphan > 0)
                EchoButton.destructive(
                  label: _cleaning ? '正在清理' : '清理孤立文件',
                  leadingIcon: AppIcons.delete,
                  expand: true,
                  onPressed: _cleaning ? null : _cleanOrphans,
                )
              else
                Text(
                  '所有文件状态正常。',
                  textAlign: TextAlign.center,
                  style: context.echoTypography.body.copyWith(
                    color: context.echoColors.muted,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _ScanResultRow extends StatelessWidget {
  const _ScanResultRow({
    required this.label,
    required this.count,
    required this.icon,
    required this.color,
  });

  final String label;
  final int count;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.echoSpacing.xs),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 22, color: color),
          SizedBox(width: context.echoSpacing.sm),
          Expanded(child: Text(label, style: context.echoTypography.title)),
          Text(
            '$count',
            style: context.echoTypography.title.copyWith(
              color: color,
              fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

class _DownloadTaskSkeleton extends StatelessWidget {
  const _DownloadTaskSkeleton();

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
        children: <Widget>[
          const EchoSkeleton(width: 48, height: 48),
          SizedBox(width: context.echoSpacing.sm),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                EchoSkeleton.line(width: 190),
                SizedBox(height: 8),
                EchoSkeleton.line(width: 120, height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScanSkeleton extends StatelessWidget {
  const _ScanSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (var index = 0; index < 3; index++) ...<Widget>[
          const EchoSkeleton.line(),
          if (index < 2) SizedBox(height: context.echoSpacing.sm),
        ],
      ],
    );
  }
}

class _TaskGroup {
  const _TaskGroup({required this.title, required this.tasks});

  final String title;
  final List<DownloadTask> tasks;
}

List<Widget> _taskActions({
  required DownloadTask task,
  required VoidCallback onPause,
  required VoidCallback onResume,
  required VoidCallback onCancel,
  required VoidCallback onPlay,
}) {
  EchoIconButton action(IconData icon, String label, VoidCallback onPressed) {
    return EchoIconButton(icon: icon, label: label, onPressed: onPressed);
  }

  return switch (task.status) {
    DownloadTaskStatus.downloading => <Widget>[
      action(AppIcons.pause, '暂停 ${task.title}', onPause),
    ],
    DownloadTaskStatus.pending => const <Widget>[EchoSkeleton.circle(size: 32)],
    DownloadTaskStatus.paused => <Widget>[
      action(AppIcons.play, '继续 ${task.title}', onResume),
      action(AppIcons.close, '取消 ${task.title}', onCancel),
    ],
    DownloadTaskStatus.failed => <Widget>[
      action(AppIcons.refresh, '重试 ${task.title}', onResume),
      action(AppIcons.close, '取消 ${task.title}', onCancel),
    ],
    DownloadTaskStatus.completed => <Widget>[
      action(AppIcons.play, '播放 ${task.title}', onPlay),
      action(AppIcons.delete, '删除 ${task.title}', onCancel),
    ],
  };
}

String _taskStatusText(DownloadTask task) {
  if (task.status == DownloadTaskStatus.failed &&
      task.errorMessage?.trim().isNotEmpty == true) {
    return '${task.status.displayName} · ${task.errorMessage!.trim()}';
  }
  return task.status.displayName;
}

String _taskSemanticLabel(DownloadTask task, double progress) {
  final percentage = (progress * 100).round();
  return <String>[
    task.title,
    if (task.artist?.trim().isNotEmpty == true) task.artist!.trim(),
    task.status.displayName,
    if (task.status == DownloadTaskStatus.downloading) '$percentage%',
    if (task.errorMessage?.trim().isNotEmpty == true) task.errorMessage!.trim(),
  ].join('，');
}

Future<void> _playTask(
  BuildContext context,
  WidgetRef ref,
  DownloadTask task,
) async {
  final repository = ref.read(musicRepositoryProvider);
  if (repository == null) return;

  final song = await repository.getSong(task.songId);
  if (song == null) {
    ToastNotifier.show('无法获取歌曲信息');
    return;
  }
  unawaited(ref.read(playerProvider.notifier).playSong(song));
  ToastNotifier.show('正在播放：${task.title}');
}

Future<void> _showTaskActions(
  BuildContext context,
  WidgetRef ref,
  DownloadTask task,
) async {
  final service = ref.read(downloadServiceProvider);
  await showEchoBottomSheet<void>(
    context: context,
    useRootNavigator: true,
    builder: (sheetContext) => EchoBottomSheet(
      title: task.title,
      subtitle: task.artist,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          EchoActionRow(
            icon: AppIcons.play,
            title: '播放',
            onPressed: () {
              Navigator.of(sheetContext).pop();
              unawaited(_playTask(context, ref, task));
            },
          ),
          EchoActionRow(
            icon: AppIcons.delete,
            title: '删除下载',
            destructive: true,
            onPressed: () {
              Navigator.of(sheetContext).pop();
              service.cancel(task.id);
            },
          ),
        ],
      ),
    ),
  );
}
