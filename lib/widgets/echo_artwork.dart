import 'package:flutter/material.dart';

import '../core/design/echo_design.dart';
import 'cover_art_image.dart';

enum EchoArtworkShape { rounded, circle }

/// Echo's shared artwork frame.
///
/// Network resolution, loading, and missing-cover states remain owned by
/// [CoverArtImage]. This wrapper standardizes shape, Hero transitions, and the
/// accessible image label used by media surfaces.
class EchoArtwork extends StatelessWidget {
  const EchoArtwork({
    super.key,
    required this.coverArtId,
    required this.semanticLabel,
    this.size,
    this.requestSize,
    this.fit = BoxFit.cover,
    this.shape = EchoArtworkShape.rounded,
    this.borderRadius,
    this.heroTag,
  }) : assert(semanticLabel != ''),
       assert(
         shape != EchoArtworkShape.circle || size != null,
         'Circular artwork requires an explicit square size.',
       );

  final String? coverArtId;
  final String semanticLabel;

  /// Logical square size. Required when [shape] is [EchoArtworkShape.circle].
  final double? size;
  final int? requestSize;
  final BoxFit fit;
  final EchoArtworkShape shape;
  final BorderRadius? borderRadius;
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    Widget artwork = CoverArtImage(
      coverArtId: coverArtId,
      size: size,
      requestSize: requestSize,
      fit: fit,
      semanticLabel: semanticLabel,
    );

    artwork = switch (shape) {
      EchoArtworkShape.rounded => ClipRRect(
        borderRadius: borderRadius ?? context.echoRadii.surface,
        clipBehavior: Clip.antiAlias,
        child: artwork,
      ),
      EchoArtworkShape.circle => ClipOval(
        clipBehavior: Clip.antiAlias,
        child: artwork,
      ),
    };

    if (size != null) {
      artwork = SizedBox.square(dimension: size, child: artwork);
    }

    if (heroTag != null) {
      artwork = Hero(
        tag: heroTag!,
        transitionOnUserGestures: true,
        child: artwork,
      );
    }

    return artwork;
  }
}
