import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
import '../../data/models/download_task.dart';
import '../../data/models/song.dart';
import '../../data/repositories/download_repository.dart';
import '../../data/sources/subsonic_api_client.dart';
import '../utils/logger.dart';

/// 下载服务 — 队列管理 + 并发控制
class DownloadService {
  final Dio _dio;
  final SubsonicApiClient _apiClient;
  final DownloadRepository _repository;
  final int maxConcurrent;

  final _activeDownloads = <String, CancelToken>{};
  final _progressController = StreamController<Map<String, double>>.broadcast();
  final _progress = <String, double>{};

  DownloadService({
    required Dio dio,
    required SubsonicApiClient apiClient,
    required DownloadRepository repository,
    this.maxConcurrent = 3,
  }) : _dio = dio,
       _apiClient = apiClient,
       _repository = repository;

  /// 下载进度 Stream
  Stream<Map<String, double>> get progressStream => _progressController.stream;

  /// 当前活跃下载数
  int get activeCount => _activeDownloads.length;

  /// 添加下载任务（单曲）
  Future<void> enqueue(Song song, {required String libraryId}) async {
    // 检查是否已存在
    final existing = await _repository.getTaskBySongId(song.id, libraryId);
    if (existing != null) {
      if (existing.status == DownloadTaskStatus.completed) {
        Logger.info('Song ${song.title} already downloaded');
        return;
      }
      if (existing.status == DownloadTaskStatus.downloading ||
          existing.status == DownloadTaskStatus.pending) {
        Logger.info('Song ${song.title} already in queue');
        return;
      }
      // failed/paused → 重新下载
      await _repository.deleteTask(existing.id);
    }

    final task = DownloadTask(
      id: const Uuid().v4(),
      libraryId: libraryId,
      songId: song.id,
      title: song.title,
      artist: song.artist,
      album: song.album,
      coverArt: song.coverArt,
      duration: song.duration,
      suffix: song.suffix,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    await _repository.createTask(task);
    _processQueue();
  }

  /// 批量添加（专辑/歌单）
  Future<void> enqueueBatch(
    List<Song> songs, {
    required String libraryId,
  }) async {
    for (final song in songs) {
      await enqueue(song, libraryId: libraryId);
    }
  }

  /// 暂停任务
  Future<void> pause(String taskId) async {
    final cancelToken = _activeDownloads[taskId];
    if (cancelToken != null) {
      cancelToken.cancel('Paused by user');
      _activeDownloads.remove(taskId);
    }
    await _repository.updateTask(
      taskId: taskId,
      status: DownloadTaskStatus.paused,
    );
    _processQueue();
  }

  /// 恢复任务
  Future<void> resume(String taskId) async {
    await _repository.updateTask(
      taskId: taskId,
      status: DownloadTaskStatus.pending,
    );
    _processQueue();
  }

  /// 取消并删除任务（含本地文件）
  Future<void> cancel(String taskId) async {
    // 取消活跃下载
    final cancelToken = _activeDownloads[taskId];
    if (cancelToken != null) {
      cancelToken.cancel('Cancelled by user');
      _activeDownloads.remove(taskId);
    }

    // 删除本地文件
    final tasks = await _repository.getAllTasks();
    final task = tasks.where((t) => t.id == taskId).firstOrNull;
    if (task?.filePath != null) {
      final file = File(task!.filePath!);
      if (await file.exists()) {
        await file.delete();
      }
    }

    await _repository.deleteTask(taskId);
    _processQueue();
  }

  /// 清除所有已完成任务记录
  Future<void> clearCompleted() async {
    await _repository.clearCompleted();
  }

  /// 全部暂停
  Future<void> pauseAll() async {
    for (final taskId in _activeDownloads.keys.toList()) {
      await pause(taskId);
    }
  }

  /// 全部恢复
  Future<void> resumeAll() async {
    final tasks = await _repository.getAllTasks();
    for (final task in tasks) {
      if (task.status == DownloadTaskStatus.paused) {
        await resume(task.id);
      }
    }
  }

  /// 获取歌曲是否已下载
  Future<bool> isDownloaded(String songId, String libraryId) async {
    final task = await _repository.getTaskBySongId(songId, libraryId);
    if (task == null || task.status != DownloadTaskStatus.completed) {
      return false;
    }
    // 验证文件存在
    if (task.filePath != null) {
      return File(task.filePath!).existsSync();
    }
    return false;
  }

  /// 获取已下载歌曲的本地路径
  Future<String?> getDownloadedPath(String songId, String libraryId) async {
    final task = await _repository.getTaskBySongId(songId, libraryId);
    if (task == null || task.status != DownloadTaskStatus.completed) {
      return null;
    }
    if (task.filePath != null && File(task.filePath!).existsSync()) {
      return task.filePath;
    }
    return null;
  }

  /// 处理下载队列
  void _processQueue() async {
    if (_activeDownloads.length >= maxConcurrent) return;

    final pending = await _repository.getPendingTasks();
    for (final task in pending) {
      if (_activeDownloads.length >= maxConcurrent) break;
      if (_activeDownloads.containsKey(task.id)) continue;

      _startDownload(task);
    }
  }

  /// 开始下载
  Future<void> _startDownload(DownloadTask task) async {
    final cancelToken = CancelToken();
    _activeDownloads[task.id] = cancelToken;

    await _repository.updateTask(
      taskId: task.id,
      status: DownloadTaskStatus.downloading,
    );

    try {
      // 构建下载 URL（始终下载原始文件）
      final downloadUrl = _apiClient.getDownloadUrl(task.songId);
      if (downloadUrl.isEmpty) {
        throw Exception('Cannot build download URL');
      }

      // 构建保存路径
      final savePath = await _getSavePath(
        task.libraryId,
        task.songId,
        task.suffix ?? 'mp3',
      );

      // 确保目录存在
      final dir = Directory(p.dirname(savePath));
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }

      // 使用单独的 Dio 实例下载（不走 FallbackInterceptor）
      await _dio.download(
        downloadUrl,
        savePath,
        cancelToken: cancelToken,
        onReceiveProgress: (received, total) {
          if (total > 0) {
            final progress = received / total;
            _progress[task.id] = progress;
            _progressController.add(Map.from(_progress));

            // 每 10% 更新数据库
            if ((progress * 10).floor() > ((task.progress) * 10).floor()) {
              _repository.updateTask(taskId: task.id, progress: progress);
            }
          }
        },
      );

      // 下载完成
      final file = File(savePath);
      final fileSize = await file.length();

      await _repository.updateTask(
        taskId: task.id,
        status: DownloadTaskStatus.completed,
        progress: 1.0,
        filePath: savePath,
        fileSize: fileSize,
        completedAt: DateTime.now().millisecondsSinceEpoch,
      );

      Logger.info('Downloaded: ${task.title}');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        Logger.info('Download cancelled: ${task.title}');
      } else {
        Logger.error('Download failed: ${task.title}', e);
        await _repository.updateTask(
          taskId: task.id,
          status: DownloadTaskStatus.failed,
          errorMessage: e.message ?? 'Download failed',
        );
      }
    } catch (e) {
      Logger.error('Download failed: ${task.title}', e);
      await _repository.updateTask(
        taskId: task.id,
        status: DownloadTaskStatus.failed,
        errorMessage: e.toString(),
      );
    } finally {
      _activeDownloads.remove(task.id);
      _progress.remove(task.id);
      _processQueue(); // 处理下一个
    }
  }

  /// 获取文件保存路径
  Future<String> _getSavePath(
    String libraryId,
    String songId,
    String suffix,
  ) async {
    final appDir = await getApplicationDocumentsDirectory();
    return p.join(appDir.path, 'echo_downloads', libraryId, '$songId.$suffix');
  }

  void dispose() {
    for (final token in _activeDownloads.values) {
      token.cancel('Service disposed');
    }
    _activeDownloads.clear();
    _progressController.close();
  }
}
