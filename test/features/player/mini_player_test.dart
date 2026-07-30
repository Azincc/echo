import 'dart:ui' show SemanticsAction;

import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/data/models/song.dart';
import 'package:echoes/features/player/widgets/mini_player.dart';
import 'package:echoes/features/player/widgets/player_hero_helpers.dart';
import 'package:echoes/providers/palette_provider.dart';
import 'package:echoes/providers/player_provider.dart';
import 'package:echoes/widgets/cover_art_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_player_notifier.dart';

void main() {
  final songs = <Song>[
    Song(id: 'a', title: 'Before', artist: 'Artist A'),
    Song(
      id: 'b',
      title: 'A very long current song title that still remains operable',
      artist: 'Artist B',
    ),
    Song(id: 'c', title: 'After', artist: 'Artist C'),
  ];

  PlayerState playerState({bool playing = false}) => PlayerState(
    currentSong: songs[1],
    queue: songs,
    currentIndex: 1,
    isPlaying: playing,
    position: const Duration(seconds: 50),
    duration: const Duration(seconds: 200),
  );

  Widget appFor(
    Widget child, {
    double textScale = 1,
    bool disableAnimations = true,
  }) {
    return ProviderScope(
      child: MaterialApp(
        theme: AppTheme.dark(),
        builder: (context, appChild) {
          final media = MediaQuery.of(context);
          return MediaQuery(
            data: media.copyWith(
              textScaler: TextScaler.linear(textScale),
              disableAnimations: disableAnimations,
            ),
            child: appChild!,
          );
        },
        home: Scaffold(
          body: Align(alignment: Alignment.bottomCenter, child: child),
        ),
      ),
    );
  }

  MiniPlayerView view({
    required PlayerState state,
    Future<void> Function()? onToggle,
    Future<void> Function()? onPrevious,
    Future<void> Function()? onNext,
    Future<void> Function(Duration)? onSeek,
    VoidCallback? onOpen,
    VoidCallback? onActions,
    EchoMediaVisuals? mediaVisuals,
    Color? albumColor,
  }) {
    return MiniPlayerView(
      playerState: state,
      onOpenPlayer: onOpen ?? () {},
      onTogglePlayPause: onToggle ?? () async {},
      onPrevious: onPrevious ?? () async {},
      onNext: onNext ?? () async {},
      onSeek: onSeek ?? (_) async {},
      onOpenActions: onActions ?? () {},
      mediaVisuals: mediaVisuals,
      albumColor: albumColor,
    );
  }

  testWidgets('stays 72dp, keeps two visible actions, and survives 200% text', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(320, 800);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(appFor(view(state: playerState()), textScale: 2));
    await tester.pump();

    expect(
      tester.getSize(find.byKey(const Key('mini-player-surface'))).height,
      MiniPlayer.height,
    );
    expect(find.byType(EchoIconButton), findsNWidgets(2));
    expect(find.bySemanticsLabel('播放'), findsOneWidget);
    expect(find.bySemanticsLabel('更多播放操作'), findsOneWidget);
    expect(find.text('Artist B'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'progress spans the surface, sits at the bottom, and shares its clip',
    (tester) async {
      await tester.pumpWidget(appFor(view(state: playerState())));
      await tester.pump();

      final surface = find.byKey(const Key('mini-player-surface'));
      final progress = find.byKey(const Key('mini-player-progress'));
      final surfaceRect = tester.getRect(surface);
      final progressRect = tester.getRect(progress);
      final progressBar = tester.widget<EchoProgressBar>(progress);
      final fraction = tester.widget<AnimatedFractionallySizedBox>(
        find.descendant(
          of: progress,
          matching: find.byType(AnimatedFractionallySizedBox),
        ),
      );
      final surfaceClip = find.ancestor(
        of: progress,
        matching: find.byKey(const Key('mini-player-surface-clip')),
      );
      final clip = tester.widget<ClipRRect>(surfaceClip);

      expect(progressRect.left, surfaceRect.left);
      expect(progressRect.right, surfaceRect.right);
      expect(progressRect.bottom, surfaceRect.bottom);
      expect(surfaceClip, findsOneWidget);
      expect(clip.borderRadius, tester.element(surface).echoRadii.surface);
      expect(clip.clipBehavior, isNot(Clip.none));
      expect(progressBar.trackColor, Colors.transparent);
      expect(fraction.alignment, Alignment.centerLeft);
      expect(fraction.widthFactor, closeTo(0.25, 0.001));
    },
  );

  testWidgets('scrubber leaves the lower halves of both actions clickable', (
    tester,
  ) async {
    var toggles = 0;
    var actions = 0;
    await tester.pumpWidget(
      appFor(
        view(
          state: playerState(),
          onToggle: () async => toggles += 1,
          onActions: () => actions += 1,
        ),
      ),
    );
    await tester.pump();

    final playRect = tester.getRect(find.bySemanticsLabel('播放'));
    final actionsRect = tester.getRect(find.bySemanticsLabel('更多播放操作'));

    await tester.tapAt(Offset(playRect.center.dx, playRect.bottom - 2));
    await tester.pump();
    await tester.tapAt(Offset(actionsRect.center.dx, actionsRect.bottom - 2));
    await tester.pump();

    expect(toggles, 1);
    expect(actions, 1);
  });

  testWidgets('bright and dark visuals drive local player tokens', (
    tester,
  ) async {
    for (final seed in const <Color>[Color(0xFFFFD54F), Color(0xFF14213D)]) {
      final visuals = EchoMediaVisuals.fallback(seed: seed);
      await tester.pumpWidget(
        appFor(
          view(
            state: playerState(),
            mediaVisuals: visuals,
            albumColor: const Color(0xFF7B1E3A),
          ),
        ),
      );
      await tester.pump();

      final title = tester.widget<Text>(find.text(songs[1].title));
      final playIcon = tester.widget<Icon>(find.byIcon(AppIcons.play));
      final progress = tester.widget<EchoProgressBar>(
        find.byKey(const Key('mini-player-progress')),
      );
      final backdrop = tester.widget<EchoPlayerBackdrop>(
        find.byType(EchoPlayerBackdrop),
      );
      final backgroundHero = tester.widget<Hero>(
        find.ancestor(
          of: find.byType(EchoPlayerBackdrop),
          matching: find.byType(Hero),
        ),
      );
      expect(title.style?.color, visuals.foreground);
      expect(playIcon.color, visuals.foreground);
      expect(progress.color, visuals.controlAccent);
      expect(backdrop.visuals, visuals);
      expect(backdrop.mode, EchoPlayerBackdropMode.mini);
      expect(
        backgroundHero.flightShuttleBuilder,
        playerBackgroundFlightShuttleBuilder,
      );
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('preserves tap, double tap, swipe, expand, and scrub gestures', (
    tester,
  ) async {
    var opens = 0;
    var toggles = 0;
    var previous = 0;
    var next = 0;
    final seeks = <Duration>[];
    var state = playerState();
    await tester.pumpWidget(
      appFor(
        StatefulBuilder(
          builder: (context, setState) => view(
            state: state,
            onOpen: () => opens += 1,
            onToggle: () async => toggles += 1,
            onPrevious: () async {
              previous += 1;
              setState(() {
                state = state.copyWith(currentSong: songs[1], currentIndex: 1);
              });
            },
            onNext: () async {
              next += 1;
              setState(() {
                state = state.copyWith(currentSong: songs[2], currentIndex: 2);
              });
            },
            onSeek: (target) async => seeks.add(target),
          ),
        ),
      ),
    );

    final track = find.byKey(const Key('mini-player-track'));
    await tester.tap(track);
    await tester.pump(const Duration(milliseconds: 350));
    expect(opens, 1);

    await tester.tap(track);
    await tester.pump(const Duration(milliseconds: 40));
    await tester.tap(track);
    await tester.pump(const Duration(milliseconds: 350));
    expect(toggles, 1);

    await tester.drag(track, const Offset(-100, 0));
    await tester.pump();
    expect(next, 1);

    await tester.drag(track, const Offset(100, 0));
    await tester.pump();
    expect(previous, 1);

    await tester.fling(track, const Offset(0, -80), 900);
    await tester.pump();
    expect(opens, 2);

    final scrubber = find.byKey(const Key('mini-player-scrubber'));
    final rect = tester.getRect(scrubber);
    final gesture = await tester.startGesture(
      Offset(rect.left + rect.width * 0.1, rect.center.dy),
    );
    await gesture.moveTo(Offset(rect.left + rect.width * 0.75, rect.center.dy));
    await gesture.up();
    await tester.pump(const Duration(milliseconds: 60));

    expect(seeks, hasLength(1));
    expect(seeks.single.inSeconds, closeTo(150, 2));
  });

  testWidgets(
    'pending swipe disables player Hero and expansion until confirm',
    (tester) async {
      var opens = 0;
      var next = 0;
      var state = playerState();
      late StateSetter updateState;

      await tester.pumpWidget(
        appFor(
          StatefulBuilder(
            builder: (context, setState) {
              updateState = setState;
              return view(
                state: state,
                onOpen: () => opens += 1,
                onNext: () async => next += 1,
              );
            },
          ),
        ),
      );

      final track = find.byKey(const Key('mini-player-track'));
      await tester.drag(track, const Offset(-100, 0));
      await tester.pump();
      expect(next, 1);

      final pendingHeroTags = tester
          .widgetList<Hero>(find.byType(Hero))
          .map((hero) => hero.tag)
          .toSet();
      expect(pendingHeroTags, isNot(contains(playerCoverHeroTag)));
      expect(pendingHeroTags, isNot(contains(playerTitleHeroTag)));
      expect(pendingHeroTags, isNot(contains(playerSubtitleHeroTag)));
      final pendingSemantics = tester
          .getSemantics(find.bySemanticsLabel(RegExp('迷你播放器')))
          .getSemanticsData();
      expect(pendingSemantics.value, '正在切换曲目');
      expect(pendingSemantics.hasAction(SemanticsAction.tap), isFalse);

      await tester.tap(track);
      await tester.pump(const Duration(milliseconds: 350));
      await tester.fling(
        find.byKey(const Key('mini-player-surface')),
        const Offset(0, -80),
        900,
      );
      await tester.pump();
      expect(opens, 0);

      updateState(() {
        state = state.copyWith(currentSong: songs[2], currentIndex: 2);
      });
      await tester.pump();

      final confirmedHeroTags = tester
          .widgetList<Hero>(find.byType(Hero))
          .map((hero) => hero.tag)
          .toSet();
      expect(confirmedHeroTags, contains(playerCoverHeroTag));
      expect(confirmedHeroTags, contains(playerTitleHeroTag));
      expect(confirmedHeroTags, contains(playerSubtitleHeroTag));
      await tester.tap(track);
      await tester.pump(const Duration(milliseconds: 350));
      expect(opens, 1);
    },
  );

  testWidgets('secondary action opens clickable alternatives for gestures', (
    tester,
  ) async {
    final notifier = TestPlayerNotifier(playerState());
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          playerProvider.overrideWith((ref) => notifier),
          currentSongPaletteProvider.overrideWith((ref) async => null),
        ],
        child: MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(body: MiniPlayer()),
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.byIcon(AppIcons.more));
    await tester.pumpAndSettle();

    expect(find.text('上一首'), findsOneWidget);
    expect(find.text('下一首'), findsOneWidget);
    expect(find.text('查看播放队列'), findsOneWidget);
    expect(find.text('曲目操作'), findsOneWidget);
  });

  testWidgets('shuffle swipe never previews a guessed adjacent cover', (
    tester,
  ) async {
    var next = 0;
    final shuffled = PlayerState(
      currentSong: songs[1],
      queue: songs,
      currentIndex: 1,
      shuffleEnabled: true,
      position: const Duration(seconds: 50),
      duration: const Duration(seconds: 200),
    );
    await tester.pumpWidget(
      appFor(view(state: shuffled, onNext: () async => next += 1)),
    );
    await tester.pump();

    expect(find.text('Before'), findsNothing);
    expect(find.text('After'), findsNothing);

    await tester.drag(
      find.byKey(const Key('mini-player-track')),
      const Offset(-100, 0),
    );
    await tester.pump(const Duration(milliseconds: 60));
    expect(next, 1);
  });

  testWidgets('preview songs use their remote cover in the compact player', (
    tester,
  ) async {
    final preview = Song(
      id: 'preview',
      title: 'Preview',
      isPreview: true,
      previewCoverUrl: 'https://images.example.test/preview.jpg',
    );
    final state = PlayerState(
      currentSong: preview,
      queue: <Song>[preview],
      duration: const Duration(minutes: 3),
    );

    await tester.pumpWidget(appFor(view(state: state)));
    await tester.pump();

    final covers = tester
        .widgetList<CoverArtImage>(find.byType(CoverArtImage))
        .where(
          (candidate) =>
              candidate.coverArtId == 'https://images.example.test/preview.jpg',
        );
    expect(covers, isNotEmpty);
  });
}
