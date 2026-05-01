import '../../core/constants/api_constants.dart';
import '../../core/utils/logger.dart';
import '../models/song.dart';
import '../models/album.dart';
import '../models/artist.dart';
import '../sources/subsonic_api_client.dart';

const _musicRepoLogTag = 'MUSIC_REPO';

/// 音乐数据仓库
class MusicRepository {
  final SubsonicApiClient _apiClient;

  MusicRepository(this._apiClient);

  /// 获取专辑列表
  /// type: newest, frequent, recent, random, alphabeticalByName, alphabeticalByArtist, starred 等
  Future<List<Album>> getAlbumList({
    required String type,
    int? size,
    int? offset,
  }) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.getAlbumList2,
        queryParameters: {
          'type': type,
          if (size != null) 'size': size.toString(),
          if (offset != null) 'offset': offset.toString(),
        },
      );

      final albumList = response['albumList2']?['album'] as List?;
      if (albumList == null) return [];

      return albumList
          .map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      Logger.error('Failed to get album list', e);
      rethrow;
    }
  }

  /// 获取专辑详情（包含曲目列表）
  Future<AlbumDetail?> getAlbum(String albumId) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.getAlbum,
        queryParameters: {'id': albumId},
      );

      final albumData = response['album'];
      if (albumData == null) return null;

      final album = Album.fromJson(albumData as Map<String, dynamic>);
      final songList = albumData['song'] as List?;
      final songs =
          songList
              ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];

      return AlbumDetail(album: album, songs: songs);
    } catch (e) {
      Logger.error('Failed to get album', e);
      rethrow;
    }
  }

  /// 获取所有歌手（按字母索引）
  Future<List<Artist>> getArtists() async {
    try {
      final response = await _apiClient.get(ApiConstants.getArtists);

      final artists = <Artist>[];
      final indexes = response['artists']?['index'] as List?;

      if (indexes == null) return [];

      for (final index in indexes) {
        final artistList = index['artist'] as List?;
        if (artistList != null) {
          for (final artistData in artistList) {
            artists.add(Artist.fromJson(artistData as Map<String, dynamic>));
          }
        }
      }

      return artists;
    } catch (e) {
      Logger.error('Failed to get artists', e);
      rethrow;
    }
  }

  /// 获取歌手详情（包含专辑列表和全部歌曲）
  Future<ArtistDetail?> getArtist(String artistId) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.getArtist,
        queryParameters: {'id': artistId},
      );

      final artistData = response['artist'];
      if (artistData == null) return null;

      final artist = Artist.fromJson(artistData as Map<String, dynamic>);
      final albumList = artistData['album'] as List?;
      final albums =
          albumList
              ?.map((e) => Album.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];

      // 按歌手下所有专辑聚合歌曲，避免仅返回热门歌曲。
      final albumDetails = await Future.wait(
        albums.map((album) async {
          try {
            return await getAlbum(album.id);
          } catch (e) {
            Logger.warn(
              'Failed to get album songs for artist=$artistId album=${album.id}',
              e,
            );
            return null;
          }
        }),
      );

      final songsById = <String, Song>{};
      for (final detail in albumDetails) {
        if (detail == null) continue;
        for (final song in detail.songs) {
          final songArtistId = song.artistId;
          if (songArtistId != null &&
              songArtistId.isNotEmpty &&
              songArtistId != artist.id) {
            continue;
          }
          songsById.putIfAbsent(song.id, () => song);
        }
      }
      final songs = songsById.values.toList();

      return ArtistDetail(artist: artist, albums: albums, songs: songs);
    } catch (e) {
      Logger.error('Failed to get artist', e);
      rethrow;
    }
  }

  /// 获取歌手热门歌曲
  Future<List<Song>> getTopSongs(String artistName, {int? count}) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.getTopSongs,
        queryParameters: {
          'artist': artistName,
          if (count != null) 'count': count.toString(),
        },
      );

      final songList = response['topSongs']?['song'] as List?;
      if (songList == null) return [];

      return songList
          .map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      Logger.error('Failed to get top songs', e);
      rethrow;
    }
  }

  /// 获取随机歌曲
  Future<List<Song>> getRandomSongs({
    int? size,
    String? genre,
    int? fromYear,
    int? toYear,
  }) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.getRandomSongs,
        queryParameters: {
          if (size != null) 'size': size.toString(),
          if (genre != null) 'genre': genre,
          if (fromYear != null) 'fromYear': fromYear.toString(),
          if (toYear != null) 'toYear': toYear.toString(),
        },
      );

      final songList = response['randomSongs']?['song'] as List?;
      if (songList == null) return [];

      return songList
          .map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      Logger.error('Failed to get random songs', e);
      rethrow;
    }
  }

  /// 获取所有歌曲 (通过 search3 接口变通实现)
  Future<List<Song>> getAllSongs() async {
    try {
      // Subsonic API 没有直接的 getAllSongs 接口
      // 这里使用 search3 接口，查询空字符串或通配符，获取大量歌曲
      // 实际生产中可能需要分页处理，这里为了简化先一次性获取较多数量
      final response = await _apiClient.get(
        ApiConstants.search3,
        queryParameters: {
          'query': '', // 尝试空字符串获取所有
          'songCount': '5000', // 获取足够多的歌曲
          'artistCount': '0',
          'albumCount': '0',
        },
      );

      final searchResult = response['searchResult3'];
      if (searchResult == null) return [];

      final songList = searchResult['song'] as List?;
      if (songList == null) return [];

      return songList
          .map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      Logger.error('Failed to get all songs', e);
      rethrow;
    }
  }

  /// 搜索
  Future<SearchResult> search({
    required String query,
    int? artistCount,
    int? albumCount,
    int? songCount,
  }) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.search3,
        queryParameters: {
          'query': query,
          if (artistCount != null) 'artistCount': artistCount.toString(),
          if (albumCount != null) 'albumCount': albumCount.toString(),
          if (songCount != null) 'songCount': songCount.toString(),
        },
      );

      final searchResult = response['searchResult3'];
      if (searchResult == null) {
        return SearchResult(artists: [], albums: [], songs: []);
      }

      final artists =
          (searchResult['artist'] as List?)
              ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];

      final albums =
          (searchResult['album'] as List?)
              ?.map((e) => Album.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];

      final songs =
          (searchResult['song'] as List?)
              ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];

      return SearchResult(artists: artists, albums: albums, songs: songs);
    } catch (e) {
      Logger.error('Failed to search', e);
      rethrow;
    }
  }

  /// 收藏/取消收藏歌曲
  Future<void> setSongStarred(String songId, bool starred) async {
    try {
      await _apiClient.get(
        starred ? ApiConstants.star : ApiConstants.unstar,
        queryParameters: {'id': songId},
      );
    } catch (e) {
      Logger.error('Failed to set song starred', e);
      rethrow;
    }
  }

  /// 收藏/取消收藏专辑
  Future<void> setAlbumStarred(String albumId, bool starred) async {
    try {
      await _apiClient.get(
        starred ? ApiConstants.star : ApiConstants.unstar,
        queryParameters: {'albumId': albumId},
      );
    } catch (e) {
      Logger.error('Failed to set album starred', e);
      rethrow;
    }
  }

  /// 收藏/取消收藏歌手
  Future<void> setArtistStarred(String artistId, bool starred) async {
    try {
      await _apiClient.get(
        starred ? ApiConstants.star : ApiConstants.unstar,
        queryParameters: {'artistId': artistId},
      );
    } catch (e) {
      Logger.error('Failed to set artist starred', e);
      rethrow;
    }
  }

  /// 获取收藏列表
  Future<StarredResult> getStarred() async {
    try {
      final response = await _apiClient.get(ApiConstants.getStarred2);

      final starred = response['starred2'];
      if (starred == null) {
        return StarredResult(artists: [], albums: [], songs: []);
      }

      final artists =
          (starred['artist'] as List?)
              ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];

      final albums =
          (starred['album'] as List?)
              ?.map((e) => Album.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];

      final songs =
          (starred['song'] as List?)
              ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];

      return StarredResult(artists: artists, albums: albums, songs: songs);
    } catch (e) {
      Logger.error('Failed to get starred', e);
      rethrow;
    }
  }

  /// 获取单曲详情
  Future<Song?> getSong(String songId) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.getSong,
        queryParameters: {'id': songId},
      );

      final songData = response['song'];
      if (songData == null) return null;

      final song = Song.fromJson(songData as Map<String, dynamic>);
      Logger.infoWithTag(
        _musicRepoLogTag,
        'getSong loaded songId=$songId '
        'title="${song.title.trim()}" '
        'artist="${(song.artist ?? '').trim()}" '
        'album="${(song.album ?? '').trim()}" '
        'path="${(song.path ?? '').trim()}"',
      );
      return song;
    } catch (e) {
      Logger.error('Failed to get song: $songId', e);
      return null;
    }
  }
}

/// 专辑详情（包含歌曲列表）
class AlbumDetail {
  final Album album;
  final List<Song> songs;

  AlbumDetail({required this.album, required this.songs});
}

/// 歌手详情（包含专辑列表和歌曲）
class ArtistDetail {
  final Artist artist;
  final List<Album> albums;
  final List<Song> songs;

  ArtistDetail({
    required this.artist,
    required this.albums,
    this.songs = const [],
  });
}

/// 搜索结果
class SearchResult {
  final List<Artist> artists;
  final List<Album> albums;
  final List<Song> songs;

  SearchResult({
    required this.artists,
    required this.albums,
    required this.songs,
  });

  bool get isEmpty => artists.isEmpty && albums.isEmpty && songs.isEmpty;
}

/// 收藏结果
class StarredResult {
  final List<Artist> artists;
  final List<Album> albums;
  final List<Song> songs;

  StarredResult({
    required this.artists,
    required this.albums,
    required this.songs,
  });

  bool get isEmpty => artists.isEmpty && albums.isEmpty && songs.isEmpty;
}
