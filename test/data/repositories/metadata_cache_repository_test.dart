import 'package:echoes/data/models/playlist.dart';
import 'package:echoes/data/models/song.dart';
import 'package:echoes/data/repositories/metadata_cache_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
  });

  test('song removal repairs detail and summary caches', () async {
    final repository = MetadataCacheRepository();
    final songs = <Song>[
      Song(id: 'song-a', title: 'A', duration: 100),
      Song(id: 'song-b', title: 'B', duration: 200),
      Song(id: 'song-c', title: 'C', duration: 300),
    ];
    final playlist = Playlist(
      id: 'playlist-1',
      name: 'Cached playlist',
      songCount: songs.length,
      duration: 600,
      songs: songs,
    );
    await repository.cachePlaylistDetail('library-1', playlist);
    await repository.cachePlaylists('library-1', <Playlist>[
      Playlist(
        id: playlist.id,
        name: playlist.name,
        songCount: playlist.songCount,
        duration: playlist.duration,
      ),
    ]);

    await repository.cachePlaylistSongRemoval(
      libraryId: 'library-1',
      playlist: playlist,
      removedIndexes: <int>{1},
    );

    final detail = await repository.getPlaylistDetail('library-1', playlist.id);
    final summaries = await repository.getPlaylists('library-1');
    expect(detail, isNotNull);
    expect(detail!.songs!.map((song) => song.id), <String>['song-a', 'song-c']);
    expect(detail.songCount, 2);
    expect(detail.duration, 400);
    expect(summaries, isNotNull);
    expect(summaries!.single.songCount, 2);
    expect(summaries.single.duration, 400);
  });
}
