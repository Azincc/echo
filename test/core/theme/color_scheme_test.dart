import 'package:echoes/core/theme/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('default seed color uses music red', () {
    expect(AppColorScheme.defaultSeedColor, AppColorScheme.musicRed);
  });

  test('custom seed color drives light and dark primary colors', () {
    const custom = Color(0xFF0EA5E9);

    expect(AppColorScheme.lightScheme(custom).primary, custom);
    expect(AppColorScheme.darkScheme(custom).primary, custom);
  });
}
