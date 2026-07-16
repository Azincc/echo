import 'dart:async';

import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/data/models/album.dart';
import 'package:echoes/data/models/artist.dart';
import 'package:echoes/data/models/song.dart';
import 'package:echoes/data/repositories/music_repository.dart';
import 'package:echoes/features/discover/pages/search_page.dart';
import 'package:echoes/features/library/pages/album_detail_page.dart';
import 'package:echoes/features/library/pages/artist_detail_page.dart';
import 'package:echoes/features/library/widgets/library_collection_components.dart';
import 'package:echoes/providers/music_provider.dart';
import 'package:echoes/providers/player_provider.dart';
import 'package:echoes/widgets/song_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../player/test_player_notifier.dart';

typedef _SearchHandler = Future<SearchResult> Function(Ref ref, String query);

void main() {
  final songs = <Song>[
    Song(
      id: 'song-1',
      title: '晨光序曲',
      artist: '远山乐队',
      album: '清晨航线',
      duration: 204,
    ),
    Song(
      id: 'song-2',
      title: '第二首有很长标题用于验证移动端大字体布局',
      artist: '歌手乙与城市室内乐团',
      album: '夜航',
      duration: 201,
    ),
  ];
  final album = Album(
    id: 'album-1',
    name: '夜航与一张标题很长的现场专辑',
    artist: '歌手乙与城市室内乐团',
    songCount: 12,
    duration: 2840,
  );
  final artist = Artist(id: 'artist-1', name: '歌手乙与城市室内乐团', albumCount: 2);

  SearchResult result({
    List<Song> resultSongs = const <Song>[],
    List<Album> albums = const <Album>[],
    List<Artist> artists = const <Artist>[],
  }) => SearchResult(songs: resultSongs, albums: albums, artists: artists);

  testWidgets('focuses initially, ignores blank and duplicate submissions', (
    tester,
  ) async {
    final queries = <String>[];
    final player = _RecordingPlayerNotifier(PlayerState());
    await _pumpSearchPage(
      tester,
      player: player,
      onSearch: (ref, query) async {
        queries.add(query);
        return result();
      },
    );

    final textField = find.byType(TextField);
    expect(find.text('搜索你的音乐库'), findsOneWidget);
    expect(tester.widget<TextField>(textField).focusNode!.hasFocus, isTrue);

    await tester.enterText(textField, '   ');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump();

    expect(queries, isEmpty);
    expect(tester.widget<TextField>(textField).focusNode!.hasFocus, isFalse);
    expect(find.text('搜索你的音乐库'), findsOneWidget);

    await tester.tap(textField);
    await tester.pump();
    await tester.enterText(textField, '晨光');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump();
    await tester.pump();

    expect(queries, <String>['晨光']);
    expect(find.text('没有找到相关结果'), findsOneWidget);
    expect(tester.widget<TextField>(textField).focusNode!.hasFocus, isFalse);

    await tester.tap(textField);
    await tester.pump();
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump(const Duration(milliseconds: 600));
    expect(queries, <String>['晨光']);

    await tester.tap(find.bySemanticsLabel('清空搜索'));
    await tester.pump();

    expect(find.text('搜索你的音乐库'), findsOneWidget);
    expect(tester.widget<TextField>(textField).controller!.text, isEmpty);
    expect(tester.widget<TextField>(textField).focusNode!.hasFocus, isTrue);
  });

  testWidgets('debounces typing while the search action submits immediately', (
    tester,
  ) async {
    final queries = <String>[];
    await _pumpSearchPage(
      tester,
      player: _RecordingPlayerNotifier(PlayerState()),
      onSearch: (ref, query) async {
        queries.add(query);
        return result();
      },
    );

    final textField = find.byType(TextField);
    await tester.enterText(textField, '晨');
    await tester.pump(const Duration(milliseconds: 300));
    await tester.enterText(textField, '晨光');
    await tester.pump(const Duration(milliseconds: 499));
    expect(queries, isEmpty);

    await tester.pump(const Duration(milliseconds: 1));
    await tester.pump();
    expect(queries, <String>['晨光']);

    await tester.enterText(textField, '晨光现场');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump();
    expect(queries, <String>['晨光', '晨光现场']);
    expect(tester.widget<TextField>(textField).focusNode!.hasFocus, isFalse);

    await tester.pump(const Duration(milliseconds: 600));
    expect(queries, <String>['晨光', '晨光现场']);
  });

  testWidgets('a new draft hides committed results until it is searched', (
    tester,
  ) async {
    final queries = <String>[];
    await _pumpSearchPage(
      tester,
      player: _RecordingPlayerNotifier(PlayerState()),
      onSearch: (ref, query) async {
        queries.add(query);
        return query == '晨光'
            ? result(resultSongs: <Song>[songs.first])
            : result();
      },
    );

    await _submitQuery(tester, '晨光');
    await tester.pump();
    expect(find.text(songs.first.title), findsOneWidget);

    final textField = find.byType(TextField);
    await tester.tap(textField);
    await tester.enterText(textField, '夜航');
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('准备搜索'), findsOneWidget);
    expect(find.text('停止输入后将搜索“夜航”。'), findsOneWidget);
    expect(find.text(songs.first.title), findsNothing);
    expect(queries, <String>['晨光']);

    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();
    expect(queries, <String>['晨光', '夜航']);
    expect(find.text('没有找到相关结果'), findsOneWidget);
  });

  testWidgets(
    'shows a mixed loading skeleton and a query-specific empty state',
    (tester) async {
      final completer = Completer<SearchResult>();
      await _pumpSearchPage(
        tester,
        player: _RecordingPlayerNotifier(PlayerState()),
        onSearch: (ref, query) => completer.future,
      );

      await _submitQuery(tester, '不存在');

      expect(
        find.byKey(const ValueKey<String>('search_results_loading')),
        findsOneWidget,
      );
      expect(find.bySemanticsLabel('正在搜索“不存在”'), findsOneWidget);
      final skeletons = tester.widgetList<EchoSkeleton>(
        find.byType(EchoSkeleton),
      );
      expect(
        skeletons.any(
          (skeleton) => skeleton.width == 72 && skeleton.height == 72,
        ),
        isTrue,
      );
      expect(
        skeletons.any(
          (skeleton) => skeleton.width == 56 && skeleton.height == 56,
        ),
        isTrue,
      );
      expect(
        skeletons.any(
          (skeleton) => skeleton.width == 48 && skeleton.height == 48,
        ),
        isTrue,
      );

      completer.complete(result());
      await tester.pump();
      await tester.pump();

      expect(find.text('没有找到相关结果'), findsOneWidget);
      expect(find.textContaining('“不存在”没有匹配'), findsOneWidget);
      final emptyStatus = tester.getSemantics(
        find.byKey(const ValueKey<String>('search_results_empty')),
      );
      expect(emptyStatus.flagsCollection.isLiveRegion, isTrue);
    },
  );

  testWidgets('shows a retryable error state and retries the active query', (
    tester,
  ) async {
    var attempts = 0;
    await _pumpSearchPage(
      tester,
      player: _RecordingPlayerNotifier(PlayerState()),
      onSearch: (ref, query) async {
        attempts += 1;
        await Future<void>.delayed(Duration.zero);
        ref.read(searchLoadFailedProvider(query).notifier).state =
            attempts == 1;
        return result();
      },
    );

    await _submitQuery(tester, '夜航');
    await tester.pumpAndSettle();

    expect(find.text('搜索失败'), findsOneWidget);
    expect(find.text('重试'), findsOneWidget);
    expect(attempts, 1);
    final errorStatus = tester.getSemantics(
      find.byKey(const ValueKey<String>('search_results_error')),
    );
    expect(errorStatus.flagsCollection.isLiveRegion, isTrue);

    await tester.tap(find.text('重试'));
    await tester.pumpAndSettle();

    expect(attempts, 2);
    expect(find.text('没有找到相关结果'), findsOneWidget);
  });

  testWidgets('uses distinct shared media rows without dividers at 200% text', (
    tester,
  ) async {
    final fullResult = result(
      resultSongs: songs,
      albums: <Album>[album],
      artists: <Artist>[artist],
    );
    await _pumpSearchPage(
      tester,
      size: const Size(320, 900),
      textScale: 2,
      player: _RecordingPlayerNotifier(
        PlayerState(
          currentSong: songs[1],
          queue: <Song>[songs[1]],
          currentIndex: 0,
        ),
      ),
      onSearch: (ref, query) async => fullResult,
    );

    await _submitQuery(tester, '夜航');
    await tester.pump();

    expect(find.byType(EchoSongRow), findsNWidgets(2));
    expect(find.byType(EchoDivider), findsNothing);
    final resultSummary = tester.getSemantics(
      find.byKey(const ValueKey<String>('search_results_summary')),
    );
    expect(resultSummary.flagsCollection.isLiveRegion, isTrue);
    expect(find.text('找到 4 项结果'), findsOneWidget);
    expect(tester.widget<Text>(find.text(songs[1].title)).maxLines, isNull);
    expect(
      find.byKey(const ValueKey<String>('search_section_songs')),
      findsOneWidget,
    );
    expect(find.bySemanticsLabel(RegExp('正在播放.*第二首.*歌手乙')), findsOneWidget);
    final resultsList = find.byKey(
      const ValueKey<String>('search_results_list'),
    );
    final resultsScrollable = find.descendant(
      of: resultsList,
      matching: find.byType(Scrollable),
    );
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey<String>('search_section_albums')),
      220,
      scrollable: resultsScrollable,
    );
    await tester.pump();
    expect(find.byType(EchoAlbumRow), findsOneWidget);
    await tester.scrollUntilVisible(
      find.byType(EchoArtistRow),
      280,
      scrollable: resultsScrollable,
    );
    await tester.pump();
    expect(find.byType(EchoArtistRow), findsOneWidget);
    expect(
      find.byKey(const ValueKey<String>('search_section_artists')),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(EchoArtistRow),
        matching: find.byType(ClipOval),
      ),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('final search result clears the compact bottom overlay', (
    tester,
  ) async {
    const bottomObstruction = 176.0;
    final resultSongs = List<Song>.generate(
      14,
      (index) => Song(
        id: 'overlay-song-$index',
        title: '遮挡回归歌曲 ${index + 1}',
        artist: '移动端测试歌手',
        duration: 180 + index,
      ),
    );
    final finalArtist = Artist(
      id: 'overlay-artist',
      name: '最后一位歌手',
      albumCount: 3,
    );

    await _pumpSearchPage(
      tester,
      size: const Size(390, 760),
      bottomObstruction: bottomObstruction,
      player: _RecordingPlayerNotifier(PlayerState()),
      onSearch: (ref, query) async =>
          result(resultSongs: resultSongs, artists: <Artist>[finalArtist]),
    );

    await _submitQuery(tester, '遮挡回归');
    await tester.pumpAndSettle();

    final resultsList = find.byKey(
      const ValueKey<String>('search_results_list'),
    );
    await tester.fling(resultsList, const Offset(0, -5000), 10000);
    await tester.pumpAndSettle();

    final artistRow = find.bySemanticsLabel('歌手 最后一位歌手，3 张专辑');
    final overlay = find.byKey(
      const ValueKey<String>('test-compact-bottom-overlay'),
    );
    expect(artistRow, findsOneWidget);
    expect(overlay, findsOneWidget);
    expect(
      tester.getBottomLeft(artistRow).dy,
      lessThanOrEqualTo(tester.getTopLeft(overlay).dy),
    );

    await tester.tap(artistRow);
    await tester.pumpAndSettle();
    expect(find.byType(ArtistDetailPage), findsOneWidget);
  });

  testWidgets('plays the selected song and opens album and artist routes', (
    tester,
  ) async {
    final player = _RecordingPlayerNotifier(PlayerState());
    await _pumpSearchPage(
      tester,
      player: player,
      onSearch: (ref, query) async => result(
        resultSongs: songs,
        albums: <Album>[album],
        artists: <Artist>[artist],
      ),
    );

    await _submitQuery(tester, '夜航');
    await tester.pump();

    await tester.tap(
      find.bySemanticsLabel('第二首有很长标题用于验证移动端大字体布局，歌手乙与城市室内乐团，03:21'),
    );
    await tester.pump();
    expect(player.playedQueues.single, songs);
    expect(player.startIndices.single, 1);

    final albumRow = find.bySemanticsLabel('专辑 夜航与一张标题很长的现场专辑，歌手乙与城市室内乐团');
    await tester.ensureVisible(albumRow);
    await tester.tap(albumRow);
    await tester.pumpAndSettle();
    expect(find.byType(AlbumDetailPage), findsOneWidget);

    Navigator.of(tester.element(find.byType(AlbumDetailPage))).pop();
    await tester.pumpAndSettle();

    final artistRow = find.bySemanticsLabel('歌手 歌手乙与城市室内乐团，2 张专辑');
    await tester.ensureVisible(artistRow);
    await tester.tap(artistRow);
    await tester.pumpAndSettle();
    expect(find.byType(ArtistDetailPage), findsOneWidget);
  });
}

Future<void> _pumpSearchPage(
  WidgetTester tester, {
  required _SearchHandler onSearch,
  required _RecordingPlayerNotifier player,
  Size size = const Size(430, 900),
  double textScale = 1,
  double bottomObstruction = 0,
}) async {
  await tester.binding.setSurfaceSize(size);
  addTearDown(() => tester.binding.setSurfaceSize(null));

  final page = EchoShellObstructionScope(
    bottom: bottomObstruction,
    child: const SearchPage(),
  );
  final home = bottomObstruction == 0
      ? page
      : Stack(
          fit: StackFit.expand,
          children: <Widget>[
            page,
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: bottomObstruction,
              child: const AbsorbPointer(
                child: ColoredBox(
                  key: ValueKey<String>('test-compact-bottom-overlay'),
                  color: Color(0x33000000),
                ),
              ),
            ),
          ],
        );

  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        searchProvider.overrideWith((ref, query) => onSearch(ref, query)),
        playerProvider.overrideWith((ref) => player),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
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
        home: home,
      ),
    ),
  );
  await tester.pump();
}

Future<void> _submitQuery(WidgetTester tester, String query) async {
  final textField = find.byType(TextField);
  await tester.enterText(textField, query);
  await tester.testTextInput.receiveAction(TextInputAction.search);
  await tester.pump();
  await tester.pump();
}

class _RecordingPlayerNotifier extends TestPlayerNotifier {
  _RecordingPlayerNotifier(super.state);

  final List<List<Song>> playedQueues = <List<Song>>[];
  final List<int> startIndices = <int>[];

  @override
  Future<void> playQueue(List<Song> songs, {int startIndex = 0}) async {
    playedQueues.add(List<Song>.unmodifiable(songs));
    startIndices.add(startIndex);
  }
}
