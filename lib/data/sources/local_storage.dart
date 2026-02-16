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
      Logger.debugWithTag(_logTag, 'audio quality settings not found, use default');
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
}
