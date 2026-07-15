import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/data/models/song.dart';
import 'package:echoes/features/player/widgets/mini_player.dart';
import 'package:echoes/providers/palette_provider.dart';
import 'package:echoes/providers/player_provider.dart';
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
  }) {
    return MiniPlayerView(
      playerState: state,
      onOpenPlayer: onOpen ?? () {},
      onTogglePlayPause: onToggle ?? () async {},
      onPrevious: onPrevious ?? () async {},
      onNext: onNext ?? () async {},
      onSeek: onSeek ?? (_) async {},
      onOpenActions: onActions ?? () {},
    );
  }

  testWidgets('stays 72dp, keeps two visible actions, and survives 200% text', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 800);
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

  testWidgets('progress starts at the left edge and sits at the bottom', (
    tester,
  ) async {
    await tester.pumpWidget(appFor(view(state: playerState())));
    await tester.pump();

    final surfaceRect = tester.getRect(
      find.byKey(const Key('mini-player-surface')),
    );
    final progressRect = tester.getRect(
      find.byKey(const Key('mini-player-progress')),
    );
    final fraction = tester.widget<AnimatedFractionallySizedBox>(
      find.descendant(
        of: find.byKey(const Key('mini-player-progress')),
        matching: find.byType(AnimatedFractionallySizedBox),
      ),
    );

    expect(progressRect.bottom, surfaceRect.bottom);
    expect(fraction.alignment, Alignment.centerLeft);
    expect(fraction.widthFactor, closeTo(0.25, 0.001));
  });

  testWidgets('preserves tap, double tap, swipe, expand, and scrub gestures', (
    tester,
  ) async {
    var opens = 0;
    var toggles = 0;
    var previous = 0;
    var next = 0;
    final seeks = <Duration>[];
    await tester.pumpWidget(
      appFor(
        view(
          state: playerState(),
          onOpen: () => opens += 1,
          onToggle: () async => toggles += 1,
          onPrevious: () async => previous += 1,
          onNext: () async => next += 1,
          onSeek: (target) async => seeks.add(target),
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
}
