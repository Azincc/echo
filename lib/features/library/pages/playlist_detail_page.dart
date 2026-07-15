import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/echo_design.dart';
import '../../../core/utils/network_error_notifier.dart';
import '../../../core/utils/toast_notifier.dart';
import '../../../data/models/playlist.dart';
import '../../../data/models/song.dart';
import '../../../providers/api_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/download_provider.dart';
import '../../../providers/navigation_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../providers/playlist_provider.dart';
import '../../../widgets/song_list_item.dart';
import '../../../widgets/visible_remote_retry_scope.dart';
import '../../player/widgets/song_options_sheet.dart';
import '../utils/library_sorting.dart';
import '../widgets/media_detail_components.dart';
import '../widgets/playlist_manage_dialogs.dart';
import '../widgets/playlist_options_sheet.dart';

class PlaylistDetailPage extends ConsumerStatefulWidget {
  const PlaylistDetailPage({super.key, required this.playlistId});

  final String playlistId;

  @override
  ConsumerState<PlaylistDetailPage> createState() => _PlaylistDetailPageState();
}

class _PlaylistDetailPageState extends ConsumerState<PlaylistDetailPage> {
  SongSortOption _sortOption = SongSortOption.defaultOrder;

  @override
  Widget build(BuildContext context) {
    final playlistAsync = ref.watch(playlistDetailProvider(widget.playlistId));
    final loadFailed = ref.watch(
      playlistDetailLoadFailedProvider(widget.playlistId),
    );
    final currentPlaylist = playlistAsync.valueOrNull;
    final hasActiveLibrary = ref.watch(
      authStateProvider.select((state) {
        return (state.currentLibrary?.id ?? '').isNotEmpty;
      }),
    );

    return VisibleRemoteRetryScope(
      branchIndex: libraryBranchIndex,
      debugLabel: 'playlist_detail_page',
      shouldRetry: (ref) => loadFailed || playlistAsync.hasError,
      onRetry: (ref) =>
          ref.invalidate(playlistDetailProvider(widget.playlistId)),
      child: EchoScaffold(
        topBar: EchoTopBar.back(
          context: context,
          title: '歌单',
          actions: <Widget>[
            EchoIconButton(
              icon: AppIcons.sort,
              label: '歌曲排序：${_sortOption.label}',
              onPressed: currentPlaylist == null ? null : _selectSortOption,
            ),
            EchoIconButton(
              icon: AppIcons.more,
              label: '歌单操作',
              onPressed: currentPlaylist == null
                  ? null
                  : () =>
                        _showPlaylistActions(currentPlaylist, hasActiveLibrary),
            ),
          ],
        ),
        body: playlistAsync.when(
          data: (playlist) {
            if (playlist == null) {
              return loadFailed
                  ? EchoErrorState(
                      title: '歌单加载失败',
                      description: '无法读取歌单详情。请检查网络后重试。',
                      actionLabel: '重试',
                      onAction: _retry,
                    )
                  : const EchoEmptyState(
                      title: '歌单不存在',
                      description: '这个歌单可能已经被删除，或当前服务器不再提供它。',
                      icon: AppIcons.playlist,
                    );
            }

            final songs = sortSongs(
              playlist.songs ?? const <Song>[],
              _sortOption,
            );
            return Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: _PlaylistIdentityHeader(
                        playlist: playlist,
                        songs: songs,
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
                            message: '网络连接异常，当前可能显示缓存的歌单内容。',
                            onRetry: _retry,
                          ),
                        ),
                      ),
                    SliverToBoxAdapter(
                      child: EchoSectionHeader(
                        title: '歌曲',
                        description: songs.isEmpty
                            ? '歌单中暂时没有歌曲'
                            : '${songs.length} 首 · ${_sortOption.label}',
                        padding: EdgeInsets.fromLTRB(
                          context.echoSpacing.md,
                          context.echoSpacing.lg,
                          context.echoSpacing.md,
                          context.echoSpacing.xs,
                        ),
                      ),
                    ),
                    if (songs.isEmpty)
                      const SliverToBoxAdapter(
                        child: EchoEmptyState(
                          title: '歌单还是空的',
                          description: '通过歌曲操作菜单把喜欢的内容加入这个歌单。',
                          icon: AppIcons.playlistAdd,
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
                            variant: SongListItemVariant.standard,
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
                      child: SizedBox(height: context.echoSpacing.xxl),
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () => const MediaDetailLoadingView(),
          error: (error, stackTrace) => EchoErrorState(
            title: '歌单加载失败',
            description: '无法读取歌单详情。请检查网络后重试。',
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
    ref.invalidate(playlistDetailProvider(widget.playlistId));
  }

  Future<void> _showPlaylistActions(
    Playlist playlist,
    bool hasActiveLibrary,
  ) async {
    final sortedSongs = sortSongs(
      playlist.songs ?? const <Song>[],
      _sortOption,
    );
    final action = await showPlaylistOptionsSheet(
      context: context,
      playlist: playlist,
      canDownload: hasActiveLibrary,
      hasSongs: sortedSongs.isNotEmpty,
    );
    if (!mounted || action == null) return;
    await _onMoreActionSelected(playlist, action, sortedSongs);
  }

  Future<void> _onMoreActionSelected(
    Playlist playlist,
    PlaylistOptionsAction action,
    List<Song> songs,
  ) async {
    switch (action) {
      case PlaylistOptionsAction.download:
        await _downloadPlaylist(songs);
      case PlaylistOptionsAction.addToQueue:
        _addPlaylistToQueue(songs);
      case PlaylistOptionsAction.edit:
        await _editPlaylist(playlist);
      case PlaylistOptionsAction.delete:
        await _deletePlaylist(playlist);
    }
  }

  Future<void> _downloadPlaylist(List<Song> songs) async {
    if (songs.isEmpty) {
      NetworkErrorNotifier.show('歌单暂无可用歌曲');
      return;
    }
    final libraryId = ref.read(authStateProvider).currentLibrary?.id ?? '';
    if (libraryId.isEmpty) {
      NetworkErrorNotifier.show('未选择音乐库');
      return;
    }

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

  void _addPlaylistToQueue(List<Song> songs) {
    if (songs.isEmpty) {
      NetworkErrorNotifier.show('歌单暂无可用歌曲');
      return;
    }
    ref.read(playerProvider.notifier).addAllToQueue(songs);
    ToastNotifier.show(
      '已添加 ${songs.length} 首到播放列表',
      kind: EchoMessageKind.success,
    );
  }

  Future<void> _editPlaylist(Playlist playlist) async {
    final repository = ref.read(playlistRepositoryProvider);
    if (repository == null) {
      NetworkErrorNotifier.show('未选择音乐库');
      return;
    }

    final formResult = await showPlaylistFormDialog(
      context: context,
      title: '修改歌单',
      confirmText: '保存',
      initialName: playlist.name,
      initialComment: playlist.comment ?? '',
      initialPublic: playlist.public,
    );
    if (formResult == null) return;
    final currentComment = (playlist.comment ?? '').trim();
    if (formResult.name == playlist.name &&
        formResult.comment == currentComment &&
        formResult.isPublic == playlist.public) {
      return;
    }

    try {
      await ref.read(ensureActiveAddressProvider.future);
      await repository.updatePlaylist(
        playlistId: playlist.id,
        name: formResult.name,
        comment: formResult.comment,
        public: formResult.isPublic,
      );
      ref.invalidate(playlistsProvider);
      ref.invalidate(playlistDetailProvider(playlist.id));
      if (mounted) {
        ToastNotifier.show(
          '已更新歌单「${formResult.name}」',
          kind: EchoMessageKind.success,
        );
      }
    } catch (_) {
      NetworkErrorNotifier.show('网络异常，修改失败');
    }
  }

  Future<void> _deletePlaylist(Playlist playlist) async {
    final repository = ref.read(playlistRepositoryProvider);
    if (repository == null) {
      NetworkErrorNotifier.show('未选择音乐库');
      return;
    }

    final confirmed = await showDeletePlaylistConfirmDialog(
      context: context,
      playlistName: playlist.name,
    );
    if (!confirmed || !mounted) return;

    try {
      await ref.read(ensureActiveAddressProvider.future);
      await repository.deletePlaylist(playlist.id);
      ref.invalidate(playlistsProvider);
      ref.invalidate(playlistDetailProvider(playlist.id));
      if (mounted) {
        Navigator.of(context).pop();
        ToastNotifier.show(
          '已删除歌单「${playlist.name}」',
          kind: EchoMessageKind.success,
        );
      }
    } catch (_) {
      NetworkErrorNotifier.show('网络异常，删除失败');
    }
  }
}

class _PlaylistIdentityHeader extends StatelessWidget {
  const _PlaylistIdentityHeader({
    required this.playlist,
    required this.songs,
    required this.onPlay,
  });

  final Playlist playlist;
  final List<Song> songs;
  final VoidCallback? onPlay;

  @override
  Widget build(BuildContext context) {
    final comment = playlist.comment?.trim();
    final owner = playlist.owner?.trim();

    return MediaDetailHeaderSurface(
      useContentTint: false,
      child: Padding(
        padding: EdgeInsets.all(context.echoSpacing.lg),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 680;
            final cover = SizedBox.square(
              dimension: wide ? 176 : 120,
              child: MediaDetailArtwork(
                coverArtId: playlist.coverArt,
                semanticLabel: '${playlist.name} 封面',
                heroTag: 'playlist-cover-${playlist.id}',
                requestSize: 480,
              ),
            );
            final information = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Semantics(
                  header: true,
                  child: Text(
                    playlist.name,
                    style: context.echoTypography.display,
                  ),
                ),
                if (comment != null && comment.isNotEmpty) ...<Widget>[
                  SizedBox(height: context.echoSpacing.xs),
                  Text(comment, style: context.echoTypography.body),
                ],
                SizedBox(height: context.echoSpacing.sm),
                Wrap(
                  spacing: context.echoSpacing.xs,
                  runSpacing: context.echoSpacing.xxs,
                  children: <Widget>[
                    Text(
                      '${songs.length} 首',
                      style: context.echoTypography.metadata.copyWith(
                        color: context.echoColors.muted,
                      ),
                    ),
                    Text(
                      playlist.durationString,
                      style: context.echoTypography.metadata.copyWith(
                        color: context.echoColors.muted,
                      ),
                    ),
                    if (owner != null && owner.isNotEmpty)
                      Text(
                        '创建者 $owner',
                        style: context.echoTypography.metadata.copyWith(
                          color: context.echoColors.muted,
                        ),
                      ),
                    Text(
                      playlist.public ? '公开歌单' : '私人歌单',
                      style: context.echoTypography.metadata.copyWith(
                        color: context.echoColors.muted,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.echoSpacing.lg),
                EchoButton.primary(
                  label: '播放全部',
                  leadingIcon: AppIcons.play,
                  onPressed: onPlay,
                ),
              ],
            );

            if (!wide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  cover,
                  SizedBox(width: context.echoSpacing.md),
                  Expanded(child: information),
                ],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                cover,
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
