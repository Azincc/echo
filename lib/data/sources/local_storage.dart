import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/logger.dart';
import '../models/server_config.dart';
import '../models/audio_quality.dart';

/// 本地存储封装（SharedPreferences）
class LocalStorage {
  static const String _logTag = 'LOCAL_STORAGE';
  static const String _keyServerConfig = 'server_config';
  static const String _keyAutoFallback = 'auto_fallback';
  static const String _keyAudioQualitySettings = 'audio_quality_settings';
  static const String _keyPlaybackMode = 'playback_mode';
  static const String _keyThemeMode = 'theme_mode';
  static const String _keyThemeSeedColor = 'theme_seed_color';
  static const String _keyMobileCacheSavedBytesByLibrary =
      'mobile_cache_saved_bytes_by_library_v1';
  static const String _keyMaxCacheSizeBytes = 'max_cache_size_bytes';
  static const String _keyHasLaunchedBefore = 'has_launched_before';

  /// 是否曾经启动过（用于判断是否显示开屏动画）
  static Future<bool> hasLaunchedBefore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyHasLaunchedBefore) ?? false;
  }

  /// 标记已完成首次启动
  static Future<void> setHasLaunchedBefore() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyHasLaunchedBefore, true);
    Logger.infoWithTag(_logTag, 'hasLaunchedBefore set to true');
  }

  /// 保存服务器配置
  static Future<void> saveServerConfig(ServerConfig config) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(config.toJson());
    await prefs.setString(_keyServerConfig, json);
    Logger.infoWithTag(_logTag, 'server config saved');
  }

  /// 读取服务器配置
  static Future<ServerConfig?> getServerConfig() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_keyServerConfig);
    if (json == null) {
      Logger.debugWithTag(_logTag, 'server config not found');
      return null;
    }

    try {
      final map = jsonDecode(json) as Map<String, dynamic>;
      Logger.debugWithTag(_logTag, 'server config loaded');
      return ServerConfig.fromJson(map);
    } catch (e) {
      Logger.warnWithTag(_logTag, 'failed to parse server config', e);
      return null;
    }
  }

  /// 删除服务器配置（登出）
  static Future<void> clearServerConfig() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyServerConfig);
    Logger.infoWithTag(_logTag, 'server config cleared');
  }

  /// 检查是否有已保存的配置
  static Future<bool> hasServerConfig() async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.containsKey(_keyServerConfig);
    Logger.debugWithTag(_logTag, 'hasServerConfig=$result');
    return result;
  }

  /// 读取自动回退开关（默认开启）
  static Future<bool> getAutoFallback() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool(_keyAutoFallback) ?? true;
    Logger.debugWithTag(_logTag, 'autoFallback=$value');
    return value;
  }

  /// 保存自动回退开关
  static Future<void> setAutoFallback(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyAutoFallback, value);
    Logger.infoWithTag(_logTag, 'autoFallback updated: $value');
  }

  /// 读取音质设置
  static Future<AudioQualitySettings> getAudioQualitySettings() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_keyAudioQualitySettings);
    if (json == null) {
      Logger.debugWithTag(
        _logTag,
        'audio quality settings not found, use default',
      );
      return const AudioQualitySettings();
    }

    try {
      Logger.debugWithTag(_logTag, 'audio quality settings loaded');
      return AudioQualitySettings.fromJsonString(json);
    } catch (e) {
      Logger.warnWithTag(_logTag, 'failed to parse audio quality settings', e);
      return const AudioQualitySettings();
    }
  }

  /// 保存音质设置
  static Future<void> setAudioQualitySettings(
    AudioQualitySettings settings,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAudioQualitySettings, settings.toJsonString());
    Logger.infoWithTag(_logTag, 'audio quality settings saved');
  }

  /// 读取播放模式（shuffle / repeatAll / repeatOne）
  static Future<String> getPlaybackMode() async {
    final prefs = await SharedPreferences.getInstance();
    final mode = prefs.getString(_keyPlaybackMode);
    if (mode == null) {
      Logger.debugWithTag(_logTag, 'playback mode not found, use default');
      return 'repeatAll';
    }

    switch (mode) {
      case 'shuffle':
      case 'repeatAll':
      case 'repeatOne':
        Logger.debugWithTag(_logTag, 'playback mode loaded: $mode');
        return mode;
      default:
        Logger.warnWithTag(_logTag, 'invalid playback mode in storage: $mode');
        return 'repeatAll';
    }
  }

  /// 保存播放模式（shuffle / repeatAll / repeatOne）
  static Future<void> setPlaybackMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPlaybackMode, mode);
    Logger.infoWithTag(_logTag, 'playback mode saved: $mode');
  }

  /// 读取主题模式（system / light / dark）
  static Future<String> getThemeModeSetting() async {
    final prefs = await SharedPreferences.getInstance();
    final mode = prefs.getString(_keyThemeMode) ?? 'system';
    switch (mode) {
      case 'light':
      case 'dark':
      case 'system':
        Logger.debugWithTag(_logTag, 'theme mode loaded: $mode');
        return mode;
      default:
        Logger.warnWithTag(_logTag, 'invalid theme mode in storage: $mode');
        return 'system';
    }
  }

  /// 保存主题模式（system / light / dark）
  static Future<void> setThemeModeSetting(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyThemeMode, mode);
    Logger.infoWithTag(_logTag, 'theme mode saved: $mode');
  }

  /// 读取主题主色（ARGB int）
  static Future<int> getThemeSeedColorValue() async {
    final prefs = await SharedPreferences.getInstance();
    final color = prefs.getInt(_keyThemeSeedColor) ?? 0xFF6750A4;
    Logger.debugWithTag(
      _logTag,
      'theme seed color loaded: 0x${color.toRadixString(16)}',
    );
    return color;
  }

  /// 保存主题主色（ARGB int）
  static Future<void> setThemeSeedColorValue(int color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyThemeSeedColor, color);
    Logger.infoWithTag(
      _logTag,
      'theme seed color saved: 0x${color.toRadixString(16)}',
    );
  }

  /// 读取指定音乐库的“移动网络缓存命中节省流量”累计值（字节）
  static Future<int> getMobileCacheSavedBytes({
    required String libraryId,
  }) async {
    if (libraryId.trim().isEmpty) return 0;

    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyMobileCacheSavedBytesByLibrary);
    if (raw == null || raw.isEmpty) return 0;

    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return _parsePositiveInt(map[libraryId]);
    } catch (e) {
      Logger.warnWithTag(
        _logTag,
        'failed to parse mobile cache saved bytes map',
        e,
      );
      return 0;
    }
  }

  /// 增加指定音乐库的“移动网络缓存命中节省流量”累计值（字节）
  static Future<void> addMobileCacheSavedBytes({
    required String libraryId,
    required int bytes,
  }) async {
    final normalizedLibraryId = libraryId.trim();
    if (normalizedLibraryId.isEmpty || bytes <= 0) return;

    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyMobileCacheSavedBytesByLibrary);

    Map<String, dynamic> map = <String, dynamic>{};
    if (raw != null && raw.isNotEmpty) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is Map<String, dynamic>) {
          map = decoded;
        } else if (decoded is Map) {
          map = decoded.map((key, value) => MapEntry(key.toString(), value));
        }
      } catch (e) {
        Logger.warnWithTag(
          _logTag,
          'failed to parse existing mobile cache saved bytes map',
          e,
        );
      }
    }

    final current = _parsePositiveInt(map[normalizedLibraryId]);
    final next = current + bytes;
    map[normalizedLibraryId] = next;
    await prefs.setString(_keyMobileCacheSavedBytesByLibrary, jsonEncode(map));
    Logger.infoWithTag(
      _logTag,
      'mobile cache saved bytes +$bytes library=$normalizedLibraryId total=$next',
    );
  }

  static int _parsePositiveInt(Object? value) {
    if (value is int) return value < 0 ? 0 : value;
    if (value is double) {
      final converted = value.floor();
      return converted < 0 ? 0 : converted;
    }
    if (value is String) {
      final parsed = int.tryParse(value);
      if (parsed == null || parsed < 0) return 0;
      return parsed;
    }
    return 0;
  }

  /// 读取音频缓存上限设置（字节）
  static Future<int?> getMaxCacheSize() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getInt(_keyMaxCacheSizeBytes);
    if (value != null) {
      Logger.debugWithTag(_logTag, 'maxCacheSize loaded: $value');
    }
    return value;
  }

  /// 保存音频缓存上限设置（字节）
  static Future<void> setMaxCacheSize(int bytes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyMaxCacheSizeBytes, bytes);
    Logger.infoWithTag(_logTag, 'maxCacheSize saved: $bytes');
  }
}
