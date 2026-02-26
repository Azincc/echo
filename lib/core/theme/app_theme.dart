import 'package:flutter/material.dart';
import 'color_scheme.dart';

/// Application theme configuration.
class AppTheme {
  // Light theme.
  static ThemeData light({Color seedColor = AppColorScheme.defaultSeedColor}) {
    final colorScheme = AppColorScheme.lightScheme(seedColor);
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColorScheme.lightBackgroundColor,
      canvasColor: AppColorScheme.lightBackgroundColor,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColorScheme.lightBackgroundColor,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
      ),
    );
  }

  // Dark theme.
  static ThemeData dark({Color seedColor = AppColorScheme.defaultSeedColor}) {
    final colorScheme = AppColorScheme.darkScheme(seedColor);
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColorScheme.darkBackgroundColor,
      canvasColor: AppColorScheme.darkBackgroundColor,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColorScheme.darkBackgroundColor,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
      ),
    );
  }
}
