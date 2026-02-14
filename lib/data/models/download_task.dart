/// 下载任务模型
class DownloadTask {
  final String id;
  final String libraryId;
  final String songId;
  final String title;
  final String? artist;
  final String? album;
  final String? coverArt;
  final int? duration;
  final String? suffix;
  final String? filePath;
  final int? fileSize;
  final DownloadTaskStatus status;
  final double progress;
  final String? errorMessage;
  final int createdAt;
  final int? completedAt;

  DownloadTask({
    required this.id,
    required this.libraryId,
    required this.songId,
    required this.title,
    this.artist,
    this.album,
    this.coverArt,
    this.duration,
    this.suffix,
    this.filePath,
    this.fileSize,
    this.status = DownloadTaskStatus.pending,
    this.progress = 0.0,
    this.errorMessage,
    required this.createdAt,
    this.completedAt,
  });

  DownloadTask copyWith({
    String? filePath,
    int? fileSize,
    DownloadTaskStatus? status,
    double? progress,
    String? errorMessage,
    int? completedAt,
  }) {
    return DownloadTask(
      id: id,
      libraryId: libraryId,
      songId: songId,
      title: title,
      artist: artist,
      album: album,
      coverArt: coverArt,
      duration: duration,
      suffix: suffix,
      filePath: filePath ?? this.filePath,
      fileSize: fileSize ?? this.fileSize,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      errorMessage: errorMessage ?? this.errorMessage,
      createdAt: createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  /// 获取时长字符串
  String get durationString {
    if (duration == null) return '--:--';
    final minutes = duration! ~/ 60;
    final seconds = duration! % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

enum DownloadTaskStatus { pending, downloading, completed, failed, paused }

extension DownloadTaskStatusExt on DownloadTaskStatus {
  String get displayName => switch (this) {
    DownloadTaskStatus.pending => '等待中',
    DownloadTaskStatus.downloading => '下载中',
    DownloadTaskStatus.completed => '已完成',
    DownloadTaskStatus.failed => '失败',
    DownloadTaskStatus.paused => '已暂停',
  };

  static DownloadTaskStatus fromString(String value) {
    return DownloadTaskStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => DownloadTaskStatus.pending,
    );
  }
}
