import 'dart:async';

import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('EchoRefreshView uses custom refresh feedback', (tester) async {
    final refreshCompleter = Completer<void>();
    var refreshCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: EchoRefreshView(
            onRefresh: () {
              refreshCount += 1;
              return refreshCompleter.future;
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: const <Widget>[SizedBox(height: 900)],
            ),
          ),
        ),
      ),
    );

    await tester.fling(find.byType(ListView), const Offset(0, 300), 1000);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(refreshCount, 1);
    expect(find.text('正在刷新'), findsOneWidget);
    expect(find.byType(RefreshProgressIndicator), findsNothing);
    expect(
      tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity)).opacity,
      1,
    );

    refreshCompleter.complete();
    await tester.pumpAndSettle();

    expect(
      tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity)).opacity,
      0,
    );
  });
}
