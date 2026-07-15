import 'package:echoes/core/design/tokens/echo_colors.dart';
import 'package:flutter/material.dart';

/// One-way compatibility bridge from Echo semantics to Flutter roles.
///
/// Business UI consumes [EchoColors]. [ColorScheme] exists only for Flutter,
/// third-party widgets, and code that has not yet migrated to Echo primitives.
abstract final class AppColorScheme {
  static const Color defaultSeedColor = EchoColors.defaultAccent;

  static EchoColors lightColors([Color? accent]) {
    return EchoColors.light(accent: accent ?? defaultSeedColor);
  }

  static EchoColors darkColors([Color? accent]) {
    return EchoColors.dark(accent: accent ?? defaultSeedColor);
  }

  static EchoColors colorsFor(Brightness brightness, [Color? accent]) {
    return brightness == Brightness.dark
        ? darkColors(accent)
        : lightColors(accent);
  }

  static ColorScheme materialBridge(EchoColors colors, Brightness brightness) {
    final base = brightness == Brightness.dark
        ? const ColorScheme.dark()
        : const ColorScheme.light();
    final inversePrimary = EchoColors.ensureColorContrast(
      colors.accent,
      background: colors.ink,
    );

    return base.copyWith(
      primary: colors.accent,
      onPrimary: colors.onAccent,
      primaryContainer: colors.accent,
      onPrimaryContainer: colors.onAccent,
      primaryFixed: colors.accent,
      primaryFixedDim: colors.accent,
      onPrimaryFixed: colors.onAccent,
      onPrimaryFixedVariant: colors.onAccent,
      secondary: colors.contentTint,
      onSecondary: colors.onContentTint,
      secondaryContainer: colors.raised,
      onSecondaryContainer: colors.ink,
      secondaryFixed: colors.contentTint,
      secondaryFixedDim: colors.contentTint,
      onSecondaryFixed: colors.onContentTint,
      onSecondaryFixedVariant: colors.onContentTint,
      tertiary: colors.warning,
      onTertiary: colors.onWarning,
      tertiaryContainer: colors.warning,
      onTertiaryContainer: colors.onWarning,
      tertiaryFixed: colors.warning,
      tertiaryFixedDim: colors.warning,
      onTertiaryFixed: colors.onWarning,
      onTertiaryFixedVariant: colors.onWarning,
      error: colors.error,
      onError: colors.onError,
      errorContainer: colors.error,
      onErrorContainer: colors.onError,
      surface: colors.surface,
      onSurface: colors.ink,
      surfaceDim: colors.canvas,
      surfaceBright: colors.surface,
      surfaceContainerLowest: colors.canvas,
      surfaceContainerLow: colors.surface,
      surfaceContainer: colors.raised,
      surfaceContainerHigh: colors.raised,
      surfaceContainerHighest: colors.raised,
      onSurfaceVariant: colors.muted,
      outline: colors.controlBoundary,
      outlineVariant: colors.divider,
      shadow: Colors.transparent,
      scrim: colors.scrim,
      inverseSurface: colors.ink,
      onInverseSurface: colors.canvas,
      inversePrimary: inversePrimary,
      surfaceTint: Colors.transparent,
    );
  }
}
