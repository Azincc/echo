import '../../data/models/structured_lyrics.dart';

/// OpenSubsonic 结构化歌词 JSON 解析器
class StructuredLyricsParser {
  /// 从 getLyricsBySongId 响应解析
  /// 输入: `response['lyricsList']['structuredLyrics']` (List)
  static List<StructuredLyrics> parse(List<dynamic> json) {
    return json
        .map((e) => StructuredLyrics.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
