import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/sources/local_storage.dart';

/// 淡入淡出时长 Provider（毫秒，0 = 关闭）
final crossfadeDurationMsProvider =
    StateNotifierProvider<CrossfadeNotifier, int>((ref) {
      return CrossfadeNotifier();
    });

class CrossfadeNotifier extends StateNotifier<int> {
  CrossfadeNotifier() : super(0) {
    _load();
  }

  Future<void> _load() async {
    final ms = await LocalStorage.getCrossfadeDurationMs();
    if (mounted) state = ms;
  }

  Future<void> setDuration(int ms) async {
    final clamped = ms.clamp(0, 3000);
    state = clamped;
    await LocalStorage.setCrossfadeDurationMs(clamped);
  }
}
