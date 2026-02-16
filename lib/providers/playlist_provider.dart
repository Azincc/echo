import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/utils/logger.dart';
import '../core/utils/network_error_notifier.dart';
import '../data/models/playlist.dart';
import '../data/repositories/playlist_repository.dart';

import 'package:echoes/providers/library_provider.dart';

import 'api_provider.dart';
import 'metadata_cache_provider.dart';

const _playlistLogTag = 'PLAYLIST';

/// 歌单仓库 Provider
final playlistRepositoryProvider = Provider<PlaylistRepository?>((ref) {
  final activeLib = ref.watch(activeLibraryProvider);
  if (activeLib == null) return null;
  final apiClient = ref.watch(subsonicApiClientProvider);
  return PlaylistRepository(apiClient);
});

final playlistsLoadFailedProvider = StateProvider<bool>((ref) => false);
final playlistDetailLoadFailedProvider = StateProvider.family<bool, String>(
  (ref, playlistId) => false,
);

/// 所有歌单 Provider
final playlistsProvider = FutureProvider.autoDispose<List<Playlist>>((
  ref,
) async {
  final repository = ref.watch(playlistRepositoryProvider);
  final cache = ref.watch(metadataCacheRepositoryProvider);
  final libraryId = ref.watch(activeLibraryProvider)?.id;
  if (repository == null || libraryId == null || libraryId.isEmpty) {
    Logger.warnWithTag(
      _playlistLogTag,
      'playlists skipped: repository or library unavailable',
    );
    return [];
  }
  try {
    await ref.watch(ensureActiveAddressProvider.future);
    final playlists = await repository.getPlaylists();
    await cache.cachePlaylists(libraryId, playlists);
    ref.read(playlistsLoadFailedProvider.notifier).state = false;
    Logger.infoWithTag(
      _playlistLogTag,
      'playlists loaded from remote, count=${playlists.length}',
    );
    return playlists;
  } catch (e, stackTrace) {
    Logger.warnWithTag(_playlistLogTag, 'playlists remote load failed', e);
    Logger.debugWithTag(
      _playlistLogTag,
      'playlists fallback stackTrace',
      null,
      stackTrace,
    );
    NetworkErrorNotifier.show('网络异常，歌单加载失败');
    final cached = await cache.getPlaylists(libraryId);
    if (cached != null) {
      ref.read(playlistsLoadFailedProvider.notifier).state = false;
      Logger.infoWithTag(
        _playlistLogTag,
        'playlists fallback to cache, count=${cached.length}',
      );
      return cached;
    }
    ref.read(playlistsLoadFailedProvider.notifier).state = true;
    Logger.warnWithTag(_playlistLogTag, 'playlists cache miss');
    return [];
  }
});

/// 歌单详情 Provider
final playlistDetailProvider = FutureProvider.autoDispose
    .family<Playlist?, String>((ref, playlistId) async {
      final repository = ref.watch(playlistRepositoryProvider);
      final cache = ref.watch(metadataCacheRepositoryProvider);
      final libraryId = ref.watch(activeLibraryProvider)?.id;
      if (repository == null || libraryId == null || libraryId.isEmpty) {
        Logger.warnWithTag(
          _playlistLogTag,
          'playlistDetail skipped: repository or library unavailable',
        );
        return null;
      }
      try {
        await ref.watch(ensureActiveAddressProvider.future);
        final playlist = await repository.getPlaylist(playlistId);
        if (playlist != null) {
          await cache.cachePlaylistDetail(libraryId, playlist);
          ref
                  .read(playlistDetailLoadFailedProvider(playlistId).notifier)
                  .state =
              false;
          Logger.infoWithTag(
            _playlistLogTag,
            'playlistDetail loaded from remote: playlistId=$playlistId songs=${playlist.songs?.length ?? playlist.songCount}',
          );
        } else {
          Logger.warnWithTag(
            _playlistLogTag,
            'playlistDetail remote returned null: playlistId=$playlistId',
          );
        }
        return playlist;
      } catch (e, stackTrace) {
        Logger.warnWithTag(
          _playlistLogTag,
          'playlistDetail remote load failed: playlistId=$playlistId',
          e,
        );
        Logger.debugWithTag(
          _playlistLogTag,
          'playlistDetail fallback stackTrace: playlistId=$playlistId',
          null,
          stackTrace,
        );
        NetworkErrorNotifier.show('网络异常，歌单加载失败');
        final cached = await cache.getPlaylistDetail(libraryId, playlistId);
        if (cached != null) {
          ref
                  .read(playlistDetailLoadFailedProvider(playlistId).notifier)
                  .state =
              false;
          Logger.infoWithTag(
            _playlistLogTag,
            'playlistDetail fallback to cache: playlistId=$playlistId songs=${cached.songs?.length ?? cached.songCount}',
          );
          return cached;
        }
        ref.read(playlistDetailLoadFailedProvider(playlistId).notifier).state =
            true;
        Logger.warnWithTag(
          _playlistLogTag,
          'playlistDetail cache miss: playlistId=$playlistId',
        );
        return null;
      }
    });
