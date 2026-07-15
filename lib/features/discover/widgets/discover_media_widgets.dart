import 'package:flutter/material.dart';

import '../../../core/design/echo_design.dart';
import '../../../data/models/album.dart';
import '../../../data/models/artist.dart';
import '../../../data/models/song.dart';
import '../../../widgets/cover_art_image.dart';

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
    final artist = song.artist?.trim();
    final artistLabel = artist == null || artist.isEmpty ? '未知歌手' : artist;

    return EchoPressable(
      semanticLabel: '${song.title}，$artistLabel',
      onPressed: onPressed,
      onLongPress: onLongPress ?? onOpenActions,
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
                size: 48,
                requestSize: 192,
                semanticLabel: '${song.title} 封面',
              ),
            ),
            SizedBox(width: context.echoSpacing.sm),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(song.title, style: context.echoTypography.title),
                  SizedBox(height: context.echoSpacing.xxs),
                  Text(
                    artistLabel,
                    style: context.echoTypography.body.copyWith(
                      color: context.echoColors.muted,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: context.echoSpacing.xs),
            EchoIconButton(
              icon: AppIcons.more,
              label: '${song.title} 操作',
              onPressed: onOpenActions,
            ),
          ],
        ),
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
  });

  final Album album;
  final VoidCallback onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {
    final artist = album.artist?.trim();
    final scale = MediaQuery.textScalerOf(context).scale(1);

    return SizedBox(
      width: width,
      child: EchoPressable(
        semanticLabel: <String>[
          album.name,
          if (artist != null && artist.isNotEmpty) artist,
          '${album.songCount} 首歌曲',
        ].join('，'),
        onPressed: onPressed,
        minimumSize: const Size(48, 48),
        borderRadius: context.echoRadii.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
              borderRadius: context.echoRadii.surface,
              child: CoverArtImage(
                coverArtId: album.coverArt,
                size: width,
                requestSize: (width * 2).round(),
                fit: BoxFit.cover,
                semanticLabel: '${album.name} 封面',
              ),
            ),
            SizedBox(height: context.echoSpacing.xs),
            Text(
              album.name,
              maxLines: scale > 1.3 ? 3 : 2,
              overflow: TextOverflow.ellipsis,
              style: context.echoTypography.title,
            ),
            if (artist != null && artist.isNotEmpty) ...<Widget>[
              SizedBox(height: context.echoSpacing.xxs),
              Text(
                artist,
                maxLines: scale > 1.3 ? 2 : 1,
                overflow: TextOverflow.ellipsis,
                style: context.echoTypography.body.copyWith(
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

class SearchAlbumRow extends StatelessWidget {
  const SearchAlbumRow({
    super.key,
    required this.album,
    required this.onPressed,
  });

  final Album album;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final artist = album.artist?.trim();
    final metadata = <String>[
      if (artist != null && artist.isNotEmpty) artist,
      '${album.songCount} 首歌曲',
    ].join(' · ');

    return _SearchMediaRow(
      semanticLabel: '${album.name}，$metadata',
      onPressed: onPressed,
      leading: ClipRRect(
        borderRadius: context.echoRadii.detail,
        child: CoverArtImage(
          coverArtId: album.coverArt,
          size: 56,
          requestSize: 224,
          semanticLabel: '${album.name} 封面',
        ),
      ),
      title: album.name,
      subtitle: metadata,
    );
  }
}

class SearchArtistRow extends StatelessWidget {
  const SearchArtistRow({
    super.key,
    required this.artist,
    required this.onPressed,
  });

  final Artist artist;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final albumCount = artist.albumCount ?? 0;
    return _SearchMediaRow(
      semanticLabel: '${artist.name}，$albumCount 张专辑',
      onPressed: onPressed,
      leading: ClipRRect(
        borderRadius: context.echoRadii.surface,
        child: CoverArtImage(
          coverArtId: artist.coverArt,
          size: 56,
          requestSize: 224,
          semanticLabel: '${artist.name} 图片',
        ),
      ),
      title: artist.name,
      subtitle: '$albumCount 张专辑',
    );
  }
}

class _SearchMediaRow extends StatelessWidget {
  const _SearchMediaRow({
    required this.semanticLabel,
    required this.onPressed,
    required this.leading,
    required this.title,
    required this.subtitle,
  });

  final String semanticLabel;
  final VoidCallback onPressed;
  final Widget leading;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return EchoPressable(
      semanticLabel: semanticLabel,
      onPressed: onPressed,
      minimumSize: const Size(double.infinity, 72),
      borderRadius: context.echoRadii.control,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.echoSpacing.xs),
        child: Row(
          children: <Widget>[
            leading,
            SizedBox(width: context.echoSpacing.sm),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: context.echoTypography.title),
                  SizedBox(height: context.echoSpacing.xxs),
                  Text(
                    subtitle,
                    style: context.echoTypography.body.copyWith(
                      color: context.echoColors.muted,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: context.echoSpacing.xs),
            ExcludeSemantics(
              child: Icon(
                AppIcons.chevronRight,
                size: context.echoInteraction.smallIconSize,
                color: context.echoColors.muted,
              ),
            ),
          ],
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
      label: '$title，$description',
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.echoSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox.square(
              dimension: context.echoInteraction.minimumTouchTarget,
              child: Center(
                child: Icon(icon, size: 24, color: context.echoColors.muted),
              ),
            ),
            SizedBox(width: context.echoSpacing.sm),
            Expanded(
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
    return Column(
      children: List<Widget>.generate(
        count,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: context.echoSpacing.xs),
          child: Row(
            children: <Widget>[
              const EchoSkeleton(width: 48, height: 48),
              SizedBox(width: context.echoSpacing.sm),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    EchoSkeleton.line(width: 180, height: 16),
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
    );
  }
}

class DiscoverAlbumLoading extends StatelessWidget {
  const DiscoverAlbumLoading({super.key, this.count = 4});

  final int count;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width < 400 ? 128.0 : 144.0;
    return SizedBox(
      height: width + 72,
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
              EchoSkeleton(width: width, height: width),
              SizedBox(height: context.echoSpacing.xs),
              const EchoSkeleton.line(height: 16),
              SizedBox(height: context.echoSpacing.xs),
              const EchoSkeleton.line(width: 88, height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
