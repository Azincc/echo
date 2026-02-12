import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/playlist_provider.dart';
import '../../../widgets/main_scaffold.dart';
import 'album_list_page.dart';
import 'artist_list_page.dart';
import 'playlist_detail_page.dart';
import 'song_list_page.dart';
import 'starred_page.dart';

/// 我的页面 - Tab 2
class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistsAsync = ref.watch(playlistsProvider);
    final starredAsync = ref.watch(starredProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // 使用 GlobalKey 打开侧栏
            scaffoldKey.currentState?.openDrawer();
          },
        ),
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
              error: (error, stack) => const SizedBox.shrink(),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StarredPage()),
              );
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              '我的歌单',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
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
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.music_note),
            title: const Text('全部歌曲'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SongListPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.album),
            title: const Text('按专辑浏览'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AlbumListPage()),
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
                MaterialPageRoute(builder: (context) => const ArtistListPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
