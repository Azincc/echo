import 'package:flutter/material.dart';
import 'shimmer_loading.dart';

// ──────────────────────────────────────────────────────────────────────
// 1. 歌曲网格骨架 — discover_page 随机推荐
// ──────────────────────────────────────────────────────────────────────

/// 模拟首页 2 列歌曲网格（48px 封面 + 文字）
class SongGridSkeleton extends StatelessWidget {
  final int count;
  const SongGridSkeleton({super.key, this.count = 6});

  @override
  Widget build(BuildContext context) {
    return ShimmerEffect(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.8,
          crossAxisSpacing: 12,
          mainAxisSpacing: 8,
        ),
        itemCount: count,
        itemBuilder: (context, index) {
          return Row(
            children: [
              const SkeletonBox(width: 48, height: 48, borderRadius: 6),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonBox(
                      width: 80 + (index % 3) * 20,
                      height: 13,
                      borderRadius: 3,
                    ),
                    const SizedBox(height: 6),
                    SkeletonBox(
                      width: 50 + (index % 2) * 15,
                      height: 11,
                      borderRadius: 3,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────
// 2. 横向专辑卡片骨架 — discover_page 最近入库 / 最近播放
// ──────────────────────────────────────────────────────────────────────

/// 模拟高 200px 横向滚动的专辑卡片列表
class AlbumCarouselSkeleton extends StatelessWidget {
  final int count;
  const AlbumCarouselSkeleton({super.key, this.count = 4});

  @override
  Widget build(BuildContext context) {
    return ShimmerEffect(
      child: SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: count,
          itemBuilder: (context, index) {
            return Container(
              width: 140,
              margin: const EdgeInsets.only(right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SkeletonBox(width: 140, height: 140, borderRadius: 8),
                  const SizedBox(height: 8),
                  SkeletonBox(
                    width: 90 + (index % 3) * 15,
                    height: 14,
                    borderRadius: 3,
                  ),
                  const SizedBox(height: 4),
                  SkeletonBox(
                    width: 60 + (index % 2) * 20,
                    height: 12,
                    borderRadius: 3,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────
// 3. 专辑网格骨架 — discover_page 常听专辑、starred_page、artist_detail_page
// ──────────────────────────────────────────────────────────────────────

/// 模拟 2 列专辑网格（1:1 正方形封面 + 文字）
class AlbumGridSkeleton extends StatelessWidget {
  final int count;
  const AlbumGridSkeleton({super.key, this.count = 6});

  @override
  Widget build(BuildContext context) {
    return ShimmerEffect(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: count,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AspectRatio(
                aspectRatio: 1.0,
                child: SkeletonBox(borderRadius: 8),
              ),
              const SizedBox(height: 8),
              SkeletonBox(
                width: 80 + (index % 3) * 20,
                height: 14,
                borderRadius: 3,
              ),
              const SizedBox(height: 4),
              SkeletonBox(
                width: 55 + (index % 2) * 15,
                height: 12,
                borderRadius: 3,
              ),
            ],
          );
        },
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────
// 4. 通用 ListTile 列表骨架
// ──────────────────────────────────────────────────────────────────────

/// 模拟 ListTile 列表，支持圆形/方形 leading 和可选 trailing
class ListTileSkeleton extends StatelessWidget {
  final int count;
  final bool isCircleAvatar;
  final bool hasTrailing;
  final bool hasIcon;
  final double leadingSize;

  const ListTileSkeleton({
    super.key,
    this.count = 6,
    this.isCircleAvatar = false,
    this.hasTrailing = false,
    this.hasIcon = false,
    this.leadingSize = 48,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerEffect(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: count,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                if (hasIcon)
                  const Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: SkeletonBox(width: 24, height: 24, borderRadius: 4),
                  ),
                isCircleAvatar
                    ? SkeletonBox.circle(size: leadingSize)
                    : SkeletonBox(
                        width: leadingSize,
                        height: leadingSize,
                        borderRadius: 6,
                      ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonBox(
                        width: 120 + (index % 4) * 25,
                        height: 14,
                        borderRadius: 3,
                      ),
                      const SizedBox(height: 6),
                      SkeletonBox(
                        width: 70 + (index % 3) * 20,
                        height: 12,
                        borderRadius: 3,
                      ),
                    ],
                  ),
                ),
                if (hasTrailing)
                  const SkeletonBox(width: 36, height: 12, borderRadius: 3),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────
// 5. 专辑详情页骨架
// ──────────────────────────────────────────────────────────────────────

/// 模拟专辑详情页：大封面 + 标题/副标题信息 + 操作按钮 + 歌曲列表
class AlbumDetailSkeleton extends StatelessWidget {
  const AlbumDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerEffect(
      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          // 模拟 SliverAppBar 大封面
          SliverToBoxAdapter(
            child: Container(
              height: 300,
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF2A2A2A)
                  : const Color(0xFFE0E0E0),
            ),
          ),
          // 信息区域
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SkeletonBox(width: 160, height: 18, borderRadius: 4),
                  const SizedBox(height: 8),
                  const SkeletonBox(width: 120, height: 14, borderRadius: 3),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      SkeletonBox(width: 110, height: 40, borderRadius: 20),
                      const SizedBox(width: 8),
                      const SkeletonBox.circle(size: 40),
                      const SizedBox(width: 8),
                      const SkeletonBox.circle(size: 40),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // 歌曲列表骨架
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    const SkeletonBox.circle(size: 40),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonBox(
                            width: 120 + (index % 4) * 25,
                            height: 14,
                            borderRadius: 3,
                          ),
                          const SizedBox(height: 6),
                          SkeletonBox(
                            width: 70 + (index % 3) * 20,
                            height: 12,
                            borderRadius: 3,
                          ),
                        ],
                      ),
                    ),
                    const SkeletonBox(width: 36, height: 12, borderRadius: 3),
                  ],
                ),
              ),
              childCount: 8,
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────
// 6. 歌手详情页骨架
// ──────────────────────────────────────────────────────────────────────

/// 模拟歌手详情页：圆形头像 + 名称 + 专辑网格
class ArtistDetailSkeleton extends StatelessWidget {
  const ArtistDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerEffect(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const SkeletonBox.circle(size: 120),
            const SizedBox(height: 16),
            const SkeletonBox(width: 140, height: 22, borderRadius: 4),
            const SizedBox(height: 8),
            const SkeletonBox(width: 80, height: 14, borderRadius: 3),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AlbumGridSkeleton(count: 4),
            ),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────
// 7. 歌单详情页骨架
// ──────────────────────────────────────────────────────────────────────

/// 模拟歌单详情页：标题 + 描述 + 按钮 + 歌曲列表
class PlaylistDetailSkeleton extends StatelessWidget {
  const PlaylistDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerEffect(
      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SkeletonBox(width: 200, height: 24, borderRadius: 4),
                  const SizedBox(height: 12),
                  const SkeletonBox(width: 280, height: 14, borderRadius: 3),
                  const SizedBox(height: 8),
                  const SkeletonBox(width: 100, height: 14, borderRadius: 3),
                  const SizedBox(height: 16),
                  SkeletonBox(width: 110, height: 40, borderRadius: 20),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    const SkeletonBox.circle(size: 40),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonBox(
                            width: 120 + (index % 4) * 25,
                            height: 14,
                            borderRadius: 3,
                          ),
                          const SizedBox(height: 6),
                          SkeletonBox(
                            width: 70 + (index % 3) * 20,
                            height: 12,
                            borderRadius: 3,
                          ),
                        ],
                      ),
                    ),
                    const SkeletonBox(width: 36, height: 12, borderRadius: 3),
                  ],
                ),
              ),
              childCount: 8,
            ),
          ),
        ],
      ),
    );
  }
}
