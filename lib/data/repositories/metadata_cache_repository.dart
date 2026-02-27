import 'dart:convert';

import 'package:echoes/core/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/album.dart';
import '../models/artist.dart';
import '../models/playlist.dart';
import '../models/song.dart';
import 'music_repository.dart';

/// 元数据缓存仓库（基于 SharedPreferences）
class MetadataCacheRepository {
  static const _tag = 'META_CACHE';
  static const String _prefix = 'metadata_cache_v1';

  String _key(String libraryId, String scope) =>
      '${_prefix}_${libraryId}_$scope';

  Future<void> _saveMap(
    String libraryId,
    String scope,
    Map<String, dynamic> value,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key(libraryId, scope), jsonEncode(value));
    Logger.debugWithTag(_tag, 'cache saved libraryId=$libraryId scope=$scope');
  }

  Future<Map<String, dynamic>?> _readMap(String libraryId, String scope) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key(libraryId, scope));
    if (raw == null || raw.isEmpty) {
      Logger.debugWithTag(_tag, 'cache miss libraryId=$libraryId scope=$scope');
      return null;
    }
    try {
      Logger.debugWithTag(_tag, 'cache hit libraryId=$libraryId scope=$scope');
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (e) {
      Logger.warnWithTag(
        _tag,
        'cache parse failed libraryId=$libraryId scope=$scope',
        e,
      );
      return null;
    }
  }

  Future<void> cacheRandomSongs(String libraryId, List<Song> songs) async {
    await _saveMap(libraryId, 'home_random_songs', {
      'songs': songs.map((e) => e.toJson()).toList(),
      'cachedAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<List<Song>?> getRandomSongs(String libraryId) async {
    final map = await _readMap(libraryId, 'home_random_songs');
    if (map == null) return null;
    final list = map['songs'] as List?;
    if (list == null) return null;
    return list.map((e) => Song.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> cacheRecentAlbums(String libraryId, List<Album> albums) async {
    await _saveMap(libraryId, 'home_recent_albums', {
      'albums': albums.map((e) => e.toJson()).toList(),
      'cachedAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<List<Album>?> getRecentAlbums(String libraryId) async {
    final map = await _readMap(libraryId, 'home_recent_albums');
    if (map == null) return null;
    final list = map['albums'] as List?;
    if (list == null) return null;
    return list.map((e) => Album.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> cacheFrequentAlbums(String libraryId, List<Album> albums) async {
    await _saveMap(libraryId, 'home_frequent_albums', {
      'albums': albums.map((e) => e.toJson()).toList(),
      'cachedAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<List<Album>?> getFrequentAlbums(String libraryId) async {
    final map = await _readMap(libraryId, 'home_frequent_albums');
    if (map == null) return null;
    final list = map['albums'] as List?;
    if (list == null) return null;
    return list.map((e) => Album.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> cacheAllSongs(String libraryId, List<Song> songs) async {
    await _saveMap(libraryId, 'all_songs', {
      'songs': songs.map((e) => e.toJson()).toList(),
      'cachedAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<List<Song>?> getAllSongs(String libraryId) async {
    final map = await _readMap(libraryId, 'all_songs');
    if (map == null) return null;
    final list = map['songs'] as List?;
    if (list == null) return null;
    return list.map((e) => Song.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> cacheAllAlbums(String libraryId, List<Album> albums) async {
    await _saveMap(libraryId, 'all_albums', {
      'albums': albums.map((e) => e.toJson()).toList(),
      'cachedAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<List<Album>?> getAllAlbums(String libraryId) async {
    final map = await _readMap(libraryId, 'all_albums');
    if (map == null) return null;
    final list = map['albums'] as List?;
    if (list == null) return null;
    return list.map((e) => Album.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> cacheAlbumDetail(String libraryId, AlbumDetail detail) async {
    await _saveMap(libraryId, 'album_detail_${detail.album.id}', {
      'album': detail.album.toJson(),
      'songs': detail.songs.map((e) => e.toJson()).toList(),
      'cachedAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<AlbumDetail?> getAlbumDetail(String libraryId, String albumId) async {
    final map = await _readMap(libraryId, 'album_detail_$albumId');
    if (map == null) return null;
    final albumMap = map['album'] as Map<String, dynamic>?;
    final songsList = map['songs'] as List?;
    if (albumMap == null || songsList == null) return null;
    return AlbumDetail(
      album: Album.fromJson(albumMap),
      songs: songsList
          .map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<void> cachePlaylists(
    String libraryId,
    List<Playlist> playlists,
  ) async {
    await _saveMap(libraryId, 'playlists', {
      'playlists': playlists.map((e) => e.toJson()).toList(),
      'cachedAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<List<Playlist>?> getPlaylists(String libraryId) async {
    final map = await _readMap(libraryId, 'playlists');
    if (map == null) return null;
    final list = map['playlists'] as List?;
    if (list == null) return null;
    return list
        .map((e) => Playlist.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> cachePlaylistDetail(String libraryId, Playlist playlist) async {
    await _saveMap(libraryId, 'playlist_detail_${playlist.id}', {
      'playlist': playlist.toJson(),
      'cachedAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<Playlist?> getPlaylistDetail(
    String libraryId,
    String playlistId,
  ) async {
    final map = await _readMap(libraryId, 'playlist_detail_$playlistId');
    if (map == null) return null;
    final playlistMap = map['playlist'] as Map<String, dynamic>?;
    if (playlistMap == null) return null;
    return Playlist.fromJson(playlistMap);
  }

  // -------------------------------------------------------------------------
  // Newest Albums
  // -------------------------------------------------------------------------

  Future<void> cacheNewestAlbums(String libraryId, List<Album> albums) async {
    await _saveMap(libraryId, 'newest_albums', {
      'albums': albums.map((e) => e.toJson()).toList(),
      'cachedAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<List<Album>?> getNewestAlbums(String libraryId) async {
    final map = await _readMap(libraryId, 'newest_albums');
    if (map == null) return null;
    final list = map['albums'] as List?;
    if (list == null) return null;
    return list.map((e) => Album.fromJson(e as Map<String, dynamic>)).toList();
  }

  // -------------------------------------------------------------------------
  // All Artists
  // -------------------------------------------------------------------------

  Future<void> cacheAllArtists(String libraryId, List<Artist> artists) async {
    await _saveMap(libraryId, 'all_artists', {
      'artists': artists.map((e) => e.toJson()).toList(),
      'cachedAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<List<Artist>?> getAllArtists(String libraryId) async {
    final map = await _readMap(libraryId, 'all_artists');
    if (map == null) return null;
    final list = map['artists'] as List?;
    if (list == null) return null;
    return list.map((e) => Artist.fromJson(e as Map<String, dynamic>)).toList();
  }

  // -------------------------------------------------------------------------
  // Artist Detail
  // -------------------------------------------------------------------------

  Future<void> cacheArtistDetail(
    String libraryId,
    Artist artist,
    List<Album> albums,
  ) async {
    await _saveMap(libraryId, 'artist_detail_${artist.id}', {
      'artist': artist.toJson(),
      'albums': albums.map((e) => e.toJson()).toList(),
      'cachedAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<ArtistDetailCache?> getArtistDetail(
    String libraryId,
    String artistId,
  ) async {
    final map = await _readMap(libraryId, 'artist_detail_$artistId');
    if (map == null) return null;
    final artistMap = map['artist'] as Map<String, dynamic>?;
    final albumsList = map['albums'] as List?;
    if (artistMap == null || albumsList == null) return null;
    return ArtistDetailCache(
      artist: Artist.fromJson(artistMap),
      albums: albumsList
          .map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  // -------------------------------------------------------------------------
  // Starred
  // -------------------------------------------------------------------------

  Future<void> cacheStarred(
    String libraryId, {
    required List<Artist> artists,
    required List<Album> albums,
    required List<Song> songs,
  }) async {
    await _saveMap(libraryId, 'starred', {
      'artists': artists.map((e) => e.toJson()).toList(),
      'albums': albums.map((e) => e.toJson()).toList(),
      'songs': songs.map((e) => e.toJson()).toList(),
      'cachedAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<StarredCache?> getStarred(String libraryId) async {
    final map = await _readMap(libraryId, 'starred');
    if (map == null) return null;
    final artistsList = map['artists'] as List?;
    final albumsList = map['albums'] as List?;
    final songsList = map['songs'] as List?;
    if (artistsList == null || albumsList == null || songsList == null) {
      return null;
    }
    return StarredCache(
      artists: artistsList
          .map((e) => Artist.fromJson(e as Map<String, dynamic>))
          .toList(),
      albums: albumsList
          .map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
      songs: songsList
          .map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Artist detail cache DTO
class ArtistDetailCache {
  final Artist artist;
  final List<Album> albums;

  ArtistDetailCache({required this.artist, required this.albums});
}

/// Starred cache DTO
class StarredCache {
  final List<Artist> artists;
  final List<Album> albums;
  final List<Song> songs;

  StarredCache({
    required this.artists,
    required this.albums,
    required this.songs,
  });
}
