import '../../core/constants/api_constants.dart';
import '../../core/utils/logger.dart';
import '../models/playlist.dart';
import '../sources/subsonic_api_client.dart';

/// 歌单仓库
class PlaylistRepository {
  final SubsonicApiClient _apiClient;

  PlaylistRepository(this._apiClient);

  /// 获取所有歌单
  Future<List<Playlist>> getPlaylists() async {
    try {
      final response = await _apiClient.get(ApiConstants.getPlaylists);

      final playlistList = response['playlists']?['playlist'] as List?;
      if (playlistList == null) return [];

      return playlistList
          .map((e) => Playlist.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      Logger.error('Failed to get playlists', e);
      rethrow;
    }
  }

  /// 获取歌单详情（包含歌曲列表）
  Future<Playlist?> getPlaylist(String playlistId) async {
    try {
      final response = await _apiClient.get(
        ApiConstants.getPlaylist,
        queryParameters: {'id': playlistId},
      );

      final playlistData = response['playlist'];
      if (playlistData == null) return null;

      return Playlist.fromJson(playlistData as Map<String, dynamic>);
    } catch (e) {
      Logger.error('Failed to get playlist', e);
      rethrow;
    }
  }

  /// 创建歌单
  Future<Playlist?> createPlaylist({
    required String name,
    List<String>? songIds,
  }) async {
    try {
      final queryParams = {
        'name': name,
        if (songIds != null && songIds.isNotEmpty)
          'songId': songIds,
      };

      final response = await _apiClient.get(
        ApiConstants.createPlaylist,
        queryParameters: queryParams,
      );

      final playlistData = response['playlist'];
      if (playlistData == null) return null;

      return Playlist.fromJson(playlistData as Map<String, dynamic>);
    } catch (e) {
      Logger.error('Failed to create playlist', e);
      rethrow;
    }
  }

  /// 更新歌单
  Future<void> updatePlaylist({
    required String playlistId,
    String? name,
    String? comment,
    bool? public,
    List<String>? songIdsToAdd,
    List<int>? songIndexesToRemove,
  }) async {
    try {
      final queryParams = {
        'playlistId': playlistId,
        if (name != null) 'name': name,
        if (comment != null) 'comment': comment,
        if (public != null) 'public': public.toString(),
        if (songIdsToAdd != null && songIdsToAdd.isNotEmpty)
          'songIdToAdd': songIdsToAdd,
        if (songIndexesToRemove != null && songIndexesToRemove.isNotEmpty)
          'songIndexToRemove':
              songIndexesToRemove.map((i) => i.toString()).toList(),
      };

      await _apiClient.get(
        ApiConstants.updatePlaylist,
        queryParameters: queryParams,
      );
    } catch (e) {
      Logger.error('Failed to update playlist', e);
      rethrow;
    }
  }

  /// 删除歌单
  Future<void> deletePlaylist(String playlistId) async {
    try {
      await _apiClient.get(
        ApiConstants.deletePlaylist,
        queryParameters: {'id': playlistId},
      );
    } catch (e) {
      Logger.error('Failed to delete playlist', e);
      rethrow;
    }
  }
}
