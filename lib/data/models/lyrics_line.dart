/// 单行歌词
class LyricsLine {
  final int? startMs;
  final String value;

  LyricsLine({this.startMs, required this.value});

  factory LyricsLine.fromJson(Map<String, dynamic> json) {
    return LyricsLine(
      startMs: json['start'] as int?,
      value: json['value'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {if (startMs != null) 'start': startMs, 'value': value};
  }
}
