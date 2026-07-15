import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../core/design/echo_design.dart';
import '../../../data/models/structured_lyrics.dart';
import '../../../providers/player_provider.dart';

class _LyricsRenderParts {
  const _LyricsRenderParts(this.primary, [this.secondary]);

  final String primary;
  final String? secondary;
}

class SyncedLyricsView extends ConsumerWidget {
  const SyncedLyricsView({
    super.key,
    required this.lyrics,
    this.activePrimaryColor,
    this.activeSecondaryColor,
    this.inactivePrimaryColor,
    this.inactiveSecondaryColor,
  });

  final StructuredLyrics lyrics;
  final Color? activePrimaryColor;
  final Color? activeSecondaryColor;
  final Color? inactivePrimaryColor;
  final Color? inactiveSecondaryColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(
      playerProvider.select((state) => state.position),
    );
    return SyncedLyricsSurface(
      lyrics: lyrics,
      position: position,
      activePrimaryColor: activePrimaryColor,
      activeSecondaryColor: activeSecondaryColor,
      inactivePrimaryColor: inactivePrimaryColor,
      inactiveSecondaryColor: inactiveSecondaryColor,
      onSeek: (target) => ref.read(playerProvider.notifier).seek(target),
    );
  }
}

/// Provider-free lyric surface for deterministic position and motion tests.
@visibleForTesting
class SyncedLyricsSurface extends StatefulWidget {
  const SyncedLyricsSurface({
    super.key,
    required this.lyrics,
    required this.position,
    required this.onSeek,
    this.activePrimaryColor,
    this.activeSecondaryColor,
    this.inactivePrimaryColor,
    this.inactiveSecondaryColor,
  });

  final StructuredLyrics lyrics;
  final Duration position;
  final Future<void> Function(Duration target) onSeek;
  final Color? activePrimaryColor;
  final Color? activeSecondaryColor;
  final Color? inactivePrimaryColor;
  final Color? inactiveSecondaryColor;

  @override
  State<SyncedLyricsSurface> createState() => _SyncedLyricsSurfaceState();
}

class _SyncedLyricsSurfaceState extends State<SyncedLyricsSurface> {
  static final RegExp _cjkRegExp = RegExp(r'[\u4e00-\u9fff]');
  static final RegExp _latinRegExp = RegExp(r'[A-Za-z]');
  static final RegExp _enZhBoundary = RegExp(
    r'^(.*?[A-Za-z0-9][^\u4e00-\u9fff]*?)\s+([\u4e00-\u9fff].*)$',
  );
  static final RegExp _zhEnBoundary = RegExp(
    r'^([\u4e00-\u9fff].*?)\s+([A-Za-z].*)$',
  );

  final ItemScrollController _itemScrollController = ItemScrollController();
  int _currentIndex = -1;
  bool _hasInitialAutoPositioned = false;
  bool _isUserScrolling = false;
  Timer? _userScrollTimer;

  @override
  void didUpdateWidget(covariant SyncedLyricsSurface oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.lyrics != widget.lyrics) {
      _currentIndex = -1;
      _hasInitialAutoPositioned = false;
      _isUserScrolling = false;
      _userScrollTimer?.cancel();
    }
  }

  @override
  void dispose() {
    _userScrollTimer?.cancel();
    super.dispose();
  }

  double _alignmentForIndex(int index) {
    if (index < 0 || index >= widget.lyrics.lines.length) return 0.47;
    final parts = _splitBilingualLine(widget.lyrics.lines[index].value);
    return parts.secondary?.isNotEmpty == true ? 0.44 : 0.47;
  }

  void _scrollToLine(int index, {bool animated = true}) {
    if (_isUserScrolling || !widget.lyrics.synced) return;
    if (index < 0 || index >= widget.lyrics.lines.length) return;

    final reduceMotion = context.echoReduceMotion;
    try {
      if (animated && !reduceMotion) {
        _itemScrollController.scrollTo(
          index: index,
          duration: context.echoMotion.resolve(
            context,
            context.echoMotion.scene,
          ),
          curve: context.echoMotion.easeOut,
          alignment: _alignmentForIndex(index),
        );
      } else {
        _itemScrollController.jumpTo(
          index: index,
          alignment: _alignmentForIndex(index),
        );
      }
    } catch (_) {
      // The list may be between attachment frames while lyrics are replaced.
    }
  }

  int _findCurrentLineIndex(int currentMs) {
    final lines = widget.lyrics.lines;
    if (!widget.lyrics.synced || lines.isEmpty) return 0;

    final offset = widget.lyrics.offsetMs;
    var low = 0;
    var high = lines.length - 1;
    var result = 0;
    while (low <= high) {
      final middle = (low + high) >> 1;
      final start = (lines[middle].startMs ?? 0) + offset;
      if (currentMs >= start) {
        result = middle;
        low = middle + 1;
      } else {
        high = middle - 1;
      }
    }
    return result;
  }

  _LyricsRenderParts _splitBilingualLine(String raw) {
    final text = raw.trim();
    if (text.isEmpty) return const _LyricsRenderParts('');
    if (!_cjkRegExp.hasMatch(text) || !_latinRegExp.hasMatch(text)) {
      return _LyricsRenderParts(text);
    }

    final enZh = _enZhBoundary.firstMatch(text);
    if (enZh != null) {
      final first = enZh.group(1)?.trim() ?? '';
      final second = enZh.group(2)?.trim() ?? '';
      if (first.isNotEmpty && second.isNotEmpty) {
        return _LyricsRenderParts(first, second);
      }
    }

    final zhEn = _zhEnBoundary.firstMatch(text);
    if (zhEn != null) {
      final first = zhEn.group(1)?.trim() ?? '';
      final second = zhEn.group(2)?.trim() ?? '';
      if (first.isNotEmpty && second.isNotEmpty) {
        return _LyricsRenderParts(first, second);
      }
    }
    return _LyricsRenderParts(text);
  }

  @override
  Widget build(BuildContext context) {
    final lines = widget.lyrics.lines;
    if (lines.isEmpty) return const SizedBox.shrink();

    final colors = context.echoColors;
    final activePrimaryColor = widget.activePrimaryColor ?? colors.accent;
    final activeSecondaryColor =
        widget.activeSecondaryColor ?? activePrimaryColor;
    final inactivePrimaryColor = widget.inactivePrimaryColor ?? colors.muted;
    final inactiveSecondaryColor =
        widget.inactiveSecondaryColor ?? colors.muted;
    final newIndex = _findCurrentLineIndex(widget.position.inMilliseconds);
    final initialIndex = newIndex.clamp(0, lines.length - 1).toInt();

    if (newIndex != _currentIndex) {
      final shouldAnimate = _hasInitialAutoPositioned;
      _currentIndex = newIndex;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _scrollToLine(newIndex, animated: shouldAnimate);
        _hasInitialAutoPositioned = true;
      });
    }

    return Semantics(
      container: true,
      label: widget.lyrics.synced ? '同步歌词' : '歌词',
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          final userStarted =
              notification is ScrollStartNotification &&
              notification.dragDetails != null;
          final userUpdated =
              notification is ScrollUpdateNotification &&
              notification.dragDetails != null;
          if (userStarted || userUpdated) {
            _isUserScrolling = true;
            _userScrollTimer?.cancel();
          } else if (notification is ScrollEndNotification &&
              _isUserScrolling) {
            _userScrollTimer?.cancel();
            _userScrollTimer = Timer(const Duration(seconds: 3), () {
              if (!mounted) return;
              _isUserScrolling = false;
              _scrollToLine(_currentIndex);
            });
          }
          return false;
        },
        child: ScrollablePositionedList.builder(
          itemScrollController: _itemScrollController,
          initialScrollIndex: initialIndex,
          initialAlignment: _alignmentForIndex(initialIndex),
          padding: EdgeInsets.symmetric(
            vertical: context.echoSpacing.xxl * 2,
            horizontal: context.echoSpacing.lg,
          ),
          itemCount: lines.length,
          itemBuilder: (context, index) {
            final line = lines[index];
            final isCurrent = widget.lyrics.synced && index == newIndex;
            final parts = _splitBilingualLine(line.value);
            final secondary = parts.secondary;
            final canSeek = widget.lyrics.synced && line.startMs != null;
            final target = Duration(
              milliseconds: ((line.startMs ?? 0) + widget.lyrics.offsetMs)
                  .clamp(0, 1 << 53)
                  .toInt(),
            );
            final timeLabel = _formatDuration(target);
            final semanticLabel = <String>[
              if (isCurrent) '当前歌词',
              parts.primary,
              if (secondary?.isNotEmpty == true) secondary!,
              if (canSeek) '跳转到 $timeLabel',
            ].join('，');
            final lineContent = ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: context.echoInteraction.minimumTouchTarget,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: context.echoSpacing.xs),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      parts.primary,
                      style: context.echoTypography.title.copyWith(
                        fontSize: 16,
                        fontWeight: isCurrent
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: isCurrent
                            ? activePrimaryColor
                            : inactivePrimaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (secondary?.isNotEmpty == true) ...<Widget>[
                      SizedBox(height: context.echoSpacing.xxs),
                      Text(
                        secondary!,
                        style: context.echoTypography.metadata.copyWith(
                          color: isCurrent
                              ? activeSecondaryColor
                              : inactiveSecondaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
            );

            if (!canSeek) {
              return Semantics(
                container: true,
                selected: isCurrent,
                label: semanticLabel,
                child: ExcludeSemantics(child: lineContent),
              );
            }
            return EchoPressable(
              semanticLabel: semanticLabel,
              selected: isCurrent,
              onPressed: () {
                HapticFeedback.selectionClick();
                unawaited(widget.onSeek(target));
              },
              minimumSize: Size(
                double.infinity,
                context.echoInteraction.minimumTouchTarget,
              ),
              child: lineContent,
            );
          },
        ),
      ),
    );
  }

  static String _formatDuration(Duration duration) {
    final safe = duration.isNegative ? Duration.zero : duration;
    final minutes = safe.inMinutes;
    final seconds = safe.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
