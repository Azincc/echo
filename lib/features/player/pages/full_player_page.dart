import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../providers/player_provider.dart';
import '../../../providers/lyrics_cover_provider.dart';
import '../../../providers/api_provider.dart';
import '../../../providers/audio_quality_provider.dart';
import '../../../data/models/lyrics.dart';
import '../../../data/models/audio_quality.dart';
import '../../../data/models/song.dart';
import '../../../core/network/connectivity_monitor.dart';
import '../../../widgets/cover_art_image.dart';
import '../widgets/play_queue_sheet.dart';
import '../widgets/synced_lyrics_view.dart';

/// 全屏播放器
class FullPlayerPage extends ConsumerStatefulWidget {
  const FullPlayerPage({super.key});

  @override
  ConsumerState<FullPlayerPage> createState() => _FullPlayerPageState();
}

class _FullPlayerPageState extends ConsumerState<FullPlayerPage>
    with SingleTickerProviderStateMixin {
  bool _showLyrics = false;
  PaletteGenerator? _paletteGenerator;
  late AnimationController _controller;
  late Animation<double> _topBarAnimation;
  late Animation<double> _controlsAnimation;
  late Animation<double> _bottomBarAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _topBarAnimation = CurvedAnimation(
      parent: _controller,
      // Delay top bar until background has likely covered the top area
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    );

    _controlsAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 0.9, curve: Curves.easeOut),
    );

    _bottomBarAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    );

    _controller.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final song = ref.read(playerProvider).currentSong;
      if (song != null) {
        _updatePalette(song.coverArt);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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

  Color _limitBackgroundLuminance(Color color, {double maxLuminance = 0.3}) {
    final luminance = color.computeLuminance();
    if (luminance <= maxLuminance) return color;

    final blendFactor = ((luminance - maxLuminance) / (1 - maxLuminance)).clamp(
      0.0,
      0.82,
    );
    return Color.lerp(color, Colors.black, blendFactor) ?? color;
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
    final rawBackgroundColor =
        _paletteGenerator?.dominantColor?.color ??
        Theme.of(context).colorScheme.surface;
    final backgroundColor = _limitBackgroundLuminance(
      rawBackgroundColor,
      maxLuminance: 0.32,
    );
    final scaffoldBackgroundColor = _limitBackgroundLuminance(
      Theme.of(context).scaffoldBackgroundColor,
      maxLuminance: 0.2,
    );
    const primaryTextColor = Colors.white;
    final secondaryTextColor = Colors.white.withValues(alpha: 0.78);
    const lyricsActivePrimaryColor = Colors.white;
    const lyricsActiveSecondaryColor = Colors.white;
    final lyricsInactivePrimaryColor = Colors.white.withValues(alpha: 0.64);
    final lyricsInactiveSecondaryColor = Colors.white.withValues(alpha: 0.5);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // 背景 Hero
          Positioned.fill(
            child: Hero(
              tag: 'player-background',
              child: Container(
                decoration: BoxDecoration(
                  color: scaffoldBackgroundColor,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      backgroundColor.withValues(alpha: 0.85),
                      scaffoldBackgroundColor,
                    ],
                  ),
                ),
              ),
            ),
          ),
          // 内容
          SafeArea(
            child: FadeTransition(
              opacity: ModalRoute.of(context)!.animation!,
              child: Column(
                children: [
                  // 顶部操作栏
                  FadeTransition(
                    opacity: _topBarAnimation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: IconTheme(
                        data: Theme.of(
                          context,
                        ).iconTheme.copyWith(color: primaryTextColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.keyboard_arrow_down),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Text(
                              '正在播放',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(color: primaryTextColor),
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
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 8),
                                    Text(
                                      currentSong.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: primaryTextColor,
                                          ),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(color: secondaryTextColor),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ),
                              // 歌词视图占满剩余空间
                              Expanded(
                                child: _buildLyricsView(
                                  lyricsAsync,
                                  activePrimaryColor: lyricsActivePrimaryColor,
                                  activeSecondaryColor:
                                      lyricsActiveSecondaryColor,
                                  inactivePrimaryColor:
                                      lyricsInactivePrimaryColor,
                                  inactiveSecondaryColor:
                                      lyricsInactiveSecondaryColor,
                                ),
                              ),
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
                                    child: Hero(
                                      tag: 'player-cover',
                                      child: Container(
                                        width: 320,
                                        height: 320,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
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
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          child: CoverArtImage(
                                            coverArtId: currentSong.coverArt,
                                            size: 320,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 32),

                                  // 歌曲信息
                                  Hero(
                                    tag: 'player-title',
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: Text(
                                        currentSong.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: primaryTextColor,
                                            ),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  if (currentSong.artist != null ||
                                      currentSong.album != null)
                                    Hero(
                                      tag: 'player-artist',
                                      child: Material(
                                        type: MaterialType.transparency,
                                        child: Text(
                                          [
                                            if (currentSong.artist != null)
                                              currentSong.artist!,
                                            if (currentSong.album != null)
                                              currentSong.album!,
                                          ].join(' · '),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                color: secondaryTextColor,
                                              ),
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),

                                  const SizedBox(height: 32),
                                ],
                              ),
                            ),
                          ),
                  ),

                  // 底部固定控制栏
                  FadeTransition(
                    opacity: _controlsAnimation,
                    child: SlideTransition(
                      position: _controlsAnimation.drive(
                        Tween<Offset>(
                          begin: const Offset(0, 0.2),
                          end: Offset.zero,
                        ),
                      ),
                      child: Container(
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
                            PlaybackControls(currentSong: currentSong),

                            const SizedBox(height: 8),

                            // 底部操作按钮
                            FadeTransition(
                              opacity: _bottomBarAnimation,
                              child: SizedBox(
                                width: 160,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // 歌词按钮
                                    IconButton(
                                      icon: Icon(
                                        Icons.lyrics,
                                        color: _showLyrics
                                            ? Colors.white
                                            : Colors.white.withValues(
                                                alpha: 0.72,
                                              ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _showLyrics = !_showLyrics;
                                        });
                                      },
                                    ),

                                    // 播放队列按钮
                                    IconButton(
                                      icon: Icon(
                                        Icons.queue_music,
                                        color: Colors.white.withValues(
                                          alpha: 0.78,
                                        ),
                                      ),
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) =>
                                              const PlayQueueSheet(),
                                          isScrollControlled: true,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // 音质指示
                            const SizedBox(height: 4),
                            _buildQualityIndicator(ref),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQualityIndicator(WidgetRef ref) {
    final playerState = ref.watch(playerProvider);
    final AudioQualityLevel quality =
        playerState.currentQuality ?? ref.watch(effectiveQualityProvider);
    final source = playerState.playbackSource ?? PlaybackSource.stream;
    final networkType = ref.watch(currentNetworkTypeProvider).valueOrNull;

    String text;
    IconData icon;
    Color? color;

    if (networkType == NetworkType.none) {
      text = '缓存-${quality.displayName}';
      icon = Icons.offline_pin;
      color = Colors.orange;
    } else {
      switch (source) {
        case PlaybackSource.downloaded:
          text = '已下载 · ${quality.displayName}';
          icon = Icons.offline_pin;
          color = Colors.green;
          break;
        case PlaybackSource.cached:
          text = '已缓存 · ${quality.displayName}';
          icon = Icons.check_circle_outline;
          color = Colors.blue;
          break;
        case PlaybackSource.stream:
          final netName = switch (networkType) {
            NetworkType.wifi => 'Wi-Fi',
            NetworkType.mobile => '移动数据',
            NetworkType.none => '无网络',
            null => '未知网络',
          };
          text = '$netName · ${quality.displayName}';
          icon = Icons.cloud_queue;
          color = null;
          break;
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 12,
          color: color ?? Colors.white.withValues(alpha: 0.76),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 10,
            color: color ?? Colors.white.withValues(alpha: 0.76),
          ),
        ),
      ],
    );
  }

  Widget _buildLyricsView(
    AsyncValue<Lyrics?> lyricsAsync, {
    required Color activePrimaryColor,
    required Color activeSecondaryColor,
    required Color inactivePrimaryColor,
    required Color inactiveSecondaryColor,
  }) {
    return lyricsAsync.when(
      data: (lyrics) {
        if (lyrics == null || lyrics.isEmpty) {
          return Center(
            child: Text('暂无歌词', style: TextStyle(color: activePrimaryColor)),
          );
        }
        final bestLyrics = lyrics.getBest();
        if (bestLyrics == null) {
          return Center(
            child: Text('暂无歌词', style: TextStyle(color: activePrimaryColor)),
          );
        }
        return SyncedLyricsView(
          lyrics: bestLyrics,
          activePrimaryColor: activePrimaryColor,
          activeSecondaryColor: activeSecondaryColor,
          inactivePrimaryColor: inactivePrimaryColor,
          inactiveSecondaryColor: inactiveSecondaryColor,
        );
      },
      loading: () =>
          const Center(child: CircularProgressIndicator(color: Colors.white)),
      error: (err, stack) => Center(
        child: Text('加载歌词失败', style: TextStyle(color: activePrimaryColor)),
      ),
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
    final timeTextStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      color: Colors.white.withValues(alpha: 0.78),
    );

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
              Text(_formatDuration(displayPosition), style: timeTextStyle),
              Text(_formatDuration(duration), style: timeTextStyle),
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
  final Song currentSong;

  const PlaybackControls({super.key, required this.currentSong});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerProvider);
    final inactiveControlColor = Colors.white.withValues(alpha: 0.78);
    final playbackMode = playerState.shuffleEnabled
        ? PlaybackMode.shuffle
        : (playerState.loopMode == LoopMode.one
              ? PlaybackMode.repeatOne
              : PlaybackMode.repeatAll);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 播放模式按钮（三态）
        IconButton(
          icon: Icon(_getPlaybackModeIcon(playbackMode), color: Colors.white),
          onPressed: () {
            ref.read(playerProvider.notifier).cyclePlaybackMode();
          },
        ),

        const SizedBox(width: 12),

        // 上一首按钮
        IconButton(
          iconSize: 36,
          icon: Icon(Icons.skip_previous, color: inactiveControlColor),
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
          icon: Icon(Icons.skip_next, color: inactiveControlColor),
          onPressed: playerState.hasNext
              ? () {
                  ref.read(playerProvider.notifier).next();
                }
              : null,
        ),

        const SizedBox(width: 12),

        // 收藏按钮
        IconButton(
          icon: Icon(
            currentSong.starred ? Icons.favorite : Icons.favorite_border,
            color: currentSong.starred ? Colors.red : inactiveControlColor,
          ),
          onPressed: () {
            ref.read(playerProvider.notifier).toggleFavorite();
          },
        ),
      ],
    );
  }

  IconData _getPlaybackModeIcon(PlaybackMode mode) {
    return switch (mode) {
      PlaybackMode.shuffle => Icons.shuffle,
      PlaybackMode.repeatAll => Icons.repeat,
      PlaybackMode.repeatOne => Icons.repeat_one,
    };
  }
}
