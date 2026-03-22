import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/cover_ref_security.dart';
import '../providers/api_provider.dart';
import 'shimmer_loading.dart';

class CoverArtImage extends ConsumerWidget {
  final String? coverArtId;
  final double? size;
  final int? requestSize;
  final BoxFit fit;

  const CoverArtImage({
    super.key,
    required this.coverArtId,
    this.size,
    this.requestSize,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(activeAddressProvider);

    final raw = coverArtId?.trim() ?? '';
    if (raw.isEmpty) {
      return _buildPlaceholder(context);
    }

    final trustedCoverUrl = extractTrustedCoverUrl(raw);
    if (trustedCoverUrl != null) {
      return _buildNetworkImage(context, trustedCoverUrl);
    }

    final safeCoverArtId = sanitizeServerCoverArtId(raw);
    if (safeCoverArtId == null) {
      return _buildPlaceholder(context);
    }

    final apiClient = ref.watch(subsonicApiClientProvider);
    final resolvedCoverSize = _resolveCoverSize(context);
    final coverUrl = apiClient.getCoverArtUrl(
      safeCoverArtId,
      size: resolvedCoverSize,
    );
    if (coverUrl.isEmpty) {
      return _buildPlaceholder(context);
    }

    return _buildNetworkImage(
      context,
      coverUrl,
      cacheKey: '${safeCoverArtId}_$resolvedCoverSize',
    );
  }

  int _resolveCoverSize(BuildContext context) {
    if (requestSize != null && requestSize! > 0) {
      return requestSize!;
    }

    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    if (size != null && !size!.isInfinite) {
      return (size! * devicePixelRatio).ceil();
    }
    return 500;
  }

  Widget _buildNetworkImage(
    BuildContext context,
    String imageUrl, {
    String? cacheKey,
  }) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      cacheKey: cacheKey,
      width: size,
      height: size,
      fit: fit,
      placeholder: (context, url) =>
          _buildPlaceholder(context, isLoading: true),
      errorWidget: (context, url, error) => _buildPlaceholder(context),
    );
  }

  Widget _buildPlaceholder(BuildContext context, {bool isLoading = false}) {
    final bgColor = Theme.of(context).colorScheme.surfaceContainerHighest;
    if (isLoading) {
      return ShimmerEffect(
        child: Container(width: size, height: size, color: bgColor),
      );
    }

    return Container(
      width: size,
      height: size,
      color: bgColor,
      child: Icon(
        Icons.music_note,
        size: _getIconSize(),
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }

  double? _getIconSize() {
    if (size == null || size!.isInfinite) {
      return 48;
    }
    return size! * 0.5;
  }
}
