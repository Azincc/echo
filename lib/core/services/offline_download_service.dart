import 'dart:async';

import '../../core/utils/logger.dart';
import '../../data/models/embed_service_config.dart';
import '../../data/models/song.dart';
import '../../data/sources/remote/embed_service_client.dart';

/// 离线下载服务 — 所有任务状态从服务端获取，不在本地持久化
class OfflineDownloadService {
  static const _logTag = 'OFFLINE_DL';
  final EmbedServiceClient _embedClient;

  /// 当前任务列表（从服务端获取）
  List<EmbedJobStatus> _jobs = [];
  final _jobsController = StreamController<List<EmbedJobStatus>>.broadcast();

  Timer? _pollTimer;
  EmbedServiceConfig? _lastConfig;

  OfflineDownloadService({required EmbedServiceClient embedClient})
    : _embedClient = embedClient;

  Stream<List<EmbedJobStatus>> get jobsStream async* {
    yield List.unmodifiable(_jobs);
    yield* _jobsController.stream;
  }

  List<EmbedJobStatus> get jobs => List.unmodifiable(_jobs);

  /// 测试连接
  Future<void> testConnection(EmbedServiceConfig config) async {
    if (!config.isConfigured) {
      throw Exception('请先完整填写 Embed Service 地址与 API Key');
    }
    Logger.infoWithTag(_logTag, 'testConnection url=${config.baseUrl}');
    await _embedClient.testConnection(config);
    Logger.infoWithTag(_logTag, 'testConnection success url=${config.baseUrl}');
  }

  /// 提交下载任务
  Future<void> enqueuePreviewSong({
    required Song song,
    required String libraryId,
    required EmbedServiceConfig config,
    bool force = false,
  }) async {
    final source = (song.previewSource ?? '').trim();
    final trackId = (song.previewTrackId ?? '').trim();
    Logger.infoWithTag(
      _logTag,
      'enqueue start library=$libraryId source=$source track=$trackId title="${song.title}" force=$force',
    );

    if (!config.isConfigured) {
      throw Exception('当前音乐库未配置 Embed Service');
    }

    if (!song.isPreview) {
      throw Exception('仅支持将试听歌曲加入离线队列');
    }

    if (source.isEmpty || trackId.isEmpty) {
      throw Exception('试听歌曲缺少必要元数据（source/trackId）');
    }

    _lastConfig = config;

    final jobId = await _embedClient.submitJob(
      config: config,
      source: source,
      trackId: trackId,
      libraryId: config.libraryId,
      quality: 'best',
      force: force,
      title: song.title,
      artist: song.artist,
      album: song.album,
    );

    Logger.infoWithTag(
      _logTag,
      'enqueue success jobId=$jobId source=$source track=$trackId',
    );

    // 提交后立即刷新列表
    await refreshNow(config: config);
    _startPolling();
  }

  /// 从服务端拉取最新任务列表
  Future<void> refreshNow({EmbedServiceConfig? config}) async {
    final cfg = config ?? _lastConfig;
    if (cfg == null || !cfg.isConfigured) return;

    _lastConfig = cfg;

    try {
      _jobs = await _embedClient.listJobs(config: cfg);
      _emit();

      Logger.debugWithTag(
        _logTag,
        'refreshed ${_jobs.length} jobs from server',
      );

      _stopPollingIfIdle();
    } catch (e) {
      Logger.warnWithTag(_logTag, 'refresh jobs failed', e);
    }
  }

  /// 重试失败的任务
  Future<void> retryTask(String jobId) async {
    final cfg = _lastConfig;
    if (cfg == null || !cfg.isConfigured) {
      throw Exception('Embed Service 未配置');
    }

    Logger.infoWithTag(_logTag, 'retry task jobId=$jobId');
    await _embedClient.retryJob(config: cfg, jobId: jobId);
    await refreshNow();
    _startPolling();
  }

  /// 取消任务
  Future<void> cancelTask(String jobId) async {
    final cfg = _lastConfig;
    if (cfg == null || !cfg.isConfigured) {
      throw Exception('Embed Service 未配置');
    }

    Logger.infoWithTag(_logTag, 'cancel task jobId=$jobId');
    await _embedClient.cancelJob(config: cfg, jobId: jobId);
    await refreshNow();
  }

  /// 删除单个任务
  Future<void> deleteTask(String jobId) async {
    final cfg = _lastConfig;
    if (cfg == null || !cfg.isConfigured) {
      throw Exception('Embed Service 未配置');
    }

    Logger.infoWithTag(_logTag, 'delete task jobId=$jobId');
    await _embedClient.deleteJob(config: cfg, jobId: jobId);
    await refreshNow();
  }

  /// 批量删除任务
  Future<void> batchDeleteTasks(List<String> jobIds) async {
    final cfg = _lastConfig;
    if (cfg == null || !cfg.isConfigured) {
      throw Exception('Embed Service 未配置');
    }

    Logger.infoWithTag(_logTag, 'batch delete ${jobIds.length} tasks');
    await _embedClient.batchDeleteJobs(config: cfg, jobIds: jobIds);
    await refreshNow();
  }

  /// 设置当前配置并加载任务（用于页面初始化）
  void setConfig(EmbedServiceConfig config) {
    if (!config.isConfigured) return;
    _lastConfig = config;
    refreshNow(config: config);
    _startPolling();
  }

  void _startPolling() {
    _pollTimer ??= Timer.periodic(const Duration(seconds: 3), (_) {
      refreshNow();
    });
  }

  void _stopPollingIfIdle() {
    final hasActive = _jobs.any((j) => j.isActive);
    if (!hasActive) {
      _pollTimer?.cancel();
      _pollTimer = null;
    }
  }

  void _emit() {
    _jobsController.add(List.unmodifiable(_jobs));
  }

  void dispose() {
    _pollTimer?.cancel();
    _pollTimer = null;
    _jobsController.close();
  }
}
