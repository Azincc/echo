import 'package:echoes/providers/player/player_seek_policy.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('just_audio retains an idle source seek for the next play', () async {
    final player = AudioPlayer();
    addTearDown(player.dispose);

    await player.setAudioSource(
      AudioSource.uri(Uri.parse('https://example.invalid/song.mp3')),
      preload: false,
    );
    await player.seek(const Duration(minutes: 3));
    await player.stop();
    await player.seek(const Duration(seconds: 45));

    expect(player.processingState, ProcessingState.idle);
    expect(player.position, const Duration(seconds: 45));
  });

  group('canSeekLoadedPlayerSource', () {
    test('allows a retained current source to seek while stopped', () {
      expect(
        canSeekLoadedPlayerSource(
          processingState: ProcessingState.idle,
          loadedSourceSongId: 'song-1',
          currentSongId: 'song-1',
        ),
        isTrue,
      );
    });

    test('allows buffering, ready and completed sources', () {
      for (final processingState in <ProcessingState>[
        ProcessingState.buffering,
        ProcessingState.ready,
        ProcessingState.completed,
      ]) {
        expect(
          canSeekLoadedPlayerSource(
            processingState: processingState,
            loadedSourceSongId: 'song-1',
            currentSongId: 'song-1',
          ),
          isTrue,
        );
      }
    });

    test('queues while loading', () {
      expect(
        canSeekLoadedPlayerSource(
          processingState: ProcessingState.loading,
          loadedSourceSongId: 'song-1',
          currentSongId: 'song-1',
        ),
        isFalse,
      );
    });

    test('rejects a missing or stale retained source', () {
      expect(
        canSeekLoadedPlayerSource(
          processingState: ProcessingState.idle,
          loadedSourceSongId: 'old-song',
          currentSongId: 'new-song',
        ),
        isFalse,
      );
      expect(
        canSeekLoadedPlayerSource(
          processingState: ProcessingState.idle,
          loadedSourceSongId: null,
          currentSongId: 'song-1',
        ),
        isFalse,
      );
      expect(
        canSeekLoadedPlayerSource(
          processingState: ProcessingState.idle,
          loadedSourceSongId: 'song-1',
          currentSongId: null,
        ),
        isFalse,
      );
    });
  });

  group('shouldPreservePendingSeekPosition', () {
    test('protects only the current song pending target', () {
      expect(
        shouldPreservePendingSeekPosition(
          pendingPosition: const Duration(seconds: 90),
          pendingSongId: 'song-1',
          currentSongId: 'song-1',
        ),
        isTrue,
      );
      expect(
        shouldPreservePendingSeekPosition(
          pendingPosition: Duration.zero,
          pendingSongId: 'song-1',
          currentSongId: 'song-1',
        ),
        isTrue,
      );
      expect(
        shouldPreservePendingSeekPosition(
          pendingPosition: const Duration(seconds: 90),
          pendingSongId: 'song-1',
          currentSongId: 'song-2',
        ),
        isFalse,
      );
      expect(
        shouldPreservePendingSeekPosition(
          pendingPosition: null,
          pendingSongId: 'song-1',
          currentSongId: 'song-1',
        ),
        isFalse,
      );
      expect(
        shouldPreservePendingSeekPosition(
          pendingPosition: const Duration(seconds: 90),
          pendingSongId: null,
          currentSongId: 'song-1',
        ),
        isFalse,
      );
      expect(
        shouldPreservePendingSeekPosition(
          pendingPosition: const Duration(seconds: 90),
          pendingSongId: 'song-1',
          currentSongId: null,
        ),
        isFalse,
      );
    });
  });
}
