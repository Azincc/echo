import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../widgets/cover_art_image.dart';
import '../../library/pages/album_detail_page.dart';
import 'search_page.dart';

/// 音乐流首页 - Tab 1
class DiscoverPage extends ConsumerWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('音乐流'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // 刷新数据
          ref.invalidate(randomSongsProvider);
          ref.invalidate(recentAlbumsProvider);
          ref.invalidate(frequentAlbumsProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // 随机推荐
            const SectionHeader(title: '🎲 随机推荐'),
            const SizedBox(height: 12),
            const RandomSongsSection(),
            const SizedBox(height: 24),

            // 最近播放的专辑
            const SectionHeader(title: '📌 最近播放'),
            const SizedBox(height: 12),
            const RecentAlbumsSection(),
            const SizedBox(height: 24),

            // 常听的专辑
            const SectionHeader(title: '🔥 经常听的专辑'),
            const SizedBox(height: 12),
            const FrequentAlbumsSection(),
          ],
        ),
      ),
    );
  }
}

/// 区块标题
class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAll;

  const SectionHeader({
    super.key,
    required this.title,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        if (onViewAll != null)
          TextButton(
            onPressed: onViewAll,
            child: const Text('查看全部'),
          ),
      ],
    );
  }
}

/// 随机歌曲区块
class RandomSongsSection extends ConsumerWidget {
  const RandomSongsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final randomSongsAsync = ref.watch(randomSongsProvider);

    return randomSongsAsync.when(
      data: (songs) {
        if (songs.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text('暂无歌曲'),
            ),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: songs.length > 10 ? 10 : songs.length,
          itemBuilder: (context, index) {
            final song = songs[index];
            return Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  // 播放歌曲
                  ref.read(playerProvider.notifier).playQueue(
                        songs,
                        startIndex: index,
                      );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      CoverArtImage(
                        coverArtId: song.coverArt,
                        size: 40,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              song.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (song.artist != null)
                              Text(
                                song.artist!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stack) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 8),
              Text('加载失败: $error'),
            ],
          ),
        ),
      ),
    );
  }
}

/// 最近播放专辑区块
class RecentAlbumsSection extends ConsumerWidget {
  const RecentAlbumsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentAlbumsAsync = ref.watch(recentAlbumsProvider);

    return recentAlbumsAsync.when(
      data: (albums) {
        if (albums.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text('暂无最近播放'),
            ),
          );
        }

        return SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: albums.length,
            itemBuilder: (context, index) {
              final album = albums[index];
              return AlbumCard(album: album);
            },
          ),
        );
      },
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stack) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text('加载失败: $error'),
        ),
      ),
    );
  }
}

/// 常听专辑区块
class FrequentAlbumsSection extends ConsumerWidget {
  const FrequentAlbumsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final frequentAlbumsAsync = ref.watch(frequentAlbumsProvider);

    return frequentAlbumsAsync.when(
      data: (albums) {
        if (albums.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text('暂无常听专辑'),
            ),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75, // 调整比例以容纳文字
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: albums.length > 6 ? 6 : albums.length,
          itemBuilder: (context, index) {
            final album = albums[index];
            return AlbumGridItem(album: album);
          },
        );
      },
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stack) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text('加载失败: $error'),
        ),
      ),
    );
  }
}

/// 专辑卡片（横向滚动）
class AlbumCard extends StatelessWidget {
  final dynamic album; // Album 类型

  const AlbumCard({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AlbumDetailPage(albumId: album.id),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CoverArtImage(
                coverArtId: album.coverArt,
                size: 140,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              album.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w500),
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
      ),
    );
  }
}

/// 专辑网格项（网格布局）- 1:1 正方形
class AlbumGridItem extends StatelessWidget {
  final dynamic album; // Album 类型

  const AlbumGridItem({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlbumDetailPage(albumId: album.id),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 封面 - 正方形
          AspectRatio(
            aspectRatio: 1.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CoverArtImage(
                coverArtId: album.coverArt,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            album.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w500),
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
  }
}
