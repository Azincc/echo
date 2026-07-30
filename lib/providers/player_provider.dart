import 'dart:async';
import 'dart:math';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb, visibleForTesting;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart' hide PlayerState;
import '../data/models/song.dart';
import '../data/models/audio_quality.dart';
import '../data/models/server_address.dart';
import '../data/sources/subsonic_api_client.dart';
import '../data/sources/local_storage.dart';
import '../data/repositories/music_repository.dart';

import '../core/network/connectivity_monitor.dart';
import '../core/platform/platform_file_bridge.dart';
import '../core/utils/logger.dart';
import '../core/utils/network_error_notifier.dart';
import '../core/services/audio_handler_service.dart';

import 'music_provider.dart';
import 'api_provider.dart';
import 'audio_quality_provider.dart';
import 'download_provider.dart';
import 'audio_cache_provider.dart';
import 'crossfade_provider.dart';
import 'gd_music_provider.dart';
import '../providers/auth_provider.dart';

export 'player/player_state.dart';
export 'player/favorite_scrobble_handler.dart';
export 'player/cache_manager_handler.dart';
import 'player/player_state.dart';
import 'player/favorite_scrobble_handler.dart';
import 'player/cache_manager_handler.dart';
import 'player/player_seek_policy.dart';
import 'player/transcoded_stream_seek.dart';

const _playerLogTag = 'PLAYER';
const _playDbgTag = 'PLAYDBG';

bool get _isDesktopPlatform =>
    !kIsWeb &&
    (defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.macOS);

bool get _isApplePlatform =>
    !kIsWeb &&
    (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS);

/// 将解析后的试听元数据写回原队列项，同时保留其它正式/试听歌曲。
@visibleForTesting
({List<Song> queue, int index}) resolvePreviewPlaybackQueue({
  required List<Song> queue,
  required int preferredIndex,
  required Song unresolvedSong,
  required Song resolvedSong,
}) {
  final nextQueue = List<Song>.of(queue);
  var nextIndex = preferredIndex;

  if (nextQueue.isEmpty) {
    return (queue: <Song>[resolvedSong], index: 0);
  }

  final preferredIndexMatches =
      nextIndex >= 0 &&
      nextIndex < nextQueue.length &&
      nextQueue[nextIndex].id == unresolvedSong.id;
  if (!preferredIndexMatches) {
    final matchedIndex = nextQueue.indexWhere(
      (item) => item.id == unresolvedSong.id,
    );
    if (matchedIndex >= 0) {
      nextIndex = matchedIndex;
    } else {
      nextIndex = nextIndex.clamp(0, nextQueue.length);
      nextQueue.insert(nextIndex, resolvedSong);
      return (queue: nextQueue, index: nextIndex);
    }
  }

  nextQueue[nextIndex] = resolvedSong;
  return (queue: nextQueue, index: nextIndex);
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
  StreamSubscription? _downloadProgressSubscription;
  StreamSubscription<NetworkType>? _networkTypeSubscription;
  final Random _random = Random();
  final List<ShuffleHistoryEntry> _shuffleBackHistory = <ShuffleHistoryEntry>[];
  final List<ShuffleHistoryEntry> _shuffleForwardHistory =
      <ShuffleHistoryEntry>[];
  Duration? _pendingSeekPosition;
  String? _pendingSeekSongId;
  bool _usingLockCachingSource = false;
  String? _currentStreamUrl;
  String? _currentStreamSongId;
  String? _currentStreamFormat;
  int? _currentStreamMaxBitRate;
  String? _loadedSourceSongId;
  int _sourceGeneration = 0;
  int _seekRequestGeneration = 0;
  int _transportRequestGeneration = 0;
  int? _activeSeekGeneration;
  String? _activeSeekSongId;
  bool _isApplyingPendingSeek = false;
  bool _seekByReloadStream = false;
  Duration _sourcePositionOffset = Duration.zero;
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
  Timer? _fadeTimer;
  Completer<void>? _fadeCompleter;
  static const Duration _playbackSessionPersistInterval = Duration(seconds: 2);
  Timer? _playbackSessionPersistTimer;
  bool _isPersistingPlaybackSession = false;
  bool _isRestoringPlaybackSession = false;
  NetworkType _lastObservedNetworkType = NetworkType.none;
  bool _retryCurrentPlaybackOnReconnect = false;
  bool _retryingCurrentPlayback = false;
  String? _pendingRetrySongId;
  bool _pendingRetryIsPreview = false;
  bool _pendingRetryAutoPlay = true;

  // ── Handlers ──────────────────────────────────────────────────────────────
  late final FavoriteScrobbleHandler _favoriteHandler;
  late final CacheManagerHandler _cacheHandler;

  /// 动态获取最新的 API client
  SubsonicApiClient get _apiClient => _ref.read(subsonicApiClientProvider);

  /// 动态获取最新的 MusicRepository
  MusicRepository get _musicRepository =>
      _ref.read(musicRepositoryProvider) ?? MusicRepository(_apiClient);

  PlayerNotifier(this._ref) : super(PlayerState()) {
    _favoriteHandler = FavoriteScrobbleHandler(_ref);
    _cacheHandler = CacheManagerHandler(_ref);
    _initConnectivityRetryHandling();
    _init();
  }

  @override
  set state(PlayerState value) {
    super.state = value;
    _schedulePersistPlaybackSession();
  }

  /// 初始化播放器
  void _init() async {
    AudioPlayer player;

    // 初始化 AudioService（仅在移动平台，桌面端不支持且可能干扰播放）
    try {
      if (_isDesktopPlatform) throw UnsupportedError('Desktop platform');
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
      _audioHandler?.onSeek = seek;
    } catch (e) {
      Logger.warn('AudioService not available: $e');
      player = AudioPlayer(
        audioLoadConfiguration: const AudioLoadConfiguration(
          androidLoadControl: AndroidLoadControl(
            minBufferDuration: Duration(minutes: 10),
            maxBufferDuration: Duration(minutes: 15),
            bufferForPlaybackDuration: Duration(seconds: 5),
            bufferForPlaybackAfterRebufferDuration: Duration(seconds: 10),
          ),
          darwinLoadControl: DarwinLoadControl(
            preferredForwardBufferDuration: Duration(minutes: 10),
          ),
        ),
      );
    }

    _audioPlayer = player;

    // 监听播放状态
    player.playingStream.listen((isPlaying) {
      _playDbg(
        'playingStream playing=$isPlaying '
        'processing=${player.processingState.name} '
        'sourcePosition=${player.position} '
        'position=${_logicalPlayerPosition(player.position)} '
        'sourceBuffered=${player.bufferedPosition} '
        'buffered=${_logicalPlayerPosition(player.bufferedPosition)} '
        'song=${state.currentSong?.id}',
      );
      if (mounted) state = state.copyWith(isPlaying: isPlaying);
    });

    // 监听播放进度
    player.positionStream.listen((position) {
      if (!mounted) return;

      // A queued seek is the user's latest intent. While the next source is
      // still loading, just_audio may continue to report the previous source
      // position; do not let that stale value make the scrubber jump back.
      if (_shouldPreserveSeekPosition()) {
        return;
      }

      final logicalPosition = _logicalPlayerPosition(position);

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
                      'sourcePos=$position logicalPos=$logicalPosition '
                      'statePos=${state.position} '
                      'song=${state.currentSong?.id}'
                : 'positionStream ignored_while_synthetic '
                      'sourcePos=$position logicalPos=$logicalPosition '
                      'statePos=${state.position} '
                      'song=${state.currentSong?.id}',
          );
        }
        return;
      }

      state = state.copyWith(position: logicalPosition);
    });
    _startPositionPolling(player);

    // 监听缓冲进度（仅在在线流式播放且非 LockCachingAudioSource 模式下使用）
    player.bufferedPositionStream.listen((buffered) {
      if (mounted && _downloadProgressSubscription == null) {
        if (_shouldPreserveSeekPosition()) return;
        // 本地文件（下载/缓存）的 bufferedPositionStream 仅反映解码缓冲窗口，
        // 不代表文件可用进度，应跳过以保持 100%。
        final source = state.playbackSource;
        if (source == PlaybackSource.downloaded ||
            source == PlaybackSource.cached) {
          return;
        }
        // 当使用 LockCachingAudioSource 时,由 downloadProgressStream 更新 bufferedPosition
        // 避免播放器解码缓冲区（seek 后会重置）覆盖实际下载进度
        state = state.copyWith(
          bufferedPosition: _logicalPlayerPosition(buffered),
        );
      }
    });
    // 监听总时长
    player.durationStream.listen((duration) {
      if (mounted) {
        if (duration != null && duration > Duration.zero) {
          if (_shouldPreserveSeekPosition() && _seekByReloadStream) {
            _playDbg(
              'durationStream ignored during reload seek duration=$duration '
              'song=${state.currentSong?.id}',
            );
            return;
          }
          // A timeOffset stream may expose either the remaining duration or
          // the original X-Content-Duration. The song timeline is already
          // known, so do not replace it with a source-relative duration.
          if (_sourcePositionOffset > Duration.zero &&
              state.duration > Duration.zero) {
            _loggedDurationUnavailableForSong = false;
            _playDbg(
              'durationStream kept logical duration=${state.duration} '
              'sourceDuration=$duration offset=$_sourcePositionOffset '
              'song=${state.currentSong?.id}',
            );
            return;
          }
          // 如果流能提供时长，优先使用流的时长（更准确）
          state = state.copyWith(
            duration: _sourcePositionOffset > Duration.zero
                ? duration + _sourcePositionOffset
                : duration,
          );
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
          'sourcePosition=${player.position} '
          'position=${_logicalPlayerPosition(player.position)} '
          'sourceBuffered=${player.bufferedPosition} '
          'buffered=${_logicalPlayerPosition(player.bufferedPosition)} '
          'duration=${player.duration} '
          'sourceOffset=$_sourcePositionOffset '
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
    await _restorePlaybackSession();
  }

  void _initConnectivityRetryHandling() {
    final connectivityMonitor = _ref.read(connectivityMonitorProvider);
    _lastObservedNetworkType = connectivityMonitor.currentNetworkType;
    _networkTypeSubscription?.cancel();
    _networkTypeSubscription = connectivityMonitor.networkTypeStream.listen(
      (networkType) {
        final previousType = _lastObservedNetworkType;
        _lastObservedNetworkType = networkType;
        if (networkType == NetworkType.none || previousType == networkType) {
          return;
        }
        unawaited(
          _retryCurrentPlaybackIfNeeded(
            networkType: networkType,
            previousType: previousType,
          ),
        );
      },
      onError: (Object error, StackTrace stackTrace) {
        Logger.warnWithTag(
          _playerLogTag,
          'connectivity retry listener error',
          error,
        );
      },
    );
  }

  void _scheduleCurrentPlaybackRetry({
    required Song song,
    required bool isPreview,
    required bool autoPlay,
  }) {
    _retryCurrentPlaybackOnReconnect = true;
    _pendingRetrySongId = song.id;
    _pendingRetryIsPreview = isPreview;
    _pendingRetryAutoPlay = autoPlay;
    _playDbg(
      'schedule reconnect retry song=${song.id} preview=$isPreview '
      'autoPlay=$autoPlay network=$_lastObservedNetworkType',
    );
  }

  void _clearCurrentPlaybackRetry({
    String? reason,
    bool preserveRetrying = false,
  }) {
    final hadRetryState =
        _retryCurrentPlaybackOnReconnect ||
        _retryingCurrentPlayback ||
        _pendingRetrySongId != null;
    if (hadRetryState && reason != null) {
      _playDbg(
        'clear reconnect retry reason=$reason '
        'song=$_pendingRetrySongId retrying=$_retryingCurrentPlayback',
      );
    }
    _retryCurrentPlaybackOnReconnect = false;
    _pendingRetrySongId = null;
    _pendingRetryIsPreview = false;
    _pendingRetryAutoPlay = true;
    if (!preserveRetrying) {
      _retryingCurrentPlayback = false;
    }
  }

  Future<void> _retryCurrentPlaybackIfNeeded({
    required NetworkType networkType,
    required NetworkType previousType,
  }) async {
    if (!_retryCurrentPlaybackOnReconnect || _retryingCurrentPlayback) {
      return;
    }

    final song = state.currentSong;
    if (song == null) {
      _clearCurrentPlaybackRetry(reason: 'no_current_song');
      return;
    }

    if (_pendingRetrySongId != null && song.id != _pendingRetrySongId) {
      _clearCurrentPlaybackRetry(reason: 'current_song_changed');
      return;
    }

    _retryingCurrentPlayback = true;
    final retryAutoPlay = _pendingRetryAutoPlay;
    final retryPreview = _pendingRetryIsPreview || song.isPreview;
    _playDbg(
      'retry current playback on connectivity change '
      '$previousType->$networkType song=${song.id} preview=$retryPreview',
    );

    try {
      final retryQueue = state.queue.isEmpty ? [song] : state.queue;
      var retryIndex = state.currentIndex;
      final currentIndexMatchesSong =
          retryIndex >= 0 &&
          retryIndex < retryQueue.length &&
          retryQueue[retryIndex].id == song.id;
      if (!currentIndexMatchesSong) {
        final matchedIndex = retryQueue.indexWhere(
          (item) => item.id == song.id,
        );
        retryIndex = matchedIndex >= 0 ? matchedIndex : 0;
      }

      await playSong(
        song,
        queue: retryQueue,
        index: retryIndex,
        autoPlay: retryAutoPlay,
      );
    } catch (e) {
      Logger.warnWithTag(
        _playerLogTag,
        'reconnect retry failed for current playback',
        e,
      );
    } finally {
      _retryingCurrentPlayback = false;
    }
  }

  /// 播放单曲
  Future<void> playSong(
    Song song, {
    List<Song>? queue,
    int? index,
    bool recordShuffleHistory = false,
    bool clearShuffleForwardHistory = false,
    bool autoPlay = true,
  }) async {
    final playQueue = queue ?? [song];
    final playIndex = index ?? 0;
    _syncShuffleHistoryBeforeSongChange(
      nextSong: song,
      nextQueue: playQueue,
      nextIndex: playIndex,
      recordHistory: recordShuffleHistory,
      clearForwardHistory: clearShuffleForwardHistory,
    );

    if (song.isPreview) {
      await _playPreviewSongInternal(
        song,
        queue: playQueue,
        index: playIndex,
        autoPlay: autoPlay,
      );
      return;
    }

    final debugSession = ++_playDebugSession;
    _transportRequestGeneration += 1;
    bool isCurrentSession() =>
        _isPlaybackContextCurrent(session: debugSession, songId: song.id);
    _clearCurrentPlaybackRetry(
      reason: 'play_song_started',
      preserveRetrying: _retryingCurrentPlayback,
    );
    try {
      _seekDbg(
        'playSong start song=${song.id} title="${song.title}" '
        'suffix=${song.suffix} duration=${song.duration}s '
        'queue=${playQueue.length} index=$playIndex autoPlay=$autoPlay',
      );
      _playDbg(
        'sid=$debugSession playSong enter song=${song.id} '
        'suffix=${song.suffix} durationSec=${song.duration} '
        'queue=${playQueue.length} index=$playIndex',
      );

      // 淡出当前歌曲（如果启用了淡入淡出）
      await _fadeOut(debugSession);
      if (_playDebugSession != debugSession) return;
      if (!autoPlay) {
        _cancelFade();
        await _audioPlayer?.pause();
        await _audioHandler?.pause();
        if (_playDebugSession != debugSession) return;
      }

      _downloadProgressSubscription?.cancel();
      _downloadProgressSubscription = null;
      _clearPendingSeek();
      _usingLockCachingSource = false;
      _currentStreamUrl = null;
      _invalidateLoadedSource(reason: 'play_song_started');
      _invalidateSeekRequests();
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
      _scheduleSongRemoteRefresh(song, debugSession);

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
      if (downloadedPath != null && fileExistsSync(downloadedPath)) {
        Logger.info('Playing from download: ${song.title}');
        _playDbg(
          'sid=$debugSession source=download setFilePath path=$downloadedPath',
        );
        final sourceReady = await _replaceLoadedSource(
          songId: song.id,
          label: 'download',
          ownsSource: () =>
              _isPlaybackContextCurrent(session: debugSession, songId: song.id),
          setSource: (player) async {
            await player.setFilePath(downloadedPath);
          },
        );
        if (!sourceReady) return;
        _replaceDownloadProgressSubscription(null);
        _usingLockCachingSource = false;
        _currentStreamUrl = null;
        _clearStreamContext();
        await _syncPlaybackAfterSourceReady(autoPlay: autoPlay);
        if (!isCurrentSession()) return;
        await _applyPendingSeekIfNeeded();
        if (!isCurrentSession()) return;
        _seekDbg('source=download path=$downloadedPath');
        state = state.copyWith(
          currentQuality: AudioQualityLevel.original,
          playbackSource: PlaybackSource.downloaded,
          currentBitRateKbps: _resolveCurrentBitRateKbps(
            song: song,
            quality: AudioQualityLevel.original,
            source: PlaybackSource.downloaded,
          ),
          bufferedPosition: initialDuration,
        );
        _clearCurrentPlaybackRetry(reason: 'playback_ready_downloaded');
        if (autoPlay) {
          await _scrobble(song.id, submission: false);
          if (!isCurrentSession()) return;
          _preCacheNextSong();
        }
        return;
      }

      // 2. 检查是否已缓存
      final cachedPath = await cacheService.getCachedPath(
        songId: song.id,
        libraryId: libraryId,
        quality: effectiveQuality,
      );
      if (cachedPath != null && fileExistsSync(cachedPath)) {
        Logger.info('Playing from cache: ${song.title}');
        _playDbg(
          'sid=$debugSession source=cache setFilePath path=$cachedPath '
          'quality=${effectiveQuality.name}',
        );
        final sourceReady = await _replaceLoadedSource(
          songId: song.id,
          label: 'cache',
          ownsSource: () =>
              _isPlaybackContextCurrent(session: debugSession, songId: song.id),
          setSource: (player) async {
            await player.setFilePath(cachedPath);
          },
        );
        if (!sourceReady) return;
        _usingLockCachingSource = false;
        _currentStreamUrl = null;
        _clearStreamContext();
        await _syncPlaybackAfterSourceReady(autoPlay: autoPlay);
        if (!isCurrentSession()) return;
        await _applyPendingSeekIfNeeded();
        if (!isCurrentSession()) return;
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
          bufferedPosition: initialDuration,
        );
        _clearCurrentPlaybackRetry(reason: 'playback_ready_cached');
        if (autoPlay) {
          await _scrobble(song.id, submission: false);
          if (!isCurrentSession()) return;
          unawaited(
            _recordMobileCacheSavedBytesForHit(
              songId: song.id,
              cacheFilePath: cachedPath,
              libraryId: libraryId,
            ),
          );
          _preCacheNextSong();
        }
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
      final useServerTimeOffsetSeek = shouldUseServerTimeOffsetSeek(
        requestedFormat: transcodeFormat,
        requestedMaxBitRate: maxBitRate,
        sourceFormat: song.suffix,
        sourceBitRate: song.bitRate,
      );

      final activeAddress = await _ensureActiveAddressForPlayback(
        session: debugSession,
        reason: 'stream_playback',
      );
      if (_playDebugSession != debugSession) {
        _playDbg(
          'sid=$debugSession abandoned while waiting for active address '
          '(current=$_playDebugSession)',
        );
        return;
      }
      if (activeAddress == null) {
        _scheduleCurrentPlaybackRetry(
          song: song,
          isPreview: false,
          autoPlay: autoPlay,
        );
        NetworkErrorNotifier.show('网络异常，当前无可用线路');
        return;
      }

      final streamUrl = _buildStreamUrlOrThrow(
        song.id,
        session: debugSession,
        source: 'primary_stream',
        format: transcodeFormat,
        maxBitRate: maxBitRate,
      );
      final isAppleHttpStream =
          _isApplePlatform && streamUrl.startsWith('http://');
      _playDbg(
        'sid=$debugSession stream_resolved '
        'quality=${effectiveQuality.name} transcode=${transcodeFormat ?? 'none'} '
        'maxBitRate=${maxBitRate ?? 'none'} appleHttp=$isAppleHttpStream '
        'timeOffsetSeek=$useServerTimeOffsetSeek '
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
          // ignore: experimental_member_use
          final audioSource = LockCachingAudioSource(
            Uri.parse(streamUrl),
            cacheFile: fileForPath(cacheFilePath),
          );
          _playDbg(
            'sid=$debugSession source=lock_cache setAudioSource '
            'cachePath=$cacheFilePath',
          );
          final sourceReady = await _replaceLoadedSource(
            songId: song.id,
            label: 'lock_cache',
            ownsSource: () => _isPlaybackContextCurrent(
              session: debugSession,
              songId: song.id,
            ),
            setSource: (player) async {
              await player.setAudioSource(audioSource);
            },
          );
          if (!sourceReady) return;
          _usingLockCachingSource = true;
          _currentStreamUrl = streamUrl;
          _setStreamContext(
            songId: song.id,
            format: transcodeFormat,
            maxBitRate: maxBitRate,
            seekByReloadStream: false,
          );
          await _syncPlaybackAfterSourceReady(autoPlay: autoPlay);
          if (!isCurrentSession()) return;
          _seekDbg(
            'source=lock_cache stream quality=${effectiveQuality.name} '
            'format=${transcodeFormat ?? song.suffix} '
            'processing=${_audioPlayer?.processingState.name}',
          );
          await _applyPendingSeekIfNeeded();
          if (!isCurrentSession()) return;

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

          // 监听下载进度：更新缓冲进度条 + 下载完成时注册缓存
          _downloadProgressSubscription?.cancel();
          final capSongId = song.id;
          final capLibraryId = libraryId;
          final capQuality = effectiveQuality;
          final capCacheFilePath = cacheFilePath;
          // ignore: experimental_member_use
          _downloadProgressSubscription = audioSource.downloadProgressStream
              .listen((progress) {
                if (mounted && state.duration > Duration.zero) {
                  final buffered = Duration(
                    milliseconds: (state.duration.inMilliseconds * progress)
                        .round(),
                  );
                  state = state.copyWith(bufferedPosition: buffered);
                }
                // 下载完成 → 注册缓存
                if (progress >= 1.0) {
                  _registerCacheFromFile(
                    capCacheFilePath,
                    capSongId,
                    capLibraryId,
                    capQuality,
                  );
                }
              });
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
          final sourceReady = await _replaceLoadedSource(
            songId: song.id,
            label: 'direct_stream_from_lock_fallback',
            ownsSource: () => _isPlaybackContextCurrent(
              session: debugSession,
              songId: song.id,
            ),
            setSource: (player) async {
              await player.setUrl(streamUrl);
            },
          );
          if (!sourceReady) return;
          _usingLockCachingSource = false;
          _currentStreamUrl = streamUrl;
          _setStreamContext(
            songId: song.id,
            format: transcodeFormat,
            maxBitRate: maxBitRate,
            seekByReloadStream: useServerTimeOffsetSeek,
          );
          await _syncPlaybackAfterSourceReady(autoPlay: autoPlay);
          if (!isCurrentSession()) return;
          _seekDbg(
            'source=direct_stream_from_lock_fallback quality=${effectiveQuality.name} '
            'format=${transcodeFormat ?? song.suffix}',
          );
          await _applyPendingSeekIfNeeded();
          if (!isCurrentSession()) return;
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
          final sourceReady = await _replaceLoadedSource(
            songId: song.id,
            label: 'direct_stream',
            ownsSource: () => _isPlaybackContextCurrent(
              session: debugSession,
              songId: song.id,
            ),
            setSource: (player) async {
              await player.setUrl(streamUrl);
            },
          );
          if (!sourceReady) return;
          _usingLockCachingSource = false;
          _currentStreamUrl = streamUrl;
          _setStreamContext(
            songId: song.id,
            format: transcodeFormat,
            maxBitRate: maxBitRate,
            seekByReloadStream: useServerTimeOffsetSeek,
          );
          await _syncPlaybackAfterSourceReady(autoPlay: autoPlay);
          if (!isCurrentSession()) return;
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
          // ignore: experimental_member_use
          final audioSource = LockCachingAudioSource(
            Uri.parse(streamUrl),
            cacheFile: fileForPath(cacheFilePath),
          );
          _playDbg(
            'sid=$debugSession source=lock_cache_from_direct_fallback '
            'setAudioSource cachePath=$cacheFilePath',
          );
          final sourceReady = await _replaceLoadedSource(
            songId: song.id,
            label: 'lock_cache_from_direct_fallback',
            ownsSource: () => _isPlaybackContextCurrent(
              session: debugSession,
              songId: song.id,
            ),
            setSource: (player) async {
              await player.setAudioSource(audioSource);
            },
          );
          if (!sourceReady) return;
          _usingLockCachingSource = true;
          _currentStreamUrl = streamUrl;
          _setStreamContext(
            songId: song.id,
            format: transcodeFormat,
            maxBitRate: maxBitRate,
            seekByReloadStream: useServerTimeOffsetSeek,
          );
          await _syncPlaybackAfterSourceReady(autoPlay: autoPlay);
          if (!isCurrentSession()) return;
          _seekDbg(
            'source=lock_cache_from_direct_fallback '
            'quality=${effectiveQuality.name} '
            'format=${transcodeFormat ?? song.suffix}',
          );
        }

        await _applyPendingSeekIfNeeded();
        if (!isCurrentSession()) return;
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

      if (!isCurrentSession()) return;
      _clearCurrentPlaybackRetry(reason: 'playback_ready_stream');

      // 上报"正在播放"
      if (autoPlay) {
        await _scrobble(song.id, submission: false);
        if (!isCurrentSession()) return;
      }

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
      if (autoPlay) {
        _preCacheNextSong();
      }
    } catch (e) {
      Logger.error('Failed to play song', e);
      _seekDbg('playSong failed song=${song.id} err=$e');

      // 如果在重试前用户已切歌（新的 playSong 被调用），放弃本次重试
      if (_playDebugSession != debugSession) {
        _playDbg(
          'sid=$debugSession abandoned (current=$_playDebugSession), '
          'skip transcoding retry',
        );
        return;
      }

      final hasAvailableRoute = await _refreshRoutesAndCheckAvailability();
      if (!hasAvailableRoute) {
        _scheduleCurrentPlaybackRetry(
          song: song,
          isPreview: false,
          autoPlay: autoPlay,
        );
        NetworkErrorNotifier.show('网络异常，当前无可用线路');
        return;
      }

      // 路由刷新后再次检查会话
      if (_playDebugSession != debugSession) {
        _playDbg(
          'sid=$debugSession abandoned after route refresh '
          '(current=$_playDebugSession)',
        );
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
          autoPlay: autoPlay,
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
    bool autoPlay = true,
  }) async {
    // 会话已被更新的 playSong 取代，放弃本次转码重试
    final sid = debugSession ?? _playDebugSession;
    bool isCurrentSession() =>
        _isPlaybackContextCurrent(session: sid, songId: song.id);
    if (debugSession != null && _playDebugSession != debugSession) {
      _playDbg(
        'sid=$sid transcoding retry abandoned '
        '(current=$_playDebugSession)',
      );
      return;
    }

    try {
      final authState = _ref.read(authStateProvider);
      final libraryId = authState.currentLibrary?.id ?? '';
      final cacheService = _ref.read(audioCacheServiceProvider);
      final streamUrl = _buildStreamUrlOrThrow(
        song.id,
        session: sid,
        source: 'transcoding_retry',
        format: 'mp3', // 转码为 MP3
        maxBitRate: 320,
      );
      final useServerTimeOffsetSeek = shouldUseServerTimeOffsetSeek(
        requestedFormat: 'mp3',
        requestedMaxBitRate: 320,
        sourceFormat: song.suffix,
        sourceBitRate: song.bitRate,
      );
      final isAppleHttpStream =
          _isApplePlatform && streamUrl.startsWith('http://');

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
        // 在实际设置音源前再次检查会话
        if (debugSession != null && _playDebugSession != debugSession) {
          _playDbg(
            'sid=$sid transcoding setUrl abandoned '
            '(current=$_playDebugSession)',
          );
          return;
        }
        final sourceReady = await _replaceLoadedSource(
          songId: song.id,
          label: 'direct_stream_transcoding',
          ownsSource: () =>
              _isPlaybackContextCurrent(session: sid, songId: song.id),
          setSource: (player) async {
            await player.setUrl(streamUrl);
          },
        );
        if (!sourceReady) return;
        _usingLockCachingSource = false;
        _currentStreamUrl = streamUrl;
        _setStreamContext(
          songId: song.id,
          format: 'mp3',
          maxBitRate: 320,
          seekByReloadStream: useServerTimeOffsetSeek,
        );
        await _syncPlaybackAfterSourceReady(autoPlay: autoPlay);
        if (!isCurrentSession()) return;
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
          cacheFile: fileForPath(cacheFilePath),
        );
        _playDbg(
          'sid=${debugSession ?? _playDebugSession} '
          'source=lock_cache_transcoding setAudioSource '
          'cachePath=$cacheFilePath',
        );
        final sourceReady = await _replaceLoadedSource(
          songId: song.id,
          label: 'lock_cache_transcoding',
          ownsSource: () =>
              _isPlaybackContextCurrent(session: sid, songId: song.id),
          setSource: (player) async {
            await player.setAudioSource(audioSource);
          },
        );
        if (!sourceReady) return;
        _usingLockCachingSource = true;
        _currentStreamUrl = streamUrl;
        _setStreamContext(
          songId: song.id,
          format: 'mp3',
          maxBitRate: 320,
          seekByReloadStream: useServerTimeOffsetSeek,
        );
        await _syncPlaybackAfterSourceReady(autoPlay: autoPlay);
        if (!isCurrentSession()) return;
        _seekDbg('source=lock_cache_transcoding mp3 song=${song.id}');
      }

      // 转码设置音源完成后再次检查会话
      if (debugSession != null && _playDebugSession != debugSession) {
        _playDbg(
          'sid=$sid transcoding post-setup abandoned '
          '(current=$_playDebugSession)',
        );
        return;
      }
      await _applyPendingSeekIfNeeded();
      if (!isCurrentSession()) return;
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
      _clearCurrentPlaybackRetry(reason: 'playback_ready_transcoding');

      // 上报"正在播放"
      if (autoPlay) {
        await _scrobble(song.id, submission: false);
        if (!isCurrentSession()) return;
      }
    } catch (e) {
      Logger.error('Failed to play song even with transcoding', e);
      final hasAvailableRoute = await _refreshRoutesAndCheckAvailability();
      if (debugSession != null && _playDebugSession != debugSession) {
        _playDbg(
          'sid=$sid transcoding retry abandoned after route refresh '
          '(current=$_playDebugSession)',
        );
        return;
      }
      if (!hasAvailableRoute) {
        _scheduleCurrentPlaybackRetry(
          song: song,
          isPreview: false,
          autoPlay: autoPlay,
        );
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
    if (!_isApplePlatform) {
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

  void _scheduleSongRemoteRefresh(Song song, int session) {
    unawaited(() async {
      final activeAddress = await _ensureActiveAddressForPlayback(
        session: session,
        reason: 'song_remote_refresh',
        logFailure: false,
      );
      if (activeAddress == null ||
          !mounted ||
          _playDebugSession != session ||
          state.currentSong?.id != song.id) {
        return;
      }
      _updateMediaItem(song);
      await _enrichSongMetadata(song.id, session);
    }());
  }

  ServerAddress? _syncImmediateActiveAddress({
    required int session,
    required String reason,
  }) {
    final pool = _ref.read(addressPoolProvider);
    final active = pool.activeAddress ?? _ref.read(activeAddressProvider);
    if (active == null) return null;

    final dio = _apiClient.dio;
    if (dio.options.baseUrl != active.url) {
      dio.options.baseUrl = active.url;
      Logger.infoWithTag('API', 'switched base URL to: ${active.url}');
    }
    _playDbg(
      'sid=$session active_address_ready '
      'reason=$reason label=${active.label} url=${active.url}',
    );
    return active;
  }

  Future<ServerAddress?> _ensureActiveAddressForPlayback({
    required int session,
    required String reason,
    bool logFailure = true,
  }) async {
    final immediate = _syncImmediateActiveAddress(
      session: session,
      reason: reason,
    );
    if (immediate != null) return immediate;

    _playDbg('sid=$session active_address_wait start reason=$reason');
    try {
      final ensured = await _ref.read(ensureActiveAddressProvider.future);
      final dio = _apiClient.dio;
      if (dio.options.baseUrl != ensured.url) {
        dio.options.baseUrl = ensured.url;
        Logger.infoWithTag('API', 'switched base URL to: ${ensured.url}');
      }
      _playDbg(
        'sid=$session active_address_ready '
        'reason=$reason label=${ensured.label} url=${ensured.url}',
      );
      return ensured;
    } catch (e) {
      if (logFailure) {
        Logger.warnWithTag(
          _playerLogTag,
          'failed to ensure active address for $reason',
          e,
        );
      }
      _playDbg(
        'sid=$session active_address_wait failed '
        'reason=$reason err=$e',
      );
      return null;
    }
  }

  String _buildStreamUrlOrThrow(
    String songId, {
    required int session,
    required String source,
    int? maxBitRate,
    String? format,
    int? timeOffset,
  }) {
    final streamUrl = _apiClient.getStreamUrl(
      songId,
      maxBitRate: maxBitRate,
      format: format,
      timeOffset: timeOffset,
    );
    if (streamUrl.isEmpty) {
      final baseUrl = _apiClient.dio.options.baseUrl;
      _playDbg(
        'sid=$session $source stream_url_empty '
        'baseUrl=${baseUrl.isEmpty ? 'none' : baseUrl}',
      );
      throw StateError('No active server address available for stream URL');
    }
    return streamUrl;
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
    final safeCoverArtUrl = coverArtUrl?.trim();

    final mediaItem = MediaItem(
      id: song.id,
      title: song.title,
      artist: song.artist ?? 'Unknown Artist',
      album: song.album ?? 'Unknown Album',
      duration: song.duration != null
          ? Duration(seconds: song.duration!)
          : null,
      artUri: safeCoverArtUrl != null && safeCoverArtUrl.isNotEmpty
          ? Uri.parse(safeCoverArtUrl)
          : null,
    );

    _audioHandler?.updateMediaItem(mediaItem);
  }

  /// 异步补充歌曲元数据（格式/码率/位深/采样率/声道数），不阻塞播放流程。
  Future<void> _enrichSongMetadata(String songId, int session) async {
    try {
      final fullSong = await _musicRepository.getSong(songId);
      if (fullSong == null) return;
      // 会话已切换 → 丢弃
      if (!mounted || _playDebugSession != session) return;
      final current = state.currentSong;
      if (current == null || current.id != songId) return;
      // 仅在缺失时补充
      final needsUpdate =
          current.suffix == null ||
          current.bitRate == null ||
          current.bitDepth == null ||
          current.samplingRate == null ||
          current.channelCount == null;
      if (!needsUpdate) return;
      final enriched = current.copyWith(
        suffix: current.suffix ?? fullSong.suffix,
        bitRate: current.bitRate ?? fullSong.bitRate,
        bitDepth: current.bitDepth ?? fullSong.bitDepth,
        samplingRate: current.samplingRate ?? fullSong.samplingRate,
        channelCount: current.channelCount ?? fullSong.channelCount,
      );
      if (mounted && state.currentSong?.id == songId) {
        state = state.copyWith(currentSong: enriched);
        // 同步更新队列中的歌曲对象
        final idx = state.currentIndex;
        if (idx >= 0 &&
            idx < state.queue.length &&
            state.queue[idx].id == songId) {
          final updatedQueue = List<Song>.from(state.queue);
          updatedQueue[idx] = enriched;
          state = state.copyWith(queue: updatedQueue);
        }
        if (_currentStreamSongId == songId &&
            _sourcePositionOffset == Duration.zero) {
          final useServerTimeOffsetSeek = shouldUseServerTimeOffsetSeek(
            requestedFormat: _currentStreamFormat,
            requestedMaxBitRate: _currentStreamMaxBitRate,
            sourceFormat: enriched.suffix,
            sourceBitRate: enriched.bitRate,
          );
          if (useServerTimeOffsetSeek != _seekByReloadStream) {
            _seekByReloadStream = useServerTimeOffsetSeek;
            _seekDbg(
              'updated timeOffset seek after metadata refresh '
              'song=$songId bitRate=${enriched.bitRate} '
              'maxBitRate=$_currentStreamMaxBitRate '
              'enabled=$useServerTimeOffsetSeek',
            );
          }
        }
      }
    } catch (e) {
      Logger.debug('Failed to enrich song metadata for $songId: $e');
    }
  }

  /// 启动播放但不阻塞当前流程。
  /// just_audio 的 play() Future 会在暂停/结束时才完成，不能在切歌流程里 await。
  void _startPlayback({bool fadeIn = true}) {
    final player = _audioPlayer;
    if (player == null) return;
    unawaited(
      player.play().catchError((error) {
        Logger.warn('Failed to start playback', error);
      }),
    );
    if (fadeIn) {
      _fadeIn();
    }
  }

  Future<void> _syncPlaybackAfterSourceReady({required bool autoPlay}) async {
    if (autoPlay) {
      _startPlayback();
      return;
    }

    _cancelFade();
    await _audioPlayer?.pause();
    await _audioHandler?.pause();
    if (mounted && state.isPlaying) {
      state = state.copyWith(isPlaying: false);
    }
  }

  // ---------------------------------------------------------------------------
  // 淡入淡出
  // ---------------------------------------------------------------------------

  /// 取消正在进行的淡入淡出动画并将音量恢复为 1.0
  void _cancelFade() {
    _fadeTimer?.cancel();
    _fadeTimer = null;
    final completer = _fadeCompleter;
    _fadeCompleter = null;
    if (completer != null && !completer.isCompleted) {
      completer.complete();
    }
    _audioPlayer?.setVolume(1.0);
  }

  /// 淡出当前正在播放的歌曲。
  /// 如果用户未启用淡入淡出或当前未在播放，则立即返回。
  Future<void> _fadeOut(int session) async {
    _cancelFade();
    final durationMs = _ref.read(crossfadeDurationMsProvider);
    if (durationMs <= 0) return;
    final player = _audioPlayer;
    if (player == null || !player.playing) return;

    // 淡出只使用一半时长，另一半留给淡入
    final fadeMs = durationMs ~/ 2;
    const stepMs = 20;
    final steps = (fadeMs / stepMs).ceil().clamp(1, 500);
    final volumeStep = 1.0 / steps;
    var currentVolume = 1.0;

    _playDbg('sid=$session fadeOut start durationMs=$fadeMs steps=$steps');

    final completer = Completer<void>();
    _fadeCompleter = completer;
    _fadeTimer = Timer.periodic(const Duration(milliseconds: stepMs), (timer) {
      // 会话已变（用户快速切歌）→ 立即中止
      if (_playDebugSession != session) {
        timer.cancel();
        _fadeTimer = null;
        if (identical(_fadeCompleter, completer)) {
          _fadeCompleter = null;
        }
        player.setVolume(0.0);
        if (!completer.isCompleted) completer.complete();
        return;
      }
      currentVolume = (currentVolume - volumeStep).clamp(0.0, 1.0);
      player.setVolume(currentVolume);
      if (currentVolume <= 0.0) {
        timer.cancel();
        _fadeTimer = null;
        if (identical(_fadeCompleter, completer)) {
          _fadeCompleter = null;
        }
        _playDbg('sid=$session fadeOut complete');
        if (!completer.isCompleted) completer.complete();
      }
    });

    return completer.future;
  }

  /// 淡入新歌曲：从 0.0 渐变到 1.0
  void _fadeIn() {
    _cancelFade();
    final durationMs = _ref.read(crossfadeDurationMsProvider);
    if (durationMs <= 0) {
      _audioPlayer?.setVolume(1.0);
      return;
    }
    final player = _audioPlayer;
    if (player == null) return;

    // 淡入使用另一半时长
    final fadeMs = durationMs ~/ 2;
    const stepMs = 20;
    final steps = (fadeMs / stepMs).ceil().clamp(1, 500);
    final volumeStep = 1.0 / steps;
    var currentVolume = 0.0;
    player.setVolume(0.0);

    final session = _playDebugSession;
    _playDbg('sid=$session fadeIn start durationMs=$fadeMs steps=$steps');

    _fadeTimer = Timer.periodic(const Duration(milliseconds: stepMs), (timer) {
      if (_playDebugSession != session) {
        timer.cancel();
        _fadeTimer = null;
        player.setVolume(1.0);
        return;
      }
      currentVolume = (currentVolume + volumeStep).clamp(0.0, 1.0);
      player.setVolume(currentVolume);
      if (currentVolume >= 1.0) {
        timer.cancel();
        _fadeTimer = null;
        _playDbg('sid=$session fadeIn complete');
      }
    });
  }

  /// 播放队列
  Future<void> playQueue(List<Song> songs, {int startIndex = 0}) async {
    if (songs.isEmpty) return;
    await playSong(songs[startIndex], queue: songs, index: startIndex);
  }

  /// 播放试听歌曲。
  Future<void> playPreviewSong(Song song) async {
    await playSong(song);
  }

  Future<void> _playPreviewSongInternal(
    Song song, {
    required List<Song> queue,
    required int index,
    bool autoPlay = true,
  }) async {
    final debugSession = ++_playDebugSession;
    _transportRequestGeneration += 1;
    bool isCurrentSession() =>
        _isPlaybackContextCurrent(session: debugSession, songId: song.id);
    _clearCurrentPlaybackRetry(
      reason: 'play_preview_started',
      preserveRetrying: _retryingCurrentPlayback,
    );

    late final Song resolvedSong;
    try {
      resolvedSong = await _resolvePreviewSongForPlayback(song);
    } catch (e) {
      Logger.error('Failed to resolve preview song', e);
      if (_playDebugSession == debugSession) {
        NetworkErrorNotifier.show('试听链接解析失败');
      }
      return;
    }
    if (_playDebugSession != debugSession) return;

    final streamUrl = resolvedSong.previewStreamUrl?.trim() ?? '';
    final previewHeaders = resolvedSong.previewRequestHeaders;
    final previewQueue = resolvePreviewPlaybackQueue(
      queue: queue,
      preferredIndex: index,
      unresolvedSong: song,
      resolvedSong: resolvedSong,
    );
    final playQueue = previewQueue.queue;
    final playIndex = previewQueue.index;

    if (!autoPlay) {
      _cancelFade();
      await _audioPlayer?.pause();
      await _audioHandler?.pause();
      if (_playDebugSession != debugSession) return;
    }

    _downloadProgressSubscription?.cancel();
    _downloadProgressSubscription = null;
    _clearPendingSeek();
    _usingLockCachingSource = false;
    _currentStreamUrl = null;
    _invalidateLoadedSource(reason: 'play_preview_started');
    _invalidateSeekRequests();
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

    final initialDuration = resolvedSong.duration != null
        ? Duration(seconds: resolvedSong.duration!)
        : Duration.zero;

    state = state.copyWith(
      currentSong: resolvedSong,
      queue: playQueue,
      currentIndex: playIndex,
      position: Duration.zero,
      duration: initialDuration,
      currentBitRateKbps: 0,
    );

    _updateMediaItem(resolvedSong);

    try {
      _playDbg(
        'sid=$debugSession preview setUrl song=${resolvedSong.id} '
        'queue=${playQueue.length} index=$playIndex '
        'url=${_summarizeStreamUrl(streamUrl)} '
        'headers=${previewHeaders.keys.join(",")}',
      );
      final sourceReady = await _replaceLoadedSource(
        songId: resolvedSong.id,
        label: 'preview',
        ownsSource: () => _isPlaybackContextCurrent(
          session: debugSession,
          songId: resolvedSong.id,
        ),
        setSource: (player) async {
          await player.setUrl(streamUrl, headers: previewHeaders);
        },
      );
      if (!sourceReady) return;
      _usingLockCachingSource = false;
      _currentStreamUrl = streamUrl;
      _setStreamContext(
        songId: resolvedSong.id,
        format: null,
        maxBitRate: null,
        seekByReloadStream: false,
      );
      await _syncPlaybackAfterSourceReady(autoPlay: autoPlay);
      if (!isCurrentSession()) return;
      await _applyPendingSeekIfNeeded();
      if (!isCurrentSession()) return;
      state = state.copyWith(
        currentQuality: AudioQualityLevel.original,
        playbackSource: PlaybackSource.stream,
        currentBitRateKbps: _resolveCurrentBitRateKbps(
          song: resolvedSong,
          quality: AudioQualityLevel.original,
          source: PlaybackSource.stream,
          maxBitRate: _normalizeBitRateKbps(resolvedSong.bitRate),
        ),
      );
      _clearCurrentPlaybackRetry(reason: 'playback_ready_preview');
    } catch (e) {
      Logger.error('Failed to play preview song', e);
      if (_playDebugSession != debugSession) {
        _playDbg(
          'sid=$debugSession preview abandoned after failure '
          '(current=$_playDebugSession)',
        );
        return;
      }
      final hasAvailableRoute = await _refreshRoutesAndCheckAvailability();
      if (_playDebugSession != debugSession) {
        _playDbg(
          'sid=$debugSession preview abandoned after route refresh '
          '(current=$_playDebugSession)',
        );
        return;
      }
      if (!hasAvailableRoute) {
        _scheduleCurrentPlaybackRetry(
          song: resolvedSong,
          isPreview: true,
          autoPlay: autoPlay,
        );
        NetworkErrorNotifier.show('试听播放失败，当前无可用线路');
        return;
      }
      NetworkErrorNotifier.show('试听播放失败');
    }
  }

  /// 试听歌曲可以先作为普通队列项加入；真正轮到播放时再补齐临时 URL。
  Future<Song> _resolvePreviewSongForPlayback(Song song) async {
    final existingUrl = song.previewStreamUrl?.trim() ?? '';
    if (existingUrl.isNotEmpty) return song;

    final source = song.previewSource?.trim() ?? '';
    final trackId = song.previewTrackId?.trim() ?? '';
    if (source.isEmpty || trackId.isEmpty) {
      throw StateError('试听歌曲缺少 source/trackId');
    }

    final client = _ref.read(gdMusicApiClientProvider);
    final resolved = await client.resolveSongUrl(
      source: source,
      trackId: trackId,
    );

    var coverUrl = song.previewCoverUrl?.trim();
    final picId = song.previewPicId?.trim() ?? '';
    if ((coverUrl == null || coverUrl.isEmpty) && picId.isNotEmpty) {
      coverUrl = await client.resolveCoverUrl(source: source, picId: picId);
    }

    return song.copyWith(
      previewStreamUrl: resolved.url,
      previewCoverUrl: coverUrl,
      previewQualityLabel: resolved.qualityLabel,
      previewRequestHeaders: resolved.requiredHeaders,
      bitRate: resolved.bitRateKbps,
      suffix: resolved.suffix ?? song.suffix,
    );
  }

  /// 播放/暂停
  Future<void> togglePlayPause() async {
    if (state.isPlaying) {
      await pause();
    } else {
      await play();
    }
  }

  /// 暂停（带淡出）
  Future<void> pause() async {
    final playbackSession = _playDebugSession;
    final transportRequest = ++_transportRequestGeneration;
    final durationMs = _ref.read(crossfadeDurationMsProvider);
    if (durationMs > 0 && state.isPlaying) {
      await _fadeOutForPause();
      if (_playDebugSession != playbackSession ||
          _transportRequestGeneration != transportRequest) {
        return;
      }
    }
    await _audioPlayer?.pause();
    if (_playDebugSession != playbackSession ||
        _transportRequestGeneration != transportRequest) {
      return;
    }
    await _audioHandler?.pause();
  }

  /// 播放（从暂停恢复，不使用淡入——淡入淡出仅用于切歌）
  Future<void> play() {
    _transportRequestGeneration += 1;
    _cancelFade(); // 取消任何进行中的淡入淡出，恢复音量到 1.0
    _startPlayback(fadeIn: false);
    return Future<void>.value();
  }

  /// 暂停前的淡出：音量降到 0 后返回，由 pause() 执行实际暂停。
  Future<void> _fadeOutForPause() async {
    _cancelFade();
    final durationMs = _ref.read(crossfadeDurationMsProvider);
    if (durationMs <= 0) return;
    final player = _audioPlayer;
    if (player == null || !player.playing) return;

    final fadeMs = durationMs ~/ 2;
    const stepMs = 20;
    final steps = (fadeMs / stepMs).ceil().clamp(1, 500);
    final volumeStep = 1.0 / steps;
    var currentVolume = 1.0;

    final completer = Completer<void>();
    _fadeCompleter = completer;
    _fadeTimer = Timer.periodic(const Duration(milliseconds: stepMs), (timer) {
      currentVolume = (currentVolume - volumeStep).clamp(0.0, 1.0);
      player.setVolume(currentVolume);
      if (currentVolume <= 0.0) {
        timer.cancel();
        _fadeTimer = null;
        if (identical(_fadeCompleter, completer)) {
          _fadeCompleter = null;
        }
        if (!completer.isCompleted) completer.complete();
      }
    });

    return completer.future;
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

    // 回绕到首曲（单曲队列时等同于重播当前曲目）。
    if (state.queue.isNotEmpty) {
      await skipToQueueItem(0);
    }
  }

  /// 跳转到指定位置
  Future<void> seek(Duration position) async {
    final player = _audioPlayer;
    final currentSongId = state.currentSong?.id;
    if (player == null || currentSongId == null) return;

    final seekGeneration = ++_seekRequestGeneration;
    final playbackSession = _playDebugSession;
    bool isCurrentSeek() => _isSeekRequestCurrent(
      seekGeneration: seekGeneration,
      playbackSession: playbackSession,
      songId: currentSongId,
    );
    bool ownsSource() => _isPlaybackContextCurrent(
      session: playbackSession,
      songId: currentSongId,
    );
    final target = _normalizeSeekPosition(position);
    final canSeekNow = canSeekLoadedPlayerSource(
      processingState: player.processingState,
      loadedSourceSongId: _loadedSourceSongId,
      currentSongId: currentSongId,
    );
    _seekDbg(
      'seek request song=$currentSongId target=$target '
      'playerPos=${player.position} state=${player.processingState.name} '
      'canSeekNow=$canSeekNow loadedSource=$_loadedSourceSongId '
      'lockCache=$_usingLockCachingSource',
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

    _activeSeekGeneration = seekGeneration;
    _activeSeekSongId = currentSongId;

    // 可立即 seek 时，先把 UI 锚定到目标位置，避免等待底层回调期间回退到旧进度。
    if (mounted) {
      state = state.copyWith(position: target);
    }
    if (_usingLockCachingSource) {
      _syntheticPositionFallbackActive = true;
      _seekDbg('seek anchor synthetic position target=$target');
    }

    _clearPendingSeek();
    try {
      await _seekWithFallback(
        target,
        songId: currentSongId,
        isCurrentSeek: isCurrentSeek,
        ownsSource: ownsSource,
      );
      if (isCurrentSeek() && mounted) {
        state = state.copyWith(position: target);
      }
    } finally {
      _releaseSeekAnchor(seekGeneration);
      _schedulePendingSeekIfReady();
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

  void _schedulePersistPlaybackSession({bool immediate = false}) {
    if (!mounted || _isRestoringPlaybackSession) return;

    if (immediate) {
      _playbackSessionPersistTimer?.cancel();
      _playbackSessionPersistTimer = null;
      unawaited(_persistPlaybackSession());
      return;
    }

    if (_playbackSessionPersistTimer != null) return;
    _playbackSessionPersistTimer = Timer(_playbackSessionPersistInterval, () {
      _playbackSessionPersistTimer = null;
      unawaited(_persistPlaybackSession());
    });
  }

  Map<String, dynamic>? _buildPlaybackSessionPayload() {
    final queue = state.queue;
    if (queue.isEmpty) return null;

    var currentIndex = state.currentIndex;
    final currentSongId = state.currentSong?.id;
    final hasCurrentIndex = currentIndex >= 0 && currentIndex < queue.length;

    if (currentSongId != null &&
        (!hasCurrentIndex || queue[currentIndex].id != currentSongId)) {
      final resolvedIndex = queue.indexWhere(
        (song) => song.id == currentSongId,
      );
      if (resolvedIndex >= 0) {
        currentIndex = resolvedIndex;
      }
    }

    if (currentIndex < 0 || currentIndex >= queue.length) return null;

    final normalizedPosition = _normalizeSeekPosition(state.position);
    return {
      'version': 1,
      'queue': queue.map((song) => song.toJson()).toList(growable: false),
      'currentIndex': currentIndex,
      'currentSongId': queue[currentIndex].id,
      'positionMs': normalizedPosition.inMilliseconds,
      'isPlaying': state.isPlaying,
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
    };
  }

  Future<void> _persistPlaybackSession() async {
    if (!mounted ||
        _isRestoringPlaybackSession ||
        _isPersistingPlaybackSession) {
      return;
    }

    _isPersistingPlaybackSession = true;
    try {
      final payload = _buildPlaybackSessionPayload();
      if (payload == null) {
        await LocalStorage.clearPlaybackSession();
        return;
      }
      await LocalStorage.savePlaybackSession(payload);
    } catch (e) {
      Logger.warnWithTag(
        _playerLogTag,
        'failed to persist playback session',
        e,
      );
    } finally {
      _isPersistingPlaybackSession = false;
    }
  }

  Future<void> _restorePlaybackSession() async {
    if (!mounted) return;
    var restored = false;
    _isRestoringPlaybackSession = true;

    try {
      final session = await LocalStorage.getPlaybackSession();
      if (session == null) return;

      final queue = _parsePlaybackSessionQueue(session['queue']);
      if (queue.isEmpty) {
        await LocalStorage.clearPlaybackSession();
        return;
      }

      final preferredIndex = _parseStoredInt(session['currentIndex']) ?? 0;
      final currentSongId = session['currentSongId']?.toString();
      final restoredIndex = _resolveRestoredQueueIndex(
        queue: queue,
        preferredIndex: preferredIndex,
        currentSongId: currentSongId,
      );
      final storedPositionMs = _parseStoredInt(session['positionMs']) ?? 0;
      final restoredPosition = Duration(milliseconds: max(0, storedPositionMs));
      final wasPlaying = session['isPlaying'] == true;
      Logger.infoWithTag(
        _playerLogTag,
        'restoring playback session queue=${queue.length} '
        'index=$restoredIndex posMs=${restoredPosition.inMilliseconds} '
        'wasPlaying=$wasPlaying',
      );
      await playSong(
        queue[restoredIndex],
        queue: queue,
        index: restoredIndex,
        autoPlay: false,
      );
      if (restoredPosition > Duration.zero) {
        await seek(restoredPosition);
      }
      // 安全策略：恢复会话后始终暂停，避免未确认自动播放出声。
      await pause();

      Logger.infoWithTag(_playerLogTag, 'playback session restored');
      restored = true;
    } catch (e) {
      Logger.warnWithTag(
        _playerLogTag,
        'failed to restore playback session',
        e,
      );
    } finally {
      _isRestoringPlaybackSession = false;
    }

    if (restored) {
      _schedulePersistPlaybackSession(immediate: true);
    }
  }

  List<Song> _parsePlaybackSessionQueue(Object? rawQueue) {
    if (rawQueue is! List) return const [];

    final queue = <Song>[];
    for (final item in rawQueue) {
      try {
        if (item is Map<String, dynamic>) {
          queue.add(Song.fromJson(item));
          continue;
        }
        if (item is Map) {
          final mapped = item.map(
            (key, value) => MapEntry(key.toString(), value),
          );
          queue.add(Song.fromJson(mapped));
        }
      } catch (e) {
        Logger.warnWithTag(
          _playerLogTag,
          'skip invalid song in playback session',
          e,
        );
      }
    }
    return queue;
  }

  int? _parseStoredInt(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  int _resolveRestoredQueueIndex({
    required List<Song> queue,
    required int preferredIndex,
    required String? currentSongId,
  }) {
    if (queue.isEmpty) return 0;

    if (currentSongId != null && currentSongId.isNotEmpty) {
      if (preferredIndex >= 0 &&
          preferredIndex < queue.length &&
          queue[preferredIndex].id == currentSongId) {
        return preferredIndex;
      }

      final matched = queue.indexWhere((song) => song.id == currentSongId);
      if (matched >= 0) return matched;
    }

    if (preferredIndex < 0) return 0;
    if (preferredIndex >= queue.length) return queue.length - 1;
    return preferredIndex;
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

  ShuffleHistoryEntry? _currentShuffleEntry({
    required List<Song> queue,
    required Song? song,
    required int index,
  }) {
    if (song == null || queue.isEmpty) return null;

    if (index >= 0 && index < queue.length && queue[index].id == song.id) {
      return ShuffleHistoryEntry(songId: song.id, preferredIndex: index);
    }

    for (var i = 0; i < queue.length; i++) {
      if (queue[i].id == song.id) {
        return ShuffleHistoryEntry(songId: song.id, preferredIndex: i);
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
    List<ShuffleHistoryEntry> stack,
    ShuffleHistoryEntry entry,
  ) {
    if (stack.isNotEmpty) {
      final last = stack.last;
      if (last.songId == entry.songId &&
          last.preferredIndex == entry.preferredIndex) {
        return;
      }
    }

    stack.add(entry);
    if (stack.length > maxShuffleHistoryEntries) {
      stack.removeAt(0);
    }
  }

  int? _resolveShuffleEntryIndex(ShuffleHistoryEntry entry) {
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

  int? _takeLastValidHistoryIndex(List<ShuffleHistoryEntry> stack) {
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
    if (queue.isEmpty) return null;
    if (queue.length == 1) return 0;

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
    _invalidateLoadedSource(reason: 'queue_cleared');
    _invalidateSeekRequests();
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
      _invalidateLoadedSource(reason: 'current_queue_item_removed');
      _invalidateSeekRequests();
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
      if (state.queue.isNotEmpty) {
        _seekDbg('completed -> shuffle next song=$completedSongId');
        await next();
      }
      return;
    }

    // 根据循环模式决定下一步
    if (state.loopMode == LoopMode.one) {
      // 单曲循环
      _seekDbg('completed -> repeat one song=$completedSongId');
      await seek(Duration.zero);
      if (state.currentSong?.id == completedSongId) {
        _startPlayback(fadeIn: false);
      }
    } else if (state.hasNext) {
      // 播放下一首
      _seekDbg('completed -> sequential next song=$completedSongId');
      await next();
    }
  }

  /// 上报播放记录（Scrobble）
  Future<void> _scrobble(String songId, {required bool submission}) =>
      _favoriteHandler.scrobble(songId, submission: submission);

  Future<void> _recordMobileCacheSavedBytesForHit({
    required String songId,
    required String cacheFilePath,
    required String libraryId,
  }) => _favoriteHandler.recordMobileCacheSavedBytesForHit(
    songId: songId,
    cacheFilePath: cacheFilePath,
    libraryId: libraryId,
  );

  /// 切换当前歌曲的收藏状态
  Future<void> toggleFavorite() async {
    final currentSong = state.currentSong;
    if (currentSong == null) return;
    await toggleSongFavorite(currentSong);
  }

  /// 切换指定歌曲的收藏状态
  Future<bool?> toggleSongFavorite(Song song) async {
    final newStarred = await _favoriteHandler.toggleSongFavorite(
      song: song,
      currentSong: state.currentSong,
      queue: state.queue,
    );
    if (newStarred == null) return null;

    final updatedQueue = _favoriteHandler.updateQueueStarred(
      state.queue,
      song.id,
      newStarred,
    );
    final currentSong = state.currentSong;
    final updatedCurrentSong = currentSong != null && currentSong.id == song.id
        ? currentSong.copyWith(starred: newStarred)
        : currentSong;

    state = state.copyWith(
      currentSong: updatedCurrentSong,
      queue: updatedQueue,
    );
    _favoriteHandler.invalidateFavoriteProviders(albumId: song.albumId);
    return newStarred;
  }

  Future<void> refreshSongMetadata(String songId) async {
    if (songId.trim().isEmpty) return;

    try {
      final fullSong = await _musicRepository.getSong(songId);
      if (fullSong == null) return;

      final currentSong = state.currentSong;
      final updatedQueue = List<Song>.from(state.queue);
      var queueChanged = false;
      for (var i = 0; i < updatedQueue.length; i++) {
        if (updatedQueue[i].id != songId) continue;
        updatedQueue[i] = fullSong;
        queueChanged = true;
      }

      if (currentSong != null && currentSong.id == songId) {
        state = state.copyWith(
          currentSong: fullSong,
          queue: queueChanged ? updatedQueue : state.queue,
        );
        _updateMediaItem(fullSong);
        return;
      }

      if (queueChanged) {
        state = state.copyWith(queue: updatedQueue);
      }
    } catch (e) {
      Logger.warnWithTag(_playerLogTag, 'failed to refresh song metadata', e);
    }
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
    if (_isApplyingPendingSeek) return;

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

    final canSeekNow = canSeekLoadedPlayerSource(
      processingState: player.processingState,
      loadedSourceSongId: _loadedSourceSongId,
      currentSongId: currentSongId,
    );
    if (!canSeekNow) return;

    _isApplyingPendingSeek = true;
    final seekGeneration = ++_seekRequestGeneration;
    final playbackSession = _playDebugSession;
    bool isCurrentSeek() => _isSeekRequestCurrent(
      seekGeneration: seekGeneration,
      playbackSession: playbackSession,
      songId: currentSongId,
    );
    bool ownsSource() => _isPlaybackContextCurrent(
      session: playbackSession,
      songId: currentSongId,
    );
    final target = _normalizeSeekPosition(pending);
    _activeSeekGeneration = seekGeneration;
    _activeSeekSongId = currentSongId;
    _seekDbg(
      'applyPendingSeek song=$currentSongId target=$target '
      'playerPos=${player.position} state=${player.processingState.name}',
    );
    _clearPendingSeek();
    try {
      await _seekWithFallback(
        target,
        songId: currentSongId,
        isCurrentSeek: isCurrentSeek,
        ownsSource: ownsSource,
      );
      if (isCurrentSeek() && mounted) {
        state = state.copyWith(position: target);
      }
    } finally {
      _releaseSeekAnchor(seekGeneration);
      _isApplyingPendingSeek = false;
      _schedulePendingSeekIfReady();
    }
  }

  Future<void> _seekWithFallback(
    Duration target, {
    required String songId,
    required bool Function() isCurrentSeek,
    required bool Function() ownsSource,
  }) async {
    final player = _audioPlayer;
    if (player == null || !isCurrentSeek()) return;

    if (_seekByReloadStream &&
        _currentStreamSongId == songId &&
        _currentStreamUrl != null) {
      final shouldResume = player.playing;
      final seekTarget = TranscodedStreamSeekTarget.fromLogical(target);
      final streamFormat = _currentStreamFormat;
      final streamMaxBitRate = _currentStreamMaxBitRate;
      final wasUsingLockCachingSource = _usingLockCachingSource;
      final reloadUrl = _apiClient.getStreamUrl(
        songId,
        maxBitRate: streamMaxBitRate,
        format: streamFormat,
        timeOffset: seekTarget.serverOffset.inSeconds,
      );
      _seekDbg(
        'seek reload-stream song=$songId '
        'target=$target serverOffset=${seekTarget.serverOffset} '
        'sourcePosition=${seekTarget.sourcePosition} format=$streamFormat '
        'maxBitRate=$streamMaxBitRate wasPlaying=$shouldResume '
        'lockCache=$wasUsingLockCachingSource',
      );
      try {
        var reloadedWithLockCaching = false;
        final sourceReady = await _replaceLoadedSource(
          songId: songId,
          label: 'seek_reload_stream',
          ownsSource: ownsSource,
          setSource: (sourcePlayer) async {
            if (wasUsingLockCachingSource && _isAppleHttpUrl(reloadUrl)) {
              // Apple HTTP streams may require just_audio's local proxy. Do
              // not reuse the full-song cache file: this URL contains only a
              // timeOffset tail segment.
              // ignore: experimental_member_use
              final audioSource = LockCachingAudioSource(Uri.parse(reloadUrl));
              await sourcePlayer.setAudioSource(
                audioSource,
                initialPosition: seekTarget.sourcePosition,
              );
              reloadedWithLockCaching = true;
              return;
            }
            await sourcePlayer.setUrl(
              reloadUrl,
              initialPosition: seekTarget.sourcePosition,
            );
          },
        );
        if (!sourceReady) return;
        if (reloadedWithLockCaching) {
          // A tail segment must not be registered as a complete song cache.
          _replaceDownloadProgressSubscription(null);
        }
        _usingLockCachingSource = reloadedWithLockCaching;
        _currentStreamUrl = reloadUrl;
        _setStreamContext(
          songId: songId,
          format: streamFormat,
          maxBitRate: streamMaxBitRate,
          seekByReloadStream: true,
          sourcePositionOffset: seekTarget.serverOffset,
        );
        if (!isCurrentSeek()) {
          _schedulePendingSeekIfReady();
          return;
        }
        if (mounted) {
          state = state.copyWith(position: target, bufferedPosition: target);
        }
        if (shouldResume) {
          _startPlayback(fadeIn: false);
        }
        await Future<void>.delayed(const Duration(milliseconds: 220));
        if (!isCurrentSeek()) return;
        final actualReload = _logicalPlayerPosition(player.position);
        final reloadDrift = (actualReload - target).inMilliseconds.abs();
        _seekDbg(
          'seek reload-stream verify target=$target '
          'sourceActual=${player.position} actual=$actualReload '
          'sourceOffset=$_sourcePositionOffset driftMs=$reloadDrift',
        );
        if (reloadDrift <= 2000) return;
        Logger.warn(
          'Reload-stream seek drift still high '
          '(target=$target, actual=$actualReload), retrying plain seek',
        );
        if (!isCurrentSeek()) return;
        await player.seek(seekTarget.sourcePosition);
        return;
      } catch (e) {
        if (!isCurrentSeek()) return;
        Logger.warn('Reload-stream seek failed, fallback to plain seek', e);
        await player.seek(_sourceSeekPosition(target));
        return;
      }
    }

    final sourceTarget = _sourceSeekPosition(target);
    _seekDbg(
      'seek execute target=$target sourceTarget=$sourceTarget '
      'sourceFrom=${player.position} '
      'from=${_logicalPlayerPosition(player.position)} '
      'sourceOffset=$_sourcePositionOffset '
      'state=${player.processingState.name} lockCache=$_usingLockCachingSource',
    );
    await player.seek(sourceTarget);
    if (!isCurrentSeek()) return;

    await Future<void>.delayed(const Duration(milliseconds: 220));
    if (!isCurrentSeek()) return;
    final actual = _logicalPlayerPosition(player.position);
    final drift = (actual - target).inMilliseconds.abs();
    _seekDbg(
      'seek verify target=$target sourceActual=${player.position} '
      'actual=$actual driftMs=$drift',
    );
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
            songId: songId,
            isCurrentSeek: isCurrentSeek,
            ownsSource: ownsSource,
          );
          if (!isCurrentSeek()) return;
          if (reloaded) return;
        } catch (e) {
          if (!isCurrentSeek()) return;
          Logger.warn('Lock-cache reload seek failed on Apple HTTP', e);
        }
        _seekDbg(
          'seek fallback lock-cache reload unavailable, '
          'keep synthetic position target=$target',
        );
        _syntheticPositionFallbackActive = true;
        if (isCurrentSeek() && mounted) {
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
        final streamUrl = _currentStreamUrl!;
        final streamFormat = _currentStreamFormat;
        final streamMaxBitRate = _currentStreamMaxBitRate;
        final reloadStreamSeek = _seekByReloadStream;
        final sourceReady = await _replaceLoadedSource(
          songId: songId,
          label: 'seek_direct_stream_fallback',
          ownsSource: ownsSource,
          setSource: (sourcePlayer) async {
            await sourcePlayer.setUrl(streamUrl, initialPosition: target);
          },
        );
        if (!sourceReady) return;
        _replaceDownloadProgressSubscription(null);
        _usingLockCachingSource = false;
        _currentStreamUrl = streamUrl;
        _setStreamContext(
          songId: songId,
          format: streamFormat,
          maxBitRate: streamMaxBitRate,
          seekByReloadStream: reloadStreamSeek,
        );
        if (!isCurrentSeek()) {
          _schedulePendingSeekIfReady();
          return;
        }
        if (shouldResume) {
          _startPlayback(fadeIn: false);
        }
        _seekDbg('seek fallback completed now=${player.position}');
        return;
      } catch (e) {
        if (!isCurrentSeek()) return;
        Logger.warn('Seek fallback direct stream failed, keep lock cache', e);
        _seekDbg(
          'seek fallback direct stream failed, '
          'keep synthetic position target=$target',
        );
        _syntheticPositionFallbackActive = true;
        if (isCurrentSeek() && mounted) {
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
      if (!isCurrentSeek()) return;
    }
    await player.seek(sourceTarget);
    if (!isCurrentSeek()) return;
    if (shouldResume) {
      _startPlayback(fadeIn: false);
    }
    await Future<void>.delayed(const Duration(milliseconds: 120));
    if (!isCurrentSeek()) return;
    _seekDbg('seek retry completed now=${player.position}');
  }

  Future<bool> _trySeekByReloadingLockCache({
    required AudioPlayer player,
    required Duration target,
    required bool shouldResume,
    required String songId,
    required bool Function() isCurrentSeek,
    required bool Function() ownsSource,
  }) async {
    if (!isCurrentSeek()) return false;

    final currentStreamUrl = _currentStreamUrl;
    if (currentStreamUrl == null) return false;
    final reloadUrl = _withoutTimeOffset(currentStreamUrl);
    final streamFormat = _currentStreamFormat;
    final streamMaxBitRate = _currentStreamMaxBitRate;
    final reloadStreamSeek = _seekByReloadStream;

    _seekDbg(
      'seek fallback -> lock-cache reload target=$target '
      'format=$streamFormat maxBitRate=$streamMaxBitRate cache=temporary',
    );
    _playDbg(
      'seek_lock_cache_reload '
      'url=${_summarizeStreamUrl(reloadUrl)} cache=temporary',
    );

    // ignore: experimental_member_use
    final audioSource = LockCachingAudioSource(Uri.parse(reloadUrl));
    final sourceReady = await _replaceLoadedSource(
      songId: songId,
      label: 'seek_lock_cache_reload',
      ownsSource: ownsSource,
      setSource: (sourcePlayer) async {
        await sourcePlayer.setAudioSource(audioSource, initialPosition: target);
      },
    );
    if (!sourceReady) return false;
    // This is a temporary retry source. Do not let it replace or register the
    // normal full-song cache entry; bufferedPositionStream is sufficient.
    _replaceDownloadProgressSubscription(null);
    _usingLockCachingSource = true;
    _currentStreamUrl = reloadUrl;
    _setStreamContext(
      songId: songId,
      format: streamFormat,
      maxBitRate: streamMaxBitRate,
      seekByReloadStream: reloadStreamSeek,
    );
    if (!isCurrentSeek()) {
      _schedulePendingSeekIfReady();
      return true;
    }
    if (shouldResume) {
      _startPlayback();
    }

    await Future<void>.delayed(const Duration(milliseconds: 220));
    if (!isCurrentSeek()) return true;
    final actual = _logicalPlayerPosition(player.position);
    final drift = (actual - target).inMilliseconds.abs();
    _seekDbg(
      'seek fallback lock-cache reload verify target=$target '
      'sourceActual=${player.position} actual=$actual driftMs=$drift',
    );

    if (actual <= const Duration(milliseconds: 50)) {
      // 底层 position 仍可能卡 0，保持 UI 在用户拖动位置，后续由合成进度推进。
      _syntheticPositionFallbackActive = true;
      if (isCurrentSeek() && mounted) {
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
    return _isApplePlatform && url.startsWith('http://');
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
    Duration sourcePositionOffset = Duration.zero,
  }) {
    _currentStreamSongId = songId;
    _currentStreamFormat = format;
    _currentStreamMaxBitRate = maxBitRate;
    _seekByReloadStream = seekByReloadStream;
    _setSourcePositionOffset(sourcePositionOffset);
  }

  void _clearStreamContext() {
    _currentStreamSongId = null;
    _currentStreamFormat = null;
    _currentStreamMaxBitRate = null;
    _seekByReloadStream = false;
    _setSourcePositionOffset(Duration.zero);
  }

  void _setSourcePositionOffset(Duration offset) {
    final normalized = offset < Duration.zero ? Duration.zero : offset;
    if (_sourcePositionOffset == normalized) return;
    _sourcePositionOffset = normalized;
    _audioHandler?.setPositionOffset(normalized);
    _seekDbg('source timeline offset updated: $normalized');
  }

  Duration _logicalPlayerPosition(Duration sourcePosition) {
    return addPlaybackPositionOffset(
      sourcePosition,
      _sourcePositionOffset,
      maximum: state.duration > Duration.zero ? state.duration : null,
    );
  }

  Duration _sourceSeekPosition(Duration logicalPosition) {
    final sourcePosition = logicalPosition - _sourcePositionOffset;
    return sourcePosition < Duration.zero ? Duration.zero : sourcePosition;
  }

  String _withoutTimeOffset(String url) {
    final uri = Uri.parse(url);
    final query = Map<String, String>.from(uri.queryParameters)
      ..remove('timeOffset');
    return uri.replace(queryParameters: query).toString();
  }

  bool _isPlaybackContextCurrent({
    required int session,
    required String songId,
  }) {
    return _playDebugSession == session && state.currentSong?.id == songId;
  }

  void _invalidateLoadedSource({required String reason}) {
    _sourceGeneration += 1;
    _loadedSourceSongId = null;
    _playDbg('source invalidated generation=$_sourceGeneration reason=$reason');
  }

  Future<bool> _replaceLoadedSource({
    required String songId,
    required String label,
    required bool Function() ownsSource,
    required Future<void> Function(AudioPlayer player) setSource,
  }) async {
    final player = _audioPlayer;
    if (player == null || !ownsSource()) {
      _playDbg('source=$label setup abandoned before load song=$songId');
      return false;
    }

    final generation = ++_sourceGeneration;
    _loadedSourceSongId = null;
    _playDbg('source=$label load begin song=$songId generation=$generation');

    try {
      await setSource(player);
    } catch (_) {
      if (_sourceGeneration == generation) {
        _loadedSourceSongId = null;
      }
      rethrow;
    }

    if (_sourceGeneration != generation ||
        !ownsSource() ||
        player.audioSource == null) {
      _playDbg(
        'source=$label load abandoned song=$songId generation=$generation '
        'currentGeneration=$_sourceGeneration',
      );
      return false;
    }

    _loadedSourceSongId = songId;
    _playDbg('source=$label load ready song=$songId generation=$generation');
    return true;
  }

  void _replaceDownloadProgressSubscription(StreamSubscription? next) {
    final previous = _downloadProgressSubscription;
    _downloadProgressSubscription = next;
    if (previous != null && !identical(previous, next)) {
      unawaited(previous.cancel());
    }
  }

  void _invalidateSeekRequests() {
    _seekRequestGeneration += 1;
    _activeSeekGeneration = null;
    _activeSeekSongId = null;
  }

  bool _isSeekRequestCurrent({
    required int seekGeneration,
    required int playbackSession,
    required String songId,
  }) {
    return _seekRequestGeneration == seekGeneration &&
        _isPlaybackContextCurrent(session: playbackSession, songId: songId);
  }

  void _releaseSeekAnchor(int seekGeneration) {
    if (_activeSeekGeneration != seekGeneration) return;
    _activeSeekGeneration = null;
    _activeSeekSongId = null;
  }

  void _schedulePendingSeekIfReady() {
    if (!mounted || _isApplyingPendingSeek) return;
    final player = _audioPlayer;
    final currentSongId = state.currentSong?.id;
    if (player == null || currentSongId == null) return;
    if (!shouldPreservePendingSeekPosition(
      pendingPosition: _pendingSeekPosition,
      pendingSongId: _pendingSeekSongId,
      currentSongId: currentSongId,
    )) {
      return;
    }
    if (!canSeekLoadedPlayerSource(
      processingState: player.processingState,
      loadedSourceSongId: _loadedSourceSongId,
      currentSongId: currentSongId,
    )) {
      return;
    }
    unawaited(_applyPendingSeekIfNeeded());
  }

  bool _shouldPreserveSeekPosition() {
    final currentSongId = state.currentSong?.id;
    return shouldPreservePendingSeekPosition(
          pendingPosition: _pendingSeekPosition,
          pendingSongId: _pendingSeekSongId,
          currentSongId: currentSongId,
        ) ||
        (_activeSeekGeneration == _seekRequestGeneration &&
            _activeSeekSongId != null &&
            _activeSeekSongId == currentSongId);
  }

  void _startPositionPolling(AudioPlayer player) {
    _positionPollTimer?.cancel();
    _positionPollTimer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      if (!mounted) return;
      if (state.currentSong == null) return;
      if (_shouldPreserveSeekPosition()) {
        return;
      }

      final sourcePlayerPos = player.position;
      final playerPos = _logicalPlayerPosition(sourcePlayerPos);
      final processing = player.processingState;
      final isReadyPlaying =
          player.playing && processing == ProcessingState.ready;

      final deltaFromLast = (sourcePlayerPos - _lastPolledPlayerPosition)
          .inMilliseconds
          .abs();
      if (deltaFromLast <= 150) {
        _stagnantPositionTicks += 1;
      } else {
        _stagnantPositionTicks = 0;
      }
      _lastPolledPlayerPosition = sourcePlayerPos;

      // 正常情况下用底层播放器位置对齐 UI 进度。
      final drift = (playerPos - state.position).inMilliseconds.abs();
      final keepSyntheticProgress =
          _syntheticPositionFallbackActive &&
          _usingLockCachingSource &&
          isReadyPlaying &&
          sourcePlayerPos <= const Duration(milliseconds: 50);
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
            sourcePlayerPos > Duration.zero &&
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
          'sourcePlayerPos=$sourcePlayerPos playerPos=$playerPos '
          'statePos=${state.position} '
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
          'sourcePlayerPos=$sourcePlayerPos playerPos=$playerPos '
          'statePos=${state.position} '
          'driftMs=$drift song=${state.currentSong?.id}',
        );
      }

      // iOS + LockCachingAudioSource 某些流上 position 可能卡在 0。
      // 当确认持续卡住时，按时间片推进 UI 进度，避免进度条一直 0:00。
      final shouldUseSyntheticPosition =
          _usingLockCachingSource &&
          isReadyPlaying &&
          sourcePlayerPos <= const Duration(milliseconds: 50) &&
          state.duration > Duration.zero &&
          _stagnantPositionTicks >= 6;
      if (shouldUseSyntheticPosition &&
          _stagnantPositionTicks != _lastStagnantLogTick &&
          _stagnantPositionTicks % 6 == 0) {
        _lastStagnantLogTick = _stagnantPositionTicks;
        _playDbg(
          'position_stagnant ticks=$_stagnantPositionTicks '
          'sourcePlayerPos=$sourcePlayerPos playerPos=$playerPos '
          'statePos=${state.position} '
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

  /// 从缓存文件注册缓存元数据（downloadProgressStream 到 1.0 时调用）
  Future<void> _registerCacheFromFile(
    String cacheFilePath,
    String songId,
    String libraryId,
    AudioQualityLevel quality,
  ) => _cacheHandler.registerCacheFromFile(
    cacheFilePath,
    songId,
    libraryId,
    quality,
  );

  /// 预缓存队列中下一首歌
  void _preCacheNextSong() => _cacheHandler.preCacheNextSong(
    state: state,
    needsTranscoding: _needsTranscoding,
    seekDbg: _seekDbg,
  );

  @override
  void dispose() {
    _playbackSessionPersistTimer?.cancel();
    unawaited(_persistPlaybackSession());
    _positionPollTimer?.cancel();
    _cancelFade();
    _downloadProgressSubscription?.cancel();
    _networkTypeSubscription?.cancel();
    // Check if initialized/assigned before disposing
    // Since it was 'late', we can't check.
    // Converting to nullable field:
    _audioPlayer?.dispose();
    _audioHandler?.stop(); // Ensure handler is stopped too
    super.dispose();
  }
}
