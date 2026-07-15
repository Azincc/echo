import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Echo semantic tokens', () {
    test('light and dark palettes keep stable chrome', () {
      final light = EchoColors.light();
      final dark = EchoColors.dark();

      expect(light.canvas, EchoColors.dayCanvas);
      expect(light.surface, EchoColors.daySurface);
      expect(dark.canvas, EchoColors.nightCanvas);
      expect(dark.surface, EchoColors.nightSurface);
      expect(light.canvas, isNot(dark.canvas));
    });

    test('accent foregrounds meet WCAG AA for varied user colors', () {
      const candidates = <Color>[
        Color(0xFFFFFFFF),
        Color(0xFFFFFF00),
        Color(0xFF00E5FF),
        Color(0xFF050505),
        Color(0xFF7E57C2),
      ];

      for (final candidate in candidates) {
        for (final palette in <EchoColors>[
          EchoColors.light(accent: candidate),
          EchoColors.dark(accent: candidate),
        ]) {
          expect(
            EchoColors.contrastRatio(palette.onAccent, palette.accent),
            greaterThanOrEqualTo(4.5),
          );
          expect(
            EchoColors.contrastRatio(palette.accent, palette.canvas),
            greaterThanOrEqualTo(4.5),
          );
        }
      }
    });

    test(
      'dynamic content surfaces are normalized for readable foregrounds',
      () {
        const foreground = Colors.white;
        const candidates = <Color>[
          Color(0xFFFFFF00),
          Color(0xFF00E5FF),
          Color(0xFFFFFFFF),
          Color(0xFF7E57C2),
        ];

        for (final candidate in candidates) {
          final normalized = EchoColors.ensureForegroundContrast(
            candidate,
            foreground: foreground,
          );
          expect(
            EchoColors.contrastRatio(foreground, normalized),
            greaterThanOrEqualTo(4.5),
          );
        }
      },
    );

    test('message accents are normalized against inverse surfaces', () {
      final colors = EchoColors.light();
      final action = EchoColors.ensureColorContrast(
        colors.accent,
        background: colors.ink,
      );
      expect(
        EchoColors.contrastRatio(action, colors.ink),
        greaterThanOrEqualTo(4.5),
      );
    });

    test('error and warning inks meet WCAG AA on every stable surface', () {
      for (final palette in <EchoColors>[
        EchoColors.light(),
        EchoColors.dark(),
      ]) {
        for (final surface in <Color>[
          palette.canvas,
          palette.surface,
          palette.raised,
        ]) {
          expect(
            EchoColors.contrastRatio(palette.error, surface),
            greaterThanOrEqualTo(4.5),
          );
          expect(
            EchoColors.contrastRatio(palette.warning, surface),
            greaterThanOrEqualTo(4.5),
          );
        }
        expect(
          EchoColors.contrastRatio(palette.onError, palette.error),
          greaterThanOrEqualTo(4.5),
        );
        expect(
          EchoColors.contrastRatio(palette.onWarning, palette.warning),
          greaterThanOrEqualTo(4.5),
        );
      }
    });

    test('interactive control boundaries meet non-text contrast', () {
      for (final palette in <EchoColors>[
        EchoColors.light(),
        EchoColors.dark(),
      ]) {
        for (final surface in <Color>[
          palette.canvas,
          palette.surface,
          palette.raised,
        ]) {
          expect(
            EchoColors.contrastRatio(palette.controlBoundary, surface),
            greaterThanOrEqualTo(3),
          );
        }
      }
    });

    test('token extensions support copyWith and lerp', () {
      final light = EchoColors.light();
      final dark = EchoColors.dark();
      final typography = EchoTypography.standard(light);

      expect(light.copyWith(accent: Colors.red).accent, Colors.red);
      expect(light.lerp(dark, 0.5).canvas, isNot(light.canvas));
      expect(typography.copyWith(title: typography.display).title.fontSize, 32);
      expect(
        typography.lerp(EchoTypography.standard(dark), 0.5).body,
        isA<TextStyle>(),
      );
      expect(EchoSpacing.standard.copyWith(md: 20).md, 20);
      expect(
        EchoSpacing.standard
            .lerp(EchoSpacing.standard.copyWith(md: 24), 0.5)
            .md,
        20,
      );
      expect(
        EchoRadii.standard.copyWith(control: EchoRadii.standard.scene).control,
        EchoRadii.standard.scene,
      );
      expect(
        EchoRadii.standard.lerp(EchoRadii.standard, 0.5).surface,
        EchoRadii.standard.surface,
      );
      expect(
        EchoMotion.standard.copyWith(feedback: Duration.zero).feedback,
        Duration.zero,
      );
      expect(
        EchoMotion.standard
            .lerp(
              EchoMotion.standard.copyWith(
                feedback: const Duration(milliseconds: 200),
              ),
              0.5,
            )
            .feedback,
        const Duration(milliseconds: 180),
      );
      expect(
        EchoInteraction.standard
            .copyWith(minimumTouchTarget: 52)
            .minimumTouchTarget,
        52,
      );
      expect(
        EchoInteraction.standard
            .lerp(
              EchoInteraction.standard.copyWith(minimumTouchTarget: 56),
              0.5,
            )
            .minimumTouchTarget,
        52,
      );
      expect(EchoBreakpoints.standard.copyWith(medium: 640).medium, 640);
      expect(
        EchoBreakpoints.standard
            .lerp(EchoBreakpoints.standard.copyWith(medium: 640), 0.5)
            .medium,
        620,
      );
    });

    test('breakpoints use the documented three structural widths', () {
      expect(EchoBreakpoints.standard.classify(599), EchoWindowClass.compact);
      expect(EchoBreakpoints.standard.classify(600), EchoWindowClass.medium);
      expect(EchoBreakpoints.standard.classify(839), EchoWindowClass.medium);
      expect(EchoBreakpoints.standard.classify(840), EchoWindowClass.expanded);
    });
  });

  group('AppTheme bridge', () {
    test('registers every Echo ThemeExtension in both modes', () {
      for (final theme in <ThemeData>[AppTheme.light(), AppTheme.dark()]) {
        expect(theme.extension<EchoColors>(), isNotNull);
        expect(theme.extension<EchoTypography>(), isNotNull);
        expect(theme.extension<EchoSpacing>(), isNotNull);
        expect(theme.extension<EchoRadii>(), isNotNull);
        expect(theme.extension<EchoMotion>(), isNotNull);
        expect(theme.extension<EchoInteraction>(), isNotNull);
        expect(theme.extension<EchoBreakpoints>(), isNotNull);
        expect(theme.splashFactory, NoSplash.splashFactory);
      }
    });

    testWidgets('BuildContext exposes registered tokens and window class', (
      tester,
    ) async {
      late EchoColors colors;
      late EchoWindowClass windowClass;
      late double pagePadding;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Builder(
            builder: (context) {
              colors = context.echoColors;
              windowClass = context.echoWindowClass;
              pagePadding = context.echoPageHorizontalPadding;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(colors.canvas, EchoColors.dayCanvas);
      expect(windowClass, EchoWindowClass.medium);
      expect(pagePadding, EchoSpacing.standard.lg);
    });
  });

  group('Echo interaction primitives', () {
    testWidgets('buttons expose 48dp targets and activate', (tester) async {
      var activations = 0;
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  EchoIconButton(
                    icon: AppIcons.play,
                    label: '播放',
                    onPressed: () => activations++,
                  ),
                  EchoButton.primary(
                    label: '重试',
                    onPressed: () => activations++,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(tester.getSize(find.byType(EchoIconButton)), const Size(48, 48));
      expect(
        tester.getSize(find.byType(EchoButton)).height,
        greaterThanOrEqualTo(48),
      );
      expect(find.bySemanticsLabel('播放'), findsOneWidget);

      await tester.tap(find.byType(EchoIconButton));
      await tester.tap(find.byType(EchoButton));
      expect(activations, 2);
    });

    testWidgets('long-press-only targets remain enabled and interactive', (
      tester,
    ) async {
      var activations = 0;
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: EchoPressable(
              onPressed: null,
              onLongPress: () => activations++,
              child: const Text('任务行'),
            ),
          ),
        ),
      );

      expect(
        tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity)).opacity,
        1,
      );
      await tester.longPress(find.text('任务行'));
      expect(activations, 1);
    });

    testWidgets('skeleton becomes static when animations are disabled', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const MediaQuery(
            data: MediaQueryData(disableAnimations: true),
            child: EchoSkeleton(width: 120, height: 16),
          ),
        ),
      );

      expect(find.byType(EchoSkeleton), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    test('AppIcons are backed by the Remix icon font', () {
      expect(AppIcons.play.fontPackage, 'remixicon');
      expect(AppIcons.library.fontPackage, 'remixicon');
    });
  });
}
