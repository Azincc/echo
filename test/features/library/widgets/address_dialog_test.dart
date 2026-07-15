import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/features/library/widgets/address_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildDialog() {
    return const MaterialApp(
      home: Scaffold(body: AddressDialog(libraryId: 'lib-1')),
    );
  }

  Finder addressEditor() => find.descendant(
    of: find.byWidgetPredicate(
      (widget) => widget is EchoTextField && widget.label == '服务器地址',
    ),
    matching: find.byType(TextField),
  );

  testWidgets('shows warning icon for http urls and opens hint dialog', (
    tester,
  ) async {
    await tester.pumpWidget(buildDialog());

    expect(addressEditor(), findsOneWidget);
    await tester.enterText(addressEditor(), 'http://192.168.1.5:4533');
    await tester.pumpAndSettle();

    final warningAction = find.bySemanticsLabel('HTTP 使用提示');
    expect(warningAction, findsOneWidget);

    await tester.tap(warningAction);
    await tester.pumpAndSettle();

    expect(find.text('HTTP 使用提示'), findsOneWidget);
    expect(find.text('优先使用 HTTPS。只有在可信局域网中才建议使用 HTTP。'), findsNWidgets(2));
    expect(find.text('知道了'), findsOneWidget);
  });

  testWidgets('does not show warning icon for https urls', (tester) async {
    await tester.pumpWidget(buildDialog());

    expect(addressEditor(), findsOneWidget);
    await tester.enterText(addressEditor(), 'https://music.example.com');
    await tester.pumpAndSettle();

    expect(find.bySemanticsLabel('HTTP 使用提示'), findsNothing);
  });
}
