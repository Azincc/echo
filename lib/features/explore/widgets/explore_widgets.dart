import 'package:flutter/material.dart';

import '../../../core/design/echo_design.dart';
import '../../../data/models/song.dart';
import '../../../widgets/cover_art_image.dart';

class ExploreModeControl extends StatelessWidget {
  const ExploreModeControl({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.onPressed,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return EchoPressable(
      semanticLabel: '$title，$description，点击切换搜索范围',
      onPressed: onPressed,
      minimumSize: const Size(double.infinity, 64),
      borderRadius: context.echoRadii.control,
      child: Ink(
        decoration: BoxDecoration(
          color: context.echoColors.raised,
          borderRadius: context.echoRadii.control,
          border: Border.all(color: context.echoColors.controlBoundary),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.echoSpacing.sm,
            vertical: context.echoSpacing.xs,
          ),
          child: Row(
            children: <Widget>[
              SizedBox.square(
                dimension: context.echoInteraction.minimumTouchTarget,
                child: Center(
                  child: Icon(icon, size: 22, color: context.echoColors.accent),
                ),
              ),
              SizedBox(width: context.echoSpacing.xs),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title, style: context.echoTypography.title),
                    SizedBox(height: context.echoSpacing.xxs),
                    Text(
                      description,
                      style: context.echoTypography.metadata.copyWith(
                        color: context.echoColors.muted,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: context.echoSpacing.xs),
              ExcludeSemantics(
                child: Icon(
                  AppIcons.chevronDown,
                  size: context.echoInteraction.smallIconSize,
                  color: context.echoColors.muted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExploreFilterOption<T> extends StatelessWidget {
  const ExploreFilterOption({
    super.key,
    required this.value,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final T value;
  final String label;
  final bool selected;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.echoColors;
    return EchoPressable(
      semanticLabel: label,
      selected: selected,
      onPressed: () => onSelected(value),
      minimumSize: Size(
        context.echoInteraction.minimumTouchTarget,
        context.echoInteraction.minimumTouchTarget,
      ),
      borderRadius: context.echoRadii.control,
      child: Ink(
        decoration: BoxDecoration(
          color: selected
              ? colors.accent.withValues(alpha: 0.12)
              : colors.raised,
          borderRadius: context.echoRadii.control,
          border: Border.all(
            color: selected ? colors.accent : colors.controlBoundary,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.echoSpacing.sm,
            vertical: context.echoSpacing.xs,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (selected) ...<Widget>[
                Icon(AppIcons.check, size: 18, color: colors.accent),
                SizedBox(width: context.echoSpacing.xxs),
              ],
              Text(
                label,
                style: context.echoTypography.label.copyWith(
                  color: selected ? colors.accent : colors.ink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExploreLibrarySongRow extends StatelessWidget {
  const ExploreLibrarySongRow({
    super.key,
    required this.song,
    required this.onPressed,
  });

  final Song song;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final artist = _songArtistAndAlbum(song);
    return EchoPressable(
      semanticLabel: '${song.title}，$artist，音乐库，${song.durationString}',
      onPressed: onPressed,
      minimumSize: const Size(double.infinity, 72),
      borderRadius: context.echoRadii.control,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.echoSpacing.xs),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: context.echoRadii.detail,
              child: CoverArtImage(
                coverArtId: song.coverArt,
                size: 52,
                requestSize: 208,
                semanticLabel: '${song.title} 封面',
              ),
            ),
            SizedBox(width: context.echoSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(song.title, style: context.echoTypography.title),
                  SizedBox(height: context.echoSpacing.xxs),
                  Text(
                    artist,
                    style: context.echoTypography.body.copyWith(
                      color: context.echoColors.muted,
                    ),
                  ),
                  SizedBox(height: context.echoSpacing.xxs),
                  Wrap(
                    spacing: context.echoSpacing.xs,
                    runSpacing: context.echoSpacing.xxs,
                    children: <Widget>[
                      _InlineMetadata(icon: AppIcons.library, label: '音乐库'),
                      _InlineMetadata(
                        icon: AppIcons.time,
                        label: song.durationString,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum ExploreRemoteDownloadState { idle, submitting, queued }

class ExploreRemoteSongRow extends StatelessWidget {
  const ExploreRemoteSongRow({
    super.key,
    required this.song,
    required this.selected,
    required this.selectionMode,
    required this.resolving,
    required this.downloadState,
    required this.onPressed,
    required this.onLongPress,
    required this.onToggleSelected,
    required this.onMorePressed,
    required this.onDownload,
  });

  final Song song;
  final bool selected;
  final bool selectionMode;
  final bool resolving;
  final ExploreRemoteDownloadState downloadState;
  final VoidCallback onPressed;
  final VoidCallback onLongPress;
  final VoidCallback onToggleSelected;
  final VoidCallback onMorePressed;
  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context) {
    final colors = context.echoColors;
    final metadata = _songArtistAndAlbum(song);
    final background = selected
        ? colors.accent.withValues(alpha: 0.1)
        : Colors.transparent;

    return EchoPressable(
      semanticLabel: <String>[
        song.title,
        metadata,
        '远程试听',
        if (selected) '已选择',
        if (resolving) '正在解析播放地址',
        if (downloadState == ExploreRemoteDownloadState.submitting) '正在提交下载',
        if (downloadState == ExploreRemoteDownloadState.queued) '已加入下载队列',
      ].join('，'),
      semanticsMode: EchoPressableSemanticsMode.explicitChildren,
      selected: selected,
      onPressed: onPressed,
      onLongPress: onLongPress,
      minimumSize: const Size(double.infinity, 76),
      borderRadius: context.echoRadii.control,
      child: Ink(
        decoration: BoxDecoration(
          color: background,
          borderRadius: context.echoRadii.control,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: context.echoSpacing.xs),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ExcludeSemantics(child: _RemoteCover(song: song)),
              SizedBox(width: context.echoSpacing.sm),
              Expanded(
                child: ExcludeSemantics(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(song.title, style: context.echoTypography.title),
                      SizedBox(height: context.echoSpacing.xxs),
                      Text(
                        metadata,
                        style: context.echoTypography.body.copyWith(
                          color: colors.muted,
                        ),
                      ),
                      SizedBox(height: context.echoSpacing.xxs),
                      const _InlineMetadata(
                        icon: AppIcons.headphones,
                        label: '试听',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: context.echoSpacing.xs),
              if (selectionMode)
                EchoIconButton(
                  icon: selected ? AppIcons.checkCircle : AppIcons.radio,
                  label: selected ? '取消选择 ${song.title}' : '选择 ${song.title}',
                  selected: selected,
                  onPressed: onToggleSelected,
                )
              else if (resolving)
                Semantics(
                  liveRegion: true,
                  label: '正在解析 ${song.title}',
                  child: const SizedBox.square(
                    dimension: 48,
                    child: Center(child: EchoSkeleton.circle(size: 24)),
                  ),
                )
              else
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    EchoIconButton(
                      icon: AppIcons.more,
                      label: '${song.title}，更多试听操作',
                      onPressed: onMorePressed,
                    ),
                    AnimatedSwitcher(
                      duration: context.echoMotion.resolve(
                        context,
                        context.echoMotion.feedback,
                      ),
                      switchInCurve: context.echoMotion.easeOut,
                      switchOutCurve: context.echoMotion.easeOut,
                      child: switch (downloadState) {
                        ExploreRemoteDownloadState.idle => EchoIconButton(
                          key: const ValueKey<String>('download-idle'),
                          icon: AppIcons.downloadOutline,
                          label: '添加 ${song.title} 到离线下载队列',
                          onPressed: onDownload,
                        ),
                        ExploreRemoteDownloadState.submitting =>
                          _RemoteDownloadStatus(
                            key: const ValueKey<String>('download-submitting'),
                            songTitle: song.title,
                            submitting: true,
                          ),
                        ExploreRemoteDownloadState.queued =>
                          _RemoteDownloadStatus(
                            key: const ValueKey<String>('download-queued'),
                            songTitle: song.title,
                            submitting: false,
                          ),
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RemoteDownloadStatus extends StatelessWidget {
  const _RemoteDownloadStatus({
    super.key,
    required this.songTitle,
    required this.submitting,
  });

  final String songTitle;
  final bool submitting;

  @override
  Widget build(BuildContext context) {
    final colors = context.echoColors;
    final animationsDisabled =
        MediaQuery.maybeOf(context)?.disableAnimations ??
        WidgetsBinding
            .instance
            .platformDispatcher
            .accessibilityFeatures
            .disableAnimations;
    final label = submitting
        ? '正在添加 $songTitle 到离线下载队列'
        : '$songTitle 已加入离线下载队列';

    return Semantics(
      liveRegion: true,
      label: label,
      child: ExcludeSemantics(
        child: SizedBox.square(
          dimension: context.echoInteraction.minimumTouchTarget,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.accent.withValues(alpha: 0.12),
              borderRadius: context.echoRadii.control,
            ),
            child: Center(
              child: submitting
                  ? animationsDisabled
                        ? Icon(AppIcons.time, size: 20, color: colors.accent)
                        : SizedBox.square(
                            dimension: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: colors.accent,
                              backgroundColor: colors.divider,
                            ),
                          )
                  : Icon(AppIcons.check, size: 22, color: colors.accent),
            ),
          ),
        ),
      ),
    );
  }
}

class ExploreSelectionBar extends StatelessWidget {
  const ExploreSelectionBar({
    super.key,
    required this.selectedCount,
    required this.downloading,
    required this.onCancel,
    required this.onDownload,
  });

  final int selectedCount;
  final bool downloading;
  final VoidCallback onCancel;
  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context) {
    final count = Text(
      '已选 $selectedCount 首',
      style: context.echoTypography.title,
    );
    final actions = <Widget>[
      EchoButton.ghost(label: '取消选择', onPressed: onCancel),
      SizedBox(width: context.echoSpacing.xs),
      EchoButton.primary(
        label: downloading ? '下载中…' : '下载选中',
        leadingIcon: AppIcons.downloadOutline,
        onPressed: downloading ? null : onDownload,
      ),
    ];

    return EchoSurface(
      level: EchoSurfaceLevel.surface,
      borderRadius: BorderRadius.zero,
      borderColor: context.echoColors.divider,
      padding: EdgeInsets.fromLTRB(
        context.echoPageHorizontalPadding,
        context.echoSpacing.xs,
        context.echoPageHorizontalPadding,
        context.echoSpacing.xs,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final stack =
              constraints.maxWidth < 380 ||
              MediaQuery.textScalerOf(context).scale(1) > 1.3;
          if (stack) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                count,
                SizedBox(height: context.echoSpacing.xs),
                Wrap(
                  spacing: context.echoSpacing.xs,
                  runSpacing: context.echoSpacing.xs,
                  children: actions,
                ),
              ],
            );
          }
          return Row(children: <Widget>[count, const Spacer(), ...actions]);
        },
      ),
    );
  }
}

class ExploreResultsLoading extends StatelessWidget {
  const ExploreResultsLoading({super.key, this.count = 6});

  final int count;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: context.echoPageHorizontalPadding,
        vertical: context.echoSpacing.xs,
      ),
      itemCount: count,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(bottom: context.echoSpacing.sm),
        child: Row(
          children: <Widget>[
            const EchoSkeleton(width: 52, height: 52),
            SizedBox(width: context.echoSpacing.sm),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  EchoSkeleton.line(width: 220, height: 16),
                  SizedBox(height: 8),
                  EchoSkeleton.line(width: 148, height: 12),
                ],
              ),
            ),
            SizedBox(width: context.echoSpacing.sm),
            const EchoSkeleton(width: 48, height: 48),
          ],
        ),
      ),
    );
  }
}

class ExplorePaginationState extends StatelessWidget {
  const ExplorePaginationState({
    super.key,
    this.error,
    required this.loading,
    required this.onRetry,
  });

  final String? error;
  final bool loading;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: context.echoSpacing.md),
        child: Column(
          children: <Widget>[
            Text(
              error!,
              textAlign: TextAlign.center,
              style: context.echoTypography.body.copyWith(
                color: context.echoColors.error,
              ),
            ),
            SizedBox(height: context.echoSpacing.xs),
            EchoButton.secondary(
              label: '重试',
              leadingIcon: AppIcons.refresh,
              onPressed: onRetry,
            ),
          ],
        ),
      );
    }
    if (!loading) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.echoSpacing.md),
      child: Semantics(
        liveRegion: true,
        label: '正在加载更多结果',
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const EchoSkeleton.circle(size: 24),
            SizedBox(width: context.echoSpacing.xs),
            Text(
              '正在加载更多',
              style: context.echoTypography.body.copyWith(
                color: context.echoColors.muted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InlineMetadata extends StatelessWidget {
  const _InlineMetadata({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 15, color: context.echoColors.muted),
        SizedBox(width: context.echoSpacing.xxs),
        Text(
          label,
          style: context.echoTypography.metadata.copyWith(
            color: context.echoColors.muted,
          ),
        ),
      ],
    );
  }
}

class _RemoteCover extends StatelessWidget {
  const _RemoteCover({required this.song});

  final Song song;

  @override
  Widget build(BuildContext context) {
    final url = song.previewCoverUrl?.trim() ?? '';
    final placeholder = ColoredBox(
      color: context.echoColors.raised,
      child: Center(
        child: Icon(AppIcons.music, size: 24, color: context.echoColors.muted),
      ),
    );

    return Semantics(
      image: true,
      label: url.isEmpty ? '暂无封面' : '${song.title} 封面',
      child: ExcludeSemantics(
        child: ClipRRect(
          borderRadius: context.echoRadii.detail,
          child: SizedBox.square(
            dimension: 52,
            child: url.isEmpty
                ? placeholder
                : Image.network(
                    url,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => placeholder,
                  ),
          ),
        ),
      ),
    );
  }
}

String _songArtistAndAlbum(Song song) {
  final artist = song.artist?.trim();
  final album = song.album?.trim();
  return <String>[
    artist == null || artist.isEmpty ? '未知歌手' : artist,
    if (album != null && album.isNotEmpty) album,
  ].join(' · ');
}
