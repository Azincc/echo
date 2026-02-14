import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/server_config.dart';
import '../models/audio_quality.dart';

/// 本地存储封装（SharedPreferences）
class LocalStorage {
  static const String _keyServerConfig = 'server_config';
  static const String _keyAutoFallback = 'auto_fallback';
  static const String _keyAudioQualitySettings = 'audio_quality_settings';

  /// 保存服务器配置
  static Future<void> saveServerConfig(ServerConfig config) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(config.toJson());
    await prefs.setString(_keyServerConfig, json);
  }

  /// 读取服务器配置
  static Future<ServerConfig?> getServerConfig() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_keyServerConfig);
    if (json == null) return null;

    try {
      final map = jsonDecode(json) as Map<String, dynamic>;
      return ServerConfig.fromJson(map);
    } catch (e) {
      return null;
    }
  }

  /// 删除服务器配置（登出）
  static Future<void> clearServerConfig() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyServerConfig);
  }

  /// 检查是否有已保存的配置
  static Future<bool> hasServerConfig() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_keyServerConfig);
  }

  /// 读取自动回退开关（默认开启）
  static Future<bool> getAutoFallback() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyAutoFallback) ?? true;
  }

  /// 保存自动回退开关
  static Future<void> setAutoFallback(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyAutoFallback, value);
  }

  /// 读取音质设置
  static Future<AudioQualitySettings> getAudioQualitySettings() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_keyAudioQualitySettings);
    if (json == null) return const AudioQualitySettings();

    try {
      return AudioQualitySettings.fromJsonString(json);
    } catch (e) {
      return const AudioQualitySettings();
    }
  }

  /// 保存音质设置
  static Future<void> setAudioQualitySettings(
    AudioQualitySettings settings,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAudioQualitySettings, settings.toJsonString());
  }
}
