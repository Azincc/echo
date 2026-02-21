enum OfflineDownloadTaskStatus {
  queued,
  resolving,
  downloading,
  tagging,
  moving,
  scanning,
  paused,
  completed,
  failed,
  removed,
}

extension OfflineDownloadTaskStatusExt on OfflineDownloadTaskStatus {
  String get displayName => switch (this) {
    OfflineDownloadTaskStatus.queued => '等待中',
    OfflineDownloadTaskStatus.resolving => '解析中',
    OfflineDownloadTaskStatus.downloading => '下载中',
    OfflineDownloadTaskStatus.tagging => '写入标签',
    OfflineDownloadTaskStatus.moving => '移动文件',
    OfflineDownloadTaskStatus.scanning => '扫描中',
    OfflineDownloadTaskStatus.paused => '已暂停',
    OfflineDownloadTaskStatus.completed => '已完成',
    OfflineDownloadTaskStatus.failed => '失败',
    OfflineDownloadTaskStatus.removed => '已移除',
  };
}

class OfflineDownloadTask {
  final String id;
  final String libraryId;
  final String title;
  final String? artist;
  final String? album;
  final String source;
  final String trackId;
  final String? lyricId;
  final String? picId;
  final String? coverUrl;
  final String? streamUrl;
  final String? qualityLabel;
  final String embedJobId; // 改为 embedJobId
  final String? saveDir;
  final String? fileName;
  final OfflineDownloadTaskStatus status;
  final int? progress; // 改为可选，支持 0-100 进度
  final int totalBytes;
  final int completedBytes;
  final int downloadSpeed;
  final String? errorMessage;
  final String? statusMessage; // 新增：状态消息
  final int createdAt;
  final int updatedAt;

  const OfflineDownloadTask({
    required this.id,
    required this.libraryId,
    required this.title,
    this.artist,
    this.album,
    required this.source,
    required this.trackId,
    this.lyricId,
    this.picId,
    this.coverUrl,
    this.streamUrl,
    this.qualityLabel,
    required this.embedJobId,
    this.saveDir,
    this.fileName,
    this.status = OfflineDownloadTaskStatus.queued,
    this.progress,
    this.totalBytes = 0,
    this.completedBytes = 0,
    this.downloadSpeed = 0,
    this.errorMessage,
    this.statusMessage,
    required this.createdAt,
    required this.updatedAt,
  });

  double get progressRatio {
    // 优先使用服务端返回的 progress (0-100)
    if (progress != null) {
      return progress! / 100.0;
    }
    // 回退到字节进度计算
    if (totalBytes <= 0) return 0;
    return completedBytes / totalBytes;
  }

  OfflineDownloadTask copyWith({
    String? coverUrl,
    String? streamUrl,
    String? qualityLabel,
    OfflineDownloadTaskStatus? status,
    int? progress,
    int? totalBytes,
    int? completedBytes,
    int? downloadSpeed,
    String? errorMessage,
    String? statusMessage,
    int? updatedAt,
  }) {
    return OfflineDownloadTask(
      id: id,
      libraryId: libraryId,
      title: title,
      artist: artist,
      album: album,
      source: source,
      trackId: trackId,
      lyricId: lyricId,
      picId: picId,
      coverUrl: coverUrl ?? this.coverUrl,
      streamUrl: streamUrl ?? this.streamUrl,
      qualityLabel: qualityLabel ?? this.qualityLabel,
      embedJobId: embedJobId,
      saveDir: saveDir,
      fileName: fileName,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      totalBytes: totalBytes ?? this.totalBytes,
      completedBytes: completedBytes ?? this.completedBytes,
      downloadSpeed: downloadSpeed ?? this.downloadSpeed,
      errorMessage: errorMessage ?? this.errorMessage,
      statusMessage: statusMessage ?? this.statusMessage,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class OfflineDownloadSummary {
  final int queued;
  final int downloading;
  final int paused;
  final int completed;
  final int failed;

  const OfflineDownloadSummary({
    this.queued = 0,
    this.downloading = 0,
    this.paused = 0,
    this.completed = 0,
    this.failed = 0,
  });

  int get active => queued + downloading;
  int get total => queued + downloading + paused + completed + failed;
}
