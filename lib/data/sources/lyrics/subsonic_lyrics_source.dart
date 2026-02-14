import '../../../core/constants/api_constants.dart';
import '../../../core/utils/lrc_parser.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/structured_lyrics_parser.dart';
import '../../models/lyrics.dart';
import '../subsonic_api_client.dart';
import 'lyrics_source.dart';

/// 服务端歌词源（OpenSubsonic / 传统 Subsonic）
class SubsonicLyricsSource implements LyricsSource {
  final SubsonicApiClient _apiClient;
  final Set<String> _extensions;

  SubsonicLyricsSource(this._apiClient, [List<String> extensions = const []])
    : _extensions = extensions.toSet();

  @override
  String get id => 'subsonic';

  @override
  String get displayName => '服务端';

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
    // 优先尝试 OpenSubsonic getLyricsBySongId
    // 兼容旧库扩展信息缺失：扩展列表为空时也尝试一次。
    final canTryBySongId =
        songId != null &&
        (_extensions.isEmpty || _extensions.contains('songLyrics'));
    if (canTryBySongId) {
      try {
        final response = await _apiClient.get(
          ApiConstants.getLyricsBySongId,
          queryParameters: {'id': songId},
        );

        final lyricsList = response['lyricsList'];
        if (lyricsList != null) {
          final structured = lyricsList['structuredLyrics'] as List?;
          if (structured != null && structured.isNotEmpty) {
            final entries = StructuredLyricsParser.parse(structured);
            return Lyrics(sourceId: id, entries: entries);
          }
        }
      } catch (e) {
        Logger.warn('getLyricsBySongId failed, trying legacy getLyrics', e);
      }
    }

    // 回退到传统 getLyrics
    try {
      final response = await _apiClient.get(
        ApiConstants.getLyrics,
        queryParameters: {'artist': artist, 'title': title},
      );

      final lyricsData = response['lyrics'];
      if (lyricsData != null) {
        final value = lyricsData['value'] as String?;
        if (value != null && value.isNotEmpty) {
          final parsed = LrcParser.parse(value);
          return Lyrics(sourceId: id, entries: [parsed]);
        }
      }
    } catch (e) {
      Logger.warn('Legacy getLyrics failed', e);
    }

    return null;
  }
}
