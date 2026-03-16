import 'package:echoes/core/utils/download_path_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

void main() {
  group('buildDownloadFilePath', () {
    final root = p.join('downloads', 'Echoes');

    test('keeps safe inputs unchanged under the download root', () {
      final path = buildDownloadFilePath(
        rootDir: root,
        libraryId: 'lib-1',
        songId: 'song_42',
        suffix: 'mp3',
      );

      expect(p.isWithin(root, path), isTrue);
      expect(p.dirname(path), p.join(root, 'lib-1'));
      expect(p.basename(path), 'song_42.mp3');
    });

    test('sanitizes traversal payloads and absolute path markers', () {
      final path = buildDownloadFilePath(
        rootDir: root,
        libraryId: '../library',
        songId: r'..\..\Download\evil',
        suffix: '../aac',
      );

      expect(p.isWithin(root, path), isTrue);
      expect(
        p.basename(p.dirname(path)),
        matches(RegExp(r'^library_[0-9a-f]{12}$')),
      );
      expect(
        p.basenameWithoutExtension(path),
        matches(RegExp(r'^Download_evil_[0-9a-f]{12}$')),
      );
      expect(p.extension(path), '.aac');
    });

    test('falls back for empty or separator-only path components', () {
      final path = buildDownloadFilePath(
        rootDir: root,
        libraryId: '///',
        songId: '   ',
        suffix: '***',
      );

      expect(p.isWithin(root, path), isTrue);
      expect(
        p.basename(p.dirname(path)),
        matches(RegExp(r'^library_[0-9a-f]{12}$')),
      );
      expect(
        p.basenameWithoutExtension(path),
        matches(RegExp(r'^song_[0-9a-f]{12}$')),
      );
      expect(p.extension(path), '.mp3');
    });

    test('adds a stable hash to avoid collisions after sanitization', () {
      final pathA = buildDownloadFilePath(
        rootDir: root,
        libraryId: 'lib',
        songId: 'A/B',
        suffix: 'mp3',
      );
      final pathB = buildDownloadFilePath(
        rootDir: root,
        libraryId: 'lib',
        songId: 'A?B',
        suffix: 'mp3',
      );

      expect(pathA, isNot(pathB));
      expect(
        p.basenameWithoutExtension(pathA),
        matches(RegExp(r'^A_B_[0-9a-f]{12}$')),
      );
      expect(
        p.basenameWithoutExtension(pathB),
        matches(RegExp(r'^A_B_[0-9a-f]{12}$')),
      );
    });
  });

  group('buildCacheFilePath', () {
    final root = p.join('cache', 'echo_audio_cache');

    test('keeps cache files under the cache root', () {
      final path = buildCacheFilePath(
        rootDir: root,
        libraryId: 'lib-1',
        songId: 'song_42',
        qualityName: 'original',
      );

      expect(isPathWithinRoot(rootDir: root, candidatePath: path), isTrue);
      expect(p.dirname(path), p.join(root, 'lib-1'));
      expect(p.basename(path), 'song_42_original.cache');
    });

    test('sanitizes traversal payloads in cache paths', () {
      final path = buildCacheFilePath(
        rootDir: root,
        libraryId: '../library',
        songId: r'..\..\evil',
        qualityName: 'original',
      );

      expect(isPathWithinRoot(rootDir: root, candidatePath: path), isTrue);
      expect(
        p.basename(p.dirname(path)),
        matches(RegExp(r'^library_[0-9a-f]{12}$')),
      );
      expect(
        p.basenameWithoutExtension(path),
        matches(RegExp(r'^evil_[0-9a-f]{12}_original$')),
      );
    });
  });

  group('isPathWithinRoot', () {
    final root = p.join('root', 'safe');

    test('returns true for descendants and false for escaped paths', () {
      expect(
        isPathWithinRoot(
          rootDir: root,
          candidatePath: p.join(root, 'child', 'file.txt'),
        ),
        isTrue,
      );
      expect(
        isPathWithinRoot(
          rootDir: root,
          candidatePath: p.normalize(p.join(root, '..', 'other', 'file.txt')),
        ),
        isFalse,
      );
    });

    test('can allow the root path itself when requested', () {
      expect(isPathWithinRoot(rootDir: root, candidatePath: root), isFalse);
      expect(
        isPathWithinRoot(rootDir: root, candidatePath: root, allowRoot: true),
        isTrue,
      );
    });
  });
}
