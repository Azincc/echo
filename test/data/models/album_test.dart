import 'package:flutter_test/flutter_test.dart';
import 'package:echoes/data/models/album.dart';

void main() {
  // -------------------------------------------------------------------------
  // Test fixtures
  // -------------------------------------------------------------------------

  Map<String, dynamic> fullJson() => {
        'id': 'album-1',
        'name': 'Test Album',
        'artist': 'Test Artist',
        'artistId': 'artist-1',
        'coverArt': 'cover-1',
        'songCount': 12,
        'duration': 3600,
        'playCount': 100,
        'created': '2024-06-15T12:00:00.000Z',
        'year': 2024,
        'genre': 'Jazz',
        'starred': '2024-07-01T00:00:00.000Z',
      };

  Map<String, dynamic> minimalJson() => {
        'id': 'album-min',
        'name': 'Minimal Album',
      };

  // -------------------------------------------------------------------------
  // fromJson
  // -------------------------------------------------------------------------

  group('Album.fromJson', () {
    test('parses full JSON with all fields', () {
      final album = Album.fromJson(fullJson());

      expect(album.id, 'album-1');
      expect(album.name, 'Test Album');
      expect(album.artist, 'Test Artist');
      expect(album.artistId, 'artist-1');
      expect(album.coverArt, 'cover-1');
      expect(album.songCount, 12);
      expect(album.duration, 3600);
      expect(album.playCount, 100);
      expect(album.created, isA<DateTime>());
      expect(album.year, 2024);
      expect(album.genre, 'Jazz');
      expect(album.starred, true);
    });

    test('parses minimal JSON — optional fields default', () {
      final album = Album.fromJson(minimalJson());

      expect(album.id, 'album-min');
      expect(album.name, 'Minimal Album');
      expect(album.artist, isNull);
      expect(album.songCount, 0); // defaults from ?? 0
      expect(album.duration, 0); // defaults from ?? 0
      expect(album.starred, false);
    });

    test('starred is true when starred field is non-null', () {
      final json = minimalJson()..['starred'] = '2024-01-01';
      expect(Album.fromJson(json).starred, true);
    });

    test('starred is false when starred field is absent', () {
      expect(Album.fromJson(minimalJson()).starred, false);
    });
  });

  // -------------------------------------------------------------------------
  // toJson round-trip
  // -------------------------------------------------------------------------

  group('Album.toJson', () {
    test('round-trip: fromJson → toJson → fromJson consistent', () {
      final original = Album.fromJson(fullJson());
      final roundTripped = Album.fromJson(original.toJson());

      expect(roundTripped.id, original.id);
      expect(roundTripped.name, original.name);
      expect(roundTripped.artist, original.artist);
      expect(roundTripped.songCount, original.songCount);
      expect(roundTripped.duration, original.duration);
      expect(roundTripped.year, original.year);
      expect(roundTripped.genre, original.genre);
    });

    test('toJson includes all fields', () {
      final json = Album.fromJson(fullJson()).toJson();

      expect(json['id'], 'album-1');
      expect(json['name'], 'Test Album');
      expect(json['songCount'], 12);
      expect(json['duration'], 3600);
      expect(json['year'], 2024);
    });
  });

  // -------------------------------------------------------------------------
  // durationString
  // -------------------------------------------------------------------------

  group('Album.durationString', () {
    test('formats correctly', () {
      final album = Album(id: '1', name: 'A', songCount: 0, duration: 3661);
      expect(album.durationString, '61:01');
    });

    test('formats zero duration', () {
      final album = Album(id: '1', name: 'A', songCount: 0, duration: 0);
      expect(album.durationString, '00:00');
    });
  });
}
