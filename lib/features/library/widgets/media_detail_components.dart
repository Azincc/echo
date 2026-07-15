import 'package:flutter/material.dart';

import '../../../core/design/echo_design.dart';
import '../../../data/models/album.dart';
import '../../../widgets/cover_art_image.dart';
import '../utils/library_sorting.dart';

Future<SongSortOption?> showMediaSongSortSheet({
  required BuildContext context,
  required SongSortOption current,
}) {
  return showEchoBottomSheet<SongSortOption>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    builder: (sheetContext) => EchoBottomSheet(
      title: '歌曲排序',
      subtitle: '当前：${current.label}',
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            for (final option in selectableSongSortOptions)
              EchoActionRow(
                icon: AppIcons.sort,
                title: option.label,
                selected: option == current,
                trailing: option == current
                    ? Icon(
                        AppIcons.check,
                        color: sheetContext.echoColors.accent,
                      )
                    : null,
                onPressed: () => Navigator.of(sheetContext).pop(option),
              ),
          ],
        ),
      ),
    ),
  );
}

class MediaDetailHeaderSurface extends StatelessWidget {
  const MediaDetailHeaderSurface({
    super.key,
    required this.child,
    this.useContentTint = true,
  });

  final Widget child;
  final bool useContentTint;

  @override
  Widget build(BuildContext context) {
    final colors = context.echoColors;
    final background = useContentTint
        ? Color.alphaBlend(
            colors.contentTint.withValues(alpha: 0.12),
            colors.canvas,
          )
        : colors.canvas;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        border: Border(bottom: BorderSide(color: colors.divider)),
      ),
      child: child,
    );
  }
}

class MediaDetailArtwork extends StatelessWidget {
  const MediaDetailArtwork({
    super.key,
    required this.coverArtId,
    required this.semanticLabel,
    this.heroTag,
    this.circular = false,
    this.requestSize = 720,
  });

  final String? coverArtId;
  final String semanticLabel;
  final Object? heroTag;
  final bool circular;
  final int requestSize;

  @override
  Widget build(BuildContext context) {
    Widget artwork = CoverArtImage(
      coverArtId: coverArtId,
      requestSize: requestSize,
      fit: BoxFit.cover,
      semanticLabel: semanticLabel,
    );
    artwork = circular
        ? ClipOval(child: artwork)
        : ClipRRect(borderRadius: context.echoRadii.surface, child: artwork);

    if (heroTag != null) {
      artwork = Hero(tag: heroTag!, child: artwork);
    }
    return artwork;
  }
}

class MediaDetailSectionSwitcher extends StatelessWidget {
  const MediaDetailSectionSwitcher({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.echoColors.canvas,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.echoSpacing.md,
          vertical: context.echoSpacing.xs,
        ),
        child: Row(
          children: <Widget>[
            for (var index = 0; index < labels.length; index++) ...<Widget>[
              if (index > 0) SizedBox(width: context.echoSpacing.xs),
              Expanded(
                child: EchoPressable(
                  semanticLabel: labels[index],
                  selected: index == selectedIndex,
                  onPressed: () => onSelected(index),
                  minimumSize: const Size(double.infinity, 48),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: index == selectedIndex
                          ? context.echoColors.accent.withValues(alpha: 0.12)
                          : Colors.transparent,
                      borderRadius: context.echoRadii.control,
                    ),
                    child: Center(
                      child: Text(
                        labels[index],
                        style: context.echoTypography.label.copyWith(
                          color: index == selectedIndex
                              ? context.echoColors.accent
                              : context.echoColors.ink,
                          fontWeight: index == selectedIndex
                              ? FontWeight.w700
                              : FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class MediaDetailAlbumTile extends StatelessWidget {
  const MediaDetailAlbumTile({
    super.key,
    required this.album,
    required this.onPressed,
    required this.onLongPress,
  });

  final Album album;
  final VoidCallback onPressed;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    final metadata = <String>[
      if (album.year != null) '${album.year}',
      '${album.songCount} 首',
    ].join(' · ');

    return EchoPressable(
      semanticLabel: '${album.name}，$metadata',
      onPressed: onPressed,
      onLongPress: onLongPress,
      minimumSize: const Size(double.infinity, 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: MediaDetailArtwork(
              coverArtId: album.coverArt,
              semanticLabel: '${album.name} 封面',
              heroTag: 'album-cover-${album.id}',
              requestSize: 480,
            ),
          ),
          SizedBox(height: context.echoSpacing.xs),
          Text(album.name, style: context.echoTypography.title, maxLines: 2),
          SizedBox(height: context.echoSpacing.xxs),
          Text(
            metadata,
            style: context.echoTypography.metadata.copyWith(
              color: context.echoColors.muted,
            ),
          ),
        ],
      ),
    );
  }
}

class MediaDetailLoadingView extends StatelessWidget {
  const MediaDetailLoadingView({super.key, this.circularArtwork = false});

  final bool circularArtwork;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(context.echoSpacing.md),
      children: <Widget>[
        Center(
          child: circularArtwork
              ? const EchoSkeleton.circle(size: 160)
              : const SizedBox.square(
                  dimension: 220,
                  child: EchoSkeleton(
                    height: 220,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
        ),
        SizedBox(height: context.echoSpacing.lg),
        const EchoSkeleton.line(width: 220, height: 28),
        SizedBox(height: context.echoSpacing.sm),
        const EchoSkeleton.line(width: 160),
        SizedBox(height: context.echoSpacing.lg),
        for (var index = 0; index < 6; index++) ...<Widget>[
          Row(
            children: <Widget>[
              const EchoSkeleton.circle(),
              SizedBox(width: context.echoSpacing.sm),
              const Expanded(child: EchoSkeleton.line(height: 18)),
            ],
          ),
          SizedBox(height: context.echoSpacing.md),
        ],
      ],
    );
  }
}

class MediaLoadNotice extends StatelessWidget {
  const MediaLoadNotice({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: message,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.echoColors.raised,
          borderRadius: context.echoRadii.control,
          border: Border.all(color: context.echoColors.controlBoundary),
        ),
        child: Padding(
          padding: EdgeInsets.all(context.echoSpacing.sm),
          child: Row(
            children: <Widget>[
              Icon(
                AppIcons.wifiOff,
                size: 20,
                color: context.echoColors.warning,
              ),
              SizedBox(width: context.echoSpacing.xs),
              Expanded(
                child: Text(message, style: context.echoTypography.body),
              ),
              SizedBox(width: context.echoSpacing.xs),
              EchoButton.ghost(label: '重试', onPressed: onRetry),
            ],
          ),
        ),
      ),
    );
  }
}
