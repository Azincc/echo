import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/echo_design.dart';
import '../../../core/utils/network_error_notifier.dart';
import '../../../core/utils/toast_notifier.dart';
import '../../../data/models/album.dart';
import '../../../data/models/song.dart';
import '../../../providers/api_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/download_provider.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../providers/playlist_provider.dart';

Future<void> showAlbumOptionsSheet({
  required BuildContext context,
  required WidgetRef ref,
  required Album album,
  bool useRootNavigator = true,
}) async {
  await showEchoBottomSheet<void>(
    context: context,
    useRootNavigator: useRootNavigator,
    isScrollControlled: true,
    builder: (_) =>
        _AlbumOptionsSheet(hostContext: context, hostRef: ref, album: album),
  );
}

class _AlbumOptionsSheet extends ConsumerWidget {
  const _AlbumOptionsSheet({
    required this.hostContext,
    required this.hostRef,
    required this.album,
  });

  final BuildContext hostContext;
  final WidgetRef hostRef;
  final Album album;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final libraryId = ref.watch(
      authStateProvider.select((state) => state.currentLibrary?.id ?? ''),
    );
    final canDownload = libraryId.isNotEmpty;
    final artistName = album.artist?.trim().isNotEmpty == true
        ? album.artist!.trim()
        : '未知歌手';

    return EchoBottomSheet(
      title: album.name,
      subtitle: artistName,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            EchoActionRow(
              icon: album.starred ? AppIcons.heart : AppIcons.heartOutline,
              title: album.starred ? '取消收藏专辑' : '收藏专辑',
              selected: album.starred,
              onPressed: () => _closeAndRun(context, () async {
                final repository = hostRef.read(musicRepositoryProvider);
                if (repository == null) {
                  NetworkErrorNotifier.show('未选择音乐库');
                  return;
                }

                try {
                  await hostRef.read(ensureActiveAddressProvider.future);
                  final nextStarred = !album.starred;
                  await repository.setAlbumStarred(album.id, nextStarred);
                  _invalidateAlbumQueries();
                  _showMessage(nextStarred ? '已收藏专辑' : '已取消收藏');
                } catch (_) {
                  NetworkErrorNotifier.show('网络异常，操作失败');
                }
              }),
            ),
            EchoActionRow(
              icon: AppIcons.downloadOutline,
              title: '下载专辑',
              subtitle: canDownload ? null : '请先选择音乐库',
              onPressed: canDownload
                  ? () => _closeAndRun(context, () async {
                      final songs = await _loadAlbumSongs();
                      if (songs == null || songs.isEmpty) return;

                      final currentLibraryId =
                          hostRef.read(authStateProvider).currentLibrary?.id ??
                          '';
                      if (currentLibraryId.isEmpty) {
                        NetworkErrorNotifier.show('未选择音乐库');
                        return;
                      }

                      await hostRef
                          .read(downloadServiceProvider)
                          .enqueueBatch(songs, libraryId: currentLibraryId);
                      _showMessage('已添加 ${songs.length} 首到下载队列');
                    })
                  : null,
            ),
            EchoActionRow(
              icon: AppIcons.queueAdd,
              title: '添加到播放列表',
              onPressed: () => _closeAndRun(context, () async {
                final songs = await _loadAlbumSongs();
                if (songs == null || songs.isEmpty) return;
                hostRef.read(playerProvider.notifier).addAllToQueue(songs);
                _showMessage('已添加 ${songs.length} 首到播放列表');
              }),
            ),
            EchoActionRow(
              icon: AppIcons.playlistAdd,
              title: '添加到歌单',
              onPressed: () => _closeAndRun(context, () async {
                final songs = await _loadAlbumSongs();
                if (songs == null || songs.isEmpty || !hostContext.mounted) {
                  return;
                }

                await showEchoBottomSheet<void>(
                  context: hostContext,
                  useRootNavigator: true,
                  isScrollControlled: true,
                  builder: (_) => _AddAlbumToPlaylistSheet(
                    hostContext: hostContext,
                    album: album,
                    songs: songs,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Song>?> _loadAlbumSongs() async {
    if (album.songCount <= 0) {
      NetworkErrorNotifier.show('专辑暂无可用歌曲');
      return null;
    }

    final repository = hostRef.read(musicRepositoryProvider);
    if (repository == null) {
      NetworkErrorNotifier.show('未选择音乐库');
      return null;
    }

    try {
      await hostRef.read(ensureActiveAddressProvider.future);
      final detail = await repository.getAlbum(album.id);
      final songs = detail?.songs ?? const <Song>[];
      if (songs.isEmpty) {
        NetworkErrorNotifier.show('专辑暂无可用歌曲');
        return null;
      }
      return songs;
    } catch (_) {
      NetworkErrorNotifier.show('网络异常，专辑加载失败');
      return null;
    }
  }

  void _invalidateAlbumQueries() {
    hostRef.invalidate(starredProvider);
    hostRef.invalidate(allAlbumsProvider);
    hostRef.invalidate(recentAlbumsProvider);
    hostRef.invalidate(frequentAlbumsProvider);
    hostRef.invalidate(albumDetailProvider(album.id));
    final artistId = album.artistId;
    if (artistId != null && artistId.trim().isNotEmpty) {
      hostRef.invalidate(artistDetailProvider(artistId));
    }
  }

  void _closeAndRun(BuildContext sheetContext, Future<void> Function() action) {
    Navigator.of(sheetContext).pop();
    Future<void>.microtask(() async {
      if (!hostContext.mounted) return;
      await action();
    });
  }

  void _showMessage(String message) {
    if (!hostContext.mounted) return;
    ToastNotifier.show(message, kind: EchoMessageKind.success);
  }
}

class _AddAlbumToPlaylistSheet extends ConsumerWidget {
  const _AddAlbumToPlaylistSheet({
    required this.hostContext,
    required this.album,
    required this.songs,
  });

  final BuildContext hostContext;
  final Album album;
  final List<Song> songs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistsAsync = ref.watch(playlistsProvider);
    final loadFailed = ref.watch(playlistsLoadFailedProvider);
    final songIds = songs.map((song) => song.id).toSet().toList();
    final maxListHeight = MediaQuery.sizeOf(context).height * 0.56;

    return EchoBottomSheet(
      title: '添加到歌单',
      subtitle: album.name,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxListHeight),
        child: playlistsAsync.when(
          data: (playlists) {
            if (playlists.isEmpty) {
              return EchoEmptyState(
                title: loadFailed ? '歌单暂时不可用' : '还没有歌单',
                description: loadFailed ? '网络连接恢复后重试。' : '先创建一个歌单，再把这张专辑加入其中。',
                icon: loadFailed ? AppIcons.cloudOff : AppIcons.playlist,
                actionLabel: loadFailed ? '重试' : null,
                onAction: loadFailed
                    ? () => ref.invalidate(playlistsProvider)
                    : null,
                padding: const EdgeInsets.all(24),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                final playlist = playlists[index];
                return EchoActionRow(
                  icon: AppIcons.playlist,
                  title: playlist.name,
                  subtitle: '${playlist.songCount} 首',
                  onPressed: () {
                    Navigator.of(context).pop();
                    unawaited(
                      _addToPlaylist(
                        ref: ref,
                        playlistId: playlist.id,
                        playlistName: playlist.name,
                        songIds: songIds,
                      ),
                    );
                  },
                );
              },
            );
          },
          loading: () => const _PlaylistSkeletonList(),
          error: (_, _) => EchoErrorState(
            title: '歌单加载失败',
            description: '无法读取歌单，请检查网络后重试。',
            actionLabel: '重试',
            onAction: () => ref.invalidate(playlistsProvider),
            padding: const EdgeInsets.all(24),
          ),
        ),
      ),
    );
  }

  Future<void> _addToPlaylist({
    required WidgetRef ref,
    required String playlistId,
    required String playlistName,
    required List<String> songIds,
  }) async {
    final repository = ref.read(playlistRepositoryProvider);
    if (repository == null) {
      NetworkErrorNotifier.show('未选择音乐库');
      return;
    }

    try {
      await ref.read(ensureActiveAddressProvider.future);
      await repository.updatePlaylist(
        playlistId: playlistId,
        songIdsToAdd: songIds,
      );
      ref.invalidate(playlistsProvider);
      ref.invalidate(playlistDetailProvider(playlistId));
      if (hostContext.mounted) {
        ToastNotifier.show(
          '已将「${album.name}」添加到歌单「$playlistName」',
          kind: EchoMessageKind.success,
        );
      }
    } catch (_) {
      NetworkErrorNotifier.show('网络异常，添加失败');
    }
  }
}

class _PlaylistSkeletonList extends StatelessWidget {
  const _PlaylistSkeletonList();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 3,
      separatorBuilder: (context, index) =>
          SizedBox(height: context.echoSpacing.xs),
      itemBuilder: (context, index) => Row(
        children: <Widget>[
          const EchoSkeleton.circle(size: 48),
          SizedBox(width: context.echoSpacing.sm),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                EchoSkeleton.line(width: 160),
                SizedBox(height: 8),
                EchoSkeleton.line(width: 72, height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
