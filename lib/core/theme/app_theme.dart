import 'package:flutter/material.dart';
import 'color_scheme.dart';

/// Application theme configuration.
class AppTheme {
  // Light theme.
  static ThemeData light({Color seedColor = AppColorScheme.defaultSeedColor}) {
    final colorScheme = AppColorScheme.lightScheme(seedColor);
    return ThemeData(
      useMaterial3: true,
      splashFactory: NoSplash.splashFactory,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColorScheme.lightBackgroundColor,
      canvasColor: AppColorScheme.lightBackgroundColor,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: colorScheme.primary.withValues(alpha: 0.06),
      focusColor: colorScheme.primary.withValues(alpha: 0.08),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: AppColorScheme.lightBackgroundColor,
        surfaceTintColor: Colors.transparent,
        foregroundColor: colorScheme.onSurface,
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant.withValues(alpha: 0.7),
        thickness: 0.7,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: colorScheme.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.2),
        ),
        filled: true,
        fillColor: colorScheme.surfaceContainer,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      dialogTheme: DialogThemeData(
        elevation: 0,
        backgroundColor: Colors.white.withValues(alpha: 0.94),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.black.withValues(alpha: 0.16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        actionsPadding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
        insetPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
        ),
        contentTextStyle: TextStyle(
          color: colorScheme.onSurfaceVariant,
          fontSize: 14,
          height: 1.4,
          letterSpacing: 0,
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: Colors.white.withValues(alpha: 0.96),
        elevation: 12,
        shadowColor: Colors.black.withValues(alpha: 0.12),
        surfaceTintColor: Colors.transparent,
        iconColor: colorScheme.onSurfaceVariant,
        iconSize: 22,
        menuPadding: const EdgeInsets.symmetric(vertical: 8),
        position: PopupMenuPosition.under,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
          ),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        circularTrackColor: colorScheme.primary.withValues(alpha: 0.12),
        linearTrackColor: colorScheme.primary.withValues(alpha: 0.10),
        linearMinHeight: 5,
        strokeWidth: 3,
        strokeCap: StrokeCap.round,
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.onSurfaceVariant.withValues(alpha: 0.62);
        }),
        overlayColor: WidgetStatePropertyAll(
          colorScheme.primary.withValues(alpha: 0.10),
        ),
        backgroundColor: WidgetStatePropertyAll(
          colorScheme.surfaceContainerHighest.withValues(alpha: 0.62),
        ),
        side: BorderSide(color: colorScheme.outlineVariant, width: 1.2),
        innerRadius: WidgetStatePropertyAll(5),
        splashRadius: 20,
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 66,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        indicatorColor: colorScheme.primary.withValues(alpha: 0.12),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return TextStyle(
            fontSize: 12,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            size: selected ? 25 : 24,
            color: selected
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant,
          );
        }),
      ),
      chipTheme: ChipThemeData(
        selectedColor: colorScheme.primary.withValues(alpha: 0.14),
        checkmarkColor: colorScheme.primary,
        side: BorderSide(color: colorScheme.outlineVariant),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
      ),
    );
  }

  // Dark theme.
  static ThemeData dark({Color seedColor = AppColorScheme.defaultSeedColor}) {
    final colorScheme = AppColorScheme.darkScheme(seedColor);
    return ThemeData(
      useMaterial3: true,
      splashFactory: NoSplash.splashFactory,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColorScheme.darkBackgroundColor,
      canvasColor: AppColorScheme.darkBackgroundColor,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: colorScheme.primary.withValues(alpha: 0.10),
      focusColor: colorScheme.primary.withValues(alpha: 0.12),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: AppColorScheme.darkBackgroundColor,
        surfaceTintColor: Colors.transparent,
        foregroundColor: colorScheme.onSurface,
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant.withValues(alpha: 0.75),
        thickness: 0.7,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: colorScheme.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.2),
        ),
        filled: true,
        fillColor: colorScheme.surfaceContainer,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      dialogTheme: DialogThemeData(
        elevation: 0,
        backgroundColor: colorScheme.surfaceContainerHigh.withValues(
          alpha: 0.92,
        ),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.black.withValues(alpha: 0.34),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        actionsPadding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
        insetPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
        ),
        contentTextStyle: TextStyle(
          color: colorScheme.onSurfaceVariant,
          fontSize: 14,
          height: 1.4,
          letterSpacing: 0,
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: colorScheme.surfaceContainerHigh.withValues(alpha: 0.96),
        elevation: 14,
        shadowColor: Colors.black.withValues(alpha: 0.32),
        surfaceTintColor: Colors.transparent,
        iconColor: colorScheme.onSurfaceVariant,
        iconSize: 22,
        menuPadding: const EdgeInsets.symmetric(vertical: 8),
        position: PopupMenuPosition.under,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.78),
          ),
        ),
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
          ),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        circularTrackColor: colorScheme.primary.withValues(alpha: 0.18),
        linearTrackColor: colorScheme.primary.withValues(alpha: 0.14),
        linearMinHeight: 5,
        strokeWidth: 3,
        strokeCap: StrokeCap.round,
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.onSurfaceVariant.withValues(alpha: 0.7);
        }),
        overlayColor: WidgetStatePropertyAll(
          colorScheme.primary.withValues(alpha: 0.14),
        ),
        backgroundColor: WidgetStatePropertyAll(
          colorScheme.surfaceContainerHighest.withValues(alpha: 0.72),
        ),
        side: BorderSide(
          color: colorScheme.outlineVariant.withValues(alpha: 0.82),
          width: 1.2,
        ),
        innerRadius: WidgetStatePropertyAll(5),
        splashRadius: 20,
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 66,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        indicatorColor: colorScheme.primary.withValues(alpha: 0.18),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return TextStyle(
            fontSize: 12,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            size: selected ? 25 : 24,
            color: selected
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant,
          );
        }),
      ),
      chipTheme: ChipThemeData(
        selectedColor: colorScheme.primary.withValues(alpha: 0.2),
        checkmarkColor: colorScheme.primary,
        side: BorderSide(color: colorScheme.outlineVariant),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
      ),
    );
  }
}
