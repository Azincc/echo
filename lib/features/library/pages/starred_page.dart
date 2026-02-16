import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../widgets/cover_art_image.dart';
import '../../player/widgets/song_options_sheet.dart';
import '../widgets/album_options_sheet.dart';
import 'album_detail_page.dart';
import 'artist_detail_page.dart';

/// 收藏夹页面
class StarredPage extends ConsumerWidget {
  const StarredPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final starredAsync = ref.watch(starredProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('收藏夹')),
      body: starredAsync.when(
        data: (starred) {
          if (starred.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('暂无收藏'),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(starredProvider);
            },
            child: ListView(
              children: [
                // 收藏的歌曲
                if (starred.songs.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.music_note),
                        const SizedBox(width: 8),
                        Text(
                          '歌曲 (${starred.songs.length})',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: () {
                            ref
                                .read(playerProvider.notifier)
                                .playQueue(starred.songs);
                          },
                          icon: const Icon(Icons.play_arrow),
                          label: const Text('播放全部'),
                        ),
                      ],
                    ),
                  ),
                  ...starred.songs.map((song) {
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: CoverArtImage(
                          coverArtId: song.coverArt,
                          size: 48,
                        ),
                      ),
                      title: Text(song.title),
                      subtitle: song.artist != null ? Text(song.artist!) : null,
                      trailing: Text(song.durationString),
                      onTap: () {
                        ref
                            .read(playerProvider.notifier)
                            .playQueue(
                              starred.songs,
                              startIndex: starred.songs.indexOf(song),
                            );
                      },
                      onLongPress: () {
                        showSongOptionsSheet(context: context, song: song);
                      },
                    );
                  }),
                  const Divider(height: 32),
                ],

                // 收藏的专辑
                if (starred.albums.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.album),
                        const SizedBox(width: 8),
                        Text(
                          '专辑 (${starred.albums.length})',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: starred.albums.length,
                    itemBuilder: (context, index) {
                      final album = starred.albums[index];
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
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
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
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (album.artist != null)
                              Text(
                                album.artist!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 32),
                ],

                // 收藏的歌手
                if (starred.artists.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.person),
                        const SizedBox(width: 8),
                        Text(
                          '歌手 (${starred.artists.length})',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  ...starred.artists.map((artist) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: artist.coverArt != null
                            ? ClipOval(
                                child: CoverArtImage(
                                  coverArtId: artist.coverArt,
                                  size: 40,
                                ),
                              )
                            : const Icon(Icons.person),
                      ),
                      title: Text(artist.name),
                      subtitle: Text('${artist.albumCount} 张专辑'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ArtistDetailPage(artistId: artist.id),
                          ),
                        );
                      },
                    );
                  }),
                ],
              ],
            ),
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
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  ref.invalidate(starredProvider);
                },
                child: const Text('重试'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
