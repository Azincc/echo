import 'dart:async';

import 'package:dio/dio.dart';

import '../../data/models/download_task.dart';
import '../../data/models/song.dart';
import '../../data/repositories/cover_repository.dart';
import '../../data/repositories/download_repository.dart';
import '../../data/sources/subsonic_api_client.dart';
import '../utils/logger.dart';
import 'audio_cache_service.dart';

class DownloadService {
  static const _logTag = 'DOWNLOAD';

  final DownloadRepository _repository;
  final StreamController<Map<String, double>> _progressController =
      StreamController<Map<String, double>>.broadcast();

  DownloadService({
    required Dio dio,
    required SubsonicApiClient apiClient,
    required DownloadRepository repository,
    required CoverRepository coverRepository,
    required AudioCacheService cacheService,
    int maxConcurrent = 3,
  }) : _repository = repository;

  Stream<Map<String, double>> get progressStream => _progressController.stream;

  int get activeCount => 0;

  Future<void> enqueue(Song song, {required String libraryId}) async {
    Logger.warnWithTag(_logTag, 'downloads are disabled on web');
  }

  Future<void> enqueueBatch(
    List<Song> songs, {
    required String libraryId,
  }) async {
    Logger.warnWithTag(_logTag, 'batch downloads are disabled on web');
  }

  Future<void> pause(String taskId) async {
    await _repository.updateTask(
      taskId: taskId,
      status: DownloadTaskStatus.paused,
    );
  }

  Future<void> resume(String taskId) async {
    await _repository.updateTask(
      taskId: taskId,
      status: DownloadTaskStatus.pending,
    );
  }

  Future<void> cancel(String taskId) async {
    await _repository.deleteTask(taskId);
  }

  Future<void> clearCompleted() async {
    await _repository.clearCompleted();
  }

  Future<void> pauseAll() async {
    final tasks = await _repository.getAllTasks();
    for (final task in tasks) {
      if (task.status == DownloadTaskStatus.downloading) {
        await pause(task.id);
      }
    }
  }

  Future<void> resumeAll() async {
    final tasks = await _repository.getAllTasks();
    for (final task in tasks) {
      if (task.status == DownloadTaskStatus.paused) {
        await resume(task.id);
      }
    }
  }

  Future<bool> isDownloaded(String songId, String libraryId) async => false;

  Future<String?> getDownloadedPath(String songId, String libraryId) async {
    return null;
  }

  Future<String> getDownloadDir() async => 'Web unsupported';

  Future<void> ensureTaskCoverCached(DownloadTask task) async {}

  Future<({int valid, int missing, int orphan})> scanLocalFiles() async {
    return (valid: 0, missing: 0, orphan: 0);
  }

  Future<int> cleanOrphanFiles() async => 0;

  Future<({int totalFiles, int totalSizeBytes, int missingFiles})>
  getDownloadStats() async {
    final tasks = await _repository.getAllTasks();
    final completed = tasks
        .where((task) => task.status == DownloadTaskStatus.completed)
        .length;
    return (totalFiles: completed, totalSizeBytes: 0, missingFiles: completed);
  }

  Future<List<DownloadTask>> getDownloadedTasks({String? libraryId}) async {
    return [];
  }

  static Song taskToSong(DownloadTask task) {
    return Song(
      id: task.songId,
      title: task.title,
      artist: task.artist ?? '',
      album: task.album,
      coverArt: task.coverArt,
      duration: task.duration,
      suffix: task.suffix,
      bitRate: task.bitRate,
      contentType: task.contentType,
      size: task.fileSize,
      path: task.filePath,
    );
  }

  void dispose() {
    _progressController.close();
  }
}
