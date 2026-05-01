import '../../data/models/audio_quality.dart';
import '../../data/repositories/audio_cache_repository.dart';
import '../../data/sources/database/app_database.dart';

class AudioCacheService {
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

  Future<String?> getCachedPath({
    required String songId,
    required String libraryId,
    required AudioQualityLevel quality,
  }) async {
    return null;
  }

  Future<void> registerCache({
    required String songId,
    required String libraryId,
    required String filePath,
    required int fileSize,
    required AudioQualityLevel quality,
  }) async {}

  Future<String> getCacheFilePath({
    required String songId,
    required String libraryId,
    required AudioQualityLevel quality,
  }) async {
    return '/web-cache/$libraryId/${quality.name}/$songId';
  }

  Future<void> evictIfNeeded({Set<String>? activeSongIds}) async {}

  Future<int> getAudioCacheSize() async => 0;

  Future<void> clearAllAudioCache() async {
    await _repository.clearAll();
  }

  Future<void> clearAudioCacheByLibrary(String libraryId) async {
    await _repository.clearByLibrary(libraryId);
  }

  Future<int> getImageCacheSize() async => 0;

  Future<void> clearImageCache() async {}

  Future<int> getLyricsCacheCount() async {
    final rows = await _db.select(_db.lyricsCache).get();
    return rows.length;
  }

  Future<void> clearLyricsCache() async {
    await _db.delete(_db.lyricsCache).go();
  }

  Future<int> getTotalCacheSize() async => 0;

  Future<void> clearAll() async {
    await clearAllAudioCache();
  }

  Future<void> clearByLibrary(String libraryId) async {
    await clearAudioCacheByLibrary(libraryId);
  }
}
