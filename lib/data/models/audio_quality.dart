import 'dart:convert';

/// 音质级别枚举
enum AudioQualityLevel {
  original, // 原始直连（不传 maxBitRate 和 format）
  high, // 高品质 320kbps
  standard, // 标准 192kbps
  dataSaver, // 流量节省 128kbps
}

/// 音质级别扩展
extension AudioQualityLevelExt on AudioQualityLevel {
  /// 获取对应的 maxBitRate（用于 /rest/stream 请求）
  int? get maxBitRate => switch (this) {
    AudioQualityLevel.original => null, // 不限制
    AudioQualityLevel.high => 320,
    AudioQualityLevel.standard => 192,
    AudioQualityLevel.dataSaver => 128,
  };

  String get displayName => switch (this) {
    AudioQualityLevel.original => '原始无损',
    AudioQualityLevel.high => '高品质 (320kbps)',
    AudioQualityLevel.standard => '标准 (192kbps)',
    AudioQualityLevel.dataSaver => '流量节省 (128kbps)',
  };

  /// 从字符串解析
  static AudioQualityLevel fromString(String value) {
    return AudioQualityLevel.values.firstWhere(
      (e) => e.name == value,
      orElse: () => AudioQualityLevel.original,
    );
  }

  /// 音质的排序级别（用于比较高低）
  int get rank => switch (this) {
    AudioQualityLevel.original => 3,
    AudioQualityLevel.high => 2,
    AudioQualityLevel.standard => 1,
    AudioQualityLevel.dataSaver => 0,
  };
}

/// 音质设置（持久化到 SharedPreferences）
class AudioQualitySettings {
  final AudioQualityLevel wifiQuality; // Wi-Fi 下使用的音质
  final AudioQualityLevel mobileQuality; // 移动数据下使用的音质
  final bool autoSwitch; // 是否按网络类型自动切换

  const AudioQualitySettings({
    this.wifiQuality = AudioQualityLevel.original,
    this.mobileQuality = AudioQualityLevel.standard,
    this.autoSwitch = true,
  });

  AudioQualitySettings copyWith({
    AudioQualityLevel? wifiQuality,
    AudioQualityLevel? mobileQuality,
    bool? autoSwitch,
  }) {
    return AudioQualitySettings(
      wifiQuality: wifiQuality ?? this.wifiQuality,
      mobileQuality: mobileQuality ?? this.mobileQuality,
      autoSwitch: autoSwitch ?? this.autoSwitch,
    );
  }

  Map<String, dynamic> toJson() => {
    'wifiQuality': wifiQuality.name,
    'mobileQuality': mobileQuality.name,
    'autoSwitch': autoSwitch,
  };

  factory AudioQualitySettings.fromJson(Map<String, dynamic> json) {
    return AudioQualitySettings(
      wifiQuality: AudioQualityLevelExt.fromString(
        json['wifiQuality'] as String? ?? 'original',
      ),
      mobileQuality: AudioQualityLevelExt.fromString(
        json['mobileQuality'] as String? ?? 'standard',
      ),
      autoSwitch: json['autoSwitch'] as bool? ?? true,
    );
  }

  String toJsonString() => jsonEncode(toJson());

  factory AudioQualitySettings.fromJsonString(String jsonStr) {
    return AudioQualitySettings.fromJson(
      jsonDecode(jsonStr) as Map<String, dynamic>,
    );
  }
}
