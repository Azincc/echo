import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/network/connectivity_monitor.dart';
import '../data/models/audio_quality.dart';
import '../data/sources/local_storage.dart';
import 'api_provider.dart';

/// 音质设置状态 Provider
final audioQualitySettingsProvider =
    StateNotifierProvider<AudioQualitySettingsNotifier, AudioQualitySettings>(
      (ref) => AudioQualitySettingsNotifier(),
    );

class AudioQualitySettingsNotifier extends StateNotifier<AudioQualitySettings> {
  AudioQualitySettingsNotifier() : super(const AudioQualitySettings()) {
    _load();
  }

  Future<void> _load() async {
    state = await LocalStorage.getAudioQualitySettings();
  }

  Future<void> setWifiQuality(AudioQualityLevel quality) async {
    state = state.copyWith(wifiQuality: quality);
    await LocalStorage.setAudioQualitySettings(state);
  }

  Future<void> setMobileQuality(AudioQualityLevel quality) async {
    state = state.copyWith(mobileQuality: quality);
    await LocalStorage.setAudioQualitySettings(state);
  }

  Future<void> setAutoSwitch(bool value) async {
    state = state.copyWith(autoSwitch: value);
    await LocalStorage.setAudioQualitySettings(state);
  }
}

/// 当前网络类型 Provider（基于 api_provider 中共享的 ConnectivityMonitor）
final currentNetworkTypeProvider = StreamProvider<NetworkType>((ref) {
  final monitor = ref.watch(connectivityMonitorProvider);

  final controller = StreamController<NetworkType>();
  controller.add(monitor.currentNetworkType);

  final subscription = monitor.networkTypeStream.listen(
    controller.add,
    onError: controller.addError,
  );

  ref.onDispose(() {
    subscription.cancel();
    controller.close();
  });

  return controller.stream;
});

/// 当前生效音质 Provider（结合网络类型和设置计算）
final effectiveQualityProvider = Provider<AudioQualityLevel>((ref) {
  final settings = ref.watch(audioQualitySettingsProvider);
  final networkType = ref.watch(currentNetworkTypeProvider);

  if (!settings.autoSwitch) {
    // 不自动切换时，使用 Wi-Fi 设置作为全局设置
    return settings.wifiQuality;
  }

  final type = networkType.valueOrNull ?? NetworkType.none;

  return switch (type) {
    NetworkType.wifi => settings.wifiQuality,
    NetworkType.mobile => settings.mobileQuality,
    NetworkType.none => settings.mobileQuality, // 无网络时使用移动数据设置
  };
});
