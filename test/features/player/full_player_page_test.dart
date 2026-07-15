import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/data/models/audio_quality.dart';
import 'package:echoes/data/models/song.dart';
import 'package:echoes/features/player/pages/full_player_page.dart';
import 'package:echoes/features/player/widgets/player_hero_helpers.dart';
import 'package:echoes/providers/lyrics_cover_provider.dart';
import 'package:echoes/providers/palette_provider.dart';
import 'package:echoes/providers/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  }) {
    return ProviderScope(
      overrides: [
        playerProvider.overrideWith((ref) => notifier),
        currentSongPaletteProvider.overrideWith((ref) async => null),
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

  testWidgets('full player keeps Hero contract and works at 200% text', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 800);
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
      tester.getSize(find.bySemanticsLabel('收起播放器')).height,
      greaterThanOrEqualTo(48),
    );
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
  });

  testWidgets('progress remains seekable with buffered state', (tester) async {
    final notifier = TestPlayerNotifier(initialState());
    await tester.pumpWidget(
      providerApp(notifier: notifier, home: const FullPlayerPage()),
    );
    await tester.pump();

    final progressSlider = find.byType(EchoSlider);
    expect(progressSlider, findsOneWidget);
    await tester.drag(progressSlider, const Offset(120, 0));
    await tester.pump();

    expect(notifier.seekTargets, isNotEmpty);
    expect(notifier.seekTargets.last, greaterThan(const Duration(seconds: 30)));
  });
}
