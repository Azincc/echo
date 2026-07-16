import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/features/player/widgets/player_hero_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:palette_generator/palette_generator.dart';

void main() {
  final visuals = EchoMediaVisuals.fromPalette(
    PaletteGenerator.fromColors(<PaletteColor>[
      PaletteColor(const Color(0xFFFFE36B), 120),
      PaletteColor(const Color(0xFF4E77C8), 30),
      PaletteColor(const Color(0xFFD9B43C), 24),
    ]),
  );

  testWidgets('mini and stage expose the intended backdrop materials', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Row(
          children: <Widget>[
            SizedBox(
              width: 220,
              height: 72,
              child: EchoPlayerBackdrop(
                key: const Key('mini-backdrop'),
                visuals: visuals,
                mode: EchoPlayerBackdropMode.mini,
              ),
            ),
            Expanded(
              child: EchoPlayerBackdrop(
                key: const Key('stage-backdrop'),
                visuals: visuals,
                mode: EchoPlayerBackdropMode.stage,
              ),
            ),
          ],
        ),
      ),
    );

    final miniDecoration = _backdropDecoration(
      tester,
      const Key('mini-backdrop'),
    );
    expect(visuals.foreground.computeLuminance(), lessThan(0.05));
    final miniGradient = miniDecoration.gradient! as LinearGradient;
    expect(miniGradient.colors, <Color>[
      visuals.miniSurface,
      visuals.miniSurface,
      visuals.miniSurface,
    ]);
    expect(
      miniDecoration.borderRadius,
      const BorderRadius.all(Radius.circular(16)),
    );
    expect(miniDecoration.border, isA<Border>());
    expect((miniDecoration.border! as Border).top.color, visuals.controlAccent);
    expect(miniDecoration.boxShadow, isEmpty);

    final stageDecoration = _backdropDecoration(
      tester,
      const Key('stage-backdrop'),
    );
    final stageGradient = stageDecoration.gradient! as LinearGradient;
    expect(stageGradient.colors, <Color>[
      visuals.stageGlow,
      visuals.stageBase,
      visuals.stageBottom,
    ]);
    expect(stageDecoration.borderRadius, BorderRadius.zero);
    expect(stageDecoration.border, isNull);
    expect(stageDecoration.boxShadow, isEmpty);
  });

  testWidgets(
    'background Hero uses one contrast-safe material flight in both directions',
    (tester) async {
      await tester.pumpWidget(_heroApp(visuals: visuals));

      await tester.tap(find.byKey(const Key('open-player')));
      await tester.pump();

      var previousRadius = 16.0;
      for (var step = 1; step <= 3; step += 1) {
        await tester.pump(const Duration(milliseconds: 75));
        final decoration = _flightDecoration(tester);
        _expectContrastSafe(decoration, visuals);
        final radius = _radiusOf(decoration);
        expect(radius, lessThan(previousRadius));
        expect(radius, greaterThan(0));
        expect(decoration.boxShadow, isEmpty);
        previousRadius = radius;

        if (step == 2) {
          final border = decoration.border! as Border;
          expect(border.top.width, greaterThan(0));
          expect(border.top.width, lessThan(1));
        }
      }

      await tester.pump(const Duration(milliseconds: 75));
      final landedStage = _flightDecoration(tester);
      _expectRadiusValue(landedStage, 0);
      expect((landedStage.gradient! as LinearGradient).colors, <Color>[
        visuals.stageGlow,
        visuals.stageBase,
        visuals.stageBottom,
      ]);
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey<String>('player-background-flight')),
        findsNothing,
      );
      final stageDecoration = _backdropDecoration(
        tester,
        const Key('target-backdrop'),
      );
      expect((stageDecoration.gradient! as LinearGradient).colors, <Color>[
        visuals.stageGlow,
        visuals.stageBase,
        visuals.stageBottom,
      ]);

      await tester.tap(find.byKey(const Key('close-player')));
      await tester.pump();

      previousRadius = 0;
      for (var step = 1; step <= 3; step += 1) {
        await tester.pump(const Duration(milliseconds: 75));
        final decoration = _flightDecoration(tester);
        _expectContrastSafe(decoration, visuals);
        final radius = _radiusOf(decoration);
        expect(radius, greaterThan(previousRadius));
        expect(radius, lessThan(16));
        previousRadius = radius;
      }

      await tester.pump(const Duration(milliseconds: 75));
      final landedMini = _flightDecoration(tester);
      _expectRadiusValue(landedMini, 16);
      expect((landedMini.gradient! as LinearGradient).colors, <Color>[
        visuals.miniSurface,
        visuals.miniSurface,
        visuals.miniSurface,
      ]);
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('source-backdrop')), findsOneWidget);
      expect(
        find.byKey(const ValueKey<String>('player-background-flight')),
        findsNothing,
      );
    },
  );

  testWidgets('reduced motion uses the target backdrop without interpolation', (
    tester,
  ) async {
    await tester.pumpWidget(
      _heroApp(visuals: visuals, disableAnimations: true),
    );

    await tester.tap(find.byKey(const Key('open-player')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 75));

    expect(
      find.byKey(const ValueKey<String>('player-background-flight')),
      findsNothing,
    );
    expect(
      tester
          .widgetList<EchoPlayerBackdrop>(find.byType(EchoPlayerBackdrop))
          .map((backdrop) => backdrop.mode),
      contains(EchoPlayerBackdropMode.stage),
    );
  });
}

Widget _heroApp({
  required EchoMediaVisuals visuals,
  bool disableAnimations = false,
}) {
  return MaterialApp(
    builder: (context, child) {
      final mediaQuery = MediaQuery.of(context);
      return MediaQuery(
        data: mediaQuery.copyWith(disableAnimations: disableAnimations),
        child: child!,
      );
    },
    home: _BackdropHeroSource(visuals: visuals),
  );
}

class _BackdropHeroSource extends StatelessWidget {
  const _BackdropHeroSource({required this.visuals});

  final EchoMediaVisuals visuals;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 280,
              height: 72,
              child: Hero(
                tag: playerBackgroundHeroTag,
                createRectTween: playerLinearRectTween,
                flightShuttleBuilder: playerBackgroundFlightShuttleBuilder,
                child: EchoPlayerBackdrop(
                  key: const Key('source-backdrop'),
                  visuals: visuals,
                  mode: EchoPlayerBackdropMode.mini,
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextButton(
              key: const Key('open-player'),
              onPressed: () => Navigator.of(context).push<void>(
                PageRouteBuilder<void>(
                  transitionDuration: const Duration(milliseconds: 300),
                  reverseTransitionDuration: const Duration(milliseconds: 300),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) => child,
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return _BackdropHeroTarget(visuals: visuals);
                  },
                ),
              ),
              child: const Text('Open'),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackdropHeroTarget extends StatelessWidget {
  const _BackdropHeroTarget({required this.visuals});

  final EchoMediaVisuals visuals;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Hero(
              tag: playerBackgroundHeroTag,
              createRectTween: playerLinearRectTween,
              flightShuttleBuilder: playerBackgroundFlightShuttleBuilder,
              child: EchoPlayerBackdrop(
                key: const Key('target-backdrop'),
                visuals: visuals,
                mode: EchoPlayerBackdropMode.stage,
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                key: const Key('close-player'),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

BoxDecoration _backdropDecoration(WidgetTester tester, Key backdropKey) {
  final decoratedBox = find.descendant(
    of: find.byKey(backdropKey),
    matching: find.byType(DecoratedBox),
  );
  return tester.widget<DecoratedBox>(decoratedBox).decoration as BoxDecoration;
}

BoxDecoration _flightDecoration(WidgetTester tester) {
  final decoratedBox = find.byKey(
    const ValueKey<String>('player-background-flight'),
  );
  expect(decoratedBox, findsOneWidget);
  return tester.widget<DecoratedBox>(decoratedBox).decoration as BoxDecoration;
}

double _radiusOf(BoxDecoration decoration) {
  final radius = decoration.borderRadius! as BorderRadius;
  expect(radius.topRight.x, closeTo(radius.topLeft.x, 0.001));
  expect(radius.bottomLeft.x, closeTo(radius.topLeft.x, 0.001));
  expect(radius.bottomRight.x, closeTo(radius.topLeft.x, 0.001));
  return radius.topLeft.x;
}

void _expectRadiusValue(BoxDecoration decoration, double expected) {
  expect(_radiusOf(decoration), closeTo(expected, 0.001));
}

void _expectContrastSafe(BoxDecoration decoration, EchoMediaVisuals visuals) {
  final gradient = decoration.gradient! as LinearGradient;
  for (final color in gradient.colors) {
    expect(
      EchoColors.contrastRatio(visuals.foreground, color),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      EchoColors.contrastRatio(visuals.controlAccent, color),
      greaterThanOrEqualTo(3),
    );
  }
}
