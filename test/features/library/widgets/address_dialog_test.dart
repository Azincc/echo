import 'package:echoes/features/library/widgets/address_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildDialog() {
    return const MaterialApp(
      home: Scaffold(body: AddressDialog(libraryId: 'lib-1')),
    );
  }

  testWidgets('shows warning icon for http urls and opens hint dialog', (
    tester,
  ) async {
    await tester.pumpWidget(buildDialog());

    await tester.enterText(
      find.widgetWithText(TextFormField, '服务器地址'),
      'http://192.168.1.5:4533',
    );
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.warning_amber_rounded), findsOneWidget);

    await tester.tap(find.byIcon(Icons.warning_amber_rounded));
    await tester.pumpAndSettle();

    expect(find.text('HTTP 使用提示'), findsOneWidget);
    expect(find.text('优先使用 HTTPS。只有在可信局域网中才建议使用 HTTP。'), findsOneWidget);
  });

  testWidgets('does not show warning icon for https urls', (tester) async {
    await tester.pumpWidget(buildDialog());

    await tester.enterText(
      find.widgetWithText(TextFormField, '服务器地址'),
      'https://music.example.com',
    );
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.warning_amber_rounded), findsNothing);
  });
}
