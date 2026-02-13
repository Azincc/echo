import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echoes/providers/lyrics_cover_provider.dart';
import 'package:echoes/data/models/provider_config.dart';
import 'package:echoes/data/sources/database/database_provider.dart';

class LyricsProvidersPage extends ConsumerStatefulWidget {
  const LyricsProvidersPage({super.key});

  @override
  ConsumerState<LyricsProvidersPage> createState() =>
      _LyricsProvidersPageState();
}

class _LyricsProvidersPageState extends ConsumerState<LyricsProvidersPage> {
  @override
  Widget build(BuildContext context) {
    final configsAsync = ref.watch(lyricsProviderConfigsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('歌词提供商')),
      body: configsAsync.when(
        data: (configs) {
          // Create a modifiable copy for reordering
          final currentConfigs = List<ProviderConfig>.from(configs);

          return ReorderableListView.builder(
            itemCount: currentConfigs.length,
            onReorder: (oldIndex, newIndex) {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final item = currentConfigs.removeAt(oldIndex);
              currentConfigs.insert(newIndex, item);

              // Update DB
              final db = ref.read(appDatabaseProvider);
              updateLyricsProviderOrder(db, currentConfigs);

              // Invalidate to ensure fresh data (though stream should handle it)
              ref.invalidate(lyricsProviderConfigsProvider);
            },
            itemBuilder: (context, index) {
              final config = currentConfigs[index];
              return ListTile(
                key: ValueKey(config.id),
                leading: ReorderableDragStartListener(
                  index: index,
                  child: const Icon(Icons.drag_handle),
                ),
                title: Text(_getProviderName(config.sourceId)),
                subtitle: Text(_getProviderDescription(config.sourceId)),
                trailing: Switch(
                  value: config.enabled,
                  onChanged: (value) {
                    final db = ref.read(appDatabaseProvider);
                    toggleLyricsProvider(db, config.id, value);
                    ref.invalidate(lyricsProviderConfigsProvider);
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  String _getProviderName(String sourceId) {
    switch (sourceId) {
      case 'subsonic':
        return '服务端';
      case 'lrclib':
        return 'LRCLIB';
      case 'netease':
        return '网易云音乐';
      case 'custom':
        return '自定义源';
      default:
        return sourceId;
    }
  }

  String _getProviderDescription(String sourceId) {
    switch (sourceId) {
      case 'subsonic':
        return 'OpenSubsonic / Subsonic 内嵌歌词';
      case 'lrclib':
        return '公共同步歌词 API';
      case 'netease':
        return '网易云音乐歌词';
      case 'custom':
        return '自定义 API 地址';
      default:
        return '';
    }
  }
}
