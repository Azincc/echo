import 'dart:io' show File;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart' hide PlayerState;
import '../../data/models/audio_quality.dart';
import '../../data/sources/subsonic_api_client.dart';
import '../../core/utils/logger.dart';
import '../api_provider.dart';
import '../audio_cache_provider.dart';
import '../audio_quality_provider.dart';
import '../download_provider.dart';
import '../auth_provider.dart';
import 'player_state.dart';

/// 缓存管理处理器
///
/// 处理缓存注册和预缓存逻辑，从 PlayerNotifier 中提取。
class CacheManagerHandler {
  final Ref _ref;

  CacheManagerHandler(this._ref);

  SubsonicApiClient get _apiClient => _ref.read(subsonicApiClientProvider);

  /// 从缓存文件注册缓存元数据（downloadProgressStream 到 1.0 时调用）
  Future<void> registerCacheFromFile(
    File cacheFile,
    String songId,
    String libraryId,
    AudioQualityLevel quality,
  ) async {
    try {
      if (!await cacheFile.exists()) return;
      final fileSize = await cacheFile.length();
      if (fileSize <= 0) return;

      final cacheService = _ref.read(audioCacheServiceProvider);
      await cacheService.registerCache(
        songId: songId,
        libraryId: libraryId,
        filePath: cacheFile.path,
        fileSize: fileSize,
        quality: quality,
      );
      Logger.info(
        'Cache registered (download complete): $songId '
        '(${(fileSize / 1024 / 1024).toStringAsFixed(1)} MB)',
      );
    } catch (e) {
      Logger.warn('Failed to register cache for $songId', e);
    }
  }

  /// 预缓存队列中下一首歌
  ///
  /// [needsTranscoding] 回调用于判断是否需要转码。
  Future<void> preCacheNextSong({
    required PlayerState state,
    required String? Function(String? suffix) needsTranscoding,
    required void Function(String message) seekDbg,
  }) async {
    if (!state.hasNext) return;
    if (kIsWeb) return;
    if (state.shuffleEnabled) return;
    if (state.currentIndex < 0 ||
        state.currentIndex >= state.queue.length - 1) {
      return;
    }

    final nextSong = state.queue[state.currentIndex + 1];
    final authState = _ref.read(authStateProvider);
    final libraryId = authState.currentLibrary?.id ?? '';
    if (libraryId.isEmpty) return;

    final downloadService = _ref.read(downloadServiceProvider);
    final cacheService = _ref.read(audioCacheServiceProvider);
    final effectiveQuality = _ref.read(effectiveQualityProvider);
    final maxBitRate = effectiveQuality.maxBitRate;
    if (maxBitRate != null) {
      seekDbg('pre_cache_skip song=${nextSong.id} reason=bitrate-limited');
      return;
    }

    // 已下载则不需要预缓存
    final downloaded = await downloadService.isDownloaded(
      nextSong.id,
      libraryId,
    );
    if (downloaded) return;

    // 已缓存则不需要预缓存
    final cached = await cacheService.getCachedPath(
      songId: nextSong.id,
      libraryId: libraryId,
      quality: effectiveQuality,
    );
    if (cached != null) return;

    // 预缓存：构建 LockCachingAudioSource 并监听下载进度
    try {
      final streamUrl = _apiClient.getStreamUrl(
        nextSong.id,
        format: needsTranscoding(nextSong.suffix),
        maxBitRate: maxBitRate,
      );
      final cacheFilePath = await cacheService.getCacheFilePath(
        songId: nextSong.id,
        libraryId: libraryId,
        quality: effectiveQuality,
      );
      final cacheFile = File(cacheFilePath);
      // ignore: experimental_member_use
      final source = LockCachingAudioSource(
        Uri.parse(streamUrl),
        cacheFile: cacheFile,
      );
      Logger.info('Pre-caching next song: ${nextSong.title}');

      // 监听 downloadProgressStream，下载完成时注册缓存
      // ignore: experimental_member_use
      source.downloadProgressStream.listen((progress) {
        if (progress >= 1.0) {
          registerCacheFromFile(
            cacheFile,
            nextSong.id,
            libraryId,
            effectiveQuality,
          );
        }
      });
    } catch (e) {
      Logger.warn('Pre-cache failed for next song', e);
    }
  }
}
