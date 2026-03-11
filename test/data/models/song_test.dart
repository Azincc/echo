import 'package:flutter_test/flutter_test.dart';
import 'package:echoes/data/models/song.dart';

void main() {
  // -------------------------------------------------------------------------
  // Test fixtures
  // -------------------------------------------------------------------------

  Map<String, dynamic> fullJson() => {
        'id': 'song-1',
        'title': 'Test Song',
        'album': 'Test Album',
        'albumId': 'album-1',
        'artist': 'Test Artist',
        'artistId': 'artist-1',
        'track': 3,
        'year': 2024,
        'genre': 'Rock',
        'coverArt': 'cover-1',
        'size': 5242880,
        'contentType': 'audio/flac',
        'suffix': 'flac',
        'duration': 245,
        'bitRate': 320,
        'bitDepth': 24,
        'samplingRate': 96000,
        'channelCount': 2,
        'path': '/music/test.flac',
        'isVideo': false,
        'playCount': 42,
        'created': '2024-01-15T10:30:00.000Z',
        'starred': '2024-02-01T00:00:00.000Z',
        'discNumber': 1,
        'type': 'music',
      };

  Map<String, dynamic> minimalJson() => {
        'id': 'song-min',
        'title': 'Minimal Song',
      };

  // -------------------------------------------------------------------------
  // fromJson
  // -------------------------------------------------------------------------

  group('Song.fromJson', () {
    test('parses full JSON with all fields', () {
      final song = Song.fromJson(fullJson());

      expect(song.id, 'song-1');
      expect(song.title, 'Test Song');
      expect(song.album, 'Test Album');
      expect(song.albumId, 'album-1');
      expect(song.artist, 'Test Artist');
      expect(song.artistId, 'artist-1');
      expect(song.track, 3);
      expect(song.year, 2024);
      expect(song.genre, 'Rock');
      expect(song.coverArt, 'cover-1');
      expect(song.size, 5242880);
      expect(song.contentType, 'audio/flac');
      expect(song.suffix, 'flac');
      expect(song.duration, 245);
      expect(song.bitRate, 320);
      expect(song.bitDepth, 24);
      expect(song.samplingRate, 96000);
      expect(song.channelCount, 2);
      expect(song.path, '/music/test.flac');
      expect(song.isVideo, false);
      expect(song.playCount, 42);
      expect(song.created, isA<DateTime>());
      expect(song.starred, true);
      expect(song.discNumber, 1);
      expect(song.type, 'music');
    });

    test('parses minimal JSON with only required fields', () {
      final song = Song.fromJson(minimalJson());

      expect(song.id, 'song-min');
      expect(song.title, 'Minimal Song');
      expect(song.album, isNull);
      expect(song.artist, isNull);
      expect(song.duration, isNull);
      expect(song.bitDepth, isNull);
      expect(song.samplingRate, isNull);
      expect(song.channelCount, isNull);
      expect(song.starred, false);
      expect(song.isPreview, false);
    });

    test('starred is true when starred field is non-null', () {
      final json = minimalJson()..['starred'] = '2024-01-01T00:00:00.000Z';
      expect(Song.fromJson(json).starred, true);
    });

    test('starred is false when starred field is absent', () {
      expect(Song.fromJson(minimalJson()).starred, false);
    });

    test('starred is false when starred field is null', () {
      final json = minimalJson()..['starred'] = null;
      expect(Song.fromJson(json).starred, false);
    });
  });

  // -------------------------------------------------------------------------
  // toJson round-trip
  // -------------------------------------------------------------------------

  group('Song.toJson', () {
    test('round-trip: fromJson → toJson → fromJson produces equal song', () {
      final original = Song.fromJson(fullJson());
      final roundTripped = Song.fromJson(original.toJson());

      expect(roundTripped.id, original.id);
      expect(roundTripped.title, original.title);
      expect(roundTripped.album, original.album);
      expect(roundTripped.bitDepth, original.bitDepth);
      expect(roundTripped.samplingRate, original.samplingRate);
      expect(roundTripped.channelCount, original.channelCount);
      expect(roundTripped.starred, original.starred);
    });
  });

  // -------------------------------------------------------------------------
  // copyWith
  // -------------------------------------------------------------------------

  group('Song.copyWith', () {
    test('changes only starred, keeps all other fields', () {
      final original = Song.fromJson(fullJson());
      final copy = original.copyWith(starred: false);

      expect(copy.starred, false);
      expect(copy.id, original.id);
      expect(copy.title, original.title);
      expect(copy.bitDepth, original.bitDepth);
      expect(copy.samplingRate, original.samplingRate);
      expect(copy.channelCount, original.channelCount);
      expect(copy.duration, original.duration);
    });

    test('changes id produces new identity', () {
      final original = Song.fromJson(fullJson());
      final copy = original.copyWith(id: 'new-id');

      expect(copy.id, 'new-id');
      expect(copy != original, true);
    });
  });

  // -------------------------------------------------------------------------
  // == and hashCode
  // -------------------------------------------------------------------------

  group('Song equality', () {
    test('same id → equal', () {
      final a = Song(id: 'x', title: 'A');
      final b = Song(id: 'x', title: 'B');

      expect(a, equals(b));
      expect(a.hashCode, b.hashCode);
    });

    test('different id → not equal', () {
      final a = Song(id: 'x', title: 'Same');
      final b = Song(id: 'y', title: 'Same');

      expect(a, isNot(equals(b)));
    });

    test('identical reference → equal', () {
      final song = Song(id: 'z', title: 'Test');
      expect(song, equals(song));
    });
  });

  // -------------------------------------------------------------------------
  // durationString
  // -------------------------------------------------------------------------

  group('Song.durationString', () {
    test('formats seconds correctly', () {
      final song = Song(id: '1', title: 't', duration: 125);
      expect(song.durationString, '02:05');
    });

    test('formats zero duration', () {
      final song = Song(id: '1', title: 't', duration: 0);
      expect(song.durationString, '00:00');
    });

    test('returns --:-- for null duration', () {
      final song = Song(id: '1', title: 't');
      expect(song.durationString, '--:--');
    });

    test('formats large duration correctly', () {
      final song = Song(id: '1', title: 't', duration: 3661);
      expect(song.durationString, '61:01');
    });
  });
}
