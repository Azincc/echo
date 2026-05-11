import 'package:flutter/material.dart';
import 'package:echoes/core/theme/app_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/navigation_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../widgets/cover_art_image.dart';
import '../../../widgets/main_scaffold.dart';
import '../../../widgets/music_chrome.dart';
import '../../../widgets/visible_remote_retry_scope.dart';
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
  Widget build(BuildContext context) {
    final randomSongsLoadFailed = ref.watch(randomSongsLoadFailedProvider);
    final newestAlbumsLoadFailed = ref.watch(newestAlbumsLoadFailedProvider);
    final recentAlbumsLoadFailed = ref.watch(recentAlbumsLoadFailedProvider);
    final frequentAlbumsLoadFailed = ref.watch(
      frequentAlbumsLoadFailedProvider,
    );

    return VisibleRemoteRetryScope(
      branchIndex: discoverBranchIndex,
      debugLabel: 'discover_page',
      shouldRetry: (ref) =>
          randomSongsLoadFailed ||
          newestAlbumsLoadFailed ||
          recentAlbumsLoadFailed ||
          frequentAlbumsLoadFailed ||
          ref.read(randomSongsProvider).hasError ||
          ref.read(newestAlbumsProvider).hasError ||
          ref.read(recentAlbumsProvider).hasError ||
          ref.read(frequentAlbumsProvider).hasError,
      onRetry: (ref) {
        ref.invalidate(randomSongsProvider);
        ref.invalidate(newestAlbumsProvider);
        ref.invalidate(recentAlbumsProvider);
        ref.invalidate(frequentAlbumsProvider);
      },
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(randomSongsProvider);
              ref.invalidate(newestAlbumsProvider);
              ref.invalidate(recentAlbumsProvider);
              ref.invalidate(frequentAlbumsProvider);
            },
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: MusicChrome.maxContentWidth,
                ),
                child: ListView(
                  cacheExtent: 1500,
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                  children: [
                    MusicPageHeader(
                      padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
                      title: '音乐流',
                      subtitle: '从你的资料库里继续发现熟悉和意外的声音',
                      leading: MusicIconButton(
                        icon: AppIcons.menu,
                        tooltip: '菜单',
                        onPressed: () => scaffoldKey.currentState?.openDrawer(),
                      ),
                      actions: [
                        MusicIconButton(
                          icon: AppIcons.search,
                          tooltip: '搜索',
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
                    const MusicSectionHeader(
                      title: '随机推荐',
                      subtitle: '快速开始一组来自资料库的歌曲',
                    ),
                    const RandomSongsSection(),
                    const MusicSectionHeader(title: '最近入库', subtitle: '新加入的专辑'),
                    const NewestAlbumsSection(),
                    const MusicSectionHeader(
                      title: '最近播放',
                      subtitle: '接着听你停下的地方',
                    ),
                    const RecentAlbumsSection(),
                    const MusicSectionHeader(
                      title: '经常听的专辑',
                      subtitle: '资料库里的高频回访',
                    ),
                    const FrequentAlbumsSection(),
                  ],
                ),
              ),
            ),
          ),
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

        // 根据屏幕宽度计算列数：手机2列，平板及以上3列
        final screenWidth = MediaQuery.of(context).size.width;
        final crossAxisCount = screenWidth >= 600 ? 3 : 2;

        return Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisExtent: 74,
                crossAxisSpacing: 12,
                mainAxisSpacing: 8,
              ),
              itemCount: displayCount,
              itemBuilder: (context, index) {
                final song = songs[index];
                return Material(
                  color: colorScheme.surfaceContainerLow.withValues(
                    alpha: Theme.of(context).brightness == Brightness.dark
                        ? 0.7
                        : 0.9,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      ref
                          .read(playerProvider.notifier)
                          .playQueue(songs, startIndex: index);
                    },
                    onLongPress: () {
                      showSongOptionsSheet(context: context, song: song);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CoverArtImage(
                              coverArtId: song.coverArt,
                              size: 52,
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
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    color: titleColor,
                                  ),
                                ),
                                const SizedBox(height: 3),
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
                          Icon(
                            AppIcons.play_arrow_rounded,
                            size: 20,
                            color: colorScheme.primary.withValues(alpha: 0.9),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            if (songs.length > 6)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                  icon: Icon(
                    _expanded
                        ? AppIcons.keyboard_arrow_up
                        : AppIcons.keyboard_arrow_down,
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
          height: 226,
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

        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return SizedBox(
                height: 226,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: albums.length,
                  itemBuilder: (context, index) {
                    final album = albums[index];
                    return AlbumCard(album: album);
                  },
                ),
              );
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 190,
                childAspectRatio: 0.72,
                crossAxisSpacing: 16,
                mainAxisSpacing: 18,
              ),
              itemCount: albums.length > 6 ? 6 : albums.length,
              itemBuilder: (context, index) {
                final album = albums[index];
                return AlbumGridItem(album: album);
              },
            );
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
          height: 226,
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
      width: 156,
      margin: const EdgeInsets.only(right: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
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
            Container(
              width: 156,
              height: 156,
              decoration: BoxDecoration(
                borderRadius: MusicChrome.albumRadius,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: Theme.of(context).brightness == Brightness.dark
                          ? 0.22
                          : 0.12,
                    ),
                    blurRadius: 14,
                    offset: const Offset(0, 7),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: MusicChrome.albumRadius,
                child: CoverArtImage(coverArtId: album.coverArt, size: 156),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              album.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.w700, color: titleColor),
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
              borderRadius: MusicChrome.albumRadius,
              child: CoverArtImage(
                coverArtId: album.coverArt,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            album.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.w700, color: titleColor),
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
