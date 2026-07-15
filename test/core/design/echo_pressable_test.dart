import 'dart:ui' show SemanticsAction, Tristate;

import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
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
}
