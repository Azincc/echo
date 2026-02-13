import 'package:dio/dio.dart';
import '../../../core/utils/logger.dart';
import 'cover_source.dart';

/// MusicBrainz Cover Art Archive 封面源
class MusicbrainzCoverSource implements CoverSource {
  final Dio _dio;

  MusicbrainzCoverSource([Dio? dio])
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: 'https://coverartarchive.org',
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
              followRedirects: true,
            ),
          );

  @override
  String get id => 'musicbrainz';

  @override
  String get displayName => 'MusicBrainz';

  @override
  bool get requiresConfig => false;

  @override
  Future<String?> fetchCoverUrl({
    required String artist,
    String? album,
    String? musicBrainzId,
    String? coverArtId,
    int? size,
  }) async {
    if (musicBrainzId == null || musicBrainzId.isEmpty) return null;

    try {
      final response = await _dio.get('/release/$musicBrainzId');

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as Map<String, dynamic>;
        final images = data['images'] as List?;
        if (images != null && images.isNotEmpty) {
          // 优先使用 front cover
          for (final image in images) {
            final imageData = image as Map<String, dynamic>;
            if (imageData['front'] == true) {
              // 根据 size 选择缩略图或全尺寸
              if (size != null && size <= 500) {
                final thumbnails =
                    imageData['thumbnails'] as Map<String, dynamic>?;
                return (thumbnails?['500'] ??
                        thumbnails?['large'] ??
                        imageData['image'])
                    as String?;
              }
              return imageData['image'] as String?;
            }
          }
          // 没有 front 标记的，返回第一个
          return images.first['image'] as String?;
        }
      }
    } catch (e) {
      Logger.warn('MusicBrainz cover fetch failed', e);
    }

    return null;
  }
}
