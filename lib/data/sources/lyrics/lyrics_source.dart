import '../../models/lyrics.dart';

/// 歌词数据源抽象接口
abstract class LyricsSource {
  String get id;
  String get displayName;
  bool get requiresConfig;

  Future<Lyrics?> fetchLyrics({
    required String title,
    required String artist,
    String? album,
    Duration? duration,
    String? songId,
  });
}
