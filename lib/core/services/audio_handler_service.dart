import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import '../utils/logger.dart';

/// 音频处理器 - 处理后台播放和通知栏控制
class EchoAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  final AudioPlayer _audioPlayer;

  // 暴露 AudioPlayer 给外部使用
  AudioPlayer get audioPlayer => _audioPlayer;

  // 用于通知外部的回调
  Function()? onSkipToNext;
  Function()? onSkipToPrevious;

  EchoAudioHandler(this._audioPlayer) {
    _init();
  }

  /// 初始化监听器
  void _init() {
    // 监听播放状态变化，同步到通知栏
    _audioPlayer.playingStream.listen((playing) {
      _broadcastState();
    });

    // 监听播放位置
    _audioPlayer.positionStream.listen((position) {
      playbackState.add(playbackState.value.copyWith(updatePosition: position));
    });

    // 监听播放完成
    _audioPlayer.processingStateStream.listen((processingState) {
      _broadcastState();
    });
  }

  /// 广播当前状态到通知栏
  void _broadcastState() {
    playbackState.add(
      playbackState.value.copyWith(
        controls: _getControls(),
        androidCompactActionIndices: const [0, 1, 2],
        processingState: _getProcessingState(),
        playing: _audioPlayer.playing,
        updatePosition: _audioPlayer.position,
        bufferedPosition: _audioPlayer.bufferedPosition,
        speed: _audioPlayer.speed,
      ),
    );
  }

  /// 获取控制按钮
  List<MediaControl> _getControls() {
    return [
      MediaControl.skipToPrevious,
      if (_audioPlayer.playing) MediaControl.pause else MediaControl.play,
      MediaControl.skipToNext,
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

    // 立即设置为播放状态，激活 MediaSession
    playbackState.add(
      playbackState.value.copyWith(
        controls: _getControls(),
        androidCompactActionIndices: const [0, 1, 2],
        processingState: AudioProcessingState.ready,
        playing: true, // 关键：标记为正在播放
        updatePosition: Duration.zero,
        bufferedPosition: Duration.zero,
        speed: 1.0,
      ),
    );
  }

  // ===== 播放控制 =====

  @override
  Future<void> play() async {
    Logger.info('AudioHandler: play');
    await _audioPlayer.play();
  }

  @override
  Future<void> pause() async {
    Logger.info('AudioHandler: pause');
    await _audioPlayer.pause();
  }

  @override
  Future<void> stop() async {
    Logger.info('AudioHandler: stop');
    await _audioPlayer.stop();
    await super.stop();
  }

  @override
  Future<void> seek(Duration position) async {
    Logger.info('AudioHandler: seek to $position');
    await _audioPlayer.seek(position);
  }

  @override
  Future<void> skipToNext() async {
    Logger.info('AudioHandler: skipToNext');
    onSkipToNext?.call();
  }

  @override
  Future<void> skipToPrevious() async {
    Logger.info('AudioHandler: skipToPrevious');
    onSkipToPrevious?.call();
  }

  @override
  Future<void> setSpeed(double speed) async {
    await _audioPlayer.setSpeed(speed);
  }

  /// 清理资源
  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}

/// 初始化 AudioService
Future<EchoAudioHandler> initAudioService() async {
  final audioPlayer = AudioPlayer(
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

  final handler = await AudioService.init(
    builder: () => EchoAudioHandler(audioPlayer),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.example.echo.audio',
      androidNotificationChannelName: 'Echo Music Playback',
      androidNotificationChannelDescription: 'Echo music player controls',
      androidNotificationOngoing: false, // 允许用户手动关闭通知
      androidNotificationIcon: 'drawable/ic_notification',
      androidShowNotificationBadge: true,
      androidStopForegroundOnPause: false, // 暂停时保持通知栏
      fastForwardInterval: Duration(seconds: 10),
      rewindInterval: Duration(seconds: 10),
    ),
  );

  return handler;
}
