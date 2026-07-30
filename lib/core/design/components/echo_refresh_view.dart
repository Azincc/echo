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
  _RefreshPhase _phase = _RefreshPhase.idle;
  Timer? _resultTimer;

  void _handleStatusChange(RefreshIndicatorStatus? status) {
    if (!mounted) return;

    switch (status) {
      case RefreshIndicatorStatus.drag:
        _transitionTo(_RefreshPhase.pulling);
      case RefreshIndicatorStatus.armed:
        _transitionTo(_RefreshPhase.armed);
      case RefreshIndicatorStatus.snap:
      case RefreshIndicatorStatus.refresh:
        _transitionTo(_RefreshPhase.refreshing);
      case RefreshIndicatorStatus.done:
        _showResult(
          _phase == _RefreshPhase.failed
              ? _RefreshPhase.failed
              : _RefreshPhase.completed,
        );
      case RefreshIndicatorStatus.canceled:
        _transitionTo(_RefreshPhase.idle);
      case null:
        // RefreshIndicator currently does not report its terminal null status,
        // but keep result feedback stable if a future Flutter version does.
        if (!_phase.isResult) {
          _transitionTo(_RefreshPhase.idle);
        }
    }
  }

  Future<void> _performRefresh() async {
    _transitionTo(_RefreshPhase.refreshing);
    try {
      await widget.onRefresh();
    } catch (_) {
      // RefreshIndicator treats every completed callback as `done`, including
      // failed futures. Convert the error into an explicit UI result instead
      // of reporting a false success or leaking an unhandled async error.
      _transitionTo(_RefreshPhase.failed);
    }
  }

  void _transitionTo(_RefreshPhase nextPhase) {
    if (!mounted || _phase == nextPhase) return;
    _resultTimer?.cancel();
    _resultTimer = null;
    setState(() => _phase = nextPhase);
  }

  void _showResult(_RefreshPhase resultPhase) {
    assert(resultPhase.isResult);
    if (!mounted) return;

    _resultTimer?.cancel();
    _resultTimer = null;
    if (_phase != resultPhase) {
      setState(() => _phase = resultPhase);
    }

    _resultTimer = Timer(
      context.echoMotion.scene + context.echoMotion.feedback,
      () => _transitionTo(_RefreshPhase.idle),
    );
  }

  @override
  void dispose() {
    _resultTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final motion = context.echoMotion;
    final colors = context.echoColors;
    final feedback = _RefreshFeedback.from(_phase);
    final visible = feedback != null;
    final emphasisColor = feedback?.kind == _RefreshFeedbackKind.failed
        ? colors.error
        : colors.accent;

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
                                emphasisColor.withValues(alpha: 0.12),
                                colors.surface,
                              )
                            : colors.surface,
                        borderRadius: context.echoRadii.pill,
                        border: Border.all(
                          color: feedback?.emphasized == true
                              ? emphasisColor
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

enum _RefreshPhase { idle, pulling, armed, refreshing, completed, failed }

extension on _RefreshPhase {
  bool get isResult =>
      this == _RefreshPhase.completed || this == _RefreshPhase.failed;
}

enum _RefreshFeedbackKind { pull, release, refreshing, done, failed }

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

  static _RefreshFeedback? from(_RefreshPhase phase) {
    return switch (phase) {
      _RefreshPhase.idle => null,
      _RefreshPhase.pulling => const _RefreshFeedback(
        kind: _RefreshFeedbackKind.pull,
        label: '下拉刷新',
        announce: false,
        emphasized: false,
      ),
      _RefreshPhase.armed => const _RefreshFeedback(
        kind: _RefreshFeedbackKind.release,
        label: '松开刷新',
        announce: true,
        emphasized: true,
      ),
      _RefreshPhase.refreshing => const _RefreshFeedback(
        kind: _RefreshFeedbackKind.refreshing,
        label: '正在刷新',
        announce: true,
        emphasized: true,
      ),
      _RefreshPhase.completed => const _RefreshFeedback(
        kind: _RefreshFeedbackKind.done,
        label: '刷新完成',
        announce: true,
        emphasized: true,
      ),
      _RefreshPhase.failed => const _RefreshFeedback(
        kind: _RefreshFeedbackKind.failed,
        label: '刷新失败',
        announce: true,
        emphasized: true,
      ),
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
      _RefreshFeedbackKind.failed => Icon(
        AppIcons.error,
        size: 18,
        color: colors.error,
      ),
    };
  }
}
