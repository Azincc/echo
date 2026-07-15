import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:echoes/providers/palette_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:palette_generator/palette_generator.dart';

void main() {
  group('BoundedAsyncCache', () {
    test('coalesces concurrent loads for one stable resource key', () async {
      final cache = BoundedAsyncCache<int>(capacity: 2);
      final completer = Completer<int?>();
      var loadCount = 0;

      Future<int?> loader() {
        loadCount += 1;
        return completer.future;
      }

      final first = cache.getOrLoad('library:cover', loader);
      final second = cache.getOrLoad('library:cover', loader);

      expect(loadCount, 1);
      expect(cache.inFlightEntryCount, 1);

      completer.complete(7);
      expect(await Future.wait<int?>(<Future<int?>>[first, second]), <int?>[
        7,
        7,
      ]);
      expect(cache.inFlightEntryCount, 0);
      expect(cache.completedEntryCount, 1);
    });

    test('keeps a bounded least-recently-used result set', () async {
      final cache = BoundedAsyncCache<int>(capacity: 2);
      var reloadedA = 0;
      var reloadedB = 0;

      await cache.getOrLoad('a', () async => 1);
      await cache.getOrLoad('b', () async => 2);
      await cache.getOrLoad('a', () async {
        reloadedA += 1;
        return 10;
      });
      await cache.getOrLoad('c', () async => 3);

      expect(reloadedA, 0);
      expect(cache.containsCompleted('a'), isTrue);
      expect(cache.containsCompleted('b'), isFalse);
      expect(cache.containsCompleted('c'), isTrue);

      expect(
        await cache.getOrLoad('b', () async {
          reloadedB += 1;
          return 20;
        }),
        20,
      );
      expect(reloadedB, 1);
      expect(cache.completedEntryCount, 2);
    });

    test('does not retain failures or null results', () async {
      final cache = BoundedAsyncCache<int>(capacity: 2);

      await expectLater(
        cache.getOrLoad('failed', () async => throw StateError('offline')),
        throwsStateError,
      );
      expect(cache.containsCompleted('failed'), isFalse);

      expect(await cache.getOrLoad('failed', () async => 4), 4);
      expect(await cache.getOrLoad('empty', () async => null), isNull);
      expect(cache.containsCompleted('empty'), isFalse);
    });
  });

  test('media palette requests use source kind and reference as identity', () {
    const coverA = MediaPaletteRequest.coverReference('cover-1');
    const coverB = MediaPaletteRequest.coverReference('cover-1');
    const preview = MediaPaletteRequest.previewUrl('cover-1');

    expect(coverA, coverB);
    expect(coverA.hashCode, coverB.hashCode);
    expect(coverA, isNot(preview));
  });

  test(
    'preview URLs are normalized and loaded through the shared provider',
    () async {
      ImageProvider? requestedImage;
      final expected = PaletteGenerator.fromColors(<PaletteColor>[
        PaletteColor(const Color(0xFF0057A8), 100),
      ]);
      final container = ProviderContainer(
        overrides: <Override>[
          mediaPaletteLoaderProvider.overrideWithValue((imageProvider) async {
            requestedImage = imageProvider;
            return expected;
          }),
        ],
      );
      addTearDown(container.dispose);

      final result = await container.read(
        mediaPaletteProvider(
          const MediaPaletteRequest.previewUrl(
            'https://images.example.test/preview.jpg#player',
          ),
        ).future,
      );

      expect(result, same(expected));
      expect(requestedImage, isA<CachedNetworkImageProvider>());
      expect(
        (requestedImage! as CachedNetworkImageProvider).url,
        'https://images.example.test/preview.jpg',
      );
    },
  );
}
