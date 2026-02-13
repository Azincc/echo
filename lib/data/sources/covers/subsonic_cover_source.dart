import '../subsonic_api_client.dart';
import 'cover_source.dart';

/// 服务端封面源（Subsonic getCoverArt）
class SubsonicCoverSource implements CoverSource {
  final SubsonicApiClient _apiClient;

  SubsonicCoverSource(this._apiClient);

  @override
  String get id => 'subsonic';

  @override
  String get displayName => '服务端';

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
    if (coverArtId == null || coverArtId.isEmpty) return null;
    final url = _apiClient.getCoverArtUrl(coverArtId, size: size);
    return url.isNotEmpty ? url : null;
  }
}
