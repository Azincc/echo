import 'dart:collection';

import 'package:echoes/data/models/song.dart';
import 'package:echoes/data/sources/remote/gd_music_api_client.dart';
import 'package:echoes/providers/explore_provider.dart';
import 'package:echoes/providers/gd_music_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'empty GD Studio results are retried until a non-empty page arrives',
    () async {
      final client = _SequencedGdMusicApiClient(<List<Song>>[
        const <Song>[],
        const <Song>[],
        <Song>[_previewSong()],
      ]);
      final container = _container(
        client: client,
        retryTimeout: const Duration(milliseconds: 200),
        retryDelay: const Duration(milliseconds: 1),
      );
      addTearDown(container.dispose);

      await container
          .read(exploreRemoteSearchProvider.notifier)
          .search(
            keyword: '空结果重试',
            source: 'netease',
            type: ExploreSearchType.song,
          );

      final state = container.read(exploreRemoteSearchProvider);
      expect(client.searchCalls, 3);
      expect(state.songs, hasLength(1));
      expect(state.error, isNull);
      expect(state.isLoading, isFalse);
    },
  );

  test(
    'persistent empty GD Studio results fail only after the retry timeout',
    () async {
      final client = _SequencedGdMusicApiClient(const <List<Song>>[]);
      final container = _container(
        client: client,
        retryTimeout: const Duration(milliseconds: 35),
        retryDelay: const Duration(milliseconds: 5),
      );
      addTearDown(container.dispose);

      final stopwatch = Stopwatch()..start();
      await container
          .read(exploreRemoteSearchProvider.notifier)
          .search(
            keyword: '持续空结果',
            source: 'netease',
            type: ExploreSearchType.song,
          );
      stopwatch.stop();

      final state = container.read(exploreRemoteSearchProvider);
      expect(client.searchCalls, greaterThan(1));
      expect(
        stopwatch.elapsed,
        greaterThanOrEqualTo(const Duration(milliseconds: 30)),
      );
      expect(state.songs, isEmpty);
      expect(state.isLoading, isFalse);
      expect(state.error, contains('持续返回空结果'));
    },
  );
}

ProviderContainer _container({
  required GdMusicApiClient client,
  required Duration retryTimeout,
  required Duration retryDelay,
}) {
  final container = ProviderContainer(
    overrides: <Override>[
      gdMusicApiClientProvider.overrideWithValue(client),
      exploreRemoteSearchProvider.overrideWith(
        (ref) => ExploreRemoteSearchNotifier(
          ref,
          retryTimeout: retryTimeout,
          initialRetryDelay: retryDelay,
        ),
      ),
    ],
  );
  container.listen<ExploreRemoteState>(
    exploreRemoteSearchProvider,
    (_, _) {},
    fireImmediately: true,
  );
  return container;
}

class _SequencedGdMusicApiClient extends GdMusicApiClient {
  _SequencedGdMusicApiClient(List<List<Song>> responses)
    : _responses = Queue<List<Song>>.of(responses);

  final Queue<List<Song>> _responses;
  int searchCalls = 0;

  @override
  Future<List<Song>> searchSongs({
    required String keyword,
    String source = 'netease',
    int count = 20,
    int page = 1,
  }) async {
    searchCalls += 1;
    return _responses.isEmpty ? const <Song>[] : _responses.removeFirst();
  }
}

Song _previewSong() {
  return Song(
    id: 'gd_netease_track-1',
    title: '重试成功',
    artist: '测试歌手',
    isPreview: true,
    previewSource: 'netease',
    previewTrackId: 'track-1',
  );
}
