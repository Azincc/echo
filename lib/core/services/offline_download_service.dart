import 'dart:async';

import 'package:uuid/uuid.dart';

import '../../core/utils/logger.dart';
import '../../data/models/embed_service_config.dart';
import '../../data/models/offline_download_task.dart';
import '../../data/models/song.dart';
import '../../data/sources/remote/embed_service_client.dart';

class OfflineDownloadService {
  static const _logTag = 'OFFLINE_DL';
  final EmbedServiceClient _embedClient;

  final List<OfflineDownloadTask> _tasks = [];
  final Map<String, EmbedServiceConfig> _taskConfigs = {};
  final _taskController =
      StreamController<List<OfflineDownloadTask>>.broadcast();

  Timer? _pollTimer;

  OfflineDownloadService({
    required EmbedServiceClient embedClient,
  }) : _embedClient = embedClient;

  Stream<List<OfflineDownloadTask>> get tasksStream async* {
    yield List.unmodifiable(_tasks);
    yield* _taskController.stream;
  }

  List<OfflineDownloadTask> get tasks => List.unmodifiable(_tasks);

  Future<void> testConnection(EmbedServiceConfig config) async {
    if (!config.isConfigured) {
      throw Exception('请先完整填写 Embed Service 地址与 API Key');
    }
    Logger.infoWithTag(_logTag, 'testConnection url=${config.baseUrl}');
    await _embedClient.testConnection(config);
    Logger.infoWithTag(_logTag, 'testConnection success url=${config.baseUrl}');
  }

  Future<void> enqueuePreviewSong({
    required Song song,
    required String libraryId,
    required EmbedServiceConfig config,
  }) async {
    final source = (song.previewSource ?? '').trim();
    final trackId = (song.previewTrackId ?? '').trim();
    Logger.infoWithTag(
      _logTag,
      'enqueue start library=$libraryId source=$source track=$trackId title="${song.title}"',
    );

    try {
      if (!config.isConfigured) {
        throw Exception('当前音乐库未配置 Embed Service');
      }

      if (!song.isPreview) {
        throw Exception('仅支持将试听歌曲加入离线队列');
      }

      if (source.isEmpty || trackId.isEmpty) {
        throw Exception('试听歌曲缺少必要元数据（source/trackId）');
      }

      final duplicate = _tasks.any(
        (task) =>
            task.libraryId == libraryId &&
            task.source == source &&
            task.trackId == trackId &&
            task.status != OfflineDownloadTaskStatus.failed &&
            task.status != OfflineDownloadTaskStatus.removed,
      );
      if (duplicate) {
        throw Exception('该歌曲已在离线队列中');
      }

      // 提交任务到 Embed Service
      final jobId = await _embedClient.submitJob(
        config: config,
        source: source,
        trackId: trackId,
        libraryId: config.libraryId,
        quality: 'best',
        title: song.title,
        artist: song.artist,
        album: song.album,
      );

      final now = DateTime.now().millisecondsSinceEpoch;
      final task = OfflineDownloadTask(
        id: const Uuid().v4(),
        libraryId: libraryId,
        title: song.title,
        artist: song.artist,
        album: song.album,
        source: source,
        trackId: trackId,
        lyricId: song.previewLyricId,
        picId: song.previewPicId,
        embedJobId: jobId,
        status: OfflineDownloadTaskStatus.queued,
        createdAt: now,
        updatedAt: now,
      );

      _taskConfigs[task.id] = config;
      _tasks.insert(0, task);
      _emit();

      Logger.infoWithTag(
        _logTag,
        'enqueue queued jobId=$jobId source=$source track=$trackId',
      );
      _startPolling();
      await _refreshTask(task.id);
    } catch (e, st) {
      Logger.errorWithTag(
        _logTag,
        'enqueue failed source=$source track=$trackId title="${song.title}"',
        e,
        st,
      );
      rethrow;
    }
  }

  Future<void> refreshNow() async {
    await _pollOnce();
  }

  void clearFinished() {
    final removedTaskIds = _tasks
        .where(
          (t) =>
              t.status == OfflineDownloadTaskStatus.completed ||
              t.status == OfflineDownloadTaskStatus.failed ||
              t.status == OfflineDownloadTaskStatus.removed,
        )
        .map((t) => t.id)
        .toList();

    _tasks.removeWhere(
      (t) =>
          t.status == OfflineDownloadTaskStatus.completed ||
          t.status == OfflineDownloadTaskStatus.failed ||
          t.status == OfflineDownloadTaskStatus.removed,
    );
    for (final taskId in removedTaskIds) {
      _taskConfigs.remove(taskId);
    }
    _emit();
  }

  Future<void> retryTask(String taskId) async {
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index < 0) {
      throw Exception('任务不存在');
    }

    final task = _tasks[index];
    final config = _taskConfigs[task.id];
    if (config == null) {
      throw Exception('任务配置丢失');
    }

    try {
      await _embedClient.retryJob(
        config: config,
        jobId: task.embedJobId,
      );

      final updated = task.copyWith(
        status: OfflineDownloadTaskStatus.queued,
        errorMessage: null,
        statusMessage: '重试中...',
        updatedAt: DateTime.now().millisecondsSinceEpoch,
      );

      _tasks[index] = updated;
      _emit();

      Logger.infoWithTag(_logTag, 'task retry jobId=${task.embedJobId}');
      _startPolling();
    } catch (e) {
      Logger.errorWithTag(_logTag, 'task retry failed jobId=${task.embedJobId}', e);
      rethrow;
    }
  }

  Future<void> _pollOnce() async {
    final pollTargets = _tasks
        .where(
          (t) =>
              t.status == OfflineDownloadTaskStatus.queued ||
              t.status == OfflineDownloadTaskStatus.resolving ||
              t.status == OfflineDownloadTaskStatus.downloading ||
              t.status == OfflineDownloadTaskStatus.tagging ||
              t.status == OfflineDownloadTaskStatus.moving ||
              t.status == OfflineDownloadTaskStatus.scanning ||
              t.status == OfflineDownloadTaskStatus.paused,
        )
        .toList();

    if (pollTargets.isEmpty) return;

    await Future.wait(pollTargets.map((t) => _refreshTask(t.id)));
  }

  Future<void> _refreshTask(String taskId) async {
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index < 0) return;

    final task = _tasks[index];
    final config = _taskConfigs[task.id];
    if (config == null) return;

    try {
      final status = await _embedClient.getJobStatus(
        config: config,
        jobId: task.embedJobId,
      );

      final mappedStatus = _mapStatus(status.status);
      final previousStatus = task.status;
      final updated = task.copyWith(
        status: mappedStatus,
        progress: status.progress,
        totalBytes: status.totalBytes,
        completedBytes: status.completedBytes,
        statusMessage: status.message,
        errorMessage: status.error,
        updatedAt: DateTime.now().millisecondsSinceEpoch,
      );

      _tasks[index] = updated;
      _emit();

      if (previousStatus != mappedStatus) {
        Logger.infoWithTag(
          _logTag,
          'task status changed jobId=${task.embedJobId} ${previousStatus.name} -> ${mappedStatus.name}',
        );
      }

      _stopPollingIfIdle();
    } catch (e) {
      final updated = task.copyWith(
        status: OfflineDownloadTaskStatus.failed,
        errorMessage: e.toString(),
        updatedAt: DateTime.now().millisecondsSinceEpoch,
      );
      _tasks[index] = updated;
      _emit();
      Logger.warnWithTag(
        _logTag,
        'task refresh failed jobId=${task.embedJobId} title="${task.title}"',
        e,
      );
      _stopPollingIfIdle();
    }
  }

  OfflineDownloadTaskStatus _mapStatus(String raw) {
    switch (raw.toLowerCase()) {
      case 'queued':
        return OfflineDownloadTaskStatus.queued;
      case 'resolving':
        return OfflineDownloadTaskStatus.resolving;
      case 'downloading':
        return OfflineDownloadTaskStatus.downloading;
      case 'tagging':
        return OfflineDownloadTaskStatus.tagging;
      case 'moving':
        return OfflineDownloadTaskStatus.moving;
      case 'scanning':
        return OfflineDownloadTaskStatus.scanning;
      case 'done':
        return OfflineDownloadTaskStatus.completed;
      case 'failed':
        return OfflineDownloadTaskStatus.failed;
      case 'cancelled':
        return OfflineDownloadTaskStatus.removed;
      default:
        return OfflineDownloadTaskStatus.queued;
    }
  }

  void _startPolling() {
    _pollTimer ??= Timer.periodic(const Duration(seconds: 3), (_) {
      unawaited(_pollOnce());
    });
  }

  void _stopPollingIfIdle() {
    final hasActive = _tasks.any(
      (t) =>
          t.status == OfflineDownloadTaskStatus.queued ||
          t.status == OfflineDownloadTaskStatus.resolving ||
          t.status == OfflineDownloadTaskStatus.downloading ||
          t.status == OfflineDownloadTaskStatus.tagging ||
          t.status == OfflineDownloadTaskStatus.moving ||
          t.status == OfflineDownloadTaskStatus.scanning,
    );

    if (!hasActive) {
      _pollTimer?.cancel();
      _pollTimer = null;
    }
  }

  void _emit() {
    _taskController.add(List.unmodifiable(_tasks));
  }

  void dispose() {
    _pollTimer?.cancel();
    _pollTimer = null;
    _taskController.close();
    _taskConfigs.clear();
  }
}
