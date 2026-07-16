import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/echo_design.dart';
import '../../../core/utils/toast_notifier.dart';
import '../../../data/models/album.dart';
import '../../../data/models/song.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/navigation_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../widgets/song_list_item.dart';
import '../../../widgets/visible_remote_retry_scope.dart';
import '../../player/widgets/song_options_sheet.dart';
import '../widgets/album_options_sheet.dart';
import '../widgets/media_detail_components.dart';
import 'album_detail_page.dart';

class ArtistDetailPage extends ConsumerStatefulWidget {
  const ArtistDetailPage({super.key, required this.artistId});

  final String artistId;

  @override
  ConsumerState<ArtistDetailPage> createState() => _ArtistDetailPageState();
}

class _ArtistDetailPageState extends ConsumerState<ArtistDetailPage> {
  static const int _topSongsPreviewCount = 5;

  int _selectedSection = 0;
  bool _showAllTopSongs = false;

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(artistDetailProvider(widget.artistId));
    final loadFailed = ref.watch(
      artistDetailLoadFailedProvider(widget.artistId),
    );
    final currentArtistName = detailAsync.valueOrNull?.artist.name;
    final topSongsLoadFailed = currentArtistName == null
        ? false
        : ref.watch(topSongsByArtistLoadFailedProvider(currentArtistName));

    return VisibleRemoteRetryScope(
      branchIndex: libraryBranchIndex,
      debugLabel: 'artist_detail_page',
      shouldRetry: (ref) =>
          loadFailed || detailAsync.hasError || topSongsLoadFailed,
      onRetry: (ref) {
        ref.invalidate(artistDetailProvider(widget.artistId));
        if (currentArtistName?.isNotEmpty == true) {
          ref.invalidate(topSongsByArtistProvider(currentArtistName!));
        }
      },
      child: EchoScaffold(
        topBar: EchoTopBar.back(
          context: context,
          title: '歌手',
          actions: <Widget>[
            EchoIconButton(
              icon: AppIcons.info,
              label: '歌曲来源说明',
              onPressed: _showSongSourceInfo,
            ),
          ],
        ),
        body: detailAsync.when(
          data: (detail) {
            if (detail == null) {
              return loadFailed
                  ? EchoErrorState(
                      title: '歌手加载失败',
                      description: '无法读取歌手详情。请检查网络后重试。',
                      actionLabel: '重试',
                      onAction: _retryArtist,
                    )
                  : const EchoEmptyState(
                      title: '歌手不存在',
                      description: '服务器没有返回这位歌手，内容可能已经被移动或删除。',
                      icon: AppIcons.people,
                    );
            }

            final artist = detail.artist;
            final albums = detail.albums;
            final songs = detail.songs;
            final topSongsAsync = ref.watch(
              topSongsByArtistProvider(artist.name),
            );

            return Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: CustomScrollView(
                  key: PageStorageKey<String>(
                    _selectedSection == 0
                        ? 'artist-detail-songs'
                        : 'artist-detail-albums',
                  ),
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: _ArtistIdentityHeader(
                        artistName: artist.name,
                        coverArtId: artist.coverArt,
                        starred: artist.starred,
                        songCount: songs.length,
                        albumCount: albums.length,
                        onToggleStarred: () =>
                            _toggleArtistStarred(artist.id, artist.starred),
                        onPlay: songs.isEmpty
                            ? null
                            : () => ref
                                  .read(playerProvider.notifier)
                                  .playQueue(songs),
                      ),
                    ),
                    if (loadFailed)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            context.echoSpacing.md,
                            context.echoSpacing.md,
                            context.echoSpacing.md,
                            0,
                          ),
                          child: MediaLoadNotice(
                            message: '网络连接异常，当前可能显示缓存的歌手内容。',
                            onRetry: _retryArtist,
                          ),
                        ),
                      ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _ArtistSectionHeaderDelegate(
                        selectedIndex: _selectedSection,
                        onSelected: (index) {
                          if (index == _selectedSection) return;
                          setState(() => _selectedSection = index);
                        },
                      ),
                    ),
                    if (_selectedSection == 0)
                      ..._buildSongSlivers(artist.name, songs, topSongsAsync)
                    else
                      ..._buildAlbumSlivers(albums),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        key: const ValueKey<String>(
                          'artist-detail-bottom-spacer',
                        ),
                        height:
                            context.echoSpacing.xxl +
                            context.echoShellBottomObstruction,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () => const MediaDetailLoadingView(circularArtwork: true),
          error: (error, stackTrace) => EchoErrorState(
            title: '歌手加载失败',
            description: '无法读取歌手详情。请检查网络后重试。',
            actionLabel: '重试',
            onAction: _retryArtist,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSongSlivers(
    String artistName,
    List<Song> songs,
    AsyncValue<List<Song>> topSongsAsync,
  ) {
    final slivers = <Widget>[
      SliverToBoxAdapter(
        child: topSongsAsync.when(
          data: (topSongs) {
            if (topSongs.isEmpty) return const SizedBox.shrink();
            final visibleSongs = _showAllTopSongs
                ? topSongs
                : topSongs.take(_topSongsPreviewCount).toList();
            return Padding(
              padding: EdgeInsets.fromLTRB(
                context.echoSpacing.md,
                context.echoSpacing.lg,
                context.echoSpacing.md,
                context.echoSpacing.xs,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  EchoSectionHeader(
                    title: '热门歌曲',
                    description: '${topSongs.length} 首来自远程热门结果',
                    actionLabel: topSongs.length > _topSongsPreviewCount
                        ? (_showAllTopSongs ? '收起' : '显示所有')
                        : null,
                    onAction: () {
                      setState(() => _showAllTopSongs = !_showAllTopSongs);
                    },
                  ),
                  SizedBox(height: context.echoSpacing.xs),
                  for (var index = 0; index < visibleSongs.length; index++)
                    SongListItem(
                      song: visibleSongs[index],
                      index: index,
                      variant: SongListItemVariant.standard,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: context.echoSpacing.xs,
                      ),
                      onTap: () {
                        final queueIndex = topSongs.indexWhere(
                          (song) => song.id == visibleSongs[index].id,
                        );
                        ref
                            .read(playerProvider.notifier)
                            .playQueue(
                              topSongs,
                              startIndex: queueIndex < 0 ? index : queueIndex,
                            );
                      },
                      onLongPress: () => showSongOptionsSheet(
                        context: context,
                        song: visibleSongs[index],
                      ),
                    ),
                ],
              ),
            );
          },
          loading: () => const _TopSongsSkeleton(),
          error: (error, stackTrace) => Padding(
            padding: EdgeInsets.fromLTRB(
              context.echoSpacing.md,
              context.echoSpacing.md,
              context.echoSpacing.md,
              0,
            ),
            child: MediaLoadNotice(
              message: '热门歌曲暂时不可用。',
              onRetry: () =>
                  ref.invalidate(topSongsByArtistProvider(artistName)),
            ),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: EchoSectionHeader(
          title: '所有歌曲',
          description: songs.isEmpty ? '没有可播放歌曲' : '${songs.length} 首',
          actionLabel: songs.isEmpty ? null : '播放全部',
          onAction: songs.isEmpty
              ? null
              : () => ref.read(playerProvider.notifier).playQueue(songs),
          padding: EdgeInsets.fromLTRB(
            context.echoSpacing.md,
            context.echoSpacing.lg,
            context.echoSpacing.md,
            context.echoSpacing.xs,
          ),
        ),
      ),
    ];

    if (songs.isEmpty) {
      slivers.add(
        const SliverToBoxAdapter(
          child: EchoEmptyState(
            title: '暂无歌曲',
            description: '服务器没有为这位歌手返回可播放歌曲。',
            icon: AppIcons.music,
            padding: EdgeInsets.all(32),
          ),
        ),
      );
    } else {
      slivers.add(
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final song = songs[index];
            return SongListItem(
              song: song,
              index: index,
              variant: SongListItemVariant.standard,
              onTap: () => ref
                  .read(playerProvider.notifier)
                  .playQueue(songs, startIndex: index),
              onLongPress: () =>
                  showSongOptionsSheet(context: context, song: song),
            );
          }, childCount: songs.length),
        ),
      );
    }
    return slivers;
  }

  List<Widget> _buildAlbumSlivers(List<Album> albums) {
    if (albums.isEmpty) {
      return const <Widget>[
        SliverToBoxAdapter(
          child: EchoEmptyState(
            title: '暂无专辑',
            description: '服务器没有为这位歌手返回专辑。',
            icon: AppIcons.albumOutline,
          ),
        ),
      ];
    }

    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final useList = MediaQuery.sizeOf(context).width < 520 || textScale > 1.5;
    if (useList) {
      return <Widget>[
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            context.echoSpacing.md,
            context.echoSpacing.lg,
            context.echoSpacing.md,
            0,
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final album = albums[index];
              return Padding(
                padding: EdgeInsets.only(bottom: context.echoSpacing.sm),
                child: _ArtistAlbumRow(
                  album: album,
                  onPressed: () => _openAlbum(album),
                  onLongPress: () => showAlbumOptionsSheet(
                    context: context,
                    ref: ref,
                    album: album,
                  ),
                ),
              );
            }, childCount: albums.length),
          ),
        ),
      ];
    }

    return <Widget>[
      SliverPadding(
        padding: EdgeInsets.fromLTRB(
          context.echoSpacing.md,
          context.echoSpacing.lg,
          context.echoSpacing.md,
          0,
        ),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 220,
            mainAxisExtent: 286,
            crossAxisSpacing: 16,
            mainAxisSpacing: 20,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            final album = albums[index];
            return MediaDetailAlbumTile(
              album: album,
              onPressed: () => _openAlbum(album),
              onLongPress: () => showAlbumOptionsSheet(
                context: context,
                ref: ref,
                album: album,
              ),
            );
          }, childCount: albums.length),
        ),
      ),
    ];
  }

  void _openAlbum(Album album) {
    Navigator.of(context).push<void>(
      EchoPageRoute<void>(
        context: context,
        builder: (context) => AlbumDetailPage(albumId: album.id),
      ),
    );
  }

  void _retryArtist() {
    ref.invalidate(artistDetailProvider(widget.artistId));
  }

  Future<void> _toggleArtistStarred(
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
      if (mounted) {
        ToastNotifier.show(
          nextStarred ? '已收藏歌手' : '已取消收藏歌手',
          kind: EchoMessageKind.success,
        );
      }
    } catch (error) {
      if (mounted) {
        ToastNotifier.show('操作失败: $error', kind: EchoMessageKind.error);
      }
    }
  }

  Future<void> _showSongSourceInfo() {
    return showEchoBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (sheetContext) => EchoBottomSheet(
        title: '歌曲来源说明',
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                '当前歌手歌曲来源为该歌手作为专辑艺术家的专辑下的所有歌曲，可能出现错漏。',
                style: sheetContext.echoTypography.body,
              ),
              SizedBox(height: sheetContext.echoSpacing.lg),
              EchoButton.secondary(
                label: '知道了',
                expand: true,
                onPressed: () => Navigator.of(sheetContext).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArtistIdentityHeader extends StatelessWidget {
  const _ArtistIdentityHeader({
    required this.artistName,
    required this.coverArtId,
    required this.starred,
    required this.songCount,
    required this.albumCount,
    required this.onToggleStarred,
    required this.onPlay,
  });

  final String artistName;
  final String? coverArtId;
  final bool starred;
  final int songCount;
  final int albumCount;
  final VoidCallback onToggleStarred;
  final VoidCallback? onPlay;

  @override
  Widget build(BuildContext context) {
    return MediaDetailHeaderSurface(
      coverArtId: coverArtId,
      child: Padding(
        padding: EdgeInsets.all(context.echoSpacing.lg),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 680;
            final portrait = SizedBox.square(
              dimension: wide ? 200 : 160,
              child: MediaDetailArtwork(
                coverArtId: coverArtId,
                semanticLabel: '$artistName 照片',
                heroTag: 'artist-cover-$artistName',
                circular: true,
                requestSize: 480,
              ),
            );
            final information = Column(
              crossAxisAlignment: wide
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: <Widget>[
                Semantics(
                  header: true,
                  child: Text(
                    artistName,
                    textAlign: wide ? TextAlign.start : TextAlign.center,
                    style: context.echoTypography.display,
                  ),
                ),
                SizedBox(height: context.echoSpacing.sm),
                Text(
                  '$songCount 首歌曲 · $albumCount 张专辑',
                  textAlign: wide ? TextAlign.start : TextAlign.center,
                  style: context.echoTypography.body.copyWith(
                    color: context.echoColors.muted,
                  ),
                ),
                SizedBox(height: context.echoSpacing.lg),
                Wrap(
                  alignment: wide ? WrapAlignment.start : WrapAlignment.center,
                  spacing: context.echoSpacing.xs,
                  runSpacing: context.echoSpacing.xs,
                  children: <Widget>[
                    EchoButton.primary(
                      label: '播放歌曲',
                      leadingIcon: AppIcons.play,
                      onPressed: onPlay,
                    ),
                    EchoIconButton(
                      icon: starred ? AppIcons.heart : AppIcons.heartOutline,
                      label: starred ? '取消收藏歌手' : '收藏歌手',
                      selected: starred,
                      onPressed: onToggleStarred,
                    ),
                  ],
                ),
              ],
            );

            if (!wide) {
              return Column(
                children: <Widget>[
                  portrait,
                  SizedBox(height: context.echoSpacing.lg),
                  information,
                ],
              );
            }
            return Row(
              children: <Widget>[
                portrait,
                SizedBox(width: context.echoSpacing.xl),
                Expanded(child: information),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ArtistSectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  _ArtistSectionHeaderDelegate({
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  double get minExtent => 64;

  @override
  double get maxExtent => 64;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return MediaDetailSectionSwitcher(
      labels: const <String>['歌曲', '专辑'],
      selectedIndex: selectedIndex,
      onSelected: onSelected,
    );
  }

  @override
  bool shouldRebuild(_ArtistSectionHeaderDelegate oldDelegate) {
    return selectedIndex != oldDelegate.selectedIndex ||
        onSelected != oldDelegate.onSelected;
  }
}

class _ArtistAlbumRow extends StatelessWidget {
  const _ArtistAlbumRow({
    required this.album,
    required this.onPressed,
    required this.onLongPress,
  });

  final Album album;
  final VoidCallback onPressed;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return EchoPressable(
      semanticLabel: '${album.name}，${album.songCount} 首',
      onPressed: onPressed,
      onLongPress: onLongPress,
      minimumSize: const Size(double.infinity, 104),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.echoSpacing.xs),
        child: Row(
          children: <Widget>[
            SizedBox.square(
              dimension: 88,
              child: MediaDetailArtwork(
                coverArtId: album.coverArt,
                semanticLabel: '${album.name} 封面',
                heroTag: 'album-cover-${album.id}',
                requestSize: 320,
              ),
            ),
            SizedBox(width: context.echoSpacing.sm),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(album.name, style: context.echoTypography.title),
                  SizedBox(height: context.echoSpacing.xxs),
                  Text(
                    <String>[
                      if (album.year != null) '${album.year}',
                      '${album.songCount} 首',
                    ].join(' · '),
                    style: context.echoTypography.body.copyWith(
                      color: context.echoColors.muted,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: context.echoSpacing.xs),
            Icon(
              AppIcons.chevronRight,
              color: context.echoColors.muted,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _TopSongsSkeleton extends StatelessWidget {
  const _TopSongsSkeleton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.echoSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const EchoSkeleton.line(width: 160, height: 24),
          SizedBox(height: context.echoSpacing.md),
          for (var index = 0; index < 3; index++) ...<Widget>[
            Row(
              children: <Widget>[
                const EchoSkeleton.circle(),
                SizedBox(width: context.echoSpacing.sm),
                const Expanded(child: EchoSkeleton.line(height: 18)),
              ],
            ),
            SizedBox(height: context.echoSpacing.sm),
          ],
        ],
      ),
    );
  }
}
