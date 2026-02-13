import 'lyrics_line.dart';

/// 一组歌词（对应 OpenSubsonic 的 structuredLyrics 中的一个条目）
class StructuredLyrics {
  final String? displayArtist;
  final String? displayTitle;
  final String? lang;
  final int offsetMs;
  final bool synced;
  final List<LyricsLine> lines;

  StructuredLyrics({
    this.displayArtist,
    this.displayTitle,
    this.lang,
    this.offsetMs = 0,
    required this.synced,
    required this.lines,
  });

  factory StructuredLyrics.fromJson(Map<String, dynamic> json) {
    final lineList =
        (json['line'] as List?)
            ?.map((e) => LyricsLine.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
    return StructuredLyrics(
      displayArtist: json['displayArtist'] as String?,
      displayTitle: json['displayTitle'] as String?,
      lang: json['lang'] as String?,
      offsetMs: json['offset'] as int? ?? 0,
      synced: json['synced'] as bool? ?? false,
      lines: lineList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (displayArtist != null) 'displayArtist': displayArtist,
      if (displayTitle != null) 'displayTitle': displayTitle,
      if (lang != null) 'lang': lang,
      'offset': offsetMs,
      'synced': synced,
      'line': lines.map((l) => l.toJson()).toList(),
    };
  }
}
