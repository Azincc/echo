import 'dart:ui' show SemanticsAction;

import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/features/player/widgets/player_scrubber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('keeps a 48dp target and expands only while seeking', (
    tester,
  ) async {
    double value = 25;
    var startCount = 0;
    var endCount = 0;
    var cancelCount = 0;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark(),
        home: StatefulBuilder(
          builder: (context, setState) {
            return Scaffold(
              body: Center(
                child: SizedBox(
                  width: 240,
                  child: EchoPlayerScrubber(
                    value: value,
                    min: 0,
                    max: 100,
                    secondaryValue: 60,
                    semanticLabel: '播放进度',
                    semanticValue: '${value.round()}%',
                    onChangeStart: (_) => startCount += 1,
                    onChangeEnd: (_) => endCount += 1,
                    onChangeCancel: (_) => cancelCount += 1,
                    onChanged: (next) => setState(() => value = next),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );

    final scrubber = find.byKey(const ValueKey<String>('echo-player-scrubber'));
    expect(tester.getSize(scrubber).height, 48);
    expect(
      tester
          .getSize(
            find.byKey(const ValueKey<String>('echo-player-scrubber-thumb')),
          )
          .width,
      6,
    );

    final gesture = await tester.startGesture(tester.getCenter(scrubber));
    await tester.pumpAndSettle();
    expect(
      tester
          .getSize(
            find.byKey(const ValueKey<String>('echo-player-scrubber-thumb')),
          )
          .width,
      14,
    );

    await gesture.moveBy(const Offset(80, 0));
    await tester.pump();
    await gesture.up();
    await tester.pumpAndSettle();
    expect(value, greaterThan(50));
    expect((startCount, endCount, cancelCount), (1, 1, 0));
    expect(
      tester
          .getSize(
            find.byKey(const ValueKey<String>('echo-player-scrubber-thumb')),
          )
          .width,
      6,
    );
  });

  testWidgets('tap and canceled gestures close exactly one seek session', (
    tester,
  ) async {
    double value = 20;
    var startCount = 0;
    var endCount = 0;
    var cancelCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: StatefulBuilder(
          builder: (context, setState) {
            return Center(
              child: SizedBox(
                width: 240,
                child: EchoPlayerScrubber(
                  value: value,
                  min: 0,
                  max: 100,
                  semanticLabel: '播放进度',
                  onChangeStart: (_) => startCount += 1,
                  onChangeEnd: (_) => endCount += 1,
                  onChangeCancel: (_) => cancelCount += 1,
                  onChanged: (next) => setState(() => value = next),
                ),
              ),
            );
          },
        ),
      ),
    );

    final scrubber = find.byKey(const ValueKey<String>('echo-player-scrubber'));
    await tester.tapAt(tester.getCenter(scrubber));
    await tester.pump();
    expect((startCount, endCount, cancelCount), (1, 1, 0));

    final canceledGesture = await tester.startGesture(
      tester.getCenter(scrubber),
    );
    await tester.pumpAndSettle();
    await canceledGesture.cancel();
    await tester.pump();

    expect((startCount, endCount, cancelCount), (2, 1, 1));
  });

  testWidgets('exposes adjustable slider semantics', (tester) async {
    double value = 50;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: StatefulBuilder(
          builder: (context, setState) {
            return EchoPlayerScrubber(
              value: value,
              min: 0,
              max: 100,
              semanticLabel: '播放进度',
              semanticValue: '${value.round()}%',
              semanticStep: 10,
              semanticValueFormatter: (next) => '${next.round()}%',
              onChanged: (next) => setState(() => value = next),
            );
          },
        ),
      ),
    );

    final finder = find.bySemanticsLabel('播放进度');
    final semantics = tester.getSemantics(finder).getSemanticsData();
    expect(semantics.hasAction(SemanticsAction.increase), isTrue);
    expect(semantics.hasAction(SemanticsAction.decrease), isTrue);
    expect(semantics.increasedValue, '60%');
    expect(semantics.decreasedValue, '40%');
    tester.semantics.increase(find.semantics.byLabel('播放进度'));
    await tester.pump();
    expect(value, 60);
    expect(tester.getSemantics(finder).getSemanticsData().value, '60%');
  });
}
