import 'package:flutter/material.dart';

import '../core/design/echo_design.dart';
import '../data/models/song.dart';
import 'cover_art_image.dart';

enum SongListItemVariant { albumTrack, standard }

class SongListItem extends StatelessWidget {
  static const double _coverSize = 48;
  static const double _albumTrackWidth = 32;

  final Song song;
  final int index;
  final SongListItemVariant variant;
  final String? coverArtId;
  final EdgeInsetsGeometry contentPadding;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const SongListItem({
    super.key,
    required this.song,
    required this.index,
    required this.variant,
    this.coverArtId,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final artist = song.artist?.trim();
    final artistText = artist != null && artist.isNotEmpty ? artist : '-';
    final semanticLabel = <String>[
      song.title,
      artistText,
      song.durationString,
    ].join('，');

    return EchoPressable(
      semanticLabel: semanticLabel,
      onPressed: onTap,
      onLongPress: onLongPress,
      minimumSize: const Size(double.infinity, 64),
      borderRadius: context.echoRadii.control,
      child: Padding(
        padding: contentPadding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildLeading(context),
            SizedBox(width: context.echoSpacing.sm),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(song.title, style: context.echoTypography.title),
                  SizedBox(height: context.echoSpacing.xxs),
                  Wrap(
                    spacing: context.echoSpacing.xs,
                    runSpacing: context.echoSpacing.xxs,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      Text(
                        artistText,
                        style: context.echoTypography.body.copyWith(
                          color: context.echoColors.muted,
                        ),
                      ),
                      Text(
                        song.durationString,
                        style: context.echoTypography.metadata.copyWith(
                          color: context.echoColors.muted,
                          fontFeatures: const <FontFeature>[
                            FontFeature.tabularFigures(),
                          ],
                        ),
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

  Widget _buildLeading(BuildContext context) {
    switch (variant) {
      case SongListItemVariant.albumTrack:
        final trackNumber = song.track ?? index + 1;
        return SizedBox(
          width: _albumTrackWidth,
          child: Text(
            '$trackNumber',
            textAlign: TextAlign.center,
            style: context.echoTypography.metadata.copyWith(
              color: context.echoColors.muted,
              fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
            ),
          ),
        );
      case SongListItemVariant.standard:
        return ClipRRect(
          borderRadius: context.echoRadii.detail,
          child: CoverArtImage(
            coverArtId: coverArtId ?? song.coverArt,
            size: _coverSize,
            requestSize: 192,
            semanticLabel: '${song.title} 封面',
          ),
        );
    }
  }
}
