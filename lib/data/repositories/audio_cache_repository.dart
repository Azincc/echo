import 'package:drift/drift.dart';
import '../../data/models/audio_quality.dart';
import '../sources/database/app_database.dart';

/// 音频缓存条目模型（从 Drift 行转换）
class AudioCacheEntry {
  final String id;
  final String libraryId;
  final String songId;
  final AudioQualityLevel quality;
  final String filePath;
  final int fileSize;
  final int playCount;
  final int? lastPlayedAt;
  final int cachedAt;
  final bool isComplete;

  AudioCacheEntry({
    required this.id,
    required this.libraryId,
    required this.songId,
    required this.quality,
    required this.filePath,
    required this.fileSize,
    this.playCount = 0,
    this.lastPlayedAt,
    required this.cachedAt,
    this.isComplete = false,
  });
}

/// 缓存元数据仓库（Drift CRUD）
class AudioCacheRepository {
  final AppDatabase _db;

  AudioCacheRepository(this._db);

  /// 查询缓存条目
  Future<AudioCacheEntry?> getCacheEntry({
    required String songId,
    required String libraryId,
    required AudioQualityLevel quality,
  }) async {
    final row =
        await (_db.select(_db.audioCacheEntries)..where(
              (t) =>
                  t.songId.equals(songId) &
                  t.libraryId.equals(libraryId) &
                  t.quality.equals(quality.name),
            ))
            .getSingleOrNull();
    return row != null ? _rowToEntry(row) : null;
  }

  /// 查询歌曲的任意完整缓存（不限音质，返回最高音质的）
  Future<AudioCacheEntry?> getAnyCacheEntry({
    required String songId,
    required String libraryId,
  }) async {
    final rows =
        await (_db.select(_db.audioCacheEntries)..where(
              (t) =>
                  t.songId.equals(songId) &
                  t.libraryId.equals(libraryId) &
                  t.isComplete.equals(true),
            ))
            .get();

    if (rows.isEmpty) return null;

    // 返回最高音质的缓存
    final entries = rows.map(_rowToEntry).toList();
    entries.sort((a, b) => b.quality.rank.compareTo(a.quality.rank));
    return entries.first;
  }

  /// 注册新的缓存条目
  Future<void> registerCache(AudioCacheEntry entry) async {
    await _db
        .into(_db.audioCacheEntries)
        .insertOnConflictUpdate(
          AudioCacheEntriesCompanion.insert(
            id: entry.id,
            libraryId: entry.libraryId,
            songId: entry.songId,
            quality: entry.quality.name,
            filePath: entry.filePath,
            fileSize: entry.fileSize,
            playCount: Value(entry.playCount),
            lastPlayedAt: Value(entry.lastPlayedAt),
            cachedAt: entry.cachedAt,
            isComplete: Value(entry.isComplete),
          ),
        );
  }

  /// 更新播放计数和最后播放时间
  Future<void> updatePlayStats(String entryId) async {
    // 先获取当前 playCount
    final row = await (_db.select(
      _db.audioCacheEntries,
    )..where((t) => t.id.equals(entryId))).getSingleOrNull();

    if (row == null) return;

    await (_db.update(
      _db.audioCacheEntries,
    )..where((t) => t.id.equals(entryId))).write(
      AudioCacheEntriesCompanion(
        playCount: Value(row.playCount + 1),
        lastPlayedAt: Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );
  }

  /// 标记缓存为完整
  Future<void> markComplete(String entryId) async {
    await (_db.update(_db.audioCacheEntries)
          ..where((t) => t.id.equals(entryId)))
        .write(const AudioCacheEntriesCompanion(isComplete: Value(true)));
  }

  /// 获取按淘汰分数排序的非保护条目
  Future<List<AudioCacheEntry>> getEvictablEntries({
    required int protectionThreshold,
  }) async {
    final rows =
        await (_db.select(_db.audioCacheEntries)..where(
              (t) =>
                  t.playCount.isSmallerThanValue(protectionThreshold) &
                  t.isComplete.equals(true),
            ))
            .get();

    final entries = rows.map(_rowToEntry).toList();

    // 计算淘汰分数并排序（分数低的先淘汰）
    final now = DateTime.now().millisecondsSinceEpoch;
    const maxAge = 30 * 24 * 60 * 60 * 1000; // 30 天（毫秒）

    entries.sort((a, b) {
      final scoreA = _evictionScore(a, now, maxAge);
      final scoreB = _evictionScore(b, now, maxAge);
      return scoreA.compareTo(scoreB);
    });

    return entries;
  }

  double _evictionScore(AudioCacheEntry entry, int now, int maxAge) {
    final recencyScore = entry.lastPlayedAt != null
        ? 1.0 - ((now - entry.lastPlayedAt!) / maxAge).clamp(0.0, 1.0)
        : 0.0;
    return (entry.playCount * 0.6) + (recencyScore * 0.4);
  }

  /// 获取缓存总大小
  Future<int> getTotalCacheSize() async {
    final rows = await _db.select(_db.audioCacheEntries).get();
    return rows.fold<int>(0, (sum, row) => sum + row.fileSize);
  }

  /// 删除缓存条目
  Future<void> deleteEntry(String entryId) async {
    await (_db.delete(
      _db.audioCacheEntries,
    )..where((t) => t.id.equals(entryId))).go();
  }

  /// 清除所有缓存条目
  Future<void> clearAll() async {
    await _db.delete(_db.audioCacheEntries).go();
  }

  /// 清除指定音乐库的缓存
  Future<void> clearByLibrary(String libraryId) async {
    await (_db.delete(
      _db.audioCacheEntries,
    )..where((t) => t.libraryId.equals(libraryId))).go();
  }

  /// 获取所有缓存条目
  Future<List<AudioCacheEntry>> getAllEntries() async {
    final rows = await _db.select(_db.audioCacheEntries).get();
    return rows.map(_rowToEntry).toList();
  }

  AudioCacheEntry _rowToEntry(AudioCacheEntryData row) {
    return AudioCacheEntry(
      id: row.id,
      libraryId: row.libraryId,
      songId: row.songId,
      quality: AudioQualityLevelExt.fromString(row.quality),
      filePath: row.filePath,
      fileSize: row.fileSize,
      playCount: row.playCount,
      lastPlayedAt: row.lastPlayedAt,
      cachedAt: row.cachedAt,
      isComplete: row.isComplete,
    );
  }
}
