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
import '../data/sources/local_storage.dart';
import '../data/repositories/music_repository.dart';
import '../core/constants/api_constants.dart';
import '../core/network/connectivity_monitor.dart';
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

const _playerLogTag = 'PLAYER';
const _playDbgTag = 'PLAYDBG';
const _maxShuffleHistoryEntries = 200;

class _ShuffleHistoryEntry {
  const _ShuffleHistoryEntry({
    required this.songId,
    required this.preferredIndex,
  });

  final String songId;
  final int preferredIndex;
}

/// 播放器状态
class PlayerState {
  final Song? currentSong;
  final List<Song> queue;
  final int currentIndex;
  final bool isPlaying;
  final ProcessingState processingState;
  final Duration position;
  final Duration duration;
  final LoopMode loopMode;
  final bool shuffleEnabled;
  final int shuffleHistoryCount;
  final AudioQualityLevel? currentQuality;
  final PlaybackSource? playbackSource;
  final int currentBitRateKbps;

  PlayerState({
    this.currentSong,
    this.queue = const [],
    this.currentIndex = 0,
    this.isPlaying = false,
    this.processingState = ProcessingState.idle,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.loopMode = LoopMode.off,
    this.shuffleEnabled = false,
    this.shuffleHistoryCount = 0,
    this.currentQuality,
    this.playbackSource,
    this.currentBitRateKbps = 0,
  });

  PlayerState copyWith({
    Song? currentSong,
    List<Song>? queue,
    int? currentIndex,
    bool? isPlaying,
    ProcessingState? processingState,
    Duration? position,
    Duration? duration,
    LoopMode? loopMode,
    bool? shuffleEnabled,
    int? shuffleHistoryCount,
    AudioQualityLevel? currentQuality,
    PlaybackSource? playbackSource,
    int? currentBitRateKbps,
  }) {
    return PlayerState(
      currentSong: currentSong ?? this.currentSong,
      queue: queue ?? this.queue,
      currentIndex: currentIndex ?? this.currentIndex,
      isPlaying: isPlaying ?? this.isPlaying,
      processingState: processingState ?? this.processingState,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      loopMode: loopMode ?? this.loopMode,
      shuffleEnabled: shuffleEnabled ?? this.shuffleEnabled,
      shuffleHistoryCount: shuffleHistoryCount ?? this.shuffleHistoryCount,
      currentQuality: currentQuality ?? this.currentQuality,
      playbackSource: playbackSource ?? this.playbackSource,
      currentBitRateKbps: currentBitRateKbps ?? this.currentBitRateKbps,
    );
  }

  bool get _hasValidCurrent =>
      currentSong != null && currentIndex >= 0 && currentIndex < queue.length;

  bool get hasNext {
    if (!_hasValidCurrent) return false;
    if (shuffleEnabled) return queue.length > 1;
    // 单曲循环只影响播放完成时自动重播；手动下一曲按顺序推进，不回绕。
    if (loopMode == LoopMode.one) return currentIndex < queue.length - 1;
    // 列表循环（Repeat All）下，末尾仍允许“下一曲”回到第一首。
    return queue.isNotEmpty;
  }

  bool get hasPrevious {
    if (!_hasValidCurrent) return false;
    // 与主流播放器一致：只要队列存在当前曲目，上一曲始终可用（首项回到末项，单曲回自己）。
    return queue.isNotEmpty;
  }
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
  final List<_ShuffleHistoryEntry> _shuffleBackHistory =
      <_ShuffleHistoryEntry>[];
  final List<_ShuffleHistoryEntry> _shuffleForwardHistory =
      <_ShuffleHistoryEntry>[];
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
  String? _forcedNextSongId;
  int? _forcedNextIndex;
  ProcessingState? _lastProcessingStateForDebug;
  bool _isHandlingCompletion = false;
  String? _completionHandlingSongId;
  Timer? _positionPollTimer;
  Duration _lastPolledPlayerPosition = Duration.zero;
  int _stagnantPositionTicks = 0;
  int _lastStagnantLogTick = -1;
  int _lastIgnoredSyntheticPositionLogTick = -1;
  bool _syntheticPositionFallbackActive = false;
  int _playDebugSession = 0;
  bool _loggedDurationUnavailableForSong = false;

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
      _playDbg(
        'playingStream playing=$isPlaying '
        'processing=${player.processingState.name} '
        'position=${player.position} buffered=${player.bufferedPosition} '
        'song=${state.currentSong?.id}',
      );
      if (mounted) state = state.copyWith(isPlaying: isPlaying);
    });

    // 监听播放进度
    player.positionStream.listen((position) {
      if (!mounted) return;

      // 合成进度模式下，lock cache 的 positionStream 可能回传 0 或过时位置，
      // 会把 UI 进度回退。此时统一忽略，交给轮询器维护并在恢复后切回真实位置。
      final ignorePositionWhileSynthetic =
          _syntheticPositionFallbackActive &&
          _usingLockCachingSource &&
          state.position > const Duration(milliseconds: 250);
      if (ignorePositionWhileSynthetic) {
        final isStuckZero = position <= const Duration(milliseconds: 50);
        final shouldLog =
            _stagnantPositionTicks != _lastIgnoredSyntheticPositionLogTick &&
            _stagnantPositionTicks % 6 == 0;
        if (shouldLog) {
          _lastIgnoredSyntheticPositionLogTick = _stagnantPositionTicks;
          _playDbg(
            isStuckZero
                ? 'positionStream ignored_stuck_zero '
                      'streamPos=$position statePos=${state.position} '
                      'song=${state.currentSong?.id}'
                : 'positionStream ignored_while_synthetic '
                      'streamPos=$position statePos=${state.position} '
                      'song=${state.currentSong?.id}',
          );
        }
        return;
      }

      state = state.copyWith(position: position);
    });
    _startPositionPolling(player);

    // 监听总时长
    player.durationStream.listen((duration) {
      if (mounted) {
        if (duration != null && duration > Duration.zero) {
          // 如果流能提供时长，优先使用流的时长（更准确）
          state = state.copyWith(duration: duration);
          _loggedDurationUnavailableForSong = false;
          _playDbg(
            'durationStream duration=$duration song=${state.currentSong?.id}',
          );
        } else {
          if (!_loggedDurationUnavailableForSong && state.currentSong != null) {
            _loggedDurationUnavailableForSong = true;
            _playDbg(
              'durationStream unavailable duration=$duration '
              'song=${state.currentSong?.id}',
            );
          }
        }
      }
      // 如果 duration 为 null 或 0，保持使用歌曲元数据的时长
    });

    // 监听播放完成
    player.playerStateStream.listen((playerState) {
      if (mounted && state.processingState != playerState.processingState) {
        state = state.copyWith(processingState: playerState.processingState);
      }
      if (_lastProcessingStateForDebug != playerState.processingState) {
        _lastProcessingStateForDebug = playerState.processingState;
        _seekDbg(
          'playerState=${playerState.processingState.name} '
          'playing=${playerState.playing} '
          'position=${player.position} '
          'buffered=${player.bufferedPosition} '
          'duration=${player.duration} '
          'pending=$_pendingSeekPosition '
          'pendingSong=$_pendingSeekSongId '
          'currentSong=${state.currentSong?.id}',
        );
      }
      if (playerState.processingState == ProcessingState.ready ||
          playerState.processingState == ProcessingState.completed) {
        unawaited(_applyPendingSeekIfNeeded());
      }

      if (playerState.processingState != ProcessingState.completed) {
        _isHandlingCompletion = false;
        _completionHandlingSongId = null;
      }

      if (mounted && playerState.processingState == ProcessingState.completed) {
        final completedSongId = state.currentSong?.id;
        final shouldHandle =
            completedSongId != null &&
            (!_isHandlingCompletion ||
                _completionHandlingSongId != completedSongId);
        if (shouldHandle) {
          _isHandlingCompletion = true;
          _completionHandlingSongId = completedSongId;
          _seekDbg(
            'completed detected song=$completedSongId '
            'loop=${state.loopMode.name} shuffle=${state.shuffleEnabled} '
            'index=${state.currentIndex}/${state.queue.length - 1} '
            'hasNext=${state.hasNext}',
          );
          unawaited(_onSongCompleted(completedSongId));
        }
      }
    });

    // 监听循环模式
    player.loopModeStream.listen((loopMode) {
      if (mounted) state = state.copyWith(loopMode: loopMode);
    });

    // 监听随机模式
    player.shuffleModeEnabledStream.listen((enabled) {
      if (!enabled) {
        _resetShuffleHistory(updateState: false);
      }
      if (mounted) {
        state = state.copyWith(
          shuffleEnabled: enabled,
          shuffleHistoryCount: enabled ? state.shuffleHistoryCount : 0,
        );
      }
    });

    await _restorePlaybackMode();
  }

  /// 播放单曲
  Future<void> playSong(
    Song song, {
    List<Song>? queue,
    int? index,
    bool recordShuffleHistory = false,
    bool clearShuffleForwardHistory = false,
  }) async {
    if (song.isPreview) {
      await _playPreviewSongInternal(song);
      return;
    }

    final playQueue = queue ?? [song];
    final playIndex = index ?? 0;
    _syncShuffleHistoryBeforeSongChange(
      nextSong: song,
      nextQueue: playQueue,
      nextIndex: playIndex,
      recordHistory: recordShuffleHistory,
      clearForwardHistory: clearShuffleForwardHistory,
    );

    final debugSession = ++_playDebugSession;
    try {
      _seekDbg(
        'playSong start song=${song.id} title="${song.title}" '
        'suffix=${song.suffix} duration=${song.duration}s '
        'queue=${playQueue.length} index=$playIndex',
      );
      _playDbg(
        'sid=$debugSession playSong enter song=${song.id} '
        'suffix=${song.suffix} durationSec=${song.duration} '
        'queue=${playQueue.length} index=$playIndex',
      );
      await _cacheCompletionSubscription?.cancel();
      _cacheCompletionSubscription = null;
      _clearPendingSeek();
      _usingLockCachingSource = false;
      _currentStreamUrl = null;
      _clearStreamContext();
      _clearForcedNext();
      _isHandlingCompletion = false;
      _completionHandlingSongId = null;
      _lastPolledPlayerPosition = Duration.zero;
      _stagnantPositionTicks = 0;
      _lastStagnantLogTick = -1;
      _lastIgnoredSyntheticPositionLogTick = -1;
      _syntheticPositionFallbackActive = false;
      _loggedDurationUnavailableForSong = false;

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
        currentBitRateKbps: 0,
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
        _playDbg(
          'sid=$debugSession source=download setFilePath path=$downloadedPath',
        );
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
          currentBitRateKbps: _resolveCurrentBitRateKbps(
            song: song,
            quality: AudioQualityLevel.original,
            source: PlaybackSource.downloaded,
          ),
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
        _playDbg(
          'sid=$debugSession source=cache setFilePath path=$cachedPath '
          'quality=${effectiveQuality.name}',
        );
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
          currentBitRateKbps: _resolveCurrentBitRateKbps(
            song: song,
            quality: effectiveQuality,
            source: PlaybackSource.cached,
            maxBitRate: effectiveQuality.maxBitRate,
          ),
        );
        await _scrobble(song.id, submission: false);
        unawaited(
          _recordMobileCacheSavedBytesForHit(
            songId: song.id,
            cacheFilePath: cachedPath,
            libraryId: libraryId,
          ),
        );
        _preCacheNextSong();
        return;
      }

      // 3. 流式播放（边播边缓存）
      final String? transcodeFormat = _needsTranscoding(song.suffix);
      final int? maxBitRate;
      if (transcodeFormat != null) {
        // 需要转码时：原始音质不限制码率，其它音质使用对应 maxBitRate。
        maxBitRate = effectiveQuality == AudioQualityLevel.original
            ? null
            : (effectiveQuality.maxBitRate ?? 320);
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
      final isAppleHttpStream =
          !kIsWeb &&
          (Platform.isIOS || Platform.isMacOS) &&
          streamUrl.startsWith('http://');
      _playDbg(
        'sid=$debugSession stream_resolved '
        'quality=${effectiveQuality.name} transcode=${transcodeFormat ?? 'none'} '
        'maxBitRate=${maxBitRate ?? 'none'} appleHttp=$isAppleHttpStream '
        'url=${_summarizeStreamUrl(streamUrl)}',
      );

      if (transcodeFormat != null) {
        Logger.info(
          'Transcoding ${song.suffix} to $transcodeFormat for: ${song.title}',
        );
      } else if (maxBitRate != null) {
        Logger.info(
          'Playing bitrate-limited stream (${song.suffix}) '
          'maxBitRate=$maxBitRate: ${song.title}',
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
          maxBitRate == null &&
          !isLongTrack;

      if (!shouldUseLockCaching) {
        final reason = <String>[
          if (kIsWeb) 'web',
          if (libraryId.isEmpty) 'no-library',
          if (transcodeFormat != null) 'transcoding',
          if (maxBitRate != null) 'bitrate-limited',
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
          _playDbg(
            'sid=$debugSession source=lock_cache setAudioSource '
            'cachePath=$cacheFilePath',
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
            currentBitRateKbps: _resolveCurrentBitRateKbps(
              song: song,
              quality: effectiveQuality,
              source: PlaybackSource.stream,
              maxBitRate: maxBitRate,
            ),
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
          _playDbg(
            'sid=$debugSession source=lock_cache setAudioSource failed '
            'err=$e, fallback=setUrl',
          );
          Logger.warn('LockCachingAudioSource failed, falling back to URL', e);
          _playDbg(
            'sid=$debugSession source=direct_stream_from_lock_fallback '
            'setUrl=${_summarizeStreamUrl(streamUrl)}',
          );
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
            currentBitRateKbps: _resolveCurrentBitRateKbps(
              song: song,
              quality: effectiveQuality,
              source: PlaybackSource.stream,
              maxBitRate: maxBitRate,
            ),
          );
        }
      } else {
        // 直接流式播放（Web / 无音乐库 / 转码流 / 超长音轨）
        try {
          _playDbg(
            'sid=$debugSession source=direct_stream setUrl='
            '${_summarizeStreamUrl(streamUrl)}',
          );
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
        } catch (e) {
          final canFallbackToLockCache =
              isAppleHttpStream && libraryId.isNotEmpty;
          _playDbg(
            'sid=$debugSession source=direct_stream setUrl failed err=$e '
            'canFallbackToLockCache=$canFallbackToLockCache',
          );
          if (!canFallbackToLockCache) rethrow;

          Logger.warn(
            'Direct stream failed on Apple HTTP, falling back to lock cache',
            e,
          );
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
          _playDbg(
            'sid=$debugSession source=lock_cache_from_direct_fallback '
            'setAudioSource cachePath=$cacheFilePath',
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
            'source=lock_cache_from_direct_fallback '
            'quality=${effectiveQuality.name} '
            'format=${transcodeFormat ?? song.suffix}',
          );
        }

        await _applyPendingSeekIfNeeded();
        state = state.copyWith(
          currentQuality: effectiveQuality,
          playbackSource: PlaybackSource.stream,
          currentBitRateKbps: _resolveCurrentBitRateKbps(
            song: song,
            quality: effectiveQuality,
            source: PlaybackSource.stream,
            maxBitRate: maxBitRate,
          ),
        );
      }

      // 上报"正在播放"
      await _scrobble(song.id, submission: false);

      Logger.info('Playing: ${song.title}');
      _seekDbg(
        'playSong ready song=${song.id} currentPos=${_audioPlayer?.position} '
        'duration=${state.duration}',
      );
      _playDbg(
        'sid=$debugSession playSong ready '
        'playerPos=${_audioPlayer?.position} '
        'buffered=${_audioPlayer?.bufferedPosition} '
        'duration=${_audioPlayer?.duration} '
        'usingLock=$_usingLockCachingSource '
        'stream=${_summarizeStreamUrl(_currentStreamUrl)}',
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
        await _playWithTranscoding(
          song,
          queue: queue,
          index: index,
          debugSession: debugSession,
        );
      }
    }
  }

  /// 使用转码方式播放（降级方案）
  Future<void> _playWithTranscoding(
    Song song, {
    List<Song>? queue,
    int? index,
    int? debugSession,
  }) async {
    try {
      final authState = _ref.read(authStateProvider);
      final libraryId = authState.currentLibrary?.id ?? '';
      final cacheService = _ref.read(audioCacheServiceProvider);
      final streamUrl = _apiClient.getStreamUrl(
        song.id,
        format: 'mp3', // 转码为 MP3
        maxBitRate: 320,
      );
      final isApplePlatform = !kIsWeb && (Platform.isIOS || Platform.isMacOS);
      final isAppleHttpStream =
          isApplePlatform && streamUrl.startsWith('http://');

      Logger.info('Retrying with MP3 transcoding: ${song.title}');
      _playDbg(
        'sid=${debugSession ?? _playDebugSession} transcoding retry '
        'song=${song.id} appleHttp=$isAppleHttpStream '
        'url=${_summarizeStreamUrl(streamUrl)}',
      );

      try {
        _playDbg(
          'sid=${debugSession ?? _playDebugSession} '
          'source=direct_stream_transcoding setUrl='
          '${_summarizeStreamUrl(streamUrl)}',
        );
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
      } catch (e) {
        final canFallbackToLockCache =
            isAppleHttpStream && libraryId.isNotEmpty;
        _playDbg(
          'sid=${debugSession ?? _playDebugSession} '
          'source=direct_stream_transcoding setUrl failed err=$e '
          'canFallbackToLockCache=$canFallbackToLockCache',
        );
        if (!canFallbackToLockCache) rethrow;

        Logger.warn(
          'Direct transcoding stream failed on Apple HTTP, retrying lock cache',
          e,
        );
        final cacheFilePath = await cacheService.getCacheFilePath(
          songId: song.id,
          libraryId: libraryId,
          quality: AudioQualityLevel.high,
        );
        // ignore: experimental_member_use
        final audioSource = LockCachingAudioSource(
          Uri.parse(streamUrl),
          cacheFile: File(cacheFilePath),
        );
        _playDbg(
          'sid=${debugSession ?? _playDebugSession} '
          'source=lock_cache_transcoding setAudioSource '
          'cachePath=$cacheFilePath',
        );
        await _audioPlayer?.setAudioSource(audioSource);
        _usingLockCachingSource = true;
        _currentStreamUrl = streamUrl;
        _setStreamContext(
          songId: song.id,
          format: 'mp3',
          maxBitRate: 320,
          seekByReloadStream: false,
        );
        _startPlayback();
        _seekDbg('source=lock_cache_transcoding mp3 song=${song.id}');
      }

      await _applyPendingSeekIfNeeded();
      final effectiveQuality = _ref.read(effectiveQualityProvider);
      state = state.copyWith(
        currentQuality: effectiveQuality,
        playbackSource: PlaybackSource.stream,
        currentBitRateKbps: _resolveCurrentBitRateKbps(
          song: song,
          quality: effectiveQuality,
          source: PlaybackSource.stream,
          maxBitRate: 320,
        ),
      );

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

  int _normalizeBitRateKbps(int? bitRate) {
    if (bitRate == null || bitRate <= 0) return 0;
    // 兼容个别场景可能传入 bps（例如 320000）。
    if (bitRate >= 10000) return bitRate ~/ 1000;
    return bitRate;
  }

  int _parseBitRateFromText(String? text) {
    if (text == null) return 0;
    final match = RegExp(
      r'(\d{2,4})\s*kbps',
      caseSensitive: false,
    ).firstMatch(text);
    if (match == null) return 0;
    return int.tryParse(match.group(1) ?? '') ?? 0;
  }

  int _resolveCurrentBitRateKbps({
    required Song song,
    required AudioQualityLevel quality,
    required PlaybackSource source,
    int? maxBitRate,
  }) {
    final songBitRate = _normalizeBitRateKbps(song.bitRate);
    if (song.isPreview) {
      if (songBitRate > 0) return songBitRate;
      return _parseBitRateFromText(song.previewQualityLabel);
    }

    switch (source) {
      case PlaybackSource.downloaded:
        return songBitRate;
      case PlaybackSource.cached:
        if (quality != AudioQualityLevel.original &&
            quality.maxBitRate != null) {
          return quality.maxBitRate!;
        }
        return songBitRate;
      case PlaybackSource.stream:
        if (maxBitRate != null && maxBitRate > 0) return maxBitRate;
        if (quality != AudioQualityLevel.original &&
            quality.maxBitRate != null) {
          return quality.maxBitRate!;
        }
        return songBitRate;
    }
  }

  /// 更新通知栏媒体信息
  void _updateMediaItem(Song song) {
    if (_audioHandler == null) return;

    final previewCover = song.previewCoverUrl?.trim();
    final coverArtUrl =
        song.isPreview && previewCover != null && previewCover.isNotEmpty
        ? previewCover
        : (song.coverArt != null
              ? _apiClient.getCoverArtUrl(song.coverArt!, size: 300)
              : null);

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

  /// 播放试听歌曲（强制单曲队列）
  Future<void> playPreviewSong(Song song) async {
    await _playPreviewSongInternal(song);
  }

  Future<void> _playPreviewSongInternal(Song song) async {
    final streamUrl = song.previewStreamUrl?.trim() ?? '';
    if (streamUrl.isEmpty) {
      NetworkErrorNotifier.show('试听链接不可用');
      return;
    }
    final previewHeaders = song.previewRequestHeaders;

    await _cacheCompletionSubscription?.cancel();
    _cacheCompletionSubscription = null;
    _clearPendingSeek();
    _usingLockCachingSource = false;
    _currentStreamUrl = null;
    _clearStreamContext();
    _clearForcedNext();
    _isHandlingCompletion = false;
    _completionHandlingSongId = null;
    _lastPolledPlayerPosition = Duration.zero;
    _stagnantPositionTicks = 0;
    _lastStagnantLogTick = -1;
    _lastIgnoredSyntheticPositionLogTick = -1;
    _syntheticPositionFallbackActive = false;
    _loggedDurationUnavailableForSong = false;
    _resetShuffleHistory(updateState: false);

    final initialDuration = song.duration != null
        ? Duration(seconds: song.duration!)
        : Duration.zero;

    state = state.copyWith(
      currentSong: song,
      queue: [song],
      currentIndex: 0,
      shuffleHistoryCount: 0,
      position: Duration.zero,
      duration: initialDuration,
      currentBitRateKbps: 0,
    );

    _updateMediaItem(song);

    try {
      _playDbg(
        'preview setUrl song=${song.id} url=${_summarizeStreamUrl(streamUrl)} '
        'headers=${previewHeaders.keys.join(",")}',
      );
      await _audioPlayer?.setUrl(streamUrl, headers: previewHeaders);
      _usingLockCachingSource = false;
      _currentStreamUrl = streamUrl;
      _setStreamContext(
        songId: song.id,
        format: null,
        maxBitRate: null,
        seekByReloadStream: true,
      );
      _startPlayback();
      await _applyPendingSeekIfNeeded();
      state = state.copyWith(
        currentQuality: AudioQualityLevel.original,
        playbackSource: PlaybackSource.stream,
        currentBitRateKbps: _resolveCurrentBitRateKbps(
          song: song,
          quality: AudioQualityLevel.original,
          source: PlaybackSource.stream,
          maxBitRate: _normalizeBitRateKbps(song.bitRate),
        ),
      );
    } catch (e) {
      Logger.error('Failed to play preview song', e);
      final hasAvailableRoute = await _refreshRoutesAndCheckAvailability();
      if (!hasAvailableRoute) {
        NetworkErrorNotifier.show('试听播放失败，当前无可用线路');
        return;
      }
      NetworkErrorNotifier.show('试听播放失败');
    }
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

    _clearForcedNext();

    if (state.shuffleEnabled) {
      final historyIndex = _takeLastValidBackHistoryIndex();
      final previousIndex = historyIndex ?? _getQueuePreviousIndex();
      if (previousIndex == null) return;

      if (historyIndex != null) {
        final currentEntry = _currentShuffleEntry(
          queue: state.queue,
          song: state.currentSong,
          index: state.currentIndex,
        );
        if (currentEntry != null) {
          _pushShuffleEntry(_shuffleForwardHistory, currentEntry);
        }
      } else {
        _shuffleForwardHistory.clear();
      }
      _syncShuffleHistoryState();
      final previousSong = state.queue[previousIndex];
      await playSong(
        previousSong,
        queue: state.queue,
        index: previousIndex,
        recordShuffleHistory: false,
        clearShuffleForwardHistory: false,
      );
      return;
    }

    final previousIndex = _getQueuePreviousIndex();
    if (previousIndex == null) return;
    final previousSong = state.queue[previousIndex];
    await playSong(previousSong, queue: state.queue, index: previousIndex);
  }

  /// 下一首
  Future<void> next() async {
    if (!state.hasNext) return;

    if (state.shuffleEnabled) {
      final forcedIndex = _resolveForcedNextIndex();
      if (forcedIndex != null) {
        final forcedSong = state.queue[forcedIndex];
        _clearForcedNext();
        await playSong(
          forcedSong,
          queue: state.queue,
          index: forcedIndex,
          recordShuffleHistory: true,
          clearShuffleForwardHistory: true,
        );
        return;
      }
      _clearForcedNext();
      final forwardIndex = _takeLastValidForwardHistoryIndex();
      if (forwardIndex != null) {
        final currentEntry = _currentShuffleEntry(
          queue: state.queue,
          song: state.currentSong,
          index: state.currentIndex,
        );
        if (currentEntry != null) {
          _pushShuffleEntry(_shuffleBackHistory, currentEntry);
        }
        _syncShuffleHistoryState();
        final forwardSong = state.queue[forwardIndex];
        await playSong(
          forwardSong,
          queue: state.queue,
          index: forwardIndex,
          recordShuffleHistory: false,
          clearShuffleForwardHistory: false,
        );
        return;
      }
      final nextIndex = _getRandomIndexExcludingCurrent();
      if (nextIndex == null) return;
      final nextSong = state.queue[nextIndex];
      await playSong(
        nextSong,
        queue: state.queue,
        index: nextIndex,
        recordShuffleHistory: true,
        clearShuffleForwardHistory: true,
      );
      return;
    }

    final nextIndex = state.currentIndex + 1;
    if (nextIndex < state.queue.length) {
      final nextSong = state.queue[nextIndex];
      await playSong(nextSong, queue: state.queue, index: nextIndex);
      return;
    }

    // 列表循环（Repeat All）回绕到首曲。
    if (state.loopMode != LoopMode.one && state.queue.isNotEmpty) {
      await skipToQueueItem(0);
    }
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

    // 可立即 seek 时，先把 UI 锚定到目标位置，避免等待底层回调期间回退到旧进度。
    if (mounted) {
      state = state.copyWith(position: target);
    }
    if (_usingLockCachingSource) {
      _syntheticPositionFallbackActive = true;
      _seekDbg('seek anchor synthetic position target=$target');
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
    if (mounted) {
      state = state.copyWith(loopMode: mode);
    }
    final modeToPersist = state.shuffleEnabled
        ? PlaybackMode.shuffle
        : (mode == LoopMode.one
              ? PlaybackMode.repeatOne
              : PlaybackMode.repeatAll);
    await _persistPlaybackMode(modeToPersist);
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
    _resetShuffleHistory(updateState: false);
    if (mounted) {
      state = state.copyWith(shuffleEnabled: enabled, shuffleHistoryCount: 0);
    }
    final modeToPersist = enabled
        ? PlaybackMode.shuffle
        : (state.loopMode == LoopMode.one
              ? PlaybackMode.repeatOne
              : PlaybackMode.repeatAll);
    await _persistPlaybackMode(modeToPersist);
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
  Future<void> setPlaybackMode(PlaybackMode mode, {bool persist = true}) async {
    switch (mode) {
      case PlaybackMode.shuffle:
        // 队列是手动切歌而非播放器内建列表。
        // 在随机模式使用 LoopMode.off，避免底层播放器自动重放当前单曲。
        await _audioPlayer?.setLoopMode(LoopMode.off);
        await _audioPlayer?.setShuffleModeEnabled(true);
        _resetShuffleHistory(updateState: false);
        if (mounted) {
          state = state.copyWith(
            loopMode: LoopMode.off,
            shuffleEnabled: true,
            shuffleHistoryCount: 0,
          );
        }
        break;
      case PlaybackMode.repeatAll:
        // 队列切歌由外层状态机驱动，Repeat All 用 LoopMode.off
        // 避免底层播放器在单音源下自动回放当前曲目。
        await _audioPlayer?.setShuffleModeEnabled(false);
        await _audioPlayer?.setLoopMode(LoopMode.off);
        _resetShuffleHistory(updateState: false);
        if (mounted) {
          state = state.copyWith(
            loopMode: LoopMode.off,
            shuffleEnabled: false,
            shuffleHistoryCount: 0,
          );
        }
        break;
      case PlaybackMode.repeatOne:
        await _audioPlayer?.setShuffleModeEnabled(false);
        await _audioPlayer?.setLoopMode(LoopMode.one);
        _resetShuffleHistory(updateState: false);
        if (mounted) {
          state = state.copyWith(
            loopMode: LoopMode.one,
            shuffleEnabled: false,
            shuffleHistoryCount: 0,
          );
        }
        break;
    }

    if (persist) {
      await _persistPlaybackMode(mode);
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

  Future<void> _restorePlaybackMode() async {
    try {
      final storedMode = await LocalStorage.getPlaybackMode();
      final mode = PlaybackMode.values.firstWhere(
        (item) => item.name == storedMode,
        orElse: () => PlaybackMode.repeatAll,
      );
      await setPlaybackMode(mode, persist: false);
      Logger.infoWithTag(_playerLogTag, 'playback mode restored: ${mode.name}');
    } catch (e) {
      Logger.warnWithTag(_playerLogTag, 'failed to restore playback mode', e);
    }
  }

  Future<void> _persistPlaybackMode(PlaybackMode mode) async {
    try {
      await LocalStorage.setPlaybackMode(mode.name);
    } catch (e) {
      Logger.warnWithTag(
        _playerLogTag,
        'failed to persist playback mode: ${mode.name}',
        e,
      );
    }
  }

  void _syncShuffleHistoryBeforeSongChange({
    required Song nextSong,
    required List<Song> nextQueue,
    required int nextIndex,
    required bool recordHistory,
    required bool clearForwardHistory,
  }) {
    if (!state.shuffleEnabled) {
      _resetShuffleHistory(updateState: false);
      _syncShuffleHistoryState();
      return;
    }

    if (!_isSameQueueBySongId(state.queue, nextQueue)) {
      _resetShuffleHistory(updateState: false);
      _syncShuffleHistoryState();
      return;
    }

    if (recordHistory) {
      final currentEntry = _currentShuffleEntry(
        queue: state.queue,
        song: state.currentSong,
        index: state.currentIndex,
      );
      if (currentEntry != null) {
        final isDifferentTrack =
            currentEntry.songId != nextSong.id ||
            currentEntry.preferredIndex != nextIndex;
        if (isDifferentTrack) {
          _pushShuffleEntry(_shuffleBackHistory, currentEntry);
        }
      }
    }

    if (clearForwardHistory) {
      _shuffleForwardHistory.clear();
    }

    _syncShuffleHistoryState();
  }

  _ShuffleHistoryEntry? _currentShuffleEntry({
    required List<Song> queue,
    required Song? song,
    required int index,
  }) {
    if (song == null || queue.isEmpty) return null;

    if (index >= 0 && index < queue.length && queue[index].id == song.id) {
      return _ShuffleHistoryEntry(songId: song.id, preferredIndex: index);
    }

    for (var i = 0; i < queue.length; i++) {
      if (queue[i].id == song.id) {
        return _ShuffleHistoryEntry(songId: song.id, preferredIndex: i);
      }
    }
    return null;
  }

  bool _isSameQueueBySongId(List<Song> currentQueue, List<Song> nextQueue) {
    if (identical(currentQueue, nextQueue)) return true;
    if (currentQueue.length != nextQueue.length) return false;

    for (var i = 0; i < currentQueue.length; i++) {
      if (currentQueue[i].id != nextQueue[i].id) {
        return false;
      }
    }
    return true;
  }

  void _pushShuffleEntry(
    List<_ShuffleHistoryEntry> stack,
    _ShuffleHistoryEntry entry,
  ) {
    if (stack.isNotEmpty) {
      final last = stack.last;
      if (last.songId == entry.songId &&
          last.preferredIndex == entry.preferredIndex) {
        return;
      }
    }

    stack.add(entry);
    if (stack.length > _maxShuffleHistoryEntries) {
      stack.removeAt(0);
    }
  }

  int? _resolveShuffleEntryIndex(_ShuffleHistoryEntry entry) {
    final queue = state.queue;
    final preferredIndex = entry.preferredIndex;
    if (preferredIndex >= 0 &&
        preferredIndex < queue.length &&
        queue[preferredIndex].id == entry.songId) {
      return preferredIndex;
    }

    for (var i = 0; i < queue.length; i++) {
      if (queue[i].id == entry.songId) {
        return i;
      }
    }
    return null;
  }

  int? _takeLastValidHistoryIndex(List<_ShuffleHistoryEntry> stack) {
    while (stack.isNotEmpty) {
      final entry = stack.removeLast();
      final resolvedIndex = _resolveShuffleEntryIndex(entry);
      if (resolvedIndex != null) {
        return resolvedIndex;
      }
    }
    return null;
  }

  int? _takeLastValidBackHistoryIndex() {
    return _takeLastValidHistoryIndex(_shuffleBackHistory);
  }

  int? _takeLastValidForwardHistoryIndex() {
    return _takeLastValidHistoryIndex(_shuffleForwardHistory);
  }

  void _resetShuffleHistory({bool updateState = true}) {
    _shuffleBackHistory.clear();
    _shuffleForwardHistory.clear();
    if (updateState) {
      _syncShuffleHistoryState();
    }
  }

  void _syncShuffleHistoryState() {
    if (!mounted) return;
    final historyCount = _shuffleBackHistory.length;
    if (state.shuffleHistoryCount == historyCount) return;
    state = state.copyWith(shuffleHistoryCount: historyCount);
  }

  int? _getQueuePreviousIndex() {
    final queue = state.queue;
    if (queue.isEmpty) return null;
    if (queue.length == 1) return 0;

    final currentIndex = state.currentIndex;
    if (currentIndex <= 0) return queue.length - 1;
    if (currentIndex >= queue.length) return queue.length - 1;
    return currentIndex - 1;
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

  int? _resolveForcedNextIndex() {
    final forcedSongId = _forcedNextSongId;
    if (forcedSongId == null) return null;

    final queue = state.queue;
    final currentIndex = state.currentIndex;

    bool isMatch(int index) {
      return index >= 0 &&
          index < queue.length &&
          index != currentIndex &&
          queue[index].id == forcedSongId;
    }

    final preferredIndex = _forcedNextIndex;
    if (preferredIndex != null && isMatch(preferredIndex)) {
      return preferredIndex;
    }

    for (var i = currentIndex + 1; i < queue.length; i++) {
      if (isMatch(i)) return i;
    }

    for (var i = 0; i < queue.length; i++) {
      if (isMatch(i)) return i;
    }
    return null;
  }

  void _clearForcedNext() {
    _forcedNextSongId = null;
    _forcedNextIndex = null;
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
    _forcedNextSongId = song.id;
    _forcedNextIndex = insertIndex;
  }

  /// 清空队列
  Future<void> clearQueue() async {
    _clearForcedNext();
    _resetShuffleHistory(updateState: false);

    final currentSong = state.currentSong;
    if (currentSong != null) {
      // 保留当前正在播放/暂停的歌曲，仅清空后续队列。
      state = state.copyWith(
        queue: [currentSong],
        currentIndex: 0,
        shuffleHistoryCount: 0,
      );
      return;
    }

    await _audioPlayer?.stop();
    await _audioHandler?.stop();
    state = state.copyWith(
      currentSong: null,
      queue: const [],
      currentIndex: 0,
      shuffleHistoryCount: 0,
      isPlaying: false,
      processingState: ProcessingState.idle,
      position: Duration.zero,
      duration: Duration.zero,
      currentQuality: null,
      playbackSource: null,
      currentBitRateKbps: 0,
    );
  }

  /// 从队列移除
  void removeFromQueue(int index) {
    if (index < 0 || index >= state.queue.length) return;

    _clearForcedNext();
    _resetShuffleHistory(updateState: false);

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
        shuffleHistoryCount: 0,
        currentBitRateKbps: 0,
      );
    } else {
      // 调整当前索引
      final newIndex = index < state.currentIndex
          ? state.currentIndex - 1
          : state.currentIndex;
      state = state.copyWith(
        queue: newQueue,
        currentIndex: newIndex,
        shuffleHistoryCount: 0,
      );
    }
  }

  /// 歌曲播放完成
  Future<void> _onSongCompleted(String completedSongId) async {
    if (state.currentSong?.id != completedSongId) return;

    // 不阻塞切歌流程，避免完成态停留过久导致竞态。
    if (state.currentSong?.isPreview != true) {
      unawaited(_scrobble(completedSongId, submission: true));
    }

    // 随机模式优先：从队列中随机到下一首，不走 loopMode 分支。
    if (state.shuffleEnabled) {
      if (state.queue.length > 1) {
        _seekDbg('completed -> shuffle next song=$completedSongId');
        await next();
      }
      return;
    }

    // 根据循环模式决定下一步
    if (state.loopMode == LoopMode.one) {
      // 单曲循环
      _seekDbg('completed -> repeat one song=$completedSongId');
      await _audioPlayer?.seek(Duration.zero);
      _startPlayback();
    } else if (state.hasNext) {
      // 播放下一首
      _seekDbg('completed -> sequential next song=$completedSongId');
      await next();
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

  Future<void> _recordMobileCacheSavedBytesForHit({
    required String songId,
    required String cacheFilePath,
    required String libraryId,
  }) async {
    if (libraryId.isEmpty) return;

    try {
      final networkType = _ref
          .read(connectivityMonitorProvider)
          .currentNetworkType;
      if (networkType != NetworkType.mobile) return;

      final cacheFile = File(cacheFilePath);
      if (!await cacheFile.exists()) return;

      final savedBytes = await cacheFile.length();
      if (savedBytes <= 0) return;

      await LocalStorage.addMobileCacheSavedBytes(
        libraryId: libraryId,
        bytes: savedBytes,
      );
      Logger.infoWithTag(
        _playerLogTag,
        'mobile cache hit recorded song=$songId savedBytes=$savedBytes',
      );
    } catch (e) {
      Logger.warnWithTag(
        _playerLogTag,
        'failed to record mobile cache hit savings',
        e,
      );
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
      try {
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
      } catch (e) {
        Logger.warn('Reload-stream seek failed, fallback to plain seek', e);
        await player.seek(target);
        return;
      }
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
      final isAppleHttpStream = _isAppleHttpUrl(_currentStreamUrl);
      if (isAppleHttpStream) {
        Logger.warn(
          'Lock cache seek drift detected on Apple HTTP '
          '(target=$target, actual=$actual), trying lock-cache reload',
        );
        try {
          final reloaded = await _trySeekByReloadingLockCache(
            player: player,
            target: target,
            shouldResume: shouldResume,
          );
          if (reloaded) return;
        } catch (e) {
          Logger.warn('Lock-cache reload seek failed on Apple HTTP', e);
        }
        _seekDbg(
          'seek fallback lock-cache reload unavailable, '
          'keep synthetic position target=$target',
        );
        _syntheticPositionFallbackActive = true;
        if (mounted) {
          state = state.copyWith(position: target);
        }
        return;
      }

      Logger.warn(
        'Lock cache seek drift detected (target=$target, actual=$actual), '
        'switching to direct stream source',
      );
      _seekDbg(
        'seek fallback -> direct stream initialPosition=$target '
        'wasPlaying=$shouldResume',
      );
      try {
        await player.setUrl(_currentStreamUrl!, initialPosition: target);
        _usingLockCachingSource = false;
        if (shouldResume) {
          await player.play();
        }
        _seekDbg('seek fallback completed now=${player.position}');
        return;
      } catch (e) {
        Logger.warn('Seek fallback direct stream failed, keep lock cache', e);
        _seekDbg(
          'seek fallback direct stream failed, '
          'keep synthetic position target=$target',
        );
        _syntheticPositionFallbackActive = true;
        if (mounted) {
          state = state.copyWith(position: target);
        }
        return;
      }
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

  Future<bool> _trySeekByReloadingLockCache({
    required AudioPlayer player,
    required Duration target,
    required bool shouldResume,
  }) async {
    final songId = _currentStreamSongId ?? state.currentSong?.id;
    if (songId == null) return false;

    final authState = _ref.read(authStateProvider);
    final libraryId = authState.currentLibrary?.id ?? '';
    if (libraryId.isEmpty) return false;

    final offset = target.inSeconds;
    final reloadUrl = _apiClient.getStreamUrl(
      songId,
      maxBitRate: _currentStreamMaxBitRate,
      format: _currentStreamFormat,
      timeOffset: offset,
    );

    final cacheService = _ref.read(audioCacheServiceProvider);
    final quality = state.currentQuality ?? AudioQualityLevel.original;
    final cacheFilePath = await cacheService.getCacheFilePath(
      songId: songId,
      libraryId: libraryId,
      quality: quality,
    );

    _seekDbg(
      'seek fallback -> lock-cache reload target=$target '
      'offsetSec=$offset format=$_currentStreamFormat '
      'maxBitRate=$_currentStreamMaxBitRate quality=${quality.name}',
    );
    _playDbg(
      'seek_lock_cache_reload '
      'url=${_summarizeStreamUrl(reloadUrl)} cachePath=$cacheFilePath',
    );

    // ignore: experimental_member_use
    final audioSource = LockCachingAudioSource(
      Uri.parse(reloadUrl),
      cacheFile: File(cacheFilePath),
    );
    await player.setAudioSource(audioSource);
    _usingLockCachingSource = true;
    _currentStreamUrl = reloadUrl;
    _setStreamContext(
      songId: songId,
      format: _currentStreamFormat,
      maxBitRate: _currentStreamMaxBitRate,
      seekByReloadStream: false,
    );
    if (shouldResume) {
      _startPlayback();
    }

    await Future<void>.delayed(const Duration(milliseconds: 220));
    final actual = player.position;
    final drift = (actual - target).inMilliseconds.abs();
    _seekDbg(
      'seek fallback lock-cache reload verify target=$target '
      'actual=$actual driftMs=$drift',
    );

    if (actual <= const Duration(milliseconds: 50)) {
      // 底层 position 仍可能卡 0，保持 UI 在用户拖动位置，后续由合成进度推进。
      _syntheticPositionFallbackActive = true;
      if (mounted) {
        state = state.copyWith(position: target);
      }
      _seekDbg(
        'seek fallback lock-cache reload position still zero, '
        'keep synthetic position target=$target',
      );
    }
    return true;
  }

  bool _isAppleHttpUrl(String? url) {
    if (url == null || url.isEmpty || kIsWeb) return false;
    return (Platform.isIOS || Platform.isMacOS) && url.startsWith('http://');
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

  void _startPositionPolling(AudioPlayer player) {
    _positionPollTimer?.cancel();
    _positionPollTimer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      if (!mounted) return;
      if (state.currentSong == null) return;

      final playerPos = player.position;
      final processing = player.processingState;
      final isReadyPlaying =
          player.playing && processing == ProcessingState.ready;

      final deltaFromLast = (playerPos - _lastPolledPlayerPosition)
          .inMilliseconds
          .abs();
      if (deltaFromLast <= 150) {
        _stagnantPositionTicks += 1;
      } else {
        _stagnantPositionTicks = 0;
      }
      _lastPolledPlayerPosition = playerPos;

      // 正常情况下用底层播放器位置对齐 UI 进度。
      final drift = (playerPos - state.position).inMilliseconds.abs();
      final keepSyntheticProgress =
          _syntheticPositionFallbackActive &&
          _usingLockCachingSource &&
          isReadyPlaying &&
          playerPos <= const Duration(milliseconds: 50);
      final preserveSyntheticPosition =
          _syntheticPositionFallbackActive &&
          _usingLockCachingSource &&
          state.position > const Duration(milliseconds: 250) &&
          (!isReadyPlaying ||
              playerPos + const Duration(seconds: 5) < state.position);

      if (drift >= 250 &&
          !keepSyntheticProgress &&
          !preserveSyntheticPosition) {
        final canDeactivateSynthetic =
            _syntheticPositionFallbackActive &&
            isReadyPlaying &&
            playerPos > Duration.zero &&
            drift <= 3000;
        if (canDeactivateSynthetic) {
          _syntheticPositionFallbackActive = false;
          _seekDbg('position fallback deactivated, player position recovered');
        }
        state = state.copyWith(position: playerPos);
        return;
      }
      if (drift >= 250 &&
          preserveSyntheticPosition &&
          _stagnantPositionTicks != _lastStagnantLogTick &&
          _stagnantPositionTicks % 6 == 0) {
        _playDbg(
          'position sync skipped to preserve synthetic '
          'playerPos=$playerPos statePos=${state.position} '
          'driftMs=$drift playing=${player.playing} '
          'processing=${processing.name} song=${state.currentSong?.id}',
        );
      }
      if (drift >= 250 &&
          keepSyntheticProgress &&
          _stagnantPositionTicks != _lastStagnantLogTick &&
          _stagnantPositionTicks % 6 == 0) {
        _playDbg(
          'position drift sync skipped while synthetic active '
          'playerPos=$playerPos statePos=${state.position} '
          'driftMs=$drift song=${state.currentSong?.id}',
        );
      }

      // iOS + LockCachingAudioSource 某些流上 position 可能卡在 0。
      // 当确认持续卡住时，按时间片推进 UI 进度，避免进度条一直 0:00。
      final shouldUseSyntheticPosition =
          _usingLockCachingSource &&
          isReadyPlaying &&
          playerPos <= const Duration(milliseconds: 50) &&
          state.duration > Duration.zero &&
          _stagnantPositionTicks >= 6;
      if (shouldUseSyntheticPosition &&
          _stagnantPositionTicks != _lastStagnantLogTick &&
          _stagnantPositionTicks % 6 == 0) {
        _lastStagnantLogTick = _stagnantPositionTicks;
        _playDbg(
          'position_stagnant ticks=$_stagnantPositionTicks '
          'playerPos=$playerPos statePos=${state.position} '
          'buffered=${player.bufferedPosition} duration=${state.duration} '
          'processing=${processing.name} playing=${player.playing} '
          'song=${state.currentSong?.id} '
          'format=$_currentStreamFormat maxBitRate=$_currentStreamMaxBitRate '
          'stream=${_summarizeStreamUrl(_currentStreamUrl)}',
        );
      }
      if (!shouldUseSyntheticPosition) return;

      final next = _normalizeSeekPosition(
        state.position + const Duration(milliseconds: 500),
      );
      if (next <= state.position) return;

      if (!_syntheticPositionFallbackActive) {
        _syntheticPositionFallbackActive = true;
        _seekDbg(
          'position fallback activated for lock_cache source '
          'song=${state.currentSong?.id}',
        );
      }
      state = state.copyWith(position: next);
    });
  }

  void _seekDbg(String message) {
    Logger.info('[SEEKDBG] $message');
  }

  void _playDbg(String message) {
    Logger.infoWithTag(_playDbgTag, message);
  }

  String _summarizeStreamUrl(String? url) {
    if (url == null || url.isEmpty) return 'none';
    try {
      final uri = Uri.parse(url);
      final host = uri.hasPort ? '${uri.host}:${uri.port}' : uri.host;
      final q = uri.queryParameters;
      final id = q['id'] ?? '-';
      final format = q['format'] ?? '-';
      final maxBitRate = q['maxBitRate'] ?? '-';
      final timeOffset = q['timeOffset'] ?? '-';
      return '${uri.scheme}://$host${uri.path} '
          'id=$id format=$format maxBitRate=$maxBitRate timeOffset=$timeOffset';
    } catch (_) {
      return 'invalid_url';
    }
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
    final maxBitRate = effectiveQuality.maxBitRate;
    if (maxBitRate != null) {
      _seekDbg('pre_cache_skip song=${nextSong.id} reason=bitrate-limited');
      return;
    }

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
        maxBitRate: maxBitRate,
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
    _positionPollTimer?.cancel();
    _cacheCompletionSubscription?.cancel();
    // Check if initialized/assigned before disposing
    // Since it was 'late', we can't check.
    // Converting to nullable field:
    _audioPlayer?.dispose();
    _audioHandler?.stop(); // Ensure handler is stopped too
    super.dispose();
  }
}
