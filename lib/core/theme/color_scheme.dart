import 'package:flutter/material.dart';

/// 应用颜色方案
class AppColorScheme {
  // 亮色模式
  static ColorScheme lightScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF6750A4), // Material 3 默认紫色
    brightness: Brightness.light,
  );

  // 暗色模式
  static ColorScheme darkScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF6750A4),
    brightness: Brightness.dark,
  );
}
