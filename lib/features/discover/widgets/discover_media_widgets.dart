import 'package:flutter/material.dart';

import '../../../core/design/echo_design.dart';
import '../../../data/models/album.dart';
import '../../../data/models/song.dart';
import '../../../widgets/cover_art_image.dart';
import '../../../widgets/song_list_item.dart';
import '../../library/widgets/library_collection_components.dart';

class DiscoverSongTile extends StatelessWidget {
  const DiscoverSongTile({
    super.key,
    required this.song,
    required this.onPressed,
    required this.onOpenActions,
    this.onLongPress,
  });

  final Song song;
  final VoidCallback onPressed;
  final VoidCallback onOpenActions;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 72),
      child: EchoSongRow(
        song: song,
        contentPadding: EdgeInsets.symmetric(vertical: context.echoSpacing.xxs),
        onPressed: onPressed,
        onLongPress: onLongPress ?? onOpenActions,
        onMorePressed: onOpenActions,
        moreSemanticLabel: '${song.title} 操作',
      ),
    );
  }
}

class DiscoverAlbumTile extends StatelessWidget {
  const DiscoverAlbumTile({
    super.key,
    required this.album,
    required this.onPressed,
    required this.width,
    this.onLongPress,
  });

  final Album album;
  final VoidCallback onPressed;
  final double width;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: EchoAlbumTile(
        album: album,
        onPressed: onPressed,
        onLongPress: onLongPress,
      ),
    );
  }
}

class DiscoverRecentAlbumRail extends StatelessWidget {
  const DiscoverRecentAlbumRail({
    super.key,
    required this.albums,
    required this.onAlbumPressed,
    this.onAlbumLongPress,
  });

  final List<Album> albums;
  final ValueChanged<Album> onAlbumPressed;
  final ValueChanged<Album>? onAlbumLongPress;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final scale = MediaQuery.textScalerOf(
          context,
        ).scale(1).clamp(1.0, 2.0).toDouble();
        if (scale > 1.3) {
          return Column(
            key: const Key('discover-recent-spotlight'),
            children: <Widget>[
              for (final album in albums)
                EchoAlbumRow(
                  album: album,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: context.echoSpacing.xs,
                  ),
                  onPressed: () => onAlbumPressed(album),
                  onLongPress: onAlbumLongPress == null
                      ? null
                      : () => onAlbumLongPress!(album),
                ),
            ],
          );
        }

        final maximumWidth = constraints.maxWidth < 360
            ? constraints.maxWidth
            : 360.0;
        final minimumWidth = constraints.maxWidth < 260
            ? constraints.maxWidth
            : constraints.maxWidth < 330
            ? 240.0
            : 280.0;
        final targetWidth = constraints.maxWidth * 0.88;
        final cardWidth = targetWidth
            .clamp(minimumWidth, maximumWidth)
            .toDouble();
        final cardHeight = 152 + (scale - 1) * 72;

        return SizedBox(
          key: const Key('discover-recent-spotlight'),
          height: cardHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: albums.length,
            separatorBuilder: (context, index) =>
                SizedBox(width: context.echoSpacing.sm),
            itemBuilder: (context, index) {
              final album = albums[index];
              return DiscoverRecentAlbumCard(
                album: album,
                width: cardWidth,
                height: cardHeight,
                onPressed: () => onAlbumPressed(album),
                onLongPress: onAlbumLongPress == null
                    ? null
                    : () => onAlbumLongPress!(album),
              );
            },
          ),
        );
      },
    );
  }
}

class DiscoverRecentAlbumCard extends StatelessWidget {
  const DiscoverRecentAlbumCard({
    super.key,
    required this.album,
    required this.width,
    required this.height,
    required this.onPressed,
    this.onLongPress,
  });

  final Album album;
  final double width;
  final double height;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final artist = album.artist?.trim();
    final scale = MediaQuery.textScalerOf(context).scale(1);
    final artworkSize = scale > 1.3 ? 88.0 : 112.0;
    final semanticLabel = <String>[
      '最近播放专辑 ${album.name}',
      if (artist != null && artist.isNotEmpty) artist,
      '${album.songCount} 首歌曲',
    ].join('，');
    final metadata = <String>[
      if (artist != null && artist.isNotEmpty) artist,
      '${album.songCount} 首歌曲',
    ].join('，');

    return SizedBox(
      width: width,
      height: height,
      child: EchoPressable(
        semanticLabel: semanticLabel,
        onPressed: onPressed,
        onLongPress: onLongPress,
        minimumSize: Size(width, height),
        borderRadius: context.echoRadii.surface,
        child: Ink(
          decoration: BoxDecoration(
            color: context.echoColors.surface,
            borderRadius: context.echoRadii.surface,
            border: Border.all(color: context.echoColors.divider),
          ),
          child: Padding(
            padding: EdgeInsets.all(context.echoSpacing.sm),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: context.echoRadii.surface,
                  child: CoverArtImage(
                    coverArtId: album.coverArt,
                    size: artworkSize,
                    requestSize: 320,
                    fit: BoxFit.cover,
                    semanticLabel: '${album.name} 封面',
                  ),
                ),
                SizedBox(width: context.echoSpacing.sm),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            AppIcons.history,
                            size: 16,
                            color: context.echoColors.accent,
                          ),
                          SizedBox(width: context.echoSpacing.xxs),
                          Expanded(
                            child: Text(
                              '最近听过',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.echoTypography.label.copyWith(
                                color: context.echoColors.accent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.echoSpacing.xs),
                      Text(
                        album.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.echoTypography.title,
                      ),
                      SizedBox(height: context.echoSpacing.xxs),
                      Text(
                        metadata,
                        maxLines: scale > 1.3 ? 2 : 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.echoTypography.metadata.copyWith(
                          color: context.echoColors.muted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DiscoverAlbumRail extends StatelessWidget {
  const DiscoverAlbumRail({
    super.key,
    required this.albums,
    required this.onAlbumPressed,
    this.onAlbumLongPress,
  });

  final List<Album> albums;
  final ValueChanged<Album> onAlbumPressed;
  final ValueChanged<Album>? onAlbumLongPress;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final scale = MediaQuery.textScalerOf(
          context,
        ).scale(1).clamp(1.0, 2.0).toDouble();
        if (scale > 1.3) {
          return Column(
            key: const Key('discover-newest-rail'),
            children: <Widget>[
              for (final album in albums)
                EchoAlbumRow(
                  album: album,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: context.echoSpacing.xs,
                  ),
                  onPressed: () => onAlbumPressed(album),
                  onLongPress: onAlbumLongPress == null
                      ? null
                      : () => onAlbumLongPress!(album),
                ),
            ],
          );
        }

        final tileWidth = constraints.maxWidth < 400 ? 132.0 : 148.0;
        final tileHeight = tileWidth + 104 + (scale - 1) * 112;

        return SizedBox(
          key: const Key('discover-newest-rail'),
          height: tileHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: albums.length,
            separatorBuilder: (context, index) =>
                SizedBox(width: context.echoSpacing.sm),
            itemBuilder: (context, index) {
              final album = albums[index];
              return DiscoverAlbumTile(
                album: album,
                width: tileWidth,
                onPressed: () => onAlbumPressed(album),
                onLongPress: onAlbumLongPress == null
                    ? null
                    : () => onAlbumLongPress!(album),
              );
            },
          ),
        );
      },
    );
  }
}

class DiscoverFrequentAlbumShelf extends StatelessWidget {
  const DiscoverFrequentAlbumShelf({
    super.key,
    required this.albums,
    required this.onAlbumPressed,
    this.onAlbumLongPress,
  });

  final List<Album> albums;
  final ValueChanged<Album> onAlbumPressed;
  final ValueChanged<Album>? onAlbumLongPress;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final scale = MediaQuery.textScalerOf(
          context,
        ).scale(1).clamp(1.0, 2.0).toDouble();
        final useAccessibleList = scale >= 1.3 || constraints.maxWidth < 280;

        if (useAccessibleList) {
          return Column(
            key: const Key('discover-frequent-shelf'),
            children: <Widget>[
              for (final album in albums)
                EchoAlbumRow(
                  album: album,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: context.echoSpacing.xs,
                  ),
                  onPressed: () => onAlbumPressed(album),
                  onLongPress: onAlbumLongPress == null
                      ? null
                      : () => onAlbumLongPress!(album),
                ),
            ],
          );
        }

        final maximumWidth = constraints.maxWidth < 340
            ? constraints.maxWidth
            : 340.0;
        final minimumWidth = constraints.maxWidth < 280
            ? constraints.maxWidth
            : 280.0;
        final tileWidth = (constraints.maxWidth * 0.86)
            .clamp(minimumWidth, maximumWidth)
            .toDouble();
        final itemHeight = 104 + (scale - 1) * 80;
        final groupCount = (albums.length + 1) ~/ 2;

        return SizedBox(
          key: const Key('discover-frequent-shelf'),
          height: itemHeight * 2 + context.echoSpacing.sm,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: groupCount,
            separatorBuilder: (context, index) =>
                SizedBox(width: context.echoSpacing.md),
            itemBuilder: (context, groupIndex) {
              final start = groupIndex * 2;
              final end = (start + 2).clamp(0, albums.length);
              return _DiscoverFrequentAlbumGroup(
                key: ValueKey<String>('discover-frequent-group-$groupIndex'),
                albums: albums.sublist(start, end),
                width: tileWidth,
                onAlbumPressed: onAlbumPressed,
                onAlbumLongPress: onAlbumLongPress,
              );
            },
          ),
        );
      },
    );
  }
}

class _DiscoverFrequentAlbumGroup extends StatelessWidget {
  const _DiscoverFrequentAlbumGroup({
    super.key,
    required this.albums,
    required this.width,
    required this.onAlbumPressed,
    this.onAlbumLongPress,
  });

  final List<Album> albums;
  final double width;
  final ValueChanged<Album> onAlbumPressed;
  final ValueChanged<Album>? onAlbumLongPress;

  @override
  Widget build(BuildContext context) {
    final spacing = context.echoSpacing;
    final radius = context.echoRadii.surface;
    return SizedBox(
      width: width,
      child: Semantics(
        container: true,
        explicitChildNodes: true,
        child: ClipRRect(
          borderRadius: radius,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.echoColors.surface,
              borderRadius: radius,
              border: Border.all(color: context.echoColors.divider),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: spacing.sm,
                vertical: spacing.xxs,
              ),
              child: Column(
                children: <Widget>[
                  for (
                    var index = 0;
                    index < albums.length;
                    index++
                  ) ...<Widget>[
                    if (index > 0)
                      EchoDivider(color: context.echoColors.divider),
                    Expanded(
                      child: EchoAlbumRow(
                        album: albums[index],
                        allowFullText: false,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: spacing.xs,
                        ),
                        onPressed: () => onAlbumPressed(albums[index]),
                        onLongPress: onAlbumLongPress == null
                            ? null
                            : () => onAlbumLongPress!(albums[index]),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DiscoverSectionMessage extends StatelessWidget {
  const DiscoverSectionMessage({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.onRetry,
  });

  final String title;
  final String description;
  final IconData icon;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: '$title，$description',
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.echoSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ExcludeSemantics(
              child: SizedBox.square(
                dimension: context.echoInteraction.minimumTouchTarget,
                child: Center(
                  child: Icon(icon, size: 24, color: context.echoColors.muted),
                ),
              ),
            ),
            SizedBox(width: context.echoSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ExcludeSemantics(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(title, style: context.echoTypography.title),
                        SizedBox(height: context.echoSpacing.xxs),
                        Text(
                          description,
                          style: context.echoTypography.body.copyWith(
                            color: context.echoColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (onRetry != null) ...<Widget>[
                    SizedBox(height: context.echoSpacing.xs),
                    EchoButton.ghost(
                      label: '重试',
                      leadingIcon: AppIcons.refresh,
                      onPressed: onRetry,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DiscoverSongLoading extends StatelessWidget {
  const DiscoverSongLoading({super.key, this.count = 6});

  final int count;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textScale = MediaQuery.textScalerOf(context).scale(1);
        final columns = textScale > 1.3 || constraints.maxWidth < 720 ? 1 : 2;
        final gap = context.echoSpacing.md;
        final itemWidth =
            (constraints.maxWidth - gap * (columns - 1)) / columns;

        return Wrap(
          spacing: gap,
          runSpacing: context.echoSpacing.xxs,
          children: <Widget>[
            for (var index = 0; index < count; index++)
              SizedBox(
                width: itemWidth,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 72),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: context.echoSpacing.xxs,
                    ),
                    child: Row(
                      children: <Widget>[
                        const EchoSkeleton(width: 48, height: 48),
                        SizedBox(width: context.echoSpacing.sm),
                        const Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              EchoSkeleton.line(height: 16),
                              SizedBox(height: 8),
                              EchoSkeleton.line(width: 112, height: 12),
                            ],
                          ),
                        ),
                        SizedBox(width: context.echoSpacing.sm),
                        const EchoSkeleton(width: 48, height: 48),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class DiscoverRecentAlbumLoading extends StatelessWidget {
  const DiscoverRecentAlbumLoading({super.key, this.count = 3});

  final int count;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final scale = MediaQuery.textScalerOf(
          context,
        ).scale(1).clamp(1.0, 2.0).toDouble();
        if (scale > 1.3) {
          return Column(
            children: <Widget>[
              for (var index = 0; index < count; index++)
                const _DiscoverAlbumRowSkeleton(),
            ],
          );
        }

        final maximumWidth = constraints.maxWidth < 360
            ? constraints.maxWidth
            : 360.0;
        final minimumWidth = constraints.maxWidth < 260
            ? constraints.maxWidth
            : constraints.maxWidth < 330
            ? 240.0
            : 280.0;
        final targetWidth = constraints.maxWidth * 0.88;
        final cardWidth = targetWidth
            .clamp(minimumWidth, maximumWidth)
            .toDouble();
        final cardHeight = 152 + (scale - 1) * 72;
        final artworkSize = scale > 1.3 ? 88.0 : 112.0;

        return SizedBox(
          height: cardHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: count,
            separatorBuilder: (context, index) =>
                SizedBox(width: context.echoSpacing.sm),
            itemBuilder: (context, index) => SizedBox(
              width: cardWidth,
              height: cardHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.echoColors.surface,
                  borderRadius: context.echoRadii.surface,
                  border: Border.all(color: context.echoColors.divider),
                ),
                child: Padding(
                  padding: EdgeInsets.all(context.echoSpacing.sm),
                  child: Row(
                    children: <Widget>[
                      EchoSkeleton(
                        width: artworkSize,
                        height: artworkSize,
                        borderRadius: context.echoRadii.surface,
                      ),
                      SizedBox(width: context.echoSpacing.sm),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            EchoSkeleton.line(width: 92, height: 12 * scale),
                            SizedBox(height: context.echoSpacing.sm),
                            EchoSkeleton.line(height: 16 * scale),
                            SizedBox(height: context.echoSpacing.xs),
                            EchoSkeleton.line(width: 112, height: 12 * scale),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DiscoverAlbumLoading extends StatelessWidget {
  const DiscoverAlbumLoading({super.key, this.count = 4});

  final int count;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final scale = MediaQuery.textScalerOf(
          context,
        ).scale(1).clamp(1.0, 2.0).toDouble();
        if (scale > 1.3) {
          return Column(
            children: <Widget>[
              for (var index = 0; index < count; index++)
                const _DiscoverAlbumRowSkeleton(),
            ],
          );
        }

        final width = constraints.maxWidth < 400 ? 132.0 : 148.0;
        final height = width + 104 + (scale - 1) * 112;

        return SizedBox(
          height: height,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: count,
            separatorBuilder: (context, index) =>
                SizedBox(width: context.echoSpacing.sm),
            itemBuilder: (context, index) => SizedBox(
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  EchoSkeleton(
                    width: width,
                    height: width,
                    borderRadius: context.echoRadii.control,
                  ),
                  SizedBox(height: context.echoSpacing.xs),
                  EchoSkeleton.line(height: 16 * scale),
                  SizedBox(height: context.echoSpacing.xs),
                  EchoSkeleton.line(width: 88, height: 12 * scale),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class DiscoverFrequentAlbumLoading extends StatelessWidget {
  const DiscoverFrequentAlbumLoading({super.key, this.count = 4});

  final int count;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final scale = MediaQuery.textScalerOf(
          context,
        ).scale(1).clamp(1.0, 2.0).toDouble();
        final useAccessibleList = scale >= 1.3 || constraints.maxWidth < 280;

        if (useAccessibleList) {
          return Column(
            children: <Widget>[
              for (var index = 0; index < count; index++)
                const _DiscoverAlbumRowSkeleton(),
            ],
          );
        }

        final itemHeight = 104 + (scale - 1) * 80;

        final maximumWidth = constraints.maxWidth < 340
            ? constraints.maxWidth
            : 340.0;
        final minimumWidth = constraints.maxWidth < 280
            ? constraints.maxWidth
            : 280.0;
        final tileWidth = (constraints.maxWidth * 0.86)
            .clamp(minimumWidth, maximumWidth)
            .toDouble();
        final groupCount = (count + 1) ~/ 2;

        return SizedBox(
          height: itemHeight * 2 + context.echoSpacing.sm,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: groupCount,
            separatorBuilder: (context, index) =>
                SizedBox(width: context.echoSpacing.md),
            itemBuilder: (context, groupIndex) {
              final start = groupIndex * 2;
              final groupItemCount = (count - start).clamp(0, 2);
              return SizedBox(
                width: tileWidth,
                child: ClipRRect(
                  borderRadius: context.echoRadii.surface,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.echoColors.surface,
                      borderRadius: context.echoRadii.surface,
                      border: Border.all(color: context.echoColors.divider),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.echoSpacing.sm,
                        vertical: context.echoSpacing.xxs,
                      ),
                      child: Column(
                        children: <Widget>[
                          for (
                            var itemIndex = 0;
                            itemIndex < groupItemCount;
                            itemIndex++
                          ) ...<Widget>[
                            if (itemIndex > 0)
                              EchoDivider(color: context.echoColors.divider),
                            const Expanded(child: _DiscoverAlbumRowSkeleton()),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _DiscoverAlbumRowSkeleton extends StatelessWidget {
  const _DiscoverAlbumRowSkeleton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.echoSpacing.xs),
      child: Row(
        children: <Widget>[
          EchoSkeleton(
            width: 72,
            height: 72,
            borderRadius: context.echoRadii.detail,
          ),
          SizedBox(width: context.echoSpacing.sm),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                EchoSkeleton.line(height: 16),
                SizedBox(height: 8),
                EchoSkeleton.line(width: 104, height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
