import 'package:flutter_test/flutter_test.dart';
import 'package:echoes/data/models/artist.dart';

void main() {
  // -------------------------------------------------------------------------
  // Test fixtures
  // -------------------------------------------------------------------------

  Map<String, dynamic> fullJson() => {
        'id': 'artist-1',
        'name': 'Test Artist',
        'coverArt': 'cover-artist-1',
        'albumCount': 5,
        'starred': '2024-03-01T00:00:00.000Z',
      };

  Map<String, dynamic> minimalJson() => {
        'id': 'artist-min',
        'name': 'Minimal Artist',
      };

  // -------------------------------------------------------------------------
  // fromJson
  // -------------------------------------------------------------------------

  group('Artist.fromJson', () {
    test('parses full JSON', () {
      final artist = Artist.fromJson(fullJson());

      expect(artist.id, 'artist-1');
      expect(artist.name, 'Test Artist');
      expect(artist.coverArt, 'cover-artist-1');
      expect(artist.albumCount, 5);
      expect(artist.starred, true);
    });

    test('parses minimal JSON', () {
      final artist = Artist.fromJson(minimalJson());

      expect(artist.id, 'artist-min');
      expect(artist.name, 'Minimal Artist');
      expect(artist.coverArt, isNull);
      expect(artist.albumCount, isNull);
      expect(artist.starred, false);
    });

    test('starred is false when starred field is absent', () {
      expect(Artist.fromJson(minimalJson()).starred, false);
    });

    test('starred is true when starred field is non-null', () {
      final json = minimalJson()..['starred'] = '2024-01-01';
      expect(Artist.fromJson(json).starred, true);
    });
  });

  // -------------------------------------------------------------------------
  // toJson round-trip
  // -------------------------------------------------------------------------

  group('Artist.toJson', () {
    test('round-trip: fromJson → toJson → fromJson consistent', () {
      final original = Artist.fromJson(fullJson());
      final roundTripped = Artist.fromJson(original.toJson());

      expect(roundTripped.id, original.id);
      expect(roundTripped.name, original.name);
      expect(roundTripped.coverArt, original.coverArt);
      expect(roundTripped.albumCount, original.albumCount);
    });

    test('toJson includes all fields', () {
      final json = Artist.fromJson(fullJson()).toJson();
      expect(json.containsKey('id'), true);
      expect(json.containsKey('name'), true);
      expect(json.containsKey('coverArt'), true);
      expect(json.containsKey('albumCount'), true);
      expect(json.containsKey('starred'), true);
    });
  });
}
