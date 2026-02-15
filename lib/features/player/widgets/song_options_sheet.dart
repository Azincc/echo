import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/network_error_notifier.dart';
import '../../../data/models/song.dart';
import '../../../providers/api_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../providers/playlist_provider.dart';
import '../../library/pages/album_detail_page.dart';
import '../../library/pages/artist_detail_page.dart';

class SongOptionsExtraAction {
  final IconData icon;
  final String title;
  final bool isDestructive;
  final FutureOr<void> Function() onPressed;

  const SongOptionsExtraAction({
    required this.icon,
    required this.title,
    required this.onPressed,
    this.isDestructive = false,
  });
}

Future<void> showSongOptionsSheet({
  required BuildContext context,
  required Song song,
  bool useRootNavigator = true,
  List<SongOptionsExtraAction> extraActions = const [],
}) async {
  await showModalBottomSheet<void>(
    context: context,
    useRootNavigator: useRootNavigator,
    isScrollControlled: true,
    enableDrag: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) => _SongOptionsSheet(
      hostContext: context,
      song: song,
      extraActions: extraActions,
    ),
  );
}

class _SongOptionsSheet extends ConsumerWidget {
  final BuildContext hostContext;
  final Song song;
  final List<SongOptionsExtraAction> extraActions;

  const _SongOptionsSheet({
    required this.hostContext,
    required this.song,
    required this.extraActions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSongId = ref.watch(
      playerProvider.select((s) => s.currentSong?.id),
    );
    final isCurrentSong = currentSongId != null && currentSongId == song.id;
    final artistName = (song.artist == null || song.artist!.trim().isEmpty)
        ? '未知歌手'
        : song.artist!;
    final albumName = (song.album == null || song.album!.trim().isEmpty)
        ? '未知专辑'
        : song.album!;
    final canOpenArtist =
        song.artistId != null && song.artistId!.trim().isNotEmpty;
    final canOpenAlbum =
        song.albumId != null && song.albumId!.trim().isNotEmpty;

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
                  song.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  '$artistName · $albumName',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Divider(height: 1),
              _buildActionTile(
                context: context,
                icon: song.starred ? Icons.favorite : Icons.favorite_border,
                title: song.starred ? '取消红心' : '红心',
                onTap: () async {
                  await _closeAndRun(context, () async {
                    final newStarred = await ref
                        .read(playerProvider.notifier)
                        .toggleSongFavorite(song);
                    if (newStarred == null) {
                      NetworkErrorNotifier.show('操作失败');
                      return;
                    }
                    _showSnackBar(newStarred ? '已添加红心' : '已取消红心');
                  });
                },
              ),
              _buildActionTile(
                context: context,
                icon: Icons.playlist_add,
                title: '添加到歌单',
                onTap: () async {
                  await _closeAndRun(context, () async {
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
                      builder: (_) => _AddToPlaylistSheet(
                        hostContext: hostContext,
                        song: song,
                      ),
                    );
                  });
                },
              ),
              if (!isCurrentSong)
                _buildActionTile(
                  context: context,
                  icon: Icons.queue_play_next,
                  title: '下一曲播放',
                  onTap: () async {
                    await _closeAndRun(context, () async {
                      await ref.read(playerProvider.notifier).playNext(song);
                      _showSnackBar('已添加到下一曲');
                    });
                  },
                ),
              _buildActionTile(
                context: context,
                icon: Icons.person_outline,
                title: '歌手：$artistName',
                enabled: canOpenArtist,
                onTap: !canOpenArtist
                    ? null
                    : () async {
                        await _closeAndRun(context, () async {
                          Navigator.of(hostContext).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  ArtistDetailPage(artistId: song.artistId!),
                            ),
                          );
                        });
                      },
              ),
              _buildActionTile(
                context: context,
                icon: Icons.album_outlined,
                title: '专辑：$albumName',
                enabled: canOpenAlbum,
                onTap: !canOpenAlbum
                    ? null
                    : () async {
                        await _closeAndRun(context, () async {
                          Navigator.of(hostContext).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  AlbumDetailPage(albumId: song.albumId!),
                            ),
                          );
                        });
                      },
              ),
              if (extraActions.isNotEmpty) const Divider(height: 1),
              for (final action in extraActions)
                _buildActionTile(
                  context: context,
                  icon: action.icon,
                  title: action.title,
                  textColor: action.isDestructive
                      ? Theme.of(context).colorScheme.error
                      : null,
                  iconColor: action.isDestructive
                      ? Theme.of(context).colorScheme.error
                      : null,
                  onTap: () async {
                    await _closeAndRun(context, () async {
                      await action.onPressed();
                    });
                  },
                ),
            ],
          ),
        ),
      ),
    );
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
    Color? iconColor,
    Color? textColor,
    bool enabled = true,
    Future<void> Function()? onTap,
  }) {
    final disabledColor = Theme.of(
      context,
    ).colorScheme.onSurfaceVariant.withValues(alpha: 0.5);

    return ListTile(
      enabled: enabled,
      leading: Icon(icon, color: enabled ? iconColor : disabledColor),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: enabled ? textColor : disabledColor),
      ),
      onTap: enabled && onTap != null ? onTap : null,
    );
  }
}

class _AddToPlaylistSheet extends ConsumerWidget {
  final BuildContext hostContext;
  final Song song;

  const _AddToPlaylistSheet({required this.hostContext, required this.song});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistsAsync = ref.watch(playlistsProvider);
    final loadFailed = ref.watch(playlistsLoadFailedProvider);

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
                    '添加到歌单',
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
                              songIdsToAdd: [song.id],
                            );
                            ref.invalidate(playlistsProvider);
                            ref.invalidate(playlistDetailProvider(playlist.id));
                            if (hostContext.mounted) {
                              ScaffoldMessenger.of(hostContext).showSnackBar(
                                SnackBar(
                                  content: Text('已添加到歌单「${playlist.name}」'),
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
