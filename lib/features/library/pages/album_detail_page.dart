import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/album.dart';
import '../../../data/models/song.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/navigation_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../providers/download_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../widgets/cover_art_image.dart';
import '../../player/widgets/song_options_sheet.dart';
import '../widgets/album_options_sheet.dart';
import 'package:marquee/marquee.dart';
import '../../../widgets/error_placeholder.dart';
import '../../../widgets/song_list_item.dart';
import '../../../widgets/skeleton_templates.dart';
import '../../../widgets/visible_remote_retry_scope.dart';

/// 专辑详情页
class AlbumDetailPage extends ConsumerWidget {
  final String albumId;

  const AlbumDetailPage({super.key, required this.albumId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albumDetailAsync = ref.watch(albumDetailProvider(albumId));
    final loadFailed = ref.watch(albumDetailLoadFailedProvider(albumId));

    return VisibleRemoteRetryScope(
      branchIndex: libraryBranchIndex,
      debugLabel: 'album_detail_page',
      shouldRetry: (ref) => loadFailed || albumDetailAsync.hasError,
      onRetry: (ref) => ref.invalidate(albumDetailProvider(albumId)),
      child: Scaffold(
        body: albumDetailAsync.when(
          data: (albumDetail) {
            final hasAlbumData = albumDetail != null;
            final album =
                albumDetail?.album ??
                Album(
                  id: albumId,
                  name: loadFailed ? '专辑加载失败' : '专辑不存在',
                  songCount: 0,
                  duration: 0,
                );
            final songs = albumDetail?.songs ?? const [];

            return Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 300,
                      pinned: true,
                      actions: [
                        IconButton(
                          onPressed: hasAlbumData
                              ? () {
                                  showAlbumOptionsSheet(
                                    context: context,
                                    ref: ref,
                                    album: album,
                                  );
                                }
                              : null,
                          icon: const Icon(Icons.more_horiz),
                          tooltip: '专辑操作',
                        ),
                      ],
                      flexibleSpace: Stack(
                        children: [
                          // Layer 1: Parallax Image
                          FlexibleSpaceBar(
                            background: CoverArtImage(
                              coverArtId: album.coverArt,
                              requestSize: 1400,
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
                                    Theme.of(context).scaffoldBackgroundColor
                                        .withValues(alpha: 0.0),
                                    Theme.of(context).scaffoldBackgroundColor
                                        .withValues(alpha: 0.5),
                                    Theme.of(context).scaffoldBackgroundColor
                                        .withValues(alpha: 0.9),
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
                                      (settings.currentExtent -
                                          settings.minExtent) /
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
                                      Theme.of(context).brightness ==
                                      Brightness.dark;
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
                                            textPainter.width >
                                            constraints.maxWidth;

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
                                            accelerationDuration:
                                                const Duration(seconds: 1),
                                            accelerationCurve: Curves.linear,
                                            decelerationDuration:
                                                const Duration(
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
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                            ),
                            if (loadFailed && !hasAlbumData) ...[
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Icon(
                                    Icons.wifi_off,
                                    size: 16,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '网络异常，专辑加载失败',
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurfaceVariant,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                FilledButton.icon(
                                  onPressed: songs.isEmpty
                                      ? null
                                      : () {
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
                                  onPressed: hasAlbumData
                                      ? () async {
                                          try {
                                            final musicRepository = ref.read(
                                              musicRepositoryProvider,
                                            );
                                            if (musicRepository == null) return;
                                            await musicRepository
                                                .setAlbumStarred(
                                                  album.id,
                                                  !album.starred,
                                                );
                                            // 刷新专辑详情和收藏列表
                                            ref.invalidate(
                                              albumDetailProvider(albumId),
                                            );
                                            ref.invalidate(starredProvider);
                                            ref.invalidate(
                                              recentAlbumsProvider,
                                            );
                                            ref.invalidate(
                                              frequentAlbumsProvider,
                                            );
                                          } catch (e) {
                                            // 显示错误提示
                                            if (context.mounted) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text('操作失败: $e'),
                                                ),
                                              );
                                            }
                                          }
                                        }
                                      : null,
                                  icon: Icon(
                                    album.starred
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: album.starred ? Colors.red : null,
                                  ),
                                ),
                                // 下载专辑按钮
                                IconButton(
                                  onPressed: songs.isEmpty
                                      ? null
                                      : () {
                                          final authState = ref.read(
                                            authStateProvider,
                                          );
                                          final libraryId =
                                              authState.currentLibrary?.id ??
                                              '';
                                          if (libraryId.isEmpty) return;

                                          final service = ref.read(
                                            downloadServiceProvider,
                                          );
                                          service.enqueueBatch(
                                            songs,
                                            libraryId: libraryId,
                                          );
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                '已添加 ${songs.length} 首歌曲到下载队列',
                                              ),
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
                        return SongListItem(
                          song: song,
                          index: index,
                          variant: SongListItemVariant.albumTrack,
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
                ),
              ),
            );
          },
          loading: () => const AlbumDetailSkeleton(),
          error: (error, stack) =>
              const ErrorPlaceholder(message: '专辑加载失败，请检查网络后重试'),
        ),
      ),
    );
  }

  void _showSongContextMenu(BuildContext context, WidgetRef ref, Song song) {
    showSongOptionsSheet(context: context, song: song);
  }
}
