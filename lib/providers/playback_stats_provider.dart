import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/album.dart';
import '../data/models/song.dart';
import '../data/repositories/audio_cache_repository.dart';
import '../data/sources/local_storage.dart';
import 'audio_cache_provider.dart';
import 'library_provider.dart';
import 'music_provider.dart';

const _topSongLimit = 10;
const _topArtistLimit = 10;
const _topAlbumLimit = 10;
const cacheProtectionThreshold = 5;

class SongPlayStat {
  const SongPlayStat({required this.song, required this.playCount});

  final Song song;
  final int playCount;
}

class ArtistPlayStat {
  const ArtistPlayStat({
    required this.artistName,
    required this.playCount,
    required this.songCount,
  });

  final String artistName;
  final int playCount;
  final int songCount;
}

class AlbumPlayStat {
  const AlbumPlayStat({
    required this.albumName,
    required this.playCount,
    required this.songCount,
    this.albumId,
    this.artistName,
    this.coverArtId,
  });

  final String albumName;
  final int playCount;
  final int songCount;
  final String? albumId;
  final String? artistName;
  final String? coverArtId;
}

class PlaybackStatsSummary {
  const PlaybackStatsSummary({
    required this.totalSongs,
    required this.totalAlbums,
    required this.totalArtists,
    required this.totalSongDurationSeconds,
    required this.totalPlayCount,
    required this.playedSongsCount,
    required this.estimatedPlayedDurationSeconds,
    required this.starredSongCount,
    required this.starredAlbumCount,
    required this.starredArtistCount,
    required this.cacheEntryCount,
    required this.cacheSongCount,
    required this.cacheTotalBytes,
    required this.cachePlayCount,
    required this.cacheProtectedEntryCount,
    required this.cacheSavedTrafficBytes,
    required this.topSongs,
    required this.topArtists,
    required this.topAlbums,
    required this.recentAlbums,
    required this.frequentAlbums,
  });

  final int totalSongs;
  final int totalAlbums;
  final int totalArtists;
  final int totalSongDurationSeconds;
  final int totalPlayCount;
  final int playedSongsCount;
  final int estimatedPlayedDurationSeconds;

  final int starredSongCount;
  final int starredAlbumCount;
  final int starredArtistCount;

  final int cacheEntryCount;
  final int cacheSongCount;
  final int cacheTotalBytes;
  final int cachePlayCount;
  final int cacheProtectedEntryCount;
  final int cacheSavedTrafficBytes;

  final List<SongPlayStat> topSongs;
  final List<ArtistPlayStat> topArtists;
  final List<AlbumPlayStat> topAlbums;

  final List<Album> recentAlbums;
  final List<Album> frequentAlbums;

  double get averagePlayCountPerSong {
    if (totalSongs <= 0) return 0;
    return totalPlayCount / totalSongs;
  }
}

class _ArtistAccumulator {
  _ArtistAccumulator(this.artistName);

  final String artistName;
  int playCount = 0;
  final Set<String> songIds = <String>{};
}

class _AlbumAccumulator {
  _AlbumAccumulator({
    required this.albumName,
    this.albumId,
    this.artistName,
    this.coverArtId,
  });

  final String albumName;
  final String? albumId;
  String? artistName;
  String? coverArtId;
  int playCount = 0;
  final Set<String> songIds = <String>{};
}

final playbackStatsProvider = FutureProvider.autoDispose<PlaybackStatsSummary>((
  ref,
) async {
  final songs = await ref.watch(allSongsProvider.future);
  final albums = await ref.watch(allAlbumsProvider.future);
  final artists = await ref.watch(allArtistsProvider.future);
  final starred = await ref.watch(starredProvider.future);
  final recentAlbums = await ref.watch(recentAlbumsProvider.future);
  final frequentAlbums = await ref.watch(frequentAlbumsProvider.future);

  final totalSongDurationSeconds = songs.fold<int>(
    0,
    (sum, song) => sum + (song.duration ?? 0),
  );
  final totalPlayCount = songs.fold<int>(
    0,
    (sum, song) => sum + (song.playCount ?? 0),
  );
  final playedSongsCount = songs
      .where((song) => (song.playCount ?? 0) > 0)
      .length;
  final estimatedPlayedDurationSeconds = songs.fold<int>(
    0,
    (sum, song) => sum + ((song.duration ?? 0) * (song.playCount ?? 0)),
  );

  final topSongs = _buildTopSongs(songs);
  final topArtists = _buildTopArtists(songs);
  final topAlbums = _buildTopAlbums(songs);

  final cacheStats = await _buildCacheStats(ref);

  return PlaybackStatsSummary(
    totalSongs: songs.length,
    totalAlbums: albums.length,
    totalArtists: artists.length,
    totalSongDurationSeconds: totalSongDurationSeconds,
    totalPlayCount: totalPlayCount,
    playedSongsCount: playedSongsCount,
    estimatedPlayedDurationSeconds: estimatedPlayedDurationSeconds,
    starredSongCount: starred.songs.length,
    starredAlbumCount: starred.albums.length,
    starredArtistCount: starred.artists.length,
    cacheEntryCount: cacheStats.entryCount,
    cacheSongCount: cacheStats.songCount,
    cacheTotalBytes: cacheStats.totalBytes,
    cachePlayCount: cacheStats.playCount,
    cacheProtectedEntryCount: cacheStats.protectedEntryCount,
    cacheSavedTrafficBytes: cacheStats.savedTrafficBytes,
    topSongs: topSongs,
    topArtists: topArtists,
    topAlbums: topAlbums,
    recentAlbums: recentAlbums,
    frequentAlbums: frequentAlbums,
  );
});

List<SongPlayStat> _buildTopSongs(List<Song> songs) {
  final ranked =
      songs
          .where((song) => (song.playCount ?? 0) > 0)
          .map(
            (song) => SongPlayStat(song: song, playCount: song.playCount ?? 0),
          )
          .toList()
        ..sort((a, b) {
          final byCount = b.playCount.compareTo(a.playCount);
          if (byCount != 0) return byCount;
          return a.song.title.toLowerCase().compareTo(
            b.song.title.toLowerCase(),
          );
        });
  return ranked.take(_topSongLimit).toList();
}

List<ArtistPlayStat> _buildTopArtists(List<Song> songs) {
  final byArtist = <String, _ArtistAccumulator>{};
  for (final song in songs) {
    final playCount = song.playCount ?? 0;
    if (playCount <= 0) continue;
    final artistName = _normalizeLabel(song.artist, fallback: 'Unknown Artist');
    final entry = byArtist.putIfAbsent(
      artistName,
      () => _ArtistAccumulator(artistName),
    );
    entry.playCount += playCount;
    entry.songIds.add(song.id);
  }

  final ranked =
      byArtist.values
          .map(
            (entry) => ArtistPlayStat(
              artistName: entry.artistName,
              playCount: entry.playCount,
              songCount: entry.songIds.length,
            ),
          )
          .toList()
        ..sort((a, b) {
          final byCount = b.playCount.compareTo(a.playCount);
          if (byCount != 0) return byCount;
          final bySongs = b.songCount.compareTo(a.songCount);
          if (bySongs != 0) return bySongs;
          return a.artistName.toLowerCase().compareTo(
            b.artistName.toLowerCase(),
          );
        });

  return ranked.take(_topArtistLimit).toList();
}

List<AlbumPlayStat> _buildTopAlbums(List<Song> songs) {
  final byAlbum = <String, _AlbumAccumulator>{};
  for (final song in songs) {
    final playCount = song.playCount ?? 0;
    if (playCount <= 0) continue;

    final albumName = _normalizeLabel(song.album, fallback: 'Unknown Album');
    final albumId = _normalizeOptional(song.albumId);
    final albumKey = albumId ?? 'name:${albumName.toLowerCase()}';

    final entry = byAlbum.putIfAbsent(
      albumKey,
      () => _AlbumAccumulator(
        albumName: albumName,
        albumId: albumId,
        artistName: _normalizeOptional(song.artist),
        coverArtId: _normalizeOptional(song.coverArt),
      ),
    );
    entry.playCount += playCount;
    entry.songIds.add(song.id);
    entry.artistName ??= _normalizeOptional(song.artist);
    entry.coverArtId ??= _normalizeOptional(song.coverArt);
  }

  final ranked =
      byAlbum.values
          .map(
            (entry) => AlbumPlayStat(
              albumName: entry.albumName,
              playCount: entry.playCount,
              songCount: entry.songIds.length,
              albumId: entry.albumId,
              artistName: entry.artistName,
              coverArtId: entry.coverArtId,
            ),
          )
          .toList()
        ..sort((a, b) {
          final byCount = b.playCount.compareTo(a.playCount);
          if (byCount != 0) return byCount;
          final bySongs = b.songCount.compareTo(a.songCount);
          if (bySongs != 0) return bySongs;
          return a.albumName.toLowerCase().compareTo(b.albumName.toLowerCase());
        });

  return ranked.take(_topAlbumLimit).toList();
}

class _CacheStats {
  const _CacheStats({
    required this.entryCount,
    required this.songCount,
    required this.totalBytes,
    required this.playCount,
    required this.protectedEntryCount,
    required this.savedTrafficBytes,
  });

  final int entryCount;
  final int songCount;
  final int totalBytes;
  final int playCount;
  final int protectedEntryCount;
  final int savedTrafficBytes;
}

Future<_CacheStats> _buildCacheStats(Ref ref) async {
  final activeLibraryId = ref.watch(activeLibraryProvider)?.id;
  final normalizedLibraryId = _normalizeOptional(activeLibraryId);
  final cacheRepository = ref.watch(audioCacheRepositoryProvider);
  final cacheService = ref.watch(audioCacheServiceProvider);
  final allEntries = await cacheRepository.getAllEntries();
  final scopedEntries = _scopeCacheEntries(allEntries, normalizedLibraryId);

  // Use disk-scanned size to match cache management page
  final totalBytes = await cacheService.getAudioCacheSize();
  final totalPlayCount = scopedEntries.fold<int>(
    0,
    (sum, entry) => sum + entry.playCount,
  );
  final savedTrafficBytes = normalizedLibraryId == null
      ? 0
      : await LocalStorage.getMobileCacheSavedBytes(
          libraryId: normalizedLibraryId,
        );
  final protectedEntryCount = scopedEntries
      .where((entry) => entry.playCount >= cacheProtectionThreshold)
      .length;
  final songCount = scopedEntries.map((entry) => entry.songId).toSet().length;

  return _CacheStats(
    entryCount: scopedEntries.length,
    songCount: songCount,
    totalBytes: totalBytes,
    playCount: totalPlayCount,
    protectedEntryCount: protectedEntryCount,
    savedTrafficBytes: savedTrafficBytes,
  );
}

List<AudioCacheEntry> _scopeCacheEntries(
  List<AudioCacheEntry> entries,
  String? activeLibraryId,
) {
  final libraryId = _normalizeOptional(activeLibraryId);
  if (libraryId == null) return entries;
  return entries.where((entry) => entry.libraryId == libraryId).toList();
}

String _normalizeLabel(String? value, {required String fallback}) {
  final normalized = _normalizeOptional(value);
  return normalized ?? fallback;
}

String? _normalizeOptional(String? value) {
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty) return null;
  return trimmed;
}
