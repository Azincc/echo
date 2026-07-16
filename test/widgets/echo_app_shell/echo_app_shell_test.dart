import 'dart:ui' show Tristate;

import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/data/models/song.dart';
import 'package:echoes/features/player/widgets/mini_player.dart';
import 'package:echoes/providers/player_provider.dart';
import 'package:echoes/widgets/echo_app_shell/echo_app_shell.dart';
import 'package:echoes/widgets/echo_app_shell/echo_network_status_bar.dart';
import 'package:echoes/widgets/echo_app_shell/echo_shell_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      expect(tester.getSize(_compactNavigation).height, 64);

      await _pumpShell(tester, size: const Size(600, 800));
      expect(_compactNavigation, findsNothing);
      expect(_mediumNavigation, findsOneWidget);
      expect(_expandedNavigation, findsNothing);
      expect(find.byType(NavigationRail), findsNothing);
      expect(find.bySemanticsLabel('打开应用菜单'), findsOneWidget);
      expect(find.bySemanticsLabel('音乐流'), findsOneWidget);
      expect(find.bySemanticsLabel('探索'), findsOneWidget);
      expect(find.bySemanticsLabel('我的'), findsOneWidget);
      expect(tester.getSize(_mediumNavigation).width, 96);
      expect(_verticalShellDividers, findsNothing);

      await _pumpShell(tester, size: const Size(839, 800));
      expect(_mediumNavigation, findsOneWidget);

      await _pumpShell(tester, size: const Size(840, 800));
      expect(_compactNavigation, findsNothing);
      expect(_mediumNavigation, findsNothing);
      expect(_expandedNavigation, findsOneWidget);
      expect(find.byType(NavigationDrawer), findsNothing);
      expect(tester.getSize(_expandedNavigation).width, 232);
      expect(_verticalShellDividers, findsNothing);
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

    testWidgets('uses filled icons and restrained selection markers', (
      tester,
    ) async {
      await _pumpShell(tester, size: const Size(390, 800));

      final selectedMarker = _compactSelectionIndicator(0);
      final unselectedMarker = _compactSelectionIndicator(1);
      expect(tester.getSize(selectedMarker), const Size(24, 3));
      expect(tester.widget<AnimatedOpacity>(selectedMarker).opacity, 1);
      expect(tester.widget<AnimatedOpacity>(unselectedMarker).opacity, 0);
      expect(find.byIcon(AppIcons.homeFilled), findsOneWidget);
      expect(find.byIcon(AppIcons.home), findsNothing);
      expect(find.byIcon(AppIcons.discover), findsOneWidget);

      await _pumpShell(
        tester,
        size: const Size(600, 800),
        selectedBranchIndex: 1,
      );
      expect(
        tester.widget<AnimatedOpacity>(_mediumSelectionIndicator(1)).opacity,
        1,
      );
      expect(tester.getSize(_mediumSelectionIndicator(1)), const Size(3, 28));
      expect(find.byIcon(AppIcons.discoverFilled), findsOneWidget);
    });

    testWidgets('200 percent text remains usable in every window class', (
      tester,
    ) async {
      for (final size in const <Size>[
        Size(320, 800),
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
    testWidgets(
      'compact shell paints content behind a truly transparent MiniPlayer slot',
      (tester) async {
        for (final theme in <ThemeData>[AppTheme.light(), AppTheme.dark()]) {
          final colors = theme.extension<EchoColors>()!;
          await _pumpShell(
            tester,
            size: const Size(390, 800),
            showMiniPlayer: true,
            theme: theme,
            body: const Scaffold(
              body: SizedBox.expand(
                key: ValueKey<String>('nested-scaffold-content'),
              ),
            ),
          );

          final scaffold = tester.widget<Scaffold>(
            find.ancestor(of: _shellContent, matching: find.byType(Scaffold)),
          );
          final contentSurface = tester.widget<ColoredBox>(_shellContent);
          final navigationSurface = tester.widget<ColoredBox>(
            _compactNavigation,
          );
          final slotSurface = find.descendant(
            of: _miniPlayerSlot,
            matching: find.byWidgetPredicate(
              (widget) =>
                  widget is ColoredBox &&
                  (widget.color == colors.canvas ||
                      widget.color == colors.surface),
            ),
          );
          final nestedContentRect = tester.getRect(
            find.byKey(const ValueKey<String>('nested-scaffold-content')),
          );
          final slotRect = tester.getRect(_miniPlayerSlot);

          expect(scaffold.backgroundColor, colors.canvas);
          expect(scaffold.extendBody, isTrue);
          expect(contentSurface.color, colors.canvas);
          expect(navigationSurface.color, colors.surface);
          expect(slotSurface, findsNothing);
          expect(nestedContentRect.bottom, 800);
          expect(nestedContentRect.bottom, greaterThan(slotRect.top));
        }
      },
    );

    testWidgets('wide chrome continues to resolve against the canvas', (
      tester,
    ) async {
      for (final theme in <ThemeData>[AppTheme.light(), AppTheme.dark()]) {
        final colors = theme.extension<EchoColors>()!;
        var obstruction = -1.0;
        await _pumpShell(
          tester,
          size: const Size(840, 960),
          showMiniPlayer: true,
          theme: theme,
          body: Builder(
            builder: (context) {
              obstruction = context.echoShellBottomObstruction;
              return const SizedBox.expand();
            },
          ),
        );

        final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
        final contentSurface = tester.widget<ColoredBox>(_shellContent);
        final slotCanvas = find.descendant(
          of: _miniPlayerSlot,
          matching: find.byWidgetPredicate(
            (widget) => widget is ColoredBox && widget.color == colors.canvas,
          ),
        );

        expect(scaffold.backgroundColor, colors.canvas);
        expect(scaffold.extendBody, isFalse);
        expect(contentSurface.color, colors.canvas);
        expect(slotCanvas, findsNothing);
        expect(obstruction, 0);
      }
    });

    testWidgets(
      'compact obstruction follows every measured bottom chrome configuration',
      (tester) async {
        var obstruction = -1.0;
        final probe = Builder(
          builder: (context) {
            obstruction = context.echoShellBottomObstruction;
            return const SizedBox.expand();
          },
        );

        await _pumpShell(
          tester,
          size: const Size(390, 800),
          showMiniPlayer: true,
          bottomSafeArea: 24,
          body: probe,
        );
        final withMiniPlayer = tester.getSize(_compactBottomChrome).height;
        expect(obstruction, withMiniPlayer);

        await _pumpShell(
          tester,
          size: const Size(390, 800),
          showMiniPlayer: false,
          bottomSafeArea: 24,
          body: probe,
        );
        final navigationOnly = tester.getSize(_compactBottomChrome).height;
        expect(obstruction, navigationOnly);
        expect(navigationOnly, lessThan(withMiniPlayer));

        await _pumpShell(
          tester,
          size: const Size(320, 800),
          textScale: 2,
          bottomSafeArea: 24,
          showMiniPlayer: true,
          networkStatus: EchoNetworkStatus.offline,
          body: probe,
        );
        final offlineLargeText = tester.getSize(_compactBottomChrome).height;
        expect(obstruction, offlineLargeText);
        expect(offlineLargeText, greaterThan(withMiniPlayer));
      },
    );

    testWidgets(
      'nested EchoScaffold bottom bar clears the compact shell obstruction',
      (tester) async {
        await _pumpShell(
          tester,
          size: const Size(390, 800),
          showMiniPlayer: true,
          bottomSafeArea: 24,
          body: const EchoScaffold(
            body: SizedBox.expand(),
            bottomBar: SizedBox(
              key: ValueKey<String>('nested-bottom-bar'),
              height: 40,
            ),
          ),
        );

        final nestedBottomBar = tester.getRect(
          find.byKey(const ValueKey<String>('nested-bottom-bar')),
        );
        final compactChrome = tester.getRect(_compactBottomChrome);
        expect(nestedBottomBar.bottom, compactChrome.top);
      },
    );

    testWidgets('network status remains above MiniPlayer in overlay order', (
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
      expect(contentRect.bottom, greaterThan(statusRect.top));
      expect(statusRect.bottom, lessThanOrEqualTo(playerRect.top));
    });

    testWidgets('compact overlays while wide reserves measured player space', (
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
        if (size.width < EchoBreakpoints.standard.medium) {
          final navigationRect = tester.getRect(_compactNavigation);
          expect(contentRect.bottom, greaterThan(playerRect.top));
          expect(playerRect.bottom, lessThanOrEqualTo(navigationRect.top));
          expect(playerRect.left, 12);
          expect(size.width - playerRect.right, 12);
          expect(navigationRect.top - playerRect.bottom, 4);
        } else {
          expect(contentRect.bottom, lessThanOrEqualTo(playerRect.top));
          expect(playerRect.bottom, lessThanOrEqualTo(size.height - 24));
          expect(size.width - playerRect.right, 12);
        }

        final chromeRect = tester.getRect(_miniPlayerChrome);
        expect(chromeRect.contains(playerRect.topLeft), isTrue);
        expect(chromeRect.contains(playerRect.bottomRight), isTrue);
      }
    });

    testWidgets('real MiniPlayer fits 320dp chrome at 200 percent text', (
      tester,
    ) async {
      final song = Song(
        id: 'song-1',
        title: '一首标题很长的歌曲用于验证紧凑布局',
        artist: '一位名字很长的歌手',
        duration: 240,
      );

      await _pumpShell(
        tester,
        size: const Size(320, 800),
        textScale: 2,
        showMiniPlayer: true,
        disableAnimations: true,
        miniPlayer: MiniPlayerView(
          playerState: PlayerState(
            currentSong: song,
            queue: <Song>[song],
            currentIndex: 0,
            isPlaying: true,
            position: const Duration(seconds: 80),
            duration: const Duration(seconds: 240),
          ),
          albumColor: const Color(0xFF556F60),
          onOpenPlayer: () {},
          onTogglePlayPause: () async {},
          onPrevious: () async {},
          onNext: () async {},
          onSeek: (_) async {},
          onOpenActions: () {},
        ),
      );

      expect(tester.takeException(), isNull);
      final surface = find.byKey(const Key('mini-player-surface'));
      final surfaceRect = tester.getRect(surface);
      final navigationRect = tester.getRect(_compactNavigation);
      final progressRect = tester.getRect(
        find.byKey(const Key('mini-player-progress')),
      );

      expect(surfaceRect.width, 296);
      expect(surfaceRect.height, MiniPlayer.height);
      expect(navigationRect.top - surfaceRect.bottom, 4);
      expect(progressRect.left, surfaceRect.left);
      expect(progressRect.bottom, surfaceRect.bottom);
    });

    testWidgets(
      'transparent MiniPlayer gutter blocks page taps without blocking controls',
      (tester) async {
        var pageTaps = 0;
        var playerTaps = 0;
        await _pumpShell(
          tester,
          size: const Size(390, 800),
          showMiniPlayer: true,
          body: Scaffold(
            body: GestureDetector(
              key: const ValueKey<String>('page-tap-target'),
              behavior: HitTestBehavior.opaque,
              onTap: () => pageTaps += 1,
              child: const SizedBox.expand(),
            ),
          ),
          miniPlayer: GestureDetector(
            key: const ValueKey<String>('test-mini-player'),
            behavior: HitTestBehavior.opaque,
            onTap: () => playerTaps += 1,
            child: const SizedBox(height: 72),
          ),
        );

        final playerRect = tester.getRect(_miniPlayer);
        await tester.tapAt(Offset(4, playerRect.center.dy));
        await tester.pump();
        expect(pageTaps, 0);
        expect(playerTaps, 0);

        await tester.tap(_miniPlayer);
        await tester.pump();
        expect(pageTaps, 0);
        expect(playerTaps, 1);
      },
    );

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
        greaterThan(tester.getRect(_compactNavigation).top),
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
      expect(
        tester.widget<AnimatedOpacity>(_compactSelectionIndicator(0)).duration,
        Duration.zero,
      );
    });
  });
}

Finder get _compactNavigation =>
    find.byKey(const ValueKey<String>('echo-compact-navigation'));
Finder get _mediumNavigation =>
    find.byKey(const ValueKey<String>('echo-medium-navigation'));
Finder get _expandedNavigation =>
    find.byKey(const ValueKey<String>('echo-expanded-navigation'));
Finder get _compactBottomChrome =>
    find.byKey(const ValueKey<String>('echo-compact-bottom-chrome'));
Finder get _shellContent =>
    find.byKey(const ValueKey<String>('echo-shell-content'));
Finder get _content => find.byKey(const ValueKey<String>('test-content'));
Finder get _miniPlayer =>
    find.byKey(const ValueKey<String>('test-mini-player'));
Finder get _miniPlayerSlot =>
    find.byKey(const ValueKey<String>('echo-mini-player-slot'));
Finder get _miniPlayerChrome =>
    find.byKey(const ValueKey<String>('echo-mini-player-chrome'));
Finder get _networkStatusSlot =>
    find.byKey(const ValueKey<String>('echo-network-status-slot'));
Finder get _verticalShellDividers => find.byWidgetPredicate(
  (widget) => widget is EchoDivider && widget.axis == Axis.vertical,
);

Finder _compactSelectionIndicator(int branchIndex) => find.byKey(
  ValueKey<String>('echo-compact-selection-indicator-$branchIndex'),
);

Finder _mediumSelectionIndicator(int branchIndex) => find.byKey(
  ValueKey<String>('echo-medium-selection-indicator-$branchIndex'),
);

Future<void> _pumpShell(
  WidgetTester tester, {
  required Size size,
  double textScale = 1,
  double bottomSafeArea = 0,
  bool showMiniPlayer = false,
  bool disableAnimations = false,
  EchoNetworkStatus networkStatus = EchoNetworkStatus.online,
  int selectedBranchIndex = 0,
  ValueChanged<int>? onDestinationSelected,
  Widget? miniPlayer,
  Widget? body,
  ThemeData? theme,
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        theme: theme ?? AppTheme.light(),
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
            selectedBranchIndex: selectedBranchIndex,
            onDestinationSelected: onDestinationSelected ?? (_) {},
            showMiniPlayer: showMiniPlayer,
            networkStatus: networkStatus,
            miniPlayer:
                miniPlayer ??
                const SizedBox(
                  key: ValueKey<String>('test-mini-player'),
                  height: 72,
                ),
            body:
                body ??
                const SizedBox.expand(key: ValueKey<String>('test-content')),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
