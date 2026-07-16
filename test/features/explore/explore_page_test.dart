import 'package:dio/dio.dart';
import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/network/address_pool.dart';
import 'package:echoes/core/network/connectivity_monitor.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/data/models/song.dart';
import 'package:echoes/features/explore/pages/explore_page.dart';
import 'package:echoes/features/explore/widgets/explore_widgets.dart';
import 'package:echoes/providers/api_provider.dart';
import 'package:echoes/providers/explore_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

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
