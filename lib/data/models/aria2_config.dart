class Aria2Config {
  final bool enabled;
  final String rpcUrl;
  final String username;
  final String password;
  final String downloadDir;

  const Aria2Config({
    this.enabled = false,
    this.rpcUrl = '',
    this.username = '',
    this.password = '',
    this.downloadDir = '',
  });

  bool get isConfigured =>
      rpcUrl.trim().isNotEmpty && downloadDir.trim().isNotEmpty;

  Aria2Config copyWith({
    bool? enabled,
    String? rpcUrl,
    String? username,
    String? password,
    String? downloadDir,
  }) {
    return Aria2Config(
      enabled: enabled ?? this.enabled,
      rpcUrl: rpcUrl ?? this.rpcUrl,
      username: username ?? this.username,
      password: password ?? this.password,
      downloadDir: downloadDir ?? this.downloadDir,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enabled': enabled,
      'rpcUrl': rpcUrl,
      'username': username,
      'password': password,
      'downloadDir': downloadDir,
    };
  }

  factory Aria2Config.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const Aria2Config();
    return Aria2Config(
      enabled: json['enabled'] == true,
      rpcUrl: (json['rpcUrl'] as String? ?? '').trim(),
      username: (json['username'] as String? ?? '').trim(),
      password: (json['password'] as String? ?? '').trim(),
      downloadDir: (json['downloadDir'] as String? ?? '').trim(),
    );
  }

  static Aria2Config fromLibraryExtensions(Map<String, dynamic>? extensions) {
    if (extensions == null) return const Aria2Config();
    final raw = extensions['aria2'];
    if (raw is! Map<String, dynamic>) return const Aria2Config();
    return Aria2Config.fromJson(raw);
  }
}
