import 'package:flutter/material.dart';

import 'echo_colors.dart';

/// Echo's single-family, content-first type hierarchy.
@immutable
class EchoTypography extends ThemeExtension<EchoTypography> {
  const EchoTypography({
    required this.display,
    required this.headline,
    required this.title,
    required this.body,
    required this.label,
    required this.metadata,
  });

  final TextStyle display;
  final TextStyle headline;
  final TextStyle title;
  final TextStyle body;
  final TextStyle label;
  final TextStyle metadata;

  factory EchoTypography.standard(EchoColors colors) {
    return EchoTypography(
      display: TextStyle(
        color: colors.ink,
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.12,
        letterSpacing: -0.64,
      ),
      headline: TextStyle(
        color: colors.ink,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.18,
        letterSpacing: -0.24,
      ),
      title: TextStyle(
        color: colors.ink,
        fontSize: 17,
        fontWeight: FontWeight.w600,
        height: 1.25,
      ),
      body: TextStyle(
        color: colors.ink,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.45,
      ),
      label: TextStyle(
        color: colors.ink,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        height: 1.25,
        letterSpacing: 0.13,
      ),
      metadata: TextStyle(
        color: colors.muted,
        fontSize: 13,
        fontWeight: FontWeight.w500,
        height: 1.25,
        fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
      ),
    );
  }

  @override
  EchoTypography copyWith({
    TextStyle? display,
    TextStyle? headline,
    TextStyle? title,
    TextStyle? body,
    TextStyle? label,
    TextStyle? metadata,
  }) {
    return EchoTypography(
      display: display ?? this.display,
      headline: headline ?? this.headline,
      title: title ?? this.title,
      body: body ?? this.body,
      label: label ?? this.label,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  EchoTypography lerp(covariant EchoTypography? other, double t) {
    if (other == null) {
      return this;
    }
    return EchoTypography(
      display: TextStyle.lerp(display, other.display, t)!,
      headline: TextStyle.lerp(headline, other.headline, t)!,
      title: TextStyle.lerp(title, other.title, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
      label: TextStyle.lerp(label, other.label, t)!,
      metadata: TextStyle.lerp(metadata, other.metadata, t)!,
    );
  }
}
