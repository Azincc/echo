import 'package:echoes/data/models/song.dart';
import 'package:echoes/providers/player_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart' hide PlayerState;

/// Lightweight StateNotifier that satisfies playerProvider's concrete type
/// without constructing AudioService or AudioPlayer in widget tests.
class TestPlayerNotifier extends StateNotifier<PlayerState>
    implements PlayerNotifier {
  TestPlayerNotifier(super.state);

  int toggleCount = 0;
  int previousCount = 0;
  int nextCount = 0;
  int clearCount = 0;
  final List<Duration> seekTargets = <Duration>[];
  final List<int> skippedIndices = <int>[];
  final List<int> removedIndices = <int>[];

  void emit(PlayerState value) => state = value;

  @override
  Future<void> togglePlayPause() async {
    toggleCount += 1;
    state = state.copyWith(isPlaying: !state.isPlaying);
  }

  @override
  Future<void> previous() async {
    previousCount += 1;
  }

  @override
  Future<void> next() async {
    nextCount += 1;
  }

  @override
  Future<void> seek(Duration position) async {
    seekTargets.add(position);
    state = state.copyWith(position: position);
  }

  @override
  Future<void> cyclePlaybackMode() async {
    if (state.shuffleEnabled) {
      state = state.copyWith(shuffleEnabled: false, loopMode: LoopMode.all);
    } else if (state.loopMode == LoopMode.one) {
      state = state.copyWith(shuffleEnabled: true, loopMode: LoopMode.off);
    } else {
      state = state.copyWith(shuffleEnabled: false, loopMode: LoopMode.one);
    }
  }

  @override
  Future<void> toggleFavorite() async {
    final song = state.currentSong;
    if (song == null) return;
    final updated = song.copyWith(starred: !song.starred);
    final queue = <Song>[
      for (final item in state.queue) item.id == song.id ? updated : item,
    ];
    state = state.copyWith(currentSong: updated, queue: queue);
  }

  @override
  Future<bool?> toggleSongFavorite(Song song) async {
    final updated = song.copyWith(starred: !song.starred);
    final queue = <Song>[
      for (final item in state.queue) item.id == song.id ? updated : item,
    ];
    state = state.copyWith(
      currentSong: state.currentSong?.id == song.id ? updated : null,
      queue: queue,
    );
    return updated.starred;
  }

  @override
  Future<void> playNext(Song song) async {
    final queue = <Song>[...state.queue];
    final insertIndex = (state.currentIndex + 1).clamp(0, queue.length);
    queue.insert(insertIndex, song);
    state = state.copyWith(queue: queue);
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    skippedIndices.add(index);
    if (index < 0 || index >= state.queue.length) return;
    state = state.copyWith(
      currentSong: state.queue[index],
      currentIndex: index,
    );
  }

  @override
  Future<void> clearQueue() async {
    clearCount += 1;
    final current = state.currentSong;
    state = current == null
        ? PlayerState()
        : state.copyWith(queue: <Song>[current], currentIndex: 0);
  }

  @override
  void removeFromQueue(int index) {
    removedIndices.add(index);
    if (index < 0 || index >= state.queue.length) return;
    final queue = <Song>[...state.queue]..removeAt(index);
    if (index == state.currentIndex) {
      state = PlayerState(queue: queue);
      return;
    }
    state = state.copyWith(
      queue: queue,
      currentIndex: index < state.currentIndex
          ? state.currentIndex - 1
          : state.currentIndex,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}
