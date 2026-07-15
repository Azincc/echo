import 'dart:async';

import 'package:echoes/core/design/tokens/echo_colors.dart';
import 'package:echoes/data/models/song.dart';
import 'package:echoes/providers/palette_provider.dart';
import 'package:echoes/providers/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:palette_generator/palette_generator.dart';

import '../features/player/test_player_notifier.dart';

void main() {
  group('EchoMediaVisuals', () {
    test('keeps bright artwork bright and chooses dark foreground', () {
      final visuals = EchoMediaVisuals.fromPalette(
        _palette(<(Color, int)>[
          (const Color(0xFFFFE36B), 120),
          (const Color(0xFF4E77C8), 24),
        ]),
      );

      expect(visuals.stageBase.computeLuminance(), greaterThan(0.35));
      expect(visuals.foreground.computeLuminance(), lessThan(0.05));
      _expectAccessibleVisuals(visuals);
    });

    test('keeps dark artwork dark and chooses light foreground', () {
      final visuals = EchoMediaVisuals.fromPalette(
        _palette(<(Color, int)>[
          (const Color(0xFF101D33), 120),
          (const Color(0xFF8F334B), 28),
        ]),
      );

      expect(visuals.stageBase.computeLuminance(), lessThan(0.18));
      expect(visuals.foreground.computeLuminance(), greaterThan(0.85));
      _expectAccessibleVisuals(visuals);
    });

    test('neutral gray artwork stays neutral across every media surface', () {
      final visuals = EchoMediaVisuals.fromPalette(
        _palette(<(Color, int)>[
          (const Color(0xFF858585), 100),
          (const Color(0xFFB7B7B7), 30),
          (const Color(0xFF4F4F4F), 24),
        ]),
      );

      for (final color in <Color>[
        visuals.stageBase,
        visuals.stageGlow,
        visuals.stageBottom,
        visuals.miniSurface,
        visuals.panelSurface,
      ]) {
        expect(HSLColor.fromColor(color).saturation, lessThan(0.01));
      }
      expect(
        HSLColor.fromColor(visuals.controlAccent).saturation,
        lessThan(0.08),
      );
      _expectAccessibleVisuals(visuals);
    });

    test('low-saturation artwork remains restrained and readable', () {
      final visuals = EchoMediaVisuals.fromPalette(
        _palette(<(Color, int)>[
          (const Color(0xFF718580), 100),
          (const Color(0xFF9A8985), 36),
        ]),
      );

      expect(HSLColor.fromColor(visuals.stageBase).saturation, lessThan(0.30));
      expect(HSLColor.fromColor(visuals.stageGlow).saturation, lessThan(0.40));
      _expectAccessibleVisuals(visuals);
    });

    test('missing and empty palettes share a deterministic fallback', () {
      final missing = EchoMediaVisuals.fromPalette(null);
      final empty = EchoMediaVisuals.fromPalette(
        PaletteGenerator.fromColors(<PaletteColor>[]),
      );

      expect(empty, missing);
      expect(missing, EchoMediaVisuals.fallback());
      _expectAccessibleVisuals(missing);
    });

    test('different bright covers retain distinct media identities', () {
      final amber = EchoMediaVisuals.fromPalette(
        _palette(<(Color, int)>[(const Color(0xFFFFC857), 100)]),
      );
      final cyan = EchoMediaVisuals.fromPalette(
        _palette(<(Color, int)>[(const Color(0xFF55D6BE), 100)]),
      );

      expect(amber.stageBase, isNot(cyan.stageBase));
      expect(amber.stageBase.computeLuminance(), greaterThan(0.25));
      expect(cyan.stageBase.computeLuminance(), greaterThan(0.25));
      expect(
        (HSLColor.fromColor(amber.stageBase).hue -
                HSLColor.fromColor(cyan.stageBase).hue)
            .abs(),
        greaterThan(30),
      );
    });

    test('tiny vibrant noise cannot override the dominant media identity', () {
      final dominantOnly = EchoMediaVisuals.fromPalette(
        _palette(<(Color, int)>[(const Color(0xFF7F8589), 1000)]),
      );
      final withNoise = EchoMediaVisuals.fromPalette(
        _palette(<(Color, int)>[
          (const Color(0xFF7F8589), 1000),
          (const Color(0xFFFF1744), 1),
        ]),
      );

      expect(withNoise, dominantOnly);
      _expectAccessibleVisuals(withNoise);
    });
  });

  group('media visuals providers', () {
    test('maps raw palettes without duplicating a concurrent load', () async {
      final completer = Completer<PaletteGenerator?>();
      var loadCount = 0;
      final container = ProviderContainer(
        overrides: <Override>[
          mediaPaletteLoaderProvider.overrideWithValue((_) {
            loadCount += 1;
            return completer.future;
          }),
        ],
      );
      addTearDown(container.dispose);
      const request = MediaPaletteRequest.previewUrl(
        'https://images.example.test/shared-cover.jpg',
      );

      final rawFuture = container.read(mediaPaletteProvider(request).future);
      final visualsFuture = container.read(
        mediaVisualsProvider(request).future,
      );
      await Future<void>.delayed(Duration.zero);

      expect(loadCount, 1);
      final palette = _palette(<(Color, int)>[
        (const Color(0xFF286B8C), 100),
        (const Color(0xFF78B7B2), 30),
      ]);
      completer.complete(palette);

      expect(await rawFuture, same(palette));
      final visuals = await visualsFuture;
      _expectAccessibleVisuals(visuals);
      expect(loadCount, 1);
    });

    test('coalesces distinct family instances with one resource key', () async {
      final completer = Completer<PaletteGenerator?>();
      var loadCount = 0;
      final container = ProviderContainer(
        overrides: <Override>[
          mediaPaletteLoaderProvider.overrideWithValue((_) {
            loadCount += 1;
            return completer.future;
          }),
        ],
      );
      addTearDown(container.dispose);
      const playerRequest = MediaPaletteRequest.previewUrl(
        'https://images.example.test/coalesced.jpg#player',
      );
      const detailRequest = MediaPaletteRequest.previewUrl(
        'https://images.example.test/coalesced.jpg#detail',
      );

      final playerFuture = container.read(
        mediaVisualsProvider(playerRequest).future,
      );
      final detailFuture = container.read(
        mediaVisualsProvider(detailRequest).future,
      );
      await Future<void>.delayed(Duration.zero);

      expect(playerRequest, isNot(detailRequest));
      expect(loadCount, 1);
      final palette = _palette(<(Color, int)>[(const Color(0xFF425E73), 100)]);
      completer.complete(palette);

      expect(await playerFuture, await detailFuture);
      expect(loadCount, 1);
    });

    test('reuses the process cache after family auto-disposal', () async {
      var loadCount = 0;
      final palette = _palette(<(Color, int)>[(const Color(0xFF614A70), 100)]);
      final container = ProviderContainer(
        overrides: <Override>[
          mediaPaletteLoaderProvider.overrideWithValue((_) async {
            loadCount += 1;
            return palette;
          }),
        ],
      );
      addTearDown(container.dispose);
      const request = MediaPaletteRequest.previewUrl(
        'https://images.example.test/persistent-cache.jpg',
      );
      final provider = mediaVisualsProvider(request);

      final first = await container.read(provider.future);
      await container.pump();
      expect(container.exists(provider), isFalse);

      final second = await container.read(provider.future);
      expect(second, first);
      expect(loadCount, 1);
    });

    test('returns semantic fallback when artwork cannot be resolved', () async {
      var loadCount = 0;
      final container = ProviderContainer(
        overrides: <Override>[
          mediaPaletteLoaderProvider.overrideWithValue((_) async {
            loadCount += 1;
            return null;
          }),
        ],
      );
      addTearDown(container.dispose);

      final visuals = await container.read(
        mediaVisualsProvider(
          const MediaPaletteRequest.coverReference(''),
        ).future,
      );

      expect(visuals, EchoMediaVisuals.fromPalette(null));
      expect(loadCount, 0);
    });

    test('current song visuals distinguish no song from missing art', () async {
      final emptyNotifier = TestPlayerNotifier(PlayerState());
      final emptyContainer = ProviderContainer(
        overrides: <Override>[
          playerProvider.overrideWith((_) => emptyNotifier),
        ],
      );
      addTearDown(emptyContainer.dispose);

      expect(
        await emptyContainer.read(currentSongMediaVisualsProvider.future),
        isNull,
      );

      final songNotifier = TestPlayerNotifier(
        PlayerState(
          currentSong: Song(id: 'missing-art', title: 'Missing artwork'),
        ),
      );
      final songContainer = ProviderContainer(
        overrides: <Override>[playerProvider.overrideWith((_) => songNotifier)],
      );
      addTearDown(songContainer.dispose);

      expect(
        await songContainer.read(currentSongMediaVisualsProvider.future),
        EchoMediaVisuals.fromPalette(null),
      );
    });

    test(
      'resolved visuals retain one previous value while reloading',
      () async {
        final generationProvider = StateProvider<int>((_) => 0);
        final pending = <int, Completer<EchoMediaVisuals?>>{
          0: Completer<EchoMediaVisuals?>(),
          1: Completer<EchoMediaVisuals?>(),
        };
        final first = EchoMediaVisuals.fallback(seed: const Color(0xFF183A54));
        final second = EchoMediaVisuals.fallback(seed: const Color(0xFFF0C55A));
        final container = ProviderContainer(
          overrides: <Override>[
            currentSongMediaVisualsProvider.overrideWith((ref) {
              final generation = ref.watch(generationProvider);
              return pending[generation]!.future;
            }),
          ],
        );
        addTearDown(container.dispose);
        final emitted = <EchoMediaVisuals>[];
        final subscription = container.listen(
          resolvedCurrentSongMediaVisualsProvider,
          (_, next) => emitted.add(next),
          fireImmediately: true,
        );
        addTearDown(subscription.close);

        expect(subscription.read(), EchoMediaVisuals.fallback());
        pending[0]!.complete(first);
        await container.pump();
        expect(subscription.read(), first);

        container.read(generationProvider.notifier).state = 1;
        await container.pump();
        final loading = container.read(currentSongMediaVisualsProvider);
        expect(loading.isLoading, isTrue);
        expect(loading.valueOrNull, first);
        expect(subscription.read(), first);

        pending[1]!.complete(second);
        await container.pump();
        expect(subscription.read(), second);
        expect(emitted, <EchoMediaVisuals>[
          EchoMediaVisuals.fallback(),
          first,
          second,
        ]);
      },
    );

    test('late palette result cannot replace a newer song request', () async {
      final generationProvider = StateProvider<int>((_) => 0);
      final pending = <int, Completer<EchoMediaVisuals?>>{
        0: Completer<EchoMediaVisuals?>(),
        1: Completer<EchoMediaVisuals?>(),
        2: Completer<EchoMediaVisuals?>(),
      };
      final first = EchoMediaVisuals.fallback(seed: const Color(0xFF244B5A));
      final stale = EchoMediaVisuals.fallback(seed: const Color(0xFF9B4054));
      final newest = EchoMediaVisuals.fallback(seed: const Color(0xFFE6D36A));
      final container = ProviderContainer(
        overrides: <Override>[
          currentSongMediaVisualsProvider.overrideWith((ref) {
            final generation = ref.watch(generationProvider);
            return pending[generation]!.future;
          }),
        ],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(
        resolvedCurrentSongMediaVisualsProvider,
        (_, _) {},
        fireImmediately: true,
      );
      addTearDown(subscription.close);

      pending[0]!.complete(first);
      await container.pump();
      expect(subscription.read(), first);

      container.read(generationProvider.notifier).state = 1;
      await container.pump();
      container.read(generationProvider.notifier).state = 2;
      await container.pump();

      pending[1]!.complete(stale);
      await container.pump();
      expect(subscription.read(), first);

      pending[2]!.complete(newest);
      await container.pump();
      expect(subscription.read(), newest);
    });
  });
}

PaletteGenerator _palette(List<(Color, int)> swatches) {
  return PaletteGenerator.fromColors(<PaletteColor>[
    for (final (color, population) in swatches) PaletteColor(color, population),
  ]);
}

void _expectAccessibleVisuals(EchoMediaVisuals visuals) {
  final surfaces = <Color>[
    visuals.stageBase,
    visuals.stageGlow,
    visuals.stageBottom,
    visuals.miniSurface,
    visuals.panelSurface,
  ];
  for (final surface in surfaces) {
    expect(
      EchoColors.contrastRatio(visuals.foreground, surface),
      greaterThanOrEqualTo(4.5),
      reason: 'primary foreground must remain readable on $surface',
    );
    expect(
      EchoColors.contrastRatio(visuals.mutedForeground, surface),
      greaterThanOrEqualTo(4.5),
      reason: 'secondary foreground must remain readable on $surface',
    );
    expect(
      EchoColors.contrastRatio(visuals.controlAccent, surface),
      greaterThanOrEqualTo(3),
      reason: 'critical controls must remain distinguishable on $surface',
    );
  }
}
