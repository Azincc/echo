import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../providers/player_provider.dart';
import '../../../providers/lyrics_cover_provider.dart';
import '../../../providers/api_provider.dart';
import '../../../data/models/lyrics.dart';
import '../../../widgets/cover_art_image.dart';
import '../widgets/play_queue_sheet.dart';
import '../widgets/synced_lyrics_view.dart';

/// 全屏播放器
class FullPlayerPage extends ConsumerStatefulWidget {
  const FullPlayerPage({super.key});

  @override
  ConsumerState<FullPlayerPage> createState() => _FullPlayerPageState();
}

class _FullPlayerPageState extends ConsumerState<FullPlayerPage> {
  bool _showLyrics = false;
  PaletteGenerator? _paletteGenerator;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final song = ref.read(playerProvider).currentSong;
      if (song != null) {
        _updatePalette(song.coverArt);
      }
    });
  }

  Future<void> _updatePalette(String? coverArtId) async {
    if (coverArtId == null) {
      if (mounted) setState(() => _paletteGenerator = null);
      return;
    }

    try {
      final url = ref
          .read(subsonicApiClientProvider)
          .getCoverArtUrl(coverArtId, size: 300);
      final generator = await PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(url),
        maximumColorCount: 20,
      );

      if (mounted) {
        setState(() => _paletteGenerator = generator);
      }
    } catch (e) {
      // Ignore errors
    }
  }

  @override
  Widget build(BuildContext context) {
    final playerState = ref.watch(playerProvider);
    final currentSong = playerState.currentSong;
    final lyricsAsync = ref.watch(currentLyricsProvider);

    // 监听歌曲变化更新背景色
    ref.listen(playerProvider.select((s) => s.currentSong), (previous, next) {
      if (next?.coverArt != previous?.coverArt) {
        _updatePalette(next?.coverArt);
      }
    });

    if (currentSong == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('正在播放')),
        body: const Center(child: Text('暂无播放内容')),
      );
    }

    // 构建背景渐变
    final backgroundColor =
        _paletteGenerator?.dominantColor?.color ??
        Theme.of(context).colorScheme.surface;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              backgroundColor.withValues(alpha: 0.6),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: SafeArea(
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

              // 中间内容区域
              Expanded(
                child: _showLyrics
                    ? // 歌词模式：歌词直接占满 Expanded，无外层 SingleChildScrollView
                      Column(
                        children: [
                          // 歌曲信息（紧凑）
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              children: [
                                const SizedBox(height: 8),
                                Text(
                                  currentSong.title,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  [
                                    if (currentSong.artist != null)
                                      currentSong.artist!,
                                    if (currentSong.album != null)
                                      currentSong.album!,
                                  ].join(' · '),
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurfaceVariant,
                                      ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                          // 歌词视图占满剩余空间
                          Expanded(child: _buildLyricsView(lyricsAsync)),
                        ],
                      )
                    : // 封面模式：保持原有 SingleChildScrollView 布局
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              const SizedBox(height: 32),

                              // 专辑封面
                              Center(
                                child: Container(
                                  width: 320,
                                  height: 320,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainerHighest,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.2,
                                        ),
                                        blurRadius: 20,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: CoverArtImage(
                                      coverArtId: currentSong.coverArt,
                                      size: 320,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 32),

                              // 歌曲信息
                              Text(
                                currentSong.title,
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              const SizedBox(height: 8),

                              Text(
                                [
                                  if (currentSong.artist != null)
                                    currentSong.artist!,
                                  if (currentSong.album != null)
                                    currentSong.album!,
                                ].join(' · '),
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
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
                            color: currentSong.starred ? Colors.red : null,
                          ),
                          onPressed: () {
                            ref.read(playerProvider.notifier).toggleFavorite();
                          },
                        ),

                        // 歌词按钮
                        IconButton(
                          icon: Icon(
                            Icons.lyrics,
                            color: _showLyrics
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          ),
                          onPressed: () {
                            setState(() {
                              _showLyrics = !_showLyrics;
                            });
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
      ),
    );
  }

  Widget _buildLyricsView(AsyncValue<Lyrics?> lyricsAsync) {
    return lyricsAsync.when(
      data: (lyrics) {
        if (lyrics == null || lyrics.isEmpty) {
          return const Center(child: Text('暂无歌词'));
        }
        final bestLyrics = lyrics.getBest();
        if (bestLyrics == null) {
          return const Center(child: Text('暂无歌词'));
        }
        return SyncedLyricsView(lyrics: bestLyrics);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('加载歌词失败')),
    );
  }
}

/// 进度条组件
class ProgressBar extends ConsumerStatefulWidget {
  const ProgressBar({super.key});

  @override
  ConsumerState<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends ConsumerState<ProgressBar> {
  double? _dragValue;

  @override
  Widget build(BuildContext context) {
    final playerState = ref.watch(playerProvider);
    final position = playerState.position;
    final duration = playerState.duration;

    // 确保 value 在有效范围内 (0 到 max)
    final maxMilliseconds = duration.inMilliseconds > 0
        ? duration.inMilliseconds.toDouble()
        : 1.0;
    final currentMilliseconds = position.inMilliseconds.toDouble();

    // 如果正在拖动，使用拖动值，否则使用当前播放进度
    // 限制在 0 到 max 之间
    final sliderValue = (_dragValue ?? currentMilliseconds).clamp(
      0.0,
      maxMilliseconds,
    );
    final displayPosition = _dragValue != null
        ? Duration(milliseconds: _dragValue!.toInt())
        : position;

    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 3,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
          ),
          child: Slider(
            value: sliderValue,
            max: maxMilliseconds,
            onChanged: (value) {
              setState(() {
                _dragValue = value;
              });
            },
            onChangeEnd: (value) {
              ref
                  .read(playerProvider.notifier)
                  .seek(Duration(milliseconds: value.toInt()));
              setState(() {
                _dragValue = null;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDuration(displayPosition),
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
    // 处理负数情况（虽然进度条一般不会由负数，但 robust 一点）
    if (duration.isNegative) return "0:00";
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString()}:${seconds.toString().padLeft(2, '0')}';
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
