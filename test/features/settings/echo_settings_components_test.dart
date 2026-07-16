import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/features/settings/widgets/echo_settings_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Finder toggleTrack() => find.byWidgetPredicate(
    (widget) =>
        widget is AnimatedContainer &&
        widget.constraints?.minWidth == 52 &&
        widget.constraints?.maxWidth == 52 &&
        widget.constraints?.minHeight == 30 &&
        widget.constraints?.maxHeight == 30,
  );

  Widget appFor({
    required double textScale,
    required ValueChanged<bool> onChanged,
    required VoidCallback onConfigure,
    String title = '歌词提供商',
    String description = '用于获取当前歌曲的同步歌词。',
  }) {
    return MaterialApp(
      theme: AppTheme.light(),
      builder: (context, child) {
        final media = MediaQuery.of(context);
        return MediaQuery(
          data: media.copyWith(
            textScaler: TextScaler.linear(textScale),
            disableAnimations: true,
          ),
          child: child!,
        );
      },
      home: Scaffold(
        body: ReorderableListView(
          onReorder: (_, _) {},
          children: <Widget>[
            EchoProviderSettingRow(
              key: const ValueKey<String>('lyrics-provider'),
              index: 0,
              title: title,
              description: description,
              enabled: false,
              onChanged: onChanged,
              onConfigure: onConfigure,
            ),
          ],
        ),
      ),
    );
  }

  testWidgets('provider toggle keeps a 52x30 track inside a 60x48 target', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    const title = '一个名称很长的歌词提供商';

    for (final textScale in <double>[1, 2]) {
      var changeCount = 0;
      bool? changedValue;
      await tester.pumpWidget(
        appFor(
          textScale: textScale,
          title: title,
          description: '用于获取当前歌曲的同步歌词，并验证窄屏大字体下的布局。',
          onChanged: (value) {
            changeCount += 1;
            changedValue = value;
          },
          onConfigure: () {},
        ),
      );
      await tester.pump();

      final toggleTarget = find.bySemanticsLabel('启用$title');
      expect(toggleTrack(), findsOneWidget);
      final trackRect = tester.getRect(toggleTrack());
      final targetRect = tester.getRect(toggleTarget);
      expect(trackRect.size, const Size(52, 30));
      expect(targetRect.width, greaterThanOrEqualTo(60));
      expect(targetRect.height, greaterThanOrEqualTo(48));
      expect(trackRect.center.dx, closeTo(targetRect.center.dx, 0.001));
      expect(trackRect.center.dy, closeTo(targetRect.center.dy, 0.001));

      await tester.tapAt(Offset(targetRect.center.dx, targetRect.top + 2));
      await tester.pump();

      expect(changeCount, 1);
      expect(changedValue, isTrue);
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('large text keeps provider actions stacked and interactive', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(600, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    bool? changedValue;
    var configureCount = 0;

    await tester.pumpWidget(
      appFor(
        textScale: 2,
        onChanged: (value) => changedValue = value,
        onConfigure: () => configureCount += 1,
      ),
    );
    await tester.pump();

    final toggleTarget = find.bySemanticsLabel('启用歌词提供商');
    final configure = find.bySemanticsLabel('配置歌词提供商');
    final dragHandle = find.byType(ReorderableDragStartListener);
    final statusRect = tester.getRect(find.text('已停用'));
    final toggleRect = tester.getRect(toggleTarget);
    final configureRect = tester.getRect(configure);

    expect(toggleRect.top, greaterThanOrEqualTo(statusRect.bottom));
    expect(configureRect.top, greaterThanOrEqualTo(statusRect.bottom));
    expect(tester.getSize(dragHandle), const Size.square(48));

    await tester.tap(toggleTarget);
    await tester.pump();
    await tester.tap(configure);
    await tester.pump();

    expect(changedValue, isTrue);
    expect(configureCount, 1);
    expect(tester.takeException(), isNull);
  });
}
