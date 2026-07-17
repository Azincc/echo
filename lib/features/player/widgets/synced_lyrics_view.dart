import 'dart:async';
import 'dart:ui' show ImageFilter, TileMode;

import 'package:flutter/foundation.dart' show ValueListenable;
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
  static final RegExp _visibleLyricsCharacter = RegExp(
    r'[^\s\u0000-\u001F\u007F-\u009F\u00AD\u034F\u061C\u180E'
    r'\u200B-\u200F\u2028-\u202F\u2060-\u206F\uFE00-\uFE0F\uFEFF]',
    unicode: true,
  );

  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();
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
            context.echoMotion.state,
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

  bool _hasVisibleLyricsCharacters(String value) {
    return _visibleLyricsCharacter.hasMatch(value);
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
    final stateDuration = context.echoMotion.resolve(
      context,
      context.echoMotion.state,
    );
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
          itemPositionsListener: _itemPositionsListener,
          initialScrollIndex: initialIndex,
          initialAlignment: _alignmentForIndex(initialIndex),
          padding: EdgeInsets.symmetric(
            vertical: context.echoSpacing.xxl * 2,
            horizontal: context.echoSpacing.md,
          ),
          itemCount: lines.length,
          itemBuilder: (context, index) {
            final line = lines[index];
            final isCurrent = widget.lyrics.synced && index == newIndex;
            final parts = _splitBilingualLine(line.value);
            final secondary = parts.secondary;
            final hasVisibleLyrics = _hasVisibleLyricsCharacters(line.value);
            final canSeek = widget.lyrics.synced && line.startMs != null;
            final target = Duration(
              milliseconds: ((line.startMs ?? 0) + widget.lyrics.offsetMs)
                  .clamp(0, 1 << 53)
                  .toInt(),
            );
            final timeLabel = _formatDuration(target);
            final semanticLabel = <String>[
              if (isCurrent && hasVisibleLyrics) '当前歌词',
              if (_hasVisibleLyricsCharacters(parts.primary)) parts.primary,
              if (secondary != null && _hasVisibleLyricsCharacters(secondary))
                secondary,
              if (canSeek) '跳转到 $timeLabel',
            ].join('，');
            final lineContent = _SyncedLyricLineContent(
              key: ValueKey<String>('lyrics-line-$index'),
              index: index,
              primary: parts.primary,
              secondary: secondary,
              isCurrent: isCurrent,
              showIndicator: isCurrent && hasVisibleLyrics,
              itemPositions: _itemPositionsListener.itemPositions,
              itemCount: lines.length,
              duration: stateDuration,
              activePrimaryColor: activePrimaryColor,
              activeSecondaryColor: activeSecondaryColor,
              inactivePrimaryColor: inactivePrimaryColor,
              inactiveSecondaryColor: inactiveSecondaryColor,
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

class _LyricsTextEdgeEffect extends StatelessWidget {
  const _LyricsTextEdgeEffect({
    required this.index,
    required this.itemCount,
    required this.itemPositions,
    required this.child,
  });

  static const double _edgeExtent = 0.15;
  static const double _maximumSigma = 2.4;
  static const double _terminalOpacity = 0;

  final int index;
  final int itemCount;
  final ValueListenable<Iterable<ItemPosition>> itemPositions;
  final Widget child;

  double _resolveStrength(Iterable<ItemPosition> positions) {
    ItemPosition? current;
    ItemPosition? first;
    ItemPosition? last;

    for (final position in positions) {
      final visible =
          position.itemTrailingEdge > 0 && position.itemLeadingEdge < 1;
      if (!visible) continue;
      if (position.index == index) current = position;
      if (first == null || position.index < first.index) first = position;
      if (last == null || position.index > last.index) last = position;
    }

    if (current == null || first == null || last == null || itemCount <= 1) {
      return 0;
    }

    final hasContentAbove = first.index > 0 || first.itemLeadingEdge < -0.001;
    final hasContentBelow =
        last.index < itemCount - 1 || last.itemTrailingEdge > 1.001;
    final center = (current.itemLeadingEdge + current.itemTrailingEdge) / 2;
    var topStrength = 0.0;
    var bottomStrength = 0.0;

    if (hasContentAbove && center < _edgeExtent) {
      topStrength = ((_edgeExtent - center) / _edgeExtent).clamp(0.0, 1.0);
    }
    if (hasContentBelow && center > 1 - _edgeExtent) {
      bottomStrength = ((center - (1 - _edgeExtent)) / _edgeExtent).clamp(
        0.0,
        1.0,
      );
    }

    final strength = topStrength > bottomStrength
        ? topStrength
        : bottomStrength;
    return strength * strength * strength;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Iterable<ItemPosition>>(
      valueListenable: itemPositions,
      child: child,
      builder: (context, positions, child) {
        final strength = _resolveStrength(positions);
        final opacity = 1 - (1 - _terminalOpacity) * strength;
        final content = child!;
        return Opacity(
          key: ValueKey<String>('lyrics-text-softening-$index'),
          opacity: opacity,
          child: ImageFiltered(
            key: ValueKey<String>('lyrics-text-filter-$index'),
            enabled: strength > 0.001,
            imageFilter: ImageFilter.blur(
              sigmaX: _maximumSigma * strength,
              sigmaY: _maximumSigma * strength,
              tileMode: TileMode.decal,
            ),
            child: content,
          ),
        );
      },
    );
  }
}

class _SyncedLyricLineContent extends StatelessWidget {
  const _SyncedLyricLineContent({
    super.key,
    required this.index,
    required this.primary,
    required this.secondary,
    required this.isCurrent,
    required this.showIndicator,
    required this.itemPositions,
    required this.itemCount,
    required this.duration,
    required this.activePrimaryColor,
    required this.activeSecondaryColor,
    required this.inactivePrimaryColor,
    required this.inactiveSecondaryColor,
  });

  final int index;
  final String primary;
  final String? secondary;
  final bool isCurrent;
  final bool showIndicator;
  final ValueListenable<Iterable<ItemPosition>> itemPositions;
  final int itemCount;
  final Duration duration;
  final Color activePrimaryColor;
  final Color activeSecondaryColor;
  final Color inactivePrimaryColor;
  final Color inactiveSecondaryColor;

  @override
  Widget build(BuildContext context) {
    final typography = context.echoTypography;
    final primaryStyle = (isCurrent ? typography.headline : typography.title)
        .copyWith(
          fontSize: isCurrent ? 22 : 17,
          fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
          height: isCurrent ? 1.20 : 1.30,
          color: isCurrent ? activePrimaryColor : inactivePrimaryColor,
        );
    final secondaryStyle = (isCurrent ? typography.body : typography.metadata)
        .copyWith(
          fontSize: isCurrent ? 15 : 13,
          fontWeight: isCurrent ? FontWeight.w500 : FontWeight.w400,
          height: 1.35,
          color: isCurrent ? activeSecondaryColor : inactiveSecondaryColor,
        );

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: context.echoInteraction.minimumTouchTarget,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.echoSpacing.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: ExcludeSemantics(
                child: SizedBox(
                  width: 3,
                  height: 28,
                  child: AnimatedOpacity(
                    key: ValueKey<String>('lyrics-line-marker-$index'),
                    duration: duration,
                    curve: context.echoMotion.easeOut,
                    opacity: showIndicator ? 1 : 0,
                    child: AnimatedScale(
                      duration: duration,
                      curve: context.echoMotion.easeOut,
                      scale: showIndicator ? 1 : 0.72,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: activePrimaryColor,
                          borderRadius: context.echoRadii.pill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: context.echoSpacing.sm),
            Expanded(
              child: _LyricsTextEdgeEffect(
                index: index,
                itemCount: itemCount,
                itemPositions: itemPositions,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AnimatedDefaultTextStyle(
                      key: ValueKey<String>('lyrics-primary-style-$index'),
                      duration: duration,
                      curve: context.echoMotion.easeOut,
                      style: primaryStyle,
                      child: Text(
                        primary,
                        key: ValueKey<String>('lyrics-primary-$index'),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    if (secondary?.isNotEmpty == true) ...<Widget>[
                      SizedBox(height: context.echoSpacing.xxs),
                      AnimatedDefaultTextStyle(
                        key: ValueKey<String>('lyrics-secondary-style-$index'),
                        duration: duration,
                        curve: context.echoMotion.easeOut,
                        style: secondaryStyle,
                        child: Text(
                          secondary!,
                          key: ValueKey<String>('lyrics-secondary-$index'),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
