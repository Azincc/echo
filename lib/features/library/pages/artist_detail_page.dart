import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/music_provider.dart';
import '../../../widgets/cover_art_image.dart';
import '../widgets/album_options_sheet.dart';
import 'album_detail_page.dart';

/// 歌手详情页
class ArtistDetailPage extends ConsumerWidget {
  final String artistId;

  const ArtistDetailPage({super.key, required this.artistId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final artistDetailAsync = ref.watch(artistDetailProvider(artistId));

    return Scaffold(
      appBar: AppBar(title: const Text('歌手详情')),
      body: artistDetailAsync.when(
        data: (artistDetail) {
          if (artistDetail == null) {
            return const Center(child: Text('歌手不存在'));
          }

          final artist = artistDetail.artist;
          final albums = artistDetail.albums;

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        child: CoverArtImage(
                          coverArtId: artist.coverArt,
                          size: 120,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        artist.name,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      if (artist.albumCount != null)
                        Text(
                          '${artist.albumCount} 张专辑',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final album = albums[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AlbumDetailPage(albumId: album.id),
                          ),
                        );
                      },
                      onLongPress: () {
                        showAlbumOptionsSheet(
                          context: context,
                          ref: ref,
                          album: album,
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: 1.0,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CoverArtImage(
                                      coverArtId: album.coverArt,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                if (album.starred)
                                  Positioned(
                                    left: 6,
                                    bottom: 6,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(
                                          alpha: 0.35,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(
                                        Icons.favorite,
                                        size: 14,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            album.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          if (album.year != null)
                            Text(
                              album.year.toString(),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                        ],
                      ),
                    );
                  }, childCount: albums.length),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 16),
              Text('加载失败: $error'),
            ],
          ),
        ),
      ),
    );
  }
}
