import '../../data/models/lyrics_line.dart';
import '../../data/models/structured_lyrics.dart';

/// LRC 格式解析器（用于 LRCLIB、网易云等外部源）
class LrcParser {
  // [mm:ss.xx] 或 [mm:ss.xxx]
  static final _timeTagRegExp = RegExp(r'\[(\d{1,3}):(\d{2})\.(\d{2,3})\]');

  /// 将 LRC 文本解析为统一的 StructuredLyrics
  static StructuredLyrics parse(String lrcContent) {
    final lines = lrcContent.split('\n');
    final lyricsLines = <LyricsLine>[];
    var hasTags = false;

    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) continue;

      // 跳过元数据标签 [ti:], [ar:], [al:] 等
      if (RegExp(r'^\[[a-z]{2}:').hasMatch(trimmed)) continue;

      final matches = _timeTagRegExp.allMatches(trimmed);
      if (matches.isEmpty) {
        // 无时间戳的纯文本行（非标准但常见）
        if (trimmed.isNotEmpty && !trimmed.startsWith('[')) {
          lyricsLines.add(LyricsLine(value: trimmed));
        }
        continue;
      }

      hasTags = true;

      // 提取歌词文本（移除所有时间戳）
      final text = trimmed.replaceAll(_timeTagRegExp, '').trim();

      // 一行可能有多个时间戳（共享歌词文本）
      for (final match in matches) {
        final minutes = int.parse(match.group(1)!);
        final seconds = int.parse(match.group(2)!);
        final rawMs = match.group(3)!;
        // 处理 2 位和 3 位毫秒
        final milliseconds = rawMs.length == 2
            ? int.parse(rawMs) * 10
            : int.parse(rawMs);

        final totalMs = minutes * 60 * 1000 + seconds * 1000 + milliseconds;

        lyricsLines.add(LyricsLine(startMs: totalMs, value: text));
      }
    }

    // 按时间排序
    if (hasTags) {
      lyricsLines.sort((a, b) => (a.startMs ?? 0).compareTo(b.startMs ?? 0));
    }

    return StructuredLyrics(synced: hasTags, lines: lyricsLines);
  }
}
