import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/services/offline_download_service.dart';
import '../data/models/embed_service_config.dart';
import '../data/sources/remote/embed_service_client.dart';
import 'library_provider.dart';

final embedServiceClientProvider = Provider<EmbedServiceClient>((ref) {
  return EmbedServiceClient();
});

final offlineDownloadServiceProvider = Provider<OfflineDownloadService>((ref) {
  final embedClient = ref.watch(embedServiceClientProvider);

  final service = OfflineDownloadService(embedClient: embedClient);

  ref.onDispose(service.dispose);
  return service;
});

/// 任务列表（从服务端获取）
final offlineDownloadJobsProvider = StreamProvider<List<EmbedJobStatus>>((ref) {
  final service = ref.watch(offlineDownloadServiceProvider);
  return service.jobsStream;
});

/// 任务摘要统计
final offlineDownloadSummaryProvider = Provider<OfflineDownloadSummary>((ref) {
  final jobs = ref.watch(offlineDownloadJobsProvider).valueOrNull ?? const [];

  var active = 0;
  var completed = 0;
  var failed = 0;

  for (final job in jobs) {
    if (job.isActive) {
      active++;
    } else if (job.isDone) {
      completed++;
    } else if (job.isFailed) {
      failed++;
    }
  }

  return OfflineDownloadSummary(
    active: active,
    completed: completed,
    failed: failed,
    total: jobs.length,
  );
});

/// 当前音乐库的 Embed Service 配置
final activeEmbedServiceConfigProvider = Provider<EmbedServiceConfig>((ref) {
  final activeLibrary = ref.watch(activeLibraryProvider);
  return EmbedServiceConfig.fromLibraryExtensions(activeLibrary?.extensions);
});

class OfflineDownloadSummary {
  final int active;
  final int completed;
  final int failed;
  final int total;

  const OfflineDownloadSummary({
    this.active = 0,
    this.completed = 0,
    this.failed = 0,
    this.total = 0,
  });
}
