import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/album.dart';
import '../data/models/artist.dart';
import '../data/models/song.dart';
import '../data/repositories/music_repository.dart';
import '../core/utils/network_error_notifier.dart';
import '../core/utils/logger.dart';
import 'package:echoes/providers/library_provider.dart';

import 'api_provider.dart';
import 'metadata_cache_provider.dart';

const _musicLogTag = 'MUSIC';

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
final newestAlbumsLoadFailedProvider = StateProvider<bool>((ref) => false);
final allArtistsLoadFailedProvider = StateProvider<bool>((ref) => false);
final artistDetailLoadFailedProvider = StateProvider.family<bool, String>(
  (ref, artistId) => false,
);
final starredLoadFailedProvider = StateProvider<bool>((ref) => false);

// ---------------------------------------------------------------------------
// 通用辅助：远程获取 + 缓存回退
// ---------------------------------------------------------------------------

/// 通用的远程获取 + 缓存回退逻辑。
///
/// [label] 用于日志标识。
/// [fetch] 执行远程 API 调用。
/// [cacheWrite] 将远程结果写入缓存。
/// [cacheRead] 在远程失败时从缓存读取。
/// [failedNotifier] 用于更新加载失败状态的 StateProvider notifier。
/// [errorMessage] 网络异常时的用户提示。
/// [emptyValue] 远程和缓存都不可用时的默认空值。
Future<T> _fetchWithCacheFallback<T>({
  required Ref ref,
  required String label,
  required Future<T> Function() fetch,
  required Future<void> Function(T data) cacheWrite,
  required Future<T?> Function() cacheRead,
  required StateProvider<bool> failedProvider,
  required String errorMessage,
  required T emptyValue,
}) async {
  try {
    await ref.read(ensureActiveAddressProvider.future);
    final data = await fetch();
    await cacheWrite(data);
    ref.read(failedProvider.notifier).state = false;
    Logger.infoWithTag(_musicLogTag, '$label loaded from remote');
    return data;
  } catch (e, stackTrace) {
    Logger.warnWithTag(_musicLogTag, '$label remote load failed', e);
    Logger.debugWithTag(
      _musicLogTag,
      '$label fallback stackTrace',
      null,
      stackTrace,
    );
    NetworkErrorNotifier.show(errorMessage);
    final cached = await cacheRead();
    if (cached != null) {
      ref.read(failedProvider.notifier).state = false;
      Logger.infoWithTag(_musicLogTag, '$label fallback to cache');
      return cached;
    }
    ref.read(failedProvider.notifier).state = true;
    Logger.warnWithTag(_musicLogTag, '$label cache miss');
    return emptyValue;
  }
}

// ---------------------------------------------------------------------------
// Provider 定义
// ---------------------------------------------------------------------------

/// 随机歌曲 Provider（保持数据，不自动释放）
final randomSongsProvider = FutureProvider<List<Song>>((ref) async {
  final repository = ref.watch(musicRepositoryProvider);
  final cache = ref.watch(metadataCacheRepositoryProvider);
  final libraryId = ref.watch(activeLibraryProvider)?.id;
  if (repository == null || libraryId == null || libraryId.isEmpty) return [];

  return _fetchWithCacheFallback(
    ref: ref,
    label: 'randomSongs',
    fetch: () => repository.getRandomSongs(size: 20),
    cacheWrite: (songs) => cache.cacheRandomSongs(libraryId, songs),
    cacheRead: () => cache.getRandomSongs(libraryId),
    failedProvider: randomSongsLoadFailedProvider,
    errorMessage: '网络异常',
    emptyValue: [],
  );
});

/// 最近播放专辑 Provider（保持数据，不自动释放）
final recentAlbumsProvider = FutureProvider<List<Album>>((ref) async {
  final repository = ref.watch(musicRepositoryProvider);
  final cache = ref.watch(metadataCacheRepositoryProvider);
  final libraryId = ref.watch(activeLibraryProvider)?.id;
  if (repository == null || libraryId == null || libraryId.isEmpty) return [];

  return _fetchWithCacheFallback(
    ref: ref,
    label: 'recentAlbums',
    fetch: () => repository.getAlbumList(type: 'recent', size: 10),
    cacheWrite: (albums) => cache.cacheRecentAlbums(libraryId, albums),
    cacheRead: () => cache.getRecentAlbums(libraryId),
    failedProvider: recentAlbumsLoadFailedProvider,
    errorMessage: '网络异常',
    emptyValue: [],
  );
});

/// 常听专辑 Provider（保持数据，不自动释放）
final frequentAlbumsProvider = FutureProvider<List<Album>>((ref) async {
  final repository = ref.watch(musicRepositoryProvider);
  final cache = ref.watch(metadataCacheRepositoryProvider);
  final libraryId = ref.watch(activeLibraryProvider)?.id;
  if (repository == null || libraryId == null || libraryId.isEmpty) return [];

  return _fetchWithCacheFallback(
    ref: ref,
    label: 'frequentAlbums',
    fetch: () => repository.getAlbumList(type: 'frequent', size: 10),
    cacheWrite: (albums) => cache.cacheFrequentAlbums(libraryId, albums),
    cacheRead: () => cache.getFrequentAlbums(libraryId),
    failedProvider: frequentAlbumsLoadFailedProvider,
    errorMessage: '网络异常',
    emptyValue: [],
  );
});

/// 最新专辑 Provider（保持数据，不自动释放）
final newestAlbumsProvider = FutureProvider<List<Album>>((ref) async {
  final repository = ref.watch(musicRepositoryProvider);
  final cache = ref.watch(metadataCacheRepositoryProvider);
  final libraryId = ref.watch(activeLibraryProvider)?.id;
  if (repository == null || libraryId == null || libraryId.isEmpty) return [];

  return _fetchWithCacheFallback(
    ref: ref,
    label: 'newestAlbums',
    fetch: () => repository.getAlbumList(type: 'newest', size: 20),
    cacheWrite: (albums) => cache.cacheNewestAlbums(libraryId, albums),
    cacheRead: () => cache.getNewestAlbums(libraryId),
    failedProvider: newestAlbumsLoadFailedProvider,
    errorMessage: '网络异常',
    emptyValue: [],
  );
});

/// 所有专辑 Provider（按字母排序）
final allAlbumsProvider = FutureProvider.autoDispose<List<Album>>((ref) async {
  final repository = ref.watch(musicRepositoryProvider);
  final cache = ref.watch(metadataCacheRepositoryProvider);
  final libraryId = ref.watch(activeLibraryProvider)?.id;
  if (repository == null || libraryId == null || libraryId.isEmpty) return [];

  return _fetchWithCacheFallback(
    ref: ref,
    label: 'allAlbums',
    fetch: () =>
        repository.getAlbumList(type: 'alphabeticalByName', size: 2000),
    cacheWrite: (albums) => cache.cacheAllAlbums(libraryId, albums),
    cacheRead: () => cache.getAllAlbums(libraryId),
    failedProvider: allAlbumsLoadFailedProvider,
    errorMessage: '网络异常，专辑加载失败',
    emptyValue: [],
  );
});

/// 专辑详情 Provider
final albumDetailProvider = FutureProvider.autoDispose
    .family<AlbumDetail?, String>((ref, albumId) async {
      final repository = ref.watch(musicRepositoryProvider);
      final cache = ref.watch(metadataCacheRepositoryProvider);
      final libraryId = ref.watch(activeLibraryProvider)?.id;
      if (repository == null || libraryId == null || libraryId.isEmpty)
        return null;

      return _fetchWithCacheFallback<AlbumDetail?>(
        ref: ref,
        label: 'albumDetail($albumId)',
        fetch: () => repository.getAlbum(albumId),
        cacheWrite: (detail) async {
          if (detail != null) await cache.cacheAlbumDetail(libraryId, detail);
        },
        cacheRead: () => cache.getAlbumDetail(libraryId, albumId),
        failedProvider: albumDetailLoadFailedProvider(albumId),
        errorMessage: '网络异常，专辑加载失败',
        emptyValue: null,
      );
    });

/// 所有歌曲 Provider
final allSongsProvider = FutureProvider.autoDispose<List<Song>>((ref) async {
  final repository = ref.watch(musicRepositoryProvider);
  final cache = ref.watch(metadataCacheRepositoryProvider);
  final libraryId = ref.watch(activeLibraryProvider)?.id;
  if (repository == null || libraryId == null || libraryId.isEmpty) return [];

  return _fetchWithCacheFallback(
    ref: ref,
    label: 'allSongs',
    fetch: () => repository.getAllSongs(),
    cacheWrite: (songs) => cache.cacheAllSongs(libraryId, songs),
    cacheRead: () => cache.getAllSongs(libraryId),
    failedProvider: allSongsLoadFailedProvider,
    errorMessage: '网络异常，歌曲加载失败',
    emptyValue: [],
  );
});

/// 所有歌手 Provider
final allArtistsProvider = FutureProvider.autoDispose<List<Artist>>((
  ref,
) async {
  final repository = ref.watch(musicRepositoryProvider);
  final cache = ref.watch(metadataCacheRepositoryProvider);
  final libraryId = ref.watch(activeLibraryProvider)?.id;
  if (repository == null || libraryId == null || libraryId.isEmpty) return [];

  return _fetchWithCacheFallback(
    ref: ref,
    label: 'allArtists',
    fetch: () => repository.getArtists(),
    cacheWrite: (artists) => cache.cacheAllArtists(libraryId, artists),
    cacheRead: () => cache.getAllArtists(libraryId),
    failedProvider: allArtistsLoadFailedProvider,
    errorMessage: '网络异常，歌手列表加载失败',
    emptyValue: [],
  );
});

/// 歌手详情 Provider
final artistDetailProvider = FutureProvider.autoDispose
    .family<ArtistDetail?, String>((ref, artistId) async {
      final repository = ref.watch(musicRepositoryProvider);
      final cache = ref.watch(metadataCacheRepositoryProvider);
      final libraryId = ref.watch(activeLibraryProvider)?.id;
      if (repository == null || libraryId == null || libraryId.isEmpty)
        return null;

      return _fetchWithCacheFallback<ArtistDetail?>(
        ref: ref,
        label: 'artistDetail($artistId)',
        fetch: () => repository.getArtist(artistId),
        cacheWrite: (detail) async {
          if (detail != null) {
            await cache.cacheArtistDetail(
              libraryId,
              detail.artist,
              detail.albums,
            );
          }
        },
        cacheRead: () async {
          final cached = await cache.getArtistDetail(libraryId, artistId);
          if (cached == null) return null;
          return ArtistDetail(artist: cached.artist, albums: cached.albums);
        },
        failedProvider: artistDetailLoadFailedProvider(artistId),
        errorMessage: '网络异常，歌手详情加载失败',
        emptyValue: null,
      );
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
  try {
    await ref.read(ensureActiveAddressProvider.future);
    return await repository.search(
      query: query,
      artistCount: 10,
      albumCount: 20,
      songCount: 30,
    );
  } catch (e) {
    Logger.warnWithTag(_musicLogTag, 'search failed: query=$query', e);
    NetworkErrorNotifier.show('网络异常，搜索失败');
    return SearchResult(artists: [], albums: [], songs: []);
  }
});

/// 收藏列表 Provider
final starredProvider = FutureProvider.autoDispose<StarredResult>((ref) async {
  final repository = ref.watch(musicRepositoryProvider);
  final cache = ref.watch(metadataCacheRepositoryProvider);
  final libraryId = ref.watch(activeLibraryProvider)?.id;
  if (repository == null || libraryId == null || libraryId.isEmpty) {
    return StarredResult(artists: [], albums: [], songs: []);
  }

  return _fetchWithCacheFallback<StarredResult>(
    ref: ref,
    label: 'starred',
    fetch: () => repository.getStarred(),
    cacheWrite: (result) => cache.cacheStarred(
      libraryId,
      artists: result.artists,
      albums: result.albums,
      songs: result.songs,
    ),
    cacheRead: () async {
      final cached = await cache.getStarred(libraryId);
      if (cached == null) return null;
      return StarredResult(
        artists: cached.artists,
        albums: cached.albums,
        songs: cached.songs,
      );
    },
    failedProvider: starredLoadFailedProvider,
    errorMessage: '网络异常，收藏加载失败',
    emptyValue: StarredResult(artists: [], albums: [], songs: []),
  );
});
