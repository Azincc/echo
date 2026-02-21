import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/song.dart';
import 'gd_music_provider.dart';

enum ExplorePreviewSearchMode { song, artist, album }

const explorePreviewPageSize = 30;

@immutable
class ExplorePreviewQuery {
  final String keyword;
  final String source;
  final ExplorePreviewSearchMode mode;
  final int page;
  final int count;

  const ExplorePreviewQuery({
    required this.keyword,
    required this.source,
    required this.mode,
    required this.page,
    this.count = explorePreviewPageSize,
  });

  String get requestSource =>
      mode == ExplorePreviewSearchMode.album ? '${source}_album' : source;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ExplorePreviewQuery &&
        other.keyword == keyword &&
        other.source == source &&
        other.mode == mode &&
        other.page == page &&
        other.count == count;
  }

  @override
  int get hashCode => Object.hash(keyword, source, mode, page, count);
}

final explorePreviewSourceProvider = StateProvider<String>((ref) => 'netease');
final explorePreviewModeProvider = StateProvider<ExplorePreviewSearchMode>(
  (ref) => ExplorePreviewSearchMode.song,
);

final explorePreviewSongsProvider = FutureProvider.autoDispose
    .family<List<Song>, ExplorePreviewQuery>((ref, query) async {
      final keyword = query.keyword.trim();
      if (keyword.isEmpty) return const [];

      final client = ref.watch(gdMusicApiClientProvider);
      return client.searchSongs(
        keyword: keyword,
        source: query.requestSource,
        count: query.count,
        page: query.page,
      );
    });
