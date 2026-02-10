import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/playlist.dart';
import '../data/repositories/playlist_repository.dart';
import 'auth_provider.dart';

/// 歌单仓库 Provider
final playlistRepositoryProvider = Provider<PlaylistRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return PlaylistRepository(apiClient);
});

/// 所有歌单 Provider
final playlistsProvider = FutureProvider.autoDispose<List<Playlist>>((ref) async {
  final repository = ref.watch(playlistRepositoryProvider);
  return await repository.getPlaylists();
});

/// 歌单详情 Provider
final playlistDetailProvider = FutureProvider.autoDispose.family<Playlist?, String>(
  (ref, playlistId) async {
    final repository = ref.watch(playlistRepositoryProvider);
    return await repository.getPlaylist(playlistId);
  },
);
