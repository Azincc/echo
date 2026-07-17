import 'dart:async';

import 'package:dio/dio.dart';
import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/network/address_pool.dart';
import 'package:echoes/core/network/connectivity_monitor.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/data/models/album.dart';
import 'package:echoes/data/models/song.dart';
import 'package:echoes/features/discover/pages/discover_page.dart';
import 'package:echoes/features/discover/widgets/discover_media_widgets.dart';
import 'package:echoes/features/library/pages/album_detail_page.dart';
import 'package:echoes/providers/api_provider.dart';
import 'package:echoes/providers/music_provider.dart';
import 'package:echoes/providers/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../player/test_player_notifier.dart';

void main() {
  testWidgets('discover uses four distinct music-flow compositions', (
    tester,
  ) async {
    final songs = _songs();
    final recent = _albums('最近专辑');
    final newest = _albums('新入库');
    final frequent = _albums('常听');

    await _pumpDiscover(
      tester,
      songs: songs,
      recent: recent,
      newest: newest,
      frequent: frequent,
    );

    expect(find.text('随机推荐'), findsNothing);
    expect(find.byType(DiscoverRecentAlbumRail), findsOneWidget);
    expect(find.byKey(const Key('discover-recent-spotlight')), findsOneWidget);
    expect(find.byKey(const Key('discover-random-mix')), findsOneWidget);
    expect(find.byType(DiscoverRecentAlbumCard), findsWidgets);
    expect(find.byType(DiscoverSongTile), findsNWidgets(6));
    expect(
      tester.getSize(find.byType(DiscoverRecentAlbumCard).first).width,
      lessThan(
        tester
            .getSize(find.byKey(const Key('discover-recent-spotlight')))
            .width,
      ),
    );
    expect(
      tester.getTopLeft(find.text('最近播放')).dy,
      lessThan(tester.getTopLeft(find.text('随心听')).dy),
    );

    await tester.drag(find.byType(ListView).first, const Offset(0, -1200));
    await tester.pumpAndSettle();

    expect(find.byType(DiscoverAlbumRail), findsOneWidget);
    expect(find.byKey(const Key('discover-newest-rail')), findsOneWidget);
    expect(find.byType(DiscoverAlbumTile), findsWidgets);
    expect(find.byType(DiscoverFrequentAlbumShelf), findsOneWidget);
    final frequentShelf = find.byKey(const Key('discover-frequent-shelf'));
    expect(frequentShelf, findsOneWidget);
    expect(
      find.descendant(of: frequentShelf, matching: find.byType(ListView)),
      findsOneWidget,
    );
    expect(find.byKey(const Key('discover-frequent-group-0')), findsOneWidget);
    await tester.drag(frequentShelf, const Offset(-900, 0));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('discover-frequent-group-3')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('discover survives 320dp and 200 percent text scaling', (
    tester,
  ) async {
    final songs = _songs(titlePrefix: '这是一首标题很长用于验证窄屏排版的歌曲', count: 2);
    final albums = _albums('这是一张名称很长用于验证移动端排版的专辑', count: 4);

    await _pumpDiscover(
      tester,
      size: const Size(320, 800),
      textScale: 2,
      songs: songs,
      recent: albums,
      newest: albums,
      frequent: albums,
    );

    expect(tester.takeException(), isNull);
    final recentSpotlight = find.byKey(const Key('discover-recent-spotlight'));
    expect(
      find.descendant(of: recentSpotlight, matching: find.byType(ListView)),
      findsNothing,
    );
    final recentTitle = find.descendant(
      of: recentSpotlight,
      matching: find.text(albums.first.name),
    );
    expect(tester.widget<Text>(recentTitle).maxLines, isNull);
    await tester.scrollUntilVisible(
      find.byKey(const Key('discover-random-mix')),
      320,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pump();
    final playMix = find.bySemanticsLabel('播放随心听');
    final moreAction = find.bySemanticsLabel('${songs.first.title} 操作');
    expect(playMix, findsOneWidget);
    expect(moreAction, findsOneWidget);
    expect(tester.getSize(playMix).height, greaterThanOrEqualTo(48));
    expect(tester.getSize(moreAction).width, greaterThanOrEqualTo(48));
    expect(tester.getSize(moreAction).height, greaterThanOrEqualTo(48));

    final pageScrollable = find.byType(Scrollable).first;
    final newestRail = find.byKey(const Key('discover-newest-rail'));
    await tester.scrollUntilVisible(
      newestRail,
      400,
      scrollable: pageScrollable,
    );
    await tester.pump();
    expect(
      find.descendant(of: newestRail, matching: find.byType(ListView)),
      findsNothing,
    );
    expect(
      tester
          .widget<Text>(
            find.descendant(
              of: newestRail,
              matching: find.text(albums.first.name),
            ),
          )
          .maxLines,
      isNull,
    );

    final frequentShelf = find.byKey(const Key('discover-frequent-shelf'));
    await tester.scrollUntilVisible(
      frequentShelf,
      400,
      scrollable: pageScrollable,
    );
    await tester.pump();
    expect(frequentShelf, findsOneWidget);
    expect(
      find.descendant(of: frequentShelf, matching: find.byType(GridView)),
      findsNothing,
    );
    expect(find.byKey(const Key('discover-frequent-group-0')), findsNothing);
    expect(find.byType(DiscoverAlbumTile), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('frequent shelf bounds long text before accessible mode', (
    tester,
  ) async {
    final frequent = _albums('这是一张名称非常长用于验证双行书架边界的专辑', count: 4);
    await _pumpDiscover(
      tester,
      textScale: 1.2,
      songs: _songs(count: 2),
      recent: _albums('最近专辑', count: 2),
      newest: _albums('新入库', count: 2),
      frequent: frequent,
    );

    for (var index = 0; index < 5; index += 1) {
      await tester.drag(find.byType(ListView).first, const Offset(0, -500));
      await tester.pump();
    }

    final shelf = find.byKey(const Key('discover-frequent-shelf'));
    expect(
      find.descendant(of: shelf, matching: find.byType(ListView)),
      findsOneWidget,
    );
    final firstGroup = find.byKey(const Key('discover-frequent-group-0'));
    final groupSurface = tester.widget<DecoratedBox>(
      find
          .descendant(of: firstGroup, matching: find.byType(DecoratedBox))
          .first,
    );
    final decoration = groupSurface.decoration as BoxDecoration;
    expect(decoration.color, tester.element(firstGroup).echoColors.surface);
    expect(decoration.border, isNotNull);
    final groupDividerFinder = find.descendant(
      of: firstGroup,
      matching: find.byType(EchoDivider),
    );
    expect(groupDividerFinder, findsOneWidget);
    final groupDivider = tester.widget<EchoDivider>(groupDividerFinder);
    expect(groupDivider.inset, 0);
    expect(groupDivider.endInset, 0);
    expect(groupDivider.color, tester.element(firstGroup).echoColors.divider);
    final title = find.descendant(
      of: shelf,
      matching: find.text(frequent.first.name),
    );
    final titleText = tester.widget<Text>(title);
    expect(titleText.maxLines, 2);
    expect(titleText.overflow, TextOverflow.ellipsis);
    expect(tester.takeException(), isNull);
  });

  testWidgets('random loading mirrors the wide two-column song rhythm', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(840, 600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: Center(
            child: SizedBox(width: 800, child: DiscoverSongLoading()),
          ),
        ),
      ),
    );

    final wrap = tester.widget<Wrap>(find.byType(Wrap));
    expect(wrap.children, hasLength(6));
    final firstItem = wrap.children.first as SizedBox;
    expect(firstItem.width, closeTo(392, 0.01));
    expect(
      tester.getSize(find.byWidget(firstItem)).height,
      greaterThanOrEqualTo(72),
    );
  });

  testWidgets('song taps and the mix action preserve queue playback', (
    tester,
  ) async {
    final songs = _songs(count: 3);
    final player = _RecordingPlayerNotifier();

    await _pumpDiscover(
      tester,
      songs: songs,
      recent: _albums('最近专辑', count: 2),
      newest: _albums('新入库', count: 2),
      frequent: _albums('常听', count: 2),
      player: player,
    );

    await tester.tap(
      find.bySemanticsLabel(
        '${songs[1].title}，${songs[1].artist}，${songs[1].durationString}',
      ),
    );
    await tester.pump();

    expect(player.queues, hasLength(1));
    expect(
      player.queues.single.map((song) => song.id),
      songs.map((song) => song.id),
    );
    expect(player.startIndices.single, 1);

    await tester.tap(find.bySemanticsLabel('播放随心听'));
    await tester.pump();

    expect(player.queues, hasLength(2));
    expect(player.startIndices.last, 0);
  });

  testWidgets('album taps keep the existing detail navigation', (tester) async {
    final recent = _albums('最近专辑', count: 2);

    await _pumpDiscover(
      tester,
      songs: _songs(count: 2),
      recent: recent,
      newest: _albums('新入库', count: 2),
      frequent: _albums('常听', count: 2),
    );

    final album = recent.first;
    await tester.tap(
      find.bySemanticsLabel(
        '最近播放专辑 ${album.name}，${album.artist}，${album.songCount} 首歌曲',
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(AlbumDetailPage), findsOneWidget);
    expect(
      tester.widget<AlbumDetailPage>(find.byType(AlbumDetailPage)).albumId,
      album.id,
    );
  });

  testWidgets('pull refresh invalidates every discover data source', (
    tester,
  ) async {
    var randomLoads = 0;
    var recentLoads = 0;
    var newestLoads = 0;
    var frequentLoads = 0;
    final songs = _songs(count: 1);
    final albums = _albums('专辑', count: 1);
    final randomRefresh = Completer<List<Song>>();
    final recentRefresh = Completer<List<Album>>();
    final newestRefresh = Completer<List<Album>>();
    final frequentRefresh = Completer<List<Album>>();

    await _pumpDiscover(
      tester,
      extraOverrides: <Override>[
        randomSongsProvider.overrideWith((ref) async {
          randomLoads += 1;
          return randomLoads == 1 ? songs : randomRefresh.future;
        }),
        recentAlbumsProvider.overrideWith((ref) async {
          recentLoads += 1;
          return recentLoads == 1 ? albums : recentRefresh.future;
        }),
        newestAlbumsProvider.overrideWith((ref) async {
          newestLoads += 1;
          return newestLoads == 1 ? albums : newestRefresh.future;
        }),
        frequentAlbumsProvider.overrideWith((ref) async {
          frequentLoads += 1;
          return frequentLoads == 1 ? albums : frequentRefresh.future;
        }),
      ],
    );

    final refreshView = tester.widget<EchoRefreshView>(
      find.byType(EchoRefreshView),
    );
    final refresh = refreshView.onRefresh();
    var refreshCompleted = false;
    final trackedRefresh = refresh.then((_) => refreshCompleted = true);
    await tester.pump();

    expect(
      <int>[randomLoads, recentLoads, newestLoads, frequentLoads],
      <int>[2, 2, 2, 2],
    );
    expect(refreshCompleted, isFalse);

    randomRefresh.complete(songs);
    recentRefresh.complete(albums);
    newestRefresh.complete(albums);
    await tester.pump();
    expect(refreshCompleted, isFalse);

    frequentRefresh.complete(albums);
    await trackedRefresh;
    await tester.pumpAndSettle();
    expect(refreshCompleted, isTrue);
  });

  testWidgets('section errors and empty states remain local', (tester) async {
    await _pumpDiscover(
      tester,
      extraOverrides: <Override>[
        randomSongsProvider.overrideWith((ref) async => _songs(count: 2)),
        recentAlbumsProvider.overrideWith((ref) async {
          throw StateError('recent unavailable');
        }),
        newestAlbumsProvider.overrideWith((ref) async => <Album>[]),
        frequentAlbumsProvider.overrideWith(
          (ref) async => _albums('常听', count: 2),
        ),
      ],
    );

    expect(find.text('最近播放加载失败'), findsOneWidget);
    expect(find.text('暂无最近入库'), findsOneWidget);
    expect(find.byKey(const Key('discover-random-mix')), findsOneWidget);
    expect(find.text('随心听'), findsOneWidget);
    expect(find.bySemanticsLabel('最近播放加载失败，请检查网络或切换线路后重试。'), findsOneWidget);
    expect(find.bySemanticsLabel('最近播放加载失败'), findsNothing);
    expect(find.bySemanticsLabel('重试'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

class _RecordingPlayerNotifier extends TestPlayerNotifier {
  _RecordingPlayerNotifier() : super(PlayerState());

  final List<List<Song>> queues = <List<Song>>[];
  final List<int> startIndices = <int>[];

  @override
  Future<void> playQueue(List<Song> songs, {int startIndex = 0}) async {
    queues.add(List<Song>.of(songs));
    startIndices.add(startIndex);
  }
}

Future<void> _pumpDiscover(
  WidgetTester tester, {
  Size size = const Size(390, 900),
  double textScale = 1,
  List<Song>? songs,
  List<Album>? recent,
  List<Album>? newest,
  List<Album>? frequent,
  _RecordingPlayerNotifier? player,
  List<Override> extraOverrides = const <Override>[],
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPhysicalSize);

  final connectivity = ConnectivityMonitor(AddressPool(Dio()));
  addTearDown(connectivity.stop);
  final overrides = <Override>[
    connectivityMonitorProvider.overrideWithValue(connectivity),
    playerProvider.overrideWith((ref) => player ?? _RecordingPlayerNotifier()),
    if (extraOverrides.isEmpty) ...<Override>[
      randomSongsProvider.overrideWith((ref) async => songs ?? _songs()),
      recentAlbumsProvider.overrideWith(
        (ref) async => recent ?? _albums('最近专辑'),
      ),
      newestAlbumsProvider.overrideWith(
        (ref) async => newest ?? _albums('新入库'),
      ),
      frequentAlbumsProvider.overrideWith(
        (ref) async => frequent ?? _albums('常听'),
      ),
    ],
    ...extraOverrides,
  ];

  await tester.pumpWidget(
    ProviderScope(
      overrides: overrides,
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
        home: const DiscoverPage(),
      ),
    ),
  );
  await tester.pump();
  await tester.pumpAndSettle();
}

List<Song> _songs({String titlePrefix = '歌曲', int count = 8}) {
  return List<Song>.generate(
    count,
    (index) => Song(
      id: 'song-$index',
      title: '$titlePrefix ${index + 1}',
      artist: '歌手 ${index + 1}',
      duration: 180 + index,
    ),
  );
}

List<Album> _albums(String namePrefix, {int count = 8}) {
  return List<Album>.generate(
    count,
    (index) => Album(
      id: '${namePrefix.hashCode}-$index',
      name: '$namePrefix ${index + 1}',
      artist: '歌手 ${index + 1}',
      songCount: 10 + index,
      duration: 2400 + index * 120,
    ),
  );
}
