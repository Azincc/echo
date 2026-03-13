import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echoes/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));

    expect(find.byType(App), findsOneWidget);
    expect(find.byType(ProviderScope), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 600));
  });
}
