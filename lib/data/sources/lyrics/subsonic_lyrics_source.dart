import '../../../core/constants/api_constants.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/structured_lyrics_parser.dart';
import '../../models/lyrics.dart';
import '../../models/lyrics_line.dart';
import '../../models/structured_lyrics.dart';
import '../subsonic_api_client.dart';
import 'lyrics_source.dart';

/// 服务端歌词源（OpenSubsonic / 传统 Subsonic）
class SubsonicLyricsSource implements LyricsSource {
  final SubsonicApiClient _apiClient;
  final List<String> _extensions;

  SubsonicLyricsSource(this._apiClient, this._extensions);

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
    if (_extensions.contains('songLyrics') && songId != null) {
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
          final lines = value
              .split('\n')
              .map((line) => LyricsLine(value: line))
              .toList();
          return Lyrics(
            sourceId: id,
            entries: [StructuredLyrics(synced: false, lines: lines)],
          );
        }
      }
    } catch (e) {
      Logger.warn('Legacy getLyrics failed', e);
    }

    return null;
  }
}
