import 'package:echoes/data/models/provider_config.dart';
import 'package:echoes/data/sources/database/database_provider.dart';
import 'package:echoes/providers/lyrics_cover_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          final currentConfigs = List<ProviderConfig>.from(configs);

          return ReorderableListView.builder(
            itemCount: currentConfigs.length,
            onReorder: (oldIndex, newIndex) {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final item = currentConfigs.removeAt(oldIndex);
              currentConfigs.insert(newIndex, item);

              final db = ref.read(appDatabaseProvider);
              updateCoverProviderOrder(db, currentConfigs);
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
                subtitle: Text(_buildProviderSubtitle(config)),
                isThreeLine: _isConfigurable(config.sourceId),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_isConfigurable(config.sourceId))
                      IconButton(
                        tooltip: '配置',
                        icon: const Icon(Icons.settings_outlined),
                        onPressed: () => _openProviderConfigDialog(config),
                      ),
                    Switch(
                      value: config.enabled,
                      onChanged: (value) {
                        final db = ref.read(appDatabaseProvider);
                        toggleCoverProvider(db, config.id, value);
                        ref.invalidate(coverProviderConfigsProvider);
                      },
                    ),
                  ],
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

  String _fanartApiKey(ProviderConfig config) {
    return (config.config?['apiKey'] as String? ?? '').trim();
  }

  bool _isConfigurable(String sourceId) {
    return sourceId == 'fanart';
  }

  String _buildProviderSubtitle(ProviderConfig config) {
    final description = _getProviderDescription(config.sourceId);
    if (config.sourceId != 'fanart') return description;

    final hasKey = _fanartApiKey(config).isNotEmpty;
    final status = hasKey ? 'API Key：已配置' : 'API Key：未配置';
    return '$description\n$status';
  }

  Future<void> _openProviderConfigDialog(ProviderConfig config) async {
    if (config.sourceId == 'fanart') {
      await _editFanartApiKey(config);
    }
  }

  Future<void> _editFanartApiKey(ProviderConfig config) async {
    final controller = TextEditingController(text: _fanartApiKey(config));
    final result = await showDialog<String?>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('配置 Fanart.tv'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('请输入 Fanart.tv API Key'),
              const SizedBox(height: 8),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'API Key',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, ''),
              child: const Text('清空'),
            ),
            FilledButton(
              onPressed: () =>
                  Navigator.pop(dialogContext, controller.text.trim()),
              child: const Text('保存'),
            ),
          ],
        );
      },
    );
    controller.dispose();

    if (result == null) return;

    final db = ref.read(appDatabaseProvider);
    await updateCoverProviderConfig(db, config.id, {'apiKey': result});
    ref.invalidate(coverProviderConfigsProvider);
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
        return 'Fanart.tv 高清封面（需要 API Key）';
      case 'musicbrainz':
        return 'MusicBrainz Cover Art Archive';
      case 'custom':
        return '自定义 API 地址';
      default:
        return '';
    }
  }
}
