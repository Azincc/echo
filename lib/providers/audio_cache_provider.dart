import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/services/audio_cache_service.dart';
import '../data/repositories/audio_cache_repository.dart';
import '../data/sources/database/database_provider.dart';

/// 缓存仓库 Provider
final audioCacheRepositoryProvider = Provider<AudioCacheRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return AudioCacheRepository(db);
});

/// 缓存服务 Provider
final audioCacheServiceProvider = Provider<AudioCacheService>((ref) {
  final repository = ref.watch(audioCacheRepositoryProvider);
  return AudioCacheService(repository: repository);
});

/// 缓存大小 Provider
final cacheSizeProvider = FutureProvider<int>((ref) async {
  final service = ref.watch(audioCacheServiceProvider);
  return service.getTotalCacheSize();
});
