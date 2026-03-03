import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/painting.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
import '../../data/models/audio_quality.dart';
import '../../data/repositories/audio_cache_repository.dart';
import '../../data/sources/database/app_database.dart';
import '../utils/logger.dart';

/// 音频缓存服务 — LFU+LRU 混合淘汰
class AudioCacheService {
  static const _tag = 'CACHE_SVC';

  final AudioCacheRepository _repository;
  final AppDatabase _db;
  final int maxCacheSizeBytes;
  final int protectionThreshold;

  AudioCacheService({
    required AudioCacheRepository repository,
    required AppDatabase db,
    this.maxCacheSizeBytes = 2 * 1024 * 1024 * 1024, // 2GB
    this.protectionThreshold = 5,
  }) : _repository = repository,
       _db = db;

  // ---------------------------------------------------------------------------
  // Audio cache directory helpers
  // ---------------------------------------------------------------------------

  /// 获取音频缓存根目录
  Future<Directory> getAudioCacheDir() async {
    final cacheDir = await getApplicationCacheDirectory();
    return Directory(p.join(cacheDir.path, 'echo_audio_cache'));
  }

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
    final dir = await getAudioCacheDir();
    final libDir = Directory(p.join(dir.path, libraryId));
    if (!await libDir.exists()) {
      await libDir.create(recursive: true);
    }
    return p.join(libDir.path, '${songId}_${quality.name}.cache');
  }

  /// 检查并执行缓存淘汰
  Future<void> evictIfNeeded() async {
    // 使用磁盘实际大小判断是否超限
    var totalSize = await getAudioCacheSize();
    if (totalSize <= maxCacheSizeBytes) return;

    Logger.infoWithTag(
      _tag,
      'eviction triggered: diskSize=$totalSize limit=$maxCacheSizeBytes',
    );

    final targetSize = (maxCacheSizeBytes * 0.8).toInt();
    final downloadDirPath = await _getDownloadDirPath();

    // Phase 0: 清理孤立文件（磁盘上存在但 DB 中没有记录的文件）
    totalSize = await _cleanOrphanFiles(totalSize);

    if (totalSize <= targetSize) {
      Logger.infoWithTag(_tag, 'orphan cleanup sufficient');
      return;
    }

    // Phase 1: 先淘汰低频条目（playCount < protectionThreshold）
    final lowFreqEntries = await _repository.getEvictablEntries(
      protectionThreshold: protectionThreshold,
    );
    totalSize = await _evictEntries(
      lowFreqEntries,
      totalSize,
      targetSize,
      downloadDirPath,
    );

    // Phase 2: 如果仍然超限，降级到纯 LRU（所有完整条目按最后播放时间排序）
    if (totalSize > targetSize) {
      Logger.infoWithTag(
        _tag,
        'phase 1 insufficient, falling back to pure LRU eviction',
      );
      final allEntries = await _repository.getAllEntriesByLRU();
      totalSize = await _evictEntries(
        allEntries,
        totalSize,
        targetSize,
        downloadDirPath,
      );
    }

    Logger.infoWithTag(
      _tag,
      'eviction complete: diskSize=$totalSize target=$targetSize',
    );
  }

  /// 清理孤立文件：删除磁盘上存在但 DB 中没有记录的缓存文件
  Future<int> _cleanOrphanFiles(int currentSize) async {
    try {
      final cacheDir = await getAudioCacheDir();
      if (!await cacheDir.exists()) return currentSize;

      // 获取 DB 中所有已注册的文件路径
      final allEntries = await _repository.getAllEntries();
      final registeredPaths = allEntries.map((e) => e.filePath).toSet();

      var cleaned = 0;
      var cleanedBytes = 0;

      await for (final entity in cacheDir.list(
        recursive: true,
        followLinks: false,
      )) {
        if (entity is! File) continue;
        if (registeredPaths.contains(entity.path)) continue;

        try {
          final size = await entity.length();
          await entity.delete();
          cleanedBytes += size;
          cleaned++;
        } catch (e) {
          Logger.warnWithTag(
            _tag,
            'failed to delete orphan: ${entity.path}',
            e,
          );
        }
      }

      if (cleaned > 0) {
        Logger.infoWithTag(
          _tag,
          'orphan cleanup: deleted $cleaned files, freed $cleanedBytes bytes',
        );
      }
      return currentSize - cleanedBytes;
    } catch (e) {
      Logger.warnWithTag(_tag, 'orphan cleanup failed', e);
      return currentSize;
    }
  }

  /// 从列表中逐个淘汰条目，直到 totalSize <= targetSize
  Future<int> _evictEntries(
    List<AudioCacheEntry> entries,
    int totalSize,
    int targetSize,
    String? downloadDirPath,
  ) async {
    for (final entry in entries) {
      if (totalSize <= targetSize) break;

      // 跳过已下载文件（路径在下载目录中的不淘汰）
      if (downloadDirPath != null &&
          entry.filePath.startsWith(downloadDirPath)) {
        Logger.infoWithTag(
          _tag,
          'skip evict (downloaded): ${entry.songId} path=${entry.filePath}',
        );
        continue;
      }

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
    return totalSize;
  }

  /// 获取下载目录路径（用于淘汰保护）
  Future<String?> _getDownloadDirPath() async {
    try {
      if (!kIsWeb && Platform.isAndroid) {
        return '/storage/emulated/0/Music/Echoes';
      }
      final appDir = await getApplicationDocumentsDirectory();
      return p.join(appDir.path, 'echo_downloads');
    } catch (e) {
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // 音频缓存大小 & 清理（基于磁盘扫描）
  // ---------------------------------------------------------------------------

  /// 获取音频缓存磁盘实际大小（字节）
  Future<int> getAudioCacheSize() async {
    final dir = await getAudioCacheDir();
    return _getDirectorySize(dir);
  }

  /// 清除所有音频缓存（删除目录 + 清空 DB 表）
  Future<void> clearAllAudioCache() async {
    try {
      final dir = await getAudioCacheDir();
      if (await dir.exists()) {
        await dir.delete(recursive: true);
        Logger.infoWithTag(_tag, 'audio cache directory deleted');
      }
    } catch (e) {
      Logger.warnWithTag(_tag, 'failed to delete audio cache directory', e);
    }
    await _repository.clearAll();
    Logger.infoWithTag(_tag, 'audio cache DB cleared');
  }

  /// 清除指定音乐库的音频缓存
  Future<void> clearAudioCacheByLibrary(String libraryId) async {
    try {
      final dir = await getAudioCacheDir();
      final libDir = Directory(p.join(dir.path, libraryId));
      if (await libDir.exists()) {
        await libDir.delete(recursive: true);
        Logger.infoWithTag(
          _tag,
          'audio cache directory deleted for library=$libraryId',
        );
      }
    } catch (e) {
      Logger.warnWithTag(_tag, 'failed to delete library cache dir', e);
    }
    await _repository.clearByLibrary(libraryId);
  }

  // ---------------------------------------------------------------------------
  // 图片缓存（cached_network_image / DefaultCacheManager）
  // ---------------------------------------------------------------------------

  /// 获取图片缓存大小（字节）
  Future<int> getImageCacheSize() async {
    try {
      // flutter_cache_manager stores files under the app cache directory
      // in a subdirectory named after the cache key (default: "libCachedImageData")
      final appCacheDir = await getApplicationCacheDirectory();
      final imageCacheDir = Directory(
        p.join(appCacheDir.path, 'libCachedImageData'),
      );
      return _getDirectorySize(imageCacheDir);
    } catch (e) {
      Logger.warnWithTag(_tag, 'failed to calculate image cache size', e);
      return 0;
    }
  }

  /// 清除图片缓存
  Future<void> clearImageCache() async {
    try {
      // 删除磁盘上的图片缓存目录
      final appCacheDir = await getApplicationCacheDirectory();
      final imageCacheDir = Directory(
        p.join(appCacheDir.path, 'libCachedImageData'),
      );
      if (await imageCacheDir.exists()) {
        await imageCacheDir.delete(recursive: true);
      }
      // 同时清除内存中的图片缓存
      PaintingBinding.instance.imageCache.clear();
      PaintingBinding.instance.imageCache.clearLiveImages();
      Logger.infoWithTag(_tag, 'image cache cleared');
    } catch (e) {
      Logger.warnWithTag(_tag, 'failed to clear image cache', e);
    }
  }

  // ---------------------------------------------------------------------------
  // 歌词缓存（Drift DB lyricsCache 表）
  // ---------------------------------------------------------------------------

  /// 获取歌词缓存条数
  Future<int> getLyricsCacheCount() async {
    try {
      final rows = await _db.select(_db.lyricsCache).get();
      return rows.length;
    } catch (e) {
      Logger.warnWithTag(_tag, 'failed to count lyrics cache', e);
      return 0;
    }
  }

  /// 清除歌词缓存
  Future<void> clearLyricsCache() async {
    try {
      await _db.delete(_db.lyricsCache).go();
      Logger.infoWithTag(_tag, 'lyrics cache cleared');
    } catch (e) {
      Logger.warnWithTag(_tag, 'failed to clear lyrics cache', e);
    }
  }

  // ---------------------------------------------------------------------------
  // Legacy compatibility
  // ---------------------------------------------------------------------------

  /// 获取当前缓存总大小（向后兼容，改用磁盘扫描）
  Future<int> getTotalCacheSize() async {
    return getAudioCacheSize();
  }

  /// 清除所有缓存（向后兼容）
  Future<void> clearAll() async {
    await clearAllAudioCache();
  }

  /// 清除指定音乐库的缓存（向后兼容）
  Future<void> clearByLibrary(String libraryId) async {
    await clearAudioCacheByLibrary(libraryId);
  }

  // ---------------------------------------------------------------------------
  // Internal helpers
  // ---------------------------------------------------------------------------

  /// 递归计算目录大小
  Future<int> _getDirectorySize(Directory dir) async {
    if (!await dir.exists()) return 0;
    int totalSize = 0;
    try {
      await for (final entity in dir.list(
        recursive: true,
        followLinks: false,
      )) {
        if (entity is File) {
          try {
            totalSize += await entity.length();
          } catch (_) {
            // skip unreadable files
          }
        }
      }
    } catch (e) {
      Logger.warnWithTag(_tag, 'error scanning directory: ${dir.path}', e);
    }
    return totalSize;
  }
}
