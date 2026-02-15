import 'dart:convert';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import '../../../core/utils/lrc_parser.dart';
import '../../../core/utils/logger.dart';
import '../../models/lyrics.dart';
import 'lyrics_source.dart';

/// 网易云音乐歌词源
class NeteaseLyricsSource implements LyricsSource {
  final Dio _dio;

  NeteaseLyricsSource([Dio? dio])
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ),
          );

  @override
  String get id => 'netease';

  @override
  String get displayName => '网易云音乐';

  @override
  bool get requiresConfig => false;

  @override
  Future<Lyrics?> fetchLyrics({
    required String title,
    required String artist,
    String? album,
    Duration? duration,
    String? songId,
  }) async {
    try {
      if (!_canSearch(title: title, artist: artist)) {
        return null;
      }

      final normalizedTitle = _normalizeForMatch(title);
      final normalizedArtist = _normalizeForMatch(artist);

      // Step 1: 搜索歌曲获取网易云 ID
      final searchResponse = await _dio.get(
        'https://music.163.com/api/search/get',
        queryParameters: {
          's': '$title $artist',
          'type': 1,
          'limit': 5,
          'offset': 0,
        },
        options: Options(
          headers: {
            'Referer': 'https://music.163.com',
            'User-Agent': 'Mozilla/5.0',
          },
        ),
      );

      if (searchResponse.data == null) return null;
      final searchData = _asMap(searchResponse.data);
      if (searchData == null) return null;
      final result = _asMap(searchData['result']);
      final songs = result?['songs'] as List?;
      if (songs == null || songs.isEmpty) return null;

      final matchedSong = _pickBestMatch(
        songs: songs,
        queryTitle: normalizedTitle,
        queryArtist: normalizedArtist,
        expectedDuration: duration,
      );
      final neteaseId = matchedSong?['id']?.toString();
      if (neteaseId == null || neteaseId.isEmpty) return null;

      // Step 2: 获取歌词
      final lyricResponse = await _dio.get(
        'https://music.163.com/api/song/lyric',
        queryParameters: {'id': neteaseId, 'lv': -1, 'tv': -1},
        options: Options(
          headers: {
            'Referer': 'https://music.163.com',
            'User-Agent': 'Mozilla/5.0',
          },
        ),
      );

      if (lyricResponse.data == null) return null;
      final lyricData = _asMap(lyricResponse.data);
      if (lyricData == null) return null;

      final lyricText = _extractLyricText(lyricData['lrc']);
      if (lyricText == null || lyricText.isEmpty) return null;

      final parsed = LrcParser.parse(lyricText);
      final entries = [parsed];

      // 尝试获取翻译歌词
      final translationText = _extractLyricText(lyricData['tlyric']);
      if (translationText != null && translationText.isNotEmpty) {
        final translationParsed = LrcParser.parse(translationText);
        entries.add(translationParsed);
      }

      return Lyrics(sourceId: id, entries: entries);
    } catch (e) {
      Logger.warn('Netease lyrics fetch failed', e);
    }

    return null;
  }

  bool _canSearch({required String title, required String artist}) {
    if (_isUnknownArtist(artist)) return false;
    if (_looksLikePathTitle(title)) return false;
    return title.trim().isNotEmpty;
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
    if (RegExp(r'\.(ape|flac|wav|mp3|m4a)$').hasMatch(normalized)) {
      return true;
    }
    return false;
  }

  String _normalizeForMatch(String value) {
    var text = value.toLowerCase().trim();
    text = text.replaceAll(RegExp(r'\(.*?\)|\[.*?\]|\{.*?\}'), ' ');
    text = text.replaceAll(RegExp(r'[\\/_\-\.,:;!~@#$%^&*+=?|<>]'), ' ');
    text = text.replaceAll(RegExp(r'\s+'), ' ').trim();
    return text;
  }

  Map<String, dynamic>? _pickBestMatch({
    required List songs,
    required String queryTitle,
    required String queryArtist,
    Duration? expectedDuration,
  }) {
    double bestScore = 0;
    Map<String, dynamic>? bestSong;

    for (final rawSong in songs) {
      final song = _asMap(rawSong);
      if (song == null) continue;

      final songTitle = _normalizeForMatch(
        song['name']?.toString() ?? song['title']?.toString() ?? '',
      );
      if (songTitle.isEmpty) continue;

      final titleScore = _similarity(queryTitle, songTitle);
      if (titleScore < 0.6) continue;

      final artistNames = _extractArtistNames(song);
      if (artistNames.isEmpty) continue;
      final artistScore = artistNames
          .map((name) => _similarity(queryArtist, _normalizeForMatch(name)))
          .fold<double>(0, math.max);
      if (artistScore < 0.55) continue;

      final durationScore = _durationScore(
        expectedDuration: expectedDuration,
        song: song,
      );
      if (expectedDuration != null && durationScore == 0) continue;

      final score =
          titleScore * 0.65 + artistScore * 0.25 + durationScore * 0.1;
      if (score > bestScore) {
        bestScore = score;
        bestSong = song;
      }
    }

    if (bestSong == null) return null;
    if (bestScore < 0.7) return null;
    return bestSong;
  }

  List<String> _extractArtistNames(Map<String, dynamic> song) {
    final names = <String>[];

    void appendFromList(dynamic value) {
      if (value is! List) return;
      for (final item in value) {
        final map = _asMap(item);
        final name = map?['name']?.toString().trim();
        if (name != null && name.isNotEmpty) {
          names.add(name);
        }
      }
    }

    appendFromList(song['artists']);
    appendFromList(song['ar']);

    final singleArtist = song['artist']?.toString().trim();
    if (singleArtist != null && singleArtist.isNotEmpty) {
      names.add(singleArtist);
    }

    return names;
  }

  double _durationScore({
    required Duration? expectedDuration,
    required Map<String, dynamic> song,
  }) {
    if (expectedDuration == null) return 0.5;

    final songDurationSeconds = _extractSongDurationSeconds(song);
    if (songDurationSeconds == null) return 0.2;

    final diff = (expectedDuration.inSeconds - songDurationSeconds).abs();
    if (diff <= 8) return 1;
    if (diff <= 20) return 0.8;
    if (diff <= 45) return 0.5;
    if (diff <= 90) return 0.2;
    return 0;
  }

  int? _extractSongDurationSeconds(Map<String, dynamic> song) {
    final raw = song['duration'] ?? song['dt'] ?? song['length'];
    final numeric = raw is num
        ? raw.toInt()
        : int.tryParse(raw?.toString() ?? '');
    if (numeric == null || numeric <= 0) return null;

    // 网易云搜索接口常见字段是毫秒（通常 > 10000）
    if (numeric > 10000) {
      return numeric ~/ 1000;
    }
    return numeric;
  }

  double _similarity(String a, String b) {
    if (a.isEmpty || b.isEmpty) return 0;
    if (a == b) return 1;
    if (a.contains(b) || b.contains(a)) {
      final shortLen = math.min(a.length, b.length);
      final longLen = math.max(a.length, b.length);
      return shortLen / longLen;
    }

    final aTokens = a.split(' ').where((t) => t.isNotEmpty).toSet();
    final bTokens = b.split(' ').where((t) => t.isNotEmpty).toSet();
    if (aTokens.isEmpty || bTokens.isEmpty) return 0;

    final intersection = aTokens.intersection(bTokens).length.toDouble();
    final union = aTokens.union(bTokens).length.toDouble();
    return union == 0 ? 0 : intersection / union;
  }

  Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    if (value is String) {
      final trimmed = value.trim();
      if (trimmed.isEmpty) return null;
      try {
        final decoded = jsonDecode(trimmed);
        if (decoded is Map) return Map<String, dynamic>.from(decoded);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  String? _extractLyricText(dynamic section) {
    final sectionMap = _asMap(section);
    if (sectionMap != null) {
      final lyric = sectionMap['lyric'];
      if (lyric is String) return lyric;
      return lyric?.toString();
    }
    if (section is String) return section;
    return null;
  }
}
