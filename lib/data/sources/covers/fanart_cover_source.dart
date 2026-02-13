import 'package:dio/dio.dart';
import '../../../core/utils/logger.dart';
import 'cover_source.dart';

/// Fanart.tv 封面源
class FanartCoverSource implements CoverSource {
  final Dio _dio;
  final String? _apiKey;

  FanartCoverSource({String? apiKey, Dio? dio})
    : _apiKey = apiKey,
      _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: 'https://webservice.fanart.tv/v3',
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ),
          );

  @override
  String get id => 'fanart';

  @override
  String get displayName => 'Fanart.tv';

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
    if (musicBrainzId == null || musicBrainzId.isEmpty) return null;
    if (_apiKey == null || _apiKey.isEmpty) return null;

    try {
      final response = await _dio.get(
        '/music/$musicBrainzId',
        queryParameters: {'api_key': _apiKey},
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as Map<String, dynamic>;

        // 尝试获取专辑封面
        final albumCovers = data['albums'] as Map<String, dynamic>?;
        if (albumCovers != null && albumCovers.isNotEmpty) {
          for (final albumData in albumCovers.values) {
            final covers =
                (albumData as Map<String, dynamic>)['albumcover'] as List?;
            if (covers != null && covers.isNotEmpty) {
              return covers.first['url'] as String?;
            }
          }
        }

        // 尝试获取歌手图片
        final artistArt = data['artistbackground'] as List?;
        if (artistArt != null && artistArt.isNotEmpty) {
          return artistArt.first['url'] as String?;
        }
      }
    } catch (e) {
      Logger.warn('Fanart.tv cover fetch failed', e);
    }

    return null;
  }
}
