import 'dart:async';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';

import '../../../core/design/echo_design.dart';
import '../../../data/models/album.dart';
import '../../../data/models/artist.dart';
import '../../../widgets/cover_art_image.dart';

class EchoAlbumTile extends StatelessWidget {
  const EchoAlbumTile({
    super.key,
    required this.album,
    required this.onPressed,
    this.onLongPress,
    this.allowFullText = false,
  });

  final Album album;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final bool allowFullText;

  @override
  Widget build(BuildContext context) {
    final artist = album.artist?.trim() ?? '';
    final semanticLabel = <String>[
      '专辑 ${album.name}',
      if (artist.isNotEmpty) artist,
      if (album.starred) '已收藏',
    ].join('，');

    return EchoPressable(
      semanticLabel: semanticLabel,
      onPressed: onPressed,
      onLongPress: onLongPress,
      minimumSize: const Size(96, 96),
      borderRadius: context.echoRadii.control,
      child: Padding(
        padding: EdgeInsets.only(bottom: context.echoSpacing.xs),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: context.echoRadii.control,
                    child: CoverArtImage(
                      coverArtId: album.coverArt,
                      requestSize: 420,
                      fit: BoxFit.cover,
                      semanticLabel: '${album.name} 封面',
                    ),
                  ),
                  if (album.starred)
                    PositionedDirectional(
                      start: context.echoSpacing.xs,
                      bottom: context.echoSpacing.xs,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: context.echoColors.surface,
                          borderRadius: context.echoRadii.pill,
                          border: Border.all(
                            color: context.echoColors.controlBoundary,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(context.echoSpacing.xxs),
                          child: Icon(
                            AppIcons.heart,
                            size: 16,
                            color: context.echoColors.error,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: context.echoSpacing.xs),
            Text(
              album.name,
              maxLines: allowFullText ? null : 2,
              overflow: allowFullText ? null : TextOverflow.ellipsis,
              style: context.echoTypography.title,
            ),
            if (artist.isNotEmpty) ...<Widget>[
              SizedBox(height: context.echoSpacing.xxs),
              Text(
                artist,
                maxLines: allowFullText ? null : 2,
                overflow: allowFullText ? null : TextOverflow.ellipsis,
                style: context.echoTypography.metadata.copyWith(
                  color: context.echoColors.muted,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class EchoAlbumRow extends StatelessWidget {
  const EchoAlbumRow({
    super.key,
    required this.album,
    required this.onPressed,
    this.onLongPress,
    this.contentPadding,
    this.allowFullText = true,
  });

  final Album album;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry? contentPadding;
  final bool allowFullText;

  @override
  Widget build(BuildContext context) {
    final artist = album.artist?.trim() ?? '';
    return EchoPressable(
      semanticLabel: <String>[
        '专辑 ${album.name}',
        if (artist.isNotEmpty) artist,
        if (album.starred) '已收藏',
      ].join('，'),
      onPressed: onPressed,
      onLongPress: onLongPress,
      minimumSize: Size(
        double.infinity,
        context.echoInteraction.expandedSongRowHeight,
      ),
      borderRadius: BorderRadius.zero,
      child: Padding(
        padding:
            contentPadding ??
            EdgeInsets.symmetric(
              horizontal: context.echoPageHorizontalPadding,
              vertical: context.echoSpacing.xs,
            ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: context.echoRadii.detail,
              child: CoverArtImage(
                coverArtId: album.coverArt,
                size: 72,
                requestSize: 240,
                semanticLabel: '${album.name} 封面',
              ),
            ),
            SizedBox(width: context.echoSpacing.sm),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    album.name,
                    maxLines: allowFullText ? null : 2,
                    overflow: allowFullText
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                    style: context.echoTypography.title,
                  ),
                  if (artist.isNotEmpty) ...<Widget>[
                    SizedBox(height: context.echoSpacing.xxs),
                    Text(
                      artist,
                      maxLines: allowFullText ? null : 1,
                      overflow: allowFullText
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                      style: context.echoTypography.body.copyWith(
                        color: context.echoColors.muted,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: context.echoSpacing.xs),
            if (album.starred)
              Icon(AppIcons.heart, size: 18, color: context.echoColors.error),
            SizedBox(width: context.echoSpacing.xs),
            Icon(
              AppIcons.chevronRight,
              size: 20,
              color: context.echoColors.muted,
            ),
          ],
        ),
      ),
    );
  }
}

class EchoArtistRow extends StatelessWidget {
  const EchoArtistRow({
    super.key,
    required this.artist,
    required this.onPressed,
    this.contentPadding,
  });

  final Artist artist;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final albumCount = artist.albumCount;
    return EchoPressable(
      semanticLabel: <String>[
        '歌手 ${artist.name}',
        if (albumCount != null) '$albumCount 张专辑',
      ].join('，'),
      onPressed: onPressed,
      minimumSize: Size(
        double.infinity,
        context.echoInteraction.expandedSongRowHeight,
      ),
      borderRadius: BorderRadius.zero,
      child: Padding(
        padding:
            contentPadding ??
            EdgeInsets.symmetric(
              horizontal: context.echoPageHorizontalPadding,
              vertical: context.echoSpacing.xs,
            ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipOval(child: _ArtistImage(artist: artist)),
            SizedBox(width: context.echoSpacing.sm),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(artist.name, style: context.echoTypography.title),
                  if (albumCount != null) ...<Widget>[
                    SizedBox(height: context.echoSpacing.xxs),
                    Text(
                      '$albumCount 张专辑',
                      style: context.echoTypography.metadata.copyWith(
                        color: context.echoColors.muted,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: context.echoSpacing.xs),
            Icon(
              AppIcons.chevronRight,
              size: 20,
              color: context.echoColors.muted,
            ),
          ],
        ),
      ),
    );
  }
}

class _ArtistImage extends StatelessWidget {
  const _ArtistImage({required this.artist});

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    final coverArt = artist.coverArt?.trim() ?? '';
    if (coverArt.isEmpty) {
      return ColoredBox(
        color: context.echoColors.raised,
        child: SizedBox.square(
          dimension: 56,
          child: Center(
            child: Icon(
              AppIcons.profile,
              size: 24,
              color: context.echoColors.muted,
            ),
          ),
        ),
      );
    }
    return CoverArtImage(
      coverArtId: coverArt,
      size: 56,
      requestSize: 192,
      semanticLabel: '${artist.name} 图片',
    );
  }
}

class EchoLibrarySectionLabel extends StatelessWidget {
  const EchoLibrarySectionLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.echoColors.canvas,
          border: Border(bottom: BorderSide(color: context.echoColors.divider)),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
            context.echoPageHorizontalPadding,
            context.echoSpacing.xs,
            44,
            context.echoSpacing.xs,
          ),
          child: Text(
            label,
            style: context.echoTypography.label.copyWith(
              color: context.echoColors.accent,
            ),
          ),
        ),
      ),
    );
  }
}

typedef EchoAzRevealBuilder =
    Widget Function(BuildContext context, double opacity, bool visible);

/// Reveals the alphabetical rail while the user scrolls or touches its edge.
///
/// The rail remains laid out while visually hidden so the first drag can jump
/// immediately instead of merely revealing the control for a second gesture.
class EchoAzIndexReveal extends StatefulWidget {
  const EchoAzIndexReveal({
    super.key,
    required this.builder,
    this.enabled = true,
  });

  final EchoAzRevealBuilder builder;
  final bool enabled;

  @override
  State<EchoAzIndexReveal> createState() => _EchoAzIndexRevealState();
}

class _EchoAzIndexRevealState extends State<EchoAzIndexReveal> {
  static const Duration _lingerDuration = Duration(milliseconds: 1200);
  static const double _edgeActivationWidth = 40;

  Timer? _hideTimer;
  bool _visible = false;
  bool _pointerActive = false;

  @override
  void didUpdateWidget(covariant EchoAzIndexReveal oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enabled && !widget.enabled) {
      _hideTimer?.cancel();
      _pointerActive = false;
      _visible = false;
    }
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  void _reveal() {
    if (!widget.enabled || !mounted) return;
    _hideTimer?.cancel();
    if (!_visible) setState(() => _visible = true);
    if (_pointerActive) return;
    _hideTimer = Timer(_lingerDuration, () {
      if (mounted) setState(() => _visible = false);
    });
  }

  void _beginPointer(PointerDownEvent event, double width) {
    if (!widget.enabled ||
        event.localPosition.dx < width - _edgeActivationWidth) {
      return;
    }
    _pointerActive = true;
    _reveal();
  }

  void _endPointer() {
    if (!_pointerActive) return;
    _pointerActive = false;
    _reveal();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.builder(context, 0, false);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Listener(
          onPointerDown: (event) => _beginPointer(event, constraints.maxWidth),
          onPointerUp: (_) => _endPointer(),
          onPointerCancel: (_) => _endPointer(),
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollStartNotification ||
                  notification is ScrollUpdateNotification ||
                  notification is UserScrollNotification) {
                _reveal();
              }
              return false;
            },
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(end: _visible ? 1 : 0),
              duration: context.echoMotion.resolve(
                context,
                context.echoMotion.feedback,
              ),
              curve: context.echoMotion.easeOut,
              builder: (context, opacity, _) {
                return widget.builder(context, opacity, opacity > 0.01);
              },
            ),
          ),
        );
      },
    );
  }
}

IndexBarOptions echoIndexBarOptions(
  BuildContext context, {
  required double opacity,
}) {
  final colors = context.echoColors;
  final typography = context.echoTypography;
  final textScale = MediaQuery.textScalerOf(context).scale(1);
  final indexSize = 11 / textScale;
  final hintSize = (typography.headline.fontSize ?? 24) / textScale;
  return IndexBarOptions(
    needRebuild: true,
    ignoreDragCancel: true,
    decoration: BoxDecoration(
      color: colors.surface.withValues(alpha: 0.96 * opacity),
      borderRadius: context.echoRadii.pill,
      border: Border.all(color: colors.divider.withValues(alpha: opacity)),
    ),
    downDecoration: BoxDecoration(
      color: colors.raised.withValues(alpha: opacity),
      borderRadius: context.echoRadii.pill,
    ),
    textStyle: typography.metadata.copyWith(
      fontSize: indexSize,
      height: 1,
      color: colors.muted.withValues(alpha: opacity),
    ),
    downTextStyle: typography.label.copyWith(
      fontSize: indexSize,
      height: 1,
      color: colors.accent.withValues(alpha: opacity),
    ),
    downItemDecoration: BoxDecoration(
      shape: BoxShape.circle,
      color: colors.accent.withValues(alpha: 0.14 * opacity),
    ),
    indexHintWidth: 60,
    indexHintHeight: 50,
    indexHintDecoration: BoxDecoration(
      color: colors.ink.withValues(alpha: 0.92),
      borderRadius: context.echoRadii.control,
    ),
    indexHintTextStyle: typography.headline.copyWith(
      fontSize: hintSize,
      color: colors.canvas,
    ),
    indexHintAlignment: Alignment.centerRight,
    indexHintChildAlignment: const Alignment(-0.25, 0),
    indexHintOffset: const Offset(-20, 0),
  );
}

class EchoMediaListSkeleton extends StatelessWidget {
  const EchoMediaListSkeleton({super.key, this.circle = false, this.count = 8});

  final bool circle;
  final int count;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: count,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.echoPageHorizontalPadding,
          vertical: context.echoSpacing.xs,
        ),
        child: Row(
          children: <Widget>[
            circle
                ? const EchoSkeleton.circle(size: 56)
                : EchoSkeleton(
                    width: 56,
                    height: 56,
                    borderRadius: context.echoRadii.detail,
                  ),
            SizedBox(width: context.echoSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  EchoSkeleton.line(width: 168 + (index % 3) * 24, height: 16),
                  SizedBox(height: context.echoSpacing.xs),
                  EchoSkeleton.line(width: 88 + (index % 2) * 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EchoAlbumGridSkeleton extends StatelessWidget {
  const EchoAlbumGridSkeleton({super.key, this.count = 8});

  final int count;

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final extent = textScale >= 1.6 ? 300.0 : 190.0;
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        context.echoPageHorizontalPadding,
        context.echoSpacing.sm,
        context.echoPageHorizontalPadding,
        context.echoSpacing.lg,
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: extent,
        childAspectRatio: 0.68,
        crossAxisSpacing: context.echoSpacing.sm,
        mainAxisSpacing: context.echoSpacing.sm,
      ),
      itemCount: count,
      itemBuilder: (context, index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: EchoSkeleton(
              height: double.infinity,
              borderRadius: context.echoRadii.control,
            ),
          ),
          SizedBox(height: context.echoSpacing.xs),
          EchoSkeleton.line(width: 120 + (index % 3) * 18, height: 16),
          SizedBox(height: context.echoSpacing.xs),
          EchoSkeleton.line(width: 72 + (index % 2) * 24),
        ],
      ),
    );
  }
}
