import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/network_error_notifier.dart';
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
  await showModalBottomSheet<void>(
    context: context,
    useRootNavigator: useRootNavigator,
    isScrollControlled: true,
    enableDrag: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) =>
        _AlbumOptionsSheet(hostContext: context, hostRef: ref, album: album),
  );
}

class _AlbumOptionsSheet extends ConsumerWidget {
  final BuildContext hostContext;
  final WidgetRef hostRef;
  final Album album;

  const _AlbumOptionsSheet({
    required this.hostContext,
    required this.hostRef,
    required this.album,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final libraryId = ref.watch(
      authStateProvider.select((s) => s.currentLibrary?.id ?? ''),
    );
    final canDownload = libraryId.isNotEmpty;
    final artistName = (album.artist == null || album.artist!.trim().isEmpty)
        ? '未知歌手'
        : album.artist!;

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + 8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 8),
              ListTile(
                dense: true,
                title: Text(
                  album.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  artistName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Divider(height: 1),
              _buildActionTile(
                context: context,
                icon: album.starred ? Icons.favorite : Icons.favorite_border,
                title: album.starred ? '取消收藏专辑' : '收藏专辑',
                onTap: () async {
                  await _closeAndRun(context, () async {
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
                      _showSnackBar(nextStarred ? '已收藏专辑' : '已取消收藏');
                    } catch (_) {
                      NetworkErrorNotifier.show('网络异常，操作失败');
                    }
                  });
                },
              ),
              _buildActionTile(
                context: context,
                icon: Icons.download_outlined,
                title: '下载专辑',
                enabled: canDownload,
                onTap: !canDownload
                    ? null
                    : () async {
                        await _closeAndRun(context, () async {
                          final songs = await _loadAlbumSongs();
                          if (songs == null || songs.isEmpty) return;

                          final currentLibraryId =
                              hostRef
                                  .read(authStateProvider)
                                  .currentLibrary
                                  ?.id ??
                              '';
                          if (currentLibraryId.isEmpty) {
                            NetworkErrorNotifier.show('未选择音乐库');
                            return;
                          }

                          await hostRef
                              .read(downloadServiceProvider)
                              .enqueueBatch(songs, libraryId: currentLibraryId);
                          _showSnackBar('已添加 ${songs.length} 首到下载队列');
                        });
                      },
              ),
              _buildActionTile(
                context: context,
                icon: Icons.queue_music_outlined,
                title: '添加到播放列表',
                onTap: () async {
                  await _closeAndRun(context, () async {
                    final songs = await _loadAlbumSongs();
                    if (songs == null || songs.isEmpty) return;
                    hostRef.read(playerProvider.notifier).addAllToQueue(songs);
                    _showSnackBar('已添加 ${songs.length} 首到播放列表');
                  });
                },
              ),
              _buildActionTile(
                context: context,
                icon: Icons.playlist_add,
                title: '添加到歌单',
                onTap: () async {
                  await _closeAndRun(context, () async {
                    final songs = await _loadAlbumSongs();
                    if (songs == null || songs.isEmpty) return;
                    if (!hostContext.mounted) return;

                    await showModalBottomSheet<void>(
                      context: hostContext,
                      useRootNavigator: true,
                      isScrollControlled: true,
                      enableDrag: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (_) => _AddAlbumToPlaylistSheet(
                        hostContext: hostContext,
                        album: album,
                        songs: songs,
                      ),
                    );
                  });
                },
              ),
            ],
          ),
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

  Future<void> _closeAndRun(
    BuildContext sheetContext,
    Future<void> Function() action,
  ) async {
    Navigator.of(sheetContext).pop();
    await Future<void>.delayed(Duration.zero);
    if (!hostContext.mounted) return;
    await action();
  }

  void _showSnackBar(String message) {
    if (!hostContext.mounted) return;
    ScaffoldMessenger.of(
      hostContext,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildActionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    bool enabled = true,
    Future<void> Function()? onTap,
  }) {
    final disabledColor = Theme.of(
      context,
    ).colorScheme.onSurfaceVariant.withValues(alpha: 0.5);

    return ListTile(
      enabled: enabled,
      leading: Icon(icon, color: enabled ? null : disabledColor),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: enabled ? null : disabledColor),
      ),
      onTap: enabled && onTap != null ? onTap : null,
    );
  }
}

class _AddAlbumToPlaylistSheet extends ConsumerWidget {
  final BuildContext hostContext;
  final Album album;
  final List<Song> songs;

  const _AddAlbumToPlaylistSheet({
    required this.hostContext,
    required this.album,
    required this.songs,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistsAsync = ref.watch(playlistsProvider);
    final loadFailed = ref.watch(playlistsLoadFailedProvider);
    final songIds = songs.map((song) => song.id).toSet().toList();

    return SafeArea(
      top: false,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.72,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  Text(
                    '添加专辑到歌单',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Flexible(
              child: playlistsAsync.when(
                data: (playlists) {
                  if (playlists.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(loadFailed ? '网络异常，歌单加载失败' : '暂无歌单'),
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: playlists.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final playlist = playlists[index];
                      return ListTile(
                        leading: const Icon(Icons.playlist_play),
                        title: Text(
                          playlist.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text('${playlist.songCount} 首'),
                        onTap: () async {
                          Navigator.of(context).pop();
                          final repository = ref.read(
                            playlistRepositoryProvider,
                          );
                          if (repository == null) {
                            NetworkErrorNotifier.show('未选择音乐库');
                            return;
                          }

                          try {
                            await ref.read(ensureActiveAddressProvider.future);
                            await repository.updatePlaylist(
                              playlistId: playlist.id,
                              songIdsToAdd: songIds,
                            );
                            ref.invalidate(playlistsProvider);
                            ref.invalidate(playlistDetailProvider(playlist.id));
                            if (hostContext.mounted) {
                              ScaffoldMessenger.of(hostContext).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '已将「${album.name}」添加到歌单「${playlist.name}」',
                                  ),
                                ),
                              );
                            }
                          } catch (_) {
                            NetworkErrorNotifier.show('网络异常，添加失败');
                          }
                        },
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, _) => const Center(child: Text('歌单加载失败')),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
          ],
        ),
      ),
    );
  }
}
