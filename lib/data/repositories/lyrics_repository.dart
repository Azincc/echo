import 'dart:convert';
import 'package:drift/drift.dart';
import '../../core/utils/logger.dart';
import '../models/lyrics.dart';
import '../models/structured_lyrics.dart';
import '../sources/database/app_database.dart';
import '../sources/lyrics/lyrics_source.dart';

/// 歌词仓库 — 按优先级 Fallback + 本地缓存
class LyricsRepository {
  final List<LyricsSource> _sources;
  final AppDatabase _db;

  LyricsRepository({
    required List<LyricsSource> sources,
    required AppDatabase db,
  }) : _sources = sources,
       _db = db;

  Future<Lyrics?> getLyrics({
    required String songId,
    required String title,
    required String artist,
    String? album,
    Duration? duration,
  }) async {
    final allowExternalLookup = _canUseExternalSources(
      title: title,
      artist: artist,
    );

    // 先查缓存
    var cached = await _getFromCache(songId);
    if (!allowExternalLookup &&
        cached != null &&
        cached.sourceId != 'subsonic') {
      await clearCacheForSong(songId);
      cached = null;
    }

    // 有同步歌词直接返回；非同步缓存尝试刷新一次（可升级为带时间轴版本）
    if (cached != null && cached.hasSynced) return cached;

    // 按优先级逐一查询提供商
    for (final source in _sources) {
      if (!allowExternalLookup && source.id != 'subsonic') {
        continue;
      }
      try {
        final lyrics = await source.fetchLyrics(
          title: title,
          artist: artist,
          album: album,
          duration: duration,
          songId: songId,
        );
        if (lyrics != null && !lyrics.isEmpty) {
          await _saveToCache(songId, lyrics);
          return lyrics;
        }
      } catch (e) {
        Logger.warn('Lyrics source ${source.id} failed: $e');
      }
    }

    // 所有源都失败时，回退到旧缓存（即便是非同步）
    if (!allowExternalLookup &&
        cached != null &&
        cached.sourceId != 'subsonic') {
      return null;
    }
    return cached;
  }

  bool _canUseExternalSources({required String title, required String artist}) {
    if (_isUnknownArtist(artist)) return false;
    if (_looksLikePathTitle(title)) return false;
    return true;
  }

  bool _isUnknownArtist(String artist) {
    final normalized = artist.trim().toLowerCase();
    if (normalized.isEmpty) return true;
    return normalized == 'unknown artist' ||
        normalized == '[unknown artist]' ||
        normalized == '[unknown]';
  }

  bool _looksLikePathTitle(String title) {
    final normalized = title.trim().toLowerCase();
    if (normalized.isEmpty) return true;
    final slashCount =
        '/'.allMatches(normalized).length + '\\'.allMatches(normalized).length;
    if (slashCount >= 2) return true;
    if (normalized.contains('cdimage')) return true;
    return false;
  }

  Future<Lyrics?> _getFromCache(String songId) async {
    try {
      final row = await (_db.select(
        _db.lyricsCache,
      )..where((t) => t.songId.equals(songId))).getSingleOrNull();

      if (row == null) return null;

      final entriesJson = jsonDecode(row.content) as List;
      final entries = entriesJson
          .map((e) => StructuredLyrics.fromJson(e as Map<String, dynamic>))
          .toList();

      return Lyrics(sourceId: row.sourceId, entries: entries);
    } catch (e) {
      Logger.warn('Lyrics cache read failed', e);
      return null;
    }
  }

  Future<void> _saveToCache(String songId, Lyrics lyrics) async {
    try {
      final content = jsonEncode(
        lyrics.entries.map((e) => e.toJson()).toList(),
      );

      final languages = lyrics.entries
          .map((e) => e.lang)
          .where((l) => l != null)
          .join(',');

      await _db
          .into(_db.lyricsCache)
          .insertOnConflictUpdate(
            LyricsCacheCompanion.insert(
              songId: songId,
              sourceId: lyrics.sourceId,
              content: content,
              hasSynced: Value(lyrics.hasSynced),
              languages: Value(languages.isEmpty ? null : languages),
              fetchedAt: DateTime.now().millisecondsSinceEpoch,
            ),
          );
    } catch (e) {
      Logger.warn('Lyrics cache write failed', e);
    }
  }

  Future<void> clearCache() async {
    await _db.delete(_db.lyricsCache).go();
  }

  Future<void> clearCacheForSong(String songId) async {
    await (_db.delete(
      _db.lyricsCache,
    )..where((t) => t.songId.equals(songId))).go();
  }
}
