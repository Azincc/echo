import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/playlist_provider.dart';
import 'album_list_page.dart';
import 'artist_list_page.dart';
import 'playlist_detail_page.dart';

/// 我的页面 - Tab 2
class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistsAsync = ref.watch(playlistsProvider);
    final starredAsync = ref.watch(starredProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
      ),
      body: ListView(
        children: [
          // 我的歌单
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('收藏夹'),
            trailing: starredAsync.when(
              data: (starred) => Text('${starred.songs.length} 首'),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
            onTap: () {
              // TODO: 跳转到收藏夹页面
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              '我的歌单',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          playlistsAsync.when(
            data: (playlists) {
              if (playlists.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(child: Text('暂无歌单')),
                );
              }
              return Column(
                children: playlists.map((playlist) {
                  return ListTile(
                    leading: const Icon(Icons.playlist_play),
                    title: Text(playlist.name),
                    subtitle: Text('${playlist.songCount} 首'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PlaylistDetailPage(playlistId: playlist.id),
                        ),
                      );
                    },
                  );
                }).toList(),
              );
            },
            loading: () => const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => Padding(
              padding: const EdgeInsets.all(24),
              child: Center(child: Text('加载失败: $error')),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              '音乐库浏览',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.album),
            title: const Text('按专辑浏览'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AlbumListPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('按歌手浏览'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ArtistListPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
