import 'package:dio/dio.dart';
import '../../../core/utils/lrc_parser.dart';
import '../../../core/utils/logger.dart';
import '../../models/lyrics.dart';
import 'lyrics_source.dart';

/// LRCLIB 公共歌词 API
class LrclibLyricsSource implements LyricsSource {
  final Dio _dio;

  LrclibLyricsSource([Dio? dio])
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: 'https://lrclib.net',
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ),
          );

  @override
  String get id => 'lrclib';

  @override
  String get displayName => 'LRCLIB';

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
      final params = <String, dynamic>{
        'track_name': title,
        'artist_name': artist,
      };
      if (album != null) params['album_name'] = album;
      if (duration != null) params['duration'] = duration.inSeconds;

      final response = await _dio.get('/api/get', queryParameters: params);

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as Map<String, dynamic>;

        // 优先使用同步歌词
        final syncedLyrics = data['syncedLyrics'] as String?;
        if (syncedLyrics != null && syncedLyrics.isNotEmpty) {
          final parsed = LrcParser.parse(syncedLyrics);
          return Lyrics(sourceId: id, entries: [parsed]);
        }

        // 回退到纯文本歌词
        final plainLyrics = data['plainLyrics'] as String?;
        if (plainLyrics != null && plainLyrics.isNotEmpty) {
          final parsed = LrcParser.parse(plainLyrics);
          return Lyrics(sourceId: id, entries: [parsed]);
        }
      }
    } catch (e) {
      Logger.warn('LRCLIB lyrics fetch failed', e);
    }

    return null;
  }
}
