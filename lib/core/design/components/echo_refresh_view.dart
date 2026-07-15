import 'package:flutter/material.dart';

import '../../theme/app_icons.dart';
import '../echo_context.dart';

class EchoRefreshView extends StatefulWidget {
  const EchoRefreshView({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  final RefreshCallback onRefresh;
  final Widget child;

  @override
  State<EchoRefreshView> createState() => _EchoRefreshViewState();
}

class _EchoRefreshViewState extends State<EchoRefreshView> {
  bool _refreshing = false;

  Future<void> _performRefresh() async {
    if (_refreshing) return;
    setState(() => _refreshing = true);
    try {
      await widget.onRefresh();
    } finally {
      if (mounted) setState(() => _refreshing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final motion = context.echoMotion;
    final colors = context.echoColors;

    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: RefreshIndicator.noSpinner(
            onRefresh: _performRefresh,
            elevation: 0,
            semanticsLabel: '下拉刷新',
            child: widget.child,
          ),
        ),
        PositionedDirectional(
          top: context.echoSpacing.sm,
          start: 0,
          end: 0,
          child: IgnorePointer(
            child: Semantics(
              hidden: !_refreshing,
              liveRegion: _refreshing,
              label: _refreshing ? '正在刷新' : null,
              child: AnimatedOpacity(
                duration: motion.resolve(context, motion.feedback),
                curve: motion.easeOut,
                opacity: _refreshing ? 1 : 0,
                child: Center(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: context.echoRadii.pill,
                      border: Border.all(color: colors.controlBoundary),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.echoSpacing.sm,
                        vertical: context.echoSpacing.xs,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            AppIcons.refresh,
                            size: 18,
                            color: colors.accent,
                          ),
                          SizedBox(width: context.echoSpacing.xs),
                          Text('正在刷新', style: context.echoTypography.label),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
