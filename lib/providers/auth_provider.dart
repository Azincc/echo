import 'package:echoes/data/models/music_library.dart';
import 'package:echoes/core/utils/logger.dart';
import 'package:echoes/data/repositories/auth_repository.dart';
import 'package:echoes/data/repositories/library_repository.dart';

import 'package:echoes/providers/library_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 认证仓库 Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

/// 认证状态 Provider
final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  final libraryRepository = ref.watch(libraryRepositoryProvider);
  return AuthNotifier(repository, libraryRepository);
});

/// 认证状态
class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final bool isInitializing;
  final MusicLibrary? currentLibrary;
  final String? errorMessage;

  AuthState({
    this.isAuthenticated = false,
    this.isLoading = false,
    this.isInitializing = true,
    this.currentLibrary,
    this.errorMessage,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    bool? isInitializing,
    MusicLibrary? currentLibrary,
    String? errorMessage,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      isInitializing: isInitializing ?? this.isInitializing,
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

    try {
      final libraries = await _libraryRepository.watchLibraries().first;
      final active = libraries.where((l) => l.isActive).firstOrNull;
      if (active != null) {
        state = state.copyWith(
          isAuthenticated: true,
          isLoading: false,
          isInitializing: false,
          currentLibrary: active,
        );
        Logger.infoWithTag(
          'AUTH',
          'auth state init success, active library=${active.name}',
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          isInitializing: false,
          isAuthenticated: false,
        );
        Logger.warnWithTag('AUTH', 'auth state init: no active library');
      }
    } catch (e, stackTrace) {
      state = state.copyWith(
        isLoading: false,
        isInitializing: false,
        isAuthenticated: false,
      );
      Logger.errorWithTag('AUTH', 'auth state init failed', e, stackTrace);
    }
  }

  /// 使用密码登录
  Future<bool> loginWithPassword({
    required String serverUrl,
    required String username,
    required String password,
    String? libraryName,
    String? addressLabel,
  }) async {
    Logger.infoWithTag('AUTH', 'loginWithPassword start: $serverUrl/$username');
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _repository.loginWithPassword(
      serverUrl: serverUrl,
      username: username,
      password: password,
      libraryName: libraryName,
      addressLabel: addressLabel,
    );

    return _handleLoginResult(result);
  }

  /// 使用 API Key 登录
  Future<bool> loginWithApiKey({
    required String serverUrl,
    required String username,
    required String apiKey,
    String? libraryName,
    String? addressLabel,
  }) async {
    Logger.infoWithTag('AUTH', 'loginWithApiKey start: $serverUrl/$username');
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _repository.loginWithApiKey(
      serverUrl: serverUrl,
      username: username,
      apiKey: apiKey,
      libraryName: libraryName,
      addressLabel: addressLabel,
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

  /// 登出（停用当前 Library，保留记录以便重新登录）
  Future<void> logout() async {
    Logger.infoWithTag('AUTH', 'logout start');

    if (state.currentLibrary != null) {
      try {
        await _libraryRepository.setActiveLibrary('');
      } catch (e, stackTrace) {
        Logger.errorWithTag(
          'AUTH',
          'failed to clear active library',
          e,
          stackTrace,
        );
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
