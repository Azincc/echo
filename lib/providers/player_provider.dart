import 'package:audio_service/audio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import '../data/models/song.dart';
import '../data/sources/subsonic_api_client.dart';
import '../data/repositories/music_repository.dart';
import '../core/constants/api_constants.dart';
import '../core/utils/logger.dart';
import '../core/services/audio_handler_service.dart';
import 'auth_provider.dart';
import 'music_provider.dart';

/// 播放器状态
class PlayerState {
  final Song? currentSong;
  final List<Song> queue;
  final int currentIndex;
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final LoopMode loopMode;
  final bool shuffleEnabled;

  PlayerState({
    this.currentSong,
    this.queue = const [],
    this.currentIndex = 0,
    this.isPlaying = false,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.loopMode = LoopMode.off,
    this.shuffleEnabled = false,
  });

  PlayerState copyWith({
    Song? currentSong,
    List<Song>? queue,
    int? currentIndex,
    bool? isPlaying,
    Duration? position,
    Duration? duration,
    LoopMode? loopMode,
    bool? shuffleEnabled,
  }) {
    return PlayerState(
      currentSong: currentSong ?? this.currentSong,
      queue: queue ?? this.queue,
      currentIndex: currentIndex ?? this.currentIndex,
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      loopMode: loopMode ?? this.loopMode,
      shuffleEnabled: shuffleEnabled ?? this.shuffleEnabled,
    );
  }

  bool get hasNext => currentIndex < queue.length - 1;
  bool get hasPrevious => currentIndex > 0;
}

/// 播放器 Provider
final playerProvider = StateNotifierProvider<PlayerNotifier, PlayerState>((
  ref,
) {
  final apiClient = ref.watch(apiClientProvider);
  final musicRepository = ref.watch(musicRepositoryProvider);
  return PlayerNotifier(apiClient, musicRepository, ref);
});

/// 播放器状态管理器
class PlayerNotifier extends StateNotifier<PlayerState> {
  final SubsonicApiClient _apiClient;
  final MusicRepository _musicRepository;
  final Ref _ref;
  late final AudioPlayer _audioPlayer;
  EchoAudioHandler? _audioHandler;

  PlayerNotifier(this._apiClient, this._musicRepository, this._ref)
    : super(PlayerState()) {
    _init();
  }

  /// 初始化播放器
  void _init() async {
    // 初始化 AudioService（仅在移动平台）
    try {
      _audioHandler = await initAudioService();
      _audioPlayer = _audioHandler!.audioPlayer;
      Logger.info('AudioService initialized');

      // 设置通知栏按钮回调
      _audioHandler?.onSkipToNext = () {
        next();
      };
      _audioHandler?.onSkipToPrevious = () {
        previous();
      };
    } catch (e) {
      Logger.warn('AudioService not available (web platform): $e');
      _audioPlayer = AudioPlayer();
    }

    // 监听播放状态
    _audioPlayer.playingStream.listen((isPlaying) {
      state = state.copyWith(isPlaying: isPlaying);
    });

    // 监听播放进度
    _audioPlayer.positionStream.listen((position) {
      state = state.copyWith(position: position);
    });

    // 监听总时长
    _audioPlayer.durationStream.listen((duration) {
      if (duration != null && duration > Duration.zero) {
        // 如果流能提供时长，优先使用流的时长（更准确）
        state = state.copyWith(duration: duration);
      }
      // 如果 duration 为 null 或 0，保持使用歌曲元数据的时长
    });

    // 监听播放完成
    _audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        _onSongCompleted();
      }
    });

    // 监听循环模式
    _audioPlayer.loopModeStream.listen((loopMode) {
      state = state.copyWith(loopMode: loopMode);
    });

    // 监听随机模式
    _audioPlayer.shuffleModeEnabledStream.listen((enabled) {
      state = state.copyWith(shuffleEnabled: enabled);
    });
  }

  /// 播放单曲
  Future<void> playSong(Song song, {List<Song>? queue, int? index}) async {
    try {
      final playQueue = queue ?? [song];
      final playIndex = index ?? 0;

      // 如果歌曲有时长信息，先预设 duration（转码流可能无法获取时长）
      final initialDuration = song.duration != null
          ? Duration(seconds: song.duration!)
          : Duration.zero;

      state = state.copyWith(
        currentSong: song,
        queue: playQueue,
        currentIndex: playIndex,
        duration: initialDuration,  // 使用歌曲元数据的时长
      );

      // 更新通知栏媒体信息
      _updateMediaItem(song);

      // 优先使用原始格式流式播放，只对确定不支持的格式转码
      final String? transcodeFormat = _needsTranscoding(song.suffix);
      final streamUrl = _apiClient.getStreamUrl(
        song.id,
        format: transcodeFormat,
        maxBitRate: transcodeFormat != null ? 320 : null, // 转码时限制最大比特率
      );

      if (transcodeFormat != null) {
        Logger.info('Transcoding ${song.suffix} to $transcodeFormat for: ${song.title}');
      } else {
        Logger.info('Playing original format (${song.suffix}): ${song.title}');
      }

      await _audioPlayer.setUrl(streamUrl);
      await _audioPlayer.play();

      // 上报"正在播放"
      await _scrobble(song.id, submission: false);

      Logger.info('Playing: ${song.title}');
    } catch (e) {
      Logger.error('Failed to play song', e);

      // 如果播放失败且没有转码过，尝试转码播放
      if (_needsTranscoding(song.suffix) == null) {
        Logger.info('Original format failed, retrying with MP3 transcoding');
        await _playWithTranscoding(song, queue: queue, index: index);
      }
    }
  }

  /// 使用转码方式播放（降级方案）
  Future<void> _playWithTranscoding(Song song, {List<Song>? queue, int? index}) async {
    try {
      final streamUrl = _apiClient.getStreamUrl(
        song.id,
        format: 'mp3',  // 转码为 MP3
        maxBitRate: 320,
      );

      Logger.info('Retrying with MP3 transcoding: ${song.title}');
      await _audioPlayer.setUrl(streamUrl);
      await _audioPlayer.play();

      // 上报"正在播放"
      await _scrobble(song.id, submission: false);
    } catch (e) {
      Logger.error('Failed to play song even with transcoding', e);
      // 可以在这里添加用户提示
    }
  }

  /// 判断格式是否需要强制转码
  /// 返回 null 表示直接使用原始格式，返回格式字符串表示需要转码
  String? _needsTranscoding(String? suffix) {
    if (suffix == null) return null;

    final lowerSuffix = suffix.toLowerCase();

    // 只对完全确定不支持的格式进行转码
    // ExoPlayer/just_audio 在大多数平台上不支持的格式
    const unsupportedFormats = [
      'ape',     // Monkey's Audio - Android/iOS 不支持
      'wv',      // WavPack - 部分平台不支持
      'tta',     // True Audio - 不支持
      'dff',     // DSD - 不支持
      'dsf',     // DSD - 不支持
      'tak',     // TAK - 不支持
      'm4a',     // 可能包含 ALAC 编码，Android 支持不完整，转码更稳定
      'alac',    // Apple Lossless - Android 支持不完整
    ];

    if (unsupportedFormats.contains(lowerSuffix)) {
      return 'mp3';  // 转码为通用的 MP3 格式
    }

    // 其他格式优先尝试原始格式播放
    // 支持的格式包括：mp3, aac, flac, ogg, opus, wav 等
    return null;
  }

  /// 更新通知栏媒体信息
  void _updateMediaItem(Song song) {
    if (_audioHandler == null) return;

    final coverArtUrl = song.coverArt != null
        ? _apiClient.getCoverArtUrl(song.coverArt!, size: 300)
        : null;

    final mediaItem = MediaItem(
      id: song.id,
      title: song.title,
      artist: song.artist ?? 'Unknown Artist',
      album: song.album ?? 'Unknown Album',
      duration: song.duration != null
          ? Duration(seconds: song.duration!)
          : null,
      artUri: coverArtUrl != null ? Uri.parse(coverArtUrl) : null,
    );

    _audioHandler?.updateMediaItem(mediaItem);
  }

  /// 播放队列
  Future<void> playQueue(List<Song> songs, {int startIndex = 0}) async {
    if (songs.isEmpty) return;
    await playSong(songs[startIndex], queue: songs, index: startIndex);
  }

  /// 播放/暂停
  Future<void> togglePlayPause() async {
    if (state.isPlaying) {
      await _audioPlayer.pause();
      await _audioHandler?.pause();
    } else {
      await _audioPlayer.play();
      await _audioHandler?.play();
    }
  }

  /// 暂停
  Future<void> pause() async {
    await _audioPlayer.pause();
    await _audioHandler?.pause();
  }

  /// 播放
  Future<void> play() async {
    await _audioPlayer.play();
    await _audioHandler?.play();
  }

  /// 上一首
  Future<void> previous() async {
    if (!state.hasPrevious) return;

    final previousIndex = state.currentIndex - 1;
    final previousSong = state.queue[previousIndex];

    await playSong(previousSong, queue: state.queue, index: previousIndex);
  }

  /// 下一首
  Future<void> next() async {
    if (!state.hasNext) return;

    final nextIndex = state.currentIndex + 1;
    final nextSong = state.queue[nextIndex];

    await playSong(nextSong, queue: state.queue, index: nextIndex);
  }

  /// 跳转到指定位置
  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
    await _audioHandler?.seek(position);
  }

  /// 跳转到队列中的指定歌曲
  Future<void> skipToQueueItem(int index) async {
    if (index < 0 || index >= state.queue.length) return;

    final song = state.queue[index];
    await playSong(song, queue: state.queue, index: index);
  }

  /// 设置循环模式
  Future<void> setLoopMode(LoopMode mode) async {
    await _audioPlayer.setLoopMode(mode);
  }

  /// 切换循环模式
  Future<void> toggleLoopMode() async {
    final nextMode = switch (state.loopMode) {
      LoopMode.off => LoopMode.all,
      LoopMode.all => LoopMode.one,
      LoopMode.one => LoopMode.off,
    };
    await setLoopMode(nextMode);
  }

  /// 设置随机播放
  Future<void> setShuffleEnabled(bool enabled) async {
    await _audioPlayer.setShuffleModeEnabled(enabled);
  }

  /// 切换随机播放
  Future<void> toggleShuffle() async {
    await setShuffleEnabled(!state.shuffleEnabled);
  }

  /// 添加到队列末尾
  void addToQueue(Song song) {
    final newQueue = [...state.queue, song];
    state = state.copyWith(queue: newQueue);
  }

  /// 添加多首到队列
  void addAllToQueue(List<Song> songs) {
    final newQueue = [...state.queue, ...songs];
    state = state.copyWith(queue: newQueue);
  }

  /// 清空队列
  Future<void> clearQueue() async {
    await _audioPlayer.stop();
    await _audioHandler?.stop();
    state = PlayerState();
  }

  /// 从队列移除
  void removeFromQueue(int index) {
    if (index < 0 || index >= state.queue.length) return;

    final newQueue = [...state.queue];
    newQueue.removeAt(index);

    // 如果移除的是当前播放的歌曲
    if (index == state.currentIndex) {
      // 停止播放
      _audioPlayer.stop();
      _audioHandler?.stop();
      state = state.copyWith(
        queue: newQueue,
        currentSong: null,
        currentIndex: 0,
      );
    } else {
      // 调整当前索引
      final newIndex = index < state.currentIndex
          ? state.currentIndex - 1
          : state.currentIndex;
      state = state.copyWith(queue: newQueue, currentIndex: newIndex);
    }
  }

  /// 歌曲播放完成
  void _onSongCompleted() async {
    final currentSong = state.currentSong;
    if (currentSong != null) {
      // 上报"已播放"
      await _scrobble(currentSong.id, submission: true);
    }

    // 根据循环模式决定下一步
    if (state.loopMode == LoopMode.one) {
      // 单曲循环
      await _audioPlayer.seek(Duration.zero);
      await _audioPlayer.play();
    } else if (state.hasNext) {
      // 播放下一首
      await next();
    } else if (state.loopMode == LoopMode.all) {
      // 列表循环，回到第一首
      await skipToQueueItem(0);
    }
  }

  /// 上报播放记录（Scrobble）
  Future<void> _scrobble(String songId, {required bool submission}) async {
    try {
      await _apiClient.post(
        ApiConstants.scrobble,
        queryParameters: {
          'id': songId,
          'time': DateTime.now().millisecondsSinceEpoch.toString(),
          'submission': submission.toString(),
        },
      );
      Logger.info('Scrobble: $songId (submission: $submission)');
    } catch (e) {
      Logger.warn('Failed to scrobble', e);
    }
  }

  /// 切换当前歌曲的收藏状态
  Future<void> toggleFavorite() async {
    final currentSong = state.currentSong;
    if (currentSong == null) return;

    try {
      final newStarred = !currentSong.starred;
      await _musicRepository.setSongStarred(currentSong.id, newStarred);

      // 更新当前歌曲的 starred 状态
      final updatedSong = Song(
        id: currentSong.id,
        title: currentSong.title,
        artist: currentSong.artist,
        album: currentSong.album,
        coverArt: currentSong.coverArt,
        duration: currentSong.duration,
        starred: newStarred,
        artistId: currentSong.artistId,
        albumId: currentSong.albumId,
      );

      // 更新队列中的歌曲
      final updatedQueue = state.queue.map((song) {
        if (song.id == currentSong.id) {
          return updatedSong;
        }
        return song;
      }).toList();

      state = state.copyWith(currentSong: updatedSong, queue: updatedQueue);

      // 刷新相关数据
      _ref.invalidate(starredProvider);

      Logger.info('Toggled favorite for ${currentSong.title}: $newStarred');
    } catch (e) {
      Logger.error('Failed to toggle favorite', e);
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _audioHandler?.dispose();
    super.dispose();
  }
}
