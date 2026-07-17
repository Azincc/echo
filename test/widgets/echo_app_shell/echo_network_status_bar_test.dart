import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/widgets/echo_app_shell/echo_network_status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('online state keeps the global status slot hidden', (
    tester,
  ) async {
    final status = ValueNotifier<EchoNetworkStatus>(EchoNetworkStatus.online);
    addTearDown(status.dispose);

    await _pumpStatusBar(tester, status: status);

    expect(find.text('当前离线'), findsNothing);
    expect(find.text('网络不稳定'), findsNothing);
    expect(find.text('网络已恢复'), findsNothing);
    expect(tester.getSize(_statusSlot).height, 0);
  });

  testWidgets('offline state explains that existing content remains usable', (
    tester,
  ) async {
    final status = ValueNotifier<EchoNetworkStatus>(EchoNetworkStatus.offline);
    addTearDown(status.dispose);

    await _pumpStatusBar(tester, status: status, textScale: 2);

    expect(find.text('当前离线'), findsOneWidget);
    expect(find.text('已加载内容和离线歌曲仍可使用，在线操作将在联网后恢复'), findsOneWidget);
    expect(tester.getSize(_statusSlot).height, greaterThan(0));
    final statusSurface = find.byKey(
      const ValueKey<String>('echo-network-status-surface'),
    );
    final surfaceContext = tester.element(statusSurface);
    final surfaceSize = tester.getSize(statusSurface);
    final slotSize = tester.getSize(_statusSlot);
    expect(
      surfaceSize.width,
      slotSize.width - surfaceContext.echoSpacing.sm * 2,
    );
    expect(surfaceSize.height, slotSize.height);
    expect(
      tester.widget<EchoSurface>(statusSurface).borderRadius,
      surfaceContext.echoRadii.surface,
    );
    expect(find.byType(MaterialBanner), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('weak state reports retry without replacing cached content', (
    tester,
  ) async {
    final status = ValueNotifier<EchoNetworkStatus>(EchoNetworkStatus.weak);
    addTearDown(status.dispose);

    await _pumpStatusBar(tester, status: status);

    expect(find.text('网络不稳定'), findsOneWidget);
    expect(find.textContaining('正在重试可用线路'), findsOneWidget);
    expect(find.textContaining('已加载内容和离线歌曲仍可使用'), findsOneWidget);
  });

  testWidgets('restored state is announced briefly and then releases space', (
    tester,
  ) async {
    final status = ValueNotifier<EchoNetworkStatus>(EchoNetworkStatus.offline);
    addTearDown(status.dispose);

    await _pumpStatusBar(
      tester,
      status: status,
      recoveryDisplayDuration: const Duration(milliseconds: 600),
    );
    expect(find.text('当前离线'), findsOneWidget);

    status.value = EchoNetworkStatus.online;
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 220));

    expect(find.text('网络已恢复'), findsOneWidget);
    expect(find.text('已重新连接可用线路'), findsOneWidget);
    expect(tester.getSize(_statusSlot).height, greaterThan(0));

    await tester.pump(const Duration(milliseconds: 380));
    await tester.pump(const Duration(milliseconds: 220));

    expect(find.text('网络已恢复'), findsNothing);
    expect(tester.getSize(_statusSlot).height, 0);
  });
}

Finder get _statusSlot =>
    find.byKey(const ValueKey<String>('echo-network-status-slot'));

Future<void> _pumpStatusBar(
  WidgetTester tester, {
  required ValueNotifier<EchoNetworkStatus> status,
  Duration recoveryDisplayDuration = const Duration(seconds: 3),
  double textScale = 1,
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(390, 800);
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(),
      home: MediaQuery(
        data: MediaQueryData(
          size: const Size(390, 800),
          textScaler: TextScaler.linear(textScale),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ValueListenableBuilder<EchoNetworkStatus>(
            valueListenable: status,
            builder: (context, value, child) {
              return EchoNetworkStatusBar(
                status: value,
                recoveryDisplayDuration: recoveryDisplayDuration,
              );
            },
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
