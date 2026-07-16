import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/echo_design.dart';
import '../../../data/models/provider_config.dart';
import '../../../data/sources/database/database_provider.dart';
import '../../../providers/lyrics_cover_provider.dart';
import '../widgets/echo_settings_components.dart';

class CoverProvidersPage extends ConsumerStatefulWidget {
  const CoverProvidersPage({super.key});

  @override
  ConsumerState<CoverProvidersPage> createState() => _CoverProvidersPageState();
}

class _CoverProvidersPageState extends ConsumerState<CoverProvidersPage> {
  @override
  Widget build(BuildContext context) {
    final configsAsync = ref.watch(coverProviderConfigsProvider);

    return EchoScaffold(
      topBar: EchoTopBar.back(context: context, title: '封面提供商'),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: configsAsync.when(
            data: _buildProviderList,
            loading: () => const EchoProviderListSkeleton(),
            error: (error, stackTrace) => EchoErrorState(
              title: '无法读取封面提供商',
              description: '提供商顺序、启用状态和配置暂时不可用。\n$error',
              actionLabel: '重试',
              onAction: () => ref.invalidate(coverProviderConfigsProvider),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProviderList(List<ProviderConfig> configs) {
    if (configs.isEmpty) {
      return const EchoEmptyState(
        title: '没有可用的封面提供商',
        description: '提供商配置为空，请稍后重试或检查应用数据。',
        icon: AppIcons.image,
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
          description: '查找封面时会从上到下依次尝试。按住拖动图标可调整顺序。',
        ),
      ),
      itemCount: currentConfigs.length,
      proxyDecorator: (child, index, animation) => child,
      onReorder: (oldIndex, newIndex) {
        if (oldIndex < newIndex) newIndex -= 1;
        final item = currentConfigs.removeAt(oldIndex);
        currentConfigs.insert(newIndex, item);

        final db = ref.read(appDatabaseProvider);
        updateCoverProviderOrder(db, currentConfigs);
        ref.invalidate(coverProviderConfigsProvider);
      },
      itemBuilder: (context, index) {
        final config = currentConfigs[index];
        return EchoProviderSettingRow(
          key: ValueKey(config.id),
          index: index,
          title: _getProviderName(config.sourceId),
          description: _buildProviderSubtitle(config),
          enabled: config.enabled,
          onConfigure: _isConfigurable(config.sourceId)
              ? () => _openProviderConfigSheet(config)
              : null,
          onChanged: (value) {
            final db = ref.read(appDatabaseProvider);
            toggleCoverProvider(db, config.id, value);
            ref.invalidate(coverProviderConfigsProvider);
          },
        );
      },
    );
  }

  String _fanartApiKey(ProviderConfig config) {
    return (config.config?['apiKey'] as String? ?? '').trim();
  }

  bool _isConfigurable(String sourceId) => sourceId == 'fanart';

  String _buildProviderSubtitle(ProviderConfig config) {
    final description = _getProviderDescription(config.sourceId);
    if (config.sourceId != 'fanart') return description;

    final hasKey = _fanartApiKey(config).isNotEmpty;
    final status = hasKey ? 'API Key：已配置' : 'API Key：未配置';
    return '$description\n$status';
  }

  Future<void> _openProviderConfigSheet(ProviderConfig config) async {
    if (config.sourceId == 'fanart') await _editFanartApiKey(config);
  }

  Future<void> _editFanartApiKey(ProviderConfig config) async {
    final controller = TextEditingController(text: _fanartApiKey(config));
    final result = await showEchoBottomSheet<String>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (sheetContext) => AnimatedPadding(
        duration: sheetContext.echoMotion.resolve(
          sheetContext,
          sheetContext.echoMotion.state,
        ),
        curve: sheetContext.echoMotion.easeOut,
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(sheetContext).bottom,
        ),
        child: EchoBottomSheet(
          title: '配置 Fanart.tv',
          subtitle: 'Fanart.tv 高清封面需要单独的 API Key。',
          constrainToAvailableHeight: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                EchoTextField(
                  controller: controller,
                  label: 'API Key',
                  hintText: '输入 Fanart.tv API Key',
                  helperText: '选择“清空”会移除本机保存的 Key。',
                  leadingIcon: AppIcons.key,
                  autocorrect: false,
                  enableSuggestions: false,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) =>
                      Navigator.of(sheetContext).pop(value.trim()),
                ),
                SizedBox(height: sheetContext.echoSpacing.lg),
                Wrap(
                  alignment: WrapAlignment.end,
                  spacing: sheetContext.echoSpacing.xs,
                  runSpacing: sheetContext.echoSpacing.xs,
                  children: <Widget>[
                    EchoButton.ghost(
                      label: '取消',
                      onPressed: () => Navigator.of(sheetContext).pop(),
                    ),
                    EchoButton.secondary(
                      label: '清空',
                      onPressed: () => Navigator.of(sheetContext).pop(''),
                    ),
                    EchoButton.primary(
                      label: '保存',
                      onPressed: () => Navigator.of(
                        sheetContext,
                      ).pop(controller.text.trim()),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
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
