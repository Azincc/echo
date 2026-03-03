import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/song.dart';
import 'gd_music_provider.dart';

// ── Enums ──

/// Search type: keyword, artist, album, or playlist ID
enum ExploreSearchType { song, artist, album, playlist }

/// Search mode: local (Navidrome library) or remote (online sources)
enum ExploreSearchMode { local, remote }

// ── Remote search state ──

@immutable
class ExploreRemoteState {
  final List<Song> songs;
  final int page;
  final bool isLoading;
  final bool hasMore;
  final String? error;
  final int retryCount;
  final String query;
  final String source;
  final ExploreSearchType searchType;

  const ExploreRemoteState({
    this.songs = const [],
    this.page = 0,
    this.isLoading = false,
    this.hasMore = true,
    this.error,
    this.retryCount = 0,
    this.query = '',
    this.source = 'netease',
    this.searchType = ExploreSearchType.song,
  });

  ExploreRemoteState copyWith({
    List<Song>? songs,
    int? page,
    bool? isLoading,
    bool? hasMore,
    String? error,
    bool clearError = false,
    int? retryCount,
    String? query,
    String? source,
    ExploreSearchType? searchType,
  }) {
    return ExploreRemoteState(
      songs: songs ?? this.songs,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      error: clearError ? null : (error ?? this.error),
      retryCount: retryCount ?? this.retryCount,
      query: query ?? this.query,
      source: source ?? this.source,
      searchType: searchType ?? this.searchType,
    );
  }
}

// ── Constants ──

const exploreRemotePageSize = 30;
const _maxRetries = 3;

// ── StateNotifier ──

class ExploreRemoteSearchNotifier extends StateNotifier<ExploreRemoteState> {
  final Ref _ref;

  ExploreRemoteSearchNotifier(this._ref) : super(const ExploreRemoteState());

  /// Start a new search, resetting all state.
  Future<void> search({
    required String keyword,
    required String source,
    required ExploreSearchType type,
  }) async {
    final q = keyword.trim();
    if (q.isEmpty) {
      state = const ExploreRemoteState();
      return;
    }

    state = ExploreRemoteState(
      query: q,
      source: source,
      searchType: type,
      isLoading: true,
      hasMore: true,
    );

    await _fetchPage(1);
  }

  /// Load the next page (called by scroll listener).
  Future<void> loadNextPage() async {
    if (state.isLoading || !state.hasMore || state.query.isEmpty) return;
    state = state.copyWith(isLoading: true, clearError: true);
    await _fetchPage(state.page + 1);
  }

  /// Change the remote source and re-search.
  Future<void> changeSource(String source) async {
    if (state.query.isEmpty) {
      state = state.copyWith(source: source);
      return;
    }
    await search(keyword: state.query, source: source, type: state.searchType);
  }

  /// Reset all state.
  void reset() {
    state = const ExploreRemoteState();
  }

  /// Fetch a single page with auto-retry on error.
  Future<void> _fetchPage(int page) async {
    for (var attempt = 0; attempt <= _maxRetries; attempt++) {
      if (!mounted) return;
      try {
        final client = _ref.read(gdMusicApiClientProvider);
        List<Song> results;

        if (state.searchType == ExploreSearchType.playlist) {
          // Playlist search: single request, no pagination
          results = await client.searchPlaylist(playlistId: state.query);
        } else {
          final requestSource = state.searchType == ExploreSearchType.album
              ? '${state.source}_album'
              : state.source;
          results = await client.searchSongs(
            keyword: state.query,
            source: requestSource,
            count: exploreRemotePageSize,
            page: page,
          );
        }

        if (!mounted) return;

        final isPlaylist = state.searchType == ExploreSearchType.playlist;
        state = state.copyWith(
          songs: page == 1 ? results : [...state.songs, ...results],
          page: page,
          isLoading: false,
          // Playlist always returns all songs in one go
          hasMore: isPlaylist ? false : results.length >= exploreRemotePageSize,
          clearError: true,
          retryCount: 0,
        );
        return;
      } catch (e) {
        if (!mounted) return;
        if (attempt < _maxRetries) {
          // Exponential backoff: 1s, 2s, 4s
          state = state.copyWith(
            error: '加载失败，${attempt + 1}/$_maxRetries 次重试中...',
            retryCount: attempt + 1,
          );
          await Future.delayed(Duration(seconds: 1 << attempt));
          if (!mounted) return;
        } else {
          state = state.copyWith(
            isLoading: false,
            error: '加载失败: $e',
            retryCount: attempt + 1,
          );
        }
      }
    }
  }
}

// ── Providers ──

final exploreSearchModeProvider = StateProvider<ExploreSearchMode>(
  (ref) => ExploreSearchMode.remote,
);

final exploreSearchTypeProvider = StateProvider<ExploreSearchType>(
  (ref) => ExploreSearchType.song,
);

final exploreRemoteSourceProvider = StateProvider<String>((ref) => 'netease');

final exploreRemoteSearchProvider =
    StateNotifierProvider.autoDispose<
      ExploreRemoteSearchNotifier,
      ExploreRemoteState
    >((ref) => ExploreRemoteSearchNotifier(ref));
