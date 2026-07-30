import 'dart:ui' show Tristate;

import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/data/models/song.dart';
import 'package:echoes/widgets/song_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final song = Song(
    id: 'song-1',
    title: '这是一首标题很长用于验证窄屏排版的歌曲',
    artist: '星海乐队与远方交响团',
    duration: 247,
    starred: true,
    isPreview: true,
  );

  testWidgets(
    'song row exposes current, favorite, download, preview, and more states',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(320, 800));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      var playCount = 0;
      var moreCount = 0;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.light(),
            home: Scaffold(
              body: MediaQuery(
                data: const MediaQueryData(
                  size: Size(320, 800),
                  textScaler: TextScaler.linear(2),
                ),
                child: EchoSongRow(
                  song: song,
                  isCurrent: true,
                  isDownloaded: true,
                  onPressed: () => playCount += 1,
                  onMorePressed: () => moreCount += 1,
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      final rowSemantics = find.bySemanticsLabel(RegExp('正在播放.*已收藏.*已下载.*试听'));
      final moreSemantics = find.bySemanticsLabel('${song.title}，更多操作');

      expect(rowSemantics, findsOneWidget);
      expect(moreSemantics, findsOneWidget);
      final moreSize = tester.getSize(moreSemantics);
      expect(moreSize.width, greaterThanOrEqualTo(48));
      expect(moreSize.height, greaterThanOrEqualTo(48));
      expect(find.byIcon(AppIcons.equalizer), findsOneWidget);
      expect(find.byIcon(AppIcons.heart), findsOneWidget);
      expect(find.byIcon(AppIcons.download), findsOneWidget);
      expect(find.byIcon(AppIcons.cloud), findsOneWidget);
      expect(find.byIcon(AppIcons.more), findsOneWidget);
      final title = tester.widget<Text>(find.text(song.title));
      expect(title.maxLines, isNull);
      expect(title.overflow, TextOverflow.visible);
      expect(tester.takeException(), isNull);

      await tester.tap(rowSemantics);
      await tester.tap(moreSemantics);
      expect((playCount, moreCount), (1, 1));
    },
  );

  testWidgets('legacy row maps its long-press menu to a visible more target', (
    tester,
  ) async {
    var menuCount = 0;

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: SongListItem(
              song: song,
              index: 4,
              variant: SongListItemVariant.albumTrack,
              onTap: () {},
              onLongPress: () => menuCount += 1,
            ),
          ),
        ),
      ),
    );

    expect(find.text('5'), findsOneWidget);
    final moreSemantics = find.bySemanticsLabel('${song.title}，更多操作');
    expect(moreSemantics, findsOneWidget);
    final moreSize = tester.getSize(moreSemantics);
    expect(moreSize.width, greaterThanOrEqualTo(48));
    expect(moreSize.height, greaterThanOrEqualTo(48));

    await tester.tap(moreSemantics);
    expect(menuCount, 1);
  });

  testWidgets('a menu-only row keeps static content at full emphasis', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: EchoSongRow(song: song, onMorePressed: () {}),
          ),
        ),
      ),
    );

    final rowSemantics = find.bySemanticsLabel(
      RegExp('${song.title}.*已收藏.*试听'),
    );
    final rowData = tester.getSemantics(rowSemantics).getSemanticsData();
    expect(rowData.flagsCollection.isButton, isFalse);
    expect(
      find.ancestor(
        of: find.text(song.title),
        matching: find.byType(AnimatedOpacity),
      ),
      findsNothing,
    );
    expect(find.bySemanticsLabel('${song.title}，更多操作'), findsOneWidget);
  });

  testWidgets('selection mode exposes selected state and replaces playback', (
    tester,
  ) async {
    var playCount = 0;
    var menuCount = 0;
    var toggleCount = 0;

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: EchoSongRow(
              song: song,
              selectionMode: true,
              selected: true,
              onPressed: () => playCount += 1,
              onLongPress: () => menuCount += 1,
              onMorePressed: () => menuCount += 1,
              onToggleSelected: () => toggleCount += 1,
            ),
          ),
        ),
      ),
    );

    final row = find.bySemanticsLabel(RegExp('^${RegExp.escape(song.title)}，'));
    final toggle = find.bySemanticsLabel('取消选择 ${song.title}');
    expect(row, findsOneWidget);
    expect(toggle, findsOneWidget);
    expect(
      tester.getSemantics(row).flagsCollection.isSelected,
      Tristate.isTrue,
    );
    expect(find.bySemanticsLabel('${song.title}，更多操作'), findsNothing);

    await tester.tap(row);
    await tester.tap(toggle);
    expect(toggleCount, 2);
    expect(playCount, 0);
    expect(menuCount, 0);
    expect(tester.takeException(), isNull);
  });

  testWidgets('top-rank variant uses an explicit rank', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: EchoSongRow(
              song: song,
              variant: EchoSongRowVariant.topRank,
              rank: 2,
              onPressed: () {},
            ),
          ),
        ),
      ),
    );

    expect(find.text('2'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
