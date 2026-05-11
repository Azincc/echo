import 'package:flutter/material.dart';

/// App color scheme definitions.
class AppColorScheme {
  static const Color defaultSeedColor = Color(0xFFFA2D48);
  static const Color musicRed = Color(0xFFFA2D48);
  static const Color musicPink = Color(0xFFFF4F7A);
  static const Color lightBackgroundColor = Color(0xFFFBFBFD);
  static const Color darkBackgroundColor = Color(0xFF07070A);

  static Color _onAccent(Color color) {
    return color.computeLuminance() > 0.52 ? Colors.black : Colors.white;
  }

  static Color _accentContainer(Color color, Brightness brightness) {
    final target = brightness == Brightness.dark ? Colors.black : Colors.white;
    final amount = brightness == Brightness.dark ? 0.62 : 0.82;
    return Color.lerp(color, target, amount) ?? color;
  }

  // Light mode: keep neutral backgrounds fixed, while accent colors follow seed.
  static ColorScheme lightScheme([Color seedColor = defaultSeedColor]) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    );
    final primaryContainer = _accentContainer(seedColor, Brightness.light);
    return scheme.copyWith(
      primary: seedColor,
      onPrimary: _onAccent(seedColor),
      primaryContainer: primaryContainer,
      onPrimaryContainer: _onAccent(primaryContainer),
      secondary: scheme.secondary,
      surface: lightBackgroundColor,
      surfaceTint: Colors.transparent,
      surfaceDim: const Color(0xFFE7E7EC),
      surfaceBright: const Color(0xFFFFFFFF),
      surfaceContainerLowest: const Color(0xFFFFFFFF),
      surfaceContainerLow: const Color(0xFFF5F5F8),
      surfaceContainer: const Color(0xFFEDEDF2),
      surfaceContainerHigh: const Color(0xFFE5E5EA),
      surfaceContainerHighest: const Color(0xFFDADAE2),
      outline: const Color(0xFFD0D0D8),
      outlineVariant: const Color(0xFFE3E3EA),
    );
  }

  // Dark mode: keep neutral backgrounds fixed, while accent colors follow seed.
  static ColorScheme darkScheme([Color seedColor = defaultSeedColor]) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    );
    final primaryContainer = _accentContainer(seedColor, Brightness.dark);
    return scheme.copyWith(
      primary: seedColor,
      onPrimary: _onAccent(seedColor),
      primaryContainer: primaryContainer,
      onPrimaryContainer: _onAccent(primaryContainer),
      secondary: scheme.secondary,
      surface: darkBackgroundColor,
      surfaceTint: Colors.transparent,
      surfaceDim: const Color(0xFF030305),
      surfaceBright: const Color(0xFF2B2B31),
      surfaceContainerLowest: const Color(0xFF0D0D11),
      surfaceContainerLow: const Color(0xFF15151A),
      surfaceContainer: const Color(0xFF1C1C22),
      surfaceContainerHigh: const Color(0xFF25252C),
      surfaceContainerHighest: const Color(0xFF303039),
      outline: const Color(0xFF4A4A55),
      outlineVariant: const Color(0xFF303039),
    );
  }
}
