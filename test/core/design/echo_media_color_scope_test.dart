import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'media scopes map light and dark artwork into accessible local tokens',
    (tester) async {
      final visualsCases = <EchoMediaVisuals>[
        EchoMediaVisuals.fallback(seed: const Color(0xFFFFE36B)),
        EchoMediaVisuals.fallback(seed: const Color(0xFF101D33)),
      ];

      for (final theme in <ThemeData>[AppTheme.light(), AppTheme.dark()]) {
        for (final visuals in visualsCases) {
          for (final role in EchoMediaSurfaceRole.values) {
            late EchoColors outerColors;
            late EchoColors scopedColors;
            late EchoTypography scopedTypography;
            late EchoSpacing outerSpacing;
            late EchoSpacing scopedSpacing;
            late EchoRadii outerRadii;
            late EchoRadii scopedRadii;
            late EchoMotion outerMotion;
            late EchoMotion scopedMotion;
            late EchoInteraction outerInteraction;
            late EchoInteraction scopedInteraction;
            late EchoBreakpoints outerBreakpoints;
            late EchoBreakpoints scopedBreakpoints;
            late Brightness scopedBrightness;

            await tester.pumpWidget(
              MaterialApp(
                theme: theme,
                darkTheme: theme,
                themeMode: theme.brightness == Brightness.dark
                    ? ThemeMode.dark
                    : ThemeMode.light,
                home: Builder(
                  builder: (outerContext) {
                    outerColors = outerContext.echoColors;
                    outerSpacing = outerContext.echoSpacing;
                    outerRadii = outerContext.echoRadii;
                    outerMotion = outerContext.echoMotion;
                    outerInteraction = outerContext.echoInteraction;
                    outerBreakpoints = outerContext.echoBreakpoints;
                    return EchoMediaColorScope(
                      visuals: visuals,
                      role: role,
                      child: Builder(
                        builder: (innerContext) {
                          scopedColors = innerContext.echoColors;
                          scopedTypography = innerContext.echoTypography;
                          scopedSpacing = innerContext.echoSpacing;
                          scopedRadii = innerContext.echoRadii;
                          scopedMotion = innerContext.echoMotion;
                          scopedInteraction = innerContext.echoInteraction;
                          scopedBreakpoints = innerContext.echoBreakpoints;
                          scopedBrightness = Theme.of(innerContext).brightness;
                          return const SizedBox.shrink();
                        },
                      ),
                    );
                  },
                ),
              ),
            );
            await tester.pumpAndSettle();

            final expectedSurface = switch (role) {
              EchoMediaSurfaceRole.stage => visuals.stageBase,
              EchoMediaSurfaceRole.mini => visuals.miniSurface,
              EchoMediaSurfaceRole.panel => visuals.panelSurface,
            };
            final expectedRaised = switch (role) {
              EchoMediaSurfaceRole.stage => visuals.stageGlow,
              EchoMediaSurfaceRole.mini => visuals.panelSurface,
              EchoMediaSurfaceRole.panel => visuals.miniSurface,
            };

            expect(scopedColors, isNot(outerColors));
            expect(scopedColors.canvas, expectedSurface);
            expect(scopedColors.surface, expectedSurface);
            expect(scopedColors.raised, expectedRaised);
            expect(scopedColors.ink, visuals.foreground);
            expect(scopedColors.muted, visuals.mutedForeground);
            expect(scopedColors.accent, visuals.controlAccent);
            expect(scopedColors.controlBoundary, visuals.controlAccent);
            expect(scopedTypography.display.color, visuals.foreground);
            expect(scopedTypography.headline.color, visuals.foreground);
            expect(scopedTypography.title.color, visuals.foreground);
            expect(scopedTypography.body.color, visuals.foreground);
            expect(scopedTypography.label.color, visuals.foreground);
            expect(scopedTypography.metadata.color, visuals.mutedForeground);
            expect(scopedSpacing, same(outerSpacing));
            expect(scopedRadii, same(outerRadii));
            expect(scopedMotion, same(outerMotion));
            expect(scopedInteraction, same(outerInteraction));
            expect(scopedBreakpoints, same(outerBreakpoints));
            expect(scopedBrightness, theme.brightness);
            _expectAccessibleScope(scopedColors, visuals);
          }
        }
      }
    },
  );
}

void _expectAccessibleScope(EchoColors colors, EchoMediaVisuals visuals) {
  final surfaces = <Color>{
    colors.canvas,
    colors.surface,
    colors.raised,
    visuals.stageBase,
    visuals.stageGlow,
    visuals.stageBottom,
    visuals.miniSurface,
    visuals.panelSurface,
  };
  for (final surface in surfaces) {
    for (final foreground in <Color>[
      colors.ink,
      colors.muted,
      colors.error,
      colors.warning,
    ]) {
      expect(
        EchoColors.contrastRatio(foreground, surface),
        greaterThanOrEqualTo(4.5),
      );
    }
    for (final boundary in <Color>[
      colors.accent,
      colors.controlBoundary,
      colors.divider,
      colors.onDisabled,
    ]) {
      expect(
        EchoColors.contrastRatio(boundary, surface),
        greaterThanOrEqualTo(3),
      );
    }
  }

  for (final (foreground, background) in <(Color, Color)>[
    (colors.onAccent, colors.accent),
    (colors.onContentTint, colors.contentTint),
    (colors.onError, colors.error),
    (colors.onWarning, colors.warning),
  ]) {
    expect(
      EchoColors.contrastRatio(foreground, background),
      greaterThanOrEqualTo(4.5),
    );
  }
  expect(
    EchoColors.contrastRatio(colors.onDisabled, colors.disabled),
    greaterThanOrEqualTo(3),
  );
}
