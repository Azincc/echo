import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/server_config.dart';

/// 本地存储封装（SharedPreferences）
class LocalStorage {
  static const String _keyServerConfig = 'server_config';

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
}
