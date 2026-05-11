import 'package:flutter/material.dart';
import 'package:echoes/widgets/app_back_button.dart';
import 'package:echoes/core/theme/app_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/audio_quality.dart';
import '../../../providers/audio_quality_provider.dart';
import '../../../core/network/connectivity_monitor.dart';
import '../../../widgets/music_chrome.dart';

/// 音质设置页面
class AudioQualityPage extends ConsumerWidget {
  const AudioQualityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(audioQualitySettingsProvider);
    final networkType = ref.watch(currentNetworkTypeProvider);
    final effectiveQuality = ref.watch(effectiveQualityProvider);

    return Scaffold(
      appBar: AppBar(leading: const AppBackButton(), title: const Text('音质设置')),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: MusicChrome.maxContentWidth,
          ),
          child: ListView(
            padding: EdgeInsets.fromLTRB(
              20,
              16,
              20,
              24 + MediaQuery.of(context).padding.bottom,
            ),
            children: [
              MusicGlassSurface(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '当前状态',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
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
                        Expanded(
                          child: Text(
                            '网络: ${_networkName(networkType.valueOrNull ?? NetworkType.none)}',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          AppIcons.music_note,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text('生效音质: ${effectiveQuality.displayName}'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('按网络自动切换'),
                      subtitle: const Text('Wi-Fi 和移动数据使用不同音质'),
                      value: settings.autoSwitch,
                      onChanged: (value) {
                        ref
                            .read(audioQualitySettingsProvider.notifier)
                            .setAutoSwitch(value);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              _qualitySection(
                context: context,
                title: settings.autoSwitch ? 'Wi-Fi 音质' : '全局音质',
                children: AudioQualityLevel.values.map(
                  (quality) => _buildQualityTile(
                    context: context,
                    quality: quality,
                    selected: settings.wifiQuality,
                    subtitle: quality == AudioQualityLevel.original
                        ? '不限制码率，直接播放原始文件'
                        : null,
                    onTap: () {
                      ref
                          .read(audioQualitySettingsProvider.notifier)
                          .setWifiQuality(quality);
                    },
                  ),
                ),
              ),
              if (settings.autoSwitch) ...[
                const SizedBox(height: 22),
                _qualitySection(
                  context: context,
                  title: '移动数据音质',
                  children: AudioQualityLevel.values.map(
                    (quality) => _buildQualityTile(
                      context: context,
                      quality: quality,
                      selected: settings.mobileQuality,
                      subtitle: quality == AudioQualityLevel.dataSaver
                          ? '节省流量，适合移动网络'
                          : null,
                      onTap: () {
                        ref
                            .read(audioQualitySettingsProvider.notifier)
                            .setMobileQuality(quality);
                      },
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _qualitySection({
    required BuildContext context,
    required String title,
    required Iterable<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(2, 0, 2, 8),
          child: Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
        ),
        MusicGlassSurface(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(children: children.toList()),
        ),
      ],
    );
  }

  IconData _networkIcon(NetworkType type) => switch (type) {
    NetworkType.wifi => AppIcons.wifi,
    NetworkType.mobile => AppIcons.signal_cellular_alt,
    NetworkType.none => AppIcons.signal_wifi_off,
  };

  String _networkName(NetworkType type) => switch (type) {
    NetworkType.wifi => 'Wi-Fi',
    NetworkType.mobile => '移动数据',
    NetworkType.none => '无网络',
  };

  Widget _buildQualityTile({
    required BuildContext context,
    required AudioQualityLevel quality,
    required AudioQualityLevel selected,
    required VoidCallback onTap,
    String? subtitle,
  }) {
    return MusicRadioTile<AudioQualityLevel>(
      value: quality,
      groupValue: selected,
      icon: _qualityIcon(quality),
      title: quality.displayName,
      subtitle: subtitle,
      onChanged: (_) => onTap(),
    );
  }

  IconData _qualityIcon(AudioQualityLevel quality) => switch (quality) {
    AudioQualityLevel.original => AppIcons.album_outlined,
    AudioQualityLevel.high => AppIcons.high_quality_outlined,
    AudioQualityLevel.standard => AppIcons.music_note_outlined,
    AudioQualityLevel.dataSaver => AppIcons.signal_cellular_alt,
  };
}
