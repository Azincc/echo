import 'package:flutter/material.dart';
import 'color_scheme.dart';

/// 应用主题配置
class AppTheme {
  // 亮色主题
  static ThemeData light({Color seedColor = AppColorScheme.defaultSeedColor}) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColorScheme.lightScheme(seedColor),
      appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
      ),
    );
  }

  // 暗色主题
  static ThemeData dark({Color seedColor = AppColorScheme.defaultSeedColor}) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColorScheme.darkScheme(seedColor),
      appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
      ),
    );
  }
}
