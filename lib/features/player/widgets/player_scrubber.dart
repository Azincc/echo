import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/design/echo_design.dart';

typedef EchoScrubberSemanticFormatter = String Function(double value);

/// A playback-specific scrubber that stays visually quiet until interaction.
///
/// The track and thumb grow only while the user is seeking. The full surface
/// remains a 48dp semantic target so the compact resting treatment does not
/// reduce accessibility.
class EchoPlayerScrubber extends StatefulWidget {
  const EchoPlayerScrubber({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.semanticLabel,
    this.semanticValue,
    this.secondaryValue,
    this.semanticStep,
    this.semanticValueFormatter,
    this.onChangeStart,
    this.onChangeEnd,
    this.onChangeCancel,
    this.activeColor,
    this.secondaryColor,
    this.inactiveColor,
    this.thumbColor,
  }) : assert(max > min),
       assert(semanticStep == null || semanticStep > 0);

  final double value;
  final double min;
  final double max;
  final ValueChanged<double>? onChanged;
  final String semanticLabel;
  final String? semanticValue;
  final double? secondaryValue;
  final double? semanticStep;
  final EchoScrubberSemanticFormatter? semanticValueFormatter;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;
  final ValueChanged<double>? onChangeCancel;
  final Color? activeColor;
  final Color? secondaryColor;
  final Color? inactiveColor;
  final Color? thumbColor;

  @override
  State<EchoPlayerScrubber> createState() => _EchoPlayerScrubberState();
}

class _EchoPlayerScrubberState extends State<EchoPlayerScrubber> {
  bool _interacting = false;
  bool _horizontalDragActive = false;
  double? _interactionValue;
  int _sessionId = 0;

  bool get _enabled => widget.onChanged != null;

  double _progress(double candidate) {
    return ((candidate - widget.min) / (widget.max - widget.min))
        .clamp(0.0, 1.0)
        .toDouble();
  }

  double _valueFromDx(double dx, double width) {
    if (width <= 0) return widget.value;
    final direction = Directionality.of(context);
    final local = direction == TextDirection.rtl ? width - dx : dx;
    final progress = (local / width).clamp(0.0, 1.0).toDouble();
    return widget.min + (widget.max - widget.min) * progress;
  }

  void _start(double dx, double width) {
    if (!_enabled || _interacting) return;
    HapticFeedback.selectionClick();
    widget.onChangeStart?.call(widget.value);
    setState(() {
      _sessionId += 1;
      _interacting = true;
      _horizontalDragActive = false;
      _interactionValue = _valueFromDx(dx, width);
    });
    widget.onChanged!(_interactionValue!);
  }

  void _update(double dx, double width) {
    if (!_enabled || !_interacting) return;
    final next = _valueFromDx(dx, width);
    setState(() => _interactionValue = next);
    widget.onChanged!(next);
  }

  void _finish() {
    if (!_interacting) return;
    final value = _interactionValue ?? widget.value;
    setState(() {
      _interacting = false;
      _horizontalDragActive = false;
      _interactionValue = null;
    });
    widget.onChangeEnd?.call(value);
  }

  void _cancel() {
    if (!_interacting) return;
    final value = _interactionValue ?? widget.value;
    setState(() {
      _interacting = false;
      _horizontalDragActive = false;
      _interactionValue = null;
    });
    widget.onChangeCancel?.call(value);
  }

  void _scheduleTapCancel() {
    if (!_interacting) return;
    final canceledSessionId = _sessionId;
    scheduleMicrotask(() {
      if (!mounted ||
          !_interacting ||
          _sessionId != canceledSessionId ||
          _horizontalDragActive) {
        return;
      }
      _cancel();
    });
  }

  void _recognizeHorizontalDrag(double dx, double width) {
    if (_interacting) {
      _horizontalDragActive = true;
      _update(dx, width);
      return;
    }
    _start(dx, width);
    _horizontalDragActive = true;
  }

  void _adjust(double direction) {
    if (!_enabled) return;
    final step = widget.semanticStep ?? (widget.max - widget.min) / 20;
    final next = (widget.value + step * direction)
        .clamp(widget.min, widget.max)
        .toDouble();
    HapticFeedback.selectionClick();
    widget.onChangeStart?.call(widget.value);
    widget.onChanged!(next);
    widget.onChangeEnd?.call(next);
  }

  String _formatSemanticValue(double value) {
    return widget.semanticValueFormatter?.call(value) ??
        value.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    final displayedValue = _interactionValue ?? widget.value;
    final progress = _progress(displayedValue);
    final secondaryProgress = widget.secondaryValue == null
        ? 0.0
        : _progress(widget.secondaryValue!);
    final colors = context.echoColors;
    final active = widget.activeColor ?? colors.accent;
    final secondary = widget.secondaryColor ?? active.withValues(alpha: 0.42);
    final inactive = widget.inactiveColor ?? colors.controlBoundary;
    final thumb = widget.thumbColor ?? colors.ink;
    final semanticStep = widget.semanticStep ?? (widget.max - widget.min) / 20;
    final canIncrease = _enabled && displayedValue < widget.max;
    final canDecrease = _enabled && displayedValue > widget.min;
    final increasedValue = _formatSemanticValue(
      (displayedValue + semanticStep).clamp(widget.min, widget.max).toDouble(),
    );
    final decreasedValue = _formatSemanticValue(
      (displayedValue - semanticStep).clamp(widget.min, widget.max).toDouble(),
    );
    final duration = context.echoMotion.resolve(
      context,
      context.echoMotion.feedback,
    );

    return Semantics(
      container: true,
      slider: true,
      enabled: _enabled,
      label: widget.semanticLabel,
      value: widget.semanticValue ?? _formatSemanticValue(displayedValue),
      increasedValue: canIncrease ? increasedValue : null,
      decreasedValue: canDecrease ? decreasedValue : null,
      onIncrease: canIncrease ? () => _adjust(1) : null,
      onDecrease: canDecrease ? () => _adjust(-1) : null,
      child: ExcludeSemantics(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: _enabled
                  ? (details) => _start(details.localPosition.dx, width)
                  : null,
              onTapUp: _enabled ? (_) => _finish() : null,
              onTapCancel: _enabled ? _scheduleTapCancel : null,
              onHorizontalDragStart: _enabled
                  ? (details) => _recognizeHorizontalDrag(
                      details.localPosition.dx,
                      width,
                    )
                  : null,
              onHorizontalDragUpdate: _enabled
                  ? (details) => _update(details.localPosition.dx, width)
                  : null,
              onHorizontalDragEnd: _enabled ? (_) => _finish() : null,
              onHorizontalDragCancel: _enabled ? _cancel : null,
              child: SizedBox(
                key: const ValueKey<String>('echo-player-scrubber'),
                height: context.echoInteraction.minimumTouchTarget,
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(end: _interacting ? 1 : 0),
                  duration: duration,
                  curve: context.echoMotion.easeOut,
                  builder: (context, emphasis, child) {
                    final trackHeight = 3 + emphasis * 2;
                    final thumbSize = 6 + emphasis * 8;
                    final thumbCenter = width * progress;
                    final thumbStart = (thumbCenter - thumbSize / 2)
                        .clamp(0.0, (width - thumbSize).clamp(0.0, width))
                        .toDouble();

                    return Stack(
                      alignment: AlignmentDirectional.centerStart,
                      children: <Widget>[
                        PositionedDirectional(
                          start: 0,
                          end: 0,
                          child: ClipRRect(
                            key: const ValueKey<String>(
                              'echo-player-scrubber-track',
                            ),
                            borderRadius: context.echoRadii.pill,
                            child: SizedBox(
                              height: trackHeight,
                              child: Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  ColoredBox(color: inactive),
                                  Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: FractionallySizedBox(
                                      widthFactor: secondaryProgress,
                                      heightFactor: 1,
                                      child: ColoredBox(color: secondary),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: FractionallySizedBox(
                                      widthFactor: progress,
                                      heightFactor: 1,
                                      child: ColoredBox(color: active),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        PositionedDirectional(
                          start: thumbStart,
                          child: DecoratedBox(
                            key: const ValueKey<String>(
                              'echo-player-scrubber-thumb',
                            ),
                            decoration: BoxDecoration(
                              color: _enabled ? thumb : colors.onDisabled,
                              shape: BoxShape.circle,
                              boxShadow: emphasis <= 0
                                  ? const <BoxShadow>[]
                                  : <BoxShadow>[
                                      BoxShadow(
                                        color: colors.scrim.withValues(
                                          alpha: 0.2,
                                        ),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                            ),
                            child: SizedBox.square(dimension: thumbSize),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
