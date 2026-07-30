import 'dart:async';

import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('EchoRefreshView confirms when release will refresh', (
    tester,
  ) async {
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

    final gesture = await tester.startGesture(
      tester.getCenter(find.byType(ListView)),
    );
    await gesture.moveBy(const Offset(0, 350));
    await tester.pump();

    expect(find.text('松开刷新'), findsOneWidget);
    expect(refreshCount, 0);

    await gesture.up();
    await tester.pump();

    expect(find.text('正在刷新'), findsOneWidget);
    expect(find.text('松开刷新'), findsNothing);
    expect(_visibleRefreshLabels(), hasLength(1));

    await tester.pump(const Duration(milliseconds: 250));

    expect(refreshCount, 1);
    expect(find.text('正在刷新'), findsOneWidget);

    refreshCompleter.complete();
    await tester.pumpAndSettle();
  });

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
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(
      tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity)).opacity,
      1,
    );

    refreshCompleter.complete();
    await tester.pump();

    expect(find.text('刷新完成'), findsOneWidget);
    expect(find.text('正在刷新'), findsNothing);
    expect(_visibleRefreshLabels(), hasLength(1));

    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    expect(
      tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity)).opacity,
      0,
    );
  });

  testWidgets('EchoRefreshView returns to idle when the pull is canceled', (
    tester,
  ) async {
    var refreshCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: EchoRefreshView(
            onRefresh: () async {
              refreshCount += 1;
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: const <Widget>[SizedBox(height: 900)],
            ),
          ),
        ),
      ),
    );

    final gesture = await tester.startGesture(
      tester.getCenter(find.byType(ListView)),
    );
    await gesture.moveBy(const Offset(0, 30));
    await tester.pump();

    expect(find.text('下拉刷新'), findsOneWidget);

    await gesture.up();
    await tester.pumpAndSettle();

    expect(refreshCount, 0);
    expect(_visibleRefreshLabels(), isEmpty);
  });

  testWidgets(
    'EchoRefreshView reports refresh failures without false success',
    (tester) async {
      final refreshCompleter = Completer<void>();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: EchoRefreshView(
              onRefresh: () => refreshCompleter.future,
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

      expect(find.text('正在刷新'), findsOneWidget);

      refreshCompleter.completeError(StateError('network unavailable'));
      await tester.pump();

      expect(find.text('刷新失败'), findsOneWidget);
      expect(find.text('刷新完成'), findsNothing);

      // The framework's own done/null transition must not overwrite the result.
      await tester.pump(const Duration(milliseconds: 250));
      expect(find.text('刷新失败'), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();
      expect(
        tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity)).opacity,
        0,
      );
    },
  );

  testWidgets('a new pull supersedes visible completion feedback', (
    tester,
  ) async {
    final refreshCompleter = Completer<void>();

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: EchoRefreshView(
            onRefresh: () => refreshCompleter.future,
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
    refreshCompleter.complete();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));

    expect(find.text('刷新完成'), findsOneWidget);

    final gesture = await tester.startGesture(
      tester.getCenter(find.byType(ListView)),
    );
    await gesture.moveBy(const Offset(0, 60));
    await tester.pump();

    expect(find.text('下拉刷新'), findsOneWidget);
    expect(find.text('刷新完成'), findsNothing);

    await gesture.up();
    await tester.pumpAndSettle();
  });
}

Iterable<Element> _visibleRefreshLabels() {
  const labels = <String>{'下拉刷新', '松开刷新', '正在刷新', '刷新完成', '刷新失败'};
  return find
      .byWidgetPredicate(
        (widget) => widget is Text && labels.contains(widget.data),
      )
      .evaluate();
}
