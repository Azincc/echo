import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/core/utils/cover_ref_security.dart';
import 'package:echoes/data/models/music_library.dart';
import 'package:echoes/data/sources/subsonic_api_client.dart';
import 'package:echoes/features/library/widgets/media_detail_components.dart';
import 'package:echoes/providers/api_provider.dart';
import 'package:echoes/providers/library_provider.dart';
import 'package:echoes/providers/palette_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:palette_generator/palette_generator.dart';

void main() {
  PaletteGenerator palette(Color color) =>
      PaletteGenerator.fromColors(<PaletteColor>[PaletteColor(color, 100)]);

  Color headerColor(WidgetTester tester) {
    final container = tester.widget<AnimatedContainer>(
      find.byKey(const ValueKey<String>('media-detail-header-surface')),
    );
    return (container.decoration! as BoxDecoration).color!;
  }

  testWidgets('fallback tint remains readable in light and dark modes', (
    tester,
  ) async {
    for (final theme in <ThemeData>[AppTheme.light(), AppTheme.dark()]) {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            key: ValueKey<Brightness>(theme.brightness),
            theme: theme,
            home: const MediaDetailHeaderSurface(child: Text('媒体详情')),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final colors = theme.extension<EchoColors>()!;
      final background = headerColor(tester);
      expect(
        EchoColors.contrastRatio(colors.ink, background),
        greaterThanOrEqualTo(4.5),
      );
      expect(
        EchoColors.contrastRatio(colors.muted, background),
        greaterThanOrEqualTo(4.5),
      );
      expect(background, isNot(colors.canvas));
      expect(
        tester
            .widget<AnimatedContainer>(
              find.byKey(const ValueKey<String>('media-detail-header-surface')),
            )
            .duration,
        EchoMotion.standard.state,
      );
    }
  });

  testWidgets('trusted preview artwork transitions from fallback to its tint', (
    tester,
  ) async {
    final completer = Completer<PaletteGenerator?>();
    ImageProvider? requestedImage;
    final coverReference = toTrustedCoverUrlRef(
      'https://images.example.test/preview.jpg#player',
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          mediaPaletteLoaderProvider.overrideWithValue((imageProvider) {
            requestedImage = imageProvider;
            return completer.future;
          }),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          home: MediaDetailHeaderSurface(
            coverArtId: coverReference,
            child: const Text('预览详情'),
          ),
        ),
      ),
    );
    await tester.pump();
    final fallback = headerColor(tester);

    completer.complete(palette(const Color(0xFF0057A8)));
    await tester.pump();
    await tester.pump();

    final resolved = headerColor(tester);
    expect(requestedImage, isA<CachedNetworkImageProvider>());
    expect(
      (requestedImage! as CachedNetworkImageProvider).url,
      'https://images.example.test/preview.jpg',
    );
    expect(resolved, isNot(fallback));
    final colors = AppTheme.light().extension<EchoColors>()!;
    expect(
      EchoColors.contrastRatio(colors.ink, resolved),
      greaterThanOrEqualTo(4.5),
    );
  });

  testWidgets('Subsonic cover ids share one in-flight extraction', (
    tester,
  ) async {
    final now = DateTime(2026, 7, 15);
    final library = MusicLibrary(
      id: 'library-a',
      name: 'Library A',
      createdAt: now,
      updatedAt: now,
    );
    final client = SubsonicApiClient(
      dio: Dio(BaseOptions(baseUrl: 'https://music.example.test')),
    )..setLibrary(library);
    final completer = Completer<PaletteGenerator?>();
    ImageProvider? requestedImage;
    var loadCount = 0;

    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          activeLibraryProvider.overrideWithValue(library),
          subsonicApiClientProvider.overrideWithValue(client),
          mediaPaletteLoaderProvider.overrideWithValue((imageProvider) {
            loadCount += 1;
            requestedImage = imageProvider;
            return completer.future;
          }),
        ],
        child: MaterialApp(
          theme: AppTheme.dark(),
          home: const Column(
            children: <Widget>[
              MediaDetailHeaderSurface(
                coverArtId: 'cover-1',
                child: Text('专辑'),
              ),
              MediaDetailHeaderSurface(
                coverArtId: 'cover-1',
                child: Text('歌手'),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pump();

    expect(loadCount, 1);
    expect(requestedImage, isA<CachedNetworkImageProvider>());
    expect(
      (requestedImage! as CachedNetworkImageProvider).url,
      contains('id=cover-1'),
    );

    completer.complete(palette(const Color(0xFF8B4F53)));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('palette extraction failure keeps the content tint fallback', (
    tester,
  ) async {
    final coverReference = toTrustedCoverUrlRef(
      'https://images.example.test/unavailable.jpg',
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          mediaPaletteLoaderProvider.overrideWithValue(
            (imageProvider) async => throw StateError('offline'),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          home: MediaDetailHeaderSurface(
            coverArtId: coverReference,
            child: const Text('失败回退'),
          ),
        ),
      ),
    );
    final initial = headerColor(tester);
    await tester.pumpAndSettle();

    expect(headerColor(tester), initial);
    expect(tester.takeException(), isNull);
  });
}
