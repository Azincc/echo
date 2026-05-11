import 'dart:async';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class AutoHidingAzListView extends StatefulWidget {
  const AutoHidingAzListView({
    super.key,
    required this.data,
    required this.itemCount,
    required this.itemBuilder,
    required this.indexBarData,
    this.itemPositionsListener,
    this.padding,
    this.physics,
  });

  final List<ISuspensionBean> data;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final List<String> indexBarData;
  final ItemPositionsListener? itemPositionsListener;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;

  @override
  State<AutoHidingAzListView> createState() => _AutoHidingAzListViewState();
}

class _AutoHidingAzListViewState extends State<AutoHidingAzListView> {
  Timer? _indexBarHideTimer;
  bool _showIndexBar = false;
  bool _isIndexBarPointerActive = false;

  @override
  void dispose() {
    _indexBarHideTimer?.cancel();
    super.dispose();
  }

  void _showIndexBarTemporarily() {
    if (!mounted) return;

    _indexBarHideTimer?.cancel();
    if (!_showIndexBar) {
      setState(() {
        _showIndexBar = true;
      });
    }

    if (_isIndexBarPointerActive) return;
    _indexBarHideTimer = Timer(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      setState(() {
        _showIndexBar = false;
      });
    });
  }

  void _handleIndexBarPointerDown(PointerDownEvent event, double width) {
    if (event.localPosition.dx < width - 36) return;

    _indexBarHideTimer?.cancel();
    _isIndexBarPointerActive = true;
    if (!_showIndexBar) {
      setState(() {
        _showIndexBar = true;
      });
    }
  }

  void _handleIndexBarPointerEnd() {
    if (!_isIndexBarPointerActive) return;
    _isIndexBarPointerActive = false;
    _showIndexBarTemporarily();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Listener(
          onPointerDown: (event) =>
              _handleIndexBarPointerDown(event, constraints.maxWidth),
          onPointerUp: (_) => _handleIndexBarPointerEnd(),
          onPointerCancel: (_) => _handleIndexBarPointerEnd(),
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollStartNotification ||
                  notification is ScrollUpdateNotification ||
                  notification is UserScrollNotification) {
                _showIndexBarTemporarily();
              }
              return false;
            },
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(end: _showIndexBar ? 1.0 : 0.0),
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutCubic,
              builder: (context, opacity, child) {
                final isVisible = opacity > 0.01;
                return AzListView(
                  data: widget.data,
                  itemCount: widget.itemCount,
                  itemBuilder: widget.itemBuilder,
                  itemPositionsListener: widget.itemPositionsListener,
                  padding: widget.padding,
                  physics: widget.physics,
                  indexBarData: widget.indexBarData,
                  indexBarWidth: isVisible ? 22 : 0,
                  indexBarHeight: isVisible ? null : 0,
                  indexBarMargin: EdgeInsets.only(right: isVisible ? 4 : 0),
                  indexBarOptions: IndexBarOptions(
                    needRebuild: true,
                    ignoreDragCancel: true,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.58 * opacity),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    downDecoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.72 * opacity),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    textStyle: TextStyle(
                      fontSize: 11,
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withValues(alpha: opacity),
                    ),
                    downTextStyle: TextStyle(
                      fontSize: 11,
                      height: 1,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withValues(alpha: opacity),
                    ),
                    downItemDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.24 * opacity),
                    ),
                    indexHintWidth: 120 / 2,
                    indexHintHeight: 100 / 2,
                    indexHintDecoration: BoxDecoration(
                      image: null,
                      color: Colors.black.withValues(alpha: 0.78),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    indexHintAlignment: Alignment.centerRight,
                    indexHintChildAlignment: const Alignment(-0.25, 0.0),
                    indexHintOffset: const Offset(-20, 0),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
