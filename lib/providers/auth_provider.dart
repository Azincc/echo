import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/server_config.dart';
import '../data/repositories/auth_repository.dart';
import '../data/sources/subsonic_api_client.dart';

/// API 客户端 Provider
final apiClientProvider = Provider<SubsonicApiClient>((ref) {
  return SubsonicApiClient();
});

/// 认证仓库 Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthRepository(apiClient);
});

/// 认证状态 Provider
final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  final apiClient = ref.watch(apiClientProvider);
  return AuthNotifier(repository, apiClient);
});

/// 认证状态
class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final ServerConfig? config;
  final String? errorMessage;

  AuthState({
    this.isAuthenticated = false,
    this.isLoading = false,
    this.config,
    this.errorMessage,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    ServerConfig? config,
    String? errorMessage,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      config: config ?? this.config,
      errorMessage: errorMessage,
    );
  }
}

/// 认证状态管理器
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;
  final SubsonicApiClient _apiClient;

  AuthNotifier(this._repository, this._apiClient) : super(AuthState()) {
    _init();
  }

  /// 初始化：加载已保存的配置
  Future<void> _init() async {
    state = state.copyWith(isLoading: true);
    final config = await _repository.loadSavedConfig();
    if (config != null) {
      _apiClient.setConfig(config);
      state = state.copyWith(
        isAuthenticated: true,
        isLoading: false,
        config: config,
      );
    } else {
      state = state.copyWith(isLoading: false);
    }
  }

  /// 使用密码登录
  Future<bool> loginWithPassword({
    required String serverUrl,
    required String username,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _repository.loginWithPassword(
      serverUrl: serverUrl,
      username: username,
      password: password,
    );

    if (result.success && result.config != null) {
      state = state.copyWith(
        isAuthenticated: true,
        isLoading: false,
        config: result.config,
      );
      return true;
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage: result.errorMessage,
      );
      return false;
    }
  }

  /// 使用 API Key 登录
  Future<bool> loginWithApiKey({
    required String serverUrl,
    required String username,
    required String apiKey,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _repository.loginWithApiKey(
      serverUrl: serverUrl,
      username: username,
      apiKey: apiKey,
    );

    if (result.success && result.config != null) {
      state = state.copyWith(
        isAuthenticated: true,
        isLoading: false,
        config: result.config,
      );
      return true;
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage: result.errorMessage,
      );
      return false;
    }
  }

  /// 登出
  Future<void> logout() async {
    await _repository.logout();
    _apiClient.setConfig(null);  // 清除 API 客户端配置
    state = AuthState();
  }

  /// 清除错误消息
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
