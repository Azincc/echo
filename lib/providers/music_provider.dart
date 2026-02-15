import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/album.dart';
import '../data/models/artist.dart';
import '../data/models/song.dart';
import '../data/repositories/music_repository.dart';
import '../core/utils/network_error_notifier.dart';
import 'package:echoes/providers/library_provider.dart';

import 'api_provider.dart';
import 'metadata_cache_provider.dart';

/// 音乐仓库 Provider
final musicRepositoryProvider = Provider<MusicRepository?>((ref) {
  final activeLib = ref.watch(activeLibraryProvider);
  if (activeLib == null) return null;
  final apiClient = ref.watch(subsonicApiClientProvider);
  return MusicRepository(apiClient);
});

final randomSongsLoadFailedProvider = StateProvider<bool>((ref) => false);
final recentAlbumsLoadFailedProvider = StateProvider<bool>((ref) => false);
final frequentAlbumsLoadFailedProvider = StateProvider<bool>((ref) => false);
final allSongsLoadFailedProvider = StateProvider<bool>((ref) => false);
final allAlbumsLoadFailedProvider = StateProvider<bool>((ref) => false);
final albumDetailLoadFailedProvider = StateProvider.family<bool, String>(
  (ref, albumId) => false,
);

/// 随机歌曲 Provider（保持数据，不自动释放）
final randomSongsProvider = FutureProvider<List<Song>>((ref) async {
  final repository = ref.watch(musicRepositoryProvider);
  final cache = ref.watch(metadataCacheRepositoryProvider);
  final libraryId = ref.watch(activeLibraryProvider)?.id;
  if (repository == null || libraryId == null || libraryId.isEmpty) return [];

  try {
    await ref.watch(ensureActiveAddressProvider.future);
    final songs = await repository.getRandomSongs(size: 20);
    await cache.cacheRandomSongs(libraryId, songs);
    ref.read(randomSongsLoadFailedProvider.notifier).state = false;
    return songs;
  } catch (_) {
    NetworkErrorNotifier.show('网络异常');
    final cached = await cache.getRandomSongs(libraryId);
    if (cached != null) {
      ref.read(randomSongsLoadFailedProvider.notifier).state = false;
      return cached;
    }
    ref.read(randomSongsLoadFailedProvider.notifier).state = true;
    return [];
  }
});

/// 最近播放专辑 Provider（保持数据，不自动释放）
final recentAlbumsProvider = FutureProvider<List<Album>>((ref) async {
  final repository = ref.watch(musicRepositoryProvider);
  final cache = ref.watch(metadataCacheRepositoryProvider);
  final libraryId = ref.watch(activeLibraryProvider)?.id;
  if (repository == null || libraryId == null || libraryId.isEmpty) return [];

  try {
    await ref.watch(ensureActiveAddressProvider.future);
    final albums = await repository.getAlbumList(type: 'recent', size: 10);
    await cache.cacheRecentAlbums(libraryId, albums);
    ref.read(recentAlbumsLoadFailedProvider.notifier).state = false;
    return albums;
  } catch (_) {
    NetworkErrorNotifier.show('网络异常');
    final cached = await cache.getRecentAlbums(libraryId);
    if (cached != null) {
      ref.read(recentAlbumsLoadFailedProvider.notifier).state = false;
      return cached;
    }
    ref.read(recentAlbumsLoadFailedProvider.notifier).state = true;
    return [];
  }
});

/// 常听专辑 Provider（保持数据，不自动释放）
final frequentAlbumsProvider = FutureProvider<List<Album>>((ref) async {
  final repository = ref.watch(musicRepositoryProvider);
  final cache = ref.watch(metadataCacheRepositoryProvider);
  final libraryId = ref.watch(activeLibraryProvider)?.id;
  if (repository == null || libraryId == null || libraryId.isEmpty) return [];

  try {
    await ref.watch(ensureActiveAddressProvider.future);
    final albums = await repository.getAlbumList(type: 'frequent', size: 10);
    await cache.cacheFrequentAlbums(libraryId, albums);
    ref.read(frequentAlbumsLoadFailedProvider.notifier).state = false;
    return albums;
  } catch (_) {
    NetworkErrorNotifier.show('网络异常');
    final cached = await cache.getFrequentAlbums(libraryId);
    if (cached != null) {
      ref.read(frequentAlbumsLoadFailedProvider.notifier).state = false;
      return cached;
    }
    ref.read(frequentAlbumsLoadFailedProvider.notifier).state = true;
    return [];
  }
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
  final cache = ref.watch(metadataCacheRepositoryProvider);
  final libraryId = ref.watch(activeLibraryProvider)?.id;
  if (repository == null || libraryId == null || libraryId.isEmpty) return [];

  try {
    await ref.watch(ensureActiveAddressProvider.future);
    final albums = await repository.getAlbumList(
      type: 'alphabeticalByName',
      size: 2000,
    );
    await cache.cacheAllAlbums(libraryId, albums);
    ref.read(allAlbumsLoadFailedProvider.notifier).state = false;
    return albums;
  } catch (_) {
    NetworkErrorNotifier.show('网络异常，专辑加载失败');
    final cached = await cache.getAllAlbums(libraryId);
    if (cached != null) {
      ref.read(allAlbumsLoadFailedProvider.notifier).state = false;
      return cached;
    }
    ref.read(allAlbumsLoadFailedProvider.notifier).state = true;
    return [];
  }
});

/// 专辑详情 Provider
final albumDetailProvider = FutureProvider.autoDispose
    .family<AlbumDetail?, String>((ref, albumId) async {
      final repository = ref.watch(musicRepositoryProvider);
      final cache = ref.watch(metadataCacheRepositoryProvider);
      final libraryId = ref.watch(activeLibraryProvider)?.id;
      if (repository == null || libraryId == null || libraryId.isEmpty) {
        return null;
      }
      try {
        await ref.watch(ensureActiveAddressProvider.future);
        final detail = await repository.getAlbum(albumId);
        if (detail != null) {
          await cache.cacheAlbumDetail(libraryId, detail);
          ref.read(albumDetailLoadFailedProvider(albumId).notifier).state =
              false;
        }
        return detail;
      } catch (_) {
        NetworkErrorNotifier.show('网络异常，专辑加载失败');
        final cached = await cache.getAlbumDetail(libraryId, albumId);
        if (cached != null) {
          ref.read(albumDetailLoadFailedProvider(albumId).notifier).state =
              false;
          return cached;
        }
        ref.read(albumDetailLoadFailedProvider(albumId).notifier).state = true;
        return null;
      }
    });

/// 所有歌曲 Provider
final allSongsProvider = FutureProvider.autoDispose<List<Song>>((ref) async {
  final repository = ref.watch(musicRepositoryProvider);
  final cache = ref.watch(metadataCacheRepositoryProvider);
  final libraryId = ref.watch(activeLibraryProvider)?.id;
  if (repository == null || libraryId == null || libraryId.isEmpty) return [];

  try {
    await ref.watch(ensureActiveAddressProvider.future);
    final songs = await repository.getAllSongs();
    await cache.cacheAllSongs(libraryId, songs);
    ref.read(allSongsLoadFailedProvider.notifier).state = false;
    return songs;
  } catch (_) {
    NetworkErrorNotifier.show('网络异常，歌曲加载失败');
    final cached = await cache.getAllSongs(libraryId);
    if (cached != null) {
      ref.read(allSongsLoadFailedProvider.notifier).state = false;
      return cached;
    }
    ref.read(allSongsLoadFailedProvider.notifier).state = true;
    return [];
  }
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
  if (repository == null) {
    return StarredResult(artists: [], albums: [], songs: []);
  }
  return await repository.getStarred();
});
