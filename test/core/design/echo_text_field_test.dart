import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget testApp(
    Widget child, {
    ThemeData? theme,
    TextScaler textScaler = TextScaler.noScaling,
  }) {
    return MaterialApp(
      theme: theme ?? AppTheme.light(),
      home: MediaQuery(
        data: MediaQueryData(textScaler: textScaler),
        child: Scaffold(body: Center(child: child)),
      ),
    );
  }

  testWidgets('input stays synchronized with the controller', (tester) async {
    final controller = TextEditingController();
    addTearDown(controller.dispose);
    String? changedValue;

    await tester.pumpWidget(
      testApp(
        EchoTextField(
          controller: controller,
          label: '服务器地址',
          onChanged: (value) => changedValue = value,
        ),
      ),
    );

    await tester.enterText(find.byType(EditableText), 'navidrome.local:4533');
    await tester.pump();

    expect(controller.text, 'navidrome.local:4533');
    expect(changedValue, 'navidrome.local:4533');
    expect(
      tester.widget<EditableText>(find.byType(EditableText)).controller,
      same(controller),
    );
  });

  testWidgets('uses native mobile and desktop text selection behavior', (
    tester,
  ) async {
    final controller = TextEditingController(text: 'Echo selection');
    addTearDown(controller.dispose);

    Future<EditableText> pumpFor(TargetPlatform platform) async {
      await tester.pumpWidget(
        testApp(
          EchoTextField(controller: controller, label: '名称'),
          theme: AppTheme.light().copyWith(platform: platform),
        ),
      );
      await tester.pumpAndSettle();
      return tester.widget<EditableText>(find.byType(EditableText));
    }

    var editable = await pumpFor(TargetPlatform.android);
    expect(
      editable.selectionControls,
      same(materialTextSelectionHandleControls),
    );
    expect(editable.contextMenuBuilder, isNotNull);
    expect(
      editable.magnifierConfiguration,
      same(TextMagnifier.adaptiveMagnifierConfiguration),
    );
    await tester.longPress(find.byType(TextField));
    await tester.pump();
    editable = tester.widget<EditableText>(find.byType(EditableText));
    expect(editable.showSelectionHandles, isTrue);

    editable = await pumpFor(TargetPlatform.iOS);
    expect(
      editable.selectionControls,
      same(cupertinoTextSelectionHandleControls),
    );
    expect(editable.contextMenuBuilder, isNotNull);

    editable = await pumpFor(TargetPlatform.windows);
    expect(
      editable.selectionControls,
      same(desktopTextSelectionHandleControls),
    );
    expect(editable.contextMenuBuilder, isNotNull);

    editable = await pumpFor(TargetPlatform.macOS);
    expect(
      editable.selectionControls,
      same(cupertinoDesktopTextSelectionHandleControls),
    );
    expect(editable.contextMenuBuilder, isNotNull);
  });

  testWidgets('Form validator displays and clears its inline error', (
    tester,
  ) async {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      testApp(
        Form(
          key: formKey,
          child: EchoTextField(
            controller: controller,
            label: '音乐库名称',
            validator: (value) {
              return value == null || value.trim().isEmpty ? '请输入音乐库名称' : null;
            },
          ),
        ),
      ),
    );

    expect(formKey.currentState!.validate(), isFalse);
    await tester.pump();
    expect(find.text('请输入音乐库名称'), findsOneWidget);

    await tester.enterText(find.byType(EditableText), '家庭音乐库');
    expect(formKey.currentState!.validate(), isTrue);
    await tester.pump();
    expect(find.text('请输入音乐库名称'), findsNothing);
  });

  testWidgets('external controller updates and replacement reach the field', (
    tester,
  ) async {
    final firstController = TextEditingController(text: '初始地址');
    final replacementController = TextEditingController(text: '备用地址');
    addTearDown(firstController.dispose);
    addTearDown(replacementController.dispose);
    late StateSetter updateHost;
    var activeController = firstController;

    await tester.pumpWidget(
      testApp(
        StatefulBuilder(
          builder: (context, setState) {
            updateHost = setState;
            return EchoTextField(controller: activeController, label: '服务器地址');
          },
        ),
      ),
    );

    firstController.text = '外部更新地址';
    await tester.pump();
    expect(_renderedText(tester), '外部更新地址');

    updateHost(() => activeController = replacementController);
    await tester.pump();
    expect(
      tester.widget<EditableText>(find.byType(EditableText)).controller,
      same(replacementController),
    );
    expect(_renderedText(tester), '备用地址');

    firstController.text = '不应再显示';
    await tester.pump();
    expect(_renderedText(tester), '备用地址');
  });

  testWidgets('Form reset restores the visible and saved controller value', (
    tester,
  ) async {
    final controller = TextEditingController(text: '初始地址');
    final formKey = GlobalKey<FormState>();
    String? savedValue;
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      testApp(
        Form(
          key: formKey,
          child: EchoTextField(
            controller: controller,
            label: '服务器地址',
            onSaved: (value) => savedValue = value,
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(EditableText), '修改后的地址');
    await tester.pump();
    expect(controller.text, '修改后的地址');

    formKey.currentState!.reset();
    await tester.pump();
    formKey.currentState!.save();

    expect(controller.text, '初始地址');
    expect(_renderedText(tester), '初始地址');
    expect(savedValue, '初始地址');
  });

  testWidgets('obscureText does not expose the secret in rendered text', (
    tester,
  ) async {
    const secret = 'test-secret-2048';
    final controller = TextEditingController(text: secret);
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      testApp(
        EchoTextField(
          controller: controller,
          label: '密码',
          obscureText: true,
          autocorrect: false,
          enableSuggestions: false,
        ),
        theme: AppTheme.dark(),
      ),
    );

    final editable = tester.widget<EditableText>(find.byType(EditableText));
    final renderedText = _renderedText(tester);
    expect(editable.obscureText, isTrue);
    expect(renderedText, isNot(contains(secret)));
    expect(renderedText, isNotEmpty);
    expect(renderedText.length, secret.length);
  });

  testWidgets('disabled field stays read-only and cannot receive focus', (
    tester,
  ) async {
    final controller = TextEditingController(text: '锁定内容');
    final focusNode = FocusNode();
    addTearDown(controller.dispose);
    addTearDown(focusNode.dispose);

    await tester.pumpWidget(
      testApp(
        EchoTextField(
          controller: controller,
          focusNode: focusNode,
          label: '只读字段',
          enabled: false,
        ),
      ),
    );

    final editable = tester.widget<EditableText>(find.byType(EditableText));
    expect(editable.readOnly, isTrue);
    expect(focusNode.hasFocus, isFalse);

    await tester.tap(find.byType(EchoTextField), warnIfMissed: false);
    await tester.pump();

    expect(focusNode.hasFocus, isFalse);
    expect(controller.text, '锁定内容');
  });

  testWidgets('field has no overflow at 200 percent text scale', (
    tester,
  ) async {
    final controller = TextEditingController();
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      testApp(
        SizedBox(
          width: 320,
          child: SingleChildScrollView(
            child: EchoTextField(
              controller: controller,
              label: '一个较长的服务器地址字段标签',
              hintText: '例如 music.example.local:4533',
              helperText: '请输入可以连接到 Navidrome 的完整服务器地址。',
              leadingIcon: AppIcons.router,
              trailing: EchoIconButton(
                icon: AppIcons.clearAll,
                label: '清空地址',
                onPressed: controller.clear,
              ),
            ),
          ),
        ),
        textScaler: const TextScaler.linear(2),
      ),
    );

    await tester.pump();
    expect(tester.takeException(), isNull);
    expect(
      tester.getSize(find.byType(EchoTextField)).height,
      greaterThanOrEqualTo(48),
    );
    expect(find.bySemanticsLabel('清空地址'), findsOneWidget);
  });
}

String _renderedText(WidgetTester tester) {
  final root = tester.element(find.byType(EditableText)).renderObject!;
  RenderEditable? renderEditable;

  void findEditable(RenderObject object) {
    if (object is RenderEditable) {
      renderEditable = object;
      return;
    }
    object.visitChildren(findEditable);
  }

  findEditable(root);
  expect(renderEditable, isNotNull);
  return renderEditable!.text?.toPlainText() ?? '';
}
