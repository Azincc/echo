/// Embed Service 配置
class EmbedServiceConfig {
  final bool enabled;
  final String baseUrl;
  final String apiKey;
  final String libraryId;

  const EmbedServiceConfig({
    this.enabled = false,
    this.baseUrl = '',
    this.apiKey = '',
    this.libraryId = 'default',
  });

  bool get isConfigured =>
      baseUrl.trim().isNotEmpty && apiKey.trim().isNotEmpty;

  bool get isEnabledAndConfigured => enabled && isConfigured;

  EmbedServiceConfig copyWith({
    bool? enabled,
    String? baseUrl,
    String? apiKey,
    String? libraryId,
  }) {
    return EmbedServiceConfig(
      enabled: enabled ?? this.enabled,
      baseUrl: baseUrl ?? this.baseUrl,
      apiKey: apiKey ?? this.apiKey,
      libraryId: libraryId ?? this.libraryId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enabled': enabled,
      'baseUrl': baseUrl,
      'apiKey': apiKey,
      'libraryId': libraryId,
    };
  }

  factory EmbedServiceConfig.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const EmbedServiceConfig();
    return EmbedServiceConfig(
      enabled: json['enabled'] == true,
      baseUrl: (json['baseUrl'] as String? ?? '').trim(),
      apiKey: (json['apiKey'] as String? ?? '').trim(),
      libraryId: (json['libraryId'] as String? ?? 'default').trim(),
    );
  }

  static EmbedServiceConfig fromLibraryExtensions(
    Map<String, dynamic>? extensions,
  ) {
    if (extensions == null) return const EmbedServiceConfig();
    final raw = extensions['embedService'];
    if (raw is! Map<String, dynamic>) return const EmbedServiceConfig();
    return EmbedServiceConfig.fromJson(raw);
  }
}
