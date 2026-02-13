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
      final searchData = searchResponse.data as Map<String, dynamic>;
      final result = searchData['result'] as Map<String, dynamic>?;
      final songs = result?['songs'] as List?;
      if (songs == null || songs.isEmpty) return null;

      // 取第一个匹配结果
      final neteaseId = songs[0]['id'];

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
      final lyricData = lyricResponse.data as Map<String, dynamic>;

      final lrc = lyricData['lrc'] as Map<String, dynamic>?;
      final lyricText = lrc?['lyric'] as String?;
      if (lyricText == null || lyricText.isEmpty) return null;

      final parsed = LrcParser.parse(lyricText);
      final entries = [parsed];

      // 尝试获取翻译歌词
      final tlyric = lyricData['tlyric'] as Map<String, dynamic>?;
      final translationText = tlyric?['lyric'] as String?;
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
}
