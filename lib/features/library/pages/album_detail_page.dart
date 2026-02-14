import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../providers/download_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../widgets/cover_art_image.dart';
import 'package:marquee/marquee.dart';

/// 专辑详情页
class AlbumDetailPage extends ConsumerWidget {
  final String albumId;

  const AlbumDetailPage({super.key, required this.albumId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albumDetailAsync = ref.watch(albumDetailProvider(albumId));

    return Scaffold(
      body: albumDetailAsync.when(
        data: (albumDetail) {
          if (albumDetail == null) {
            return const Center(child: Text('专辑不存在'));
          }

          final album = albumDetail.album;
          final songs = albumDetail.songs;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                flexibleSpace: Stack(
                  children: [
                    // Layer 1: Parallax Image
                    FlexibleSpaceBar(
                      background: CoverArtImage(
                        coverArtId: album.coverArt,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Layer 2: Fixed Gradient Shadow (follows divider)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      height: 120, // Approx 1/3 to 1/4 of expanded height
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Theme.of(
                                context,
                              ).scaffoldBackgroundColor.withValues(alpha: 0.0),
                              Theme.of(
                                context,
                              ).scaffoldBackgroundColor.withValues(alpha: 0.5),
                              Theme.of(
                                context,
                              ).scaffoldBackgroundColor.withValues(alpha: 0.9),
                            ],
                            // Smooth fade from top of this container to bottom
                            stops: const [0.0, 0.6, 1.0],
                          ),
                        ),
                      ),
                    ),
                    // Layer 3: Title (Animation)
                    FlexibleSpaceBar(
                      titlePadding: EdgeInsets.zero,
                      title: SizedBox(
                        height: 50,
                        child: Builder(
                          builder: (context) {
                            final settings = context
                                .dependOnInheritedWidgetOfExactType<
                                  FlexibleSpaceBarSettings
                                >();
                            final deltaExtent =
                                settings!.maxExtent - settings.minExtent;
                            final t =
                                (settings.currentExtent - settings.minExtent) /
                                deltaExtent;
                            // t goes from 0.0 (collapsed) to 1.0 (expanded)

                            // Dynamic padding:
                            // Collapsed: left 56 (clears back button)
                            // Expanded: left 16 (standard margin)
                            final tClamped = t.clamp(0.0, 1.0);

                            // helper function
                            final leftPadding =
                                lerpDouble(56.0, 16.0, tClamped) ?? 16.0;

                            final isDark =
                                Theme.of(context).brightness == Brightness.dark;
                            final textColor = isDark
                                ? Colors.white
                                : Colors.black;
                            final shadowColor = isDark
                                ? Colors.black.withValues(alpha: 0.8)
                                : Colors.white.withValues(alpha: 0.8);

                            final textStyle = TextStyle(
                              color: textColor,
                              shadows: [
                                Shadow(
                                  offset: const Offset(0, 1),
                                  blurRadius: 3.0,
                                  color: shadowColor,
                                ),
                              ],
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            );

                            return Padding(
                              padding: EdgeInsets.only(
                                left: leftPadding,
                                right: 16,
                                bottom: 16,
                              ),
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  final textPainter =
                                      TextPainter(
                                        text: TextSpan(
                                          text: album.name,
                                          style: textStyle,
                                        ),
                                        maxLines: 1,
                                        textDirection: TextDirection.ltr,
                                      )..layout(
                                        minWidth: 0,
                                        maxWidth: double.infinity,
                                      );

                                  final isOverflowing =
                                      textPainter.width > constraints.maxWidth;

                                  if (isOverflowing) {
                                    return Marquee(
                                      text: album.name,
                                      style: textStyle,
                                      scrollAxis: Axis.horizontal,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      blankSpace: 20.0,
                                      velocity: 30.0,
                                      pauseAfterRound: const Duration(
                                        seconds: 2,
                                      ),
                                      startPadding: 0.0,
                                      accelerationDuration: const Duration(
                                        seconds: 1,
                                      ),
                                      accelerationCurve: Curves.linear,
                                      decelerationDuration: const Duration(
                                        milliseconds: 500,
                                      ),
                                      decelerationCurve: Curves.easeOut,
                                    );
                                  } else {
                                    return Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        album.name,
                                        style: textStyle,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    );
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (album.artist != null)
                        Text(
                          album.artist!,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      const SizedBox(height: 4),
                      Text(
                        '${album.songCount} 首 · ${album.durationString}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          FilledButton.icon(
                            onPressed: () {
                              // 播放全部
                              ref
                                  .read(playerProvider.notifier)
                                  .playQueue(songs);
                            },
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('播放全部'),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () async {
                              try {
                                final musicRepository = ref.read(
                                  musicRepositoryProvider,
                                );
                                if (musicRepository == null) return;
                                await musicRepository.setAlbumStarred(
                                  album.id,
                                  !album.starred,
                                );
                                // 刷新专辑详情和收藏列表
                                ref.invalidate(albumDetailProvider(albumId));
                                ref.invalidate(starredProvider);
                                ref.invalidate(recentAlbumsProvider);
                                ref.invalidate(frequentAlbumsProvider);
                              } catch (e) {
                                // 显示错误提示
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('操作失败: $e')),
                                  );
                                }
                              }
                            },
                            icon: Icon(
                              album.starred
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: album.starred ? Colors.red : null,
                            ),
                          ),
                          // 下载专辑按钮
                          IconButton(
                            onPressed: () {
                              final authState = ref.read(authStateProvider);
                              final libraryId =
                                  authState.currentLibrary?.id ?? '';
                              if (libraryId.isEmpty) return;

                              final service = ref.read(downloadServiceProvider);
                              service.enqueueBatch(songs, libraryId: libraryId);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('已添加 ${songs.length} 首歌曲到下载队列'),
                                ),
                              );
                            },
                            icon: const Icon(Icons.download_outlined),
                            tooltip: '下载专辑',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final song = songs[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('${song.track ?? index + 1}'),
                    ),
                    title: Text(song.title),
                    subtitle: song.artist != null ? Text(song.artist!) : null,
                    trailing: Text(song.durationString),
                    onTap: () {
                      // 播放歌曲
                      ref
                          .read(playerProvider.notifier)
                          .playQueue(songs, startIndex: index);
                    },
                    onLongPress: () {
                      _showSongContextMenu(context, ref, song);
                    },
                  );
                }, childCount: songs.length),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 16),
              Text('加载失败: $error'),
            ],
          ),
        ),
      ),
    );
  }

  void _showSongContextMenu(BuildContext context, WidgetRef ref, dynamic song) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text('下载'),
              onTap: () {
                Navigator.pop(context);
                final authState = ref.read(authStateProvider);
                final libraryId = authState.currentLibrary?.id ?? '';
                if (libraryId.isEmpty) return;

                ref
                    .read(downloadServiceProvider)
                    .enqueue(song, libraryId: libraryId);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('已添加「${song.title}」到下载队列')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
