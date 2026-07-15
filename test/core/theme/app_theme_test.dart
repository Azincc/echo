import 'dart:io';

import 'package:echoes/core/design/tokens/echo_breakpoints.dart';
import 'package:echoes/core/design/tokens/echo_colors.dart';
import 'package:echoes/core/design/tokens/echo_interaction.dart';
import 'package:echoes/core/design/tokens/echo_motion.dart';
import 'package:echoes/core/design/tokens/echo_radii.dart';
import 'package:echoes/core/design/tokens/echo_spacing.dart';
import 'package:echoes/core/design/tokens/echo_typography.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/core/theme/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppColorScheme token bridge', () {
    test(
      'maps Echo tokens into framework roles without generating a palette',
      () {
        for (final brightness in Brightness.values) {
          final colors = AppColorScheme.colorsFor(brightness);
          final scheme = AppColorScheme.materialBridge(colors, brightness);

          expect(scheme.brightness, brightness);
          expect(scheme.primary, colors.accent);
          expect(scheme.onPrimary, colors.onAccent);
          expect(scheme.secondary, colors.contentTint);
          expect(scheme.onSecondary, colors.onContentTint);
          expect(scheme.error, colors.error);
          expect(scheme.onError, colors.onError);
          expect(scheme.surface, colors.surface);
          expect(scheme.onSurface, colors.ink);
          expect(scheme.surfaceContainerLowest, colors.canvas);
          expect(scheme.surfaceContainer, colors.raised);
          expect(scheme.onSurfaceVariant, colors.muted);
          expect(scheme.outline, colors.controlBoundary);
          expect(scheme.outlineVariant, colors.divider);
          expect(scheme.scrim, colors.scrim);
          expect(scheme.surfaceTint, Colors.transparent);
        }
      },
    );

    test('custom accents do not replace stable chrome tokens', () {
      const customAccent = Color(0xFF6B4AA0);
      final defaultColors = AppColorScheme.lightColors();
      final customColors = AppColorScheme.lightColors(customAccent);

      expect(customColors.accent, isNot(defaultColors.accent));
      expect(customColors.canvas, defaultColors.canvas);
      expect(customColors.surface, defaultColors.surface);
      expect(customColors.raised, defaultColors.raised);
      expect(customColors.ink, defaultColors.ink);
    });

    test('framework foreground pairs retain WCAG AA contrast', () {
      for (final brightness in Brightness.values) {
        final colors = AppColorScheme.colorsFor(brightness);
        final scheme = AppColorScheme.materialBridge(colors, brightness);
        final pairs = <(Color, Color)>[
          (scheme.onPrimary, scheme.primary),
          (scheme.onPrimaryFixed, scheme.primaryFixed),
          (scheme.onPrimaryFixed, scheme.primaryFixedDim),
          (scheme.onSecondary, scheme.secondary),
          (scheme.onSecondaryFixed, scheme.secondaryFixed),
          (scheme.onSecondaryFixed, scheme.secondaryFixedDim),
          (scheme.onTertiary, scheme.tertiary),
          (scheme.onTertiaryFixed, scheme.tertiaryFixed),
          (scheme.onTertiaryFixed, scheme.tertiaryFixedDim),
          (scheme.onError, scheme.error),
          (scheme.onSurface, scheme.surface),
        ];

        for (final (foreground, background) in pairs) {
          expect(
            EchoColors.contrastRatio(foreground, background),
            greaterThanOrEqualTo(4.5),
          );
        }
      }
    });
  });

  group('AppTheme compatibility bridge', () {
    test('registers every Echo token extension in both brightness modes', () {
      for (final theme in [AppTheme.light(), AppTheme.dark()]) {
        final colors = theme.extension<EchoColors>()!;

        expect(theme.extension<EchoTypography>(), isNotNull);
        expect(theme.extension<EchoSpacing>(), EchoSpacing.standard);
        expect(theme.extension<EchoRadii>(), EchoRadii.standard);
        expect(theme.extension<EchoMotion>(), EchoMotion.standard);
        expect(theme.extension<EchoInteraction>(), EchoInteraction.standard);
        expect(theme.extension<EchoBreakpoints>(), EchoBreakpoints.standard);
        expect(theme.colorScheme.primary, colors.accent);
        expect(theme.colorScheme.surface, colors.surface);
        expect(theme.scaffoldBackgroundColor, colors.canvas);
        expect(theme.canvasColor, colors.canvas);
        expect(theme.splashFactory, NoSplash.splashFactory);
      }
    });

    test('does not encode Echo component silhouettes in Material themes', () {
      final source = File('lib/core/theme/app_theme.dart').readAsStringSync();
      const componentThemeTypes = [
        'ButtonThemeData',
        'CardThemeData',
        'ChipThemeData',
        'DialogThemeData',
        'InputDecorationTheme',
        'ListTileThemeData',
        'NavigationBarThemeData',
        'PopupMenuThemeData',
        'SliderThemeData',
        'SnackBarThemeData',
        'SwitchThemeData',
        'TabBarThemeData',
      ];

      for (final type in componentThemeTypes) {
        expect(
          source,
          isNot(contains(type)),
          reason: '$type belongs in Echo UI',
        );
      }
      expect(source, isNot(contains('ColorScheme.fromSeed')));
    });
  });
}
