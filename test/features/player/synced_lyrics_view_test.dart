import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/data/models/lyrics_line.dart';
import 'package:echoes/data/models/structured_lyrics.dart';
import 'package:echoes/features/player/widgets/synced_lyrics_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final lyrics = StructuredLyrics(
    synced: true,
    lines: <LyricsLine>[
      LyricsLine(startMs: 0, value: 'Opening line'),
      LyricsLine(startMs: 1000, value: 'Second line 第二行'),
      LyricsLine(startMs: 2000, value: 'Current line'),
      LyricsLine(startMs: 3000, value: 'Closing line'),
    ],
  );

  Widget buildSubject({
    required Duration position,
    required Future<void> Function(Duration) onSeek,
    double textScale = 1,
    bool disableAnimations = true,
  }) {
    return MaterialApp(
      theme: AppTheme.dark(),
      builder: (context, child) {
        final media = MediaQuery.of(context);
        return MediaQuery(
          data: media.copyWith(
            textScaler: TextScaler.linear(textScale),
            disableAnimations: disableAnimations,
          ),
          child: child!,
        );
      },
      home: Scaffold(
        body: SyncedLyricsSurface(
          lyrics: lyrics,
          position: position,
          onSeek: onSeek,
        ),
      ),
    );
  }

  testWidgets('announces the current line and exposes semantic seek actions', (
    tester,
  ) async {
    final seeks = <Duration>[];
    await tester.pumpWidget(
      buildSubject(
        position: const Duration(milliseconds: 2500),
        onSeek: (target) async => seeks.add(target),
      ),
    );
    await tester.pump();

    expect(find.bySemanticsLabel(RegExp('当前歌词，Current line')), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('跳转到 0:03')), findsOneWidget);

    await tester.tap(find.text('Closing line'));
    await tester.pump();
    expect(seeks, <Duration>[const Duration(seconds: 3)]);
  });

  testWidgets('bilingual lines wrap at 200% and reduced motion stays static', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 640);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      buildSubject(
        position: const Duration(milliseconds: 1200),
        onSeek: (_) async {},
        textScale: 2,
      ),
    );
    await tester.pump();

    expect(find.text('Second line'), findsOneWidget);
    expect(find.text('第二行'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
