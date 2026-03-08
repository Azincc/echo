import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/api_provider.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../widgets/cover_art_image.dart';
import '../../../widgets/main_scaffold.dart';
import '../../library/pages/album_detail_page.dart';
import '../../player/widgets/song_options_sheet.dart';
import 'search_page.dart';
import '../../../widgets/error_placeholder.dart';
import '../../../widgets/skeleton_templates.dart';

/// 音乐流首页 - Tab 1
class DiscoverPage extends ConsumerStatefulWidget {
  const DiscoverPage({super.key});

  @override
  ConsumerState<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends ConsumerState<DiscoverPage> {
  @override
  void initState() {
    super.initState();
    // 监听地址变化：离线→在线时自动刷新首页数据
    ref.listenManual(activeAddressProvider, (previous, next) {
      if (previous == null && next != null) {
        ref.invalidate(randomSongsProvider);
        ref.invalidate(newestAlbumsProvider);
        ref.invalidate(recentAlbumsProvider);
        ref.invalidate(frequentAlbumsProvider);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // 使用 GlobalKey 打开侧栏
            scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: const Text('音乐流'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // 刷新数据
          ref.invalidate(randomSongsProvider);
          ref.invalidate(newestAlbumsProvider);
          ref.invalidate(recentAlbumsProvider);
          ref.invalidate(frequentAlbumsProvider);
        },
        child: ListView(
          cacheExtent: 1500, // 保持更多离屏内容，避免频繁重建
          padding: const EdgeInsets.all(16),
          children: [
            // 随机推荐
            const SectionHeader(title: '随机推荐', icon: Icons.shuffle),
            const SizedBox(height: 12),
            const RandomSongsSection(),
            const SizedBox(height: 24),

            // 最近入库的专辑
            const SectionHeader(title: '最近入库', icon: Icons.library_add),
            const SizedBox(height: 12),
            const NewestAlbumsSection(),
            const SizedBox(height: 24),

            // 最近播放的专辑
            const SectionHeader(title: '最近播放', icon: Icons.history),
            const SizedBox(height: 12),
            const RecentAlbumsSection(),
            const SizedBox(height: 24),

            // 常听的专辑
            const SectionHeader(title: '经常听的专辑', icon: Icons.whatshot),
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
  final IconData icon;
  final VoidCallback? onViewAll;

  const SectionHeader({
    super.key,
    required this.title,
    required this.icon,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary, size: 24),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        if (onViewAll != null)
          TextButton(onPressed: onViewAll, child: const Text('查看全部')),
      ],
    );
  }
}

/// 随机歌曲区块
class RandomSongsSection extends ConsumerStatefulWidget {
  const RandomSongsSection({super.key});

  @override
  ConsumerState<RandomSongsSection> createState() => _RandomSongsSectionState();
}

class _RandomSongsSectionState extends ConsumerState<RandomSongsSection> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final randomSongsAsync = ref.watch(randomSongsProvider);
    final loadFailed = ref.watch(randomSongsLoadFailedProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDarkMode ? Colors.white : colorScheme.onSurface;
    final subtitleColor = isDarkMode
        ? Colors.white.withValues(alpha: 0.78)
        : colorScheme.onSurfaceVariant;

    return randomSongsAsync.when(
      data: (songs) {
        if (songs.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(loadFailed ? '网络异常，随机歌曲加载失败' : '暂无歌曲'),
            ),
          );
        }

        final displayCount = _expanded
            ? songs.length
            : (songs.length > 6 ? 6 : songs.length);

        return Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.8,
                crossAxisSpacing: 12,
                mainAxisSpacing: 8,
              ),
              itemCount: displayCount,
              itemBuilder: (context, index) {
                final song = songs[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    ref
                        .read(playerProvider.notifier)
                        .playQueue(songs, startIndex: index);
                  },
                  onLongPress: () {
                    showSongOptionsSheet(context: context, song: song);
                  },
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: CoverArtImage(
                          coverArtId: song.coverArt,
                          size: 48,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              song.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: titleColor,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              song.artist ?? 'Unknown Artist',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11,
                                color: subtitleColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            if (songs.length > 6)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                  icon: Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 18,
                  ),
                  label: Text(_expanded ? '收起' : '更多歌曲'),
                ),
              ),
          ],
        );
      },
      loading: () => const SongGridSkeleton(),
      error: (error, stack) =>
          const ErrorPlaceholder(message: '随机歌曲加载失败，请检查网络后重试'),
    );
  }
}

/// 最近播放专辑区块
class RecentAlbumsSection extends ConsumerWidget {
  const RecentAlbumsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentAlbumsAsync = ref.watch(recentAlbumsProvider);
    final loadFailed = ref.watch(recentAlbumsLoadFailedProvider);

    return recentAlbumsAsync.when(
      data: (albums) {
        if (albums.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(loadFailed ? '网络异常，最近专辑加载失败' : '暂无最近播放'),
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
      loading: () => const AlbumCarouselSkeleton(),
      error: (error, stack) =>
          const ErrorPlaceholder(message: '最近播放加载失败，请检查网络后重试'),
    );
  }
}

/// 常听专辑区块
class FrequentAlbumsSection extends ConsumerWidget {
  const FrequentAlbumsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final frequentAlbumsAsync = ref.watch(frequentAlbumsProvider);
    final loadFailed = ref.watch(frequentAlbumsLoadFailedProvider);

    return frequentAlbumsAsync.when(
      data: (albums) {
        if (albums.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(loadFailed ? '网络异常，常听专辑加载失败' : '暂无常听专辑'),
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
      loading: () => const AlbumGridSkeleton(),
      error: (error, stack) =>
          const ErrorPlaceholder(message: '常听专辑加载失败，请检查网络后重试'),
    );
  }
}

/// 最近入库专辑区块
class NewestAlbumsSection extends ConsumerWidget {
  const NewestAlbumsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newestAlbumsAsync = ref.watch(newestAlbumsProvider);
    final loadFailed = ref.watch(newestAlbumsLoadFailedProvider);

    return newestAlbumsAsync.when(
      data: (albums) {
        if (albums.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(loadFailed ? '网络异常，最近入库加载失败' : '暂无最近入库'),
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
      loading: () => const AlbumCarouselSkeleton(),
      error: (error, stack) =>
          const ErrorPlaceholder(message: '最近入库加载失败，请检查网络后重试'),
    );
  }
}

/// 专辑卡片（横向滚动）
class AlbumCard extends StatelessWidget {
  final dynamic album; // Album 类型

  const AlbumCard({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDarkMode ? Colors.white : colorScheme.onSurface;
    final subtitleColor = isDarkMode
        ? Colors.white.withValues(alpha: 0.78)
        : colorScheme.onSurfaceVariant;

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
              child: CoverArtImage(coverArtId: album.coverArt, size: 140),
            ),
            const SizedBox(height: 8),
            Text(
              album.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.w500, color: titleColor),
            ),
            if (album.artist != null)
              Text(
                album.artist!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: subtitleColor),
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
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDarkMode ? Colors.white : colorScheme.onSurface;
    final subtitleColor = isDarkMode
        ? Colors.white.withValues(alpha: 0.78)
        : colorScheme.onSurfaceVariant;

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
            style: TextStyle(fontWeight: FontWeight.w500, color: titleColor),
          ),
          if (album.artist != null)
            Text(
              album.artist!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: subtitleColor),
            ),
        ],
      ),
    );
  }
}
