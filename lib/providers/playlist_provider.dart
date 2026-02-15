import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/utils/network_error_notifier.dart';
import '../data/models/playlist.dart';
import '../data/repositories/playlist_repository.dart';

import 'package:echoes/providers/library_provider.dart';

import 'api_provider.dart';
import 'metadata_cache_provider.dart';

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
  if (repository == null || libraryId == null || libraryId.isEmpty) return [];
  try {
    await ref.watch(ensureActiveAddressProvider.future);
    final playlists = await repository.getPlaylists();
    await cache.cachePlaylists(libraryId, playlists);
    ref.read(playlistsLoadFailedProvider.notifier).state = false;
    return playlists;
  } catch (_) {
    NetworkErrorNotifier.show('网络异常，歌单加载失败');
    final cached = await cache.getPlaylists(libraryId);
    if (cached != null) {
      ref.read(playlistsLoadFailedProvider.notifier).state = false;
      return cached;
    }
    ref.read(playlistsLoadFailedProvider.notifier).state = true;
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
        }
        return playlist;
      } catch (_) {
        NetworkErrorNotifier.show('网络异常，歌单加载失败');
        final cached = await cache.getPlaylistDetail(libraryId, playlistId);
        if (cached != null) {
          ref
                  .read(playlistDetailLoadFailedProvider(playlistId).notifier)
                  .state =
              false;
          return cached;
        }
        ref.read(playlistDetailLoadFailedProvider(playlistId).notifier).state =
            true;
        return null;
      }
    });
