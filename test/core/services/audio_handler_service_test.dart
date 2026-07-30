import 'package:audio_service/audio_service.dart';
import 'package:echoes/core/services/audio_handler_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mocktail/mocktail.dart';

class _MockAudioPlayer extends Mock implements AudioPlayer {}

void main() {
  late _MockAudioPlayer player;
  late EchoAudioHandler handler;

  setUp(() {
    player = _MockAudioPlayer();
    when(() => player.playingStream).thenAnswer((_) => const Stream.empty());
    when(() => player.positionStream).thenAnswer((_) => const Stream.empty());
    when(
      () => player.processingStateStream,
    ).thenAnswer((_) => const Stream.empty());
    when(() => player.playing).thenReturn(true);
    when(() => player.processingState).thenReturn(ProcessingState.ready);
    when(() => player.position).thenReturn(const Duration(seconds: 2));
    when(() => player.bufferedPosition).thenReturn(const Duration(seconds: 3));
    when(() => player.speed).thenReturn(1.0);
    handler = EchoAudioHandler(player);
  });

  test('media session advertises seek support for notification progress', () {
    expect(echoPlaybackSystemActions, contains(MediaAction.seek));
  });

  test(
    'delegates media-session seeks to the player notifier callback',
    () async {
      Duration? received;
      handler.onSeek = (position) async {
        received = position;
      };

      await handler.seek(const Duration(seconds: 45));

      expect(received, const Duration(seconds: 45));
      verifyNever(() => player.seek(any()));
    },
  );

  test('adds the server timeOffset to media-session progress', () {
    handler.setPositionOffset(const Duration(seconds: 45));

    expect(
      handler.playbackState.value.updatePosition,
      const Duration(seconds: 47),
    );
    expect(
      handler.playbackState.value.bufferedPosition,
      const Duration(seconds: 48),
    );
  });
}
