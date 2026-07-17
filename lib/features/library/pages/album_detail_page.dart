import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/echo_design.dart';
import '../../../core/utils/toast_notifier.dart';
import '../../../data/models/album.dart';
import '../../../data/models/song.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/download_provider.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/navigation_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../widgets/song_list_item.dart';
import '../../../widgets/visible_remote_retry_scope.dart';
import '../../player/widgets/song_options_sheet.dart';
import '../utils/library_sorting.dart';
import '../widgets/album_options_sheet.dart';
import '../widgets/media_detail_components.dart';

class AlbumDetailPage extends ConsumerStatefulWidget {
  const AlbumDetailPage({super.key, required this.albumId});

  final String albumId;

  @override
  ConsumerState<AlbumDetailPage> createState() => _AlbumDetailPageState();
}

class _AlbumDetailPageState extends ConsumerState<AlbumDetailPage> {
  SongSortOption _sortOption = SongSortOption.defaultOrder;

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(albumDetailProvider(widget.albumId));
    final loadFailed = ref.watch(albumDetailLoadFailedProvider(widget.albumId));
    final currentAlbum = detailAsync.valueOrNull?.album;

    return VisibleRemoteRetryScope(
      branchIndex: libraryBranchIndex,
      debugLabel: 'album_detail_page',
      shouldRetry: (ref) => loadFailed || detailAsync.hasError,
      onRetry: (ref) => ref.invalidate(albumDetailProvider(widget.albumId)),
      child: EchoScaffold(
        topBar: EchoTopBar.back(
          context: context,
          title: '专辑',
          actions: <Widget>[
            EchoIconButton(
              icon: AppIcons.sort,
              label: '歌曲排序：${_sortOption.label}',
              onPressed: currentAlbum == null ? null : _selectSortOption,
            ),
            EchoIconButton(
              icon: AppIcons.more,
              label: '专辑操作',
              onPressed: currentAlbum == null
                  ? null
                  : () => showAlbumOptionsSheet(
                      context: context,
                      ref: ref,
                      album: currentAlbum,
                    ),
            ),
          ],
        ),
        body: detailAsync.when(
          data: (detail) {
            if (detail == null) {
              return loadFailed
                  ? EchoErrorState(
                      title: '专辑加载失败',
                      description: '无法读取专辑详情。请检查网络后重试。',
                      actionLabel: '重试',
                      onAction: _retry,
                    )
                  : const EchoEmptyState(
                      title: '专辑不存在',
                      description: '服务器没有返回这张专辑，内容可能已经被移动或删除。',
                      icon: AppIcons.albumOutline,
                    );
            }

            final album = detail.album;
            final songs = sortSongs(detail.songs, _sortOption);
            final compact =
                MediaQuery.sizeOf(context).width <
                context.echoBreakpoints.medium;
            return Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: _AlbumIdentityHeader(
                        album: album,
                        songs: songs,
                        onPlay: songs.isEmpty
                            ? null
                            : () => ref
                                  .read(playerProvider.notifier)
                                  .playQueue(songs),
                        onToggleStarred: () => _toggleStarred(album),
                        onDownload: songs.isEmpty
                            ? null
                            : () => _downloadAlbum(songs),
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
                            message: '网络连接异常，当前可能显示缓存的专辑内容。',
                            onRetry: _retry,
                          ),
                        ),
                      ),
                    SliverToBoxAdapter(
                      child: EchoSectionHeader(
                        title: '曲目',
                        description: songs.isEmpty
                            ? '这张专辑暂时没有可播放曲目'
                            : '${songs.length} 首 · ${_sortOption.label}',
                        padding: EdgeInsets.fromLTRB(
                          context.echoSpacing.md,
                          compact
                              ? context.echoSpacing.sm
                              : context.echoSpacing.lg,
                          context.echoSpacing.md,
                          context.echoSpacing.xs,
                        ),
                      ),
                    ),
                    if (songs.isEmpty)
                      const SliverToBoxAdapter(
                        child: EchoEmptyState(
                          title: '暂无曲目',
                          description: '服务器没有为这张专辑返回可播放歌曲。',
                          icon: AppIcons.music,
                          padding: EdgeInsets.all(32),
                        ),
                      )
                    else
                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final song = songs[index];
                          return SongListItem(
                            song: song,
                            index: index,
                            variant: SongListItemVariant.albumTrack,
                            onTap: () => ref
                                .read(playerProvider.notifier)
                                .playQueue(songs, startIndex: index),
                            onLongPress: () => showSongOptionsSheet(
                              context: context,
                              song: song,
                            ),
                          );
                        }, childCount: songs.length),
                      ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        key: const ValueKey<String>(
                          'album-detail-bottom-spacer',
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
          loading: () => const MediaDetailLoadingView(),
          error: (error, stackTrace) => EchoErrorState(
            title: '专辑加载失败',
            description: '无法读取专辑详情。请检查网络后重试。',
            actionLabel: '重试',
            onAction: _retry,
          ),
        ),
      ),
    );
  }

  Future<void> _selectSortOption() async {
    final option = await showMediaSongSortSheet(
      context: context,
      current: _sortOption,
    );
    if (!mounted || option == null || option == _sortOption) return;
    setState(() => _sortOption = option);
  }

  void _retry() {
    ref.invalidate(albumDetailProvider(widget.albumId));
  }

  Future<void> _toggleStarred(Album album) async {
    final repository = ref.read(musicRepositoryProvider);
    if (repository == null) return;

    try {
      final nextStarred = !album.starred;
      await repository.setAlbumStarred(album.id, nextStarred);
      ref.invalidate(albumDetailProvider(widget.albumId));
      ref.invalidate(starredProvider);
      ref.invalidate(recentAlbumsProvider);
      ref.invalidate(frequentAlbumsProvider);
      if (mounted) {
        ToastNotifier.show(
          nextStarred ? '已收藏专辑' : '已取消收藏专辑',
          kind: EchoMessageKind.success,
        );
      }
    } catch (error) {
      if (mounted) {
        ToastNotifier.show('操作失败: $error', kind: EchoMessageKind.error);
      }
    }
  }

  Future<void> _downloadAlbum(List<Song> songs) async {
    final libraryId = ref.read(authStateProvider).currentLibrary?.id ?? '';
    if (libraryId.isEmpty) return;

    await ref
        .read(downloadServiceProvider)
        .enqueueBatch(songs, libraryId: libraryId);
    if (mounted) {
      ToastNotifier.show(
        '已添加 ${songs.length} 首歌曲到下载队列',
        kind: EchoMessageKind.success,
      );
    }
  }
}

class _AlbumIdentityHeader extends StatelessWidget {
  const _AlbumIdentityHeader({
    required this.album,
    required this.songs,
    required this.onPlay,
    required this.onToggleStarred,
    required this.onDownload,
  });

  final Album album;
  final List<Song> songs;
  final VoidCallback? onPlay;
  final VoidCallback onToggleStarred;
  final VoidCallback? onDownload;

  @override
  Widget build(BuildContext context) {
    return MediaDetailHeaderSurface(
      coverArtId: album.coverArt,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < context.echoBreakpoints.medium;
          final wide = constraints.maxWidth >= 680;
          final padding = compact
              ? EdgeInsets.symmetric(
                  horizontal: context.echoSpacing.md,
                  vertical: context.echoSpacing.sm,
                )
              : EdgeInsets.all(context.echoSpacing.lg);

          if (compact) {
            final artwork = SizedBox.square(
              dimension: 112,
              child: MediaDetailArtwork(
                coverArtId: album.coverArt,
                semanticLabel: '${album.name} 封面',
                heroTag: 'album-cover-${album.id}',
                requestSize: 480,
              ),
            );

            return Padding(
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(child: artwork),
                  SizedBox(height: context.echoSpacing.sm),
                  _AlbumInformation(
                    album: album,
                    songs: songs,
                    compact: true,
                    actions: _AlbumActions(
                      album: album,
                      onPlay: onPlay,
                      onToggleStarred: onToggleStarred,
                      onDownload: onDownload,
                    ),
                  ),
                ],
              ),
            );
          }

          final artwork = ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: wide ? 280 : 260,
              maxHeight: wide ? 280 : 260,
            ),
            child: AspectRatio(
              aspectRatio: 1,
              child: MediaDetailArtwork(
                coverArtId: album.coverArt,
                semanticLabel: '${album.name} 封面',
                heroTag: 'album-cover-${album.id}',
              ),
            ),
          );
          final information = _AlbumInformation(
            album: album,
            songs: songs,
            actions: _AlbumActions(
              album: album,
              onPlay: onPlay,
              onToggleStarred: onToggleStarred,
              onDownload: onDownload,
            ),
          );

          return Padding(
            padding: padding,
            child: wide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      artwork,
                      SizedBox(width: context.echoSpacing.xl),
                      Expanded(child: information),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(child: artwork),
                      SizedBox(height: context.echoSpacing.lg),
                      information,
                    ],
                  ),
          );
        },
      ),
    );
  }
}

class _AlbumInformation extends StatelessWidget {
  const _AlbumInformation({
    required this.album,
    required this.songs,
    this.actions,
    this.compact = false,
  });

  final Album album;
  final List<Song> songs;
  final Widget? actions;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final artist = album.artist?.trim();
    final showFullText = MediaQuery.textScalerOf(context).scale(1) > 1.3;
    final metadata = <String>[
      if (album.year != null) '${album.year}',
      if (album.genre?.trim().isNotEmpty == true) album.genre!.trim(),
      '${songs.length} 首',
      album.durationString,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Semantics(
          header: true,
          child: Text(
            album.name,
            maxLines: compact && !showFullText ? 2 : null,
            overflow: compact && !showFullText
                ? TextOverflow.ellipsis
                : TextOverflow.visible,
            style: compact
                ? context.echoTypography.headline
                : context.echoTypography.display,
          ),
        ),
        if (artist != null && artist.isNotEmpty) ...<Widget>[
          SizedBox(
            height: compact ? context.echoSpacing.xxs : context.echoSpacing.xs,
          ),
          Text(
            artist,
            maxLines: compact && !showFullText ? 2 : null,
            overflow: compact && !showFullText
                ? TextOverflow.ellipsis
                : TextOverflow.visible,
            style:
                (compact
                        ? context.echoTypography.body.copyWith(
                            fontWeight: FontWeight.w600,
                          )
                        : context.echoTypography.title)
                    .copyWith(color: context.echoColors.muted),
          ),
        ],
        SizedBox(
          height: compact ? context.echoSpacing.xs : context.echoSpacing.sm,
        ),
        Wrap(
          spacing: context.echoSpacing.xs,
          runSpacing: context.echoSpacing.xxs,
          children: <Widget>[
            for (final item in metadata)
              Text(
                item,
                style: context.echoTypography.metadata.copyWith(
                  color: context.echoColors.muted,
                ),
              ),
          ],
        ),
        if (actions != null) ...<Widget>[
          SizedBox(
            height: compact ? context.echoSpacing.sm : context.echoSpacing.lg,
          ),
          actions!,
        ],
      ],
    );
  }
}

class _AlbumActions extends StatelessWidget {
  const _AlbumActions({
    required this.album,
    required this.onPlay,
    required this.onToggleStarred,
    required this.onDownload,
  });

  final Album album;
  final VoidCallback? onPlay;
  final VoidCallback onToggleStarred;
  final VoidCallback? onDownload;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: context.echoSpacing.xs,
      runSpacing: context.echoSpacing.xs,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        EchoButton.primary(
          label: '播放全部',
          leadingIcon: AppIcons.play,
          onPressed: onPlay,
        ),
        EchoIconButton(
          icon: album.starred ? AppIcons.heart : AppIcons.heartOutline,
          label: album.starred ? '取消收藏专辑' : '收藏专辑',
          selected: album.starred,
          onPressed: onToggleStarred,
        ),
        EchoIconButton(
          icon: AppIcons.downloadOutline,
          label: '下载专辑',
          onPressed: onDownload,
        ),
      ],
    );
  }
}
