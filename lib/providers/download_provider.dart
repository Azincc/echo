import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/services/download_service.dart';
import '../data/models/download_task.dart';
import '../data/models/song.dart';
import '../data/repositories/download_repository.dart';
import '../data/sources/database/database_provider.dart';
import 'api_provider.dart';
import 'audio_cache_provider.dart';
import 'lyrics_cover_provider.dart';
import 'music_provider.dart';

/// 下载仓库 Provider
final downloadRepositoryProvider = Provider<DownloadRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return DownloadRepository(db);
});

/// 下载服务 Provider
final downloadServiceProvider = Provider<DownloadService>((ref) {
  final repository = ref.watch(downloadRepositoryProvider);
  final apiClient = ref.watch(subsonicApiClientProvider);
  final coverRepository = ref.watch(coverRepositoryProvider);
  final cacheService = ref.watch(audioCacheServiceProvider);

  // 使用独立的 Dio 实例进行下载（不走 FallbackInterceptor）
  final downloadDio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(minutes: 10),
    ),
  );

  final service = DownloadService(
    dio: downloadDio,
    apiClient: apiClient,
    repository: repository,
    coverRepository: coverRepository,
    cacheService: cacheService,
  );

  ref.onDispose(() => service.dispose());
  return service;
});

/// 下载任务列表 Provider（响应式监听）
final downloadTasksProvider = StreamProvider<List<DownloadTask>>((ref) {
  final repository = ref.watch(downloadRepositoryProvider);
  return repository.watchAllTasks();
});

/// 下载进度 Provider
final downloadProgressProvider = StreamProvider<Map<String, double>>((ref) {
  final service = ref.watch(downloadServiceProvider);
  return service.progressStream;
});

/// 已下载歌曲列表 Provider（从 API 获取完整 Song 元数据）
final downloadedSongsProvider = FutureProvider<List<Song>>((ref) async {
  final service = ref.watch(downloadServiceProvider);
  final musicRepo = ref.watch(musicRepositoryProvider);
  final tasks = await service.getDownloadedTasks();

  if (musicRepo == null || tasks.isEmpty) return [];

  final songs = <Song>[];
  for (final task in tasks) {
    final song = await musicRepo.getSong(task.songId);
    if (song != null) {
      songs.add(song);
    }
  }
  return songs;
});
