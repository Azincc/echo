import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/song.dart';
import '../../../providers/palette_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../widgets/cover_art_image.dart';
import '../pages/full_player_page.dart';
import 'player_hero_helpers.dart';

/// 迷你播放器 - 底部固定条
class MiniPlayer extends ConsumerStatefulWidget {
  const MiniPlayer({super.key});

  @override
  ConsumerState<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends ConsumerState<MiniPlayer> {
  static const double _height = 72;
  static const double _progressHitHeight = 20;
  static const double _swipeActionThreshold = 72;
  static const Duration _swipeSettleDuration = Duration(milliseconds: 180);
  static const double _swipeEdgeGuardWidth = 1;
  static const double _verticalExpandThreshold = 36;

  double _horizontalDragDx = 0;
  double _swipeViewportWidth = 0;
  double _verticalDragDy = 0;
  double? _scrubProgress;
  Song? _pendingVisualSong;
  bool _scrubbing = false;
  bool _progressDragActive = false;
  bool _settlingSwipe = false;

  void _openFullPlayer() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const FullPlayerPage();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  void _togglePlayPause() {
    HapticFeedback.selectionClick();
    ref.read(playerProvider.notifier).togglePlayPause();
  }

  void _handleProgressDragStart(DragStartDetails details) {
    _progressDragActive = details.localPosition.dy <= _progressHitHeight;
    if (!_progressDragActive) return;

    final state = ref.read(playerProvider);
    if (state.duration.inMilliseconds <= 0) return;

    setState(() {
      _scrubbing = true;
      _horizontalDragDx = 0;
      _scrubProgress = _progressFromDx(details.localPosition.dx);
    });
  }

  void _handleProgressDragUpdate(DragUpdateDetails details) {
    if (!_progressDragActive) return;
    final state = ref.read(playerProvider);
    if (state.duration.inMilliseconds <= 0) return;

    setState(() {
      _scrubbing = true;
      _scrubProgress = _progressFromDx(details.localPosition.dx);
    });
  }

  void _handleProgressDragEnd(DragEndDetails details) {
    if (!_scrubbing || _scrubProgress == null) {
      _progressDragActive = false;
      return;
    }

    final state = ref.read(playerProvider);
    final durationMs = state.duration.inMilliseconds;
    if (durationMs > 0) {
      final targetMs = (durationMs * _scrubProgress!).round();
      HapticFeedback.selectionClick();
      ref.read(playerProvider.notifier).seek(Duration(milliseconds: targetMs));
    }

    setState(() {
      _scrubbing = false;
      _scrubProgress = null;
      _progressDragActive = false;
    });
  }

  void _handleProgressDragCancel() {
    setState(() {
      _scrubbing = false;
      _scrubProgress = null;
      _progressDragActive = false;
    });
  }

  double _progressFromDx(double dx) {
    final width = context.size?.width ?? 1;
    return (dx / width).clamp(0.0, 1.0);
  }

  void _handleSwipeDragStart(DragStartDetails details) {
    setState(() {
      _horizontalDragDx = 0;
      _pendingVisualSong = null;
      _settlingSwipe = false;
      _scrubbing = false;
      _scrubProgress = null;
      _progressDragActive = false;
    });
  }

  void _handleSwipeDragUpdate(DragUpdateDetails details) {
    setState(() {
      _horizontalDragDx += details.primaryDelta ?? 0;
    });
  }

  void _handleSwipeDragEnd(DragEndDetails details) {
    final player = ref.read(playerProvider);
    final shouldGoNext =
        _horizontalDragDx <= -_swipeActionThreshold && player.hasNext;
    final shouldGoPrevious =
        _horizontalDragDx >= _swipeActionThreshold && player.hasPrevious;

    if (shouldGoNext || shouldGoPrevious) {
      _switchTrack(next: shouldGoNext);
      return;
    }

    setState(() {
      _horizontalDragDx = 0;
    });
  }

  void _handleSwipeDragCancel() {
    setState(() {
      _horizontalDragDx = 0;
    });
  }

  Future<void> _switchTrack({required bool next}) async {
    HapticFeedback.mediumImpact();
    final player = ref.read(playerProvider);
    final targetSong = _adjacentSong(player, next ? 1 : -1);
    final targetOffset = next ? -_swipeViewportWidth : _swipeViewportWidth;

    setState(() {
      _settlingSwipe = targetSong != null && _swipeViewportWidth > 0;
      _horizontalDragDx = _settlingSwipe ? targetOffset : 0;
    });

    if (_settlingSwipe) {
      await Future<void>.delayed(_swipeSettleDuration);
      if (!mounted) return;
      setState(() {
        _pendingVisualSong = targetSong;
        _horizontalDragDx = 0;
        _settlingSwipe = false;
      });
    }

    if (next) {
      await ref.read(playerProvider.notifier).next();
    } else {
      await ref.read(playerProvider.notifier).previous();
    }

    if (!mounted) return;
    setState(() {
      _pendingVisualSong = null;
    });
  }

  void _handleVerticalDragStart(DragStartDetails details) {
    _verticalDragDy = 0;
  }

  void _handleVerticalDragUpdate(DragUpdateDetails details) {
    _verticalDragDy += details.primaryDelta ?? 0;
  }

  void _handleVerticalDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    final shouldExpand =
        velocity < -600 || _verticalDragDy <= -_verticalExpandThreshold;

    _verticalDragDy = 0;
    if (!shouldExpand) return;

    HapticFeedback.selectionClick();
    _openFullPlayer();
  }

  Song? _adjacentSong(PlayerState playerState, int offset) {
    if (playerState.queue.isEmpty) return null;
    final queueLength = playerState.queue.length;
    final targetIndex =
        (playerState.currentIndex + offset + queueLength) % queueLength;
    if (targetIndex == playerState.currentIndex) return null;
    return playerState.queue[targetIndex];
  }

  @override
  Widget build(BuildContext context) {
    final playerState = ref.watch(playerProvider);
    // 预取调色板：即使 mini-player 不使用颜色，也确保 provider 在歌曲
    // 切换时立即开始计算，全屏播放器展开后无需等待。
    ref.watch(currentSongPaletteProvider);

    if (playerState.currentSong == null) {
      return const SizedBox.shrink();
    }

    final song = _pendingVisualSong ?? playerState.currentSong!;
    final theme = Theme.of(context);
    final progress = playerState.duration.inMilliseconds > 0
        ? playerState.position.inMilliseconds /
              playerState.duration.inMilliseconds
        : 0.0;
    final displayedProgress = (_scrubProgress ?? progress).clamp(0.0, 1.0);
    final previousSong = _adjacentSong(playerState, -1);
    final nextSong = _adjacentSong(playerState, 1);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _openFullPlayer,
      onDoubleTap: _togglePlayPause,
      onHorizontalDragStart: _handleProgressDragStart,
      onHorizontalDragUpdate: _handleProgressDragUpdate,
      onHorizontalDragEnd: _handleProgressDragEnd,
      onHorizontalDragCancel: _handleProgressDragCancel,
      onVerticalDragStart: _handleVerticalDragStart,
      onVerticalDragUpdate: _handleVerticalDragUpdate,
      onVerticalDragEnd: _handleVerticalDragEnd,
      child: SizedBox(
        height: _height,
        child: Stack(
          children: [
            Positioned.fill(
              child: Hero(
                tag: 'player-background',
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainer,
                    border: Border(
                      top: BorderSide(
                        color: theme.colorScheme.outlineVariant.withValues(
                          alpha: 0.2,
                        ),
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                LinearProgressIndicator(
                  value: displayedProgress,
                  minHeight: 2,
                  backgroundColor: Colors.transparent,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onHorizontalDragStart: _handleSwipeDragStart,
                            onHorizontalDragUpdate: _handleSwipeDragUpdate,
                            onHorizontalDragEnd: _handleSwipeDragEnd,
                            onHorizontalDragCancel: _handleSwipeDragCancel,
                            child: ColoredBox(
                              color: theme.colorScheme.surfaceContainer,
                              child: ClipRect(
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          final width = constraints.maxWidth;
                                          _swipeViewportWidth = width;
                                          final dragOffset = _horizontalDragDx
                                              .clamp(-width, width);
                                          final pixelRatio =
                                              MediaQuery.devicePixelRatioOf(
                                                context,
                                              );
                                          final translateX =
                                              ((-width + dragOffset) *
                                                      pixelRatio)
                                                  .round() /
                                              pixelRatio;

                                          return AnimatedContainer(
                                            duration: _settlingSwipe
                                                ? _swipeSettleDuration
                                                : Duration.zero,
                                            curve: Curves.easeOutCubic,
                                            transform:
                                                Matrix4.translationValues(
                                                  translateX,
                                                  0,
                                                  0,
                                                ),
                                            child: SizedBox(
                                              width: width * 3,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: width,
                                                    child: previousSong == null
                                                        ? const SizedBox.shrink()
                                                        : Padding(
                                                            padding:
                                                                const EdgeInsets.only(
                                                                  left:
                                                                      _swipeEdgeGuardWidth,
                                                                ),
                                                            child: _MiniPlayerTrack(
                                                              song:
                                                                  previousSong,
                                                              theme: theme,
                                                              useHero: false,
                                                            ),
                                                          ),
                                                  ),
                                                  SizedBox(
                                                    width: width,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                            left:
                                                                _swipeEdgeGuardWidth,
                                                          ),
                                                      child: _MiniPlayerTrack(
                                                        song: song,
                                                        theme: theme,
                                                        useHero: true,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width,
                                                    child: nextSong == null
                                                        ? const SizedBox.shrink()
                                                        : Padding(
                                                            padding:
                                                                const EdgeInsets.only(
                                                                  left:
                                                                      _swipeEdgeGuardWidth,
                                                                ),
                                                            child:
                                                                _MiniPlayerTrack(
                                                                  song:
                                                                      nextSong,
                                                                  theme: theme,
                                                                  useHero:
                                                                      false,
                                                                ),
                                                          ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      bottom: 0,
                                      width: _swipeEdgeGuardWidth,
                                      child: ColoredBox(
                                        color:
                                            theme.colorScheme.surfaceContainer,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            playerState.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                          onPressed: _togglePlayPause,
                        ),
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
            if (_scrubbing)
              Positioned(
                top: 8,
                left: 16,
                right: 16,
                child: _MiniPlayerScrubBubble(
                  progress: displayedProgress,
                  duration: playerState.duration,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MiniPlayerTrack extends StatelessWidget {
  const _MiniPlayerTrack({
    required this.song,
    required this.theme,
    required this.useHero,
  });

  final Song song;
  final ThemeData theme;
  final bool useHero;

  @override
  Widget build(BuildContext context) {
    final artistName = song.artist?.trim();
    final albumName = song.album?.trim();
    final subtitleText = artistName ?? albumName ?? '';
    final hasSubtitle = subtitleText.isNotEmpty;
    final cover = _MiniPlayerCover(song: song);
    final title = _MiniPlayerTitle(song: song, theme: theme);
    final subtitle = _MiniPlayerSubtitle(text: subtitleText, theme: theme);

    return Row(
      children: [
        if (useHero)
          Hero(
            tag: 'player-cover',
            createRectTween: playerCoverRectTween,
            child: cover,
          )
        else
          cover,
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (useHero)
                Hero(
                  tag: 'player-title',
                  createRectTween: playerLinearRectTween,
                  flightShuttleBuilder: playerTextFlightShuttleBuilder,
                  child: title,
                )
              else
                title,
              if (hasSubtitle)
                if (useHero)
                  Hero(
                    tag: 'player-subtitle',
                    createRectTween: playerLinearRectTween,
                    flightShuttleBuilder: playerTextFlightShuttleBuilder,
                    child: subtitle,
                  )
                else
                  subtitle,
            ],
          ),
        ),
      ],
    );
  }
}

class _MiniPlayerCover extends StatelessWidget {
  const _MiniPlayerCover({required this.song});

  final Song song;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: CoverArtImage(
          coverArtId: song.coverArt,
          size: 48,
          requestSize: 640,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _MiniPlayerTitle extends StatelessWidget {
  const _MiniPlayerTitle({required this.song, required this.theme});

  final Song song;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Text(
          song.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}

class _MiniPlayerSubtitle extends StatelessWidget {
  const _MiniPlayerSubtitle({required this.text, required this.theme});

  final String text;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _MiniPlayerScrubBubble extends StatelessWidget {
  const _MiniPlayerScrubBubble({
    required this.progress,
    required this.duration,
  });

  final double progress;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final position = Duration(
      milliseconds: (duration.inMilliseconds * progress).round(),
    );
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment((progress * 2 - 1).clamp(-1.0, 1.0), 0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.inverseSurface.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            _formatDuration(position),
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onInverseSurface,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ),
      ),
    );
  }

  static String _formatDuration(Duration duration) {
    final totalSeconds = duration.inSeconds;
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
