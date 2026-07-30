import 'dart:ui' show SemanticsAction, Tristate;

import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/data/models/audio_quality.dart';
import 'package:echoes/data/models/song.dart';
import 'package:echoes/features/player/pages/full_player_page.dart';
import 'package:echoes/features/player/widgets/mini_player.dart';
import 'package:echoes/features/player/widgets/player_hero_helpers.dart';
import 'package:echoes/features/player/widgets/player_scrubber.dart';
import 'package:echoes/providers/lyrics_cover_provider.dart';
import 'package:echoes/providers/palette_provider.dart';
import 'package:echoes/providers/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart' hide PlayerState;

import 'test_player_notifier.dart';

void main() {
  final song = Song(
    id: 'current',
    title:
        'A deliberately long player title that must remain usable at large text sizes',
    artist: 'A long artist name',
    album: 'A long album name',
    bitRate: 320,
    bitDepth: 24,
    samplingRate: 96000,
  );

  PlayerState initialState() => PlayerState(
    currentSong: song,
    queue: <Song>[
      song,
      Song(id: 'next', title: 'Next song'),
    ],
    currentIndex: 0,
    isPlaying: true,
    position: const Duration(seconds: 30),
    duration: const Duration(minutes: 4),
    bufferedPosition: const Duration(minutes: 2),
    loopMode: LoopMode.all,
    currentQuality: AudioQualityLevel.original,
    playbackSource: PlaybackSource.downloaded,
    currentBitRateKbps: 320,
  );

  Widget providerApp({
    required TestPlayerNotifier notifier,
    required Widget home,
    double textScale = 1,
    bool disableAnimations = true,
    EchoMediaVisuals? visuals,
  }) {
    final resolvedVisuals = visuals ?? EchoMediaVisuals.fallback();
    return ProviderScope(
      overrides: [
        playerProvider.overrideWith((ref) => notifier),
        currentSongPaletteProvider.overrideWith((ref) async => null),
        resolvedCurrentSongMediaVisualsProvider.overrideWithValue(
          resolvedVisuals,
        ),
        currentLyricsProvider.overrideWith((ref) async => null),
      ],
      child: MaterialApp(
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
        home: home,
      ),
    );
  }

  void expectControlHierarchy(WidgetTester tester) {
    final transport = find.byKey(
      const ValueKey<String>('full_player_transport_controls'),
    );
    final utility = find.byKey(
      const ValueKey<String>('full_player_utility_bar'),
    );
    final quality = find.byKey(
      const ValueKey<String>('full_player_quality_metadata'),
    );
    expect(transport, findsOneWidget);
    expect(utility, findsOneWidget);
    expect(quality, findsOneWidget);
    expect(
      find.descendant(of: transport, matching: find.byType(EchoPressable)),
      findsNWidgets(3),
    );
    expect(
      find.descendant(of: utility, matching: find.byType(EchoPressable)),
      findsNWidgets(4),
    );

    for (final label in <String>['上一首', '暂停', '下一首']) {
      final target = find.descendant(
        of: transport,
        matching: find.bySemanticsLabel(label),
      );
      expect(target, findsOneWidget);
      final rect = tester.getRect(target);
      expect(rect.width, greaterThanOrEqualTo(47.99));
      expect(rect.height, greaterThanOrEqualTo(47.99));
    }
    for (final label in <String>['列表循环，点击切换到单曲循环', '显示歌词', '播放队列', '红心']) {
      final target = find.descendant(
        of: utility,
        matching: find.bySemanticsLabel(label),
      );
      expect(target, findsOneWidget);
      final rect = tester.getRect(target);
      expect(rect.width, greaterThanOrEqualTo(47.99));
      expect(rect.height, greaterThanOrEqualTo(47.99));
    }
    expect(
      find.descendant(of: transport, matching: find.bySemanticsLabel('红心')),
      findsNothing,
    );
    expect(
      find.descendant(of: utility, matching: find.bySemanticsLabel('暂停')),
      findsNothing,
    );
    expect(find.descendant(of: utility, matching: quality), findsNothing);
  }

  testWidgets('full player keeps Hero contract and works at 200% text', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(320, 800);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    final notifier = TestPlayerNotifier(initialState());
    await tester.pumpWidget(
      providerApp(
        notifier: notifier,
        textScale: 2,
        home: const FullPlayerPage(),
      ),
    );
    await tester.pump();
    await tester.pump();

    final tags = tester
        .widgetList<Hero>(find.byType(Hero))
        .map((hero) => hero.tag)
        .toSet();
    expect(
      tags,
      containsAll(<Object>[
        playerBackgroundHeroTag,
        playerCoverHeroTag,
        playerTitleHeroTag,
        playerSubtitleHeroTag,
      ]),
    );
    expect(find.bySemanticsLabel('收起播放器'), findsOneWidget);
    expect(find.bySemanticsLabel('暂停'), findsOneWidget);
    expect(find.bySemanticsLabel('显示歌词'), findsOneWidget);
    expect(find.bySemanticsLabel('播放队列'), findsOneWidget);
    expect(
      find.byKey(const ValueKey<String>('full_player_portrait_layout')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey<String>('full_player_wide_layout')),
      findsNothing,
    );
    expect(
      tester.getSize(find.bySemanticsLabel('收起播放器')).height,
      greaterThanOrEqualTo(48),
    );
    expectControlHierarchy(tester);
    expect(tester.takeException(), isNull);
  });

  testWidgets('play glyph is optically centered inside the primary control', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 800);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    final notifier = TestPlayerNotifier(
      initialState().copyWith(isPlaying: false),
    );
    await tester.pumpWidget(
      providerApp(notifier: notifier, home: const FullPlayerPage()),
    );
    await tester.pump();

    final glyph = find.byKey(
      const ValueKey<String>('full_player_primary_transport_glyph'),
    );
    expect(glyph, findsOneWidget);
    expect(find.bySemanticsLabel('播放'), findsOneWidget);

    var transform = tester.widget<Transform>(glyph);
    expect(transform.transform.getTranslation().x, closeTo(2.88, 0.01));
    expect(transform.transform.getTranslation().y, 0);

    await tester.tap(find.bySemanticsLabel('播放'));
    await tester.pump();

    expect(find.bySemanticsLabel('暂停'), findsOneWidget);
    transform = tester.widget<Transform>(glyph);
    expect(transform.transform.getTranslation().x, 0);
    expect(transform.transform.getTranslation().y, 0);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'landscape player uses two columns and keeps controls reachable at 130%',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(800, 360);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);

      final notifier = TestPlayerNotifier(initialState());
      await tester.pumpWidget(
        providerApp(
          notifier: notifier,
          textScale: 1.3,
          disableAnimations: false,
          home: const FullPlayerPage(),
        ),
      );
      await tester.pumpAndSettle();

      final wideLayout = find.byKey(
        const ValueKey<String>('full_player_wide_layout'),
      );
      final artworkPane = find.byKey(
        const ValueKey<String>('full_player_artwork_pane'),
      );
      final detailsPane = find.byKey(
        const ValueKey<String>('full_player_details_pane'),
      );
      expect(wideLayout, findsOneWidget);
      expect(
        find.byKey(const ValueKey<String>('full_player_portrait_layout')),
        findsNothing,
      );
      expect(
        find.byKey(const ValueKey<String>('full_player_cover')),
        findsOneWidget,
      );
      expect(find.byType(EchoPlayerScrubber), findsOneWidget);
      final heroTags = tester
          .widgetList<Hero>(find.byType(Hero))
          .map((hero) => hero.tag)
          .toSet();
      expect(
        heroTags,
        containsAll(<Object>[
          playerBackgroundHeroTag,
          playerCoverHeroTag,
          playerTitleHeroTag,
          playerSubtitleHeroTag,
        ]),
      );

      final artworkRect = tester.getRect(artworkPane);
      final detailsRect = tester.getRect(detailsPane);
      expect(artworkRect.right, lessThan(detailsRect.left));
      expect(artworkRect.height, closeTo(detailsRect.height, 0.1));
      expectControlHierarchy(tester);

      for (final label in <String>['暂停', '显示歌词', '播放队列']) {
        final target = find.bySemanticsLabel(label);
        expect(target, findsOneWidget);
        final targetRect = tester.getRect(target);
        expect(targetRect.width, greaterThanOrEqualTo(48));
        expect(targetRect.height, greaterThanOrEqualTo(48));
        expect(targetRect.top, greaterThanOrEqualTo(detailsRect.top));
        expect(targetRect.bottom, lessThanOrEqualTo(detailsRect.bottom));
      }
      expect(tester.takeException(), isNull);

      await tester.tap(find.bySemanticsLabel('显示歌词'));
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.takeException(), isNull);
      await tester.pumpAndSettle();

      expect(find.text('暂无歌词'), findsOneWidget);
      expect(find.bySemanticsLabel('显示封面'), findsOneWidget);
      expect(
        tester.getRect(find.text('暂无歌词')).center.dx,
        lessThan(detailsRect.left),
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('expanded portrait width also uses the player split layout', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(900, 1200);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    final notifier = TestPlayerNotifier(initialState());
    await tester.pumpWidget(
      providerApp(
        notifier: notifier,
        textScale: 1.3,
        home: const FullPlayerPage(),
      ),
    );
    await tester.pump();

    expect(
      find.byKey(const ValueKey<String>('full_player_wide_layout')),
      findsOneWidget,
    );
    expect(
      tester
          .getRect(
            find.byKey(const ValueKey<String>('full_player_artwork_pane')),
          )
          .right,
      lessThan(
        tester
            .getRect(
              find.byKey(const ValueKey<String>('full_player_details_pane')),
            )
            .left,
      ),
    );
    expectControlHierarchy(tester);
    expect(tester.takeException(), isNull);
  });

  testWidgets('reduced-motion close collapses lyrics before popping', (
    tester,
  ) async {
    final notifier = TestPlayerNotifier(initialState());
    await tester.pumpWidget(
      providerApp(
        notifier: notifier,
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () => Navigator.of(context).push<void>(
                MaterialPageRoute<void>(builder: (_) => const FullPlayerPage()),
              ),
              child: const Text('打开播放器'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('打开播放器'));
    await tester.pumpAndSettle();
    await tester.tap(find.bySemanticsLabel('显示歌词'));
    await tester.pumpAndSettle();
    expect(find.text('暂无歌词'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('收起播放器'));
    await tester.pump();
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.byType(FullPlayerPage), findsNothing);
    expect(find.text('打开播放器'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'route foreground fades progress and controls together on close',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(360, 800);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);

      final notifier = TestPlayerNotifier(initialState());
      await tester.pumpWidget(
        providerApp(
          notifier: notifier,
          disableAnimations: false,
          home: const Scaffold(
            body: Align(alignment: Alignment.bottomCenter, child: MiniPlayer()),
          ),
        ),
      );
      await tester.pump();

      await tester.tap(find.byKey(const Key('mini-player-track')));
      await tester.pump(const Duration(milliseconds: 350));
      await tester.pumpAndSettle();
      expect(find.byType(FullPlayerPage), findsOneWidget);

      final foreground = find.byKey(
        const ValueKey<String>('full_player_foreground_transition'),
      );
      expect(foreground, findsOneWidget);
      expect(
        find.descendant(of: foreground, matching: find.byType(ProgressBar)),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: foreground,
          matching: find.byKey(
            const ValueKey<String>('full_player_transport_controls'),
          ),
        ),
        findsOneWidget,
      );

      await tester.tap(find.bySemanticsLabel('收起播放器'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 90));

      final fade = tester.widget<FadeTransition>(foreground);
      expect(fade.opacity.value, greaterThan(0));
      expect(fade.opacity.value, lessThan(1));
      expect(find.byType(ProgressBar), findsOneWidget);

      await tester.pumpAndSettle();
      expect(find.byType(FullPlayerPage), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('playback mode cycles in the established three-state order', (
    tester,
  ) async {
    final notifier = TestPlayerNotifier(initialState());
    await tester.pumpWidget(
      providerApp(notifier: notifier, home: const FullPlayerPage()),
    );
    await tester.pump();

    await tester.tap(find.bySemanticsLabel('列表循环，点击切换到单曲循环'));
    await tester.pump();
    expect(find.bySemanticsLabel('单曲循环，点击切换到随机播放'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('单曲循环，点击切换到随机播放'));
    await tester.pump();
    expect(find.bySemanticsLabel('随机播放，点击切换到列表循环'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('随机播放，点击切换到列表循环'));
    await tester.pump();
    expect(find.bySemanticsLabel('列表循环，点击切换到单曲循环'), findsOneWidget);

    final unstarred = find.bySemanticsLabel('红心');
    expect(
      tester
          .getSemantics(unstarred)
          .getSemanticsData()
          .flagsCollection
          .isSelected,
      Tristate.isFalse,
    );
    await tester.tap(unstarred);
    await tester.pump();
    final starred = find.bySemanticsLabel('取消红心');
    expect(starred, findsOneWidget);
    expect(
      tester
          .getSemantics(starred)
          .getSemanticsData()
          .flagsCollection
          .isSelected,
      Tristate.isTrue,
    );
  });

  testWidgets('progress remains seekable with buffered state', (tester) async {
    final notifier = TestPlayerNotifier(initialState());
    await tester.pumpWidget(
      providerApp(notifier: notifier, home: const FullPlayerPage()),
    );
    await tester.pump();

    final progressSlider = find.byType(EchoPlayerScrubber);
    expect(progressSlider, findsOneWidget);
    final progressSemantics = find.bySemanticsLabel('播放进度');
    expect(progressSemantics, findsOneWidget);
    final semanticsData = tester
        .getSemantics(progressSemantics)
        .getSemanticsData();
    expect(semanticsData.hasAction(SemanticsAction.increase), isTrue);
    expect(semanticsData.increasedValue, '0:40 / 4:00');
    await tester.drag(progressSlider, const Offset(120, 0));
    await tester.pump();

    expect(notifier.seekTargets, isNotEmpty);
    expect(notifier.seekTargets.last, greaterThan(const Duration(seconds: 30)));
  });

  testWidgets('changing songs cancels an in-flight seek', (tester) async {
    final notifier = TestPlayerNotifier(initialState());
    await tester.pumpWidget(
      providerApp(notifier: notifier, home: const FullPlayerPage()),
    );
    await tester.pump();

    final scrubber = find.byType(EchoPlayerScrubber);
    final gesture = await tester.startGesture(tester.getCenter(scrubber));
    await tester.pumpAndSettle();
    await gesture.moveBy(const Offset(80, 0));
    await tester.pump();
    expect(notifier.seekTargets, isEmpty);

    final nextSong = notifier.state.queue[1];
    notifier.emit(
      initialState().copyWith(
        currentSong: nextSong,
        currentIndex: 1,
        position: const Duration(seconds: 5),
        duration: const Duration(minutes: 3),
        bufferedPosition: const Duration(seconds: 30),
      ),
    );
    await tester.pump();
    await gesture.up();
    await tester.pump();

    expect(notifier.seekTargets, isEmpty);
    expect(
      tester
          .getSemantics(find.bySemanticsLabel('播放进度'))
          .getSemanticsData()
          .value,
      '0:05 / 3:00',
    );
  });

  testWidgets('bright artwork installs dark player ink and system chrome', (
    tester,
  ) async {
    final visuals = EchoMediaVisuals.fallback(seed: const Color(0xFFFFE36B));
    expect(visuals.foreground.computeLuminance(), lessThan(0.1));

    await tester.pumpWidget(
      providerApp(
        notifier: TestPlayerNotifier(initialState()),
        home: const FullPlayerPage(),
        visuals: visuals,
      ),
    );
    await tester.pump();

    final titleContext = tester.element(find.text('正在播放'));
    expect(titleContext.echoColors.ink, visuals.foreground);
    expect(titleContext.echoColors.muted, visuals.mutedForeground);
    expect(titleContext.echoColors.canvas, visuals.stageBase);

    final backdrop = tester.widget<EchoPlayerBackdrop>(
      find.byType(EchoPlayerBackdrop),
    );
    expect(backdrop.mode, EchoPlayerBackdropMode.stage);
    expect(backdrop.visuals, visuals);

    final scrubber = tester.widget<EchoPlayerScrubber>(
      find.byType(EchoPlayerScrubber),
    );
    expect(scrubber.activeColor, visuals.controlAccent);
    expect(scrubber.thumbColor, visuals.foreground);

    final overlay = tester
        .widgetList<AnnotatedRegion<SystemUiOverlayStyle>>(
          find.byType(AnnotatedRegion<SystemUiOverlayStyle>),
        )
        .firstWhere(
          (region) =>
              region.value.systemNavigationBarColor == visuals.stageBottom,
        )
        .value;
    expect(overlay.statusBarIconBrightness, Brightness.dark);
    expect(overlay.systemNavigationBarIconBrightness, Brightness.dark);
  });

  testWidgets('full-player song actions use the album-derived panel palette', (
    tester,
  ) async {
    final visuals = EchoMediaVisuals.fallback(seed: const Color(0xFFBFD7EA));

    await tester.pumpWidget(
      providerApp(
        notifier: TestPlayerNotifier(initialState()),
        home: const FullPlayerPage(),
        visuals: visuals,
      ),
    );
    await tester.pump();

    await tester.tap(find.bySemanticsLabel('${song.title} 操作'));
    await tester.pumpAndSettle();

    final sheet = find.byType(EchoBottomSheet);
    expect(sheet, findsOneWidget);
    final sheetTitle = find.descendant(of: sheet, matching: find.text('歌曲操作'));
    final sheetContext = tester.element(sheetTitle);
    expect(sheetContext.echoColors.surface, visuals.panelSurface);
    expect(sheetContext.echoColors.accent, visuals.controlAccent);
    expect(sheetContext.echoColors.ink, visuals.foreground);
    expect(sheetContext.echoColors.muted, visuals.mutedForeground);

    final heart = tester.widget<Icon>(
      find.descendant(of: sheet, matching: find.byIcon(AppIcons.heartOutline)),
    );
    expect(heart.color, visuals.controlAccent);
    expect(tester.takeException(), isNull);
  });
}
