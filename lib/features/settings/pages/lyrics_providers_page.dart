import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/echo_design.dart';
import '../../../data/models/provider_config.dart';
import '../../../data/sources/database/database_provider.dart';
import '../../../providers/lyrics_cover_provider.dart';
import '../widgets/echo_settings_components.dart';

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

    return EchoScaffold(
      topBar: EchoTopBar.back(context: context, title: '歌词提供商'),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: configsAsync.when(
            data: _buildProviderList,
            loading: () => const EchoProviderListSkeleton(),
            error: (error, stackTrace) => EchoErrorState(
              title: '无法读取歌词提供商',
              description: '提供商顺序和启用状态暂时不可用。\n$error',
              actionLabel: '重试',
              onAction: () => ref.invalidate(lyricsProviderConfigsProvider),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProviderList(List<ProviderConfig> configs) {
    if (configs.isEmpty) {
      return const EchoEmptyState(
        title: '没有可用的歌词提供商',
        description: '提供商配置为空，请稍后重试或检查应用数据。',
        icon: AppIcons.lyrics,
      );
    }

    final currentConfigs = List<ProviderConfig>.from(configs);

    return ReorderableListView.builder(
      buildDefaultDragHandles: false,
      padding: EdgeInsets.fromLTRB(
        context.echoSpacing.md,
        context.echoSpacing.sm,
        context.echoSpacing.md,
        context.echoSpacing.xxl + context.echoShellBottomObstruction,
      ),
      header: Padding(
        padding: EdgeInsets.only(bottom: context.echoSpacing.md),
        child: const EchoSectionHeader(
          title: '优先顺序',
          description: '播放时会从上到下依次尝试。按住拖动图标可调整顺序。',
        ),
      ),
      itemCount: currentConfigs.length,
      proxyDecorator: (child, index, animation) => child,
      onReorder: (oldIndex, newIndex) {
        if (oldIndex < newIndex) newIndex -= 1;
        final item = currentConfigs.removeAt(oldIndex);
        currentConfigs.insert(newIndex, item);

        final db = ref.read(appDatabaseProvider);
        updateLyricsProviderOrder(db, currentConfigs);
        ref.invalidate(lyricsProviderConfigsProvider);
      },
      itemBuilder: (context, index) {
        final config = currentConfigs[index];
        return EchoProviderSettingRow(
          key: ValueKey(config.id),
          index: index,
          title: _getProviderName(config.sourceId),
          description: _getProviderDescription(config.sourceId),
          enabled: config.enabled,
          onChanged: (value) {
            final db = ref.read(appDatabaseProvider);
            toggleLyricsProvider(db, config.id, value);
            ref.invalidate(lyricsProviderConfigsProvider);
          },
        );
      },
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
