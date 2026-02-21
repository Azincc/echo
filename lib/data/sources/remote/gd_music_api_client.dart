import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../core/utils/logger.dart';
import '../../models/song.dart';

class GdSongUrlResult {
  final String url;
  final int? bitRateKbps;
  final int? sizeBytes;
  final String? suffix;
  final Map<String, String> requiredHeaders;

  const GdSongUrlResult({
    required this.url,
    this.bitRateKbps,
    this.sizeBytes,
    this.suffix,
    this.requiredHeaders = const {},
  });

  String get qualityLabel {
    if (bitRateKbps == null || bitRateKbps! <= 0) return '未知音质';
    return '${bitRateKbps}kbps';
  }
}

class GdLyricResult {
  final String lyric;
  final String? translation;

  const GdLyricResult({required this.lyric, this.translation});
}

class GdMusicApiClient {
  static const _logTag = 'GD_API';
  final Dio _dio;

  GdMusicApiClient([Dio? dio])
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: 'https://music-api.gdstudio.xyz',
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 15),
              responseType: ResponseType.json,
            ),
          );

  Future<List<Song>> searchSongs({
    required String keyword,
    String source = 'netease',
    int count = 20,
    int page = 1,
  }) async {
    final q = keyword.trim();
    if (q.isEmpty) return const [];
    final requestSource = source.trim().isEmpty ? 'netease' : source.trim();
    Logger.infoWithTag(
      _logTag,
      'search start source=$requestSource page=$page count=$count keyword="$q"',
    );

    final response = await _dio.get(
      '/api.php',
      queryParameters: {
        'types': 'search',
        'source': requestSource,
        'name': q,
        'count': count,
        'pages': page,
      },
    );

    final data = response.data;
    if (data is! List) {
      Logger.warnWithTag(
        _logTag,
        'search unexpected response type=${data.runtimeType}',
      );
      return const [];
    }

    final songs = data
        .whereType<Map>()
        .map((raw) {
          final map = raw.cast<String, dynamic>();
          final trackId = (map['id'] ?? '').toString().trim();
          if (trackId.isEmpty) return null;

          final lyricId = (map['lyric_id'] ?? map['id'] ?? '')
              .toString()
              .trim();
          final picId = (map['pic_id'] ?? '').toString().trim();
          final title = (map['name'] ?? '').toString().trim();
          final artist = _parseArtist(map['artist']);
          final album = (map['album'] ?? '').toString();
          final responseSource = (map['source'] ?? '').toString().trim();
          final normalizedSource = _normalizeSource(
            responseSource.isEmpty ? requestSource : responseSource,
          );

          return Song(
            id: 'gd_${normalizedSource}_$trackId',
            title: title.isEmpty ? '未知歌曲' : title,
            artist: artist,
            album: album.isEmpty ? null : album,
            isPreview: true,
            previewSource: normalizedSource,
            previewTrackId: trackId,
            previewLyricId: lyricId.isEmpty ? null : lyricId,
            previewPicId: picId.isEmpty ? null : picId,
          );
        })
        .whereType<Song>()
        .toList();

    Logger.infoWithTag(
      _logTag,
      'search done source=$requestSource page=$page result=${songs.length}',
    );
    return songs;
  }

  Future<GdSongUrlResult> resolveSongUrl({
    required String source,
    required String trackId,
    int? br,
  }) async {
    final sourceCandidates = _sourceCandidates(source);
    Logger.debugWithTag(
      _logTag,
      'resolveSongUrl track=$trackId source=$source candidates=$sourceCandidates',
    );

    Object? lastError;
    for (final candidate in sourceCandidates) {
      try {
        final response = await _dio.get(
          '/api.php',
          queryParameters: {
            'types': 'url',
            'source': candidate,
            'id': trackId,
            if (br != null) 'br': br,
          },
        );

        final map = _asMap(response.data);
        final rawUrl = _sanitizeUrl((map?['url'] ?? '').toString());
        if (rawUrl.isEmpty) {
          Logger.warnWithTag(
            _logTag,
            'resolveSongUrl empty url track=$trackId source=$candidate',
          );
          continue;
        }

        final brValue = _toInt(map?['br']);
        final size = _toInt(map?['size']);
        final suffix = _extractSuffix(rawUrl);

        Logger.infoWithTag(
          _logTag,
          'resolveSongUrl ok track=$trackId source=$candidate suffix=${suffix ?? "-"} br=${brValue ?? 0}',
        );
        return GdSongUrlResult(
          url: rawUrl,
          bitRateKbps: brValue,
          sizeBytes: size,
          suffix: suffix,
          requiredHeaders: _requiredHeadersForSource(candidate),
        );
      } catch (e) {
        lastError = e;
        Logger.warnWithTag(
          _logTag,
          'resolveSongUrl failed track=$trackId source=$candidate',
          e,
        );
      }
    }

    if (lastError != null) {
      throw Exception('无法解析试听链接: $lastError');
    }
    throw Exception('无法解析试听链接');
  }

  Future<String?> resolveCoverUrl({
    required String source,
    required String picId,
  }) async {
    if (picId.trim().isEmpty) return null;
    for (final candidate in _sourceCandidates(source)) {
      try {
        final response = await _dio.get(
          '/api.php',
          queryParameters: {'types': 'pic', 'source': candidate, 'id': picId},
        );
        final map = _asMap(response.data);
        final rawUrl = _sanitizeUrl((map?['url'] ?? '').toString());
        if (rawUrl.isNotEmpty) {
          return rawUrl;
        }
      } catch (_) {}
    }
    return null;
  }

  Future<GdLyricResult?> fetchLyrics({
    required String source,
    required String lyricId,
  }) async {
    if (lyricId.trim().isEmpty) return null;
    for (final candidate in _sourceCandidates(source)) {
      try {
        final response = await _dio.get(
          '/api.php',
          queryParameters: {
            'types': 'lyric',
            'source': candidate,
            'id': lyricId,
          },
        );

        final map = _asMap(response.data);
        final lyric = (map?['lyric'] ?? '').toString();
        if (lyric.trim().isEmpty) continue;

        final tlyricRaw = (map?['tlyric'] ?? '').toString().trim();
        return GdLyricResult(
          lyric: lyric,
          translation: tlyricRaw.isEmpty ? null : tlyricRaw,
        );
      } catch (_) {}
    }
    return null;
  }

  Map<String, String> _requiredHeadersForSource(String source) {
    final normalized = _normalizeSource(source);
    const defaultUa =
        'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) '
        'AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile Safari/604.1';

    if (normalized == 'bilibili') {
      return const {
        'Referer': 'https://www.bilibili.com',
        'User-Agent': defaultUa,
      };
    }
    if (normalized == 'netease') {
      return const {
        'Referer': 'https://music.163.com/',
        'User-Agent': defaultUa,
      };
    }
    if (normalized == 'kuwo') {
      return const {'Referer': 'https://www.kuwo.cn/', 'User-Agent': defaultUa};
    }
    if (normalized == 'joox') {
      return const {'Referer': 'https://y.qq.com/', 'User-Agent': defaultUa};
    }
    return const {};
  }

  List<String> _sourceCandidates(String source) {
    final raw = source.trim().toLowerCase();
    final normalized = _normalizeSource(raw);
    if (raw.isEmpty) return const ['netease'];
    if (normalized == raw) return [raw];
    return [normalized, raw];
  }

  String _normalizeSource(String source) {
    final s = source.trim().toLowerCase();
    if (s.endsWith('_album')) {
      return s.substring(0, s.length - '_album'.length);
    }
    if (s.endsWith('_artist')) {
      return s.substring(0, s.length - '_artist'.length);
    }
    return s;
  }

  String _parseArtist(dynamic raw) {
    if (raw is List) {
      final names = raw
          .map((e) => e.toString().trim())
          .where((e) => e.isNotEmpty);
      final merged = names.join(' / ');
      return merged.isEmpty ? '未知歌手' : merged;
    }
    final text = (raw ?? '').toString().trim();
    return text.isEmpty ? '未知歌手' : text;
  }

  int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }

  Map<String, dynamic>? _asMap(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is Map) {
      return data.cast<String, dynamic>();
    }
    if (data is String) {
      final decoded = jsonDecode(data);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return decoded.cast<String, dynamic>();
    }
    return null;
  }

  String _sanitizeUrl(String raw) {
    if (raw.isEmpty) return '';
    return raw
        .replaceAll('&amp;', '&')
        .replaceAll('&quot;', '"')
        .replaceAll('&#x27;', "'")
        .trim();
  }

  String? _extractSuffix(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;
    final segments = uri.pathSegments;
    if (segments.isEmpty) return null;
    final last = segments.last;
    final dot = last.lastIndexOf('.');
    if (dot <= 0 || dot >= last.length - 1) return null;
    return last.substring(dot + 1).toLowerCase();
  }
}
