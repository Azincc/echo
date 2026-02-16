import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../widgets/cover_art_image.dart';
import '../../library/pages/album_detail_page.dart';
import '../../library/pages/artist_detail_page.dart';
import '../../player/widgets/song_options_sheet.dart';

/// 搜索页面
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        _query = '';
      });
      return;
    }

    setState(() {
      _query = query.trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchResultAsync = _query.isEmpty
        ? null
        : ref.watch(searchProvider(_query));

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: '搜索歌曲、专辑、歌手',
            border: InputBorder.none,
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: _performSearch,
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _query = '';
                });
              },
            ),
        ],
      ),
      body: _query.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    size: 64,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '搜索你喜欢的音乐',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            )
          : searchResultAsync!.when(
              data: (result) {
                if (result.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.search_off, size: 64),
                        const SizedBox(height: 16),
                        Text('未找到 "$_query" 的相关结果'),
                      ],
                    ),
                  );
                }

                return ListView(
                  children: [
                    // 歌曲结果
                    if (result.songs.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const Icon(Icons.music_note),
                            const SizedBox(width: 8),
                            Text(
                              '歌曲 (${result.songs.length})',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      ...result.songs.map((song) {
                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: CoverArtImage(
                              coverArtId: song.coverArt,
                              size: 48,
                            ),
                          ),
                          title: Text(song.title),
                          subtitle: song.artist != null ? Text(song.artist!) : null,
                          trailing: Text(song.durationString),
                          onTap: () {
                            ref.read(playerProvider.notifier).playQueue(
                                  result.songs,
                                  startIndex: result.songs.indexOf(song),
                                );
                          },
                          onLongPress: () {
                            showSongOptionsSheet(context: context, song: song);
                          },
                        );
                      }),
                      const Divider(height: 32),
                    ],

                    // 专辑结果
                    if (result.albums.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const Icon(Icons.album),
                            const SizedBox(width: 8),
                            Text(
                              '专辑 (${result.albums.length})',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      ...result.albums.map((album) {
                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: CoverArtImage(
                              coverArtId: album.coverArt,
                              size: 48,
                            ),
                          ),
                          title: Text(album.name),
                          subtitle: album.artist != null ? Text(album.artist!) : null,
                          trailing: Text('${album.songCount} 首'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AlbumDetailPage(albumId: album.id),
                              ),
                            );
                          },
                        );
                      }),
                      const Divider(height: 32),
                    ],

                    // 歌手结果
                    if (result.artists.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const Icon(Icons.person),
                            const SizedBox(width: 8),
                            Text(
                              '歌手 (${result.artists.length})',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      ...result.artists.map((artist) {
                        return ListTile(
                          leading: CircleAvatar(
                            child: artist.coverArt != null
                                ? ClipOval(
                                    child: CoverArtImage(
                                      coverArtId: artist.coverArt,
                                      size: 40,
                                    ),
                                  )
                                : const Icon(Icons.person),
                          ),
                          title: Text(artist.name),
                          subtitle: Text('${artist.albumCount} 张专辑'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ArtistDetailPage(artistId: artist.id),
                              ),
                            );
                          },
                        );
                      }),
                    ],
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
                    Text('搜索失败: $error'),
                  ],
                ),
              ),
            ),
    );
  }
}
