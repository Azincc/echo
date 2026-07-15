import 'package:flutter/material.dart';

/// Stable, semantic colors for Echo's quiet application chrome.
///
/// Material color roles are deliberately absent here. Framework roles are
/// derived from this extension in `AppColorScheme`, never the other way round.
@immutable
class EchoColors extends ThemeExtension<EchoColors> {
  const EchoColors({
    required this.accent,
    required this.onAccent,
    required this.contentTint,
    required this.onContentTint,
    required this.canvas,
    required this.surface,
    required this.raised,
    required this.ink,
    required this.muted,
    required this.divider,
    required this.controlBoundary,
    required this.error,
    required this.onError,
    required this.warning,
    required this.onWarning,
    required this.disabled,
    required this.onDisabled,
    required this.scrim,
  });

  static const Color echoAccent = Color(0xFF3B8258);
  static const Color defaultAccent = echoAccent;
  static const Color contentTintFallback = Color(0xFF556F60);

  static const Color dayCanvas = Color(0xFFF5F7F8);
  static const Color daySurface = Color(0xFFFFFFFF);
  static const Color dayRaised = Color(0xFFE9EDF0);
  static const Color dayInk = Color(0xFF16191C);
  static const Color dayMuted = Color(0xFF626A72);
  static const Color dayDivider = Color(0xFFD9DEE2);

  static const Color nightCanvas = Color(0xFF0C0F12);
  static const Color nightSurface = Color(0xFF14181C);
  static const Color nightRaised = Color(0xFF1E2429);
  static const Color nightInk = Color(0xFFF2F5F7);
  static const Color nightMuted = Color(0xFFAAB2B9);
  static const Color nightDivider = Color(0xFF2A3238);

  static const Color clearError = Color(0xFFB84B48);
  static const Color measuredWarning = Color(0xFF9F6B20);
  static const Color stageScrim = Color(0xDD080A0D);

  final Color accent;
  final Color onAccent;
  final Color contentTint;
  final Color onContentTint;
  final Color canvas;
  final Color surface;
  final Color raised;
  final Color ink;
  final Color muted;
  final Color divider;
  final Color controlBoundary;
  final Color error;
  final Color onError;
  final Color warning;
  final Color onWarning;
  final Color disabled;
  final Color onDisabled;
  final Color scrim;

  factory EchoColors.light({Color accent = defaultAccent}) {
    final resolvedAccent = ensureColorContrast(accent, background: dayCanvas);
    final resolvedContentTint = ensureColorContrast(
      contentTintFallback,
      background: dayCanvas,
      minimumRatio: 3,
    );
    final resolvedError = ensureColorContrastAcross(
      clearError,
      backgrounds: const <Color>[dayCanvas, daySurface, dayRaised],
    );
    final resolvedWarning = ensureColorContrastAcross(
      measuredWarning,
      backgrounds: const <Color>[dayCanvas, daySurface, dayRaised],
    );
    final resolvedControlBoundary = ensureColorContrastAcross(
      dayMuted,
      backgrounds: const <Color>[dayCanvas, daySurface, dayRaised],
      minimumRatio: 3,
    );

    return EchoColors(
      accent: resolvedAccent,
      onAccent: readableOn(resolvedAccent),
      contentTint: resolvedContentTint,
      onContentTint: readableOn(resolvedContentTint),
      canvas: dayCanvas,
      surface: daySurface,
      raised: dayRaised,
      ink: dayInk,
      muted: dayMuted,
      divider: dayDivider,
      controlBoundary: resolvedControlBoundary,
      error: resolvedError,
      onError: readableOn(resolvedError),
      warning: resolvedWarning,
      onWarning: readableOn(resolvedWarning),
      disabled: dayRaised,
      onDisabled: ensureColorContrast(dayMuted, background: dayRaised),
      scrim: stageScrim,
    );
  }

  factory EchoColors.dark({Color accent = defaultAccent}) {
    final resolvedAccent = ensureColorContrast(accent, background: nightCanvas);
    final resolvedContentTint = ensureColorContrast(
      contentTintFallback,
      background: nightCanvas,
      minimumRatio: 3,
    );
    final resolvedError = ensureColorContrastAcross(
      clearError,
      backgrounds: const <Color>[nightCanvas, nightSurface, nightRaised],
    );
    final resolvedWarning = ensureColorContrastAcross(
      measuredWarning,
      backgrounds: const <Color>[nightCanvas, nightSurface, nightRaised],
    );
    final resolvedControlBoundary = ensureColorContrastAcross(
      nightMuted,
      backgrounds: const <Color>[nightCanvas, nightSurface, nightRaised],
      minimumRatio: 3,
    );

    return EchoColors(
      accent: resolvedAccent,
      onAccent: readableOn(resolvedAccent),
      contentTint: resolvedContentTint,
      onContentTint: readableOn(resolvedContentTint),
      canvas: nightCanvas,
      surface: nightSurface,
      raised: nightRaised,
      ink: nightInk,
      muted: nightMuted,
      divider: nightDivider,
      controlBoundary: resolvedControlBoundary,
      error: resolvedError,
      onError: readableOn(resolvedError),
      warning: resolvedWarning,
      onWarning: readableOn(resolvedWarning),
      disabled: nightRaised,
      onDisabled: ensureColorContrast(nightMuted, background: nightRaised),
      scrim: stageScrim,
    );
  }

  /// Returns the WCAG contrast ratio for [foreground] over [background].
  ///
  /// Translucent colors are composited before luminance is measured so this
  /// helper remains safe for focus rings, scrims, and media-derived colors.
  static double contrastRatio(Color foreground, Color background) {
    final opaqueBackground = _flatten(background, Colors.white);
    final opaqueForeground = _flatten(foreground, opaqueBackground);
    final foregroundLuminance = opaqueForeground.computeLuminance();
    final backgroundLuminance = opaqueBackground.computeLuminance();
    final lighter = foregroundLuminance > backgroundLuminance
        ? foregroundLuminance
        : backgroundLuminance;
    final darker = foregroundLuminance > backgroundLuminance
        ? backgroundLuminance
        : foregroundLuminance;
    return (lighter + 0.05) / (darker + 0.05);
  }

  /// Chooses a black or white foreground with the strongest contrast.
  static Color readableOn(Color background) {
    const dark = Colors.black;
    const light = Colors.white;
    return contrastRatio(light, background) >= contrastRatio(dark, background)
        ? light
        : dark;
  }

  /// Adjusts [color] only as far as needed to contrast with [background].
  ///
  /// The adjustment travels toward black or white, whichever offers the
  /// larger available contrast. This preserves the original hue for as long
  /// as WCAG permits while guaranteeing a deterministic accessible result.
  static Color ensureColorContrast(
    Color color, {
    required Color background,
    double minimumRatio = 4.5,
  }) {
    assert(minimumRatio >= 1);
    final opaqueBackground = _flatten(background, Colors.white);
    final opaqueColor = _flatten(color, opaqueBackground);
    if (contrastRatio(opaqueColor, opaqueBackground) >= minimumRatio) {
      return opaqueColor;
    }

    const darkTarget = Colors.black;
    const lightTarget = Colors.white;
    final target =
        contrastRatio(darkTarget, opaqueBackground) >=
            contrastRatio(lightTarget, opaqueBackground)
        ? darkTarget
        : lightTarget;

    if (contrastRatio(target, opaqueBackground) < minimumRatio) {
      return target;
    }

    var failing = 0.0;
    var passing = 1.0;
    for (var index = 0; index < 18; index += 1) {
      final midpoint = (failing + passing) / 2;
      final candidate = Color.lerp(opaqueColor, target, midpoint)!;
      if (contrastRatio(candidate, opaqueBackground) >= minimumRatio) {
        passing = midpoint;
      } else {
        failing = midpoint;
      }
    }
    return Color.lerp(opaqueColor, target, passing)!;
  }

  /// Normalizes one semantic ink color against every surface it may appear on.
  static Color ensureColorContrastAcross(
    Color color, {
    required Iterable<Color> backgrounds,
    double minimumRatio = 4.5,
  }) {
    final surfaces = backgrounds.toList(growable: false);
    assert(surfaces.isNotEmpty);
    var candidate = color;
    for (var pass = 0; pass < surfaces.length * 3; pass += 1) {
      var weakestSurface = surfaces.first;
      var weakestRatio = contrastRatio(candidate, weakestSurface);
      for (final surface in surfaces.skip(1)) {
        final ratio = contrastRatio(candidate, surface);
        if (ratio < weakestRatio) {
          weakestRatio = ratio;
          weakestSurface = surface;
        }
      }
      if (weakestRatio >= minimumRatio) return candidate;
      candidate = ensureColorContrast(
        candidate,
        background: weakestSurface,
        minimumRatio: minimumRatio,
      );
    }
    return candidate;
  }

  /// Normalizes a background while keeping [foreground] unchanged.
  static Color ensureForegroundContrast(
    Color background, {
    required Color foreground,
    double minimumRatio = 4.5,
  }) {
    return ensureColorContrast(
      background,
      background: foreground,
      minimumRatio: minimumRatio,
    );
  }

  static Color _flatten(Color color, Color backdrop) {
    if (color.a >= 1) {
      return color;
    }
    return Color.alphaBlend(color, backdrop).withAlpha(0xFF);
  }

  @override
  EchoColors copyWith({
    Color? accent,
    Color? onAccent,
    Color? contentTint,
    Color? onContentTint,
    Color? canvas,
    Color? surface,
    Color? raised,
    Color? ink,
    Color? muted,
    Color? divider,
    Color? controlBoundary,
    Color? error,
    Color? onError,
    Color? warning,
    Color? onWarning,
    Color? disabled,
    Color? onDisabled,
    Color? scrim,
  }) {
    return EchoColors(
      accent: accent ?? this.accent,
      onAccent: onAccent ?? this.onAccent,
      contentTint: contentTint ?? this.contentTint,
      onContentTint: onContentTint ?? this.onContentTint,
      canvas: canvas ?? this.canvas,
      surface: surface ?? this.surface,
      raised: raised ?? this.raised,
      ink: ink ?? this.ink,
      muted: muted ?? this.muted,
      divider: divider ?? this.divider,
      controlBoundary: controlBoundary ?? this.controlBoundary,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      disabled: disabled ?? this.disabled,
      onDisabled: onDisabled ?? this.onDisabled,
      scrim: scrim ?? this.scrim,
    );
  }

  @override
  EchoColors lerp(covariant EchoColors? other, double t) {
    if (other == null) {
      return this;
    }
    return EchoColors(
      accent: Color.lerp(accent, other.accent, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      contentTint: Color.lerp(contentTint, other.contentTint, t)!,
      onContentTint: Color.lerp(onContentTint, other.onContentTint, t)!,
      canvas: Color.lerp(canvas, other.canvas, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      raised: Color.lerp(raised, other.raised, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      controlBoundary: Color.lerp(controlBoundary, other.controlBoundary, t)!,
      error: Color.lerp(error, other.error, t)!,
      onError: Color.lerp(onError, other.onError, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      disabled: Color.lerp(disabled, other.disabled, t)!,
      onDisabled: Color.lerp(onDisabled, other.onDisabled, t)!,
      scrim: Color.lerp(scrim, other.scrim, t)!,
    );
  }
}
