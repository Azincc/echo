import 'package:just_audio/just_audio.dart';

/// Whether the currently retained just_audio source can accept a seek now.
///
/// `AudioPlayer.stop()` moves the player to [ProcessingState.idle] while
/// retaining its audio source and position. Seeking that retained source is
/// supported and updates the position used by the next play call.
bool canSeekLoadedPlayerSource({
  required ProcessingState processingState,
  required String? loadedSourceSongId,
  required String? currentSongId,
}) {
  if (loadedSourceSongId == null || loadedSourceSongId != currentSongId) {
    return false;
  }

  // just_audio 0.9.x accepts seek in idle, buffering, ready and completed.
  // Only loading ignores seek requests, so defer that state until the source
  // reports ready.
  return processingState != ProcessingState.loading;
}

/// Whether UI position updates should stay anchored to a queued seek target.
bool shouldPreservePendingSeekPosition({
  required Duration? pendingPosition,
  required String? pendingSongId,
  required String? currentSongId,
}) {
  return pendingPosition != null &&
      currentSongId != null &&
      pendingSongId == currentSongId;
}
