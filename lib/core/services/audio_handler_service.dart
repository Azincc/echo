import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import '../utils/logger.dart';

/// 音频处理器 - 处理后台播放和通知栏控制
class EchoAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  final AudioPlayer _audioPlayer;

  EchoAudioHandler(this._audioPlayer) {
    _init();
  }

  /// 初始化监听器
  void _init() {
    // 监听播放状态
    _audioPlayer.playbackEventStream.listen((event) {
      _broadcastState();
    });

    // 监听播放位置
    _audioPlayer.positionStream.listen((position) {
      playbackState.add(playbackState.value.copyWith(
        updatePosition: position,
      ));
    });

    // 监听播放完成
    _audioPlayer.processingStateStream.listen((processingState) {
      if (processingState == ProcessingState.completed) {
        // 播放完成，通知外部
        _broadcastState();
      }
    });
  }

  /// 广播当前状态到通知栏
  void _broadcastState() {
    playbackState.add(playbackState.value.copyWith(
      controls: _getControls(),
      androidCompactActionIndices: const [0, 1, 2],
      processingState: _getProcessingState(),
      playing: _audioPlayer.playing,
      updatePosition: _audioPlayer.position,
      bufferedPosition: _audioPlayer.bufferedPosition,
      speed: _audioPlayer.speed,
    ));
  }

  /// 获取控制按钮
  List<MediaControl> _getControls() {
    return [
      MediaControl.skipToPrevious,
      if (_audioPlayer.playing) MediaControl.pause else MediaControl.play,
      MediaControl.skipToNext,
      MediaControl.stop,
    ];
  }

  /// 获取处理状态
  AudioProcessingState _getProcessingState() {
    switch (_audioPlayer.processingState) {
      case ProcessingState.idle:
        return AudioProcessingState.idle;
      case ProcessingState.loading:
        return AudioProcessingState.loading;
      case ProcessingState.buffering:
        return AudioProcessingState.buffering;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
    }
  }

  /// 更新媒体信息（歌曲切换时调用）
  @override
  Future<void> updateMediaItem(MediaItem item) async {
    mediaItem.add(item);
    _broadcastState();
  }

  // ===== 播放控制 =====

  @override
  Future<void> play() async {
    Logger.info('AudioHandler: play');
    await _audioPlayer.play();
    _broadcastState();
  }

  @override
  Future<void> pause() async {
    Logger.info('AudioHandler: pause');
    await _audioPlayer.pause();
    _broadcastState();
  }

  @override
  Future<void> stop() async {
    Logger.info('AudioHandler: stop');
    await _audioPlayer.stop();
    playbackState.add(playbackState.value.copyWith(
      processingState: AudioProcessingState.idle,
      playing: false,
    ));
    await super.stop();
  }

  @override
  Future<void> seek(Duration position) async {
    Logger.info('AudioHandler: seek to $position');
    await _audioPlayer.seek(position);
    _broadcastState();
  }

  @override
  Future<void> skipToNext() async {
    Logger.info('AudioHandler: skipToNext');
    // 由 PlayerProvider 处理
    // 这里只是触发事件，实际逻辑在外部
  }

  @override
  Future<void> skipToPrevious() async {
    Logger.info('AudioHandler: skipToPrevious');
    // 由 PlayerProvider 处理
  }

  @override
  Future<void> setSpeed(double speed) async {
    await _audioPlayer.setSpeed(speed);
    _broadcastState();
  }

  /// 清理资源
  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}

/// 初始化 AudioService
Future<EchoAudioHandler> initAudioService() async {
  final audioPlayer = AudioPlayer();

  final handler = await AudioService.init(
    builder: () => EchoAudioHandler(audioPlayer),
    config: AudioServiceConfig(
      androidNotificationChannelId: 'com.echo.audio',
      androidNotificationChannelName: 'Echo Music Playback',
      androidNotificationOngoing: true,
      androidNotificationIcon: 'mipmap/ic_launcher',
      androidShowNotificationBadge: true,
      androidStopForegroundOnPause: false,
      fastForwardInterval: Duration(seconds: 10),
      rewindInterval: Duration(seconds: 10),
    ),
  );

  return handler;
}
