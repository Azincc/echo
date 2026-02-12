import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/api_provider.dart';

/// 封面图组件 - 从服务端获取封面
class CoverArtImage extends ConsumerWidget {
  final String? coverArtId;
  final double? size;
  final BoxFit fit;

  const CoverArtImage({
    super.key,
    required this.coverArtId,
    this.size,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (coverArtId == null || coverArtId!.isEmpty) {
      // 没有封面，显示默认图标
      return _buildPlaceholder(context);
    }

    final apiClient = ref.watch(subsonicApiClientProvider);

    // 处理 size 参数，避免 Infinity
    int? coverSize;
    if (size != null && !size!.isInfinite) {
      coverSize = size!.toInt();
    }

    final coverUrl = apiClient.getCoverArtUrl(
      coverArtId!,
      size: coverSize ?? 500,
    );

    if (coverUrl.isEmpty) {
      return _buildPlaceholder(context);
    }

    return CachedNetworkImage(
      imageUrl: coverUrl,
      // 使用 coverArtId 作为缓存键，避免因认证参数变化导致重复下载
      cacheKey: '${coverArtId!}_${coverSize ?? 500}',
      width: size,
      height: size,
      fit: fit,
      placeholder: (context, url) =>
          _buildPlaceholder(context, isLoading: true),
      errorWidget: (context, url, error) => _buildPlaceholder(context),
    );
  }

  /// 构建占位符
  Widget _buildPlaceholder(BuildContext context, {bool isLoading = false}) {
    return Container(
      width: size,
      height: size,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: isLoading
          ? const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          : Icon(
              Icons.music_note,
              size: _getIconSize(),
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
    );
  }

  /// 计算图标大小，避免 Infinity 问题
  double? _getIconSize() {
    if (size == null || size!.isInfinite) {
      return 48; // 默认大小
    }
    return size! * 0.5;
  }
}
