import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palette_generator/palette_generator.dart';

import '../core/design/media/echo_media_visuals.dart';
import '../core/utils/cover_ref_security.dart';
import 'api_provider.dart';
import 'library_provider.dart';
import 'player_provider.dart';

export '../core/design/media/echo_media_visuals.dart';

enum MediaPaletteSourceKind { coverReference, previewUrl }

/// Identifies artwork without tying consumers to a particular image backend.
///
/// Equality intentionally follows the source reference so Riverpod families
/// and the process-local cache can share work across player and detail views.
@immutable
class MediaPaletteRequest {
  const MediaPaletteRequest.coverReference(String reference)
    : this._(MediaPaletteSourceKind.coverReference, reference);

  const MediaPaletteRequest.previewUrl(String url)
    : this._(MediaPaletteSourceKind.previewUrl, url);

  const MediaPaletteRequest._(this.kind, this.reference);

  final MediaPaletteSourceKind kind;
  final String reference;

  @override
  bool operator ==(Object other) {
    return other is MediaPaletteRequest &&
        other.kind == kind &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(kind, reference);
}

/// A bounded async LRU that also coalesces concurrent loads for the same key.
///
/// Null results and failures are deliberately not retained. A cover that was
/// unavailable on one server address can therefore retry after failover.
class BoundedAsyncCache<T extends Object> {
  BoundedAsyncCache({required this.capacity}) : assert(capacity > 0);

  final int capacity;
  final LinkedHashMap<String, T> _completed = LinkedHashMap<String, T>();
  final Map<String, Future<T?>> _inFlight = <String, Future<T?>>{};

  int get completedEntryCount => _completed.length;
  int get inFlightEntryCount => _inFlight.length;

  bool containsCompleted(String key) => _completed.containsKey(key);

  Future<T?> getOrLoad(String key, Future<T?> Function() loader) {
    if (key.isEmpty) {
      throw ArgumentError.value(key, 'key', 'Cache key must not be empty');
    }

    if (_completed.containsKey(key)) {
      final value = _completed.remove(key)!;
      _completed[key] = value;
      return Future<T?>.value(value);
    }

    final pending = _inFlight[key];
    if (pending != null) return pending;

    late final Future<T?> future;
    future = _loadAndRemember(key, loader, () {
      if (identical(_inFlight[key], future)) {
        _inFlight.remove(key);
      }
    });
    _inFlight[key] = future;
    return future;
  }

  Future<T?> _loadAndRemember(
    String key,
    Future<T?> Function() loader,
    VoidCallback onComplete,
  ) async {
    try {
      final value = await loader();
      if (value != null) {
        _completed.remove(key);
        _completed[key] = value;
        while (_completed.length > capacity) {
          _completed.remove(_completed.keys.first);
        }
      }
      return value;
    } finally {
      onComplete();
    }
  }
}

typedef MediaPaletteLoader =
    Future<PaletteGenerator?> Function(ImageProvider imageProvider);

final mediaPaletteCacheProvider = Provider<BoundedAsyncCache<PaletteGenerator>>(
  (ref) => BoundedAsyncCache<PaletteGenerator>(capacity: 48),
);

final mediaPaletteLoaderProvider = Provider<MediaPaletteLoader>((ref) {
  return (imageProvider) async {
    return PaletteGenerator.fromImageProvider(
      imageProvider,
      maximumColorCount: 20,
    );
  };
});

final mediaPaletteProvider = FutureProvider.autoDispose
    .family<PaletteGenerator?, MediaPaletteRequest>((ref, request) async {
      final resource = _resolvePaletteResource(ref, request);
      if (resource == null) return null;

      final cache = ref.watch(mediaPaletteCacheProvider);
      final loader = ref.watch(mediaPaletteLoaderProvider);
      try {
        return await cache.getOrLoad(
          resource.key,
          () => loader(resource.imageProvider),
        );
      } catch (_) {
        return null;
      }
    });

/// Artwork-derived semantic colours for player and media-adjacent surfaces.
///
/// Raw palette extraction remains available through [mediaPaletteProvider] for
/// compatibility. New UI should consume this provider so swatch selection,
/// light/dark foreground choice, and contrast guarantees stay centralized.
final mediaVisualsProvider = FutureProvider.autoDispose
    .family<EchoMediaVisuals, MediaPaletteRequest>((ref, request) async {
      final palette = await ref.watch(mediaPaletteProvider(request).future);
      return EchoMediaVisuals.fromPalette(palette);
    });

/// Current-player compatibility provider.
///
/// It keeps the existing API while delegating extraction to the shared,
/// cover-keyed cache used by media detail headers.
final currentSongPaletteProvider =
    FutureProvider.autoDispose<PaletteGenerator?>((ref) async {
      // Only currentSong changes invalidate this provider. Position and other
      // high-frequency playback state remain outside the dependency graph.
      final song = ref.watch(playerProvider.select((s) => s.currentSong));
      if (song == null) return null;

      final previewCover = song.previewCoverUrl?.trim();
      final request =
          song.isPreview && previewCover != null && previewCover.isNotEmpty
          ? MediaPaletteRequest.previewUrl(previewCover)
          : MediaPaletteRequest.coverReference(song.coverArt ?? '');
      if (request.reference.trim().isEmpty) return null;

      return await ref.watch(mediaPaletteProvider(request).future);
    });

/// Semantic media visuals for the active song.
///
/// A song without usable artwork receives the stable Echo fallback. No active
/// song remains `null`, matching the lifecycle of [currentSongPaletteProvider]
/// without forcing player chrome to render when playback has no current item.
final currentSongMediaVisualsProvider =
    FutureProvider.autoDispose<EchoMediaVisuals?>((ref) async {
      final song = ref.watch(playerProvider.select((s) => s.currentSong));
      if (song == null) return null;

      final palette = await ref.watch(currentSongPaletteProvider.future);
      return EchoMediaVisuals.fromPalette(palette);
    });

/// Always-available visuals for player chrome.
///
/// Riverpod preserves the previous FutureProvider value while a dependency is
/// reloading. Reading [valueOrNull] therefore keeps one stable colour state
/// during rapid song changes instead of flashing through fallback colours.
final resolvedCurrentSongMediaVisualsProvider = Provider<EchoMediaVisuals>((
  ref,
) {
  final visuals = ref.watch(currentSongMediaVisualsProvider);
  return visuals.valueOrNull ?? EchoMediaVisuals.fallback();
});

_MediaPaletteResource? _resolvePaletteResource(
  Ref ref,
  MediaPaletteRequest request,
) {
  if (request.kind == MediaPaletteSourceKind.previewUrl) {
    return _directUrlResource(request.reference);
  }

  final trustedUrl = extractTrustedCoverUrl(request.reference);
  if (trustedUrl != null) {
    return _directUrlResource(trustedUrl);
  }

  final coverArtId = sanitizeServerCoverArtId(request.reference);
  if (coverArtId == null) return null;

  final activeLibrary = ref.watch(activeLibraryProvider);
  final activeAddress = ref.watch(activeAddressProvider);
  final client = ref.watch(subsonicApiClientProvider);
  final imageUrl = client.getCoverArtUrl(coverArtId, size: 300);
  if (imageUrl.isEmpty) return null;

  final sourceId = activeLibrary?.id.trim().isNotEmpty == true
      ? activeLibrary!.id.trim()
      : activeAddress?.url.trim();
  if (sourceId == null || sourceId.isEmpty) return null;

  final key = 'subsonic:$sourceId:$coverArtId';
  return _MediaPaletteResource(
    key: key,
    imageProvider: CachedNetworkImageProvider(
      imageUrl,
      cacheKey: 'palette:$key',
    ),
  );
}

_MediaPaletteResource? _directUrlResource(String rawUrl) {
  final normalizedUrl = _normalizeHttpUrl(rawUrl);
  if (normalizedUrl == null) return null;
  return _MediaPaletteResource(
    key: 'url:$normalizedUrl',
    imageProvider: CachedNetworkImageProvider(normalizedUrl),
  );
}

String? _normalizeHttpUrl(String value) {
  final trimmed = value.trim();
  final uri = Uri.tryParse(trimmed);
  if (uri == null || uri.host.isEmpty) return null;
  if (uri.scheme != 'http' && uri.scheme != 'https') return null;
  return uri.removeFragment().toString();
}

class _MediaPaletteResource {
  const _MediaPaletteResource({required this.key, required this.imageProvider});

  final String key;
  final ImageProvider imageProvider;
}
