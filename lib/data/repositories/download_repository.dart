import 'package:drift/drift.dart';
import '../models/download_task.dart';
import '../sources/database/app_database.dart';

/// 下载任务仓库（Drift CRUD）
class DownloadRepository {
  final AppDatabase _db;

  DownloadRepository(this._db);

  /// 创建下载任务
  Future<void> createTask(DownloadTask task) async {
    await _db
        .into(_db.downloadTasks)
        .insertOnConflictUpdate(
          DownloadTasksCompanion.insert(
            id: task.id,
            libraryId: task.libraryId,
            songId: task.songId,
            title: task.title,
            artist: Value(task.artist),
            album: Value(task.album),
            coverArt: Value(task.coverArt),
            duration: Value(task.duration),
            suffix: Value(task.suffix),
            bitRate: Value(task.bitRate),
            contentType: Value(task.contentType),
            filePath: Value(task.filePath),
            fileSize: Value(task.fileSize),
            status: Value(task.status.name),
            progress: Value(task.progress),
            errorMessage: Value(task.errorMessage),
            createdAt: task.createdAt,
            completedAt: Value(task.completedAt),
          ),
        );
  }

  /// 查询所有任务（按创建时间倒序）
  Future<List<DownloadTask>> getAllTasks() async {
    final rows = await (_db.select(
      _db.downloadTasks,
    )..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).get();
    return rows.map(_rowToTask).toList();
  }

  /// 查询指定音乐库的任务
  Future<List<DownloadTask>> getTasksByLibrary(String libraryId) async {
    final rows =
        await (_db.select(_db.downloadTasks)
              ..where((t) => t.libraryId.equals(libraryId))
              ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
            .get();
    return rows.map(_rowToTask).toList();
  }

  /// 按 songId + libraryId 查询
  Future<DownloadTask?> getTaskBySongId(String songId, String libraryId) async {
    final row =
        await (_db.select(_db.downloadTasks)..where(
              (t) => t.songId.equals(songId) & t.libraryId.equals(libraryId),
            ))
            .getSingleOrNull();
    return row != null ? _rowToTask(row) : null;
  }

  /// 更新任务状态和进度
  Future<void> updateTask({
    required String taskId,
    DownloadTaskStatus? status,
    double? progress,
    String? coverArt,
    String? filePath,
    int? fileSize,
    String? errorMessage,
    int? completedAt,
  }) async {
    await (_db.update(
      _db.downloadTasks,
    )..where((t) => t.id.equals(taskId))).write(
      DownloadTasksCompanion(
        status: status != null ? Value(status.name) : const Value.absent(),
        progress: progress != null ? Value(progress) : const Value.absent(),
        coverArt: coverArt != null ? Value(coverArt) : const Value.absent(),
        filePath: filePath != null ? Value(filePath) : const Value.absent(),
        fileSize: fileSize != null ? Value(fileSize) : const Value.absent(),
        errorMessage: errorMessage != null
            ? Value(errorMessage)
            : const Value.absent(),
        completedAt: completedAt != null
            ? Value(completedAt)
            : const Value.absent(),
      ),
    );
  }

  /// 删除任务
  Future<void> deleteTask(String taskId) async {
    await (_db.delete(
      _db.downloadTasks,
    )..where((t) => t.id.equals(taskId))).go();
  }

  /// 清除所有已完成的任务记录
  Future<void> clearCompleted() async {
    await (_db.delete(
      _db.downloadTasks,
    )..where((t) => t.status.equals('completed'))).go();
  }

  /// 获取待处理的任务（pending 状态）
  Future<List<DownloadTask>> getPendingTasks() async {
    final rows =
        await (_db.select(_db.downloadTasks)
              ..where((t) => t.status.equals('pending'))
              ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
            .get();
    return rows.map(_rowToTask).toList();
  }

  /// 监听所有任务变化
  Stream<List<DownloadTask>> watchAllTasks() {
    return (_db.select(_db.downloadTasks)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch()
        .map((rows) => rows.map(_rowToTask).toList());
  }

  DownloadTask _rowToTask(DownloadTaskData row) {
    return DownloadTask(
      id: row.id,
      libraryId: row.libraryId,
      songId: row.songId,
      title: row.title,
      artist: row.artist,
      album: row.album,
      coverArt: row.coverArt,
      duration: row.duration,
      suffix: row.suffix,
      bitRate: row.bitRate,
      contentType: row.contentType,
      filePath: row.filePath,
      fileSize: row.fileSize,
      status: DownloadTaskStatusExt.fromString(row.status),
      progress: row.progress,
      errorMessage: row.errorMessage,
      createdAt: row.createdAt,
      completedAt: row.completedAt,
    );
  }
}
