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
                  final fromText =
                      (fromHeroContext.widget as Hero).child as Text;
                  final toText = (toHeroContext.widget as Hero).child as Text;

                  print('--- Builder Called ---');
                  print('Direction: $flightDirection');
                  print('fromHero: ${fromText.data}');
                  print('toHero: ${toText.data}');

                  return AnimatedBuilder(
                    animation: animation,
                    builder: (context, _) {
                      print(
                        'Animation value: ${animation.value} (Direction: $flightDirection)',
                      );
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

    print('====== NOW POPPING ======');
    navKey.currentState!.pop();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100)); // During pop
    await tester.pumpAndSettle();
  });
}
