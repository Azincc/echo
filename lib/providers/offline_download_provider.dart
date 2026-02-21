import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/services/offline_download_service.dart';
import '../data/models/embed_service_config.dart';
import '../data/models/offline_download_task.dart';
import '../data/sources/remote/embed_service_client.dart';
import 'library_provider.dart';

final embedServiceClientProvider = Provider<EmbedServiceClient>((ref) {
  return EmbedServiceClient();
});

final offlineDownloadServiceProvider = Provider<OfflineDownloadService>((ref) {
  final embedClient = ref.watch(embedServiceClientProvider);

  final service = OfflineDownloadService(
    embedClient: embedClient,
  );

  ref.onDispose(service.dispose);
  return service;
});

final offlineDownloadTasksProvider = StreamProvider<List<OfflineDownloadTask>>((
  ref,
) {
  final service = ref.watch(offlineDownloadServiceProvider);
  return service.tasksStream;
});

final offlineDownloadSummaryProvider = Provider<OfflineDownloadSummary>((ref) {
  final tasks = ref.watch(offlineDownloadTasksProvider).valueOrNull ?? const [];

  var queued = 0;
  var downloading = 0;
  var paused = 0;
  var completed = 0;
  var failed = 0;

  for (final task in tasks) {
    switch (task.status) {
      case OfflineDownloadTaskStatus.queued:
      case OfflineDownloadTaskStatus.resolving:
      case OfflineDownloadTaskStatus.tagging:
      case OfflineDownloadTaskStatus.moving:
      case OfflineDownloadTaskStatus.scanning:
        queued++;
        break;
      case OfflineDownloadTaskStatus.downloading:
        downloading++;
        break;
      case OfflineDownloadTaskStatus.paused:
        paused++;
        break;
      case OfflineDownloadTaskStatus.completed:
        completed++;
        break;
      case OfflineDownloadTaskStatus.failed:
        failed++;
        break;
      case OfflineDownloadTaskStatus.removed:
        break;
    }
  }

  return OfflineDownloadSummary(
    queued: queued,
    downloading: downloading,
    paused: paused,
    completed: completed,
    failed: failed,
  );
});

final activeEmbedServiceConfigProvider = Provider<EmbedServiceConfig>((ref) {
  final activeLibrary = ref.watch(activeLibraryProvider);
  return EmbedServiceConfig.fromLibraryExtensions(activeLibrary?.extensions);
});
