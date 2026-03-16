import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
import '../../data/models/audio_quality.dart';
import '../../data/models/download_task.dart';
import '../../data/repositories/cover_repository.dart';
import '../../data/models/song.dart';
import '../../data/repositories/download_repository.dart';
import '../../data/sources/subsonic_api_client.dart';
import '../utils/cover_ref_security.dart';
import '../utils/logger.dart';
import 'audio_cache_service.dart';
import 'storage_permission_service.dart';
import '../utils/download_path_utils.dart';

/// 下载服务 — 队列管理 + 并发控制
class DownloadService {
  static const _logTag = 'DOWNLOAD';
  final Dio _dio;
  final SubsonicApiClient _apiClient;
  final DownloadRepository _repository;
  final CoverRepository _coverRepository;
  final AudioCacheService _cacheService;
  final int maxConcurrent;

  final _activeDownloads = <String, CancelToken>{};
  final _coverEnsuring = <String>{};
  final _progressController = StreamController<Map<String, double>>.broadcast();
  final _progress = <String, double>{};

  DownloadService({
    required Dio dio,
    required SubsonicApiClient apiClient,
    required DownloadRepository repository,
    required CoverRepository coverRepository,
    required AudioCacheService cacheService,
    this.maxConcurrent = 3,
  }) : _dio = dio,
       _apiClient = apiClient,
       _repository = repository,
       _coverRepository = coverRepository,
       _cacheService = cacheService;

  /// 下载进度 Stream
  Stream<Map<String, double>> get progressStream => _progressController.stream;

  /// 当前活跃下载数
  int get activeCount => _activeDownloads.length;

  /// 添加下载任务（单曲）
  /// 如果歌曲已缓存，直接将缓存文件复制为下载文件，无需重新下载
  Future<void> enqueue(Song song, {required String libraryId}) async {
    // Android 下载到公共目录前先检查权限
    if (!kIsWeb && Platform.isAndroid) {
      final granted = await StoragePermissionService.ensureStoragePermission();
      if (!granted) {
        throw Exception('需要存储权限才能下载音乐');
      }
    }

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

    // 检查是否已有缓存文件 → 直接复制为下载文件
    final cachedPath = await _cacheService.getCachedPath(
      songId: song.id,
      libraryId: libraryId,
      quality: AudioQualityLevel.original,
    );
    if (cachedPath != null && File(cachedPath).existsSync()) {
      await _promoteCacheToDownload(song, libraryId, cachedPath);
      return;
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
      bitRate: song.bitRate,
      contentType: song.contentType,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    await _repository.createTask(task);
    _processQueue();
  }

  /// 将已缓存文件提升为下载文件（复制到下载目录 + 创建任务记录）
  Future<void> _promoteCacheToDownload(
    Song song,
    String libraryId,
    String cachedPath,
  ) async {
    final suffix = song.suffix ?? p.extension(cachedPath).replaceAll('.', '');
    final savePath = await _getSavePath(
      libraryId,
      song.id,
      suffix.isNotEmpty ? suffix : 'cache',
    );

    // 确保目录存在
    final dir = Directory(p.dirname(savePath));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    // 复制缓存文件到下载目录
    final cacheFile = File(cachedPath);
    await cacheFile.copy(savePath);
    final fileSize = await File(savePath).length();

    // 创建已完成的下载任务记录
    final task = DownloadTask(
      id: const Uuid().v4(),
      libraryId: libraryId,
      songId: song.id,
      title: song.title,
      artist: song.artist,
      album: song.album,
      coverArt: song.coverArt,
      duration: song.duration,
      suffix: suffix,
      bitRate: song.bitRate,
      contentType: song.contentType,
      filePath: savePath,
      fileSize: fileSize,
      status: DownloadTaskStatus.completed,
      progress: 1.0,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      completedAt: DateTime.now().millisecondsSinceEpoch,
    );
    await _repository.createTask(task);

    Logger.infoWithTag(
      _logTag,
      'promoted cache→download title="${song.title}" songId=${song.id} '
      'from=$cachedPath to=$savePath size=$fileSize',
    );
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
      final filePath = task!.filePath!;
      if (await _isManagedDownloadFilePath(filePath)) {
        final file = File(filePath);
        if (await file.exists()) {
          await file.delete();
        }
      } else {
        Logger.warnWithTag(
          _logTag,
          'skip deleting unmanaged download path=$filePath',
        );
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
      if (!await _isManagedDownloadFilePath(task.filePath!)) {
        Logger.warnWithTag(
          _logTag,
          'ignore unmanaged downloaded path=${task.filePath}',
        );
        return false;
      }
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
    if (task.filePath != null &&
        await _isManagedDownloadFilePath(task.filePath!) &&
        File(task.filePath!).existsSync()) {
      return task.filePath;
    }
    return null;
  }

  /// 处理下载队列
  void _processQueue() async {
    try {
      if (_activeDownloads.length >= maxConcurrent) return;

      final pending = await _repository.getPendingTasks();
      for (final task in pending) {
        if (_activeDownloads.length >= maxConcurrent) break;
        if (_activeDownloads.containsKey(task.id)) continue;

        _startDownload(task);
      }
    } catch (e) {
      Logger.warnWithTag(_logTag, 'failed to process download queue', e);
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
      final resolvedCoverRef = await _resolvePreferredCoverRef(task);

      await _repository.updateTask(
        taskId: task.id,
        status: DownloadTaskStatus.completed,
        progress: 1.0,
        coverArt: resolvedCoverRef,
        filePath: savePath,
        fileSize: fileSize,
        completedAt: DateTime.now().millisecondsSinceEpoch,
      );

      // 下载完成 → 注册到缓存系统，避免重复缓存
      try {
        await _cacheService.registerCache(
          songId: task.songId,
          libraryId: task.libraryId,
          filePath: savePath,
          fileSize: fileSize,
          quality: AudioQualityLevel.original,
        );
        Logger.infoWithTag(
          _logTag,
          'registered download as cache songId=${task.songId}',
        );
      } catch (e) {
        Logger.warnWithTag(
          _logTag,
          'failed to register download as cache songId=${task.songId}',
          e,
        );
      }

      Logger.infoWithTag(
        _logTag,
        'downloaded title="${task.title}" songId=${task.songId} file=$savePath cover=${resolvedCoverRef ?? "-"}',
      );
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
  /// Android: External Music app directory / Echoes / {libraryId} / {songId}.suffix
  /// iOS: Documents / echo_downloads / {libraryId} / {songId}.suffix
  Future<String> _getSavePath(
    String libraryId,
    String songId,
    String suffix,
  ) async {
    final rootDir = await _getDownloadRootDir();
    return buildDownloadFilePath(
      rootDir: rootDir.path,
      libraryId: libraryId,
      songId: songId,
      suffix: suffix,
    );
  }

  /// 获取下载根目录
  Future<Directory> _getDownloadRootDir() async {
    if (!kIsWeb && Platform.isAndroid) {
      final musicDirs = await getExternalStorageDirectories(
        type: StorageDirectory.music,
      );
      final musicDir =
          musicDirs?.firstOrNull?.path ?? '/storage/emulated/0/Music';
      return Directory(p.join(musicDir, 'Echoes'));
    }
    final appDir = await getApplicationDocumentsDirectory();
    return Directory(p.join(appDir.path, 'echo_downloads'));
  }

  /// 获取下载目录路径（供 UI 展示）
  Future<String> getDownloadDir() async {
    final dir = await _getDownloadRootDir();
    return dir.path;
  }

  Future<bool> _isManagedDownloadFilePath(String filePath) async {
    final rootDirs = await _getManagedDownloadRootPaths();
    return rootDirs.any(
      (rootDir) => isPathWithinRoot(rootDir: rootDir, candidatePath: filePath),
    );
  }

  Future<List<String>> _getManagedDownloadRootPaths() async {
    final rootDirs = <String>[(await _getDownloadRootDir()).path];

    if (!kIsWeb && Platform.isAndroid) {
      const legacyPublicMusicDir = '/storage/emulated/0/Music/Echoes';
      if (!rootDirs.any((rootDir) => p.equals(rootDir, legacyPublicMusicDir))) {
        rootDirs.add(legacyPublicMusicDir);
      }
    }

    return rootDirs;
  }

  /// 为历史已完成任务补齐封面缓存（可在列表渲染时触发）
  Future<void> ensureTaskCoverCached(DownloadTask task) async {
    if (task.status != DownloadTaskStatus.completed) return;
    if (_coverEnsuring.contains(task.id)) return;

    _coverEnsuring.add(task.id);
    try {
      final currentCover = task.coverArt?.trim();
      Logger.infoWithTag(
        _logTag,
        'ensureCover start title="${task.title}" songId=${task.songId} coverRef=${currentCover ?? "-"}',
      );
      final resolvedCoverRef = await _resolvePreferredCoverRef(task);
      if (resolvedCoverRef != null && resolvedCoverRef != currentCover) {
        await _repository.updateTask(
          taskId: task.id,
          coverArt: resolvedCoverRef,
        );
        Logger.infoWithTag(
          _logTag,
          'ensureCover done title="${task.title}" songId=${task.songId} cover=$resolvedCoverRef',
        );
      } else {
        Logger.debugWithTag(
          _logTag,
          'ensureCover unchanged title="${task.title}" songId=${task.songId} cover=${currentCover ?? "-"}',
        );
      }
    } catch (e) {
      Logger.warnWithTag(
        _logTag,
        'ensureCover failed title="${task.title}" songId=${task.songId}',
        e,
      );
    } finally {
      _coverEnsuring.remove(task.id);
    }
  }

  Future<String?> _resolvePreferredCoverRef(DownloadTask task) async {
    final rawCoverRef = task.coverArt?.trim();
    final hasRawCoverRef = rawCoverRef != null && rawCoverRef.isNotEmpty;
    final artist = (task.artist ?? '').trim();
    final album = task.album?.trim();

    // 已经是外部可访问的 URL（非 Navidrome getCoverArt）时，直接沿用。
    if (hasRawCoverRef && isTrustedCoverUrlRef(rawCoverRef)) {
      return rawCoverRef;
    }

    final coverLookupId =
        (hasRawCoverRef && isSafeServerCoverArtId(rawCoverRef))
        ? rawCoverRef
        : task.songId;

    Logger.infoWithTag(
      _logTag,
      'cover resolve start title="${task.title}" songId=${task.songId} lookupId=$coverLookupId',
    );

    String? startAfterSourceId;
    while (true) {
      final result = await _coverRepository.getCoverUrlWithSource(
        artist: artist,
        album: album,
        coverArtId: coverLookupId,
        size: 800,
        startAfterSourceId: startAfterSourceId,
      );

      if (result == null) {
        Logger.infoWithTag(
          _logTag,
          'cover resolve miss title="${task.title}" songId=${task.songId}',
        );
        return null;
      }

      if (result.sourceId == 'subsonic') {
        final isDefault = await _isLikelyDefaultNavidromeCover(result.url);
        if (isDefault) {
          Logger.infoWithTag(
            _logTag,
            'cover resolve skip source=subsonic title="${task.title}" songId=${task.songId} reason=navidrome_default',
          );
          startAfterSourceId = result.sourceId;
          continue;
        }
      }

      Logger.infoWithTag(
        _logTag,
        'cover resolve hit source=${result.sourceId} title="${task.title}" songId=${task.songId} url=${result.url}',
      );
      final trustedCoverRef = tryToTrustedCoverUrlRef(result.url);
      if (trustedCoverRef != null) {
        return trustedCoverRef;
      }

      Logger.warnWithTag(
        _logTag,
        'skip unsafe cover url source=${result.sourceId} title="${task.title}" songId=${task.songId} url=${result.url}',
      );
      return null;
    }
  }

  Future<bool> _isLikelyDefaultNavidromeCover(String coverUrl) async {
    try {
      final response = await _dio.head(
        coverUrl,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => status != null && status >= 200,
          receiveTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
        ),
      );

      final marker = [
        response.headers.value('location'),
        response.headers.value(Headers.contentTypeHeader),
        response.realUri.toString(),
      ].whereType<String>().join(' ').toLowerCase();

      final statusCode = response.statusCode ?? 0;
      final looksUnavailable = statusCode >= 400;
      final looksDefault =
          looksUnavailable ||
          marker.contains('placeholder') ||
          marker.contains('default') ||
          marker.contains('fallback') ||
          marker.contains('nocover');

      Logger.debugWithTag(
        _logTag,
        'cover inspect status=$statusCode default=$looksDefault unavailable=$looksUnavailable marker="$marker" url=$coverUrl',
      );
      return looksDefault;
    } catch (e) {
      Logger.warnWithTag(_logTag, 'cover inspect failed url=$coverUrl', e);
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // 本地文件扫描
  // ---------------------------------------------------------------------------

  /// 扫描本地下载文件，修复 DB 与文件的不一致
  /// 返回 (正常, 缺失, 孤立) 文件数
  Future<({int valid, int missing, int orphan})> scanLocalFiles() async {
    final rootDir = await _getDownloadRootDir();
    final allTasks = await _repository.getAllTasks();
    final completedTasks = allTasks
        .where((t) => t.status == DownloadTaskStatus.completed)
        .toList();

    int valid = 0;
    int missing = 0;

    // 检查 DB 中已完成任务的文件是否存在
    for (final task in completedTasks) {
      if (task.filePath != null && File(task.filePath!).existsSync()) {
        valid++;
      } else {
        missing++;
        // 标记为失败
        await _repository.updateTask(
          taskId: task.id,
          status: DownloadTaskStatus.failed,
          errorMessage: '本地文件已被删除',
        );
        Logger.infoWithTag(
          _logTag,
          'scan: file missing songId=${task.songId} path=${task.filePath}',
        );
      }
    }

    // 扫描磁盘上的孤立文件（需排除正在下载的任务路径）
    int orphan = 0;
    if (await rootDir.exists()) {
      final knownPaths = allTasks
          .where((t) => t.filePath != null)
          .map((t) => p.normalize(t.filePath!))
          .toSet();

      await for (final entity in rootDir.list(recursive: true)) {
        if (entity is File) {
          final normalized = p.normalize(entity.path);
          if (!knownPaths.contains(normalized)) {
            orphan++;
          }
        }
      }
    }

    Logger.infoWithTag(
      _logTag,
      'scan complete valid=$valid missing=$missing orphan=$orphan',
    );
    return (valid: valid, missing: missing, orphan: orphan);
  }

  /// 清理孤立文件（磁盘上存在但 DB 无记录的文件）
  Future<int> cleanOrphanFiles() async {
    final rootDir = await _getDownloadRootDir();
    if (!await rootDir.exists()) return 0;

    final allTasks = await _repository.getAllTasks();
    // 包含所有任务的路径（包括正在下载的），避免误删下载中的文件
    final knownPaths = allTasks
        .where((t) => t.filePath != null)
        .map((t) => p.normalize(t.filePath!))
        .toSet();

    int cleaned = 0;
    await for (final entity in rootDir.list(recursive: true)) {
      if (entity is File) {
        final normalized = p.normalize(entity.path);
        if (!knownPaths.contains(normalized)) {
          try {
            await entity.delete();
            cleaned++;
          } catch (e) {
            Logger.warnWithTag(
              _logTag,
              'failed to delete orphan: $normalized',
              e,
            );
          }
        }
      }
    }

    Logger.infoWithTag(_logTag, 'cleaned $cleaned orphan files');
    return cleaned;
  }

  /// 获取下载统计
  Future<({int totalFiles, int totalSizeBytes, int missingFiles})>
  getDownloadStats() async {
    final allTasks = await _repository.getAllTasks();
    final completedTasks = allTasks
        .where((t) => t.status == DownloadTaskStatus.completed)
        .toList();

    int totalFiles = 0;
    int totalSizeBytes = 0;
    int missingFiles = 0;

    for (final task in completedTasks) {
      if (task.filePath != null && File(task.filePath!).existsSync()) {
        totalFiles++;
        totalSizeBytes += task.fileSize ?? 0;
      } else {
        missingFiles++;
      }
    }

    return (
      totalFiles: totalFiles,
      totalSizeBytes: totalSizeBytes,
      missingFiles: missingFiles,
    );
  }

  // ---------------------------------------------------------------------------
  // 播放器联动
  // ---------------------------------------------------------------------------

  /// 获取所有已下载且文件完整的任务（供播放器使用）
  Future<List<DownloadTask>> getDownloadedTasks({String? libraryId}) async {
    final tasks = libraryId != null
        ? await _repository.getTasksByLibrary(libraryId)
        : await _repository.getAllTasks();

    return tasks.where((t) {
      if (t.status != DownloadTaskStatus.completed) return false;
      if (t.filePath == null) return false;
      return File(t.filePath!).existsSync();
    }).toList();
  }

  /// 将 DownloadTask 转换为 Song 模型（供播放器使用）
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
    for (final token in _activeDownloads.values) {
      token.cancel('Service disposed');
    }
    _activeDownloads.clear();
    _progressController.close();
  }
}
