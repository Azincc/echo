import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget app(Widget child, {bool disableAnimations = false}) {
    return MaterialApp(
      theme: AppTheme.dark(),
      home: MediaQuery(
        data: MediaQueryData(disableAnimations: disableAnimations),
        child: Scaffold(body: Center(child: child)),
      ),
    );
  }

  testWidgets('normal motion animates with Echo skeleton colors', (
    tester,
  ) async {
    await tester.pumpWidget(app(const EchoSkeleton(width: 120, height: 16)));
    await tester.pump(const Duration(milliseconds: 300));

    final decoratedBox = tester.widget<DecoratedBox>(
      find.descendant(
        of: find.byType(EchoSkeleton),
        matching: find.byType(DecoratedBox),
      ),
    );
    final decoration = decoratedBox.decoration as BoxDecoration;
    final gradient = decoration.gradient! as LinearGradient;
    final expectedHighlight = Color.alphaBlend(
      EchoColors.nightInk.withValues(alpha: 0.08),
      EchoColors.nightRaised,
    );

    expect(gradient.colors, <Color>[
      EchoColors.nightRaised,
      expectedHighlight,
      EchoColors.nightRaised,
    ]);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('circle keeps 48dp geometry and excludes its semantics', (
    tester,
  ) async {
    await tester.pumpWidget(
      app(const EchoSkeleton.circle(size: 48), disableAnimations: true),
    );

    expect(tester.getSize(find.byType(EchoSkeleton)), const Size(48, 48));
    final exclusion = tester.widget<ExcludeSemantics>(
      find.descendant(
        of: find.byType(EchoSkeleton),
        matching: find.byType(ExcludeSemantics),
      ),
    );
    expect(exclusion.excluding, isTrue);
  });
}
