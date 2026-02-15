import 'dart:async';
import 'dart:math';
import 'dart:io' show File, Platform;
import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import '../data/models/song.dart';
import '../data/models/audio_quality.dart';
import '../data/models/server_address.dart';
import '../data/sources/subsonic_api_client.dart';
import '../data/repositories/music_repository.dart';
import '../core/constants/api_constants.dart';
import '../core/utils/logger.dart';
import '../core/utils/network_error_notifier.dart';
import '../core/services/audio_handler_service.dart';

import 'music_provider.dart';
import 'api_provider.dart';
import 'audio_quality_provider.dart';
import 'download_provider.dart';
import 'audio_cache_provider.dart';
import '../providers/auth_provider.dart';

/// 播放来源
enum PlaybackSource {
  downloaded, // 已下载的本地文件
  cached, // 缓存的本地文件
  stream, // 在线流式播放
}

/// 播放模式（用于播放器控制区三态切换）
enum PlaybackMode { shuffle, repeatAll, repeatOne }

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
  final AudioQualityLevel? currentQuality;
  final PlaybackSource? playbackSource;

  PlayerState({
    this.currentSong,
    this.queue = const [],
    this.currentIndex = 0,
    this.isPlaying = false,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.loopMode = LoopMode.off,
    this.shuffleEnabled = false,
    this.currentQuality,
    this.playbackSource,
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
    AudioQualityLevel? currentQuality,
    PlaybackSource? playbackSource,
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
      currentQuality: currentQuality ?? this.currentQuality,
      playbackSource: playbackSource ?? this.playbackSource,
    );
  }

  bool get hasNext =>
      shuffleEnabled ? queue.length > 1 : currentIndex < queue.length - 1;
  bool get hasPrevious => shuffleEnabled ? queue.length > 1 : currentIndex > 0;
}

/// 播放器 Provider

// ...
final playerProvider = StateNotifierProvider<PlayerNotifier, PlayerState>((
  ref,
) {
  // 不固定 apiClient/musicRepository 引用，PlayerNotifier 内部通过 ref.read 动态获取
  // 这样既不建立 watch 依赖（不会被重建），又能始终拿到最新的实例
  return PlayerNotifier(ref);
});

/// 播放器状态管理器
class PlayerNotifier extends StateNotifier<PlayerState> {
  final Ref _ref;
  AudioPlayer? _audioPlayer;
  EchoAudioHandler? _audioHandler;
  StreamSubscription? _cacheCompletionSubscription;
  final Random _random = Random();
  Duration? _pendingSeekPosition;
  String? _pendingSeekSongId;
  bool _usingLockCachingSource = false;
  String? _currentStreamUrl;
  String? _currentStreamSongId;
  String? _currentStreamFormat;
  int? _currentStreamMaxBitRate;
  bool _seekByReloadStream = false;
  // 默认关闭：当前服务端对 timeOffset 支持不稳定，首跳可能先失败再回退，导致明显卡顿。
  bool _transcodeTimeOffsetSupported = false;
  ProcessingState? _lastProcessingStateForDebug;

  /// 动态获取最新的 API client
  SubsonicApiClient get _apiClient => _ref.read(subsonicApiClientProvider);

  /// 动态获取最新的 MusicRepository
  MusicRepository get _musicRepository =>
      _ref.read(musicRepositoryProvider) ?? MusicRepository(_apiClient);

  PlayerNotifier(this._ref) : super(PlayerState()) {
    _init();
  }

  /// 初始化播放器
  void _init() async {
    AudioPlayer player;

    // 初始化 AudioService（仅在移动平台）
    try {
      _audioHandler = await initAudioService();
      player = _audioHandler!.audioPlayer;
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
      player = AudioPlayer();
    }

    _audioPlayer = player;

    // 监听播放状态
    player.playingStream.listen((isPlaying) {
      if (mounted) state = state.copyWith(isPlaying: isPlaying);
    });

    // 监听播放进度
    player.positionStream.listen((position) {
      if (mounted) state = state.copyWith(position: position);
    });

    // 监听总时长
    player.durationStream.listen((duration) {
      if (mounted) {
        if (duration != null && duration > Duration.zero) {
          // 如果流能提供时长，优先使用流的时长（更准确）
          state = state.copyWith(duration: duration);
        }
      }
      // 如果 duration 为 null 或 0，保持使用歌曲元数据的时长
    });

    // 监听播放完成
    player.playerStateStream.listen((playerState) {
      if (_lastProcessingStateForDebug != playerState.processingState) {
        _lastProcessingStateForDebug = playerState.processingState;
        _seekDbg(
          'playerState=${playerState.processingState.name} '
          'playing=${playerState.playing} '
          'position=${player.position} '
          'pending=$_pendingSeekPosition '
          'pendingSong=$_pendingSeekSongId '
          'currentSong=${state.currentSong?.id}',
        );
      }
      if (playerState.processingState == ProcessingState.ready ||
          playerState.processingState == ProcessingState.completed) {
        unawaited(_applyPendingSeekIfNeeded());
      }
      if (mounted && playerState.processingState == ProcessingState.completed) {
        _onSongCompleted();
      }
    });

    // 监听循环模式
    player.loopModeStream.listen((loopMode) {
      if (mounted) state = state.copyWith(loopMode: loopMode);
    });

    // 监听随机模式
    player.shuffleModeEnabledStream.listen((enabled) {
      if (mounted) state = state.copyWith(shuffleEnabled: enabled);
    });
  }

  /// 播放单曲
  Future<void> playSong(Song song, {List<Song>? queue, int? index}) async {
    try {
      _seekDbg(
        'playSong start song=${song.id} title="${song.title}" '
        'suffix=${song.suffix} duration=${song.duration}s '
        'queue=${(queue ?? [song]).length} index=${index ?? 0}',
      );
      await _cacheCompletionSubscription?.cancel();
      _cacheCompletionSubscription = null;
      _clearPendingSeek();
      _usingLockCachingSource = false;
      _currentStreamUrl = null;
      _clearStreamContext();

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
        position: Duration.zero,
        duration: initialDuration, // 使用歌曲元数据的时长
      );

      // 更新通知栏媒体信息
      _updateMediaItem(song);

      // 获取当前音质设置
      final effectiveQuality = _ref.read(effectiveQualityProvider);
      final downloadService = _ref.read(downloadServiceProvider);
      final cacheService = _ref.read(audioCacheServiceProvider);

      // 获取当前活跃的音乐库 ID
      final authState = _ref.read(authStateProvider);
      final libraryId = authState.currentLibrary?.id ?? '';

      // ---- 三级优先音源 ----

      // 1. 检查是否已下载
      final downloadedPath = await downloadService.getDownloadedPath(
        song.id,
        libraryId,
      );
      if (downloadedPath != null && File(downloadedPath).existsSync()) {
        Logger.info('Playing from download: ${song.title}');
        await _audioPlayer?.setFilePath(downloadedPath);
        _usingLockCachingSource = false;
        _currentStreamUrl = null;
        _clearStreamContext();
        _startPlayback();
        await _applyPendingSeekIfNeeded();
        _seekDbg('source=download path=$downloadedPath');
        state = state.copyWith(
          currentQuality: AudioQualityLevel.original,
          playbackSource: PlaybackSource.downloaded,
        );
        await _scrobble(song.id, submission: false);
        _preCacheNextSong();
        return;
      }

      // 2. 检查是否已缓存
      final cachedPath = await cacheService.getCachedPath(
        songId: song.id,
        libraryId: libraryId,
        quality: effectiveQuality,
      );
      if (cachedPath != null && File(cachedPath).existsSync()) {
        Logger.info('Playing from cache: ${song.title}');
        await _audioPlayer?.setFilePath(cachedPath);
        _usingLockCachingSource = false;
        _currentStreamUrl = null;
        _clearStreamContext();
        _startPlayback();
        await _applyPendingSeekIfNeeded();
        _seekDbg(
          'source=cache path=$cachedPath quality=${effectiveQuality.name}',
        );
        state = state.copyWith(
          currentQuality: effectiveQuality,
          playbackSource: PlaybackSource.cached,
        );
        await _scrobble(song.id, submission: false);
        _preCacheNextSong();
        return;
      }

      // 3. 流式播放（边播边缓存）
      final String? transcodeFormat = _needsTranscoding(song.suffix);
      final int? maxBitRate;
      if (transcodeFormat != null) {
        // 需要转码时，使用音质设置的 maxBitRate
        maxBitRate = effectiveQuality.maxBitRate ?? 320;
      } else if (effectiveQuality == AudioQualityLevel.original) {
        // 原始无损 — 不传 maxBitRate
        maxBitRate = null;
      } else {
        maxBitRate = effectiveQuality.maxBitRate;
      }

      final streamUrl = _apiClient.getStreamUrl(
        song.id,
        format: transcodeFormat,
        maxBitRate: maxBitRate,
      );

      if (transcodeFormat != null) {
        Logger.info(
          'Transcoding ${song.suffix} to $transcodeFormat for: ${song.title}',
        );
      } else {
        Logger.info(
          'Playing original format (${song.suffix}): ${song.title} '
          '[quality=${effectiveQuality.name}]',
        );
      }

      final isLongTrack = (song.duration ?? 0) > 1200; // >20 分钟
      final shouldUseLockCaching =
          !kIsWeb &&
          libraryId.isNotEmpty &&
          transcodeFormat == null &&
          !isLongTrack;

      if (!shouldUseLockCaching) {
        final reason = <String>[
          if (kIsWeb) 'web',
          if (libraryId.isEmpty) 'no-library',
          if (transcodeFormat != null) 'transcoding',
          if (isLongTrack) 'long-track',
        ].join(',');
        _seekDbg('lock_cache_disabled reason=$reason');
      }

      // 使用 LockCachingAudioSource 边播边缓存（仅非转码且非超长音轨）
      if (shouldUseLockCaching) {
        try {
          final cacheFilePath = await cacheService.getCacheFilePath(
            songId: song.id,
            libraryId: libraryId,
            quality: effectiveQuality,
          );
          final cacheFile = File(cacheFilePath);
          // ignore: experimental_member_use
          final audioSource = LockCachingAudioSource(
            Uri.parse(streamUrl),
            cacheFile: cacheFile,
          );
          await _audioPlayer?.setAudioSource(audioSource);
          _usingLockCachingSource = true;
          _currentStreamUrl = streamUrl;
          _setStreamContext(
            songId: song.id,
            format: transcodeFormat,
            maxBitRate: maxBitRate,
            seekByReloadStream: false,
          );
          _startPlayback();
          _seekDbg(
            'source=lock_cache stream quality=${effectiveQuality.name} '
            'format=${transcodeFormat ?? song.suffix} '
            'processing=${_audioPlayer?.processingState.name}',
          );
          await _applyPendingSeekIfNeeded();

          state = state.copyWith(
            currentQuality: effectiveQuality,
            playbackSource: PlaybackSource.stream,
          );

          // 后台注册缓存（等缓存完成后调用）
          _registerCacheWhenComplete(
            cacheFile: cacheFile,
            songId: song.id,
            libraryId: libraryId,
            quality: effectiveQuality,
          );
        } catch (e) {
          // Fallback: 直接流式播放不缓存
          Logger.warn('LockCachingAudioSource failed, falling back to URL', e);
          await _audioPlayer?.setUrl(streamUrl);
          _usingLockCachingSource = false;
          _currentStreamUrl = streamUrl;
          _setStreamContext(
            songId: song.id,
            format: transcodeFormat,
            maxBitRate: maxBitRate,
            seekByReloadStream: transcodeFormat != null,
          );
          _startPlayback();
          _seekDbg(
            'source=direct_stream_from_lock_fallback quality=${effectiveQuality.name} '
            'format=${transcodeFormat ?? song.suffix}',
          );
          await _applyPendingSeekIfNeeded();
          state = state.copyWith(
            currentQuality: effectiveQuality,
            playbackSource: PlaybackSource.stream,
          );
        }
      } else {
        // 直接流式播放（Web / 无音乐库 / 转码流 / 超长音轨）
        await _audioPlayer?.setUrl(streamUrl);
        _usingLockCachingSource = false;
        _currentStreamUrl = streamUrl;
        _setStreamContext(
          songId: song.id,
          format: transcodeFormat,
          maxBitRate: maxBitRate,
          seekByReloadStream: transcodeFormat != null,
        );
        _startPlayback();
        _seekDbg(
          'source=direct_stream quality=${effectiveQuality.name} '
          'format=${transcodeFormat ?? song.suffix}',
        );
        await _applyPendingSeekIfNeeded();
        state = state.copyWith(
          currentQuality: effectiveQuality,
          playbackSource: PlaybackSource.stream,
        );
      }

      // 上报"正在播放"
      await _scrobble(song.id, submission: false);

      Logger.info('Playing: ${song.title}');
      _seekDbg(
        'playSong ready song=${song.id} currentPos=${_audioPlayer?.position} '
        'duration=${state.duration}',
      );

      // 预缓存下一首
      _preCacheNextSong();
    } catch (e) {
      Logger.error('Failed to play song', e);
      _seekDbg('playSong failed song=${song.id} err=$e');

      final hasAvailableRoute = await _refreshRoutesAndCheckAvailability();
      if (!hasAvailableRoute) {
        NetworkErrorNotifier.show('网络异常，当前无可用线路');
        return;
      }

      // 如果播放失败且没有转码过，尝试转码播放
      if (_needsTranscoding(song.suffix) == null) {
        Logger.info('Original format failed, retrying with MP3 transcoding');
        await _playWithTranscoding(song, queue: queue, index: index);
      }
    }
  }

  /// 使用转码方式播放（降级方案）
  Future<void> _playWithTranscoding(
    Song song, {
    List<Song>? queue,
    int? index,
  }) async {
    try {
      final streamUrl = _apiClient.getStreamUrl(
        song.id,
        format: 'mp3', // 转码为 MP3
        maxBitRate: 320,
      );

      Logger.info('Retrying with MP3 transcoding: ${song.title}');
      await _audioPlayer?.setUrl(streamUrl);
      _usingLockCachingSource = false;
      _currentStreamUrl = streamUrl;
      _setStreamContext(
        songId: song.id,
        format: 'mp3',
        maxBitRate: 320,
        seekByReloadStream: true,
      );
      _startPlayback();
      _seekDbg('source=direct_stream_transcoding mp3 song=${song.id}');
      await _applyPendingSeekIfNeeded();

      // 上报"正在播放"
      await _scrobble(song.id, submission: false);
    } catch (e) {
      Logger.error('Failed to play song even with transcoding', e);
      final hasAvailableRoute = await _refreshRoutesAndCheckAvailability();
      if (!hasAvailableRoute) {
        NetworkErrorNotifier.show('网络异常，当前无可用线路');
      }
    }
  }

  /// 判断格式是否需要强制转码
  /// 返回 null 表示直接使用原始格式，返回格式字符串表示需要转码
  String? _needsTranscoding(String? suffix) {
    if (suffix == null) return null;

    final lowerSuffix = suffix.toLowerCase();

    // macOS/iOS 原生支持 m4a/alac（AVFoundation/CoreAudio），无需转码
    final isApplePlatform = !kIsWeb && (Platform.isMacOS || Platform.isIOS);

    // 所有平台都不支持的格式
    const universallyUnsupported = [
      'ape', // Monkey's Audio
      'wv', // WavPack
      'tta', // True Audio
      'dff', // DSD
      'dsf', // DSD
      'tak', // TAK
    ];

    if (universallyUnsupported.contains(lowerSuffix)) {
      return 'mp3';
    }

    // Android 上 m4a/alac 支持不完整，需要转码
    if (!isApplePlatform) {
      const androidUnsupported = [
        'm4a', // 可能包含 ALAC 编码，Android 支持不完整
        'alac', // Apple Lossless
      ];
      if (androidUnsupported.contains(lowerSuffix)) {
        return 'mp3';
      }
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

  /// 启动播放但不阻塞当前流程。
  /// just_audio 的 play() Future 会在暂停/结束时才完成，不能在切歌流程里 await。
  void _startPlayback() {
    final player = _audioPlayer;
    if (player == null) return;
    unawaited(
      player.play().catchError((error) {
        Logger.warn('Failed to start playback', error);
      }),
    );
  }

  /// 播放队列
  Future<void> playQueue(List<Song> songs, {int startIndex = 0}) async {
    if (songs.isEmpty) return;
    await playSong(songs[startIndex], queue: songs, index: startIndex);
  }

  /// 播放/暂停
  Future<void> togglePlayPause() async {
    if (state.isPlaying) {
      await _audioPlayer?.pause();
      await _audioHandler?.pause();
    } else {
      await _audioPlayer?.play();
      await _audioHandler?.play();
    }
  }

  /// 暂停
  Future<void> pause() async {
    await _audioPlayer?.pause();
    await _audioHandler?.pause();
  }

  /// 播放
  Future<void> play() async {
    await _audioPlayer?.play();
    await _audioHandler?.play();
  }

  /// 上一首
  Future<void> previous() async {
    if (!state.hasPrevious) return;

    if (state.shuffleEnabled) {
      final previousIndex = _getRandomIndexExcludingCurrent();
      if (previousIndex == null) return;
      final previousSong = state.queue[previousIndex];
      await playSong(previousSong, queue: state.queue, index: previousIndex);
      return;
    }

    final previousIndex = state.currentIndex - 1;
    final previousSong = state.queue[previousIndex];

    await playSong(previousSong, queue: state.queue, index: previousIndex);
  }

  /// 下一首
  Future<void> next() async {
    if (!state.hasNext) return;

    if (state.shuffleEnabled) {
      final nextIndex = _getRandomIndexExcludingCurrent();
      if (nextIndex == null) return;
      final nextSong = state.queue[nextIndex];
      await playSong(nextSong, queue: state.queue, index: nextIndex);
      return;
    }

    final nextIndex = state.currentIndex + 1;
    final nextSong = state.queue[nextIndex];

    await playSong(nextSong, queue: state.queue, index: nextIndex);
  }

  /// 跳转到指定位置
  Future<void> seek(Duration position) async {
    final player = _audioPlayer;
    final currentSongId = state.currentSong?.id;
    if (player == null || currentSongId == null) return;

    final target = _normalizeSeekPosition(position);
    final canSeekNow =
        player.processingState == ProcessingState.ready ||
        player.processingState == ProcessingState.completed;
    _seekDbg(
      'seek request song=$currentSongId target=$target '
      'playerPos=${player.position} state=${player.processingState.name} '
      'canSeekNow=$canSeekNow lockCache=$_usingLockCachingSource',
    );

    if (!canSeekNow) {
      _pendingSeekSongId = currentSongId;
      _pendingSeekPosition = target;
      _seekDbg('seek queued pendingSong=$_pendingSeekSongId pending=$target');
      if (mounted) {
        state = state.copyWith(position: target);
      }
      return;
    }

    _clearPendingSeek();
    await _seekWithFallback(target);
    if (mounted) {
      state = state.copyWith(position: target);
    }
  }

  /// 跳转到队列中的指定歌曲
  Future<void> skipToQueueItem(int index) async {
    if (index < 0 || index >= state.queue.length) return;

    final song = state.queue[index];
    await playSong(song, queue: state.queue, index: index);
  }

  /// 设置循环模式
  Future<void> setLoopMode(LoopMode mode) async {
    await _audioPlayer?.setLoopMode(mode);
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
    await _audioPlayer?.setShuffleModeEnabled(enabled);
    if (mounted) {
      state = state.copyWith(shuffleEnabled: enabled);
    }
  }

  /// 切换随机播放
  Future<void> toggleShuffle() async {
    await setShuffleEnabled(!state.shuffleEnabled);
  }

  /// 播放失败后刷新全部线路，确认是否存在可用线路
  Future<bool> _refreshRoutesAndCheckAvailability() async {
    try {
      final pool = _ref.read(addressPoolProvider);
      final active = await pool.probeAll();
      if (active?.status == ServerAddressStatus.ok) return true;
      return pool.addresses.any((a) => a.status == ServerAddressStatus.ok);
    } catch (e) {
      Logger.warn('Failed to refresh routes after playback error', e);
      return false;
    }
  }

  /// 当前播放模式（三态）
  PlaybackMode get playbackMode {
    if (state.shuffleEnabled) return PlaybackMode.shuffle;
    if (state.loopMode == LoopMode.one) return PlaybackMode.repeatOne;
    return PlaybackMode.repeatAll;
  }

  /// 设置三态播放模式
  Future<void> setPlaybackMode(PlaybackMode mode) async {
    switch (mode) {
      case PlaybackMode.shuffle:
        // 队列是手动切歌而非播放器内建列表。
        // 在随机模式使用 LoopMode.off，避免底层播放器自动重放当前单曲。
        await _audioPlayer?.setLoopMode(LoopMode.off);
        await _audioPlayer?.setShuffleModeEnabled(true);
        if (mounted) {
          state = state.copyWith(loopMode: LoopMode.off, shuffleEnabled: true);
        }
        break;
      case PlaybackMode.repeatAll:
        await _audioPlayer?.setShuffleModeEnabled(false);
        await _audioPlayer?.setLoopMode(LoopMode.all);
        if (mounted) {
          state = state.copyWith(loopMode: LoopMode.all, shuffleEnabled: false);
        }
        break;
      case PlaybackMode.repeatOne:
        await _audioPlayer?.setShuffleModeEnabled(false);
        await _audioPlayer?.setLoopMode(LoopMode.one);
        if (mounted) {
          state = state.copyWith(loopMode: LoopMode.one, shuffleEnabled: false);
        }
        break;
    }
  }

  /// 循环切换三态播放模式：
  /// 随机 -> 列表循环 -> 单曲循环 -> 随机
  Future<void> cyclePlaybackMode() async {
    final nextMode = switch (playbackMode) {
      PlaybackMode.shuffle => PlaybackMode.repeatAll,
      PlaybackMode.repeatAll => PlaybackMode.repeatOne,
      PlaybackMode.repeatOne => PlaybackMode.shuffle,
    };
    await setPlaybackMode(nextMode);
  }

  int? _getRandomIndexExcludingCurrent() {
    final queue = state.queue;
    if (queue.length <= 1) return null;

    final currentIndex = state.currentIndex;
    final currentSongId = state.currentSong?.id;

    final nonDuplicateCandidates = <int>[];
    final fallbackCandidates = <int>[];

    for (var i = 0; i < queue.length; i++) {
      if (i == currentIndex) continue;
      fallbackCandidates.add(i);
      if (currentSongId == null || queue[i].id != currentSongId) {
        nonDuplicateCandidates.add(i);
      }
    }

    final candidates = nonDuplicateCandidates.isNotEmpty
        ? nonDuplicateCandidates
        : fallbackCandidates;
    if (candidates.isEmpty) return null;

    return candidates[_random.nextInt(candidates.length)];
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

  /// 添加到下一曲位置
  Future<void> playNext(Song song) async {
    if (state.queue.isEmpty || state.currentSong == null) {
      await playSong(song, queue: [song], index: 0);
      return;
    }

    final newQueue = [...state.queue];
    final insertIndex = (state.currentIndex + 1).clamp(0, newQueue.length);
    newQueue.insert(insertIndex, song);
    state = state.copyWith(queue: newQueue);
  }

  /// 清空队列
  Future<void> clearQueue() async {
    await _audioPlayer?.stop();
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
      _audioPlayer?.stop();
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

    // 随机模式优先：从队列中随机到下一首，不走 loopMode 分支。
    if (state.shuffleEnabled) {
      if (state.queue.length > 1) {
        await next();
      }
      return;
    }

    // 根据循环模式决定下一步
    if (state.loopMode == LoopMode.one) {
      // 单曲循环
      await _audioPlayer?.seek(Duration.zero);
      _startPlayback();
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
    await toggleSongFavorite(currentSong);
  }

  /// 切换指定歌曲的收藏状态
  Future<bool?> toggleSongFavorite(Song song) async {
    try {
      Song? queueSong;
      for (final queued in state.queue) {
        if (queued.id == song.id) {
          queueSong = queued;
          break;
        }
      }
      final currentSong = state.currentSong;
      final currentStarred =
          queueSong?.starred ??
          (currentSong?.id == song.id ? currentSong!.starred : song.starred);
      final newStarred = !currentStarred;
      await _musicRepository.setSongStarred(song.id, newStarred);

      final updatedQueue = state.queue.map((queuedSong) {
        if (queuedSong.id != song.id) return queuedSong;
        return _copySongWithStarred(queuedSong, newStarred);
      }).toList();

      final updatedCurrentSong =
          currentSong != null && currentSong.id == song.id
          ? _copySongWithStarred(currentSong, newStarred)
          : state.currentSong;

      state = state.copyWith(
        currentSong: updatedCurrentSong,
        queue: updatedQueue,
      );

      // 刷新相关数据
      _ref.invalidate(starredProvider);
      _ref.invalidate(randomSongsProvider);
      _ref.invalidate(allSongsProvider);
      if (song.albumId != null && song.albumId!.isNotEmpty) {
        _ref.invalidate(albumDetailProvider(song.albumId!));
      }

      Logger.info('Toggled favorite for ${song.title}: $newStarred');
      return newStarred;
    } catch (e) {
      Logger.error('Failed to toggle favorite', e);
      return null;
    }
  }

  Song _copySongWithStarred(Song source, bool starred) {
    return Song(
      id: source.id,
      title: source.title,
      album: source.album,
      albumId: source.albumId,
      artist: source.artist,
      artistId: source.artistId,
      track: source.track,
      year: source.year,
      genre: source.genre,
      coverArt: source.coverArt,
      size: source.size,
      contentType: source.contentType,
      suffix: source.suffix,
      duration: source.duration,
      bitRate: source.bitRate,
      path: source.path,
      isVideo: source.isVideo,
      playCount: source.playCount,
      created: source.created,
      starred: starred,
      discNumber: source.discNumber,
      type: source.type,
    );
  }

  Duration _normalizeSeekPosition(Duration position) {
    if (position < Duration.zero) return Duration.zero;
    final duration = state.duration;
    if (duration > Duration.zero && position > duration) {
      return duration;
    }
    return position;
  }

  Future<void> _applyPendingSeekIfNeeded() async {
    final player = _audioPlayer;
    final pending = _pendingSeekPosition;
    final pendingSongId = _pendingSeekSongId;
    final currentSongId = state.currentSong?.id;
    if (player == null ||
        pending == null ||
        pendingSongId == null ||
        currentSongId == null) {
      return;
    }
    if (pendingSongId != currentSongId) return;

    final canSeekNow =
        player.processingState == ProcessingState.ready ||
        player.processingState == ProcessingState.completed;
    if (!canSeekNow) return;

    final target = _normalizeSeekPosition(pending);
    _seekDbg(
      'applyPendingSeek song=$currentSongId target=$target '
      'playerPos=${player.position} state=${player.processingState.name}',
    );
    _clearPendingSeek();
    await _seekWithFallback(target);
    if (mounted) {
      state = state.copyWith(position: target);
    }
  }

  Future<void> _seekWithFallback(Duration target) async {
    final player = _audioPlayer;
    if (player == null) return;

    if (_seekByReloadStream &&
        _currentStreamSongId != null &&
        _currentStreamUrl != null) {
      final shouldResume = player.playing;
      final offset = target.inSeconds;
      final reloadUrl = _apiClient.getStreamUrl(
        _currentStreamSongId!,
        maxBitRate: _currentStreamMaxBitRate,
        format: _currentStreamFormat,
        timeOffset: offset,
      );
      _seekDbg(
        'seek reload-stream song=$_currentStreamSongId '
        'target=$target offsetSec=$offset format=$_currentStreamFormat '
        'maxBitRate=$_currentStreamMaxBitRate wasPlaying=$shouldResume',
      );
      await player.setUrl(reloadUrl, initialPosition: target);
      _currentStreamUrl = reloadUrl;
      if (shouldResume) {
        _startPlayback();
      }
      await Future<void>.delayed(const Duration(milliseconds: 220));
      final actualReload = player.position;
      final reloadDrift = (actualReload - target).inMilliseconds.abs();
      _seekDbg(
        'seek reload-stream verify target=$target actual=$actualReload '
        'driftMs=$reloadDrift',
      );
      if (reloadDrift <= 2000) return;
      if (target > const Duration(seconds: 30) &&
          actualReload < const Duration(seconds: 3) &&
          reloadDrift > 60000) {
        _transcodeTimeOffsetSupported = false;
        _seekDbg(
          'reload-stream timeOffset unsupported on current server, '
          'disable reload-stream seek for this session',
        );
      }
      Logger.warn(
        'Reload-stream seek drift still high '
        '(target=$target, actual=$actualReload), retrying plain seek',
      );
      await player.seek(target);
      return;
    }

    _seekDbg(
      'seek execute target=$target from=${player.position} '
      'state=${player.processingState.name} lockCache=$_usingLockCachingSource',
    );
    await player.seek(target);

    await Future<void>.delayed(const Duration(milliseconds: 220));
    final actual = player.position;
    final drift = (actual - target).inMilliseconds.abs();
    _seekDbg('seek verify target=$target actual=$actual driftMs=$drift');
    if (drift <= 2000) return;

    // LockCachingAudioSource 在刚开始下载时，远跳转可能出现“位置变化但音频仍从头播放”。
    // 检测到明显偏差时切换到直连流并携带 initialPosition，保证实际音频位置正确。
    if (_usingLockCachingSource && _currentStreamUrl != null) {
      final shouldResume = player.playing;
      Logger.warn(
        'Lock cache seek drift detected (target=$target, actual=$actual), '
        'switching to direct stream source',
      );
      _seekDbg(
        'seek fallback -> direct stream initialPosition=$target '
        'wasPlaying=$shouldResume',
      );
      await player.setUrl(_currentStreamUrl!, initialPosition: target);
      _usingLockCachingSource = false;
      if (shouldResume) {
        await player.play();
      }
      _seekDbg('seek fallback completed now=${player.position}');
      return;
    }

    // 直连流/本地文件也做一次强制重试，规避解码器刚起播时的 seek 抖动。
    final shouldResume = player.playing;
    Logger.warn(
      'Seek drift detected on non-lock source (target=$target, actual=$actual), '
      'retrying seek',
    );
    if (shouldResume) {
      await player.pause();
    }
    await player.seek(target);
    if (shouldResume) {
      await player.play();
    }
    await Future<void>.delayed(const Duration(milliseconds: 120));
    _seekDbg('seek retry completed now=${player.position}');
  }

  void _clearPendingSeek() {
    if (_pendingSeekPosition != null || _pendingSeekSongId != null) {
      _seekDbg(
        'clearPendingSeek pending=$_pendingSeekPosition pendingSong=$_pendingSeekSongId',
      );
    }
    _pendingSeekPosition = null;
    _pendingSeekSongId = null;
  }

  void _setStreamContext({
    required String songId,
    required String? format,
    required int? maxBitRate,
    required bool seekByReloadStream,
  }) {
    _currentStreamSongId = songId;
    _currentStreamFormat = format;
    _currentStreamMaxBitRate = maxBitRate;
    _seekByReloadStream = seekByReloadStream && _transcodeTimeOffsetSupported;
    if (seekByReloadStream &&
        _transcodeTimeOffsetSupported &&
        !_seekByReloadStream) {
      _seekDbg(
        'reload-stream seek disabled by capability cache '
        '(timeOffset unsupported)',
      );
    }
  }

  void _clearStreamContext() {
    _currentStreamSongId = null;
    _currentStreamFormat = null;
    _currentStreamMaxBitRate = null;
    _seekByReloadStream = false;
  }

  void _seekDbg(String message) {
    Logger.info('[SEEKDBG] $message');
  }

  /// 缓存完成后注册缓存元数据
  Future<void> _registerCacheWhenComplete({
    required File cacheFile,
    required String songId,
    required String libraryId,
    required AudioQualityLevel quality,
  }) async {
    final player = _audioPlayer;
    if (player == null) return;

    _cacheCompletionSubscription?.cancel();
    _cacheCompletionSubscription = player.playerStateStream.listen((ps) async {
      if (ps.processingState != ProcessingState.completed) return;

      await _cacheCompletionSubscription?.cancel();
      _cacheCompletionSubscription = null;

      // 仅为当前播放歌曲注册缓存，避免切歌后误写元数据
      if (state.currentSong?.id != songId) return;

      try {
        if (await cacheFile.exists()) {
          final fileSize = await cacheFile.length();
          if (fileSize > 0) {
            final cacheService = _ref.read(audioCacheServiceProvider);
            await cacheService.registerCache(
              songId: songId,
              libraryId: libraryId,
              filePath: cacheFile.path,
              fileSize: fileSize,
              quality: quality,
            );
            Logger.info('Cache registered for: $songId');
          }
        }
      } catch (e) {
        Logger.warn('Failed to register cache', e);
      }
    });
  }

  /// 预缓存队列中下一首歌
  void _preCacheNextSong() async {
    if (!state.hasNext) return;
    if (kIsWeb) return; // Web 平台不预缓存
    if (state.shuffleEnabled) return; // 随机模式下一首不确定，跳过顺序预缓存
    if (state.currentIndex < 0 ||
        state.currentIndex >= state.queue.length - 1) {
      return;
    }

    final nextSong = state.queue[state.currentIndex + 1];
    final authState = _ref.read(authStateProvider);
    final libraryId = authState.currentLibrary?.id ?? '';
    if (libraryId.isEmpty) return;

    final downloadService = _ref.read(downloadServiceProvider);
    final cacheService = _ref.read(audioCacheServiceProvider);
    final effectiveQuality = _ref.read(effectiveQualityProvider);

    // 已下载则不需要预缓存
    final downloaded = await downloadService.isDownloaded(
      nextSong.id,
      libraryId,
    );
    if (downloaded) return;

    // 已缓存则不需要预缓存
    final cached = await cacheService.getCachedPath(
      songId: nextSong.id,
      libraryId: libraryId,
      quality: effectiveQuality,
    );
    if (cached != null) return;

    // 预缓存：构建 LockCachingAudioSource 但不播放
    try {
      final streamUrl = _apiClient.getStreamUrl(
        nextSong.id,
        format: _needsTranscoding(nextSong.suffix),
        maxBitRate: effectiveQuality.maxBitRate,
      );
      final cacheFilePath = await cacheService.getCacheFilePath(
        songId: nextSong.id,
        libraryId: libraryId,
        quality: effectiveQuality,
      );
      // 创建 LockCachingAudioSource 会自动开始下载缓存
      // ignore: experimental_member_use
      LockCachingAudioSource(
        Uri.parse(streamUrl),
        cacheFile: File(cacheFilePath),
      );
      Logger.info('Pre-caching next song: ${nextSong.title}');
    } catch (e) {
      Logger.warn('Pre-cache failed for next song', e);
    }
  }

  @override
  void dispose() {
    _cacheCompletionSubscription?.cancel();
    // Check if initialized/assigned before disposing
    // Since it was 'late', we can't check.
    // Converting to nullable field:
    _audioPlayer?.dispose();
    _audioHandler?.stop(); // Ensure handler is stopped too
    super.dispose();
  }
}
