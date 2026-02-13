/// Subsonic API 常量
class ApiConstants {
  // API 版本
  static const String apiVersion = '1.16.1';

  // 客户端标识
  static const String clientName = 'echo';

  // 返回格式
  static const String format = 'json';

  // 超时设置
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // API 端点
  static const String ping = '/rest/ping';
  static const String getOpenSubsonicExtensions =
      '/rest/getOpenSubsonicExtensions';
  static const String getAlbumList2 = '/rest/getAlbumList2';
  static const String getAlbum = '/rest/getAlbum';
  static const String getArtists = '/rest/getArtists';
  static const String getArtist = '/rest/getArtist';
  static const String getSong = '/rest/getSong';
  static const String getRandomSongs = '/rest/getRandomSongs';
  static const String search3 = '/rest/search3';
  static const String getPlaylists = '/rest/getPlaylists';
  static const String getPlaylist = '/rest/getPlaylist';
  static const String createPlaylist = '/rest/createPlaylist';
  static const String updatePlaylist = '/rest/updatePlaylist';
  static const String deletePlaylist = '/rest/deletePlaylist';
  static const String getStarred2 = '/rest/getStarred2';
  static const String star = '/rest/star';
  static const String unstar = '/rest/unstar';
  static const String stream = '/rest/stream';
  static const String download = '/rest/download';
  static const String getCoverArt = '/rest/getCoverArt';
  static const String scrobble = '/rest/scrobble';

  // 歌词 API（v0.3.0）
  static const String getLyricsBySongId = '/rest/getLyricsBySongId';
  static const String getLyrics = '/rest/getLyrics';
}
