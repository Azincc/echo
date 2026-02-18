import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/color_scheme.dart';
import '../data/sources/local_storage.dart';

class ThemeSettings {
  final ThemeMode mode;
  final Color seedColor;

  const ThemeSettings({
    this.mode = ThemeMode.system,
    this.seedColor = AppColorScheme.defaultSeedColor,
  });

  ThemeSettings copyWith({ThemeMode? mode, Color? seedColor}) {
    return ThemeSettings(
      mode: mode ?? this.mode,
      seedColor: seedColor ?? this.seedColor,
    );
  }
}

final themeSettingsProvider =
    StateNotifierProvider<ThemeSettingsNotifier, ThemeSettings>(
      (ref) => ThemeSettingsNotifier(),
    );

class ThemeSettingsNotifier extends StateNotifier<ThemeSettings> {
  ThemeSettingsNotifier() : super(const ThemeSettings()) {
    _load();
  }

  Future<void> _load() async {
    final modeRaw = await LocalStorage.getThemeModeSetting();
    final seedColorValue = await LocalStorage.getThemeSeedColorValue();

    state = ThemeSettings(
      mode: _modeFromStorage(modeRaw),
      seedColor: Color(seedColorValue),
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (state.mode == mode) return;
    state = state.copyWith(mode: mode);
    await LocalStorage.setThemeModeSetting(_modeToStorage(mode));
  }

  Future<void> setSeedColor(Color color) async {
    if (state.seedColor.toARGB32() == color.toARGB32()) return;
    state = state.copyWith(seedColor: color);
    await LocalStorage.setThemeSeedColorValue(color.toARGB32());
  }

  Future<void> resetSeedColor() async {
    await setSeedColor(AppColorScheme.defaultSeedColor);
  }

  static ThemeMode _modeFromStorage(String raw) {
    switch (raw) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  static String _modeToStorage(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }
}
