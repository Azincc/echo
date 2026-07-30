import 'dart:ui' show Tristate;

import 'package:dio/dio.dart';
import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/network/address_pool.dart';
import 'package:echoes/core/network/connectivity_monitor.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/core/utils/toast_notifier.dart';
import 'package:echoes/data/models/music_library.dart';
import 'package:echoes/data/models/playlist.dart';
import 'package:echoes/data/models/server_address.dart';
import 'package:echoes/data/models/song.dart';
import 'package:echoes/data/repositories/library_repository.dart';
import 'package:echoes/data/repositories/playlist_repository.dart';
import 'package:echoes/features/library/pages/playlist_detail_page.dart';
import 'package:echoes/providers/api_provider.dart';
import 'package:echoes/providers/library_provider.dart';
import 'package:echoes/providers/player_provider.dart';
import 'package:echoes/providers/playlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../player/test_player_notifier.dart';

const _playlistId = 'playlist-1';

final _songs = <Song>[
  Song(
    id: 'duplicate-song',
    title: 'Zulu duplicate',
    artist: 'Test artist',
    duration: 180,
  ),
  Song(
    id: 'alpha-song',
    title: 'Alpha song',
    artist: 'Test artist',
    duration: 181,
  ),
  Song(
    id: 'duplicate-song',
    title: 'Bravo duplicate',
    artist: 'Test artist',
    duration: 182,
  ),
  Song(
    id: 'mike-song',
    title: 'Mike song',
    artist: 'Test artist',
    duration: 183,
  ),
];

final _playlist = Playlist(
  id: _playlistId,
  name: 'Selection test playlist',
  songCount: _songs.length,
  duration: _songs.fold<int>(0, (total, song) => total + (song.duration ?? 0)),
  songs: _songs,
);

final _playlistSnapshotProvider = StateProvider<Playlist>((ref) => _playlist);

class _MockLibraryRepository extends Mock implements LibraryRepository {}

class _RemovalCall {
  const _RemovalCall({required this.playlistId, required this.indexes});

  final String playlistId;
  final List<int> indexes;
}

class _RecordingPlaylistRepository extends Fake implements PlaylistRepository {
  final List<_RemovalCall> removalCalls = <_RemovalCall>[];
  Object? failure;

  @override
  Future<void> updatePlaylist({
    required String playlistId,
    String? name,
    String? comment,
    bool? public,
    List<String>? songIdsToAdd,
    List<int>? songIndexesToRemove,
  }) async {
    removalCalls.add(
      _RemovalCall(
        playlistId: playlistId,
        indexes: List<int>.of(songIndexesToRemove ?? const <int>[]),
      ),
    );
    final currentFailure = failure;
    if (currentFailure != null) throw currentFailure;
  }
}

Finder _playlistRow(int originalIndex) =>
    find.byKey(ValueKey<String>('playlist-song-$originalIndex'));

Finder _songSemantics(String title) =>
    find.bySemanticsLabel(RegExp('^${RegExp.escape(title)}，'));

void _expectSongSelected(
  WidgetTester tester,
  String title, {
  required bool selected,
}) {
  final semantics = tester.getSemantics(_songSemantics(title));
  expect(
    semantics.flagsCollection.isSelected,
    selected ? Tristate.isTrue : Tristate.isFalse,
  );
}

Future<void> _pumpPage(
  WidgetTester tester, {
  required _RecordingPlaylistRepository playlistRepository,
  Size size = const Size(800, 1200),
  double textScale = 1,
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPhysicalSize);

  final connectivityMonitor = ConnectivityMonitor(AddressPool(Dio()));
  final libraryRepository = _MockLibraryRepository();
  final player = TestPlayerNotifier(PlayerState());
  when(
    () => libraryRepository.watchLibraries(),
  ).thenAnswer((_) => Stream.value(const <MusicLibrary>[]));
  addTearDown(connectivityMonitor.stop);

  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        connectivityMonitorProvider.overrideWithValue(connectivityMonitor),
        libraryRepositoryProvider.overrideWithValue(libraryRepository),
        playerProvider.overrideWith((ref) => player),
        playlistRepositoryProvider.overrideWithValue(playlistRepository),
        ensureActiveAddressProvider.overrideWith(
          (ref) async => ServerAddress(
            id: 'server-1',
            libraryId: 'library-1',
            label: 'Test server',
            url: 'https://example.test',
            priority: 0,
          ),
        ),
        playlistDetailProvider(
          _playlistId,
        ).overrideWith((ref) async => ref.watch(_playlistSnapshotProvider)),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: rootScaffoldMessengerKey,
        theme: AppTheme.light(),
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(textScale)),
          child: child!,
        ),
        home: const PlaylistDetailPage(playlistId: _playlistId),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _confirmRemoval(WidgetTester tester) async {
  await tester.tap(find.bySemanticsLabel('移除选中歌曲'));
  await tester.pumpAndSettle();

  expect(find.text('移除歌曲'), findsOneWidget);
  expect(find.widgetWithText(EchoButton, '移除'), findsOneWidget);
  await tester.tap(find.widgetWithText(EchoButton, '移除'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets(
    'long press enters selection and duplicate song ids select independently',
    (tester) async {
      final repository = _RecordingPlaylistRepository();
      await _pumpPage(tester, playlistRepository: repository);

      await tester.longPress(_playlistRow(0));
      await tester.pumpAndSettle();

      expect(find.text('已选 1 首'), findsOneWidget);
      _expectSongSelected(tester, _songs[0].title, selected: true);
      _expectSongSelected(tester, _songs[2].title, selected: false);

      await tester.tap(_playlistRow(2));
      await tester.pumpAndSettle();

      expect(find.text('已选 2 首'), findsOneWidget);
      _expectSongSelected(tester, _songs[0].title, selected: true);
      _expectSongSelected(tester, _songs[2].title, selected: true);

      await tester.tap(_playlistRow(0));
      await tester.pumpAndSettle();

      expect(find.text('已选 1 首'), findsOneWidget);
      _expectSongSelected(tester, _songs[0].title, selected: false);
      _expectSongSelected(tester, _songs[2].title, selected: true);
      expect(repository.removalCalls, isEmpty);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('song action removes only the selected playlist occurrence', (
    tester,
  ) async {
    final repository = _RecordingPlaylistRepository();
    await _pumpPage(tester, playlistRepository: repository);

    await tester.tap(find.bySemanticsLabel('${_songs[2].title}，更多操作'));
    await tester.pumpAndSettle();

    final removeAction = find.text('从歌单移除');
    expect(removeAction, findsOneWidget);
    await tester.ensureVisible(removeAction);
    await tester.tap(removeAction);
    await tester.pumpAndSettle();

    expect(repository.removalCalls, hasLength(1));
    expect(repository.removalCalls.single.playlistId, _playlistId);
    expect(repository.removalCalls.single.indexes, <int>[2]);
    expect(find.text('移除歌曲'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('system back exits selection mode before leaving the playlist', (
    tester,
  ) async {
    final repository = _RecordingPlaylistRepository();
    await _pumpPage(tester, playlistRepository: repository);

    await tester.longPress(_playlistRow(0));
    await tester.pumpAndSettle();
    expect(find.text('已选 1 首'), findsOneWidget);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(find.byType(PlaylistDetailPage), findsOneWidget);
    expect(find.text('已选 1 首'), findsNothing);
    expect(find.bySemanticsLabel('管理歌单歌曲'), findsOneWidget);
    expect(repository.removalCalls, isEmpty);
    expect(tester.takeException(), isNull);
  });

  testWidgets('selection controls fit a compact screen with large text', (
    tester,
  ) async {
    final repository = _RecordingPlaylistRepository();
    await _pumpPage(
      tester,
      playlistRepository: repository,
      size: const Size(390, 844),
      textScale: 2,
    );

    await tester.tap(find.bySemanticsLabel('管理歌单歌曲'));
    await tester.pumpAndSettle();
    await tester.tap(find.bySemanticsLabel('全选歌曲'));
    await tester.pumpAndSettle();

    expect(find.text('已选 4 首'), findsOneWidget);
    final removeButton = find.bySemanticsLabel('移除选中歌曲');
    expect(removeButton, findsOneWidget);
    expect(tester.getSize(removeButton).height, greaterThanOrEqualTo(48));
    expect(tester.takeException(), isNull);
  });

  testWidgets('playlist refresh clears selection before indexes can go stale', (
    tester,
  ) async {
    final repository = _RecordingPlaylistRepository();
    await _pumpPage(tester, playlistRepository: repository);

    await tester.longPress(_playlistRow(0));
    await tester.pumpAndSettle();
    expect(find.text('已选 1 首'), findsOneWidget);

    final container = ProviderScope.containerOf(
      tester.element(find.byType(PlaylistDetailPage)),
    );
    container.read(_playlistSnapshotProvider.notifier).state = Playlist(
      id: _playlist.id,
      name: _playlist.name,
      songCount: _playlist.songCount,
      duration: _playlist.duration,
      changed: DateTime(2026, 7, 26),
      songs: _songs.reversed.toList(),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('已选'), findsNothing);
    expect(find.text('歌单内容已更新，请重新选择'), findsOneWidget);
    expect(find.bySemanticsLabel('管理歌单歌曲'), findsOneWidget);
    expect(repository.removalCalls, isEmpty);
    expect(tester.takeException(), isNull);
  });

  testWidgets('select all confirms one descending batch removal request', (
    tester,
  ) async {
    final repository = _RecordingPlaylistRepository();
    await _pumpPage(tester, playlistRepository: repository);

    await tester.longPress(_playlistRow(0));
    await tester.pumpAndSettle();
    await tester.tap(find.bySemanticsLabel('全选歌曲'));
    await tester.pumpAndSettle();

    expect(find.text('已选 4 首'), findsOneWidget);
    expect(find.bySemanticsLabel('取消全选歌曲'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('移除选中歌曲'));
    await tester.pumpAndSettle();

    expect(repository.removalCalls, isEmpty);
    expect(find.text('移除歌曲'), findsOneWidget);
    expect(find.textContaining('4'), findsWidgets);

    await tester.tap(find.widgetWithText(EchoButton, '移除'));
    await tester.pumpAndSettle();

    expect(repository.removalCalls, hasLength(1));
    expect(repository.removalCalls.single.playlistId, _playlistId);
    expect(repository.removalCalls.single.indexes, <int>[3, 2, 1, 0]);
    expect(find.textContaining('已选'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'alphabetical display still submits original indexes in descending order',
    (tester) async {
      final repository = _RecordingPlaylistRepository();
      await _pumpPage(tester, playlistRepository: repository);

      await tester.tap(find.bySemanticsLabel('歌曲排序：默认顺序'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('字母 A-Z'));
      await tester.pumpAndSettle();

      expect(
        tester.getTopLeft(_playlistRow(1)).dy,
        lessThan(tester.getTopLeft(_playlistRow(0)).dy),
      );

      await tester.longPress(_playlistRow(1));
      await tester.pumpAndSettle();
      await tester.tap(_playlistRow(0));
      await tester.pumpAndSettle();

      expect(find.text('已选 2 首'), findsOneWidget);
      await _confirmRemoval(tester);

      expect(repository.removalCalls, hasLength(1));
      expect(repository.removalCalls.single.playlistId, _playlistId);
      expect(repository.removalCalls.single.indexes, <int>[1, 0]);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('failed removal keeps every selected playlist occurrence', (
    tester,
  ) async {
    final repository = _RecordingPlaylistRepository()
      ..failure = StateError('offline');
    await _pumpPage(tester, playlistRepository: repository);

    await tester.longPress(_playlistRow(0));
    await tester.pumpAndSettle();
    await tester.tap(_playlistRow(2));
    await tester.pumpAndSettle();

    await _confirmRemoval(tester);

    expect(repository.removalCalls, hasLength(1));
    expect(repository.removalCalls.single.indexes, <int>[2, 0]);
    expect(find.text('网络异常，移除失败'), findsOneWidget);
    expect(find.text('已选 2 首'), findsOneWidget);
    _expectSongSelected(tester, _songs[0].title, selected: true);
    _expectSongSelected(tester, _songs[2].title, selected: true);
    expect(tester.takeException(), isNull);
  });
}
