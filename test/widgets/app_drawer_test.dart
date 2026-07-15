import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/widgets/echo_app_shell/echo_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Echo drawer avoids default Material drawer silhouettes', (
    tester,
  ) async {
    await _pumpDrawer(tester);

    expect(find.byType(Drawer), findsNothing);
    expect(find.byType(DrawerHeader), findsNothing);
    expect(find.byType(ListTile), findsNothing);
    expect(find.bySemanticsLabel('应用菜单'), findsOneWidget);
  });

  testWidgets('identity status is textual and survives 200 percent text', (
    tester,
  ) async {
    await _pumpDrawer(tester, textScale: 2);

    expect(
      find.bySemanticsLabel('当前账户 listener，音乐库 Night archive，连接失败，家庭服务器'),
      findsOneWidget,
    );
    expect(find.text('连接失败 · 家庭服务器'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('library selection and edit remain separate 48dp actions', (
    tester,
  ) async {
    var selections = 0;
    var edits = 0;
    await _pumpDrawer(
      tester,
      onSelected: () => selections++,
      onEdit: () => edits++,
    );

    final select = find.bySemanticsLabel(
      'Night archive，https://music.example，当前音乐库',
    );
    final edit = find.bySemanticsLabel('编辑 Night archive');
    expect(tester.getSize(select).height, greaterThanOrEqualTo(48));
    expect(tester.getSize(edit).height, greaterThanOrEqualTo(48));

    await tester.tap(select);
    await tester.tap(edit);
    expect(selections, 1);
    expect(edits, 1);
  });
}

Future<void> _pumpDrawer(
  WidgetTester tester, {
  double textScale = 1,
  VoidCallback? onSelected,
  VoidCallback? onEdit,
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(360, 800);
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(),
      home: MediaQuery(
        data: MediaQueryData(
          size: const Size(360, 800),
          textScaler: TextScaler.linear(textScale),
          padding: const EdgeInsets.only(top: 24, bottom: 20),
        ),
        child: Scaffold(
          body: EchoDrawerFrame(
            header: EchoDrawerIdentityHeader(
              username: 'listener',
              libraryName: 'Night archive',
              addressLabel: '家庭服务器',
              connectionState: EchoDrawerConnectionState.failed,
              showingLibraries: true,
              onToggleLibraries: () {},
            ),
            child: ListView.builder(
              itemCount: 80,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return EchoDrawerLibraryRow(
                    title: 'Night archive',
                    subtitle: 'https://music.example',
                    selected: true,
                    onSelected: onSelected ?? () {},
                    onEdit: onEdit ?? () {},
                  );
                }
                return SizedBox(height: 72, child: Text('Library $index'));
              },
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
