import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:echoes/providers/player_provider.dart';
import 'package:echoes/data/models/structured_lyrics.dart';

class SyncedLyricsView extends ConsumerStatefulWidget {
  final StructuredLyrics lyrics;

  const SyncedLyricsView({super.key, required this.lyrics});

  @override
  ConsumerState<SyncedLyricsView> createState() => _SyncedLyricsViewState();
}

class _SyncedLyricsViewState extends ConsumerState<SyncedLyricsView> {
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

    // 使用 scrollable_positioned_list 直接滚动到指定索引并居中
    try {
      _itemScrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.5, // 0.5 表示居中
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

  @override
  Widget build(BuildContext context) {
    // 只监听播放位置，不监听整个 PlayerState
    final position = ref.watch(playerProvider.select((s) => s.position));
    final currentMs = position.inMilliseconds;

    final lines = widget.lyrics.lines;
    final offsetMs = widget.lyrics.offsetMs;

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

    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        if (notification.direction != ScrollDirection.idle) {
          _isUserScrolling = true;
          _userScrollTimer?.cancel();
        } else {
          // 用户停止滚动后 3 秒恢复自动滚动
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
              child: Text(
                line.value,
                style: TextStyle(
                  fontSize: isCurrent ? 20 : 16,
                  fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                  color: isCurrent
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.5),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    );
  }
}
