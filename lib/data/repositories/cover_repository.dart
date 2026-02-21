import '../../core/utils/logger.dart';
import '../sources/covers/cover_source.dart';

class CoverLookupResult {
  final String sourceId;
  final String url;

  const CoverLookupResult({required this.sourceId, required this.url});
}

/// 封面仓库 — 按优先级 Fallback
class CoverRepository {
  final List<CoverSource> _sources;

  CoverRepository({required List<CoverSource> sources}) : _sources = sources;

  Future<CoverLookupResult?> getCoverUrlWithSource({
    required String artist,
    String? album,
    String? musicBrainzId,
    String? coverArtId,
    int? size,
    String? startAfterSourceId,
  }) async {
    var startIndex = 0;
    if (startAfterSourceId != null && startAfterSourceId.isNotEmpty) {
      final index = _sources.indexWhere((s) => s.id == startAfterSourceId);
      if (index >= 0) {
        startIndex = index + 1;
      }
    }

    for (var i = startIndex; i < _sources.length; i++) {
      final source = _sources[i];
      try {
        final url = await source.fetchCoverUrl(
          artist: artist,
          album: album,
          musicBrainzId: musicBrainzId,
          coverArtId: coverArtId,
          size: size,
        );
        final resolved = url?.trim() ?? '';
        if (resolved.isNotEmpty) {
          return CoverLookupResult(sourceId: source.id, url: resolved);
        }
      } catch (e) {
        Logger.warn('Cover source ${source.id} failed: $e');
      }
    }
    return null;
  }

  Future<String?> getCoverUrl({
    required String artist,
    String? album,
    String? musicBrainzId,
    String? coverArtId,
    int? size,
    String? startAfterSourceId,
  }) async {
    final result = await getCoverUrlWithSource(
      artist: artist,
      album: album,
      musicBrainzId: musicBrainzId,
      coverArtId: coverArtId,
      size: size,
      startAfterSourceId: startAfterSourceId,
    );
    return result?.url;
  }
}
