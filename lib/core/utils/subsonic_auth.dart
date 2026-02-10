import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

/// Subsonic 认证工具类
class SubsonicAuth {
  /// 生成随机 salt（用于 Token/Salt 认证）
  static String generateSalt() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(256));
    return base64Url.encode(values).substring(0, 16);
  }

  /// 生成 Token（MD5(password + salt)）
  static String generateToken(String password, String salt) {
    final bytes = utf8.encode(password + salt);
    final digest = md5.convert(bytes);
    return digest.toString();
  }

  /// 生成 Token/Salt 认证参数
  static Map<String, String> generateTokenAuthParams({
    required String username,
    required String password,
    required String version,
    required String clientName,
    required String format,
  }) {
    final salt = generateSalt();
    final token = generateToken(password, salt);

    return {
      'u': username,
      't': token,
      's': salt,
      'v': version,
      'c': clientName,
      'f': format,
    };
  }

  /// 生成 API Key 认证参数
  static Map<String, String> generateApiKeyAuthParams({
    required String apiKey,
    required String version,
    required String clientName,
    required String format,
  }) {
    return {
      'apiKey': apiKey,
      'v': version,
      'c': clientName,
      'f': format,
    };
  }
}
