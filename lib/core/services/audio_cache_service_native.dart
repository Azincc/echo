import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/painting.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/audio_quality.dart';
import '../../data/repositories/audio_cache_repository.dart';
import '../../data/sources/database/app_database.dart';
import '../utils/download_path_utils.dart';
import '../utils/logger.dart';

class AudioCacheService {
  static const _tag = 'CACHE_SVC';

  final AudioCacheRepository _repository;
  final AppDatabase _db;
  final int maxCacheSizeBytes;
  final int protectionThreshold;

  AudioCacheService({
    required AudioCacheRepository repository,
    required AppDatabase db,
    this.maxCacheSizeBytes = 2 * 1024 * 1024 * 1024,
    this.protectionThreshold = 5,
  }) : _repository = repository,
       _db = db;

  Future<Directory> getAudioCacheDir() async {
    final cacheDir = await getApplicationCacheDirectory();
    return Directory(p.join(cacheDir.path, 'echo_audio_cache'));
  }

  Future<String?> getCachedPath({
    required String songId,
    required String libraryId,
    required AudioQualityLevel quality,
  }) async {
    var entry = await _repository.getCacheEntry(
      songId: songId,
      libraryId: libraryId,
      quality: quality,
    );

    entry ??= await _repository.getAnyCacheEntry(
      songId: songId,
      libraryId: libraryId,
    );

    if (entry == null || !entry.isComplete) return null;
    if (!await _isManagedAudioFilePath(entry.filePath)) {
      Logger.warnWithTag(
        _tag,
        'ignoring unmanaged cache entry path=${entry.filePath}',
      );
      await _repository.deleteEntry(entry.id);
      return null;
    }

    final file = File(entry.filePath);
    if (!await file.exists()) {
      await _repository.deleteEntry(entry.id);
      return null;
    }

    await _repository.updatePlayStats(entry.id);
    return entry.filePath;
  }

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
    await evictIfNeeded(activeSongIds: {songId});
  }

  Future<String> getCacheFilePath({
    required String songId,
    required String libraryId,
    required AudioQualityLevel quality,
  }) async {
    final rootDir = await getAudioCacheDir();
    final cachePath = buildCacheFilePath(
      rootDir: rootDir.path,
      libraryId: libraryId,
      songId: songId,
      qualityName: quality.name,
    );

    final cacheDir = Directory(p.dirname(cachePath));
    if (!await cacheDir.exists()) {
      await cacheDir.create(recursive: true);
    }

    return cachePath;
  }

  Future<void> evictIfNeeded({Set<String>? activeSongIds}) async {
    var totalSize = await getAudioCacheSize();
    if (totalSize <= maxCacheSizeBytes) return;

    Logger.infoWithTag(
      _tag,
      'eviction triggered: diskSize=$totalSize limit=$maxCacheSizeBytes'
      '${activeSongIds != null ? ' activeSongs=${activeSongIds.length}' : ''}',
    );

    final targetSize = (maxCacheSizeBytes * 0.8).toInt();
    final cacheDirPath = (await getAudioCacheDir()).path;
    final downloadDirPaths = await _getDownloadDirPaths();

    totalSize = await _cleanOrphanFiles(totalSize);
    if (totalSize <= targetSize) {
      Logger.infoWithTag(_tag, 'orphan cleanup sufficient');
      return;
    }

    final lowFreqEntries = await _repository.getEvictablEntries(
      protectionThreshold: protectionThreshold,
    );
    totalSize = await _evictEntries(
      lowFreqEntries,
      totalSize,
      targetSize,
      cacheDirPath,
      downloadDirPaths,
      activeSongIds,
    );

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
        cacheDirPath,
        downloadDirPaths,
        activeSongIds,
      );
    }

    Logger.infoWithTag(
      _tag,
      'eviction complete: diskSize=$totalSize target=$targetSize',
    );
  }

  Future<int> _cleanOrphanFiles(int currentSize) async {
    try {
      final cacheDir = await getAudioCacheDir();
      if (!await cacheDir.exists()) return currentSize;

      final allEntries = await _repository.getAllEntries();
      final registeredPaths = allEntries.map((entry) => entry.filePath).toSet();

      var cleaned = 0;
      var cleanedBytes = 0;

      await for (final entity in cacheDir.list(
        recursive: true,
        followLinks: false,
      )) {
        if (entity is! File) continue;
        if (registeredPaths.contains(entity.path)) continue;
        if (entity.path.endsWith('.part')) {
          Logger.debugWithTag(
            _tag,
            'skip orphan (active .part): ${entity.path}',
          );
          continue;
        }

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

  Future<int> _evictEntries(
    List<AudioCacheEntry> entries,
    int totalSize,
    int targetSize,
    String cacheDirPath,
    List<String> downloadDirPaths,
    Set<String>? activeSongIds,
  ) async {
    for (final entry in entries) {
      if (totalSize <= targetSize) break;

      if (activeSongIds != null && activeSongIds.contains(entry.songId)) {
        Logger.infoWithTag(_tag, 'skip evict (active): ${entry.songId}');
        continue;
      }

      if (downloadDirPaths.any(
        (rootDir) =>
            isPathWithinRoot(rootDir: rootDir, candidatePath: entry.filePath),
      )) {
        Logger.infoWithTag(
          _tag,
          'skip evict (downloaded): ${entry.songId} path=${entry.filePath}',
        );
        continue;
      }

      if (!isPathWithinRoot(
        rootDir: cacheDirPath,
        candidatePath: entry.filePath,
      )) {
        Logger.warnWithTag(
          _tag,
          'drop unmanaged cache entry without deleting file path=${entry.filePath}',
        );
        await _repository.deleteEntry(entry.id);
        continue;
      }

      try {
        final file = File(entry.filePath);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        Logger.warn('Failed to delete cache file: ${entry.filePath}', e);
      }

      await _repository.deleteEntry(entry.id);
      totalSize -= entry.fileSize;

      Logger.info('Evicted cache: ${entry.songId} (${entry.quality.name})');
    }

    return totalSize;
  }

  Future<List<String>> _getDownloadDirPaths() async {
    final roots = <String>[];

    try {
      if (!kIsWeb && Platform.isAndroid) {
        final musicDirs = await getExternalStorageDirectories(
          type: StorageDirectory.music,
        );
        final musicDir =
            musicDirs?.firstOrNull?.path ?? '/storage/emulated/0/Music';
        roots.add(p.join(musicDir, 'Echoes'));

        const legacyPublicMusicDir = '/storage/emulated/0/Music/Echoes';
        if (!roots.any((root) => p.equals(root, legacyPublicMusicDir))) {
          roots.add(legacyPublicMusicDir);
        }

        return roots;
      }

      final appDir = await getApplicationDocumentsDirectory();
      roots.add(p.join(appDir.path, 'echo_downloads'));
      return roots;
    } catch (_) {
      return roots;
    }
  }

  Future<int> getAudioCacheSize() async {
    final dir = await getAudioCacheDir();
    return _getDirectorySize(dir);
  }

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

  Future<void> clearAudioCacheByLibrary(String libraryId) async {
    try {
      final dir = await getAudioCacheDir();
      final safeLibraryId = sanitizeDownloadPathSegment(
        libraryId,
        fallback: 'library',
      );
      final libDir = Directory(p.join(dir.path, safeLibraryId));
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

  Future<int> getImageCacheSize() async {
    try {
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

  Future<void> clearImageCache() async {
    try {
      final appCacheDir = await getApplicationCacheDirectory();
      final imageCacheDir = Directory(
        p.join(appCacheDir.path, 'libCachedImageData'),
      );
      if (await imageCacheDir.exists()) {
        await imageCacheDir.delete(recursive: true);
      }

      PaintingBinding.instance.imageCache.clear();
      PaintingBinding.instance.imageCache.clearLiveImages();
      Logger.infoWithTag(_tag, 'image cache cleared');
    } catch (e) {
      Logger.warnWithTag(_tag, 'failed to clear image cache', e);
    }
  }

  Future<int> getLyricsCacheCount() async {
    try {
      final rows = await _db.select(_db.lyricsCache).get();
      return rows.length;
    } catch (e) {
      Logger.warnWithTag(_tag, 'failed to count lyrics cache', e);
      return 0;
    }
  }

  Future<void> clearLyricsCache() async {
    try {
      await _db.delete(_db.lyricsCache).go();
      Logger.infoWithTag(_tag, 'lyrics cache cleared');
    } catch (e) {
      Logger.warnWithTag(_tag, 'failed to clear lyrics cache', e);
    }
  }

  Future<int> getTotalCacheSize() async {
    return getAudioCacheSize();
  }

  Future<void> clearAll() async {
    await clearAllAudioCache();
  }

  Future<void> clearByLibrary(String libraryId) async {
    await clearAudioCacheByLibrary(libraryId);
  }

  Future<bool> _isManagedAudioFilePath(String filePath) async {
    final cacheDirPath = (await getAudioCacheDir()).path;
    if (isPathWithinRoot(rootDir: cacheDirPath, candidatePath: filePath)) {
      return true;
    }

    final downloadDirPaths = await _getDownloadDirPaths();
    return downloadDirPaths.any(
      (downloadDirPath) =>
          isPathWithinRoot(rootDir: downloadDirPath, candidatePath: filePath),
    );
  }

  Future<int> _getDirectorySize(Directory dir) async {
    if (!await dir.exists()) return 0;

    var totalSize = 0;
    try {
      await for (final entity in dir.list(
        recursive: true,
        followLinks: false,
      )) {
        if (entity is File) {
          try {
            totalSize += await entity.length();
          } catch (_) {
            // Ignore unreadable files while scanning cache size.
          }
        }
      }
    } catch (e) {
      Logger.warnWithTag(_tag, 'error scanning directory: ${dir.path}', e);
    }

    return totalSize;
  }
}
