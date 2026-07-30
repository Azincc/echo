import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/data/models/song.dart';
import 'package:echoes/features/player/widgets/play_queue_sheet.dart';
import 'package:echoes/providers/player_provider.dart';
import 'package:echoes/widgets/cover_art_image.dart';
import 'package:echoes/widgets/song_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final songs = <Song>[
    Song(id: 'a', title: 'Current song', artist: 'First artist'),
    Song(
      id: 'b',
      title: 'A long queued song title that may wrap at large text sizes',
      artist: 'Second artist with a long display name',
      isPreview: true,
      previewCoverUrl: 'https://images.example.test/preview.jpg',
    ),
  ];

  Widget buildSubject({
    required PlayerState state,
    required Future<void> Function(int) onSelect,
    required Future<void> Function() onClear,
    required QueueSongAction onOpenSongActions,
    double textScale = 1,
    EchoMediaVisuals? mediaVisuals,
    Color? albumColor,
  }) {
    return ProviderScope(
      child: MaterialApp(
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
              mediaVisuals: mediaVisuals,
              albumColor: albumColor,
              onSelect: onSelect,
              onClear: onClear,
              onOpenSongActions: onOpenSongActions,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('queue rows remain operable at 200% text', (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(320, 800);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    final selected = <int>[];
    var cleared = 0;
    final opened = <int>[];
    await tester.pumpWidget(
      buildSubject(
        state: PlayerState(
          currentSong: songs.first,
          queue: songs,
          currentIndex: 0,
        ),
        textScale: 2,
        onSelect: (index) async => selected.add(index),
        onClear: () async => cleared += 1,
        onOpenSongActions: (context, index, song) async => opened.add(index),
      ),
    );
    await tester.pump();

    expect(find.bySemanticsLabel('关闭播放队列'), findsOneWidget);
    expect(find.byType(EchoSongRow), findsNWidgets(2));
    expect(find.byType(CoverArtImage), findsNWidgets(2));
    expect(find.bySemanticsLabel(RegExp('正在播放')), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('试听')), findsOneWidget);
    expect(find.byIcon(AppIcons.equalizer), findsOneWidget);
    expect(find.text('2'), findsNothing);
    final covers = tester.widgetList<CoverArtImage>(find.byType(CoverArtImage));
    expect(covers.last.coverArtId, 'https://images.example.test/preview.jpg');
    expect(find.bySemanticsLabel(RegExp('更多操作')), findsNWidgets(2));
    expect(
      find.descendant(
        of: find.byType(ListView),
        matching: find.byType(EchoDivider),
      ),
      findsNothing,
    );
    expect(tester.takeException(), isNull);

    await tester.ensureVisible(find.text(songs[1].title));
    await tester.pump();
    await tester.tap(find.text(songs[1].title));
    await tester.pump();
    expect(selected, <int>[1]);
    expect(opened, isEmpty);

    final secondMore = find.bySemanticsLabel('${songs[1].title}，更多操作');
    await tester.drag(find.byType(ListView), const Offset(0, -160));
    await tester.pump();
    final moreSize = tester.getSize(secondMore);
    expect(moreSize.width, greaterThanOrEqualTo(48));
    expect(moreSize.height, greaterThanOrEqualTo(48));
    await tester.tap(secondMore);
    await tester.pump();
    expect(selected, <int>[1]);
    expect(opened, <int>[1]);

    await tester.drag(find.byType(ListView), const Offset(0, 600));
    await tester.pumpAndSettle();
    await tester.longPress(find.text(songs.first.title));
    await tester.pump();
    expect(selected, <int>[1]);
    expect(opened, <int>[1, 0]);

    final clearQueue = find.bySemanticsLabel(RegExp('清空后续播放队列'));
    await tester.tap(clearQueue);
    await tester.pump();
    expect(cleared, 1);
  });

  testWidgets('queue content consumes the panel media color scope', (
    tester,
  ) async {
    final visuals = EchoMediaVisuals.fallback(seed: const Color(0xFFBFD7EA));
    await tester.pumpWidget(
      buildSubject(
        state: PlayerState(
          currentSong: songs.first,
          queue: songs,
          currentIndex: 0,
        ),
        mediaVisuals: visuals,
        albumColor: const Color(0xFF7B1E3A),
        onSelect: (_) async {},
        onClear: () async {},
        onOpenSongActions: (context, index, song) async {},
      ),
    );
    await tester.pump();

    final surface = tester.widget<EchoSurface>(find.byType(EchoSurface).first);
    final currentTitle = tester.widget<Text>(find.text(songs.first.title));
    expect(surface.color, visuals.panelSurface);
    expect(currentTitle.style?.color, visuals.controlAccent);
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
