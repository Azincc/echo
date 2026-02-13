import '../../core/utils/logger.dart';
import '../sources/covers/cover_source.dart';

/// 封面仓库 — 按优先级 Fallback
class CoverRepository {
  final List<CoverSource> _sources;

  CoverRepository({required List<CoverSource> sources}) : _sources = sources;

  Future<String?> getCoverUrl({
    required String artist,
    String? album,
    String? musicBrainzId,
    String? coverArtId,
    int? size,
  }) async {
    for (final source in _sources) {
      try {
        final url = await source.fetchCoverUrl(
          artist: artist,
          album: album,
          musicBrainzId: musicBrainzId,
          coverArtId: coverArtId,
          size: size,
        );
        if (url != null) return url;
      } catch (e) {
        Logger.warn('Cover source ${source.id} failed: $e');
      }
    }
    return null;
  }
}
