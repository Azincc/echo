import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/data/models/song.dart';
import 'package:echoes/features/player/pages/full_player_page.dart';
import 'package:echoes/features/player/widgets/mini_player.dart';
import 'package:echoes/features/player/widgets/play_queue_sheet.dart';
import 'package:echoes/providers/lyrics_cover_provider.dart';
import 'package:echoes/providers/palette_provider.dart';
import 'package:echoes/providers/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_player_notifier.dart';

void main() {
  testWidgets('MiniPlayer opens the full player and selects from its queue', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 800);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    final currentSong = Song(
      id: 'current',
      title: 'Current track',
      artist: 'First artist',
      album: 'Flow album',
    );
    final queuedSong = Song(
      id: 'queued',
      title: 'Queued track',
      artist: 'Second artist',
      album: 'Flow album',
    );
    final notifier = TestPlayerNotifier(
      PlayerState(
        currentSong: currentSong,
        queue: <Song>[currentSong, queuedSong],
        currentIndex: 0,
        isPlaying: true,
        position: const Duration(seconds: 30),
        duration: const Duration(minutes: 3),
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          playerProvider.overrideWith((ref) => notifier),
          currentSongPaletteProvider.overrideWith((ref) async => null),
          currentLyricsProvider.overrideWith((ref) async => null),
        ],
        child: MaterialApp(
          theme: AppTheme.dark(),
          builder: (context, child) {
            final media = MediaQuery.of(context);
            return MediaQuery(
              data: media.copyWith(disableAnimations: true),
              child: child!,
            );
          },
          home: const Scaffold(
            body: Align(alignment: Alignment.bottomCenter, child: MiniPlayer()),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(MiniPlayer), findsOneWidget);
    expect(find.text(currentSong.title), findsOneWidget);

    await tester.tap(find.byKey(const Key('mini-player-track')));
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pumpAndSettle();

    expect(find.byType(FullPlayerPage), findsOneWidget);
    expect(find.bySemanticsLabel('收起播放器'), findsOneWidget);
    expect(find.bySemanticsLabel('播放队列'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('播放队列'));
    await tester.pumpAndSettle();

    expect(find.byType(PlayQueueSheet), findsOneWidget);
    expect(find.text('2 首曲目'), findsOneWidget);
    final queuedRow = find.bySemanticsLabel(
      RegExp('Queued track.*Second artist'),
    );
    expect(queuedRow, findsOneWidget);

    await tester.tap(queuedRow);
    await tester.pumpAndSettle();

    expect(find.byType(PlayQueueSheet), findsNothing);
    expect(notifier.skippedIndices, <int>[1]);
    expect(notifier.state.currentSong, queuedSong);
    expect(find.text(queuedSong.title), findsOneWidget);
    expect(find.byType(FullPlayerPage), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
