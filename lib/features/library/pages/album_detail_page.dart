import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../widgets/cover_art_image.dart';

/// 专辑详情页
class AlbumDetailPage extends ConsumerWidget {
  final String albumId;

  const AlbumDetailPage({super.key, required this.albumId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albumDetailAsync = ref.watch(albumDetailProvider(albumId));

    return Scaffold(
      body: albumDetailAsync.when(
        data: (albumDetail) {
          if (albumDetail == null) {
            return const Center(child: Text('专辑不存在'));
          }

          final album = albumDetail.album;
          final songs = albumDetail.songs;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    album.name,
                    style: const TextStyle(
                      shadows: [
                        Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 3.0,
                          color: Colors.black45,
                        ),
                      ],
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      CoverArtImage(
                        coverArtId: album.coverArt,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (album.artist != null)
                        Text(
                          album.artist!,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      const SizedBox(height: 4),
                      Text(
                        '${album.songCount} 首 · ${album.durationString}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          FilledButton.icon(
                            onPressed: () {
                              // 播放全部
                              ref.read(playerProvider.notifier).playQueue(songs);
                            },
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('播放全部'),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () async {
                              try {
                                final musicRepository = ref.read(musicRepositoryProvider);
                                await musicRepository.setAlbumStarred(
                                  album.id,
                                  !album.starred,
                                );
                                // 刷新专辑详情和收藏列表
                                ref.invalidate(albumDetailProvider(albumId));
                                ref.invalidate(starredProvider);
                                ref.invalidate(recentAlbumsProvider);
                                ref.invalidate(frequentAlbumsProvider);
                              } catch (e) {
                                // 显示错误提示
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('操作失败: $e')),
                                  );
                                }
                              }
                            },
                            icon: Icon(
                              album.starred ? Icons.favorite : Icons.favorite_border,
                              color: album.starred ? Colors.red : null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final song = songs[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${song.track ?? index + 1}'),
                      ),
                      title: Text(song.title),
                      subtitle: song.artist != null ? Text(song.artist!) : null,
                      trailing: Text(song.durationString),
                      onTap: () {
                        // 播放歌曲
                        ref.read(playerProvider.notifier).playQueue(
                              songs,
                              startIndex: index,
                            );
                      },
                    );
                  },
                  childCount: songs.length,
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
