import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:echoes/providers/player_provider.dart';
import 'package:echoes/data/models/structured_lyrics.dart';

class _LyricsRenderParts {
  final String primary;
  final String? secondary;

  const _LyricsRenderParts(this.primary, [this.secondary]);
}

class SyncedLyricsView extends ConsumerStatefulWidget {
  final StructuredLyrics lyrics;
  final Color? activePrimaryColor;
  final Color? activeSecondaryColor;
  final Color? inactivePrimaryColor;
  final Color? inactiveSecondaryColor;

  const SyncedLyricsView({
    super.key,
    required this.lyrics,
    this.activePrimaryColor,
    this.activeSecondaryColor,
    this.inactivePrimaryColor,
    this.inactiveSecondaryColor,
  });

  @override
  ConsumerState<SyncedLyricsView> createState() => _SyncedLyricsViewState();
}

class _SyncedLyricsViewState extends ConsumerState<SyncedLyricsView> {
  static final RegExp _cjkRegExp = RegExp(r'[\u4e00-\u9fff]');
  static final RegExp _latinRegExp = RegExp(r'[A-Za-z]');
  static final RegExp _enZhBoundary = RegExp(
    r'^(.*?[A-Za-z0-9][^\u4e00-\u9fff]*?)\s+([\u4e00-\u9fff].*)$',
  );
  static final RegExp _zhEnBoundary = RegExp(
    r'^([\u4e00-\u9fff].*?)\s+([A-Za-z].*)$',
  );

  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();
  int _currentIndex = -1;
  bool _isUserScrolling = false;
  Timer? _userScrollTimer;

  @override
  void didUpdateWidget(covariant SyncedLyricsView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 歌词数据变化时重置状态
    if (oldWidget.lyrics != widget.lyrics) {
      _currentIndex = -1;
      _isUserScrolling = false;
      _userScrollTimer?.cancel();
      // 尝试重置滚动位置，忽略未挂载错误
      try {
        _itemScrollController.jumpTo(index: 0);
      } catch (_) {}
    }
  }

  @override
  void dispose() {
    _userScrollTimer?.cancel();
    super.dispose();
  }

  void _scrollToLine(int index) {
    if (_isUserScrolling) return;
    if (!widget.lyrics.synced) return;
    if (index < 0 || index >= widget.lyrics.lines.length) return;

    final renderParts = _splitBilingualLine(widget.lyrics.lines[index].value);
    final hasSecondary =
        renderParts.secondary != null && renderParts.secondary!.isNotEmpty;
    // scrollable_positioned_list 的 alignment 作用在“条目顶部”。
    // 双行歌词需要把条目顶部再往上提一点，才能让第二行进入视觉焦点区。
    final alignment = hasSecondary ? 0.44 : 0.47;

    // 使用 scrollable_positioned_list 直接滚动到指定索引
    try {
      _itemScrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: alignment,
      );
    } catch (e) {
      // 忽略控制器未挂载等错误
    }
  }

  int _findCurrentLineIndex(int currentMs) {
    final lines = widget.lyrics.lines;
    final offsetMs = widget.lyrics.offsetMs;

    if (!widget.lyrics.synced || lines.isEmpty) return 0;

    int result = 0;
    for (int i = 0; i < lines.length; i++) {
      final lineStart = (lines[i].startMs ?? 0) + offsetMs;
      if (currentMs >= lineStart) {
        result = i;
      } else {
        break;
      }
    }
    return result;
  }

  _LyricsRenderParts _splitBilingualLine(String raw) {
    final text = raw.trim();
    if (text.isEmpty) return const _LyricsRenderParts('');

    final hasCjk = _cjkRegExp.hasMatch(text);
    final hasLatin = _latinRegExp.hasMatch(text);
    if (!hasCjk || !hasLatin) {
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
    // 只监听播放位置，不监听整个 PlayerState
    final position = ref.watch(playerProvider.select((s) => s.position));
    final currentMs = position.inMilliseconds;

    final lines = widget.lyrics.lines;
    final offsetMs = widget.lyrics.offsetMs;
    final colorScheme = Theme.of(context).colorScheme;
    final onSurface = colorScheme.onSurface;
    final activePrimaryColor = widget.activePrimaryColor ?? colorScheme.primary;
    final activeSecondaryColor =
        widget.activeSecondaryColor ??
        colorScheme.primary.withValues(alpha: 0.75);
    final inactivePrimaryColor =
        widget.inactivePrimaryColor ?? onSurface.withValues(alpha: 0.5);
    final inactiveSecondaryColor =
        widget.inactiveSecondaryColor ?? onSurface.withValues(alpha: 0.38);

    // 计算当前歌词行
    final newIndex = _findCurrentLineIndex(currentMs);

    // 索引变化时触发滚动 + setState 以更新高亮
    if (newIndex != _currentIndex) {
      _currentIndex = newIndex;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _scrollToLine(newIndex);
          setState(() {});
        }
      });
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final isUserDragStart =
            notification is ScrollStartNotification &&
            notification.dragDetails != null;
        final isUserDragUpdate =
            notification is ScrollUpdateNotification &&
            notification.dragDetails != null;
        final isScrollEnd = notification is ScrollEndNotification;

        if (isUserDragStart || isUserDragUpdate) {
          _isUserScrolling = true;
          _userScrollTimer?.cancel();
        } else if (isScrollEnd && _isUserScrolling) {
          // 用户停止滚动后 3 秒恢复自动滚动
          _userScrollTimer?.cancel();
          _userScrollTimer = Timer(const Duration(seconds: 3), () {
            if (mounted) {
              setState(() {
                _isUserScrolling = false;
              });
              _scrollToLine(_currentIndex);
            }
          });
        }
        return false;
      },
      child: ScrollablePositionedList.builder(
        itemScrollController: _itemScrollController,
        itemPositionsListener: _itemPositionsListener,
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
        itemCount: lines.length,
        itemBuilder: (context, index) {
          final line = lines[index];
          final isCurrent = widget.lyrics.synced && index == _currentIndex;
          final renderParts = _splitBilingualLine(line.value);
          final secondary = renderParts.secondary;

          return GestureDetector(
            onTap: () {
              if (widget.lyrics.synced && line.startMs != null) {
                ref
                    .read(playerProvider.notifier)
                    .seek(Duration(milliseconds: line.startMs! + offsetMs));
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  Text(
                    renderParts.primary,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: isCurrent
                          ? activePrimaryColor
                          : inactivePrimaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (secondary != null && secondary.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      secondary,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
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
        },
      ),
    );
  }
}
