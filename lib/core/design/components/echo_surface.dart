import 'package:flutter/material.dart';

import '../echo_context.dart';

enum EchoSurfaceLevel { canvas, surface, raised, floating, modal }

/// A semantic Echo surface. Ordinary content remains flat; shadows are reserved
/// for floating and modal layers.
class EchoSurface extends StatelessWidget {
  const EchoSurface({
    super.key,
    required this.child,
    this.level = EchoSurfaceLevel.surface,
    this.color,
    this.padding,
    this.margin,
    this.borderRadius,
    this.borderColor,
    this.clipBehavior = Clip.none,
  });

  const EchoSurface.canvas({
    super.key,
    required this.child,
    this.color,
    this.padding,
    this.margin,
    this.borderRadius = BorderRadius.zero,
    this.borderColor,
    this.clipBehavior = Clip.none,
  }) : level = EchoSurfaceLevel.canvas;

  final Widget child;
  final EchoSurfaceLevel level;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final Color? borderColor;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final colors = context.echoColors;
    final radii = context.echoRadii;
    final resolvedColor =
        color ??
        switch (level) {
          EchoSurfaceLevel.canvas => colors.canvas,
          EchoSurfaceLevel.surface => colors.surface,
          EchoSurfaceLevel.raised => colors.raised,
          EchoSurfaceLevel.floating => colors.surface,
          EchoSurfaceLevel.modal => colors.surface,
        };
    final resolvedRadius =
        borderRadius ??
        switch (level) {
          EchoSurfaceLevel.canvas => BorderRadius.zero,
          EchoSurfaceLevel.surface => radii.surface,
          EchoSurfaceLevel.raised => radii.control,
          EchoSurfaceLevel.floating => radii.surface,
          EchoSurfaceLevel.modal => radii.scene,
        };
    final shadows = switch (level) {
      EchoSurfaceLevel.floating => <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF04080C).withValues(alpha: 0.18),
          offset: const Offset(0, 8),
          blurRadius: 24,
        ),
      ],
      EchoSurfaceLevel.modal => <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF04080C).withValues(alpha: 0.28),
          offset: const Offset(0, 18),
          blurRadius: 48,
        ),
      ],
      EchoSurfaceLevel.canvas ||
      EchoSurfaceLevel.surface ||
      EchoSurfaceLevel.raised => const <BoxShadow>[],
    };

    return Container(
      margin: margin,
      padding: padding,
      clipBehavior: clipBehavior,
      decoration: BoxDecoration(
        color: resolvedColor,
        borderRadius: resolvedRadius,
        border: borderColor == null ? null : Border.all(color: borderColor!),
        boxShadow: shadows,
      ),
      child: child,
    );
  }
}
