/// 服务器配置模型
class ServerConfig {
  final String serverUrl;
  final String username;
  final String? password;
  final String? apiKey;
  final AuthType authType;

  // OpenSubsonic 信息
  final bool isOpenSubsonic;
  final String? serverType;
  final String? serverVersion;
  final List<String> extensions;

  const ServerConfig({
    required this.serverUrl,
    required this.username,
    this.password,
    this.apiKey,
    required this.authType,
    this.isOpenSubsonic = false,
    this.serverType,
    this.serverVersion,
    this.extensions = const [],
  });

  /// 从 JSON 反序列化
  factory ServerConfig.fromJson(Map<String, dynamic> json) {
    return ServerConfig(
      serverUrl: json['serverUrl'] as String,
      username: json['username'] as String,
      password: json['password'] as String?,
      apiKey: json['apiKey'] as String?,
      authType: AuthType.values.firstWhere(
        (e) => e.name == json['authType'],
        orElse: () => AuthType.token,
      ),
      isOpenSubsonic: json['isOpenSubsonic'] as bool? ?? false,
      serverType: json['serverType'] as String?,
      serverVersion: json['serverVersion'] as String?,
      extensions: (json['extensions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  /// 序列化为 JSON
  Map<String, dynamic> toJson() {
    return {
      'serverUrl': serverUrl,
      'username': username,
      'password': password,
      'apiKey': apiKey,
      'authType': authType.name,
      'isOpenSubsonic': isOpenSubsonic,
      'serverType': serverType,
      'serverVersion': serverVersion,
      'extensions': extensions,
    };
  }

  /// 复制并更新部分字段
  ServerConfig copyWith({
    String? serverUrl,
    String? username,
    String? password,
    String? apiKey,
    AuthType? authType,
    bool? isOpenSubsonic,
    String? serverType,
    String? serverVersion,
    List<String>? extensions,
  }) {
    return ServerConfig(
      serverUrl: serverUrl ?? this.serverUrl,
      username: username ?? this.username,
      password: password ?? this.password,
      apiKey: apiKey ?? this.apiKey,
      authType: authType ?? this.authType,
      isOpenSubsonic: isOpenSubsonic ?? this.isOpenSubsonic,
      serverType: serverType ?? this.serverType,
      serverVersion: serverVersion ?? this.serverVersion,
      extensions: extensions ?? this.extensions,
    );
  }
}

/// 认证类型
enum AuthType {
  token, // Token/Salt 认证（传统 Subsonic）
  apiKey, // API Key 认证（OpenSubsonic 扩展）
}
