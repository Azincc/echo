import 'package:flutter/foundation.dart';

enum _LogLevel { debug, info, warn, error }

/// 简单日志工具：统一输出格式，支持模块 tag 与异常上下文。
class Logger {
  static void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    _log(_LogLevel.debug, message, error: error, stackTrace: stackTrace);
  }

  static void debugWithTag(
    String tag,
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    _log(
      _LogLevel.debug,
      message,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void info(String message) {
    _log(_LogLevel.info, message);
  }

  static void infoWithTag(String tag, String message) {
    _log(_LogLevel.info, message, tag: tag);
  }

  static void warn(String message, [dynamic error]) {
    _log(_LogLevel.warn, message, error: error);
  }

  static void warnWithTag(String tag, String message, [dynamic error]) {
    _log(_LogLevel.warn, message, tag: tag, error: error);
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _log(_LogLevel.error, message, error: error, stackTrace: stackTrace);
  }

  static void errorWithTag(
    String tag,
    String message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    _log(
      _LogLevel.error,
      message,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void _log(
    _LogLevel level,
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    if (!_shouldLog(level)) return;

    final now = DateTime.now().toIso8601String();
    final levelText = level.name.toUpperCase();
    final tagText = (tag == null || tag.isEmpty) ? '' : '[$tag]';
    debugPrint('[$now][$levelText]$tagText $message');

    if (error != null) {
      debugPrint('[$now][$levelText]$tagText error=$error');
    }
    if (stackTrace != null) {
      debugPrint('[$now][$levelText]$tagText stackTrace=$stackTrace');
    }
  }

  static bool _shouldLog(_LogLevel level) {
    // release 默认只保留 warn/error，避免噪声与性能开销。
    if (kReleaseMode) {
      return level == _LogLevel.warn || level == _LogLevel.error;
    }
    return true;
  }
}
