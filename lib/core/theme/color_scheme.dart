import 'package:flutter/material.dart';

/// App color scheme definitions.
class AppColorScheme {
  static const Color defaultSeedColor = Color(0xFF4CAF50);
  static const Color lightBackgroundColor = Color(0xFFFFFFFF);
  static const Color darkBackgroundColor = Color(0xFF121212);

  // Light mode: keep neutral backgrounds fixed, while accent colors follow seed.
  static ColorScheme lightScheme([Color seedColor = defaultSeedColor]) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    );
    return scheme.copyWith(
      surface: lightBackgroundColor,
      surfaceTint: Colors.transparent,
      surfaceDim: const Color(0xFFECEFF3),
      surfaceBright: const Color(0xFFFFFFFF),
      surfaceContainerLowest: const Color(0xFFFFFFFF),
      surfaceContainerLow: const Color(0xFFF7F8FA),
      surfaceContainer: const Color(0xFFF1F3F5),
      surfaceContainerHigh: const Color(0xFFEBEDF0),
      surfaceContainerHighest: const Color(0xFFE5E7EB),
    );
  }

  // Dark mode: keep neutral backgrounds fixed, while accent colors follow seed.
  static ColorScheme darkScheme([Color seedColor = defaultSeedColor]) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    );
    return scheme.copyWith(
      surface: darkBackgroundColor,
      surfaceTint: Colors.transparent,
      surfaceDim: const Color(0xFF0B0D10),
      surfaceBright: const Color(0xFF2A2D31),
      surfaceContainerLowest: const Color(0xFF0D0F12),
      surfaceContainerLow: const Color(0xFF15181C),
      surfaceContainer: const Color(0xFF1B1E22),
      surfaceContainerHigh: const Color(0xFF22262A),
      surfaceContainerHighest: const Color(0xFF2A2E33),
    );
  }
}
