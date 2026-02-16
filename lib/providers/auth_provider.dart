// import 'package:dio/dio.dart'; // unused? No, used for ref.watch(dioProvider) below? Actually below it uses 'dioProvider'.
// dioProvider returns Dio.

// import 'package:echoes/core/constants/api_constants.dart'; // unused

import 'package:echoes/data/models/music_library.dart'; // New model
import 'package:echoes/core/utils/logger.dart';
import 'package:echoes/data/repositories/auth_repository.dart';
import 'package:echoes/data/repositories/library_repository.dart';

import 'package:echoes/providers/library_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Removed apiClientProvider as it is replaced by subsonicApiClientProvider in api_provider.dart

/// 认证仓库 Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  // Dio is no longer injected into AuthRepository as it creates its own ephemeral clients.
  return AuthRepository();
});

/// 认证状态 Provider
final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  final libraryRepository = ref.watch(libraryRepositoryProvider);
  // We don't need apiClient here anymore for login logic, as AuthRepository creates temp clients.
  // But for logout or session checks, we might.

  return AuthNotifier(repository, libraryRepository);
});

/// 认证状态
class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  // Replaced ServerConfig with MusicLibrary
  final MusicLibrary? currentLibrary;
  final String? errorMessage;

  AuthState({
    this.isAuthenticated = false,
    this.isLoading = false,
    this.currentLibrary,
    this.errorMessage,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    MusicLibrary? currentLibrary,
    String? errorMessage,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      currentLibrary: currentLibrary ?? this.currentLibrary,
      errorMessage: errorMessage,
    );
  }
}

/// 认证状态管理器
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;
  final LibraryRepository _libraryRepository;

  AuthNotifier(this._repository, this._libraryRepository) : super(AuthState()) {
    _init();
  }

  /// 初始化：加载活跃的 Library
  Future<void> _init() async {
    Logger.infoWithTag('AUTH', 'auth state init start');
    state = state.copyWith(isLoading: true);

    // We need to wait for library provider to load?
    // Actually we can just check if there is an active library in the repository.
    // Or simpler: The librariesProvider will emit libraries.
    // But StateNotifier init is sync-ish.

    // Let's defer to ACTIVE library provider?
    // If we want auth state to reflect active library.

    // For now, let's async check active library.
    try {
      final libraries = await _libraryRepository.watchLibraries().first;
      try {
        final active = libraries.firstWhere((l) => l.isActive);
        state = state.copyWith(
          isAuthenticated: true,
          isLoading: false,
          currentLibrary: active,
        );
        Logger.infoWithTag(
          'AUTH',
          'auth state init success, active library=${active.name}',
        );
      } catch (_) {
        state = state.copyWith(isLoading: false, isAuthenticated: false);
        Logger.warnWithTag('AUTH', 'auth state init: no active library');
      }
    } catch (e, stackTrace) {
      state = state.copyWith(isLoading: false, isAuthenticated: false);
      Logger.errorWithTag('AUTH', 'auth state init failed', e, stackTrace);
    }
  }

  /// 使用密码登录
  Future<bool> loginWithPassword({
    required String serverUrl,
    required String username,
    required String password,
  }) async {
    Logger.infoWithTag('AUTH', 'loginWithPassword start: $serverUrl/$username');
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _repository.loginWithPassword(
      serverUrl: serverUrl,
      username: username,
      password: password,
    );

    return _handleLoginResult(result);
  }

  /// 使用 API Key 登录
  Future<bool> loginWithApiKey({
    required String serverUrl,
    required String username,
    required String apiKey,
  }) async {
    Logger.infoWithTag('AUTH', 'loginWithApiKey start: $serverUrl/$username');
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _repository.loginWithApiKey(
      serverUrl: serverUrl,
      username: username,
      apiKey: apiKey,
    );

    return _handleLoginResult(result);
  }

  Future<bool> _handleLoginResult(LoginResult result) async {
    if (result.success && result.library != null) {
      // Save to DB
      await _libraryRepository.addLibrary(result.library!);

      // Set Active
      await _libraryRepository.setActiveLibrary(result.library!.id);

      // Refresh state
      state = state.copyWith(
        isAuthenticated: true,
        isLoading: false,
        currentLibrary: result.library!,
      );
      Logger.infoWithTag(
        'AUTH',
        'login success: library=${result.library!.name} id=${result.library!.id}',
      );

      return true;
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage: result.errorMessage,
      );
      Logger.warnWithTag(
        'AUTH',
        'login failed: ${result.errorMessage ?? 'unknown error'}',
      );
      return false;
    }
  }

  /// 登出
  Future<void> logout() async {
    Logger.infoWithTag('AUTH', 'logout start');
    // Just deactivate current library? Or delete?
    // Usually logout means "switching users" or "clearing session".
    // For Multi-account, logout might just mean "Go to Library selection" or "Deactivate current".

    // Let's just unset active
    if (state.currentLibrary != null) {
      // We don't necessarily delete it. But if standard "Logout" implies "Forget me", then delete?
      // Let's assume Logout = Deactivate for now, user can switch or add new account.
      // Actually "Logout" usually means clearing credentials.
      // Plan says: "Binding libraries to users".

      // For simple "Logout" behavior:
      // Just set isAuthenticated = false.
      // We might want to clear active library in DB too?
      try {
        await _libraryRepository.setActiveLibrary(
          '',
        ); // Empty ID? Or implement "clearActive"
      } catch (e, stackTrace) {
        Logger.errorWithTag('AUTH', 'failed to clear active library', e, stackTrace);
      }
    }

    state = AuthState(isAuthenticated: false);
    Logger.infoWithTag('AUTH', 'logout completed');
  }

  /// 切换当前 Library
  void switchLibrary(MusicLibrary library) {
    Logger.infoWithTag('AUTH', 'switchLibrary: ${library.name}');
    state = state.copyWith(currentLibrary: library, isAuthenticated: true);
  }

  /// 清除错误消息
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
