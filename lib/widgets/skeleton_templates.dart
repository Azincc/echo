import 'package:flutter/material.dart';

import 'music_chrome.dart';
import 'shimmer_loading.dart';

// ──────────────────────────────────────────────────────────────────────
// 1. 歌曲网格骨架 — discover_page 随机推荐
// ──────────────────────────────────────────────────────────────────────

/// 模拟首页 2 列歌曲网格（52px 封面 + 标题/歌手 + 播放动作）
class SongGridSkeleton extends StatelessWidget {
  final int count;
  const SongGridSkeleton({super.key, this.count = 6});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ShimmerEffect(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 74,
          crossAxisSpacing: 12,
          mainAxisSpacing: 8,
        ),
        itemCount: count,
        itemBuilder: (context, index) {
          return Material(
            color: colorScheme.surfaceContainerLow.withValues(
              alpha: theme.brightness == Brightness.dark ? 0.70 : 0.90,
            ),
            borderRadius: BorderRadius.circular(8),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  const SkeletonBox(width: 52, height: 52, borderRadius: 8),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SkeletonLine(
                          widthFactor: 0.62 + (index % 3) * 0.10,
                          height: 12,
                        ),
                        const SizedBox(height: 7),
                        _SkeletonLine(
                          widthFactor: 0.44 + (index % 2) * 0.12,
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  SkeletonBox.circle(size: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────
// 2. 横向专辑卡片骨架 — discover_page 最近入库 / 最近播放
// ──────────────────────────────────────────────────────────────────────

/// 模拟高 226px 横向滚动的专辑卡片列表
class AlbumCarouselSkeleton extends StatelessWidget {
  final int count;
  const AlbumCarouselSkeleton({super.key, this.count = 4});

  @override
  Widget build(BuildContext context) {
    return ShimmerEffect(
      child: SizedBox(
        height: 226,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: count,
          itemBuilder: (context, index) {
            return SizedBox(
              width: 156,
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _AlbumCoverSkeleton(size: 156, shadow: true),
                    const SizedBox(height: 10),
                    _SkeletonLine(
                      widthFactor: 0.58 + (index % 3) * 0.10,
                      height: 12,
                    ),
                    const SizedBox(height: 7),
                    _SkeletonLine(
                      widthFactor: 0.42 + (index % 2) * 0.14,
                      height: 10,
                    ),
                  ],
                ),
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
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MusicChrome.albumGridMaxCrossAxisExtent,
          childAspectRatio: MusicChrome.albumGridChildAspectRatio,
          crossAxisSpacing: MusicChrome.albumGridCrossAxisSpacing,
          mainAxisSpacing: MusicChrome.albumGridMainAxisSpacing,
        ),
        itemCount: count,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AspectRatio(
                aspectRatio: 1.0,
                child: SkeletonBox(borderRadius: 10),
              ),
              const SizedBox(height: 10),
              _SkeletonLine(widthFactor: 0.52 + (index % 3) * 0.12, height: 12),
              const SizedBox(height: 7),
              _SkeletonLine(widthFactor: 0.38 + (index % 2) * 0.12, height: 10),
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

/// 模拟项目当前列表行：透明背景、圆角封面/头像/功能入口 + 文本占位。
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
                _buildLeading(),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SkeletonLine(
                        widthFactor: 0.56 + (index % 4) * 0.08,
                        height: 12,
                      ),
                      const SizedBox(height: 7),
                      _SkeletonLine(
                        widthFactor: 0.34 + (index % 3) * 0.08,
                        height: 10,
                      ),
                    ],
                  ),
                ),
                if (hasTrailing) ...[
                  const SizedBox(width: 12),
                  const SkeletonBox(width: 36, height: 10, borderRadius: 999),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLeading() {
    if (hasIcon) {
      return const SkeletonBox(width: 42, height: 42, borderRadius: 12);
    }

    if (isCircleAvatar) {
      return SkeletonBox.circle(size: leadingSize);
    }

    return SkeletonBox(
      width: leadingSize,
      height: leadingSize,
      borderRadius: 6,
    );
  }
}

// ──────────────────────────────────────────────────────────────────────
// 5. 专辑详情页骨架
// ──────────────────────────────────────────────────────────────────────

/// 模拟专辑详情页：沉浸式封面头图 + 玻璃信息区 + 曲目列表
class AlbumDetailSkeleton extends StatelessWidget {
  const AlbumDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final background = Theme.of(context).scaffoldBackgroundColor;

    return ShimmerEffect(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: MusicChrome.maxContentWidth,
          ),
          child: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 300,
                pinned: true,
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                flexibleSpace: Stack(
                  children: [
                    const Positioned.fill(child: SkeletonBox(borderRadius: 0)),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      height: 120,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              background.withValues(alpha: 0),
                              background.withValues(alpha: 0.50),
                              background.withValues(alpha: 0.90),
                            ],
                            stops: const [0.0, 0.6, 1.0],
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 16,
                      right: 16,
                      bottom: 18,
                      child: _SkeletonLine(widthFactor: 0.48, height: 18),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: MusicGlassSurface(
                    borderRadius: MusicChrome.largeRadius,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _SkeletonLine(widthFactor: 0.38, height: 15),
                        const SizedBox(height: 8),
                        const _SkeletonLine(widthFactor: 0.28, height: 12),
                        const SizedBox(height: 16),
                        Row(
                          children: const [
                            SkeletonBox(
                              width: 118,
                              height: 40,
                              borderRadius: 999,
                            ),
                            SizedBox(width: 8),
                            SkeletonBox.circle(size: 40),
                            SizedBox(width: 8),
                            SkeletonBox.circle(size: 40),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                  child: MusicSectionHeader(
                    title: '曲目',
                    actions: const [
                      SkeletonBox(width: 42, height: 10, borderRadius: 999),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      _SongRowSkeleton(index: index, albumTrack: true),
                  childCount: 8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────
// 6. 歌手详情页骨架
// ──────────────────────────────────────────────────────────────────────

/// 模拟歌手详情页：玻璃头像头部 + TabBar + 默认歌曲列表
class ArtistDetailSkeleton extends StatelessWidget {
  const ArtistDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerEffect(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: MusicChrome.maxContentWidth,
          ),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 96, 16, 24),
            child: Column(
              children: [
                MusicGlassSurface(
                  borderRadius: MusicChrome.largeRadius,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: const [
                      SkeletonBox.circle(size: 120),
                      SizedBox(height: 16),
                      _SkeletonLine(widthFactor: 0.42, height: 20),
                      SizedBox(height: 9),
                      _SkeletonLine(widthFactor: 0.32, height: 12),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                _TabBarSkeleton(),
                const SizedBox(height: 8),
                for (var index = 0; index < 8; index++)
                  _SongRowSkeleton(index: index),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────
// 7. 歌单详情页骨架
// ──────────────────────────────────────────────────────────────────────

/// 模拟歌单详情页：玻璃标题区 + 播放按钮 + 歌曲列表
class PlaylistDetailSkeleton extends StatelessWidget {
  const PlaylistDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerEffect(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: MusicChrome.maxContentWidth,
          ),
          child: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    MediaQuery.paddingOf(context).top + kToolbarHeight + 18,
                    16,
                    16,
                  ),
                  child: MusicGlassSurface(
                    borderRadius: MusicChrome.largeRadius,
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        _SkeletonLine(widthFactor: 0.62, height: 24),
                        SizedBox(height: 12),
                        _SkeletonLine(widthFactor: 0.82, height: 12),
                        SizedBox(height: 8),
                        _SkeletonLine(widthFactor: 0.48, height: 12),
                        SizedBox(height: 14),
                        SkeletonBox(width: 112, height: 28, borderRadius: 999),
                        SizedBox(height: 16),
                        SkeletonBox(height: 42, borderRadius: 999),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                  child: MusicSectionHeader(
                    title: '歌曲',
                    actions: const [
                      SkeletonBox(width: 42, height: 10, borderRadius: 999),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _SongRowSkeleton(index: index),
                  childCount: 8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SongRowSkeleton extends StatelessWidget {
  final int index;
  final bool albumTrack;

  const _SongRowSkeleton({required this.index, this.albumTrack = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          if (albumTrack)
            const SizedBox(
              width: 32,
              child: Center(
                child: SkeletonBox(width: 16, height: 10, borderRadius: 999),
              ),
            )
          else
            const SkeletonBox(width: 48, height: 48, borderRadius: 6),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SkeletonLine(
                  widthFactor: 0.48 + (index % 4) * 0.08,
                  height: 12,
                ),
                const SizedBox(height: 7),
                _SkeletonLine(
                  widthFactor: 0.32 + (index % 3) * 0.08,
                  height: 10,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const SkeletonBox(width: 36, height: 10, borderRadius: 999),
        ],
      ),
    );
  }
}

class _AlbumCoverSkeleton extends StatelessWidget {
  final double size;
  final bool shadow;

  const _AlbumCoverSkeleton({required this.size, this.shadow = false});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: MusicChrome.albumRadius,
        boxShadow: shadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.22 : 0.12),
                  blurRadius: 14,
                  offset: const Offset(0, 7),
                ),
              ]
            : null,
      ),
      child: const ClipRRect(
        borderRadius: MusicChrome.albumRadius,
        child: SkeletonBox(borderRadius: 10),
      ),
    );
  }
}

class _TabBarSkeleton extends StatelessWidget {
  const _TabBarSkeleton();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.82),
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.45),
            width: 0.7,
          ),
        ),
      ),
      child: Row(
        children: const [
          Expanded(
            child: Center(
              child: SkeletonBox(width: 42, height: 12, borderRadius: 999),
            ),
          ),
          Expanded(
            child: Center(
              child: SkeletonBox(width: 42, height: 12, borderRadius: 999),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkeletonLine extends StatelessWidget {
  final double widthFactor;
  final double height;

  const _SkeletonLine({required this.widthFactor, required this.height});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor.clamp(0.0, 1.0).toDouble(),
      alignment: Alignment.centerLeft,
      child: SkeletonBox(height: height, borderRadius: 999),
    );
  }
}
