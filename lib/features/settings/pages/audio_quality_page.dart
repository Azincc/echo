import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/echo_design.dart';
import '../../../core/network/connectivity_monitor.dart';
import '../../../data/models/audio_quality.dart';
import '../../../providers/audio_quality_provider.dart';
import '../widgets/echo_settings_components.dart';

class AudioQualityPage extends ConsumerWidget {
  const AudioQualityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(audioQualitySettingsProvider);
    final networkType =
        ref.watch(currentNetworkTypeProvider).valueOrNull ?? NetworkType.none;
    final effectiveQuality = ref.watch(effectiveQualityProvider);
    final notifier = ref.read(audioQualitySettingsProvider.notifier);

    return EchoScaffold(
      topBar: EchoTopBar.back(context: context, title: '音质设置'),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(
            padding: EdgeInsets.fromLTRB(
              context.echoSpacing.md,
              context.echoSpacing.sm,
              context.echoSpacing.md,
              context.echoSpacing.xxl + context.echoShellBottomObstruction,
            ),
            children: <Widget>[
              EchoSurface(
                level: EchoSurfaceLevel.raised,
                borderColor: context.echoColors.controlBoundary,
                padding: EdgeInsets.all(context.echoSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('当前播放策略', style: context.echoTypography.headline),
                    SizedBox(height: context.echoSpacing.sm),
                    _StatusLine(
                      icon: _networkIcon(networkType),
                      label: '网络',
                      value: _networkName(networkType),
                    ),
                    SizedBox(height: context.echoSpacing.xs),
                    _StatusLine(
                      icon: AppIcons.quality,
                      label: '生效音质',
                      value: effectiveQuality.displayName,
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.echoSpacing.xl),
              EchoSettingsSection(
                title: '网络策略',
                description: '在 Wi-Fi 与移动数据之间自动使用不同码率。',
                children: <Widget>[
                  EchoToggleSettingRow(
                    icon: AppIcons.route,
                    title: '按网络自动切换',
                    description: settings.autoSwitch
                        ? 'Wi-Fi 与移动数据分别保存音质。'
                        : '所有网络都使用同一音质。',
                    value: settings.autoSwitch,
                    onChanged: notifier.setAutoSwitch,
                  ),
                ],
              ),
              SizedBox(height: context.echoSpacing.xl),
              EchoSettingsSection(
                title: settings.autoSwitch ? 'Wi-Fi 音质' : '全局音质',
                description: settings.autoSwitch
                    ? '连接 Wi-Fi 时优先保证音乐完整度。'
                    : '此选择将用于所有网络。',
                children: <Widget>[
                  for (final quality in AudioQualityLevel.values)
                    EchoChoiceRow(
                      title: quality.displayName,
                      description: _qualityDescription(quality),
                      selected: settings.wifiQuality == quality,
                      onPressed: () => notifier.setWifiQuality(quality),
                      icon: AppIcons.quality,
                    ),
                ],
              ),
              if (settings.autoSwitch) ...<Widget>[
                SizedBox(height: context.echoSpacing.xl),
                EchoSettingsSection(
                  title: '移动数据音质',
                  description: '在流量消耗、启动速度与听感之间选择。',
                  children: <Widget>[
                    for (final quality in AudioQualityLevel.values)
                      EchoChoiceRow(
                        title: quality.displayName,
                        description: _qualityDescription(quality),
                        selected: settings.mobileQuality == quality,
                        onPressed: () => notifier.setMobileQuality(quality),
                        icon: AppIcons.signal,
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusLine extends StatelessWidget {
  const _StatusLine({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$label，$value',
      child: ExcludeSemantics(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox.square(
              dimension: context.echoInteraction.minimumTouchTarget,
              child: Center(
                child: Icon(icon, size: 22, color: context.echoColors.accent),
              ),
            ),
            SizedBox(width: context.echoSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    label,
                    style: context.echoTypography.metadata.copyWith(
                      color: context.echoColors.muted,
                    ),
                  ),
                  SizedBox(height: context.echoSpacing.xxs),
                  Text(value, style: context.echoTypography.title),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

IconData _networkIcon(NetworkType type) => switch (type) {
  NetworkType.wifi => AppIcons.wifi,
  NetworkType.mobile => AppIcons.signal,
  NetworkType.none => AppIcons.wifiOff,
};

String _networkName(NetworkType type) => switch (type) {
  NetworkType.wifi => 'Wi-Fi',
  NetworkType.mobile => '移动数据',
  NetworkType.none => '无网络',
};

String _qualityDescription(AudioQualityLevel quality) => switch (quality) {
  AudioQualityLevel.original => '不限制码率，直接播放服务器原始文件',
  AudioQualityLevel.high => '高保真听感，适合稳定网络',
  AudioQualityLevel.standard => '兼顾听感、启动速度与流量',
  AudioQualityLevel.dataSaver => '减少流量消耗，适合信号波动时使用',
};
