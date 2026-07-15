import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

enum EchoWindowClass { compact, medium, expanded }

/// Structural breakpoints. Typography remains stable while navigation and
/// content composition change at these boundaries.
@immutable
class EchoBreakpoints extends ThemeExtension<EchoBreakpoints> {
  const EchoBreakpoints({
    required this.medium,
    required this.expanded,
    required this.maxContentWidth,
  });

  static const EchoBreakpoints standard = EchoBreakpoints(
    medium: 600,
    expanded: 840,
    maxContentWidth: 1200,
  );

  final double medium;
  final double expanded;
  final double maxContentWidth;

  EchoWindowClass classify(double width) {
    if (width < medium) {
      return EchoWindowClass.compact;
    }
    if (width < expanded) {
      return EchoWindowClass.medium;
    }
    return EchoWindowClass.expanded;
  }

  @override
  EchoBreakpoints copyWith({
    double? medium,
    double? expanded,
    double? maxContentWidth,
  }) {
    return EchoBreakpoints(
      medium: medium ?? this.medium,
      expanded: expanded ?? this.expanded,
      maxContentWidth: maxContentWidth ?? this.maxContentWidth,
    );
  }

  @override
  EchoBreakpoints lerp(covariant EchoBreakpoints? other, double t) {
    if (other == null) {
      return this;
    }
    return EchoBreakpoints(
      medium: lerpDouble(medium, other.medium, t)!,
      expanded: lerpDouble(expanded, other.expanded, t)!,
      maxContentWidth: lerpDouble(maxContentWidth, other.maxContentWidth, t)!,
    );
  }
}
