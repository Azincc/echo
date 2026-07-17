import 'package:audio_service/audio_service.dart';
import 'package:echoes/core/services/audio_handler_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('media session advertises seek support for notification progress', () {
    expect(echoPlaybackSystemActions, contains(MediaAction.seek));
  });
}
