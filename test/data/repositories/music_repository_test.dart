import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:echoes/data/repositories/music_repository.dart';
import 'package:echoes/data/models/song.dart';
import 'package:echoes/data/models/album.dart';
import '../../helpers/mocks.dart';

void main() {
  late MockSubsonicApiClient mockApiClient;
  late MusicRepository repository;

  setUp(() {
    mockApiClient = MockSubsonicApiClient();
    repository = MusicRepository(mockApiClient);
  });

  // -------------------------------------------------------------------------
  // Fixtures
  // -------------------------------------------------------------------------

  Map<String, dynamic> songJson({String id = 's1'}) => {
        'id': id,
        'title': 'Song $id',
        'artist': 'Artist',
        'duration': 200,
      };

  Map<String, dynamic> albumJson({String id = 'a1'}) => {
        'id': id,
        'name': 'Album $id',
        'songCount': 10,
        'duration': 3000,
      };

  Map<String, dynamic> artistJson({String id = 'ar1'}) => {
        'id': id,
        'name': 'Artist $id',
      };

  // -------------------------------------------------------------------------
  // getAlbumList
  // -------------------------------------------------------------------------

  group('getAlbumList', () {
    test('returns parsed Album list from API response', () async {
      when(
        () => mockApiClient.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer((_) async => {
            'albumList2': {
              'album': [albumJson(id: 'a1'), albumJson(id: 'a2')],
            },
          });

      final albums = await repository.getAlbumList(type: 'recent', size: 10);

      expect(albums.length, 2);
      expect(albums.first, isA<Album>());
      expect(albums.first.id, 'a1');
      expect(albums.last.id, 'a2');
    });

    test('returns empty list when albumList2.album is null', () async {
      when(
        () => mockApiClient.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer((_) async => {
            'albumList2': {'album': null},
          });

      final albums = await repository.getAlbumList(type: 'recent');
      expect(albums, isEmpty);
    });

    test('returns empty list when albumList2 is null', () async {
      when(
        () => mockApiClient.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer((_) async => {'albumList2': null});

      final albums = await repository.getAlbumList(type: 'recent');
      expect(albums, isEmpty);
    });

    test('rethrows on API exception', () async {
      when(
        () => mockApiClient.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenThrow(Exception('network error'));

      expect(
        () => repository.getAlbumList(type: 'recent'),
        throwsException,
      );
    });
  });

  // -------------------------------------------------------------------------
  // getAlbum (detail)
  // -------------------------------------------------------------------------

  group('getAlbum', () {
    test('returns AlbumDetail with songs', () async {
      when(
        () => mockApiClient.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer((_) async => {
            'album': {
              ...albumJson(id: 'a1'),
              'song': [songJson(id: 's1'), songJson(id: 's2')],
            },
          });

      final detail = await repository.getAlbum('a1');

      expect(detail, isNotNull);
      expect(detail!.album.id, 'a1');
      expect(detail.songs.length, 2);
    });

    test('returns null when album data is null', () async {
      when(
        () => mockApiClient.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer((_) async => {'album': null});

      final detail = await repository.getAlbum('missing');
      expect(detail, isNull);
    });

    test('returns AlbumDetail with empty songs when no song list', () async {
      when(
        () => mockApiClient.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer((_) async => {
            'album': albumJson(id: 'empty'),
          });

      final detail = await repository.getAlbum('empty');
      expect(detail, isNotNull);
      expect(detail!.songs, isEmpty);
    });
  });

  // -------------------------------------------------------------------------
  // getArtists
  // -------------------------------------------------------------------------

  group('getArtists', () {
    test('parses nested index/artist structure', () async {
      when(
        () => mockApiClient.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer((_) async => {
            'artists': {
              'index': [
                {
                  'name': 'A',
                  'artist': [artistJson(id: 'ar1'), artistJson(id: 'ar2')],
                },
                {
                  'name': 'B',
                  'artist': [artistJson(id: 'ar3')],
                },
              ],
            },
          });

      final artists = await repository.getArtists();
      expect(artists.length, 3);
      expect(artists.map((a) => a.id), containsAll(['ar1', 'ar2', 'ar3']));
    });

    test('returns empty when index is null', () async {
      when(
        () => mockApiClient.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer((_) async => {
            'artists': {'index': null},
          });

      expect(await repository.getArtists(), isEmpty);
    });
  });

  // -------------------------------------------------------------------------
  // getRandomSongs
  // -------------------------------------------------------------------------

  group('getRandomSongs', () {
    test('returns parsed Song list', () async {
      when(
        () => mockApiClient.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer((_) async => {
            'randomSongs': {
              'song': [songJson(id: 'r1'), songJson(id: 'r2')],
            },
          });

      final songs = await repository.getRandomSongs(size: 20);
      expect(songs.length, 2);
      expect(songs.first, isA<Song>());
    });

    test('returns empty when song list is null', () async {
      when(
        () => mockApiClient.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer((_) async => {'randomSongs': null});

      expect(await repository.getRandomSongs(), isEmpty);
    });
  });

  // -------------------------------------------------------------------------
  // getAllSongs
  // -------------------------------------------------------------------------

  group('getAllSongs', () {
    test('parses search3 response as song list', () async {
      when(
        () => mockApiClient.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer((_) async => {
            'searchResult3': {
              'song': [songJson(id: 'all1'), songJson(id: 'all2')],
            },
          });

      final songs = await repository.getAllSongs();
      expect(songs.length, 2);
    });

    test('returns empty when searchResult3 is null', () async {
      when(
        () => mockApiClient.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer((_) async => {'searchResult3': null});

      expect(await repository.getAllSongs(), isEmpty);
    });
  });

  // -------------------------------------------------------------------------
  // getArtist (detail)
  // -------------------------------------------------------------------------

  group('getArtist', () {
    test('returns ArtistDetail with albums and top songs', () async {
      // First call: getArtist
      // Second call: getTopSongs
      var callCount = 0;
      when(
        () => mockApiClient.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer((_) async {
        callCount++;
        if (callCount == 1) {
          return {
            'artist': {
              ...artistJson(id: 'ar1'),
              'album': [albumJson(id: 'al1')],
            },
          };
        } else {
          return {
            'topSongs': {
              'song': [songJson(id: 'ts1')],
            },
          };
        }
      });

      final detail = await repository.getArtist('ar1');
      expect(detail, isNotNull);
      expect(detail!.artist.id, 'ar1');
      expect(detail.albums.length, 1);
      expect(detail.songs.length, 1);
    });

    test('returns null when artist data is null', () async {
      when(
        () => mockApiClient.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer((_) async => {'artist': null});

      expect(await repository.getArtist('missing'), isNull);
    });

    test('still returns ArtistDetail when topSongs fails', () async {
      var callCount = 0;
      when(
        () => mockApiClient.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer((_) async {
        callCount++;
        if (callCount == 1) {
          return {
            'artist': {
              ...artistJson(id: 'ar1'),
              'album': [albumJson(id: 'al1')],
            },
          };
        } else {
          throw Exception('topSongs failed');
        }
      });

      final detail = await repository.getArtist('ar1');
      expect(detail, isNotNull);
      expect(detail!.songs, isEmpty); // graceful fallback
    });
  });

  // -------------------------------------------------------------------------
  // search
  // -------------------------------------------------------------------------

  group('search', () {
    test('returns SearchResult with all three types', () async {
      when(
        () => mockApiClient.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer((_) async => {
            'searchResult3': {
              'artist': [artistJson()],
              'album': [albumJson()],
              'song': [songJson()],
            },
          });

      final result = await repository.search(query: 'test');
      expect(result.artists.length, 1);
      expect(result.albums.length, 1);
      expect(result.songs.length, 1);
    });

    test('returns empty result when no matches', () async {
      when(
        () => mockApiClient.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer((_) async => {'searchResult3': {}});

      final result = await repository.search(query: 'nomatch');
      expect(result.artists, isEmpty);
      expect(result.albums, isEmpty);
      expect(result.songs, isEmpty);
    });
  });
}
