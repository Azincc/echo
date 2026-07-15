import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/design/echo_design.dart';
import '../core/utils/cover_ref_security.dart';
import '../providers/api_provider.dart';

class CoverArtImage extends ConsumerWidget {
  final String? coverArtId;
  final double? size;
  final int? requestSize;
  final BoxFit fit;
  final String? semanticLabel;

  const CoverArtImage({
    super.key,
    required this.coverArtId,
    this.size,
    this.requestSize,
    this.fit = BoxFit.cover,
    this.semanticLabel,
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
    final loadedLabel = semanticLabel ?? '专辑封面';
    return RepaintBoundary(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        cacheKey: cacheKey,
        width: size,
        height: size,
        fit: fit,
        imageBuilder: (context, imageProvider) => Semantics(
          image: true,
          label: loadedLabel,
          child: ExcludeSemantics(
            child: Image(
              image: imageProvider,
              width: size,
              height: size,
              fit: fit,
            ),
          ),
        ),
        placeholder: (context, url) => _buildPlaceholder(
          context,
          isLoading: true,
          accessibilityLabel: loadedLabel,
        ),
        errorWidget: (context, url, error) => _buildPlaceholder(
          context,
          accessibilityLabel: semanticLabel == null
              ? '暂无封面'
              : '$semanticLabel，不可用',
        ),
      ),
    );
  }

  Widget _buildPlaceholder(
    BuildContext context, {
    bool isLoading = false,
    bool semantic = true,
    String? accessibilityLabel,
  }) {
    final bgColor = context.echoColors.raised;
    final placeholder = SizedBox(
      width: size,
      height: size,
      child: isLoading
          ? _buildLoadingSkeleton()
          : ColoredBox(
              color: bgColor,
              child: Center(
                child: Icon(
                  AppIcons.music,
                  size: _getIconSize(),
                  color: context.echoColors.muted,
                ),
              ),
            ),
    );

    if (!semantic) return placeholder;

    return Semantics(
      image: true,
      label:
          accessibilityLabel ?? (isLoading ? '封面加载中' : semanticLabel ?? '暂无封面'),
      child: ExcludeSemantics(child: placeholder),
    );
  }

  Widget _buildLoadingSkeleton() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boundedWidth = constraints.hasBoundedWidth
            ? constraints.maxWidth
            : null;
        final boundedHeight = constraints.hasBoundedHeight
            ? constraints.maxHeight
            : null;
        final fallbackExtent = boundedWidth ?? boundedHeight ?? 48.0;

        return EchoSkeleton(
          width: size ?? boundedWidth ?? fallbackExtent,
          height: size ?? boundedHeight ?? fallbackExtent,
          borderRadius: BorderRadius.zero,
        );
      },
    );
  }

  double? _getIconSize() {
    if (size == null || size!.isInfinite) {
      return 48;
    }
    return size! * 0.5;
  }
}
