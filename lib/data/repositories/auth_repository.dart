import '../models/server_config.dart';
import '../sources/subsonic_api_client.dart';
import '../sources/local_storage.dart';
import '../../core/utils/logger.dart';

/// 认证仓库
class AuthRepository {
  final SubsonicApiClient _apiClient;

  AuthRepository(this._apiClient);

  /// 探测服务器能力（检测是否支持 OpenSubsonic）
  Future<ServerCapabilities> detectServerCapabilities(String serverUrl) async {
    try {
      // 临时创建一个没有认证的客户端来探测
      final tempClient = SubsonicApiClient();
      tempClient.setConfig(
        ServerConfig(
          serverUrl: serverUrl,
          username: '',
          authType: AuthType.token,
        ),
      );

      // 不带认证参数的 ping（某些服务器允许）
      // 如果失败也没关系，我们主要是看响应格式
      try {
        final result = await tempClient.ping();
        return ServerCapabilities(
          isOpenSubsonic: result.isOpenSubsonic,
          serverType: result.serverType,
          serverVersion: result.serverVersion,
          supportsApiKey: result.isOpenSubsonic,
        );
      } catch (e) {
        // ping 失败（需要认证），但我们可以从错误响应中判断
        // 默认假设是传统 Subsonic
        return ServerCapabilities(
          isOpenSubsonic: false,
          supportsApiKey: false,
        );
      }
    } catch (e) {
      Logger.error('Failed to detect server capabilities', e);
      rethrow;
    }
  }

  /// 使用 Token/Salt 方式登录
  Future<LoginResult> loginWithPassword({
    required String serverUrl,
    required String username,
    required String password,
  }) async {
    try {
      final config = ServerConfig(
        serverUrl: serverUrl,
        username: username,
        password: password,
        authType: AuthType.token,
      );

      _apiClient.setConfig(config);

      // 执行 ping 测试
      final pingResult = await _apiClient.ping();

      if (!pingResult.success) {
        return LoginResult(
          success: false,
          errorMessage: pingResult.errorMessage ?? '连接失败',
        );
      }

      // 更新配置（添加服务器信息）
      final updatedConfig = config.copyWith(
        isOpenSubsonic: pingResult.isOpenSubsonic,
        serverType: pingResult.serverType,
        serverVersion: pingResult.serverVersion,
      );

      // 如果是 OpenSubsonic，获取扩展列表
      List<String> extensions = [];
      if (pingResult.isOpenSubsonic) {
        extensions = await _apiClient.getOpenSubsonicExtensions();
      }

      final finalConfig = updatedConfig.copyWith(extensions: extensions);

      // 保存配置
      await LocalStorage.saveServerConfig(finalConfig);

      return LoginResult(
        success: true,
        config: finalConfig,
      );
    } catch (e) {
      Logger.error('Login with password failed', e);
      return LoginResult(
        success: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// 使用 API Key 方式登录
  Future<LoginResult> loginWithApiKey({
    required String serverUrl,
    required String username,
    required String apiKey,
  }) async {
    try {
      final config = ServerConfig(
        serverUrl: serverUrl,
        username: username,
        apiKey: apiKey,
        authType: AuthType.apiKey,
      );

      _apiClient.setConfig(config);

      // 执行 ping 测试
      final pingResult = await _apiClient.ping();

      if (!pingResult.success) {
        return LoginResult(
          success: false,
          errorMessage: pingResult.errorMessage ?? '连接失败',
        );
      }

      // 更新配置
      final updatedConfig = config.copyWith(
        isOpenSubsonic: pingResult.isOpenSubsonic,
        serverType: pingResult.serverType,
        serverVersion: pingResult.serverVersion,
      );

      // 获取扩展列表
      final extensions = await _apiClient.getOpenSubsonicExtensions();
      final finalConfig = updatedConfig.copyWith(extensions: extensions);

      // 保存配置
      await LocalStorage.saveServerConfig(finalConfig);

      return LoginResult(
        success: true,
        config: finalConfig,
      );
    } catch (e) {
      Logger.error('Login with API key failed', e);
      return LoginResult(
        success: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// 加载已保存的配置
  Future<ServerConfig?> loadSavedConfig() async {
    return await LocalStorage.getServerConfig();
  }

  /// 登出
  Future<void> logout() async {
    await LocalStorage.clearServerConfig();
  }
}

/// 服务器能力
class ServerCapabilities {
  final bool isOpenSubsonic;
  final String? serverType;
  final String? serverVersion;
  final bool supportsApiKey;

  ServerCapabilities({
    required this.isOpenSubsonic,
    this.serverType,
    this.serverVersion,
    required this.supportsApiKey,
  });
}

/// 登录结果
class LoginResult {
  final bool success;
  final ServerConfig? config;
  final String? errorMessage;

  LoginResult({
    required this.success,
    this.config,
    this.errorMessage,
  });
}
