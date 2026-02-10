import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/pages/login_page.dart';
import 'providers/auth_provider.dart';
import 'widgets/main_scaffold.dart';

/// 应用主入口 Widget
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'SubSonic Flow',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

/// 路由配置
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);
      final isGoingToLogin = state.matchedLocation == '/login';
      final isGoingToSplash = state.matchedLocation == '/splash';

      // 如果已认证且正在去登录页，重定向到主页
      if (authState.isAuthenticated && isGoingToLogin) {
        return '/home';
      }

      // 如果未认证且不在登录页和启动页，重定向到登录页
      if (!authState.isAuthenticated && !isGoingToLogin && !isGoingToSplash) {
        return '/login';
      }

      return null;
    },
    routes: [
      // 启动页（将在后续步骤中实现检查登录状态）
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      // 登录页
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      // 主页
      GoRoute(
        path: '/home',
        builder: (context, state) => const MainScaffold(),
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
    // 等待认证状态加载
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    final authState = ref.read(authStateProvider);

    if (!mounted) return;

    if (authState.isAuthenticated) {
      if (mounted) context.go('/home');
    } else {
      if (mounted) context.go('/login');
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
              'SubSonic Flow',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
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
