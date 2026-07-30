import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/echo_design.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/network_error_notifier.dart';
import '../../../core/utils/toast_notifier.dart';
import '../../../data/models/playlist.dart';
import '../../../data/models/song.dart';
import '../../../data/sources/subsonic_api_client.dart';
import '../../../providers/api_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/download_provider.dart';
import '../../../providers/metadata_cache_provider.dart';
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
  final Set<int> _selectedSongIndexes = <int>{};
  bool _selectionMode = false;
  bool _isRemovingSongs = false;
  int? _selectionRevision;
  bool _selectionResetScheduled = false;
  int _mutationGeneration = 0;

  @override
  void didUpdateWidget(covariant PlaylistDetailPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.playlistId == widget.playlistId) return;
    _mutationGeneration++;
    _selectionMode = false;
    _selectedSongIndexes.clear();
    _isRemovingSongs = false;
    _selectionRevision = null;
    _selectionResetScheduled = false;
  }

  @override
  Widget build(BuildContext context) {
    final playlistAsync = ref.watch(playlistDetailProvider(widget.playlistId));
    final loadFailed = ref.watch(
      playlistDetailLoadFailedProvider(widget.playlistId),
    );
    final currentPlaylist = playlistAsync.valueOrNull;
    _scheduleSelectionResetIfStale(currentPlaylist);
    final hasActiveLibrary = ref.watch(
      authStateProvider.select((state) {
        return (state.currentLibrary?.id ?? '').isNotEmpty;
      }),
    );
    final currentSongCount = currentPlaylist?.songs?.length ?? 0;
    final allSongsSelected =
        currentSongCount > 0 &&
        _selectedSongIndexes.length == currentSongCount &&
        _selectedSongIndexes.every(
          (originalIndex) => originalIndex < currentSongCount,
        );
    final topBar = _selectionMode
        ? EchoTopBar(
            title: '已选 ${_selectedSongIndexes.length} 首',
            leading: EchoIconButton(
              icon: AppIcons.close,
              label: '退出歌曲管理',
              onPressed: _isRemovingSongs ? null : _exitSelectionMode,
            ),
            actions: <Widget>[
              EchoIconButton(
                icon: allSongsSelected ? AppIcons.clearAll : AppIcons.selectAll,
                label: allSongsSelected ? '取消全选歌曲' : '全选歌曲',
                selected: allSongsSelected,
                onPressed:
                    currentPlaylist == null ||
                        currentSongCount == 0 ||
                        _isRemovingSongs
                    ? null
                    : () => _toggleSelectAll(currentPlaylist),
              ),
            ],
          )
        : EchoTopBar.back(
            context: context,
            title: '歌单',
            actions: <Widget>[
              EchoIconButton(
                icon: AppIcons.selectAll,
                label: '管理歌单歌曲',
                onPressed:
                    currentPlaylist == null ||
                        currentSongCount == 0 ||
                        _isRemovingSongs
                    ? null
                    : () => _enterSelectionMode(currentPlaylist),
              ),
              EchoIconButton(
                icon: AppIcons.sort,
                label: '歌曲排序：${_sortOption.label}',
                onPressed: currentPlaylist == null || _isRemovingSongs
                    ? null
                    : _selectSortOption,
              ),
              EchoIconButton(
                icon: AppIcons.more,
                label: '歌单操作',
                onPressed: currentPlaylist == null || _isRemovingSongs
                    ? null
                    : () => _showPlaylistActions(
                        currentPlaylist,
                        hasActiveLibrary,
                      ),
              ),
            ],
          );

    return PopScope<void>(
      canPop: !_selectionMode,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _selectionMode && !_isRemovingSongs) {
          _exitSelectionMode();
        }
      },
      child: VisibleRemoteRetryScope(
        branchIndex: libraryBranchIndex,
        debugLabel: 'playlist_detail_page',
        shouldRetry: (ref) => loadFailed || playlistAsync.hasError,
        onRetry: (ref) =>
            ref.invalidate(playlistDetailProvider(widget.playlistId)),
        child: EchoScaffold(
          topBar: topBar,
          bottomBar: _selectionMode && currentPlaylist != null
              ? _PlaylistSelectionBar(
                  selectedCount: _selectedSongIndexes.length,
                  removing: _isRemovingSongs,
                  onRemove: _selectedSongIndexes.isEmpty
                      ? null
                      : () => _confirmBatchRemoval(currentPlaylist),
                )
              : null,
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

              final entries = _sortPlaylistEntries(
                playlist.songs ?? const <Song>[],
                _sortOption,
              );
              final songs = entries
                  .map((entry) => entry.song)
                  .toList(growable: false);
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
                          description: _selectionMode
                              ? '轻触歌曲选择要从歌单移除的条目'
                              : songs.isEmpty
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
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final entry = entries[index];
                            final song = entry.song;
                            return SongListItem(
                              key: ValueKey<String>(
                                'playlist-song-${entry.originalIndex}',
                              ),
                              song: song,
                              index: index,
                              variant: SongListItemVariant.standard,
                              selectionMode: _selectionMode,
                              selected: _selectedSongIndexes.contains(
                                entry.originalIndex,
                              ),
                              onToggleSelected: () => _toggleSongSelection(
                                playlist,
                                entry.originalIndex,
                              ),
                              onTap: () => ref
                                  .read(playerProvider.notifier)
                                  .playQueue(songs, startIndex: index),
                              onLongPress: () => _enterSelectionMode(
                                playlist,
                                originalIndex: entry.originalIndex,
                              ),
                              onMorePressed: () =>
                                  _showSongActions(playlist, entry),
                            );
                          }, childCount: songs.length),
                        ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          key: const ValueKey<String>(
                            'playlist-detail-bottom-spacer',
                          ),
                          height:
                              context.echoSpacing.xxl +
                              (_selectionMode
                                  ? 0
                                  : context.echoShellBottomObstruction),
                        ),
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

  void _enterSelectionMode(Playlist playlist, {int? originalIndex}) {
    if (_isRemovingSongs ||
        (playlist.songs?.isEmpty ?? true) ||
        playlist.id != widget.playlistId) {
      return;
    }
    final revision = _playlistRevision(playlist);
    setState(() {
      if (_selectionRevision != revision) {
        _selectedSongIndexes.clear();
      }
      _selectionMode = true;
      _selectionRevision = revision;
      if (originalIndex != null) {
        _selectedSongIndexes.add(originalIndex);
      }
    });
  }

  void _exitSelectionMode() {
    if (_isRemovingSongs) return;
    setState(() {
      _selectionMode = false;
      _selectedSongIndexes.clear();
      _selectionRevision = null;
    });
  }

  void _toggleSongSelection(Playlist playlist, int originalIndex) {
    if (_isRemovingSongs) return;
    if (!_selectionMatches(playlist)) {
      _resetStaleSelection();
      return;
    }
    setState(() {
      if (!_selectedSongIndexes.add(originalIndex)) {
        _selectedSongIndexes.remove(originalIndex);
      }
    });
  }

  void _toggleSelectAll(Playlist playlist) {
    if (_isRemovingSongs) return;
    if (!_selectionMatches(playlist)) {
      _resetStaleSelection();
      return;
    }
    final songCount = playlist.songs?.length ?? 0;
    setState(() {
      final allSelected =
          songCount > 0 && _selectedSongIndexes.length == songCount;
      if (allSelected) {
        _selectedSongIndexes.clear();
      } else {
        _selectedSongIndexes
          ..clear()
          ..addAll(Iterable<int>.generate(songCount));
      }
    });
  }

  Future<void> _showSongActions(Playlist playlist, _PlaylistSongEntry entry) {
    return showSongOptionsSheet(
      context: context,
      song: entry.song,
      extraActions: <SongOptionsExtraAction>[
        SongOptionsExtraAction(
          icon: AppIcons.removeCircle,
          title: '从歌单移除',
          isDestructive: true,
          onPressed: () => _removeSongEntries(
            playlist: playlist,
            originalIndexes: <int>[entry.originalIndex],
            successMessage: '已从歌单移除《${entry.song.title}》',
          ),
        ),
      ],
    );
  }

  Future<void> _confirmBatchRemoval(Playlist playlist) async {
    if (_selectedSongIndexes.isEmpty || _isRemovingSongs) return;
    if (!_selectionMatches(playlist)) {
      _resetStaleSelection();
      return;
    }
    final count = _selectedSongIndexes.length;
    final confirmed = await showEchoBottomSheet<bool>(
      context: context,
      useRootNavigator: true,
      builder: (sheetContext) => EchoBottomSheet(
        title: '移除歌曲',
        subtitle: '只会修改当前歌单，不会删除音乐文件。',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              '确定从「${playlist.name}」中移除选中的 $count 首歌曲吗？',
              style: sheetContext.echoTypography.body.copyWith(
                color: sheetContext.echoColors.muted,
              ),
            ),
            SizedBox(height: sheetContext.echoSpacing.lg),
            Row(
              children: <Widget>[
                Expanded(
                  child: EchoButton.secondary(
                    label: '取消',
                    onPressed: () => Navigator.of(sheetContext).pop(false),
                  ),
                ),
                SizedBox(width: sheetContext.echoSpacing.sm),
                Expanded(
                  child: EchoButton.destructive(
                    label: '移除',
                    onPressed: () => Navigator.of(sheetContext).pop(true),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    if (confirmed != true || !mounted) return;
    if (_selectedSongIndexes.isEmpty || !_selectionMatchesLatest(playlist)) {
      _resetStaleSelection();
      return;
    }
    await _removeSongEntries(
      playlist: playlist,
      originalIndexes: Set<int>.of(_selectedSongIndexes),
      successMessage: '已移除 $count 首歌曲',
    );
  }

  Future<void> _removeSongEntries({
    required Playlist playlist,
    required Iterable<int> originalIndexes,
    required String successMessage,
  }) async {
    if (_isRemovingSongs || playlist.id != widget.playlistId) return;
    final latestPlaylist = ref
        .read(playlistDetailProvider(playlist.id))
        .valueOrNull;
    if (latestPlaylist == null ||
        _playlistRevision(latestPlaylist) != _playlistRevision(playlist)) {
      _resetStaleSelection();
      return;
    }
    final repository = ref.read(playlistRepositoryProvider);
    if (repository == null) {
      NetworkErrorNotifier.show('未选择音乐库');
      return;
    }
    final cache = ref.read(metadataCacheRepositoryProvider);
    final libraryId = ref.read(authStateProvider).currentLibrary?.id ?? '';
    final ensureAddress = ref.read(ensureActiveAddressProvider.future);

    final songCount = latestPlaylist.songs?.length ?? 0;
    final indexes =
        originalIndexes
            .where((index) => index >= 0 && index < songCount)
            .toSet()
            .toList()
          ..sort((left, right) => right.compareTo(left));
    if (indexes.isEmpty) return;

    final mutationToken = ++_mutationGeneration;
    setState(() => _isRemovingSongs = true);
    try {
      await ensureAddress;
      if (!_isCurrentMutation(mutationToken, playlist.id)) return;
      await repository.updatePlaylist(
        playlistId: playlist.id,
        songIndexesToRemove: indexes,
      );
      if (libraryId.isNotEmpty) {
        try {
          await cache.cachePlaylistSongRemoval(
            libraryId: libraryId,
            playlist: latestPlaylist,
            removedIndexes: indexes.toSet(),
          );
        } catch (error, stackTrace) {
          Logger.warnWithTag(
            'PLAYLIST',
            'failed to repair playlist caches after song removal',
            error,
          );
          Logger.debugWithTag(
            'PLAYLIST',
            'playlist cache repair stackTrace',
            null,
            stackTrace,
          );
          try {
            await cache.clearPlaylistCaches(libraryId, playlist.id);
          } catch (clearError) {
            Logger.warnWithTag(
              'PLAYLIST',
              'failed to clear stale playlist caches',
              clearError,
            );
          }
        }
      }
      if (mounted) {
        ref.invalidate(playlistsProvider);
        ref.invalidate(playlistDetailProvider(playlist.id));
      }
      if (!_isCurrentMutation(mutationToken, playlist.id)) return;
      setState(() {
        _isRemovingSongs = false;
        _selectionMode = false;
        _selectedSongIndexes.clear();
        _selectionRevision = null;
      });
      ToastNotifier.show(successMessage, kind: EchoMessageKind.success);
    } catch (error) {
      if (!_isCurrentMutation(mutationToken, playlist.id)) return;
      setState(() => _isRemovingSongs = false);
      if (error is SubsonicException && error.code == 50) {
        NetworkErrorNotifier.show('无权修改该歌单，或该歌单不支持移除歌曲');
      } else if (error is SubsonicException) {
        final message = error.message.trim();
        NetworkErrorNotifier.show(
          message.isEmpty ? '服务器拒绝移除歌曲' : '移除失败：$message',
        );
      } else {
        NetworkErrorNotifier.show('网络异常，移除失败');
      }
    }
  }

  bool _selectionMatches(Playlist playlist) {
    return _selectionMode &&
        playlist.id == widget.playlistId &&
        _selectionRevision == _playlistRevision(playlist);
  }

  bool _selectionMatchesLatest(Playlist snapshot) {
    if (!_selectionMatches(snapshot)) return false;
    final latest = ref.read(playlistDetailProvider(snapshot.id)).valueOrNull;
    return latest != null && _selectionRevision == _playlistRevision(latest);
  }

  void _scheduleSelectionResetIfStale(Playlist? playlist) {
    final selectionRevision = _selectionRevision;
    if (!_selectionMode ||
        selectionRevision == null ||
        playlist == null ||
        playlist.id != widget.playlistId ||
        _playlistRevision(playlist) == selectionRevision ||
        _selectionResetScheduled) {
      return;
    }

    final playlistId = widget.playlistId;
    _selectionResetScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectionResetScheduled = false;
      if (!mounted ||
          widget.playlistId != playlistId ||
          !_selectionMode ||
          _selectionRevision != selectionRevision) {
        return;
      }
      final latest = ref.read(playlistDetailProvider(playlistId)).valueOrNull;
      if (latest == null || _playlistRevision(latest) == selectionRevision) {
        return;
      }
      _resetStaleSelection();
    });
  }

  void _resetStaleSelection() {
    if (!mounted) return;
    final hadSelectionMode = _selectionMode;
    setState(() {
      _selectionMode = false;
      _selectedSongIndexes.clear();
      _selectionRevision = null;
    });
    if (hadSelectionMode) {
      ToastNotifier.show('歌单内容已更新，请重新选择');
    } else {
      ToastNotifier.show('歌单内容已更新，请重试');
    }
  }

  bool _isCurrentMutation(int token, String playlistId) {
    return mounted &&
        widget.playlistId == playlistId &&
        _mutationGeneration == token;
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

class _PlaylistSongEntry {
  const _PlaylistSongEntry({required this.song, required this.originalIndex});

  final Song song;
  final int originalIndex;
}

int _playlistRevision(Playlist playlist) {
  final songs = playlist.songs ?? const <Song>[];
  return Object.hash(
    playlist.id,
    playlist.changed?.microsecondsSinceEpoch,
    playlist.songCount,
    playlist.duration,
    Object.hashAll(
      songs.map(
        (song) => Object.hash(
          song.id,
          song.title,
          song.artistId,
          song.albumId,
          song.duration,
        ),
      ),
    ),
  );
}

List<_PlaylistSongEntry> _sortPlaylistEntries(
  List<Song> songs,
  SongSortOption option,
) {
  final entries = List<_PlaylistSongEntry>.generate(
    songs.length,
    (index) => _PlaylistSongEntry(song: songs[index], originalIndex: index),
    growable: false,
  );
  if (option == SongSortOption.defaultOrder || entries.length < 2) {
    return entries;
  }

  entries.sort((left, right) {
    final comparison = compareSongsForSort(left.song, right.song, option);
    return comparison == 0
        ? left.originalIndex.compareTo(right.originalIndex)
        : comparison;
  });
  return entries;
}

class _PlaylistSelectionBar extends StatelessWidget {
  const _PlaylistSelectionBar({
    required this.selectedCount,
    required this.removing,
    required this.onRemove,
  });

  final int selectedCount;
  final bool removing;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final count = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('从当前歌单移除', style: context.echoTypography.title),
        SizedBox(height: context.echoSpacing.xxs),
        Text(
          '已选择 $selectedCount 首，不会删除音乐文件',
          style: context.echoTypography.metadata.copyWith(
            color: context.echoColors.muted,
          ),
        ),
      ],
    );

    EchoButton removeButton({required bool expand}) => EchoButton.destructive(
      label: removing ? '移除中…' : '移除选中',
      semanticLabel: '移除选中歌曲',
      leadingIcon: AppIcons.removeCircle,
      expand: expand,
      onPressed: removing ? null : onRemove,
    );

    return EchoSurface(
      level: EchoSurfaceLevel.surface,
      borderRadius: BorderRadius.zero,
      borderColor: context.echoColors.divider,
      padding: EdgeInsets.fromLTRB(
        context.echoPageHorizontalPadding,
        context.echoSpacing.xs,
        context.echoPageHorizontalPadding,
        context.echoSpacing.xs,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final stack =
              constraints.maxWidth < 380 ||
              MediaQuery.textScalerOf(context).scale(1) > 1.3;
          if (stack) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                count,
                SizedBox(height: context.echoSpacing.xs),
                removeButton(expand: true),
              ],
            );
          }
          return Row(
            children: <Widget>[
              Expanded(child: count),
              SizedBox(width: context.echoSpacing.md),
              removeButton(expand: false),
            ],
          );
        },
      ),
    );
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
      coverArtId: playlist.coverArt,
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
