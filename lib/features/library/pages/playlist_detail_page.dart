import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/playlist_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../providers/download_provider.dart';
import '../../../providers/auth_provider.dart';

/// 歌单详情页
class PlaylistDetailPage extends ConsumerWidget {
  final String playlistId;

  const PlaylistDetailPage({super.key, required this.playlistId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistAsync = ref.watch(playlistDetailProvider(playlistId));
    final loadFailed = ref.watch(playlistDetailLoadFailedProvider(playlistId));

    return Scaffold(
      appBar: AppBar(title: const Text('歌单')),
      body: playlistAsync.when(
        data: (playlist) {
          if (playlist == null) {
            return Center(child: Text(loadFailed ? '网络异常，歌单加载失败' : '歌单不存在'));
          }

          final songs = playlist.songs ?? [];

          return CustomScrollView(
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
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: () {
                          // 播放全部
                          ref.read(playerProvider.notifier).playQueue(songs);
                        },
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('播放全部'),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {
                          final authState = ref.read(authStateProvider);
                          final libraryId = authState.currentLibrary?.id ?? '';
                          if (libraryId.isEmpty || songs.isEmpty) return;

                          ref
                              .read(downloadServiceProvider)
                              .enqueueBatch(songs, libraryId: libraryId);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('已添加 ${songs.length} 首歌曲到下载队列'),
                            ),
                          );
                        },
                        icon: const Icon(Icons.download_outlined),
                        tooltip: '下载歌单',
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final song = songs[index];
                  return ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text(song.title),
                    subtitle: song.artist != null ? Text(song.artist!) : null,
                    trailing: Text(song.durationString),
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
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 16),
              Text('加载失败: $error'),
            ],
          ),
        ),
      ),
    );
  }

  void _showSongContextMenu(BuildContext context, WidgetRef ref, dynamic song) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text('下载'),
              onTap: () {
                Navigator.pop(context);
                final authState = ref.read(authStateProvider);
                final libraryId = authState.currentLibrary?.id ?? '';
                if (libraryId.isEmpty) return;

                ref
                    .read(downloadServiceProvider)
                    .enqueue(song, libraryId: libraryId);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('已添加「${song.title}」到下载队列')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
