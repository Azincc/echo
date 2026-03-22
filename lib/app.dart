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

import 'dart:io';

/// 应用主入口 Widget
class App extends ConsumerWidget {
  const App({super.key});

  bool _isDesktopScaledPlatform() {
    return Platform.isWindows || Platform.isMacOS;
  }

  double _resolveDesktopTextScale(MediaQueryData mediaQueryData) {
    final width = mediaQueryData.size.width;
    final shortestSide = mediaQueryData.size.shortestSide;
    final longestPhysicalSide =
        mediaQueryData.size.longestSide * mediaQueryData.devicePixelRatio;

    if (longestPhysicalSide >= 3800 || width >= 2200 || shortestSide >= 1400) {
      return 0.86;
    }
    if (longestPhysicalSide >= 3000 || width >= 1800 || shortestSide >= 1100) {
      return 0.90;
    }
    if (longestPhysicalSide >= 2400 || width >= 1440 || shortestSide >= 900) {
      return 0.95;
    }
    return 1.0;
  }

  VisualDensity _resolveDesktopVisualDensity(double scaleFactor) {
    if (scaleFactor <= 0.86) {
      return const VisualDensity(horizontal: -2, vertical: -2);
    }
    if (scaleFactor <= 0.90) {
      return const VisualDensity(horizontal: -1.5, vertical: -1.5);
    }
    if (scaleFactor < 1.0) {
      return const VisualDensity(horizontal: -1, vertical: -1);
    }
    return VisualDensity.standard;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeSettings = ref.watch(themeSettingsProvider);

    return MaterialApp.router(
      title: 'Echoes',
      theme: AppTheme.light(seedColor: themeSettings.seedColor),
      darkTheme: AppTheme.dark(seedColor: themeSettings.seedColor),
      themeMode: themeSettings.mode,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        if (!_isDesktopScaledPlatform()) {
          return child!;
        }

        final desktopTextScale = _resolveDesktopTextScale(mediaQueryData);
        final desktopVisualDensity = _resolveDesktopVisualDensity(
          desktopTextScale,
        );

        // High-DPI desktop windows can feel oversized with the default Material
        // metrics. Apply a mild adaptive scale-down for Windows/macOS based on
        // the current viewport and DPR, while leaving smaller desktop windows
        // untouched.
        return MediaQuery(
          data: mediaQueryData.copyWith(
            textScaler: TextScaler.linear(
              mediaQueryData.textScaler.scale(1.0) * desktopTextScale,
            ),
          ),
          child: Theme(
            data: Theme.of(
              context,
            ).copyWith(visualDensity: desktopVisualDensity),
            child: child!,
          ),
        );
      },
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
    final wasAuth = previous?.isAuthenticated ?? false;
    final wasInit = previous?.isInitializing ?? true;

    // 认证状态变化 OR 初始化完成 → 执行路由跳转
    if (wasAuth != next.isAuthenticated || (wasInit && !next.isInitializing)) {
      Logger.infoWithTag(
        'ROUTER',
        'auth changed: auth=$wasAuth->${next.isAuthenticated} init=$wasInit->${next.isInitializing}',
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

      // 初始化中，不做任何重定向，保持在 /home
      if (authState.isInitializing) {
        return null;
      }

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
