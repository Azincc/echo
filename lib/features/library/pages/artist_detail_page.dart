import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/music_provider.dart';
import '../../../widgets/cover_art_image.dart';
import '../widgets/album_options_sheet.dart';
import 'album_detail_page.dart';
import '../../../widgets/error_placeholder.dart';
import '../../../widgets/skeleton_templates.dart';

/// 歌手详情页
class ArtistDetailPage extends ConsumerWidget {
  final String artistId;

  const ArtistDetailPage({super.key, required this.artistId});

  Future<void> _toggleArtistStarred(
    BuildContext context,
    WidgetRef ref,
    String artistId,
    bool currentStarred,
  ) async {
    final repository = ref.read(musicRepositoryProvider);
    if (repository == null) return;

    final nextStarred = !currentStarred;
    try {
      await repository.setArtistStarred(artistId, nextStarred);
      ref.invalidate(artistDetailProvider(artistId));
      ref.invalidate(allArtistsProvider);
      ref.invalidate(starredProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(nextStarred ? '已收藏歌手' : '已取消收藏歌手')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('操作失败: $e')));
      }
    }
  }

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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              artist.name,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          IconButton(
                            tooltip: artist.starred ? '取消收藏歌手' : '收藏歌手',
                            onPressed: () => _toggleArtistStarred(
                              context,
                              ref,
                              artist.id,
                              artist.starred,
                            ),
                            icon: Icon(
                              artist.starred
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: artist.starred ? Colors.red : null,
                            ),
                          ),
                        ],
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
        loading: () => const ArtistDetailSkeleton(),
        error: (error, stack) =>
            const ErrorPlaceholder(message: '歌手详情加载失败，请检查网络后重试'),
      ),
    );
  }
}
