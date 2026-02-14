import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/player_provider.dart';
import '../../../widgets/cover_art_image.dart';
import '../pages/full_player_page.dart';

/// 迷你播放器 - 底部固定条
class MiniPlayer extends ConsumerWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerProvider);

    // 如果没有播放内容，不显示
    if (playerState.currentSong == null) {
      return const SizedBox.shrink();
    }

    final song = playerState.currentSong!;
    final progress = playerState.duration.inMilliseconds > 0
        ? playerState.position.inMilliseconds /
            playerState.duration.inMilliseconds
        : 0.0;

    return GestureDetector(
      onTap: () {
        // 点击展开全屏播放器
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return const FullPlayerPage();
            },
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return child;
            },
            // Reduce duration slightly if needed, or keep default
            transitionDuration: const Duration(milliseconds: 300),
          ),
        );
      },
      child: SizedBox(
        height: 72,
        child: Stack(
          children: [
            // 背景 Hero
            Positioned.fill(
              child: Hero(
                tag: 'player-background',
                child: Material(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  elevation: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color:
                              Theme.of(
                                context,
                              ).colorScheme.outlineVariant.withValues(
                                alpha: 0.2,
                              ),
                          width: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // 内容
            Column(
              children: [
                // 进度条
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 2,
                  backgroundColor: Colors.transparent,
                ),
                // 播放器内容
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        // 封面
                        Hero(
                          tag: 'player-cover',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: CoverArtImage(
                              coverArtId: song.coverArt,
                              size: 48,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // 歌曲信息
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Hero(
                                tag: 'player-title',
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: Text(
                                    song.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              if (song.artist != null)
                                Hero(
                                  tag: 'player-artist',
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Text(
                                      song.artist!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        // 播放/暂停按钮
                        IconButton(
                          icon: Icon(
                            playerState.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                          onPressed: () {
                            ref.read(playerProvider.notifier).togglePlayPause();
                          },
                        ),
                        // 下一首按钮
                        IconButton(
                          icon: const Icon(Icons.skip_next),
                          onPressed: playerState.hasNext
                              ? () {
                                  ref.read(playerProvider.notifier).next();
                                }
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
