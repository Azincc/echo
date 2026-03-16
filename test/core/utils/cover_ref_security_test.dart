import 'package:echoes/core/utils/cover_ref_security.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('sanitizeServerCoverArtId', () {
    test('accepts plain cover ids', () {
      expect(
        sanitizeServerCoverArtId('cover-123_ab.cd:thumb'),
        'cover-123_ab.cd:thumb',
      );
    });

    test('rejects paths, urls, and traversal payloads', () {
      expect(sanitizeServerCoverArtId('../secret'), isNull);
      expect(sanitizeServerCoverArtId('/sdcard/secret.jpg'), isNull);
      expect(sanitizeServerCoverArtId('file:///sdcard/secret.jpg'), isNull);
      expect(
        sanitizeServerCoverArtId('https://evil.example/cover.jpg'),
        isNull,
      );
      expect(sanitizeServerCoverArtId(r'folder\cover.jpg'), isNull);
      expect(sanitizeServerCoverArtId('cover/id'), isNull);
    });
  });

  group('trusted cover url refs', () {
    test('encodes and extracts trusted cover urls', () {
      final ref = toTrustedCoverUrlRef(
        'https://img.example.com/cover.jpg?size=800',
      );

      expect(ref, 'trusted-url:https://img.example.com/cover.jpg?size=800');
      expect(
        extractTrustedCoverUrl(ref),
        'https://img.example.com/cover.jpg?size=800',
      );
      expect(isTrustedCoverUrlRef(ref), isTrue);
    });

    test('rejects invalid trusted cover urls', () {
      expect(tryToTrustedCoverUrlRef('file:///tmp/cover.jpg'), isNull);
      expect(tryToTrustedCoverUrlRef('javascript:alert(1)'), isNull);
      expect(
        extractTrustedCoverUrl('https://img.example.com/cover.jpg'),
        isNull,
      );
      expect(
        isTrustedCoverUrlRef('trusted-url:file:///tmp/cover.jpg'),
        isFalse,
      );
    });
  });
}
