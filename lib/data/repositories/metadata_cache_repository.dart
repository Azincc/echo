import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/album.dart';
import '../models/playlist.dart';
import '../models/song.dart';
import 'music_repository.dart';

/// 元数据缓存仓库（基于 SharedPreferences）
class MetadataCacheRepository {
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
  }

  Future<Map<String, dynamic>?> _readMap(String libraryId, String scope) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key(libraryId, scope));
    if (raw == null || raw.isEmpty) return null;
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
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
}
