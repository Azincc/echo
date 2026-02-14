import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
import '../../data/models/audio_quality.dart';
import '../../data/repositories/audio_cache_repository.dart';
import '../utils/logger.dart';

/// 音频缓存服务 — LFU+LRU 混合淘汰
class AudioCacheService {
  final AudioCacheRepository _repository;
  final int maxCacheSizeBytes;
  final int protectionThreshold;

  AudioCacheService({
    required AudioCacheRepository repository,
    this.maxCacheSizeBytes = 2 * 1024 * 1024 * 1024, // 2GB
    this.protectionThreshold = 5,
  }) : _repository = repository;

  /// 获取缓存文件路径（若已缓存且文件存在）
  /// 同时更新 playCount 和 lastPlayedAt
  Future<String?> getCachedPath({
    required String songId,
    required String libraryId,
    required AudioQualityLevel quality,
  }) async {
    // 先查精确匹配
    var entry = await _repository.getCacheEntry(
      songId: songId,
      libraryId: libraryId,
      quality: quality,
    );

    // 如果没有精确匹配，查找任意完整缓存
    entry ??= await _repository.getAnyCacheEntry(
      songId: songId,
      libraryId: libraryId,
    );

    if (entry == null || !entry.isComplete) return null;

    // 验证文件存在
    final file = File(entry.filePath);
    if (!await file.exists()) {
      // 文件不存在，清理元数据
      await _repository.deleteEntry(entry.id);
      return null;
    }

    // 更新播放统计
    await _repository.updatePlayStats(entry.id);
    return entry.filePath;
  }

  /// 注册新的缓存条目（LockCachingAudioSource 缓存完成后调用）
  Future<void> registerCache({
    required String songId,
    required String libraryId,
    required String filePath,
    required int fileSize,
    required AudioQualityLevel quality,
  }) async {
    final entry = AudioCacheEntry(
      id: const Uuid().v4(),
      libraryId: libraryId,
      songId: songId,
      quality: quality,
      filePath: filePath,
      fileSize: fileSize,
      playCount: 1,
      lastPlayedAt: DateTime.now().millisecondsSinceEpoch,
      cachedAt: DateTime.now().millisecondsSinceEpoch,
      isComplete: true,
    );

    await _repository.registerCache(entry);

    // 检查并执行淘汰
    await evictIfNeeded();
  }

  /// 获取缓存文件路径（用于 LockCachingAudioSource 的 cacheFile）
  Future<String> getCacheFilePath({
    required String songId,
    required String libraryId,
    required AudioQualityLevel quality,
  }) async {
    final cacheDir = await getApplicationCacheDirectory();
    final dir = Directory(p.join(cacheDir.path, 'echo_audio_cache', libraryId));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return p.join(dir.path, '${songId}_${quality.name}.cache');
  }

  /// 检查并执行缓存淘汰
  Future<void> evictIfNeeded() async {
    var totalSize = await _repository.getTotalCacheSize();
    if (totalSize <= maxCacheSizeBytes) return;

    final targetSize = (maxCacheSizeBytes * 0.8).toInt();
    final evictable = await _repository.getEvictablEntries(
      protectionThreshold: protectionThreshold,
    );

    for (final entry in evictable) {
      if (totalSize <= targetSize) break;

      // 删除文件
      try {
        final file = File(entry.filePath);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        Logger.warn('Failed to delete cache file: ${entry.filePath}', e);
      }

      // 删除数据库记录
      await _repository.deleteEntry(entry.id);
      totalSize -= entry.fileSize;

      Logger.info('Evicted cache: ${entry.songId} (${entry.quality.name})');
    }
  }

  /// 获取当前缓存总大小
  Future<int> getTotalCacheSize() async {
    return _repository.getTotalCacheSize();
  }

  /// 清除所有缓存
  Future<void> clearAll() async {
    final entries = await _repository.getAllEntries();
    for (final entry in entries) {
      try {
        final file = File(entry.filePath);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        Logger.warn('Failed to delete cache file: ${entry.filePath}', e);
      }
    }
    await _repository.clearAll();
  }

  /// 清除指定音乐库的缓存
  Future<void> clearByLibrary(String libraryId) async {
    final entries = await _repository.getAllEntries();
    for (final entry in entries.where((e) => e.libraryId == libraryId)) {
      try {
        final file = File(entry.filePath);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        Logger.warn('Failed to delete cache file: ${entry.filePath}', e);
      }
    }
    await _repository.clearByLibrary(libraryId);
  }
}
