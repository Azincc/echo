import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/album.dart';
import '../../../data/models/song.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/navigation_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../widgets/cover_art_image.dart';
import '../widgets/album_options_sheet.dart';
import '../../player/widgets/song_options_sheet.dart';
import 'album_detail_page.dart';
import '../../../widgets/error_placeholder.dart';
import '../../../widgets/song_list_item.dart';
import '../../../widgets/skeleton_templates.dart';
import '../../../widgets/visible_remote_retry_scope.dart';

/// 歌手详情页
class ArtistDetailPage extends ConsumerWidget {
  final String artistId;

  const ArtistDetailPage({super.key, required this.artistId});

  void _showSongSourceInfo(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('歌曲来源说明'),
        content: const Text('当前歌手歌曲来源为该歌手作为专辑艺术家的专辑下的所有歌曲，可能出现错漏。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('知道了'),
          ),
        ],
      ),
    );
  }

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
    final loadFailed = ref.watch(artistDetailLoadFailedProvider(artistId));
    final currentArtistName = artistDetailAsync.valueOrNull?.artist.name;
    final topSongsLoadFailed = currentArtistName == null
        ? false
        : ref.watch(topSongsByArtistLoadFailedProvider(currentArtistName));

    return VisibleRemoteRetryScope(
      branchIndex: libraryBranchIndex,
      debugLabel: 'artist_detail_page',
      shouldRetry: (ref) =>
          loadFailed || artistDetailAsync.hasError || topSongsLoadFailed,
      onRetry: (ref) {
        ref.invalidate(artistDetailProvider(artistId));
        if (currentArtistName != null && currentArtistName.isNotEmpty) {
          ref.invalidate(topSongsByArtistProvider(currentArtistName));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('歌手详情'),
          actions: [
            IconButton(
              tooltip: '歌曲来源说明',
              onPressed: () => _showSongSourceInfo(context),
              icon: const Icon(Icons.info_outline),
            ),
          ],
        ),
        body: artistDetailAsync.when(
          data: (artistDetail) {
            if (artistDetail == null) {
              return const Center(child: Text('歌手不存在'));
            }

            final artist = artistDetail.artist;
            final albums = artistDetail.albums;
            final songs = artistDetail.songs;

            return Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: DefaultTabController(
                  length: 2,
                  child: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        // 歌手头像 + 名称 + 统计信息（可滚动消失）
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                    IconButton(
                                      tooltip: artist.starred
                                          ? '取消收藏歌手'
                                          : '收藏歌手',
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
                                        color: artist.starred
                                            ? Colors.red
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${songs.length} 首歌曲 · ${albums.length} 张专辑',
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
                        // TabBar（吸顶固定）
                        SliverOverlapAbsorber(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                context,
                              ),
                          sliver: SliverPersistentHeader(
                            pinned: true,
                            delegate: _SliverTabBarDelegate(
                              TabBar(
                                tabs: const [
                                  Tab(text: '歌曲'),
                                  Tab(text: '专辑'),
                                ],
                                labelColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                                unselectedLabelColor: Theme.of(
                                  context,
                                ).colorScheme.onSurface,
                                indicatorColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                              ),
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                        ),
                      ];
                    },
                    body: TabBarView(
                      children: [
                        _buildSongsTab(artist.name, songs),
                        _buildAlbumsTab(context, ref, albums),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          loading: () => const ArtistDetailSkeleton(),
          error: (error, stack) =>
              const ErrorPlaceholder(message: '歌手详情加载失败，请检查网络后重试'),
        ),
      ),
    );
  }

  /// 歌曲 Tab
  Widget _buildSongsTab(String artistName, List<Song> songs) {
    return _ArtistSongsTab(artistName: artistName, songs: songs);
  }

  /// 专辑 Tab
  Widget _buildAlbumsTab(
    BuildContext context,
    WidgetRef ref,
    List<Album> albums,
  ) {
    if (albums.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.album_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            const Text('暂无专辑'),
          ],
        ),
      );
    }

    return Builder(
      builder: (context) {
        return CustomScrollView(
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 180,
                  childAspectRatio: 0.75,
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
    );
  }
}

class _ArtistSongsTab extends ConsumerStatefulWidget {
  final String artistName;
  final List<Song> songs;

  const _ArtistSongsTab({required this.artistName, required this.songs});

  @override
  ConsumerState<_ArtistSongsTab> createState() => _ArtistSongsTabState();
}

class _ArtistSongsTabState extends ConsumerState<_ArtistSongsTab> {
  static const int _topSongsPreviewCount = 5;
  bool _showAllTopSongs = false;

  @override
  Widget build(BuildContext context) {
    final topSongsAsync = ref.watch(
      topSongsByArtistProvider(widget.artistName),
    );

    return Builder(
      builder: (context) {
        return CustomScrollView(
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverToBoxAdapter(
              child: topSongsAsync.when(
                data: (topSongs) {
                  if (topSongs.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  final visibleTopSongs =
                      _showAllTopSongs ||
                          topSongs.length <= _topSongsPreviewCount
                      ? topSongs
                      : topSongs.take(_topSongsPreviewCount).toList();

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.whatshot),
                            const SizedBox(width: 8),
                            Text(
                              '热门歌曲 (${topSongs.length})',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            if (topSongs.length > _topSongsPreviewCount)
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _showAllTopSongs = !_showAllTopSongs;
                                  });
                                },
                                child: Text(_showAllTopSongs ? '收起' : '显示所有'),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ...List.generate(visibleTopSongs.length, (index) {
                          final song = visibleTopSongs[index];
                          final queueIndex = topSongs.indexWhere(
                            (item) => item.id == song.id,
                          );
                          return SongListItem(
                            song: song,
                            index: index,
                            variant: SongListItemVariant.standard,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                            onTap: () {
                              ref
                                  .read(playerProvider.notifier)
                                  .playQueue(
                                    topSongs,
                                    startIndex: queueIndex >= 0
                                        ? queueIndex
                                        : index,
                                  );
                            },
                            onLongPress: () {
                              showSongOptionsSheet(
                                context: context,
                                song: song,
                              );
                            },
                          );
                        }),
                      ],
                    ),
                  );
                },
                loading: () => const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: LinearProgressIndicator(),
                ),
                error: (error, stack) => const SizedBox.shrink(),
              ),
            ),
            if (widget.songs.isEmpty)
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.music_off, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      const Text('暂无歌曲'),
                    ],
                  ),
                ),
              )
            else ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.library_music),
                      const SizedBox(width: 8),
                      Text(
                        '所有歌曲 (${widget.songs.length})',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      TextButton.icon(
                        onPressed: () => ref
                            .read(playerProvider.notifier)
                            .playQueue(widget.songs),
                        icon: const Icon(Icons.play_arrow, size: 18),
                        label: const Text('播放全部'),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final song = widget.songs[index];
                  return SongListItem(
                    song: song,
                    index: index,
                    variant: SongListItemVariant.standard,
                    onTap: () {
                      ref
                          .read(playerProvider.notifier)
                          .playQueue(widget.songs, startIndex: index);
                    },
                    onLongPress: () {
                      showSongOptionsSheet(context: context, song: song);
                    },
                  );
                }, childCount: widget.songs.length),
              ),
            ],
          ],
        );
      },
    );
  }
}

/// TabBar 吸顶代理
class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final Color color;

  _SliverTabBarDelegate(this.tabBar, {required this.color});

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: color, child: tabBar);
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar || color != oldDelegate.color;
  }
}
