import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
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
    initialLocation: '/splash',
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);
      final isGoingToLogin = state.matchedLocation == '/login';
      final isGoingToSplash = state.matchedLocation == '/splash';
      final isAddingLibrary = state.uri.queryParameters['add'] == 'true';

      // 如果已认证且正在去登录页，且不是为了添加新库，重定向到主页
      if (authState.isAuthenticated && isGoingToLogin && !isAddingLibrary) {
        return '/home';
      }

      // 如果未认证且不在登录页和启动页，重定向到登录页
      if (!authState.isAuthenticated && !isGoingToLogin && !isGoingToSplash) {
        return '/login';
      }

      return null;
    },
    routes: [
      // 启动页
      GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
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

/// 启动页 - 检查登录状态并自动跳转
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    Logger.infoWithTag('SPLASH', 'startup auth check begin');
    // 请求通知权限 (Android 13+)
    if (!kIsWeb && Platform.isAndroid) {
      await Permission.notification.request();
    }

    // 等待认证状态加载
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    final authState = ref.read(authStateProvider);

    if (!mounted) return;

    if (authState.isAuthenticated) {
      if (mounted) context.go('/home');
      Logger.infoWithTag('SPLASH', 'startup auth check result: go /home');
    } else {
      if (mounted) context.go('/login');
      Logger.infoWithTag('SPLASH', 'startup auth check result: go /login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.music_note,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              'Echoes 回响',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '正在初始化...',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
