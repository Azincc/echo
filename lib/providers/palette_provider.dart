import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palette_generator/palette_generator.dart';

import 'api_provider.dart';
import 'player_provider.dart';

/// 当前播放歌曲的调色板 Provider。
///
/// 在歌曲切换时即刻开始提取封面主色调，
/// 使全屏播放器展开时无需再等待调色板计算。
final currentSongPaletteProvider =
    FutureProvider.autoDispose<PaletteGenerator?>((ref) async {
      // 仅监听 currentSong 变化，不监听 position 等高频更新
      final song = ref.watch(playerProvider.select((s) => s.currentSong));
      ref.watch(activeAddressProvider);

      if (song == null) return null;

      try {
        ImageProvider imageProvider;
        final previewCover = song.previewCoverUrl?.trim();
        if (song.isPreview && previewCover != null && previewCover.isNotEmpty) {
          imageProvider = CachedNetworkImageProvider(previewCover);
        } else {
          final coverArtId = song.coverArt;
          if (coverArtId == null || coverArtId.isEmpty) return null;
          final url = ref
              .read(subsonicApiClientProvider)
              .getCoverArtUrl(coverArtId, size: 300);
          if (url.isEmpty) return null;
          imageProvider = CachedNetworkImageProvider(url);
        }

        return await PaletteGenerator.fromImageProvider(
          imageProvider,
          maximumColorCount: 20,
        );
      } catch (_) {
        return null;
      }
    });
