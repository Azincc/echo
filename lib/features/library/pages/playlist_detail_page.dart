import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/network_error_notifier.dart';
import '../../../data/models/playlist.dart';
import '../../../data/models/song.dart';
import '../../../providers/api_provider.dart';
import '../../../providers/navigation_provider.dart';
import '../../../providers/playlist_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../providers/download_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../player/widgets/song_options_sheet.dart';
import '../widgets/playlist_manage_dialogs.dart';
import '../widgets/playlist_options_sheet.dart';
import '../../../widgets/error_placeholder.dart';
import '../../../widgets/song_list_item.dart';
import '../../../widgets/skeleton_templates.dart';
import '../../../widgets/visible_remote_retry_scope.dart';

/// 歌单详情页
class PlaylistDetailPage extends ConsumerWidget {
  final String playlistId;

  const PlaylistDetailPage({super.key, required this.playlistId});

  Future<void> _onMoreActionSelected(
    BuildContext context,
    WidgetRef ref,
    Playlist playlist,
    PlaylistOptionsAction action,
  ) async {
    switch (action) {
      case PlaylistOptionsAction.download:
        await _downloadPlaylist(context, ref, playlist);
        return;
      case PlaylistOptionsAction.addToQueue:
        await _addPlaylistToQueue(context, ref, playlist);
        return;
      case PlaylistOptionsAction.edit:
        await _editPlaylist(context, ref, playlist);
        return;
      case PlaylistOptionsAction.delete:
        await _deletePlaylist(context, ref, playlist);
        return;
    }
  }

  Future<void> _downloadPlaylist(
    BuildContext context,
    WidgetRef ref,
    Playlist playlist,
  ) async {
    final songs = playlist.songs ?? const <Song>[];
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
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('已添加 ${songs.length} 首歌曲到下载队列')));
    }
  }

  Future<void> _addPlaylistToQueue(
    BuildContext context,
    WidgetRef ref,
    Playlist playlist,
  ) async {
    final songs = playlist.songs ?? const <Song>[];
    if (songs.isEmpty) {
      NetworkErrorNotifier.show('歌单暂无可用歌曲');
      return;
    }

    ref.read(playerProvider.notifier).addAllToQueue(songs);
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('已添加 ${songs.length} 首到播放列表')));
    }
  }

  Future<void> _editPlaylist(
    BuildContext context,
    WidgetRef ref,
    Playlist playlist,
  ) async {
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
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('已更新歌单「${formResult.name}」')));
      }
    } catch (_) {
      NetworkErrorNotifier.show('网络异常，修改失败');
    }
  }

  Future<void> _deletePlaylist(
    BuildContext context,
    WidgetRef ref,
    Playlist playlist,
  ) async {
    final repository = ref.read(playlistRepositoryProvider);
    if (repository == null) {
      NetworkErrorNotifier.show('未选择音乐库');
      return;
    }

    final confirmed = await showDeletePlaylistConfirmDialog(
      context: context,
      playlistName: playlist.name,
    );
    if (!confirmed) return;
    if (!context.mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(ensureActiveAddressProvider.future);
      await repository.deletePlaylist(playlist.id);
      ref.invalidate(playlistsProvider);
      ref.invalidate(playlistDetailProvider(playlist.id));
      if (context.mounted) {
        Navigator.of(context).pop();
        messenger.showSnackBar(
          SnackBar(content: Text('已删除歌单「${playlist.name}」')),
        );
      }
    } catch (_) {
      NetworkErrorNotifier.show('网络异常，删除失败');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistAsync = ref.watch(playlistDetailProvider(playlistId));
    final loadFailed = ref.watch(playlistDetailLoadFailedProvider(playlistId));
    final currentPlaylist = playlistAsync.valueOrNull;
    final hasActiveLibrary = ref.watch(
      authStateProvider.select((s) => (s.currentLibrary?.id ?? '').isNotEmpty),
    );

    return VisibleRemoteRetryScope(
      branchIndex: libraryBranchIndex,
      debugLabel: 'playlist_detail_page',
      shouldRetry: (ref) => loadFailed || playlistAsync.hasError,
      onRetry: (ref) => ref.invalidate(playlistDetailProvider(playlistId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(currentPlaylist?.name ?? '歌单'),
          actions: [
            if (currentPlaylist != null)
              IconButton(
                tooltip: '歌单操作',
                icon: const Icon(Icons.more_horiz),
                onPressed: () async {
                  final action = await showPlaylistOptionsSheet(
                    context: context,
                    playlist: currentPlaylist,
                    canDownload: hasActiveLibrary,
                    hasSongs:
                        (currentPlaylist.songs ?? const <Song>[]).isNotEmpty,
                  );
                  if (action == null || !context.mounted) return;
                  await _onMoreActionSelected(
                    context,
                    ref,
                    currentPlaylist,
                    action,
                  );
                },
              ),
          ],
        ),
        body: playlistAsync.when(
          data: (playlist) {
            if (playlist == null) {
              return Center(child: Text(loadFailed ? '网络异常，歌单加载失败' : '歌单不存在'));
            }

            final songs = playlist.songs ?? [];

            return Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              playlist.name,
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            if (playlist.comment != null &&
                                playlist.comment!.isNotEmpty)
                              Text(
                                playlist.comment!,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            const SizedBox(height: 8),
                            Text(
                              '${playlist.songCount} 首 · ${playlist.durationString}',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                            ),
                            const SizedBox(height: 16),
                            FilledButton.icon(
                              onPressed: songs.isEmpty
                                  ? null
                                  : () {
                                      // 播放全部
                                      ref
                                          .read(playerProvider.notifier)
                                          .playQueue(songs);
                                    },
                              icon: const Icon(Icons.play_arrow),
                              label: const Text('播放全部'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final song = songs[index];
                        return SongListItem(
                          song: song,
                          index: index,
                          variant: SongListItemVariant.standard,
                          onTap: () {
                            // 播放歌曲
                            ref
                                .read(playerProvider.notifier)
                                .playQueue(songs, startIndex: index);
                          },
                          onLongPress: () {
                            _showSongContextMenu(context, ref, song);
                          },
                        );
                      }, childCount: songs.length),
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () => const PlaylistDetailSkeleton(),
          error: (error, stack) =>
              const ErrorPlaceholder(message: '歌单加载失败，请检查网络后重试'),
        ),
      ),
    );
  }

  void _showSongContextMenu(BuildContext context, WidgetRef ref, Song song) {
    showSongOptionsSheet(context: context, song: song);
  }
}
