import 'dart:ui' show PointerDeviceKind, SemanticsAction, Tristate;

import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget app(Widget child) {
    return MaterialApp(
      theme: AppTheme.light(),
      home: Scaffold(body: Center(child: child)),
    );
  }

  group('EchoPressable semantics', () {
    testWidgets('simple media rows expose one label and a 48dp target', (
      tester,
    ) async {
      var activations = 0;

      await tester.pumpWidget(
        app(
          EchoPressable(
            semanticLabel: '晨光，示例歌手，03:24',
            onPressed: () => activations++,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Semantics(
                  label: '晨光封面',
                  image: true,
                  child: const SizedBox.square(dimension: 32),
                ),
                const SizedBox(width: 8),
                const Text('晨光'),
              ],
            ),
          ),
        ),
      );

      expect(find.bySemanticsLabel('晨光，示例歌手，03:24'), findsOneWidget);
      expect(find.bySemanticsLabel('晨光封面'), findsNothing);
      expect(find.bySemanticsLabel('晨光'), findsNothing);
      expect(
        tester.getSize(find.byType(EchoPressable)).height,
        greaterThanOrEqualTo(48),
      );

      await tester.tap(find.bySemanticsLabel('晨光，示例歌手，03:24'));
      expect(activations, 1);
    });

    testWidgets('composite rows preserve pause and delete child actions', (
      tester,
    ) async {
      var pauses = 0;
      var deletes = 0;

      await tester.pumpWidget(
        app(
          SizedBox(
            width: 320,
            child: EchoPressable(
              semanticLabel: '晨光，正在下载，42%',
              semanticsMode: EchoPressableSemanticsMode.explicitChildren,
              minimumSize: const Size(double.infinity, 72),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const ExcludeSemantics(child: Text('晨光，正在下载，42%')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      EchoIconButton(
                        icon: Icons.pause,
                        label: '暂停 晨光',
                        onPressed: () => pauses++,
                      ),
                      EchoIconButton(
                        icon: Icons.delete_outline,
                        label: '删除 晨光',
                        onPressed: () => deletes++,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.bySemanticsLabel('晨光，正在下载，42%'), findsOneWidget);
      expect(find.bySemanticsLabel('暂停 晨光'), findsOneWidget);
      expect(find.bySemanticsLabel('删除 晨光'), findsOneWidget);
      final rowNode = tester.getSemantics(find.bySemanticsLabel('晨光，正在下载，42%'));
      expect(rowNode.flagsCollection.isButton, isFalse);
      expect(rowNode.flagsCollection.isEnabled, Tristate.none);
      expect(
        tester.getSize(find.bySemanticsLabel('暂停 晨光')),
        const Size(48, 48),
      );
      expect(
        tester.getSize(find.bySemanticsLabel('删除 晨光')),
        const Size(48, 48),
      );

      await tester.tap(find.bySemanticsLabel('暂停 晨光'));
      await tester.tap(find.bySemanticsLabel('删除 晨光'));
      expect(pauses, 1);
      expect(deletes, 1);
    });

    testWidgets('disabled targets expose state without an activation action', (
      tester,
    ) async {
      await tester.pumpWidget(
        app(
          const EchoPressable(
            semanticLabel: '不可播放歌曲',
            selected: true,
            child: Text('不可播放歌曲'),
          ),
        ),
      );

      final node = tester.getSemantics(find.bySemanticsLabel('不可播放歌曲'));
      expect(node.flagsCollection.isEnabled, Tristate.isFalse);
      expect(node.flagsCollection.isSelected, Tristate.isTrue);
      expect(node.getSemanticsData().hasAction(SemanticsAction.tap), isFalse);
      expect(
        tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity)).opacity,
        0.5,
      );
    });

    testWidgets('toggle state is forwarded to the semantic node', (
      tester,
    ) async {
      await tester.pumpWidget(
        app(
          EchoPressable(
            semanticLabel: '离线模式',
            toggled: true,
            onPressed: () {},
            child: const Text('离线模式'),
          ),
        ),
      );

      final node = tester.getSemantics(find.bySemanticsLabel('离线模式'));
      expect(node.flagsCollection.isToggled, Tristate.isTrue);
      expect(node.flagsCollection.isEnabled, Tristate.isTrue);
    });
  });

  group('EchoPressable focus feedback', () {
    for (final pointerKind in <PointerDeviceKind>[
      PointerDeviceKind.touch,
      PointerDeviceKind.mouse,
    ]) {
      testWidgets('$pointerKind activation does not request focus', (
        tester,
      ) async {
        final focusManager = FocusManager.instance;
        final previousStrategy = focusManager.highlightStrategy;
        focusManager.highlightStrategy =
            FocusHighlightStrategy.alwaysTraditional;
        addTearDown(() => focusManager.highlightStrategy = previousStrategy);
        var activations = 0;

        await tester.pumpWidget(
          app(
            EchoPressable(
              semanticLabel: '音乐流',
              selected: true,
              onPressed: () => activations++,
              child: const Text('音乐流'),
            ),
          ),
        );

        final pressable = find.byType(EchoPressable);
        final focusNode = _pressableFocusNode(tester, pressable);
        expect(focusNode.hasPrimaryFocus, isFalse);

        await tester.tap(pressable, kind: pointerKind);
        await tester.pump();

        expect(activations, 1);
        expect(focusNode.hasPrimaryFocus, isFalse);
        expect(_focusBorderColor(tester, pressable), Colors.transparent);
        expect(
          tester
              .getSemantics(find.bySemanticsLabel('音乐流'))
              .flagsCollection
              .isSelected,
          Tristate.isTrue,
        );
      });
    }

    testWidgets('Tab focus shows a ring and keeps keyboard activation', (
      tester,
    ) async {
      final focusManager = FocusManager.instance;
      final previousStrategy = focusManager.highlightStrategy;
      focusManager.highlightStrategy = FocusHighlightStrategy.alwaysTraditional;
      addTearDown(() => focusManager.highlightStrategy = previousStrategy);
      var activations = 0;

      await tester.pumpWidget(
        app(
          EchoPressable(
            semanticLabel: '播放',
            onPressed: () => activations++,
            child: const Text('播放'),
          ),
        ),
      );

      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();

      final pressable = find.byType(EchoPressable);
      expect(_pressableFocusNode(tester, pressable).hasPrimaryFocus, isTrue);
      expect(
        _focusBorderColor(tester, pressable),
        tester.element(pressable).echoColors.accent,
      );

      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      expect(activations, 2);
    });

    testWidgets('touch highlight mode hides the ring without clearing focus', (
      tester,
    ) async {
      final focusManager = FocusManager.instance;
      final previousStrategy = focusManager.highlightStrategy;
      focusManager.highlightStrategy = FocusHighlightStrategy.alwaysTraditional;
      addTearDown(() => focusManager.highlightStrategy = previousStrategy);

      await tester.pumpWidget(
        app(
          EchoPressable(
            semanticLabel: '队列',
            autofocus: true,
            onPressed: () {},
            child: const Text('队列'),
          ),
        ),
      );
      await tester.pump();

      final pressable = find.byType(EchoPressable);
      final focusNode = _pressableFocusNode(tester, pressable);
      expect(focusNode.hasPrimaryFocus, isTrue);
      expect(
        _focusBorderColor(tester, pressable),
        tester.element(pressable).echoColors.accent,
      );

      focusManager.highlightStrategy = FocusHighlightStrategy.alwaysTouch;
      await tester.pump();

      expect(focusNode.hasPrimaryFocus, isTrue);
      expect(_focusBorderColor(tester, pressable), Colors.transparent);
    });

    testWidgets('a focused child control does not light the parent row', (
      tester,
    ) async {
      final focusManager = FocusManager.instance;
      final previousStrategy = focusManager.highlightStrategy;
      focusManager.highlightStrategy = FocusHighlightStrategy.alwaysTraditional;
      addTearDown(() => focusManager.highlightStrategy = previousStrategy);

      await tester.pumpWidget(
        app(
          EchoPressable(
            semanticLabel: '晨光，下载中',
            semanticsMode: EchoPressableSemanticsMode.explicitChildren,
            onPressed: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ExcludeSemantics(child: Text('晨光，下载中')),
                EchoIconButton(
                  icon: Icons.pause,
                  label: '暂停晨光',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      final pressable = find.byWidgetPredicate(
        (widget) => widget is EchoPressable && widget.semanticLabel == '晨光，下载中',
      );
      final focusNode = _pressableFocusNode(tester, pressable);

      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();
      expect(focusNode.hasPrimaryFocus, isTrue);
      expect(
        _focusBorderColor(tester, pressable),
        tester.element(pressable).echoColors.accent,
      );

      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();
      expect(focusNode.hasPrimaryFocus, isFalse);
      expect(focusNode.hasFocus, isTrue);
      expect(_focusBorderColor(tester, pressable), Colors.transparent);
      expect(FocusManager.instance.primaryFocus, isNot(focusNode));
    });
  });
}

FocusNode _pressableFocusNode(WidgetTester tester, Finder pressable) {
  final container = find
      .descendant(of: pressable, matching: find.byType(AnimatedContainer))
      .first;
  return Focus.of(tester.element(container));
}

Color _focusBorderColor(WidgetTester tester, Finder pressable) {
  final container = tester.widget<AnimatedContainer>(
    find
        .descendant(of: pressable, matching: find.byType(AnimatedContainer))
        .first,
  );
  final decoration = container.foregroundDecoration! as BoxDecoration;
  return (decoration.border! as Border).top.color;
}
