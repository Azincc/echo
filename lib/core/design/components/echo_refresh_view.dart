import 'dart:async';

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
  RefreshIndicatorStatus? _status;
  Timer? _completionTimer;

  void _handleStatusChange(RefreshIndicatorStatus? status) {
    if (!mounted) return;
    _completionTimer?.cancel();
    final nextStatus = status == RefreshIndicatorStatus.canceled
        ? null
        : status;
    if (_status != nextStatus) {
      setState(() => _status = nextStatus);
    }
    if (nextStatus == RefreshIndicatorStatus.done) {
      _completionTimer = Timer(
        context.echoMotion.scene + context.echoMotion.feedback,
        () {
          if (mounted && _status == RefreshIndicatorStatus.done) {
            setState(() => _status = null);
          }
        },
      );
    }
  }

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
  void dispose() {
    _completionTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final motion = context.echoMotion;
    final colors = context.echoColors;
    final feedback = _RefreshFeedback.from(
      status: _status,
      refreshing: _refreshing,
    );
    final visible = feedback != null;

    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: RefreshIndicator.noSpinner(
            onRefresh: _performRefresh,
            onStatusChange: _handleStatusChange,
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
              hidden: !visible,
              liveRegion: feedback?.announce ?? false,
              label: feedback?.label,
              child: AnimatedSlide(
                duration: motion.resolve(context, motion.feedback),
                curve: motion.easeOut,
                offset: visible ? Offset.zero : const Offset(0, -0.35),
                child: AnimatedOpacity(
                  duration: motion.resolve(context, motion.feedback),
                  curve: motion.easeOut,
                  opacity: visible ? 1 : 0,
                  child: Center(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: feedback?.emphasized == true
                            ? Color.alphaBlend(
                                colors.accent.withValues(alpha: 0.12),
                                colors.surface,
                              )
                            : colors.surface,
                        borderRadius: context.echoRadii.pill,
                        border: Border.all(
                          color: feedback?.emphasized == true
                              ? colors.accent
                              : colors.controlBoundary,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.echoSpacing.sm,
                          vertical: context.echoSpacing.xs,
                        ),
                        child: ExcludeSemantics(
                          child: feedback == null
                              ? const SizedBox.shrink()
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    _RefreshFeedbackIcon(feedback: feedback),
                                    SizedBox(width: context.echoSpacing.xs),
                                    Text(
                                      feedback.label,
                                      style: context.echoTypography.label
                                          .copyWith(color: colors.ink),
                                    ),
                                  ],
                                ),
                        ),
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

enum _RefreshFeedbackKind { pull, release, refreshing, done }

class _RefreshFeedback {
  const _RefreshFeedback({
    required this.kind,
    required this.label,
    required this.announce,
    required this.emphasized,
  });

  final _RefreshFeedbackKind kind;
  final String label;
  final bool announce;
  final bool emphasized;

  static _RefreshFeedback? from({
    required RefreshIndicatorStatus? status,
    required bool refreshing,
  }) {
    if (refreshing || status == RefreshIndicatorStatus.snap) {
      return const _RefreshFeedback(
        kind: _RefreshFeedbackKind.refreshing,
        label: '正在刷新',
        announce: true,
        emphasized: true,
      );
    }

    return switch (status) {
      RefreshIndicatorStatus.drag => const _RefreshFeedback(
        kind: _RefreshFeedbackKind.pull,
        label: '下拉刷新',
        announce: false,
        emphasized: false,
      ),
      RefreshIndicatorStatus.armed => const _RefreshFeedback(
        kind: _RefreshFeedbackKind.release,
        label: '松开刷新',
        announce: true,
        emphasized: true,
      ),
      RefreshIndicatorStatus.done => const _RefreshFeedback(
        kind: _RefreshFeedbackKind.done,
        label: '刷新完成',
        announce: true,
        emphasized: true,
      ),
      RefreshIndicatorStatus.snap ||
      RefreshIndicatorStatus.refresh => const _RefreshFeedback(
        kind: _RefreshFeedbackKind.refreshing,
        label: '正在刷新',
        announce: true,
        emphasized: true,
      ),
      RefreshIndicatorStatus.canceled || null => null,
    };
  }
}

class _RefreshFeedbackIcon extends StatelessWidget {
  const _RefreshFeedbackIcon({required this.feedback});

  final _RefreshFeedback feedback;

  @override
  Widget build(BuildContext context) {
    final colors = context.echoColors;
    final animationsDisabled =
        MediaQuery.maybeOf(context)?.disableAnimations ??
        WidgetsBinding
            .instance
            .platformDispatcher
            .accessibilityFeatures
            .disableAnimations;
    return switch (feedback.kind) {
      _RefreshFeedbackKind.refreshing =>
        animationsDisabled
            ? Icon(AppIcons.refresh, size: 18, color: colors.accent)
            : SizedBox.square(
                dimension: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colors.accent,
                  backgroundColor: colors.divider,
                ),
              ),
      _RefreshFeedbackKind.pull => Icon(
        AppIcons.chevronDown,
        size: 18,
        color: colors.muted,
      ),
      _RefreshFeedbackKind.release => Icon(
        AppIcons.refresh,
        size: 18,
        color: colors.accent,
      ),
      _RefreshFeedbackKind.done => Icon(
        AppIcons.check,
        size: 18,
        color: colors.accent,
      ),
    };
  }
}
