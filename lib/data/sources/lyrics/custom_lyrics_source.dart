import 'package:dio/dio.dart';
import '../../../core/utils/lrc_parser.dart';
import '../../../core/utils/logger.dart';
import '../../models/lyrics.dart';
import 'lyrics_source.dart';

/// 用户自定义歌词 API 源
class CustomLyricsSource implements LyricsSource {
  final Dio _dio;
  final String _urlTemplate;

  CustomLyricsSource({required String urlTemplate, Dio? dio})
    : _urlTemplate = urlTemplate,
      _dio =
          dio ??
          Dio(
            BaseOptions(
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ),
          );

  @override
  String get id => 'custom';

  @override
  String get displayName => '自定义源';

  @override
  bool get requiresConfig => true;

  @override
  Future<Lyrics?> fetchLyrics({
    required String title,
    required String artist,
    String? album,
    Duration? duration,
    String? songId,
  }) async {
    if (_urlTemplate.isEmpty) return null;

    try {
      final url = _urlTemplate
          .replaceAll('{title}', Uri.encodeComponent(title))
          .replaceAll('{artist}', Uri.encodeComponent(artist))
          .replaceAll('{album}', Uri.encodeComponent(album ?? ''));

      final response = await _dio.get(url);

      if (response.statusCode == 200 && response.data != null) {
        final content = response.data.toString();
        if (content.isNotEmpty) {
          final parsed = LrcParser.parse(content);
          return Lyrics(sourceId: id, entries: [parsed]);
        }
      }
    } catch (e) {
      Logger.warn('Custom lyrics source failed', e);
    }

    return null;
  }
}
