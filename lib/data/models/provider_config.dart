/// 提供商配置模型（歌词/封面通用）
class ProviderConfig {
  final String id;
  final String sourceId;
  final bool enabled;
  final int priority;
  final Map<String, dynamic>? config;

  ProviderConfig({
    required this.id,
    required this.sourceId,
    this.enabled = true,
    required this.priority,
    this.config,
  });

  ProviderConfig copyWith({
    String? id,
    String? sourceId,
    bool? enabled,
    int? priority,
    Map<String, dynamic>? config,
  }) {
    return ProviderConfig(
      id: id ?? this.id,
      sourceId: sourceId ?? this.sourceId,
      enabled: enabled ?? this.enabled,
      priority: priority ?? this.priority,
      config: config ?? this.config,
    );
  }
}
