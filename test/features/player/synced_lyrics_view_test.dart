import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/data/models/lyrics_line.dart';
import 'package:echoes/data/models/structured_lyrics.dart';
import 'package:echoes/features/player/widgets/synced_lyrics_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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
    StructuredLyrics? subjectLyrics,
    TextDirection textDirection = TextDirection.ltr,
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
      home: Directionality(
        textDirection: textDirection,
        child: Scaffold(
          body: SyncedLyricsSurface(
            lyrics: subjectLyrics ?? lyrics,
            position: position,
            onSeek: onSeek,
          ),
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
    expect(find.text('Current line'), findsOneWidget);

    final activeStyle = tester.widget<AnimatedDefaultTextStyle>(
      find.byKey(const ValueKey<String>('lyrics-primary-style-2')),
    );
    final inactiveStyle = tester.widget<AnimatedDefaultTextStyle>(
      find.byKey(const ValueKey<String>('lyrics-primary-style-0')),
    );
    expect(activeStyle.style.fontSize, 22);
    expect(activeStyle.style.fontWeight, FontWeight.w700);
    expect(inactiveStyle.style.fontSize, 17);
    expect(inactiveStyle.style.fontWeight, FontWeight.w500);
    expect(activeStyle.duration, Duration.zero);

    final activeMarker = tester.widget<AnimatedOpacity>(
      find.byKey(const ValueKey<String>('lyrics-line-marker-2')),
    );
    final inactiveMarker = tester.widget<AnimatedOpacity>(
      find.byKey(const ValueKey<String>('lyrics-line-marker-0')),
    );
    expect(activeMarker.opacity, 1);
    expect(inactiveMarker.opacity, 0);
    expect(
      tester
          .getSize(find.byKey(const ValueKey<String>('lyrics-line-2')))
          .height,
      greaterThanOrEqualTo(48),
    );

    await tester.tap(find.text('Closing line'));
    await tester.pump();
    expect(seeks, <Duration>[const Duration(seconds: 3)]);
  });

  testWidgets('edge softening filters lyric glyphs without blurring backdrop', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 640);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    final longLyrics = StructuredLyrics(
      synced: true,
      lines: <LyricsLine>[
        for (var index = 0; index < 30; index += 1)
          LyricsLine(startMs: index * 1000, value: 'Lyric line $index'),
      ],
    );

    await tester.pumpWidget(
      buildSubject(
        position: const Duration(seconds: 15),
        onSeek: (_) async {},
        subjectLyrics: longLyrics,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(BackdropFilter), findsNothing);
    final textFilters = find.byWidgetPredicate((widget) {
      final key = widget.key;
      return widget is ImageFiltered &&
          key is ValueKey<String> &&
          key.value.startsWith('lyrics-text-filter-');
    });
    expect(textFilters, findsWidgets);
    final enabledTextFilters = find.byWidgetPredicate((widget) {
      final key = widget.key;
      return widget is ImageFiltered &&
          widget.enabled &&
          key is ValueKey<String> &&
          key.value.startsWith('lyrics-text-filter-');
    });
    expect(enabledTextFilters, findsWidgets);
    expect(
      find.descendant(
        of: textFilters,
        matching: find.byType(AnimatedDefaultTextStyle),
      ),
      findsWidgets,
    );
    final lineMarkers = find.byWidgetPredicate((widget) {
      final key = widget.key;
      return widget is AnimatedOpacity &&
          key is ValueKey<String> &&
          key.value.startsWith('lyrics-line-marker-');
    });
    expect(
      find.descendant(of: textFilters, matching: lineMarkers),
      findsNothing,
    );
    final softenedText = find.byWidgetPredicate((widget) {
      final key = widget.key;
      return widget is Opacity &&
          widget.opacity < 1 &&
          key is ValueKey<String> &&
          key.value.startsWith('lyrics-text-softening-');
    });
    expect(softenedText, findsWidgets);
    final softenedOpacities = softenedText
        .evaluate()
        .map((element) => (element.widget as Opacity).opacity)
        .toList(growable: false);
    expect(softenedOpacities.any((opacity) => opacity <= 0.05), isTrue);
    expect(
      softenedOpacities.any((opacity) => opacity >= 0.9 && opacity < 1),
      isTrue,
    );

    final currentText = tester.widget<Opacity>(
      find.byKey(const ValueKey<String>('lyrics-text-softening-15')),
    );
    expect(currentText.opacity, 1);
    expect(
      tester
          .widget<ImageFiltered>(
            find.byKey(const ValueKey<String>('lyrics-text-filter-15')),
          )
          .enabled,
      isFalse,
    );

    await tester.pumpWidget(
      buildSubject(
        position: Duration.zero,
        onSeek: (_) async {},
        subjectLyrics: longLyrics,
      ),
    );
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<Opacity>(
            find.byKey(const ValueKey<String>('lyrics-text-softening-0')),
          )
          .opacity,
      1,
    );
    expect(
      tester
          .widget<ImageFiltered>(
            find.byKey(const ValueKey<String>('lyrics-text-filter-0')),
          )
          .enabled,
      isFalse,
    );

    await tester.pumpWidget(
      buildSubject(
        position: const Duration(milliseconds: 29500),
        onSeek: (_) async {},
        subjectLyrics: longLyrics,
      ),
    );
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<Opacity>(
            find.byKey(const ValueKey<String>('lyrics-text-softening-29')),
          )
          .opacity,
      1,
    );
    expect(
      tester
          .widget<ImageFiltered>(
            find.byKey(const ValueKey<String>('lyrics-text-filter-29')),
          )
          .enabled,
      isFalse,
    );
  });

  testWidgets('invisible current lines do not show the emphasis rail', (
    tester,
  ) async {
    final lyricsWithGap = StructuredLyrics(
      synced: true,
      lines: <LyricsLine>[
        LyricsLine(startMs: 0, value: 'Opening line'),
        LyricsLine(startMs: 1000, value: ' \t\u200B\u2060\uFEFF '),
        LyricsLine(startMs: 2000, value: '♪ … 👩‍🎤'),
      ],
    );

    await tester.pumpWidget(
      buildSubject(
        position: const Duration(milliseconds: 1200),
        onSeek: (_) async {},
        subjectLyrics: lyricsWithGap,
      ),
    );
    await tester.pump();

    final invisibleMarker = tester.widget<AnimatedOpacity>(
      find.byKey(const ValueKey<String>('lyrics-line-marker-1')),
    );
    expect(invisibleMarker.opacity, 0);
    expect(find.bySemanticsLabel(RegExp('当前歌词')), findsNothing);

    await tester.pumpWidget(
      buildSubject(
        position: const Duration(milliseconds: 2200),
        onSeek: (_) async {},
        subjectLyrics: lyricsWithGap,
      ),
    );
    await tester.pump();

    final visibleSymbolMarker = tester.widget<AnimatedOpacity>(
      find.byKey(const ValueKey<String>('lyrics-line-marker-2')),
    );
    expect(visibleSymbolMarker.opacity, 1);
    expect(find.bySemanticsLabel(RegExp('当前歌词，♪ … 👩‍🎤')), findsOneWidget);
  });

  testWidgets('bilingual lines wrap at 200% and reduced motion stays static', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(320, 640);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    final longLyrics = StructuredLyrics(
      synced: true,
      lines: <LyricsLine>[
        LyricsLine(startMs: 0, value: 'Opening line'),
        LyricsLine(
          startMs: 1000,
          value:
              'A deliberately long translated lyric that must wrap naturally '
              '这是一句需要在窄屏和大字体下自然换行的双语歌词',
        ),
        LyricsLine(startMs: 2000, value: 'Closing line'),
      ],
    );

    await tester.pumpWidget(
      buildSubject(
        position: const Duration(milliseconds: 1200),
        onSeek: (_) async {},
        textScale: 2,
        subjectLyrics: longLyrics,
      ),
    );
    await tester.pump();

    expect(
      find.text(
        'A deliberately long translated lyric that must wrap naturally',
      ),
      findsOneWidget,
    );
    expect(find.text('这是一句需要在窄屏和大字体下自然换行的双语歌词'), findsOneWidget);
    expect(
      tester
          .getSize(find.byKey(const ValueKey<String>('lyrics-line-1')))
          .height,
      greaterThanOrEqualTo(48),
    );
    expect(
      tester
          .widget<AnimatedDefaultTextStyle>(
            find.byKey(const ValueKey<String>('lyrics-primary-style-1')),
          )
          .duration,
      Duration.zero,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('start alignment mirrors the emphasis rail in RTL', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildSubject(
        position: const Duration(milliseconds: 2500),
        onSeek: (_) async {},
        textDirection: TextDirection.rtl,
      ),
    );
    await tester.pump();

    final primary = tester.widget<Text>(
      find.byKey(const ValueKey<String>('lyrics-primary-2')),
    );
    expect(primary.textAlign, TextAlign.start);

    final markerRect = tester.getRect(
      find.byKey(const ValueKey<String>('lyrics-line-marker-2')),
    );
    final textRect = tester.getRect(
      find.byKey(const ValueKey<String>('lyrics-primary-2')),
    );
    expect(markerRect.left, greaterThan(textRect.right));
  });

  testWidgets('line state morphs over the 220ms state token', (tester) async {
    final position = ValueNotifier<Duration>(
      const Duration(milliseconds: 1200),
    );
    addTearDown(position.dispose);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark(),
        builder: (context, child) {
          final media = MediaQuery.of(context);
          return MediaQuery(
            data: media.copyWith(disableAnimations: false),
            child: child!,
          );
        },
        home: Scaffold(
          body: ValueListenableBuilder<Duration>(
            valueListenable: position,
            builder: (context, value, child) {
              return SyncedLyricsSurface(
                lyrics: lyrics,
                position: value,
                onSeek: (_) async {},
              );
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      tester
          .widget<AnimatedDefaultTextStyle>(
            find.byKey(const ValueKey<String>('lyrics-primary-style-1')),
          )
          .duration,
      const Duration(milliseconds: 220),
    );

    position.value = const Duration(milliseconds: 2500);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 110));

    final becomingCurrent = _resolvedTextStyle(
      tester,
      const ValueKey<String>('lyrics-primary-style-2'),
    );
    final becomingInactive = _resolvedTextStyle(
      tester,
      const ValueKey<String>('lyrics-primary-style-1'),
    );
    expect(becomingCurrent.fontSize, inExclusiveRange(17, 22));
    expect(becomingInactive.fontSize, inExclusiveRange(17, 22));

    await tester.pump(const Duration(milliseconds: 110));
    expect(
      _resolvedTextStyle(
        tester,
        const ValueKey<String>('lyrics-primary-style-2'),
      ).fontSize,
      22,
    );
    expect(
      _resolvedTextStyle(
        tester,
        const ValueKey<String>('lyrics-primary-style-1'),
      ).fontSize,
      17,
    );
  });

  testWidgets(
    'user scrolling pauses follow and resumes after the idle window',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(360, 640);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);

      final longLyrics = StructuredLyrics(
        synced: true,
        lines: <LyricsLine>[
          for (var index = 0; index < 30; index += 1)
            LyricsLine(startMs: index * 1000, value: 'Lyric line $index'),
        ],
      );
      final position = ValueNotifier<Duration>(const Duration(seconds: 8));
      addTearDown(position.dispose);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ValueListenableBuilder<Duration>(
              valueListenable: position,
              builder: (context, value, child) {
                return SyncedLyricsSurface(
                  lyrics: longLyrics,
                  position: value,
                  onSeek: (_) async {},
                );
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final list = find.byType(ScrollablePositionedList);
      final scrollable = find.descendant(
        of: list,
        matching: find.byType(Scrollable),
      );
      await tester.drag(list, const Offset(0, -180));
      await tester.pumpAndSettle();
      final pausedOffset = tester
          .state<ScrollableState>(scrollable)
          .position
          .pixels;

      position.value = const Duration(seconds: 22);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(
        tester.state<ScrollableState>(scrollable).position.pixels,
        closeTo(pausedOffset, 0.5),
      );

      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
      expect(
        tester.state<ScrollableState>(scrollable).position.pixels,
        isNot(closeTo(pausedOffset, 0.5)),
      );
    },
  );
}

TextStyle _resolvedTextStyle(WidgetTester tester, ValueKey<String> key) {
  final defaultTextStyle = find.descendant(
    of: find.byKey(key),
    matching: find.byType(DefaultTextStyle),
  );
  return tester.widget<DefaultTextStyle>(defaultTextStyle).style;
}
