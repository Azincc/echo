import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/utils/logger.dart';
import 'core/theme/app_theme.dart';

import 'features/auth/pages/login_page.dart';
import 'providers/auth_provider.dart';
import 'providers/theme_provider.dart';
import 'widgets/main_scaffold.dart';
import 'features/discover/pages/discover_page.dart';
import 'features/explore/pages/explore_page.dart';
import 'features/library/pages/library_page.dart';
import 'features/library/pages/edit_library_page.dart';

/// 应用主入口 Widget
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeSettings = ref.watch(themeSettingsProvider);

    return MaterialApp.router(
      title: 'Echoes 回响',
      theme: AppTheme.light(seedColor: themeSettings.seedColor),
      darkTheme: AppTheme.dark(seedColor: themeSettings.seedColor),
      themeMode: themeSettings.mode,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

/// 路由配置
final _homeBranchNavigatorKey = GlobalKey<NavigatorState>();
final _exploreBranchNavigatorKey = GlobalKey<NavigatorState>();
final _libraryBranchNavigatorKey = GlobalKey<NavigatorState>();

final _branchNavigatorKeys = <GlobalKey<NavigatorState>>[
  _homeBranchNavigatorKey,
  _exploreBranchNavigatorKey,
  _libraryBranchNavigatorKey,
];

final routerProvider = Provider<GoRouter>((ref) {
  // 定义 NavigatorKey，以便在 ShellRoute 中使用
  final rootNavigatorKey = GlobalKey<NavigatorState>();

  // 监听认证状态变化
  ref.listen<AuthState>(authStateProvider, (previous, next) {
    // 当认证状态变化时，刷新路由
    if (previous?.isAuthenticated != next.isAuthenticated) {
      Logger.infoWithTag(
        'ROUTER',
        'auth changed: ${previous?.isAuthenticated ?? false} -> ${next.isAuthenticated}',
      );
      rootNavigatorKey.currentState?.context.go(
        next.isAuthenticated ? '/home' : '/login',
      );
    }
  });

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/home',
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);
      final isGoingToLogin = state.matchedLocation == '/login';
      final isAddingLibrary = state.uri.queryParameters['add'] == 'true';

      // 如果已认证且正在去登录页，且不是为了添加新库，重定向到主页
      if (authState.isAuthenticated && isGoingToLogin && !isAddingLibrary) {
        return '/home';
      }

      // 如果未认证且不在登录页，重定向到登录页
      if (!authState.isAuthenticated && !isGoingToLogin) {
        return '/login';
      }

      return null;
    },
    routes: [
      // 登录页
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      // Library Edit
      GoRoute(
        path: '/library/edit/:id',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return EditLibraryPage(libraryId: id);
        },
      ),
      // StatefulShellRoute 为主要导航结构
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScaffold(
            navigationShell: navigationShell,
            branchNavigatorKeys: _branchNavigatorKeys,
          );
        },
        branches: [
          // Tab 1: 音乐流
          StatefulShellBranch(
            navigatorKey: _homeBranchNavigatorKey,
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const DiscoverPage(),
              ),
            ],
          ),
          // Tab 2: 探索
          StatefulShellBranch(
            navigatorKey: _exploreBranchNavigatorKey,
            routes: [
              GoRoute(
                path: '/explore',
                builder: (context, state) => const ExplorePage(),
              ),
            ],
          ),
          // Tab 3: 我的
          StatefulShellBranch(
            navigatorKey: _libraryBranchNavigatorKey,
            routes: [
              GoRoute(
                path: '/library',
                builder: (context, state) => const LibraryPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
