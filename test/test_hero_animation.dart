import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Hero flight direction pop', (WidgetTester tester) async {
    final navKey = GlobalKey<NavigatorState>();

    final Widget app = MaterialApp(
      navigatorKey: navKey,
      home: Scaffold(
        body: Center(
          child: Hero(
            tag: 'my-hero',
            child: const Text(
              'Mini',
              style: TextStyle(fontSize: 10, color: Colors.black),
            ),
            flightShuttleBuilder:
                (
                  BuildContext flightContext,
                  Animation<double> animation,
                  HeroFlightDirection flightDirection,
                  BuildContext fromHeroContext,
                  BuildContext toHeroContext,
                ) {
                  return AnimatedBuilder(
                    animation: animation,
                    builder: (_, child) {
                      return const Text('Shuttle');
                    },
                  );
                },
          ),
        ),
      ),
    );

    await tester.pumpWidget(app);

    // Push
    navKey.currentState!.push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            body: Center(
              child: Hero(
                tag: 'my-hero',
                child: const Text(
                  'Full',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100)); // During push
    await tester.pumpAndSettle();

    navKey.currentState!.pop();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100)); // During pop
    await tester.pumpAndSettle();
  });
}
