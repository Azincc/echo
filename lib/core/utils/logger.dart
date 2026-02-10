import 'package:flutter/foundation.dart';

/// 简单的日志工具
class Logger {
  static void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      print('[DEBUG] $message');
      if (error != null) {
        print('[DEBUG] Error: $error');
      }
      if (stackTrace != null) {
        print('[DEBUG] StackTrace: $stackTrace');
      }
    }
  }

  static void info(String message) {
    if (kDebugMode) {
      print('[INFO] $message');
    }
  }

  static void warn(String message, [dynamic error]) {
    if (kDebugMode) {
      print('[WARN] $message');
      if (error != null) {
        print('[WARN] Error: $error');
      }
    }
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      print('[ERROR] $message');
      if (error != null) {
        print('[ERROR] Error: $error');
      }
      if (stackTrace != null) {
        print('[ERROR] StackTrace: $stackTrace');
      }
    }
  }
}
