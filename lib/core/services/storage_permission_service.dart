import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform;
import 'package:permission_handler/permission_handler.dart';
import '../utils/logger.dart';

/// 存储权限服务 — 封装 Android 不同版本的权限请求
class StoragePermissionService {
  static const _logTag = 'STORAGE_PERM';

  /// 确保存储权限已授予（用于下载到公共 Music 目录）
  /// 返回 true 表示已授权，false 表示用户拒绝
  static Future<bool> ensureStoragePermission() async {
    // iOS / Web 不需要额外存储权限
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return true;

    // Android 13+ (API 33): 使用 READ_MEDIA_AUDIO
    // Android < 13: 使用 WRITE_EXTERNAL_STORAGE
    final sdkInt = await _getAndroidSdkVersion();
    Logger.infoWithTag(_logTag, 'checking permission sdkInt=$sdkInt');

    if (sdkInt >= 33) {
      // Android 13+: 请求 audio 权限
      final status = await Permission.audio.status;
      if (status.isGranted) return true;

      final result = await Permission.audio.request();
      Logger.infoWithTag(_logTag, 'audio permission result=$result');
      return result.isGranted;
    } else if (sdkInt >= 30) {
      // Android 11-12: Scoped storage，使用 MediaStore 写入 Music 目录无需特殊权限
      // 但使用 File API 需要 MANAGE_EXTERNAL_STORAGE 或依赖 requestLegacyExternalStorage
      // 我们用 getExternalStorageDirectory 作为 fallback
      final status = await Permission.storage.status;
      if (status.isGranted) return true;

      final result = await Permission.storage.request();
      Logger.infoWithTag(_logTag, 'storage permission result=$result');
      return result.isGranted;
    } else {
      // Android 10 及以下
      final status = await Permission.storage.status;
      if (status.isGranted) return true;

      final result = await Permission.storage.request();
      Logger.infoWithTag(_logTag, 'storage permission result=$result');
      return result.isGranted;
    }
  }

  /// 检查是否已授权（不弹窗）
  static Future<bool> hasStoragePermission() async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return true;

    final sdkInt = await _getAndroidSdkVersion();
    if (sdkInt >= 33) {
      return (await Permission.audio.status).isGranted;
    } else {
      return (await Permission.storage.status).isGranted;
    }
  }

  /// 获取 Android SDK 版本
  static Future<int> _getAndroidSdkVersion() async {
    try {
      final audioStatus = await Permission.audio.status;
      Logger.debugWithTag(_logTag, 'audio permission probe result=$audioStatus');

      if (audioStatus != PermissionStatus.permanentlyDenied) {
        return 33;
      }
      return 30;
    } catch (e) {
      Logger.warnWithTag(_logTag, 'failed to detect SDK version', e);
      return 30; // 保守默认值
    }
  }
}
