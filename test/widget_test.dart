import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echoes/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: App(),
      ),
    );

    // Verify that the app displays the splash screen
    expect(find.text('SubSonic Flow'), findsOneWidget);

    // Drain splash delay timer to avoid pending timer failure.
    await tester.pump(const Duration(milliseconds: 600));
  });
}
