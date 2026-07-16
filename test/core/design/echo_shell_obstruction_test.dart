import 'package:echoes/core/design/echo_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shell obstruction defaults to zero and follows its scope', (
    tester,
  ) async {
    var obstruction = -1.0;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            obstruction = context.echoShellBottomObstruction;
            return const SizedBox();
          },
        ),
      ),
    );
    expect(obstruction, 0);

    await tester.pumpWidget(
      MaterialApp(
        home: EchoShellObstructionScope(
          bottom: 96,
          child: Builder(
            builder: (context) {
              obstruction = context.echoShellBottomObstruction;
              return const SizedBox();
            },
          ),
        ),
      ),
    );
    expect(obstruction, 96);
  });
}
