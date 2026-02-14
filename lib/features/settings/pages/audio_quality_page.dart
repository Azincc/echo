import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/audio_quality.dart';
import '../../../providers/audio_quality_provider.dart';
import '../../../core/network/connectivity_monitor.dart';

/// 音质设置页面
class AudioQualityPage extends ConsumerWidget {
  const AudioQualityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(audioQualitySettingsProvider);
    final networkType = ref.watch(currentNetworkTypeProvider);
    final effectiveQuality = ref.watch(effectiveQualityProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('音质设置')),
      body: ListView(
        children: [
          // 当前状态卡片
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '当前状态',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        _networkIcon(
                          networkType.valueOrNull ?? NetworkType.none,
                        ),
                        size: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '网络: ${_networkName(networkType.valueOrNull ?? NetworkType.none)}',
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.music_note,
                        size: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text('生效音质: ${effectiveQuality.displayName}'),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 自动切换开关
          SwitchListTile(
            title: const Text('按网络自动切换'),
            subtitle: const Text('Wi-Fi 和移动数据使用不同音质'),
            value: settings.autoSwitch,
            onChanged: (value) {
              ref
                  .read(audioQualitySettingsProvider.notifier)
                  .setAutoSwitch(value);
            },
          ),

          const Divider(),

          // Wi-Fi 音质
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              settings.autoSwitch ? 'Wi-Fi 音质' : '全局音质',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          ...AudioQualityLevel.values.map(
            (quality) => RadioListTile<AudioQualityLevel>(
              title: Text(quality.displayName),
              subtitle: quality == AudioQualityLevel.original
                  ? const Text('不限制码率，直接播放原始文件')
                  : null,
              value: quality,
              groupValue: settings.wifiQuality,
              onChanged: (value) {
                if (value != null) {
                  ref
                      .read(audioQualitySettingsProvider.notifier)
                      .setWifiQuality(value);
                }
              },
            ),
          ),

          // 移动数据音质（仅在自动切换开启时显示）
          if (settings.autoSwitch) ...[
            const Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                '移动数据音质',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            ...AudioQualityLevel.values.map(
              (quality) => RadioListTile<AudioQualityLevel>(
                title: Text(quality.displayName),
                subtitle: quality == AudioQualityLevel.dataSaver
                    ? const Text('节省流量，适合移动网络')
                    : null,
                value: quality,
                groupValue: settings.mobileQuality,
                onChanged: (value) {
                  if (value != null) {
                    ref
                        .read(audioQualitySettingsProvider.notifier)
                        .setMobileQuality(value);
                  }
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  IconData _networkIcon(NetworkType type) => switch (type) {
    NetworkType.wifi => Icons.wifi,
    NetworkType.mobile => Icons.signal_cellular_alt,
    NetworkType.none => Icons.signal_wifi_off,
  };

  String _networkName(NetworkType type) => switch (type) {
    NetworkType.wifi => 'Wi-Fi',
    NetworkType.mobile => '移动数据',
    NetworkType.none => '无网络',
  };
}
