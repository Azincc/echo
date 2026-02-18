import 'package:flutter/material.dart';

/// 应用颜色方案
class AppColorScheme {
  static const Color defaultSeedColor = Color(0xFF6750A4);

  // 亮色模式
  static ColorScheme lightScheme([Color seedColor = defaultSeedColor]) =>
      ColorScheme.fromSeed(
        seedColor: seedColor, // Material 3 默认紫色
        brightness: Brightness.light,
      );

  // 暗色模式
  static ColorScheme darkScheme([Color seedColor = defaultSeedColor]) =>
      ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.dark);
}
