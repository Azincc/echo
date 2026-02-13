import 'package:dio/dio.dart';
import '../../../core/utils/logger.dart';
import 'cover_source.dart';

/// 用户自定义封面 API 源
class CustomCoverSource implements CoverSource {
  final Dio _dio;
  final String _urlTemplate;

  CustomCoverSource({required String urlTemplate, Dio? dio})
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
  Future<String?> fetchCoverUrl({
    required String artist,
    String? album,
    String? musicBrainzId,
    String? coverArtId,
    int? size,
  }) async {
    if (_urlTemplate.isEmpty) return null;

    try {
      final url = _urlTemplate
          .replaceAll('{artist}', Uri.encodeComponent(artist))
          .replaceAll('{album}', Uri.encodeComponent(album ?? ''))
          .replaceAll('{mbid}', Uri.encodeComponent(musicBrainzId ?? ''));

      final response = await _dio.head(url);
      if (response.statusCode == 200) {
        return url;
      }
    } catch (e) {
      Logger.warn('Custom cover source failed', e);
    }

    return null;
  }
}
