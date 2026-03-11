import 'dart:io' show File;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/song.dart';
import '../../data/sources/subsonic_api_client.dart';
import '../../data/sources/local_storage.dart';
import '../../data/repositories/music_repository.dart';
import '../../core/constants/api_constants.dart';
import '../../core/network/connectivity_monitor.dart';
import '../../core/utils/logger.dart';
import '../music_provider.dart';
import '../api_provider.dart';


const _logTag = 'PLAYER';

/// 独立的收藏/Scrobble 处理器
///
/// 从 PlayerNotifier 中提取，接收显式依赖以保持可测试性。
class FavoriteScrobbleHandler {
  final Ref _ref;

  FavoriteScrobbleHandler(this._ref);

  SubsonicApiClient get _apiClient => _ref.read(subsonicApiClientProvider);

  MusicRepository get _musicRepository =>
      _ref.read(musicRepositoryProvider) ?? MusicRepository(_apiClient);

  /// 上报播放记录（Scrobble）
  Future<void> scrobble(String songId, {required bool submission}) async {
    try {
      await _apiClient.post(
        ApiConstants.scrobble,
        queryParameters: {
          'id': songId,
          'time': DateTime.now().millisecondsSinceEpoch.toString(),
          'submission': submission.toString(),
        },
      );
      Logger.info('Scrobble: $songId (submission: $submission)');
    } catch (e) {
      Logger.warn('Failed to scrobble', e);
    }
  }

  /// 记录移动网络缓存命中节省的流量
  Future<void> recordMobileCacheSavedBytesForHit({
    required String songId,
    required String cacheFilePath,
    required String libraryId,
  }) async {
    if (libraryId.isEmpty) return;

    try {
      final networkType = _ref
          .read(connectivityMonitorProvider)
          .currentNetworkType;
      if (networkType != NetworkType.mobile) return;

      final cacheFile = File(cacheFilePath);
      if (!await cacheFile.exists()) return;

      final savedBytes = await cacheFile.length();
      if (savedBytes <= 0) return;

      await LocalStorage.addMobileCacheSavedBytes(
        libraryId: libraryId,
        bytes: savedBytes,
      );
      Logger.infoWithTag(
        _logTag,
        'mobile cache hit recorded song=$songId savedBytes=$savedBytes',
      );
    } catch (e) {
      Logger.warnWithTag(
        _logTag,
        'failed to record mobile cache hit savings',
        e,
      );
    }
  }

  /// 切换指定歌曲的收藏状态
  ///
  /// 返回 (newStarred, updatedCurrentSong, updatedQueue)，
  /// 调用方负责更新 state 和 invalidate providers。
  Future<bool?> toggleSongFavorite({
    required Song song,
    required Song? currentSong,
    required List<Song> queue,
  }) async {
    try {
      Song? queueSong;
      for (final queued in queue) {
        if (queued.id == song.id) {
          queueSong = queued;
          break;
        }
      }
      final currentStarred =
          queueSong?.starred ??
          (currentSong?.id == song.id ? currentSong!.starred : song.starred);
      final newStarred = !currentStarred;
      await _musicRepository.setSongStarred(song.id, newStarred);
      Logger.info('Toggled favorite for ${song.title}: $newStarred');
      return newStarred;
    } catch (e) {
      Logger.error('Failed to toggle favorite', e);
      return null;
    }
  }

  /// 更新队列中指定歌曲的收藏状态
  List<Song> updateQueueStarred(
    List<Song> queue,
    String songId,
    bool starred,
  ) {
    return queue.map((s) {
      if (s.id != songId) return s;
      return s.copyWith(starred: starred);
    }).toList();
  }

  /// 刷新收藏相关的 provider
  void invalidateFavoriteProviders({String? albumId}) {
    _ref.invalidate(starredProvider);
    _ref.invalidate(randomSongsProvider);
    _ref.invalidate(allSongsProvider);
    if (albumId != null && albumId.isNotEmpty) {
      _ref.invalidate(albumDetailProvider(albumId));
    }
  }
}
