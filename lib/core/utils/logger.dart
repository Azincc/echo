import 'dart:collection';
import 'package:flutter/foundation.dart';

enum _LogLevel { debug, info, warn, error }

/// 简单日志工具：统一输出格式，支持模块 tag 与异常上下文。
/// 新增内存环形缓冲区，支持导出最近日志。
class Logger {
  /// Maximum number of log lines kept in memory.
  static const int _maxBufferSize = 5000;

  /// Ring buffer storing the most recent log lines.
  static final _buffer = ListQueue<String>(_maxBufferSize);

  // ---------------------------------------------------------------------------
  // Public API
  // ---------------------------------------------------------------------------

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

  // ---------------------------------------------------------------------------
  // Log export
  // ---------------------------------------------------------------------------

  /// Returns all buffered log lines as a single string.
  static String exportLogs() {
    return _buffer.join('\n');
  }

  /// Returns the number of buffered log lines.
  static int get bufferedLineCount => _buffer.length;

  /// Clears the in-memory log buffer.
  static void clearBuffer() {
    _buffer.clear();
  }

  // ---------------------------------------------------------------------------
  // Internal
  // ---------------------------------------------------------------------------

  static void _log(
    _LogLevel level,
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    // Always buffer (even in release) so that log export captures warn/error.
    final now = DateTime.now().toIso8601String();
    final levelText = level.name.toUpperCase();
    final tagText = (tag == null || tag.isEmpty) ? '' : '[$tag]';

    final mainLine = '[$now][$levelText]$tagText $message';
    _addToBuffer(mainLine);

    final includeErrorDetails = !kReleaseMode;
    final errorText = includeErrorDetails
        ? error?.toString()
        : (error == null ? null : '<redacted:${error.runtimeType}>');
    final stackTraceText = includeErrorDetails
        ? stackTrace?.toString()
        : (stackTrace == null ? null : '<omitted in release>');

    if (errorText != null) {
      final errLine = '[$now][$levelText]$tagText error=$errorText';
      _addToBuffer(errLine);
    }
    if (stackTraceText != null) {
      final stLine = '[$now][$levelText]$tagText stackTrace=$stackTraceText';
      _addToBuffer(stLine);
    }

    // Console output gated by log level.
    if (!_shouldLog(level)) return;
    debugPrint(mainLine);
    if (errorText != null) {
      debugPrint('[$now][$levelText]$tagText error=$errorText');
    }
    if (stackTraceText != null) {
      debugPrint('[$now][$levelText]$tagText stackTrace=$stackTraceText');
    }
  }

  static void _addToBuffer(String line) {
    if (_buffer.length >= _maxBufferSize) {
      _buffer.removeFirst();
    }
    _buffer.addLast(line);
  }

  static bool _shouldLog(_LogLevel level) {
    // release 默认只保留 warn/error，避免噪声与性能开销。
    if (kReleaseMode) {
      return level == _LogLevel.warn || level == _LogLevel.error;
    }
    return true;
  }
}
