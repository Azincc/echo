import 'dart:async';

import 'package:dio/dio.dart';
import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/network/address_pool.dart';
import 'package:echoes/core/network/connectivity_monitor.dart';
import 'package:echoes/core/services/offline_download_service.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/data/models/embed_service_config.dart';
import 'package:echoes/data/models/music_library.dart';
import 'package:echoes/data/models/song.dart';
import 'package:echoes/data/sources/remote/embed_service_client.dart';
import 'package:echoes/features/explore/pages/explore_page.dart';
import 'package:echoes/features/explore/widgets/explore_widgets.dart';
import 'package:echoes/providers/api_provider.dart';
import 'package:echoes/providers/explore_provider.dart';
import 'package:echoes/providers/library_provider.dart';
import 'package:echoes/providers/offline_download_provider.dart';
import 'package:echoes/providers/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../player/test_player_notifier.dart';

void main() {
  testWidgets('selection actions stay above the compact shell obstruction', (
    tester,
  ) async {
    const bottomObstruction = 176.0;
    final songs = List<Song>.generate(
      8,
      (index) => Song(
        id: 'remote-$index',
        title: '远程歌曲 ${index + 1}',
        artist: '探索测试歌手',
        album: '远程专辑',
        duration: 180 + index,
        isPreview: true,
        previewSource: 'netease',
        previewTrackId: 'track-$index',
      ),
    );
    final connectivity = ConnectivityMonitor(AddressPool(Dio()));
    addTearDown(connectivity.stop);

    await tester.binding.setSurfaceSize(const Size(390, 760));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          connectivityMonitorProvider.overrideWithValue(connectivity),
          exploreRemoteSearchProvider.overrideWith(
            (ref) => _StaticExploreRemoteSearchNotifier(
              ref,
              ExploreRemoteState(
                songs: songs,
                page: 1,
                hasMore: false,
                query: '浮层避让',
                source: 'netease',
              ),
            ),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          home: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              const EchoShellObstructionScope(
                bottom: bottomObstruction,
                child: ExplorePage(),
              ),
              const Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: bottomObstruction,
                child: AbsorbPointer(
                  child: ColoredBox(
                    key: ValueKey<String>('test-compact-bottom-overlay'),
                    color: Color(0x33000000),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pump();

    await tester.enterText(find.byType(TextField), '浮层避让');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();

    await tester.longPress(find.byType(ExploreRemoteSongRow).first);
    await tester.pumpAndSettle();

    final selectionBar = find.byType(ExploreSelectionBar);
    final overlay = find.byKey(
      const ValueKey<String>('test-compact-bottom-overlay'),
    );
    expect(selectionBar, findsOneWidget);
    expect(find.text('已选 1 首'), findsOneWidget);
    expect(
      tester.getBottomLeft(selectionBar).dy,
      lessThanOrEqualTo(tester.getTopLeft(overlay).dy),
    );

    await tester.tap(find.text('取消选择'));
    await tester.pumpAndSettle();
    expect(selectionBar, findsNothing);
  });

  testWidgets(
    'single remote download gives immediate feedback and ignores repeated taps',
    (tester) async {
      final song = Song(
        id: 'remote-download',
        title: '待下载歌曲',
        artist: '探索测试歌手',
        album: '远程专辑',
        duration: 188,
        isPreview: true,
        previewSource: 'netease',
        previewTrackId: 'track-download',
      );
      final connectivity = ConnectivityMonitor(AddressPool(Dio()));
      final downloadService = _ControllableOfflineDownloadService();
      final now = DateTime(2026, 7, 17);
      final library = MusicLibrary(
        id: 'library-1',
        name: '测试音乐库',
        isActive: true,
        extensions: const <String, dynamic>{
          'embedService': <String, dynamic>{
            'enabled': true,
            'baseUrl': 'https://embed.example.test',
            'apiKey': 'test-key',
            'libraryId': 'library-1',
          },
        },
        createdAt: now,
        updatedAt: now,
      );
      addTearDown(connectivity.stop);
      addTearDown(downloadService.dispose);

      await tester.pumpWidget(
        ProviderScope(
          overrides: <Override>[
            connectivityMonitorProvider.overrideWithValue(connectivity),
            activeLibraryProvider.overrideWithValue(library),
            offlineDownloadServiceProvider.overrideWithValue(downloadService),
            exploreRemoteSearchProvider.overrideWith(
              (ref) => _StaticExploreRemoteSearchNotifier(
                ref,
                ExploreRemoteState(
                  songs: <Song>[song],
                  page: 1,
                  hasMore: false,
                  query: '下载反馈',
                  source: 'netease',
                ),
              ),
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const ExplorePage(),
          ),
        ),
      );
      await tester.pump();

      await tester.enterText(find.byType(TextField), '下载反馈');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pumpAndSettle();

      final downloadAction = find.bySemanticsLabel('添加 待下载歌曲 到离线下载队列');
      expect(downloadAction, findsOneWidget);

      await tester.tap(downloadAction);
      await tester.tap(downloadAction);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      expect(downloadService.enqueueCount, 1);
      expect(find.bySemanticsLabel('正在添加 待下载歌曲 到离线下载队列'), findsOneWidget);
      expect(downloadAction, findsNothing);

      downloadService.completeRequest();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      expect(downloadService.enqueueCount, 1);
      expect(find.bySemanticsLabel('待下载歌曲 已加入离线下载队列'), findsOneWidget);
      expect(downloadAction, findsNothing);
    },
  );

  testWidgets('remote preview can be inserted after a normal current song', (
    tester,
  ) async {
    final currentSong = Song(id: 'normal', title: '音乐库歌曲');
    final previewSong = Song(
      id: 'gd_netease_preview-next',
      title: '待播试听歌曲',
      artist: '远程歌手',
      isPreview: true,
      previewSource: 'netease',
      previewTrackId: 'preview-next',
    );
    final player = TestPlayerNotifier(
      PlayerState(currentSong: currentSong, queue: <Song>[currentSong]),
    );
    final connectivity = ConnectivityMonitor(AddressPool(Dio()));
    addTearDown(connectivity.stop);

    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          connectivityMonitorProvider.overrideWithValue(connectivity),
          playerProvider.overrideWith((ref) => player),
          exploreRemoteSearchProvider.overrideWith(
            (ref) => _StaticExploreRemoteSearchNotifier(
              ref,
              ExploreRemoteState(
                songs: <Song>[previewSong],
                page: 1,
                hasMore: false,
                query: '下一曲',
                source: 'netease',
              ),
            ),
          ),
        ],
        child: MaterialApp(theme: AppTheme.light(), home: const ExplorePage()),
      ),
    );

    await tester.enterText(find.byType(TextField), '下一曲');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();

    await tester.tap(find.bySemanticsLabel('待播试听歌曲，更多试听操作'));
    await tester.pumpAndSettle();
    expect(find.text('试听歌曲操作'), findsOneWidget);

    await tester.tap(find.text('下一曲播放'));
    await tester.pumpAndSettle();

    expect(player.state.queue, <Song>[currentSong, previewSong]);
    expect(player.state.currentSong, currentSong);
  });
}

class _ControllableOfflineDownloadService extends OfflineDownloadService {
  _ControllableOfflineDownloadService()
    : super(embedClient: EmbedServiceClient());

  final Completer<void> _request = Completer<void>();
  int enqueueCount = 0;

  @override
  Future<void> enqueuePreviewSong({
    required Song song,
    required String libraryId,
    required EmbedServiceConfig config,
    bool force = false,
  }) {
    enqueueCount += 1;
    return _request.future;
  }

  void completeRequest() {
    if (!_request.isCompleted) _request.complete();
  }
}

class _StaticExploreRemoteSearchNotifier extends ExploreRemoteSearchNotifier {
  _StaticExploreRemoteSearchNotifier(super.ref, ExploreRemoteState initial) {
    state = initial;
  }

  @override
  Future<void> search({
    required String keyword,
    required String source,
    required ExploreSearchType type,
  }) async {}

  @override
  Future<void> loadNextPage() async {}
}
