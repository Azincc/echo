import 'package:dio/dio.dart';
import 'package:echoes/core/network/address_pool.dart';
import 'package:echoes/core/network/connectivity_monitor.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/data/models/album.dart';
import 'package:echoes/data/models/song.dart';
import 'package:echoes/data/repositories/music_repository.dart';
import 'package:echoes/features/library/pages/album_detail_page.dart';
import 'package:echoes/features/library/widgets/media_detail_components.dart';
import 'package:echoes/providers/api_provider.dart';
import 'package:echoes/providers/music_provider.dart';
import 'package:echoes/widgets/song_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'compact album header leaves three tracks visible at first paint',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(390, 844);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);

      final connectivityMonitor = ConnectivityMonitor(AddressPool(Dio()));
      addTearDown(connectivityMonitor.stop);

      final songs = List<Song>.generate(
        5,
        (index) => Song(
          id: 'song-${index + 1}',
          title: '第 ${index + 1} 首歌曲',
          artist: '测试歌手',
          album: '紧凑专辑',
          albumId: 'album-1',
          track: index + 1,
          duration: 180,
        ),
      );
      final album = Album(
        id: 'album-1',
        name: '紧凑专辑',
        artist: '测试歌手',
        songCount: songs.length,
        duration: 900,
        year: 2026,
        genre: '流行',
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: <Override>[
            connectivityMonitorProvider.overrideWithValue(connectivityMonitor),
            albumDetailProvider(album.id).overrideWith(
              (ref) async => AlbumDetail(album: album, songs: songs),
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: MediaQuery(
              data: const MediaQueryData(
                size: Size(390, 844),
                padding: EdgeInsets.only(top: 44, bottom: 34),
              ),
              child: AlbumDetailPage(albumId: album.id),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.getSize(find.byType(MediaDetailArtwork)).shortestSide, 112);

      final thirdTrack = find.ancestor(
        of: find.text('第 3 首歌曲'),
        matching: find.byType(SongListItem),
      );
      expect(thirdTrack, findsOneWidget);

      const miniPlayerAndNavigationHeight = 182.0;
      final visibleBottom =
          tester.view.physicalSize.height - miniPlayerAndNavigationHeight;
      expect(
        tester.getRect(thirdTrack).bottom,
        lessThanOrEqualTo(visibleBottom),
      );
      expect(tester.takeException(), isNull);
    },
  );
}
