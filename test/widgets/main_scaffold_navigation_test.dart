import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/providers/navigation_provider.dart';
import 'package:echoes/widgets/main_scaffold.dart';
import 'package:echoes/widgets/echo_app_shell/echo_network_status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  group('MainScaffold back decision', () {
    test('keeps the established five-level priority', () {
      expect(
        resolveEchoBackAction(
          drawerOpen: true,
          rootCanPop: true,
          branchCanPop: true,
          currentBranchIndex: libraryBranchIndex,
        ),
        EchoBackAction.closeDrawer,
      );
      expect(
        resolveEchoBackAction(
          drawerOpen: false,
          rootCanPop: true,
          branchCanPop: true,
          currentBranchIndex: libraryBranchIndex,
        ),
        EchoBackAction.popRootNavigator,
      );
      expect(
        resolveEchoBackAction(
          drawerOpen: false,
          rootCanPop: false,
          branchCanPop: true,
          currentBranchIndex: libraryBranchIndex,
        ),
        EchoBackAction.popBranchNavigator,
      );
      expect(
        resolveEchoBackAction(
          drawerOpen: false,
          rootCanPop: false,
          branchCanPop: false,
          currentBranchIndex: libraryBranchIndex,
        ),
        EchoBackAction.switchToDiscover,
      );
      expect(
        resolveEchoBackAction(
          drawerOpen: false,
          rootCanPop: false,
          branchCanPop: false,
          currentBranchIndex: discoverBranchIndex,
        ),
        EchoBackAction.moveAppToBackground,
      );
    });
  });

  group('MainScaffold destination mapping', () {
    testWidgets('page drawer trigger is compact-only', (tester) async {
      Future<void> pumpAtWidth(double width) async {
        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = Size(width, 800);
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.light(),
            home: Builder(
              builder: (context) => Text(
                shouldShowPageDrawerTrigger(context) ? 'compact' : 'wide',
              ),
            ),
          ),
        );
        await tester.pump();
      }

      addTearDown(tester.view.reset);
      await pumpAtWidth(599);
      expect(find.text('compact'), findsOneWidget);

      await pumpAtWidth(600);
      expect(find.text('wide'), findsOneWidget);
    });

    test('keeps fixed branch indices while Explore is dynamically visible', () {
      expect(
        echoMainDestinations(
          showExploreTab: true,
        ).map((destination) => destination.branchIndex),
        <int>[discoverBranchIndex, exploreBranchIndex, libraryBranchIndex],
      );
      expect(
        echoMainDestinations(
          showExploreTab: false,
        ).map((destination) => destination.branchIndex),
        <int>[discoverBranchIndex, libraryBranchIndex],
      );
    });

    testWidgets('preserves branch stacks and resets a reselected branch', (
      tester,
    ) async {
      final harness = await _pumpMainScaffold(tester);

      harness.router.go('/home/detail');
      await tester.pumpAndSettle();
      expect(find.text('Home detail'), findsOneWidget);

      await tester.tap(find.bySemanticsLabel('我的'));
      await tester.pumpAndSettle();
      expect(find.text('Library root'), findsOneWidget);
      expect(
        harness.container.read(currentVisibleBranchIndexProvider),
        libraryBranchIndex,
      );

      await tester.tap(find.bySemanticsLabel('音乐流'));
      await tester.pumpAndSettle();
      expect(find.text('Home detail'), findsOneWidget);
      expect(
        harness.container.read(currentVisibleBranchIndexProvider),
        discoverBranchIndex,
      );

      await tester.tap(find.bySemanticsLabel('音乐流'));
      await tester.pumpAndSettle();
      expect(find.text('Home root'), findsOneWidget);
      expect(find.text('Home detail'), findsNothing);
    });

    testWidgets(
      'hiding active Explore falls back to Home and syncs visibility',
      (tester) async {
        final harness = await _pumpMainScaffold(tester);

        await tester.tap(find.bySemanticsLabel('探索'));
        await tester.pumpAndSettle();
        expect(find.text('Explore root'), findsOneWidget);
        expect(
          harness.container.read(currentVisibleBranchIndexProvider),
          exploreBranchIndex,
        );

        harness.router.go('/explore/detail');
        await tester.pumpAndSettle();
        expect(find.text('Explore detail'), findsOneWidget);

        harness.showExplore.value = false;
        await tester.pumpAndSettle();

        expect(find.text('Home root'), findsOneWidget);
        expect(find.bySemanticsLabel('探索'), findsNothing);
        expect(
          harness.container.read(currentVisibleBranchIndexProvider),
          discoverBranchIndex,
        );

        harness.showExplore.value = true;
        await tester.pumpAndSettle();
        await tester.tap(find.bySemanticsLabel('探索'));
        await tester.pumpAndSettle();
        expect(find.text('Explore detail'), findsOneWidget);
        expect(
          harness.container.read(currentVisibleBranchIndexProvider),
          exploreBranchIndex,
        );
      },
    );
  });
}

Future<_MainScaffoldHarness> _pumpMainScaffold(WidgetTester tester) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(390, 800);
  addTearDown(tester.view.reset);

  final container = ProviderContainer();
  addTearDown(container.dispose);
  final showExplore = ValueNotifier<bool>(true);
  addTearDown(showExplore.dispose);
  final branchNavigatorKeys = <GlobalKey<NavigatorState>>[
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  final router = GoRouter(
    initialLocation: '/home',
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ValueListenableBuilder<bool>(
            valueListenable: showExplore,
            builder: (context, showExploreTab, child) {
              return MainScaffold(
                navigationShell: navigationShell,
                branchNavigatorKeys: branchNavigatorKeys,
                showExploreTabOverride: showExploreTab,
                showMiniPlayerOverride: false,
                networkStatusOverride: EchoNetworkStatus.online,
                drawerOverride: const SizedBox(width: 320),
                miniPlayerOverride: const SizedBox(height: 72),
              );
            },
          );
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: branchNavigatorKeys[discoverBranchIndex],
            routes: <RouteBase>[
              GoRoute(
                path: '/home',
                builder: (context, state) => const _BranchPage('Home root'),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'detail',
                    builder: (context, state) =>
                        const _BranchPage('Home detail'),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: branchNavigatorKeys[exploreBranchIndex],
            routes: <RouteBase>[
              GoRoute(
                path: '/explore',
                builder: (context, state) => const _BranchPage('Explore root'),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'detail',
                    builder: (context, state) =>
                        const _BranchPage('Explore detail'),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: branchNavigatorKeys[libraryBranchIndex],
            routes: <RouteBase>[
              GoRoute(
                path: '/library',
                builder: (context, state) => const _BranchPage('Library root'),
              ),
            ],
          ),
        ],
      ),
    ],
  );
  addTearDown(router.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp.router(theme: AppTheme.light(), routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();

  return _MainScaffoldHarness(
    router: router,
    container: container,
    showExplore: showExplore,
  );
}

class _MainScaffoldHarness {
  const _MainScaffoldHarness({
    required this.router,
    required this.container,
    required this.showExplore,
  });

  final GoRouter router;
  final ProviderContainer container;
  final ValueNotifier<bool> showExplore;
}

class _BranchPage extends StatelessWidget {
  const _BranchPage(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(label)));
  }
}
