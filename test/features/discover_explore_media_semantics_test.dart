import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/data/models/song.dart';
import 'package:echoes/features/discover/widgets/discover_media_widgets.dart';
import 'package:echoes/features/explore/widgets/explore_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final song = Song(
    id: 'song-1',
    title: '晨光',
    artist: '示例歌手',
    album: '清晨',
    duration: 204,
  );

  Widget app(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: Center(child: SizedBox(width: 360, child: child)),
        ),
      ),
    );
  }

  testWidgets('Discover song keeps its more action as a separate node', (
    tester,
  ) async {
    var rowPresses = 0;
    var actionPresses = 0;

    await tester.pumpWidget(
      app(
        DiscoverSongTile(
          song: song,
          onPressed: () => rowPresses++,
          onOpenActions: () => actionPresses++,
        ),
      ),
    );

    expect(find.bySemanticsLabel('晨光，示例歌手，03:24'), findsOneWidget);
    expect(find.bySemanticsLabel('晨光 操作'), findsOneWidget);
    expect(find.bySemanticsLabel('晨光 封面'), findsNothing);
    expect(find.bySemanticsLabel('晨光'), findsNothing);

    await tester.tap(find.bySemanticsLabel('晨光 操作'));
    expect(actionPresses, 1);
    expect(rowPresses, 0);
  });

  testWidgets('Explore row preserves download, selection, and live status', (
    tester,
  ) async {
    var rowPresses = 0;
    var selectionPresses = 0;
    var morePresses = 0;
    var downloadPresses = 0;

    Widget subject({
      bool selectionMode = false,
      bool resolving = false,
      ExploreRemoteDownloadState downloadState =
          ExploreRemoteDownloadState.idle,
    }) {
      return app(
        ExploreRemoteSongRow(
          song: song,
          selected: false,
          selectionMode: selectionMode,
          resolving: resolving,
          downloadState: downloadState,
          onPressed: () => rowPresses++,
          onLongPress: () {},
          onToggleSelected: () => selectionPresses++,
          onMorePressed: () => morePresses++,
          onDownload: () => downloadPresses++,
        ),
      );
    }

    await tester.pumpWidget(subject());

    expect(find.bySemanticsLabel('晨光，示例歌手 · 清晨，远程试听'), findsOneWidget);
    expect(find.bySemanticsLabel('晨光，更多试听操作'), findsOneWidget);
    expect(find.bySemanticsLabel('添加 晨光 到离线下载队列'), findsOneWidget);
    expect(find.bySemanticsLabel('晨光 封面'), findsNothing);
    expect(find.bySemanticsLabel('试听'), findsNothing);

    await tester.tap(find.bySemanticsLabel('添加 晨光 到离线下载队列'));
    expect(downloadPresses, 1);
    await tester.tap(find.bySemanticsLabel('晨光，更多试听操作'));
    expect(morePresses, 1);
    expect(rowPresses, 0);

    await tester.pumpWidget(subject(selectionMode: true));
    expect(find.bySemanticsLabel('选择 晨光'), findsOneWidget);
    expect(find.bySemanticsLabel('添加 晨光 到离线下载队列'), findsNothing);

    await tester.tap(find.bySemanticsLabel('选择 晨光'));
    expect(selectionPresses, 1);
    expect(rowPresses, 0);

    await tester.pumpWidget(subject(resolving: true));
    final resolvingNode = tester.getSemantics(find.bySemanticsLabel('正在解析 晨光'));
    expect(resolvingNode.flagsCollection.isLiveRegion, isTrue);
    expect(find.bySemanticsLabel('添加 晨光 到离线下载队列'), findsNothing);

    await tester.pumpWidget(
      subject(downloadState: ExploreRemoteDownloadState.submitting),
    );
    await tester.pump(const Duration(milliseconds: 200));
    final submittingNode = tester.getSemantics(
      find.bySemanticsLabel('正在添加 晨光 到离线下载队列'),
    );
    expect(submittingNode.flagsCollection.isLiveRegion, isTrue);
    expect(find.bySemanticsLabel('添加 晨光 到离线下载队列'), findsNothing);

    await tester.pumpWidget(
      subject(downloadState: ExploreRemoteDownloadState.queued),
    );
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.bySemanticsLabel('晨光 已加入离线下载队列'), findsOneWidget);
    expect(find.bySemanticsLabel('添加 晨光 到离线下载队列'), findsNothing);
  });
}
