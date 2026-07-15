import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildSubject({required bool disableAnimations}) {
    return MaterialApp(
      theme: AppTheme.dark(),
      home: MediaQuery(
        data: MediaQueryData(disableAnimations: disableAnimations),
        child: const Scaffold(
          body: Center(
            child: ShimmerEffect(child: SkeletonBox(width: 120, height: 16)),
          ),
        ),
      ),
    );
  }

  testWidgets('animates with Echo colors under normal motion', (tester) async {
    await tester.pumpWidget(buildSubject(disableAnimations: false));
    await tester.pump();

    expect(find.byType(ShaderMask), findsOneWidget);
    final box = tester.widget<Container>(
      find.descendant(
        of: find.byType(SkeletonBox),
        matching: find.byType(Container),
      ),
    );
    final decoration = box.decoration! as BoxDecoration;
    expect(decoration.color, EchoColors.nightRaised);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('becomes static when reduced motion is requested', (
    tester,
  ) async {
    await tester.pumpWidget(buildSubject(disableAnimations: true));
    await tester.pump(const Duration(seconds: 2));

    expect(find.byType(ShaderMask), findsNothing);
    expect(find.byType(SkeletonBox), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('circle skeleton preserves its requested 48dp target', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(body: SkeletonBox.circle(size: 48)),
      ),
    );

    expect(tester.getSize(find.byType(SkeletonBox)), const Size(48, 48));
  });
}
