import 'package:azlistview/azlistview.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/features/library/widgets/library_collection_components.dart';
import 'package:echoes/utils/az_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('A-Z rail fades in while scrolling and out after its linger', (
    tester,
  ) async {
    await _pumpIndex(tester);

    expect(_indexOpacity(tester), 0);
    expect(_azList(tester).indexBarWidth, 24);
    expect(_azList(tester).indexBarHeight, isNull);

    await tester.drag(_azFinder, const Offset(0, -160));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 160));

    expect(_indexOpacity(tester), closeTo(0.96, 0.01));
    expect(_azList(tester).indexBarWidth, 24);

    await tester.pump(const Duration(milliseconds: 1199));
    expect(_indexOpacity(tester), greaterThan(0));

    await tester.pump(const Duration(milliseconds: 1));
    await tester.pump(const Duration(milliseconds: 160));
    expect(_indexOpacity(tester), 0);
    expect(_azList(tester).indexBarWidth, 24);
  });

  testWidgets('right-edge pointer keeps the rail visible until release', (
    tester,
  ) async {
    await _pumpIndex(tester);
    final rect = tester.getRect(_azFinder);
    final gesture = await tester.startGesture(
      Offset(rect.right - 8, rect.center.dy),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 160));

    expect(_indexOpacity(tester), closeTo(0.96, 0.01));

    await tester.pump(const Duration(seconds: 2));
    expect(_indexOpacity(tester), closeTo(0.96, 0.01));

    await gesture.up();
    await tester.pump(const Duration(milliseconds: 1200));
    await tester.pump(const Duration(milliseconds: 160));
    expect(_indexOpacity(tester), 0);
  });

  testWidgets('reduced motion updates the A-Z rail immediately', (
    tester,
  ) async {
    await _pumpIndex(tester, disableAnimations: true);
    final animation = tester.widget<TweenAnimationBuilder<double>>(
      find.byType(TweenAnimationBuilder<double>),
    );
    expect(animation.duration, Duration.zero);

    final rect = tester.getRect(_azFinder);
    final gesture = await tester.startGesture(
      Offset(rect.right - 8, rect.center.dy),
    );
    await tester.pump();
    expect(_indexOpacity(tester), closeTo(0.96, 0.01));

    await gesture.up();
    await tester.pump(const Duration(milliseconds: 1200));
    await tester.pump();
    expect(_indexOpacity(tester), 0);
  });

  testWidgets('large text keeps the glasslike rail compact', (tester) async {
    await _pumpIndex(tester, textScale: 2);

    final options = _azList(tester).indexBarOptions;
    expect(options.textStyle.fontSize, 5.5);
    expect(options.indexHintTextStyle.fontSize, 12);
    expect(_azList(tester).indexBarWidth, 24);
    expect(tester.takeException(), isNull);
  });
}

const _azKey = ValueKey<String>('test-az-list');
Finder get _azFinder => find.byKey(_azKey);

AzListView _azList(WidgetTester tester) {
  return tester.widget<AzListView>(_azFinder);
}

double _indexOpacity(WidgetTester tester) {
  final decoration =
      _azList(tester).indexBarOptions.decoration! as BoxDecoration;
  return decoration.color!.a;
}

Future<void> _pumpIndex(
  WidgetTester tester, {
  bool disableAnimations = false,
  double textScale = 1,
}) async {
  final items = List<AzItem<int>>.generate(32, (index) {
    final tag = index < 16 ? 'A' : 'B';
    return AzItem<int>(data: index, tag: tag, namePinyin: '$tag$index');
  });
  SuspensionUtil.setShowSuspensionStatus(items);

  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(),
      home: MediaQuery(
        data: MediaQueryData(
          disableAnimations: disableAnimations,
          textScaler: TextScaler.linear(textScale),
        ),
        child: Scaffold(
          body: SizedBox(
            width: 320,
            height: 480,
            child: EchoAzIndexReveal(
              builder: (context, opacity, _) => AzListView(
                key: _azKey,
                data: items,
                itemCount: items.length,
                itemBuilder: (context, index) =>
                    SizedBox(height: 48, child: Text('Item $index')),
                indexBarData: const <String>['A', 'B'],
                indexBarWidth: 24,
                indexBarMargin: const EdgeInsetsDirectional.only(end: 4),
                indexBarOptions: echoIndexBarOptions(context, opacity: opacity),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
}
