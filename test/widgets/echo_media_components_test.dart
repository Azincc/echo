import 'dart:ui' show Tristate;

import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/widgets/echo_artwork.dart';
import 'package:echoes/widgets/echo_media_actions.dart';
import 'package:echoes/widgets/echo_metadata_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('artwork owns shape, Hero tag, and accessible cover label', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Row(
              children: <Widget>[
                EchoArtwork(
                  coverArtId: null,
                  semanticLabel: '星海专辑封面',
                  size: 64,
                  heroTag: 'album-starlight',
                ),
                EchoArtwork(
                  coverArtId: null,
                  semanticLabel: '演奏者头像',
                  size: 64,
                  shape: EchoArtworkShape.circle,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.byType(Hero), findsOneWidget);
    expect(find.byType(ClipRRect), findsOneWidget);
    expect(find.byType(ClipOval), findsOneWidget);
    expect(find.bySemanticsLabel('星海专辑封面'), findsOneWidget);
    expect(find.bySemanticsLabel('演奏者头像'), findsOneWidget);
  });

  testWidgets('circular artwork requires an explicit square size', (
    tester,
  ) async {
    expect(
      () => EchoArtwork(
        coverArtId: null,
        semanticLabel: '演奏者头像',
        shape: EchoArtworkShape.circle,
      ),
      throwsAssertionError,
    );
  });

  testWidgets('metadata filters blanks and wraps at 200 percent text', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: MediaQuery(
            data: MediaQueryData(textScaler: TextScaler.linear(2)),
            child: SizedBox(
              width: 150,
              child: EchoMetadataLine(
                items: <String?>['A very long artist name', '  ', '03:27'],
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text('A very long artist name · 03:27'), findsOneWidget);
    expect(
      find.bySemanticsLabel('A very long artist name，03:27'),
      findsOneWidget,
    );
    expect(
      tester.getSize(find.byType(EchoMetadataLine)).height,
      greaterThan(32),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('media actions keep primary hierarchy without narrow overflow', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    var playCount = 0;
    var shuffleCount = 0;
    var favoriteCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: MediaQuery(
            data: const MediaQueryData(
              size: Size(320, 800),
              textScaler: TextScaler.linear(2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: EchoMediaActions(
                onPlay: () => playCount += 1,
                onShuffle: () => shuffleCount += 1,
                secondaryActions: <EchoMediaAction>[
                  EchoMediaAction(
                    icon: AppIcons.heartOutline,
                    label: '收藏',
                    onPressed: () => favoriteCount += 1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.byType(EchoButton), findsNWidgets(2));
    expect(find.byType(EchoIconButton), findsOneWidget);
    expect(find.bySemanticsLabel('播放'), findsOneWidget);
    expect(find.bySemanticsLabel('随机播放'), findsOneWidget);
    expect(find.bySemanticsLabel('收藏'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.bySemanticsLabel('播放'));
    await tester.tap(find.bySemanticsLabel('随机播放'));
    await tester.tap(find.bySemanticsLabel('收藏'));
    expect((playCount, shuffleCount, favoriteCount), (1, 1, 1));
  });

  testWidgets('shuffle can remain visible while disabled', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: EchoMediaActions(
            onPlay: null,
            onShuffle: null,
            showShuffle: true,
          ),
        ),
      ),
    );

    expect(find.byType(EchoButton), findsNWidgets(2));
    final shuffleSemantics = tester
        .getSemantics(find.bySemanticsLabel('随机播放'))
        .getSemanticsData();
    expect(shuffleSemantics.flagsCollection.isEnabled, Tristate.isFalse);
  });
}
