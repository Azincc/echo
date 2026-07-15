import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/core/utils/toast_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('global notifications use the Echo message surface', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        scaffoldMessengerKey: rootScaffoldMessengerKey,
        theme: AppTheme.light(),
        home: const Scaffold(body: SizedBox.expand()),
      ),
    );

    ToastNotifier.show('网络异常', kind: EchoMessageKind.error);
    await tester.pump();

    expect(find.text('网络异常'), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
  });
}
