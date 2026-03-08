import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:echoes/core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio_media_kit/just_audio_media_kit.dart';
import 'app.dart';

void main() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      if (Platform.isLinux || Platform.isWindows) {
        JustAudioMediaKit.ensureInitialized();
      }

      FlutterError.onError = (details) {
        Logger.errorWithTag(
          'APP',
          'Flutter framework error',
          details.exception,
          details.stack,
        );
        FlutterError.presentError(details);
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        Logger.errorWithTag('APP', 'Uncaught platform error', error, stack);
        return true;
      };

      runApp(const ProviderScope(child: App()));
    },
    (error, stackTrace) {
      Logger.errorWithTag('APP', 'Uncaught zone error', error, stackTrace);
    },
  );
}
