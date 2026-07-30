import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/echo_design.dart';
import '../../../data/models/song.dart';
import '../../../providers/palette_provider.dart';
import '../../../providers/player_provider.dart';
import '../../../widgets/cover_art_image.dart';
import '../pages/full_player_page.dart';
import 'play_queue_sheet.dart';
import 'player_hero_helpers.dart';
import 'song_options_sheet.dart';

/// Stable bridge between the application shell and the immersive player.
class MiniPlayer extends ConsumerWidget {
  const MiniPlayer({super.key});

  static const double height = 72;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(
      playerProvider.select(
        (state) => (
          currentSong: state.currentSong,
          queue: state.queue,
          currentIndex: state.currentIndex,
          isPlaying: state.isPlaying,
          shuffleEnabled: state.shuffleEnabled,
          duration: state.duration,
        ),
      ),
    );
    final playerState = PlayerState(
      currentSong: snapshot.currentSong,
      queue: snapshot.queue,
      currentIndex: snapshot.currentIndex,
      isPlaying: snapshot.isPlaying,
      shuffleEnabled: snapshot.shuffleEnabled,
      duration: snapshot.duration,
    );
    final visuals = ref.watch(resolvedCurrentSongMediaVisualsProvider);
    final currentSong = playerState.currentSong;
    if (currentSong == null) return const SizedBox.shrink();

    return MiniPlayerView(
      playerState: playerState,
      mediaVisuals: visuals,
      onOpenPlayer: () => _openFullPlayer(context),
      onTogglePlayPause: () =>
          ref.read(playerProvider.notifier).togglePlayPause(),
      onPrevious: () => ref.read(playerProvider.notifier).previous(),
      onNext: () => ref.read(playerProvider.notifier).next(),
      onSeek: (position) => ref.read(playerProvider.notifier).seek(position),
      progressLayer: const _ProviderMiniPlayerProgress(),
      onOpenActions: () => _showPlayerActions(
        context: context,
        ref: ref,
        playerState: playerState,
        song: currentSong,
      ),
    );
  }

  static void _openFullPlayer(BuildContext context) {
    final duration = context.echoMotion.resolve(
      context,
      context.echoMotion.scene,
    );
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const FullPlayerPage();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
        transitionDuration: duration,
        reverseTransitionDuration: duration,
      ),
    );
  }

  static Future<void> _showPlayerActions({
    required BuildContext context,
    required WidgetRef ref,
    required PlayerState playerState,
    required Song song,
  }) async {
    void closeThen(
      BuildContext sheetContext,
      FutureOr<void> Function() action,
    ) {
      Navigator.of(sheetContext).pop();
      Future<void>.microtask(() async {
        if (!context.mounted) return;
        await action();
      });
    }

    await showEchoBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (sheetContext) => EchoBottomSheet(
        title: '播放操作',
        subtitle: <String>[
          song.title,
          if (song.artist?.trim().isNotEmpty == true) song.artist!.trim(),
        ].join(' · '),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(sheetContext).height * 0.55,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                EchoActionRow(
                  icon: AppIcons.previous,
                  title: '上一首',
                  onPressed: playerState.hasPrevious
                      ? () => closeThen(
                          sheetContext,
                          () => ref.read(playerProvider.notifier).previous(),
                        )
                      : null,
                ),
                EchoActionRow(
                  icon: AppIcons.next,
                  title: '下一首',
                  onPressed: playerState.hasNext
                      ? () => closeThen(
                          sheetContext,
                          () => ref.read(playerProvider.notifier).next(),
                        )
                      : null,
                ),
                EchoActionRow(
                  icon: AppIcons.queue,
                  title: '查看播放队列',
                  onPressed: () => closeThen(
                    sheetContext,
                    () => showPlayQueueSheet(context: context),
                  ),
                ),
                EchoActionRow(
                  icon: AppIcons.more,
                  title: '曲目操作',
                  onPressed: () => closeThen(
                    sheetContext,
                    () => showSongOptionsSheet(context: context, song: song),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Pure player surface kept public so gesture, semantics and large-text
/// behaviour can be tested without constructing the audio engine.
@visibleForTesting
class MiniPlayerView extends StatefulWidget {
  const MiniPlayerView({
    super.key,
    required this.playerState,
    required this.onOpenPlayer,
    required this.onTogglePlayPause,
    required this.onPrevious,
    required this.onNext,
    required this.onSeek,
    required this.onOpenActions,
    this.mediaVisuals,
    this.albumColor,
    this.progressLayer,
  });

  final PlayerState playerState;
  final EchoMediaVisuals? mediaVisuals;

  /// Compatibility seed for provider-free tests and older call sites.
  final Color? albumColor;
  final VoidCallback onOpenPlayer;
  final Future<void> Function() onTogglePlayPause;
  final Future<void> Function() onPrevious;
  final Future<void> Function() onNext;
  final Future<void> Function(Duration position) onSeek;
  final VoidCallback onOpenActions;
  final Widget? progressLayer;

  @override
  State<MiniPlayerView> createState() => _MiniPlayerViewState();
}

class _MiniPlayerViewState extends State<MiniPlayerView> {
  static const double _swipeActionThreshold = 72;
  static const double _verticalExpandThreshold = 36;

  double _horizontalDragDx = 0;
  double _swipeViewportWidth = 0;
  double _verticalDragDy = 0;
  Song? _pendingVisualSong;
  bool _settlingSwipe = false;
  bool _awaitingSongConfirmation = false;

  PlayerState get _playerState => widget.playerState;

  @override
  void didUpdateWidget(covariant MiniPlayerView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.playerState.currentSong?.id !=
        widget.playerState.currentSong?.id) {
      _pendingVisualSong = null;
      _horizontalDragDx = 0;
      _settlingSwipe = false;
      _awaitingSongConfirmation = false;
    }
  }

  void _togglePlayPause() {
    HapticFeedback.selectionClick();
    unawaited(widget.onTogglePlayPause());
  }

  void _handleSwipeDragStart(DragStartDetails details) {
    if (_awaitingSongConfirmation) return;
    setState(() {
      _horizontalDragDx = 0;
      _pendingVisualSong = null;
      _settlingSwipe = false;
    });
  }

  void _handleSwipeDragUpdate(DragUpdateDetails details) {
    if (_awaitingSongConfirmation) return;
    setState(() {
      _horizontalDragDx += details.primaryDelta ?? 0;
    });
  }

  void _handleSwipeDragEnd(DragEndDetails details) {
    if (_awaitingSongConfirmation) return;
    final shouldGoNext =
        _horizontalDragDx <= -_swipeActionThreshold && _playerState.hasNext;
    final shouldGoPrevious =
        _horizontalDragDx >= _swipeActionThreshold && _playerState.hasPrevious;

    if (shouldGoNext || shouldGoPrevious) {
      unawaited(_switchTrack(next: shouldGoNext));
      return;
    }

    setState(() => _horizontalDragDx = 0);
  }

  void _handleSwipeDragCancel() {
    if (_awaitingSongConfirmation) return;
    setState(() => _horizontalDragDx = 0);
  }

  Future<void> _switchTrack({required bool next}) async {
    if (_awaitingSongConfirmation) return;
    HapticFeedback.mediumImpact();
    final canPredictVisualTarget = !_playerState.shuffleEnabled;
    final targetSong = canPredictVisualTarget
        ? _adjacentSong(_playerState, next ? 1 : -1)
        : null;
    final targetOffset = next ? -_swipeViewportWidth : _swipeViewportWidth;
    final settleDuration = context.echoMotion.resolve(
      context,
      context.echoMotion.feedback,
    );

    setState(() {
      _awaitingSongConfirmation = true;
      _settlingSwipe = _swipeViewportWidth > 0;
      _horizontalDragDx = _settlingSwipe ? targetOffset : 0;
    });

    if (_settlingSwipe && settleDuration > Duration.zero) {
      await Future<void>.delayed(settleDuration);
      if (!mounted) return;
    }

    if (mounted && canPredictVisualTarget) {
      setState(() {
        _pendingVisualSong = targetSong;
        _horizontalDragDx = 0;
        _settlingSwipe = false;
      });
    } else if (mounted) {
      setState(() {
        _horizontalDragDx = 0;
        _settlingSwipe = false;
      });
    }

    try {
      if (next) {
        await widget.onNext();
      } else {
        await widget.onPrevious();
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _pendingVisualSong = null;
        _horizontalDragDx = 0;
        _settlingSwipe = false;
        _awaitingSongConfirmation = false;
      });
    }
  }

  void _handleVerticalDragStart(DragStartDetails details) {
    if (_awaitingSongConfirmation) return;
    _verticalDragDy = 0;
  }

  void _handleVerticalDragUpdate(DragUpdateDetails details) {
    if (_awaitingSongConfirmation) return;
    _verticalDragDy += details.primaryDelta ?? 0;
  }

  void _handleVerticalDragEnd(DragEndDetails details) {
    if (_awaitingSongConfirmation) {
      _verticalDragDy = 0;
      return;
    }
    final velocity = details.primaryVelocity ?? 0;
    final shouldExpand =
        velocity < -600 || _verticalDragDy <= -_verticalExpandThreshold;
    _verticalDragDy = 0;
    if (!shouldExpand) return;
    HapticFeedback.selectionClick();
    widget.onOpenPlayer();
  }

  Song? _adjacentSong(PlayerState state, int offset) {
    if (state.queue.isEmpty) return null;
    if (state.queue.length == 1) return state.queue.first;

    final queueLength = state.queue.length;
    final currentIndex = state.currentIndex;
    final normalizedCurrentIndex =
        currentIndex >= 0 && currentIndex < queueLength
        ? currentIndex
        : state.queue.indexWhere((song) => song.id == state.currentSong?.id);
    final safeCurrentIndex = normalizedCurrentIndex >= 0
        ? normalizedCurrentIndex
        : 0;
    final targetIndex = (safeCurrentIndex + offset + queueLength) % queueLength;
    return state.queue[targetIndex];
  }

  @override
  Widget build(BuildContext context) {
    final currentSong = _playerState.currentSong;
    if (currentSong == null) return const SizedBox.shrink();

    final song = _pendingVisualSong ?? currentSong;
    final previousSong = _playerState.shuffleEnabled
        ? null
        : _adjacentSong(_playerState, -1);
    final nextSong = _playerState.shuffleEnabled
        ? null
        : _adjacentSong(_playerState, 1);
    final visuals =
        widget.mediaVisuals ??
        EchoMediaVisuals.fallback(
          seed: widget.albumColor ?? EchoColors.contentTintFallback,
        );

    return EchoMediaColorScope(
      visuals: visuals,
      role: EchoMediaSurfaceRole.mini,
      child: Builder(
        builder: (context) {
          final textScale = MediaQuery.textScalerOf(context).scale(1);
          final showSubtitle = textScale <= 1.4;
          final semanticState = _awaitingSongConfirmation
              ? '正在切换曲目'
              : _playerState.isPlaying
              ? '正在播放'
              : '已暂停';
          final semanticSubtitle = song.artist?.trim().isNotEmpty == true
              ? '，${song.artist!.trim()}'
              : '';

          return Semantics(
            container: true,
            explicitChildNodes: true,
            label: '迷你播放器，${song.title}$semanticSubtitle',
            value: semanticState,
            onTap: _awaitingSongConfirmation ? null : widget.onOpenPlayer,
            customSemanticsActions: _awaitingSongConfirmation
                ? const <CustomSemanticsAction, VoidCallback>{}
                : <CustomSemanticsAction, VoidCallback>{
                    const CustomSemanticsAction(label: '上一首'): () {
                      if (_playerState.hasPrevious) {
                        unawaited(_switchTrack(next: false));
                      }
                    },
                    const CustomSemanticsAction(label: '下一首'): () {
                      if (_playerState.hasNext) {
                        unawaited(_switchTrack(next: true));
                      }
                    },
                  },
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              excludeFromSemantics: true,
              onVerticalDragStart: _awaitingSongConfirmation
                  ? null
                  : _handleVerticalDragStart,
              onVerticalDragUpdate: _awaitingSongConfirmation
                  ? null
                  : _handleVerticalDragUpdate,
              onVerticalDragEnd: _awaitingSongConfirmation
                  ? null
                  : _handleVerticalDragEnd,
              child: SizedBox(
                key: const Key('mini-player-surface'),
                height: MiniPlayer.height,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Hero(
                        tag: playerBackgroundHeroTag,
                        flightShuttleBuilder:
                            playerBackgroundFlightShuttleBuilder,
                        child: EchoPlayerBackdrop(
                          visuals: visuals,
                          mode: EchoPlayerBackdropMode.mini,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        context.echoSpacing.sm,
                        context.echoSpacing.xs,
                        context.echoSpacing.xs,
                        context.echoSpacing.xs,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              key: const Key('mini-player-track'),
                              behavior: HitTestBehavior.opaque,
                              onTap: _awaitingSongConfirmation
                                  ? null
                                  : widget.onOpenPlayer,
                              onDoubleTap: _togglePlayPause,
                              onHorizontalDragStart: _handleSwipeDragStart,
                              onHorizontalDragUpdate: _handleSwipeDragUpdate,
                              onHorizontalDragEnd: _handleSwipeDragEnd,
                              onHorizontalDragCancel: _handleSwipeDragCancel,
                              child: ClipRect(
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    final width = constraints.maxWidth;
                                    _swipeViewportWidth = width;
                                    final dragOffset = _horizontalDragDx.clamp(
                                      -width,
                                      width,
                                    );
                                    final translateX = -width + dragOffset;

                                    return OverflowBox(
                                      alignment: Alignment.centerLeft,
                                      minWidth: width * 3,
                                      maxWidth: width * 3,
                                      child: AnimatedContainer(
                                        width: width * 3,
                                        duration: _settlingSwipe
                                            ? context.echoMotion.resolve(
                                                context,
                                                context.echoMotion.feedback,
                                              )
                                            : Duration.zero,
                                        curve: context.echoMotion.easeOut,
                                        transform: Matrix4.translationValues(
                                          translateX,
                                          0,
                                          0,
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: width,
                                              child: previousSong == null
                                                  ? const SizedBox.shrink()
                                                  : _MiniPlayerTrack(
                                                      song: previousSong,
                                                      useHero: false,
                                                      showSubtitle:
                                                          showSubtitle,
                                                    ),
                                            ),
                                            SizedBox(
                                              width: width,
                                              child: _MiniPlayerTrack(
                                                song: song,
                                                useHero:
                                                    !_awaitingSongConfirmation,
                                                showSubtitle: showSubtitle,
                                              ),
                                            ),
                                            SizedBox(
                                              width: width,
                                              child: nextSong == null
                                                  ? const SizedBox.shrink()
                                                  : _MiniPlayerTrack(
                                                      song: nextSong,
                                                      useHero: false,
                                                      showSubtitle:
                                                          showSubtitle,
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          EchoIconButton(
                            icon: _playerState.isPlaying
                                ? AppIcons.pause
                                : AppIcons.play,
                            label: _playerState.isPlaying ? '暂停' : '播放',
                            foregroundColor: context.echoColors.ink,
                            backgroundColor: Colors.transparent,
                            onPressed: _togglePlayPause,
                          ),
                          EchoIconButton(
                            icon: AppIcons.more,
                            label: '更多播放操作',
                            foregroundColor: context.echoColors.ink,
                            backgroundColor: Colors.transparent,
                            onPressed: widget.onOpenActions,
                          ),
                        ],
                      ),
                    ),
                    Positioned.fill(
                      child: ClipRRect(
                        key: const Key('mini-player-surface-clip'),
                        borderRadius: context.echoRadii.surface,
                        child:
                            widget.progressLayer ??
                            _MiniPlayerProgressSurface(
                              position: _playerState.position,
                              duration: _playerState.duration,
                              onSeek: widget.onSeek,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ProviderMiniPlayerProgress extends ConsumerWidget {
  const _ProviderMiniPlayerProgress();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(
      playerProvider.select(
        (state) => (position: state.position, duration: state.duration),
      ),
    );
    return _MiniPlayerProgressSurface(
      position: progress.position,
      duration: progress.duration,
      onSeek: (target) => ref.read(playerProvider.notifier).seek(target),
    );
  }
}

class _MiniPlayerProgressSurface extends StatefulWidget {
  const _MiniPlayerProgressSurface({
    required this.position,
    required this.duration,
    required this.onSeek,
  });

  final Duration position;
  final Duration duration;
  final Future<void> Function(Duration target) onSeek;

  @override
  State<_MiniPlayerProgressSurface> createState() =>
      _MiniPlayerProgressSurfaceState();
}

class _MiniPlayerProgressSurfaceState
    extends State<_MiniPlayerProgressSurface> {
  double _scrubViewportWidth = 1;
  double? _scrubProgress;
  bool _scrubbing = false;

  void _handleProgressDragStart(DragStartDetails details) {
    if (widget.duration <= Duration.zero) return;
    setState(() {
      _scrubbing = true;
      _scrubProgress = _progressFromDx(details.localPosition.dx);
    });
  }

  void _handleProgressDragUpdate(DragUpdateDetails details) {
    if (!_scrubbing || widget.duration <= Duration.zero) return;
    setState(() {
      _scrubProgress = _progressFromDx(details.localPosition.dx);
    });
  }

  void _handleProgressDragEnd(DragEndDetails details) {
    final progress = _scrubProgress;
    final durationMs = widget.duration.inMilliseconds;
    if (_scrubbing && progress != null && durationMs > 0) {
      HapticFeedback.selectionClick();
      unawaited(
        widget.onSeek(Duration(milliseconds: (durationMs * progress).round())),
      );
    }
    setState(() {
      _scrubbing = false;
      _scrubProgress = null;
    });
  }

  void _handleProgressDragCancel() {
    if (!_scrubbing) return;
    setState(() {
      _scrubbing = false;
      _scrubProgress = null;
    });
  }

  double _progressFromDx(double dx) {
    return (dx / _scrubViewportWidth).clamp(0.0, 1.0);
  }

  void _seekRelative(Duration delta) {
    if (widget.duration <= Duration.zero) return;
    final targetMs = (widget.position + delta).inMilliseconds
        .clamp(0, widget.duration.inMilliseconds)
        .toInt();
    HapticFeedback.selectionClick();
    unawaited(widget.onSeek(Duration(milliseconds: targetMs)));
  }

  @override
  Widget build(BuildContext context) {
    final progress = widget.duration.inMilliseconds > 0
        ? widget.position.inMilliseconds / widget.duration.inMilliseconds
        : 0.0;
    final displayedProgress = (_scrubProgress ?? progress).clamp(0.0, 1.0);
    final displayedPosition = _scrubProgress == null
        ? widget.position
        : Duration(
            milliseconds: (widget.duration.inMilliseconds * displayedProgress)
                .round(),
          );
    final progressValue = _formatPlayerProgress(
      displayedPosition,
      widget.duration,
    );

    return Stack(
      children: <Widget>[
        PositionedDirectional(
          start: 0,
          end: 112,
          bottom: 0,
          height: 20,
          child: LayoutBuilder(
            builder: (context, constraints) {
              _scrubViewportWidth = constraints.maxWidth;
              return Semantics(
                label: '播放进度',
                value: progressValue,
                increasedValue: '快进 10 秒',
                decreasedValue: '后退 10 秒',
                onIncrease: () => _seekRelative(const Duration(seconds: 10)),
                onDecrease: () => _seekRelative(const Duration(seconds: -10)),
                child: GestureDetector(
                  key: const Key('mini-player-scrubber'),
                  behavior: HitTestBehavior.translucent,
                  excludeFromSemantics: true,
                  onHorizontalDragStart: _handleProgressDragStart,
                  onHorizontalDragUpdate: _handleProgressDragUpdate,
                  onHorizontalDragEnd: _handleProgressDragEnd,
                  onHorizontalDragCancel: _handleProgressDragCancel,
                ),
              );
            },
          ),
        ),
        PositionedDirectional(
          start: 0,
          end: 0,
          bottom: 0,
          child: IgnorePointer(
            child: ExcludeSemantics(
              child: EchoProgressBar(
                key: const Key('mini-player-progress'),
                value: displayedProgress,
                height: 3,
                color: context.echoColors.accent,
                trackColor: Colors.transparent,
              ),
            ),
          ),
        ),
        if (_scrubbing)
          PositionedDirectional(
            start: context.echoSpacing.sm,
            end: 112,
            bottom: 18,
            child: _MiniPlayerScrubBubble(
              progress: displayedProgress,
              duration: widget.duration,
            ),
          ),
      ],
    );
  }
}

String _formatPlayerProgress(Duration position, Duration duration) {
  return '${_formatPlayerDuration(position)} / ${_formatPlayerDuration(duration)}';
}

String _formatPlayerDuration(Duration duration) {
  final safe = duration.isNegative ? Duration.zero : duration;
  final minutes = safe.inMinutes;
  final seconds = safe.inSeconds % 60;
  return '$minutes:${seconds.toString().padLeft(2, '0')}';
}

class _MiniPlayerTrack extends StatelessWidget {
  const _MiniPlayerTrack({
    required this.song,
    required this.useHero,
    required this.showSubtitle,
  });

  final Song song;
  final bool useHero;
  final bool showSubtitle;

  @override
  Widget build(BuildContext context) {
    final artist = song.artist?.trim() ?? '';
    final album = song.album?.trim() ?? '';
    final subtitle = artist.isNotEmpty ? artist : album;
    final cover = _MiniPlayerCover(song: song);
    final title = _MiniPlayerTitle(song: song);
    final subtitleWidget = _MiniPlayerSubtitle(text: subtitle);

    return Row(
      children: <Widget>[
        if (useHero)
          Hero(
            tag: playerCoverHeroTag,
            createRectTween: playerCoverRectTween,
            child: cover,
          )
        else
          cover,
        SizedBox(width: context.echoSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (useHero)
                Hero(
                  tag: playerTitleHeroTag,
                  createRectTween: playerLinearRectTween,
                  flightShuttleBuilder: playerTextFlightShuttleBuilder,
                  child: title,
                )
              else
                title,
              if (showSubtitle && subtitle.isNotEmpty)
                if (useHero)
                  Hero(
                    tag: playerSubtitleHeroTag,
                    createRectTween: playerLinearRectTween,
                    flightShuttleBuilder: playerTextFlightShuttleBuilder,
                    child: subtitleWidget,
                  )
                else
                  subtitleWidget,
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
    return SizedBox.square(
      dimension: 48,
      child: ClipRRect(
        borderRadius: context.echoRadii.detail,
        child: CoverArtImage(
          coverArtId: song.artworkReference,
          size: 48,
          requestSize: 320,
          fit: BoxFit.cover,
          semanticLabel: '${song.title} 封面',
        ),
      ),
    );
  }
}

class _MiniPlayerTitle extends StatelessWidget {
  const _MiniPlayerTitle({required this.song});

  final Song song;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Text(
        song.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.echoTypography.title,
      ),
    );
  }
}

class _MiniPlayerSubtitle extends StatelessWidget {
  const _MiniPlayerSubtitle({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.echoTypography.metadata.copyWith(
          color: context.echoColors.muted,
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

    return Align(
      alignment: Alignment((progress * 2 - 1).clamp(-1.0, 1.0), 0),
      child: EchoSurface(
        level: EchoSurfaceLevel.floating,
        color: context.echoColors.ink,
        borderRadius: context.echoRadii.detail,
        padding: EdgeInsets.symmetric(
          horizontal: context.echoSpacing.xs,
          vertical: context.echoSpacing.xxs,
        ),
        child: Text(
          _formatPlayerDuration(position),
          style: context.echoTypography.metadata.copyWith(
            color: context.echoColors.canvas,
          ),
        ),
      ),
    );
  }
}
