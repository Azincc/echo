import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import '../../../providers/player_provider.dart';
import '../../../widgets/cover_art_image.dart';
import '../widgets/play_queue_sheet.dart';

/// 全屏播放器
class FullPlayerPage extends ConsumerWidget {
  const FullPlayerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerProvider);
    final currentSong = playerState.currentSong;

    if (currentSong == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('正在播放'),
        ),
        body: const Center(
          child: Text('暂无播放内容'),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 顶部操作栏
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    '正在播放',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      // TODO: 更多选项菜单
                    },
                  ),
                ],
              ),
            ),

            // 中间可滚动内容区域
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const SizedBox(height: 32),

                      // 专辑封面（大图）- 固定尺寸容器
                      Center(
                        child: Container(
                          width: 320,
                          height: 320,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Theme.of(context).colorScheme.surfaceContainerHighest,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CoverArtImage(
                              coverArtId: currentSong.coverArt,
                              size: 320,
                              fit: BoxFit.contain, // 保持比例，完整显示
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // 歌曲信息
                      Text(
                        currentSong.title,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 8),

                      Text(
                        [
                          if (currentSong.artist != null) currentSong.artist!,
                          if (currentSong.album != null) currentSong.album!,
                        ].join(' · '),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),

            // 底部固定控制栏
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 进度条
                  const ProgressBar(),

                  const SizedBox(height: 24),

                  // 播放控制按钮
                  const PlaybackControls(),

                  const SizedBox(height: 16),

                  // 底部操作按钮
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // 收藏按钮
                      IconButton(
                        icon: Icon(
                          currentSong.starred
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: currentSong.starred
                              ? Colors.red
                              : null,
                        ),
                        onPressed: () {
                          ref.read(playerProvider.notifier).toggleFavorite();
                        },
                      ),

                      // 播放队列按钮
                      IconButton(
                        icon: const Icon(Icons.queue_music),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => const PlayQueueSheet(),
                            isScrollControlled: true,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 进度条组件
class ProgressBar extends ConsumerWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerProvider);
    final position = playerState.position;
    final duration = playerState.duration;

    // 确保 value 在有效范围内 (0 到 max)
    final maxValue = duration.inMilliseconds > 0
        ? duration.inMilliseconds.toDouble()
        : 1.0;
    final currentValue = position.inMilliseconds.toDouble().clamp(0.0, maxValue);

    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 3,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
          ),
          child: Slider(
            value: currentValue,
            max: maxValue,
            onChanged: (value) {
              ref.read(playerProvider.notifier).seek(
                    Duration(milliseconds: value.toInt()),
                  );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDuration(position),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                _formatDuration(duration),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(1, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

/// 播放控制按钮
class PlaybackControls extends ConsumerWidget {
  const PlaybackControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 随机播放按钮
        IconButton(
          icon: Icon(
            Icons.shuffle,
            color: playerState.shuffleEnabled
                ? Theme.of(context).colorScheme.primary
                : null,
          ),
          onPressed: () {
            ref.read(playerProvider.notifier).toggleShuffle();
          },
        ),

        const SizedBox(width: 12),

        // 上一首按钮
        IconButton(
          iconSize: 36,
          icon: const Icon(Icons.skip_previous),
          onPressed: playerState.hasPrevious
              ? () {
                  ref.read(playerProvider.notifier).previous();
                }
              : null,
        ),

        const SizedBox(width: 12),

        // 播放/暂停按钮（大）
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primary,
          ),
          child: IconButton(
            iconSize: 48,
            icon: Icon(
              playerState.isPlaying ? Icons.pause : Icons.play_arrow,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () {
              ref.read(playerProvider.notifier).togglePlayPause();
            },
          ),
        ),

        const SizedBox(width: 12),

        // 下一首按钮
        IconButton(
          iconSize: 36,
          icon: const Icon(Icons.skip_next),
          onPressed: playerState.hasNext
              ? () {
                  ref.read(playerProvider.notifier).next();
                }
              : null,
        ),

        const SizedBox(width: 12),

        // 循环模式按钮
        IconButton(
          icon: Icon(_getLoopIcon(playerState.loopMode)),
          color: playerState.loopMode != LoopMode.off
              ? Theme.of(context).colorScheme.primary
              : null,
          onPressed: () {
            ref.read(playerProvider.notifier).toggleLoopMode();
          },
        ),
      ],
    );
  }

  IconData _getLoopIcon(LoopMode loopMode) {
    switch (loopMode) {
      case LoopMode.off:
        return Icons.repeat;
      case LoopMode.all:
        return Icons.repeat;
      case LoopMode.one:
        return Icons.repeat_one;
    }
  }
}
