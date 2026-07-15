import 'package:flutter/material.dart';

import '../design/components/echo_message.dart';
import 'logger.dart';

final rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class ToastNotifier {
  static const _tag = 'TOAST';
  static String? _pendingMessage;
  static EchoMessageKind _pendingKind = EchoMessageKind.info;

  static void show(
    String message, {
    EchoMessageKind kind = EchoMessageKind.info,
  }) {
    final messenger = rootScaffoldMessengerKey.currentState;
    if (messenger == null) {
      _pendingMessage = message;
      _pendingKind = kind;
      return;
    }
    showEchoMessage(
      messenger.context,
      message,
      kind: kind,
      messenger: messenger,
    );
  }

  static void flush() {
    final message = _pendingMessage;
    if (message == null) return;
    final messenger = rootScaffoldMessengerKey.currentState;
    if (messenger == null) {
      Logger.warnWithTag(_tag, 'Echo message host is not ready');
      return;
    }
    final kind = _pendingKind;
    _pendingMessage = null;
    _pendingKind = EchoMessageKind.info;
    showEchoMessage(
      messenger.context,
      message,
      kind: kind,
      messenger: messenger,
    );
  }
}
