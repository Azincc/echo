import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echoes/providers/lyrics_cover_provider.dart';
import 'package:echoes/data/models/provider_config.dart';
import 'package:echoes/data/sources/database/database_provider.dart';

class CoverProvidersPage extends ConsumerStatefulWidget {
  const CoverProvidersPage({super.key});

  @override
  ConsumerState<CoverProvidersPage> createState() => _CoverProvidersPageState();
}

class _CoverProvidersPageState extends ConsumerState<CoverProvidersPage> {
  @override
  Widget build(BuildContext context) {
    final configsAsync = ref.watch(coverProviderConfigsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('封面提供商')),
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
              updateCoverProviderOrder(db, currentConfigs);

              // Invalidate to ensure fresh data
              ref.invalidate(coverProviderConfigsProvider);
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
                    toggleCoverProvider(db, config.id, value);
                    ref.invalidate(coverProviderConfigsProvider);
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
      case 'fanart':
        return 'Fanart.tv';
      case 'musicbrainz':
        return 'MusicBrainz';
      case 'custom':
        return '自定义源';
      default:
        return sourceId;
    }
  }

  String _getProviderDescription(String sourceId) {
    switch (sourceId) {
      case 'subsonic':
        return 'Subsonic 服务端封面';
      case 'fanart':
        return 'Fanart.tv 高清封面 (需 API Key)';
      case 'musicbrainz':
        return 'MusicBrainz Cover Art Archive';
      case 'custom':
        return '自定义 API 地址';
      default:
        return '';
    }
  }
}
