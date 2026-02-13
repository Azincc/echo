import 'dart:ui';
import 'structured_lyrics.dart';

/// 统一歌词模型，兼容 OpenSubsonic 结构化歌词和外部 LRC 歌词
class Lyrics {
  final String sourceId;
  final List<StructuredLyrics> entries;

  Lyrics({required this.sourceId, required this.entries});

  /// 获取最佳歌词（优先同步、优先用户语言）
  StructuredLyrics? getBest({String? preferredLang}) {
    if (entries.isEmpty) return null;

    // 优先同步歌词
    final synced = entries.where((e) => e.synced).toList();
    final unsynced = entries.where((e) => !e.synced).toList();

    final candidates = synced.isNotEmpty ? synced : unsynced;
    if (candidates.isEmpty) return entries.first;

    if (preferredLang != null) {
      final langMatch = candidates.where((e) => e.lang == preferredLang);
      if (langMatch.isNotEmpty) return langMatch.first;
    }

    // 获取系统语言作为 fallback
    final systemLang = PlatformDispatcher.instance.locale.languageCode;
    final sysMatch = candidates.where((e) => e.lang == systemLang);
    if (sysMatch.isNotEmpty) return sysMatch.first;

    return candidates.first;
  }

  bool get hasSynced => entries.any((e) => e.synced);
  bool get isEmpty => entries.isEmpty;
}
