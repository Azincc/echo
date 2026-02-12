import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/album.dart';
import '../data/models/artist.dart';
import '../data/models/song.dart';
import '../data/repositories/music_repository.dart';
import 'package:echoes/providers/library_provider.dart';

import 'api_provider.dart';

/// 音乐仓库 Provider
final musicRepositoryProvider = Provider<MusicRepository?>((ref) {
  final activeLib = ref.watch(activeLibraryProvider);
  if (activeLib == null) return null;
  final apiClient = ref.watch(subsonicApiClientProvider);
  return MusicRepository(apiClient);
});

/// 随机歌曲 Provider（保持数据，不自动释放）
final randomSongsProvider = FutureProvider<List<Song>>((ref) async {
  ref.watch(activeAddressProvider); // 线路变化时重新获取
  final repository = ref.watch(musicRepositoryProvider);
  if (repository == null) return [];
  return await repository.getRandomSongs(size: 20);
});

/// 最近播放专辑 Provider（保持数据，不自动释放）
final recentAlbumsProvider = FutureProvider<List<Album>>((ref) async {
  ref.watch(activeAddressProvider); // 线路变化时重新获取
  final repository = ref.watch(musicRepositoryProvider);
  if (repository == null) return [];
  return await repository.getAlbumList(type: 'recent', size: 10);
});

/// 常听专辑 Provider（保持数据，不自动释放）
final frequentAlbumsProvider = FutureProvider<List<Album>>((ref) async {
  ref.watch(activeAddressProvider); // 线路变化时重新获取
  final repository = ref.watch(musicRepositoryProvider);
  if (repository == null) return [];
  return await repository.getAlbumList(type: 'frequent', size: 10);
});

/// 最新专辑 Provider
final newestAlbumsProvider = FutureProvider.autoDispose<List<Album>>((
  ref,
) async {
  final repository = ref.watch(musicRepositoryProvider);
  if (repository == null) return [];
  return await repository.getAlbumList(type: 'newest', size: 20);
});

/// 所有专辑 Provider（按字母排序）
final allAlbumsProvider = FutureProvider.autoDispose<List<Album>>((ref) async {
  final repository = ref.watch(musicRepositoryProvider);
  if (repository == null) return [];
  return await repository.getAlbumList(type: 'alphabeticalByName', size: 2000);
});

/// 专辑详情 Provider
final albumDetailProvider = FutureProvider.autoDispose
    .family<AlbumDetail?, String>((ref, albumId) async {
      final repository = ref.watch(musicRepositoryProvider);
      if (repository == null) return null;
      return await repository.getAlbum(albumId);
    });

/// 所有歌曲 Provider
final allSongsProvider = FutureProvider.autoDispose<List<Song>>((ref) async {
  final repository = ref.watch(musicRepositoryProvider);
  if (repository == null) return [];
  return await repository.getAllSongs();
});

/// 所有歌手 Provider
final allArtistsProvider = FutureProvider.autoDispose<List<Artist>>((
  ref,
) async {
  final repository = ref.watch(musicRepositoryProvider);
  if (repository == null) return [];
  return await repository.getArtists();
});

/// 歌手详情 Provider
final artistDetailProvider = FutureProvider.autoDispose
    .family<ArtistDetail?, String>((ref, artistId) async {
      final repository = ref.watch(musicRepositoryProvider);
      if (repository == null) return null;
      return await repository.getArtist(artistId);
    });

/// 搜索 Provider
final searchProvider = FutureProvider.autoDispose.family<SearchResult, String>((
  ref,
  query,
) async {
  final repository = ref.watch(musicRepositoryProvider);
  if (query.isEmpty || repository == null) {
    return SearchResult(artists: [], albums: [], songs: []);
  }
  return await repository.search(
    query: query,
    artistCount: 10,
    albumCount: 20,
    songCount: 30,
  );
});

/// 收藏列表 Provider
final starredProvider = FutureProvider.autoDispose<StarredResult>((ref) async {
  final repository = ref.watch(musicRepositoryProvider);
  if (repository == null)
    return StarredResult(artists: [], albums: [], songs: []);
  return await repository.getStarred();
});
