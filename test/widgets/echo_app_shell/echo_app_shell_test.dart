import 'dart:ui' show Tristate;

import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/widgets/echo_app_shell/echo_app_shell.dart';
import 'package:echoes/widgets/echo_app_shell/echo_network_status_bar.dart';
import 'package:echoes/widgets/echo_app_shell/echo_shell_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _destinations = <EchoShellDestination>[
  EchoShellDestination(
    branchIndex: 0,
    label: '音乐流',
    icon: AppIcons.home,
    selectedIcon: AppIcons.homeFilled,
  ),
  EchoShellDestination(
    branchIndex: 1,
    label: '探索',
    icon: AppIcons.discover,
    selectedIcon: AppIcons.discoverFilled,
  ),
  EchoShellDestination(
    branchIndex: 2,
    label: '我的',
    icon: AppIcons.library,
    selectedIcon: AppIcons.libraryFilled,
  ),
];

void main() {
  group('EchoAppShell responsive navigation', () {
    testWidgets('uses compact, medium, and expanded navigation structures', (
      tester,
    ) async {
      await _pumpShell(tester, size: const Size(599, 800));
      expect(_compactNavigation, findsOneWidget);
      expect(_mediumNavigation, findsNothing);
      expect(_expandedNavigation, findsNothing);
      expect(find.byType(NavigationBar), findsNothing);

      await _pumpShell(tester, size: const Size(600, 800));
      expect(_compactNavigation, findsNothing);
      expect(_mediumNavigation, findsOneWidget);
      expect(_expandedNavigation, findsNothing);
      expect(find.byType(NavigationRail), findsNothing);
      expect(find.bySemanticsLabel('打开应用菜单'), findsOneWidget);
      expect(find.bySemanticsLabel('音乐流'), findsOneWidget);
      expect(find.bySemanticsLabel('探索'), findsOneWidget);
      expect(find.bySemanticsLabel('我的'), findsOneWidget);

      await _pumpShell(tester, size: const Size(839, 800));
      expect(_mediumNavigation, findsOneWidget);

      await _pumpShell(tester, size: const Size(840, 800));
      expect(_compactNavigation, findsNothing);
      expect(_mediumNavigation, findsNothing);
      expect(_expandedNavigation, findsOneWidget);
      expect(find.byType(NavigationDrawer), findsNothing);
    });

    testWidgets('destinations expose selected semantics and 48dp targets', (
      tester,
    ) async {
      var selectedBranch = -1;
      await _pumpShell(
        tester,
        size: const Size(390, 800),
        onDestinationSelected: (branchIndex) {
          selectedBranch = branchIndex;
        },
      );

      final musicFeed = find.bySemanticsLabel('音乐流');
      final explore = find.bySemanticsLabel('探索');
      expect(musicFeed, findsOneWidget);
      expect(
        tester.getSemantics(musicFeed).flagsCollection.isSelected,
        Tristate.isTrue,
      );
      expect(tester.getSize(explore).height, greaterThanOrEqualTo(48));

      await tester.tap(explore);
      await tester.pump();
      expect(selectedBranch, 1);
    });

    testWidgets('200 percent text remains usable in every window class', (
      tester,
    ) async {
      for (final size in const <Size>[
        Size(360, 800),
        Size(600, 960),
        Size(840, 960),
      ]) {
        await _pumpShell(tester, size: size, textScale: 2);
        expect(tester.takeException(), isNull, reason: 'viewport: $size');
        expect(find.bySemanticsLabel('音乐流'), findsOneWidget);
        expect(find.bySemanticsLabel('探索'), findsOneWidget);
        expect(find.bySemanticsLabel('我的'), findsOneWidget);
      }
    });
  });

  group('EchoAppShell MiniPlayer slot', () {
    testWidgets('network status reserves space instead of covering content', (
      tester,
    ) async {
      await _pumpShell(
        tester,
        size: const Size(390, 800),
        showMiniPlayer: true,
        networkStatus: EchoNetworkStatus.offline,
      );

      final contentRect = tester.getRect(_content);
      final statusRect = tester.getRect(_networkStatusSlot);
      final playerRect = tester.getRect(_miniPlayer);
      expect(contentRect.bottom, lessThanOrEqualTo(statusRect.top));
      expect(statusRect.bottom, lessThanOrEqualTo(playerRect.top));
    });

    testWidgets('reserves measured MiniPlayer space without covering content', (
      tester,
    ) async {
      for (final size in const <Size>[Size(390, 800), Size(840, 960)]) {
        await _pumpShell(
          tester,
          size: size,
          showMiniPlayer: true,
          bottomSafeArea: 24,
        );

        final contentRect = tester.getRect(_content);
        final playerRect = tester.getRect(_miniPlayer);
        expect(
          contentRect.bottom,
          lessThanOrEqualTo(playerRect.top),
          reason: 'viewport: $size',
        );

        if (size.width < EchoBreakpoints.standard.medium) {
          final navigationRect = tester.getRect(_compactNavigation);
          expect(playerRect.bottom, lessThanOrEqualTo(navigationRect.top));
        } else {
          expect(playerRect.bottom, lessThanOrEqualTo(size.height - 24));
        }
      }
    });

    testWidgets('hidden MiniPlayer releases its slot', (tester) async {
      await _pumpShell(
        tester,
        size: const Size(390, 800),
        showMiniPlayer: false,
      );

      expect(
        find.byKey(const ValueKey<String>('test-mini-player')),
        findsNothing,
      );
      expect(tester.getSize(_miniPlayerSlot).height, 0);
      expect(
        tester.getRect(_content).bottom,
        tester.getRect(_compactNavigation).top,
      );
    });

    testWidgets('reduced motion makes slot changes immediate', (tester) async {
      await _pumpShell(
        tester,
        size: const Size(390, 800),
        showMiniPlayer: true,
        disableAnimations: true,
      );

      final animatedSize = tester.widget<AnimatedSize>(
        find.descendant(
          of: _miniPlayerSlot,
          matching: find.byType(AnimatedSize),
        ),
      );
      expect(animatedSize.duration, Duration.zero);
    });
  });
}

Finder get _compactNavigation =>
    find.byKey(const ValueKey<String>('echo-compact-navigation'));
Finder get _mediumNavigation =>
    find.byKey(const ValueKey<String>('echo-medium-navigation'));
Finder get _expandedNavigation =>
    find.byKey(const ValueKey<String>('echo-expanded-navigation'));
Finder get _content => find.byKey(const ValueKey<String>('test-content'));
Finder get _miniPlayer =>
    find.byKey(const ValueKey<String>('test-mini-player'));
Finder get _miniPlayerSlot =>
    find.byKey(const ValueKey<String>('echo-mini-player-slot'));
Finder get _networkStatusSlot =>
    find.byKey(const ValueKey<String>('echo-network-status-slot'));

Future<void> _pumpShell(
  WidgetTester tester, {
  required Size size,
  double textScale = 1,
  double bottomSafeArea = 0,
  bool showMiniPlayer = false,
  bool disableAnimations = false,
  EchoNetworkStatus networkStatus = EchoNetworkStatus.online,
  ValueChanged<int>? onDestinationSelected,
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(),
      home: MediaQuery(
        data: MediaQueryData(
          size: size,
          padding: EdgeInsets.only(bottom: bottomSafeArea),
          textScaler: TextScaler.linear(textScale),
          disableAnimations: disableAnimations,
        ),
        child: EchoAppShell(
          scaffoldKey: GlobalKey<ScaffoldState>(),
          drawer: const SizedBox(width: 320),
          destinations: _destinations,
          selectedBranchIndex: 0,
          onDestinationSelected: onDestinationSelected ?? (_) {},
          showMiniPlayer: showMiniPlayer,
          networkStatus: networkStatus,
          miniPlayer: const SizedBox(
            key: ValueKey<String>('test-mini-player'),
            height: 72,
          ),
          body: const SizedBox.expand(key: ValueKey<String>('test-content')),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
