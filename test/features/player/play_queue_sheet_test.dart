import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/data/models/song.dart';
import 'package:echoes/features/player/widgets/play_queue_sheet.dart';
import 'package:echoes/providers/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final songs = <Song>[
    Song(id: 'a', title: 'Current song', artist: 'First artist'),
    Song(
      id: 'b',
      title: 'A long queued song title that may wrap at large text sizes',
      artist: 'Second artist with a long display name',
    ),
  ];

  Widget buildSubject({
    required PlayerState state,
    required Future<void> Function(int) onSelect,
    required Future<void> Function() onClear,
    required QueueSongAction onOpenSongActions,
    double textScale = 1,
  }) {
    return MaterialApp(
      theme: AppTheme.dark(),
      builder: (context, child) {
        final media = MediaQuery.of(context);
        return MediaQuery(
          data: media.copyWith(
            textScaler: TextScaler.linear(textScale),
            disableAnimations: true,
          ),
          child: child!,
        );
      },
      home: Scaffold(
        body: SizedBox.expand(
          child: PlayQueueSheetView(
            playerState: state,
            onSelect: onSelect,
            onClear: onClear,
            onOpenSongActions: onOpenSongActions,
          ),
        ),
      ),
    );
  }

  testWidgets('queue rows remain operable at 200% text', (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 800);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    var selected = -1;
    var cleared = 0;
    var opened = -1;
    await tester.pumpWidget(
      buildSubject(
        state: PlayerState(
          currentSong: songs.first,
          queue: songs,
          currentIndex: 0,
        ),
        textScale: 2,
        onSelect: (index) async => selected = index,
        onClear: () async => cleared += 1,
        onOpenSongActions: (context, index, song) async => opened = index,
      ),
    );
    await tester.pump();

    expect(find.bySemanticsLabel('关闭播放队列'), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('当前播放')), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('操作')), findsNWidgets(2));
    expect(tester.takeException(), isNull);

    await tester.tap(find.text(songs[1].title));
    await tester.pump();
    expect(selected, 1);

    await tester.longPress(find.text(songs.first.title));
    await tester.pump();
    expect(opened, 0);

    await tester.tap(find.bySemanticsLabel(RegExp('清空后续播放队列')));
    await tester.pump();
    expect(cleared, 1);
  });

  testWidgets('empty queue explains the state and disables clear', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildSubject(
        state: PlayerState(),
        onSelect: (_) async {},
        onClear: () async {},
        onOpenSongActions: (context, index, song) async {},
      ),
    );
    await tester.pump();

    expect(find.text('队列为空'), findsOneWidget);
    expect(find.text('清空后续队列'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
