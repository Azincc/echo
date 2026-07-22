import 'package:dio/dio.dart';
import 'package:echoes/data/models/song.dart';
import 'package:echoes/data/sources/remote/gd_music_api_client.dart';
import 'package:flutter_test/flutter_test.dart';

class _CoverCall {
  const _CoverCall(this.source, this.picId, this.preferredSizes);

  final String source;
  final String picId;
  final List<int> preferredSizes;
}

class _RecordingGdMusicApiClient extends GdMusicApiClient {
  _RecordingGdMusicApiClient({required this.songs, required this.coverUrls});

  final List<Song> songs;
  final Map<String, String?> coverUrls;
  final List<_CoverCall> coverCalls = <_CoverCall>[];
  String? searchKeyword;
  String? searchSource;
  int? searchCount;

  @override
  Future<List<Song>> searchSongs({
    required String keyword,
    String source = 'netease',
    int count = 20,
    int page = 1,
  }) async {
    searchKeyword = keyword;
    searchSource = source;
    searchCount = count;
    return songs;
  }

  @override
  Future<String?> resolveCoverUrl({
    required String source,
    required String picId,
    List<int> preferredSizes = const <int>[500, 300],
  }) async {
    coverCalls.add(_CoverCall(source, picId, preferredSizes));
    return coverUrls[picId];
  }
}

void main() {
  group('GdMusicApiClient metadata candidates', () {
    test(
      'keeps the first three valid songs and tolerates blank covers',
      () async {
        final client = _RecordingGdMusicApiClient(
          songs: <Song>[
            Song(
              id: 'invalid-id',
              title: 'Missing track id',
              isPreview: true,
              previewSource: 'netease',
            ),
            Song(
              id: 'invalid-title',
              title: '未知歌曲',
              isPreview: true,
              previewSource: 'netease',
              previewTrackId: 'unknown-title',
            ),
            Song(
              id: 'valid-1',
              title: 'Valid One',
              isPreview: true,
              previewSource: 'netease',
              previewTrackId: 'track-1',
              previewPicId: 'pic-1',
            ),
            Song(
              id: 'valid-2',
              title: 'Valid Two',
              isPreview: true,
              previewSource: 'netease',
              previewTrackId: 'track-2',
              previewPicId: 'pic-2',
            ),
            Song(
              id: 'valid-3',
              title: 'Valid Three',
              isPreview: true,
              previewSource: 'netease',
              previewTrackId: 'track-3',
            ),
            Song(
              id: 'valid-4',
              title: 'Valid Four',
              isPreview: true,
              previewSource: 'netease',
              previewTrackId: 'track-4',
              previewPicId: 'pic-4',
            ),
          ],
          coverUrls: const <String, String?>{
            'pic-1': 'https://cover.test/one.jpg',
            'pic-2': null,
            'pic-4': 'https://cover.test/four.jpg',
          },
        );

        final results = await client.searchMetadataCandidates(
          keyword: 'Slow Down - Artist',
          source: 'netease',
        );

        expect(client.searchKeyword, 'Slow Down - Artist');
        expect(client.searchSource, 'netease');
        expect(client.searchCount, 10);
        expect(results.map((song) => song.title), <String>[
          'Valid One',
          'Valid Two',
          'Valid Three',
        ]);
        expect(results[0].previewCoverUrl, 'https://cover.test/one.jpg');
        expect(results[1].previewCoverUrl, isNull);
        expect(results[2].previewCoverUrl, isNull);
        expect(client.coverCalls, hasLength(2));
        expect(client.coverCalls.map((call) => call.picId), <String>[
          'pic-1',
          'pic-2',
        ]);
        for (final call in client.coverCalls) {
          expect(call.source, 'netease');
          expect(call.preferredSizes, <int>[500, 300]);
        }
      },
    );

    test(
      'parses string, list and object metadata returned by search',
      () async {
        final dio = Dio(BaseOptions(baseUrl: 'https://music-api.test'));
        dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              handler.resolve(
                Response<dynamic>(
                  requestOptions: options,
                  statusCode: 200,
                  data: <Map<String, dynamic>>[
                    <String, dynamic>{
                      'id': 'track-1',
                      'name': 'Object Metadata',
                      'artist': <Map<String, dynamic>>[
                        <String, dynamic>{'name': 'Artist One'},
                        <String, dynamic>{'artistName': 'Artist Two'},
                      ],
                      'album': <String, dynamic>{'name': 'Album Object'},
                      'pic_id': 'pic-1',
                    },
                    <String, dynamic>{
                      'id': 'track-2',
                      'name': 'String Metadata',
                      'artist': 'Solo Artist',
                      'album': 'String Album',
                    },
                  ],
                ),
              );
            },
          ),
        );
        final client = GdMusicApiClient(dio);

        final songs = await client.searchSongs(
          keyword: 'metadata shapes',
          source: 'kuwo',
        );

        expect(songs, hasLength(2));
        expect(songs[0].artist, 'Artist One / Artist Two');
        expect(songs[0].album, 'Album Object');
        expect(songs[0].previewSource, 'kuwo');
        expect(songs[1].artist, 'Solo Artist');
        expect(songs[1].album, 'String Album');
      },
    );

    test('resolves a cover at 500px before falling back to 300px', () async {
      final requestedSizes = <int>[];
      final dio = Dio(BaseOptions(baseUrl: 'https://music-api.test'));
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            final size = options.queryParameters['size'] as int;
            requestedSizes.add(size);
            handler.resolve(
              Response<dynamic>(
                requestOptions: options,
                statusCode: 200,
                data: <String, dynamic>{
                  'url': size == 300 ? 'http://cover.test/300.jpg' : '',
                },
              ),
            );
          },
        ),
      );
      final client = GdMusicApiClient(dio);

      final coverUrl = await client.resolveCoverUrl(
        source: 'kuwo',
        picId: 'cover-id',
      );

      expect(requestedSizes, <int>[500, 300]);
      expect(coverUrl, 'http://cover.test/300.jpg');
    });
  });
}
