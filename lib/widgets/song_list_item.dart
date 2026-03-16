import 'package:flutter/material.dart';

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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final artist = song.artist?.trim();
    final artistText = artist != null && artist.isNotEmpty ? artist : '-';

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: contentPadding,
        child: Row(
          children: [
            _buildLeading(context),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    artistText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              song.durationString,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        );
      case SongListItemVariant.standard:
        return ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: CoverArtImage(
            coverArtId: coverArtId ?? song.coverArt,
            size: _coverSize,
          ),
        );
    }
  }
}
