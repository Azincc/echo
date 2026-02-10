import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../../core/utils/subsonic_auth.dart';
import '../../core/utils/logger.dart';
import '../models/server_config.dart';

/// Subsonic API 客户端
class SubsonicApiClient {
  late final Dio _dio;
  ServerConfig? _config;

  SubsonicApiClient() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        responseType: ResponseType.json,
      ),
    );

    // 添加日志拦截器（仅调试模式）
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (obj) => Logger.debug(obj.toString()),
    ));

    // 添加认证拦截器
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _addAuthParams(options);
          handler.next(options);
        },
        onError: (error, handler) {
          Logger.error('API Error', error);
          handler.next(error);
        },
      ),
    );
  }

  /// 设置服务器配置
  void setConfig(ServerConfig config) {
    _config = config;
    _dio.options.baseUrl = config.serverUrl;
  }

  /// 添加认证参数到请求
  void _addAuthParams(RequestOptions options) {
    if (_config == null) return;

    Map<String, String> authParams;

    if (_config!.authType == AuthType.apiKey && _config!.apiKey != null) {
      // API Key 认证
      authParams = SubsonicAuth.generateApiKeyAuthParams(
        apiKey: _config!.apiKey!,
        version: ApiConstants.apiVersion,
        clientName: ApiConstants.clientName,
        format: ApiConstants.format,
      );
    } else if (_config!.password != null) {
      // Token/Salt 认证
      authParams = SubsonicAuth.generateTokenAuthParams(
        username: _config!.username,
        password: _config!.password!,
        version: ApiConstants.apiVersion,
        clientName: ApiConstants.clientName,
        format: ApiConstants.format,
      );
    } else {
      Logger.warn('No valid authentication credentials');
      return;
    }

    // 合并认证参数到查询参数
    options.queryParameters.addAll(authParams);
  }

  /// 检查响应状态
  void _checkResponse(Map<String, dynamic> data) {
    final response = data['subsonic-response'];
    if (response == null) {
      throw Exception('Invalid response: missing subsonic-response');
    }

    final status = response['status'];
    if (status != 'ok') {
      final error = response['error'];
      final message = error?['message'] ?? 'Unknown error';
      final code = error?['code'] ?? 0;
      throw SubsonicException(message, code);
    }
  }

  /// Ping 测试连接
  Future<PingResult> ping() async {
    try {
      final response = await _dio.get(ApiConstants.ping);
      final data = response.data as Map<String, dynamic>;
      _checkResponse(data);

      final subsonicResponse = data['subsonic-response'];

      return PingResult(
        success: true,
        isOpenSubsonic: subsonicResponse['openSubsonic'] == true,
        serverType: subsonicResponse['type'] as String?,
        serverVersion: subsonicResponse['serverVersion'] as String?,
      );
    } on DioException catch (e) {
      Logger.error('Ping failed', e);
      return PingResult(
        success: false,
        errorMessage: e.message,
      );
    } catch (e) {
      Logger.error('Ping failed', e);
      return PingResult(
        success: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// 获取 OpenSubsonic 扩展列表
  Future<List<String>> getOpenSubsonicExtensions() async {
    try {
      final response = await _dio.get(ApiConstants.getOpenSubsonicExtensions);
      final data = response.data as Map<String, dynamic>;
      _checkResponse(data);

      final subsonicResponse = data['subsonic-response'];
      final extensions = subsonicResponse['openSubsonicExtensions'] as List?;

      if (extensions == null) return [];

      return extensions
          .map((e) => (e as Map<String, dynamic>)['name'] as String)
          .toList();
    } catch (e) {
      Logger.warn('Failed to get OpenSubsonic extensions', e);
      return [];
    }
  }

  /// 通用 GET 请求
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.get(
      path,
      queryParameters: queryParameters,
    );
    final data = response.data as Map<String, dynamic>;
    _checkResponse(data);
    return data['subsonic-response'];
  }

  /// 通用 POST 请求
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) async {
    final response = await _dio.post(
      path,
      queryParameters: queryParameters,
      data: data,
    );
    final responseData = response.data as Map<String, dynamic>;
    _checkResponse(responseData);
    return responseData['subsonic-response'];
  }

  /// 获取 Dio 实例（用于流式播放等特殊场景）
  Dio get dio => _dio;
}

/// Ping 结果
class PingResult {
  final bool success;
  final bool isOpenSubsonic;
  final String? serverType;
  final String? serverVersion;
  final String? errorMessage;

  PingResult({
    required this.success,
    this.isOpenSubsonic = false,
    this.serverType,
    this.serverVersion,
    this.errorMessage,
  });
}

/// Subsonic 异常
class SubsonicException implements Exception {
  final String message;
  final int code;

  SubsonicException(this.message, this.code);

  @override
  String toString() => 'SubsonicException: $message (code: $code)';
}
