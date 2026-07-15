import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../echo_context.dart';

class EchoSlider extends StatelessWidget {
  const EchoSlider({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.semanticLabel,
    this.semanticValue,
    this.secondaryValue,
    this.onChangeStart,
    this.onChangeEnd,
    this.activeColor,
    this.secondaryColor,
    this.inactiveColor,
    this.thumbColor,
  }) : assert(max > min);

  final double value;
  final double min;
  final double max;
  final ValueChanged<double>? onChanged;
  final String semanticLabel;
  final String? semanticValue;
  final double? secondaryValue;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;
  final Color? activeColor;
  final Color? secondaryColor;
  final Color? inactiveColor;
  final Color? thumbColor;

  double _progress(double candidate) =>
      ((candidate - min) / (max - min)).clamp(0.0, 1.0).toDouble();

  @override
  Widget build(BuildContext context) {
    final step = (max - min) / 20;
    final progress = _progress(value);
    final secondaryProgress = secondaryValue == null
        ? 0.0
        : _progress(secondaryValue!);
    final enabled = onChanged != null;

    return Semantics(
      container: true,
      slider: true,
      enabled: enabled,
      label: semanticLabel,
      value: semanticValue ?? value.toStringAsFixed(0),
      increasedValue: (value + step).clamp(min, max).toStringAsFixed(0),
      decreasedValue: (value - step).clamp(min, max).toStringAsFixed(0),
      onIncrease: enabled
          ? () => onChanged!((value + step).clamp(min, max).toDouble())
          : null,
      onDecrease: enabled
          ? () => onChanged!((value - step).clamp(min, max).toDouble())
          : null,
      child: ExcludeSemantics(
        child: LayoutBuilder(
          builder: (context, constraints) {
            const thumbSize = 22.0;
            final width = constraints.maxWidth;
            final travel = (width - thumbSize)
                .clamp(0.0, double.infinity)
                .toDouble();
            final thumbStart = travel * progress;
            final colors = context.echoColors;
            final resolvedActive = activeColor ?? colors.accent;
            final resolvedSecondary =
                secondaryColor ?? resolvedActive.withValues(alpha: 0.42);
            final resolvedInactive = inactiveColor ?? colors.controlBoundary;
            final resolvedThumb = thumbColor ?? colors.ink;

            void update(double dx) {
              if (!enabled || width <= thumbSize) return;
              final direction = Directionality.of(context);
              final local = direction == TextDirection.rtl ? width - dx : dx;
              final nextProgress = ((local - thumbSize / 2) / travel)
                  .clamp(0.0, 1.0)
                  .toDouble();
              onChanged!(min + (max - min) * nextProgress);
            }

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: enabled
                  ? (details) {
                      HapticFeedback.selectionClick();
                      onChangeStart?.call(value);
                      update(details.localPosition.dx);
                    }
                  : null,
              onTapUp: enabled ? (_) => onChangeEnd?.call(value) : null,
              onHorizontalDragStart: enabled
                  ? (details) {
                      onChangeStart?.call(value);
                      update(details.localPosition.dx);
                    }
                  : null,
              onHorizontalDragUpdate: enabled
                  ? (details) => update(details.localPosition.dx)
                  : null,
              onHorizontalDragEnd: enabled
                  ? (_) => onChangeEnd?.call(value)
                  : null,
              child: SizedBox(
                height: context.echoInteraction.minimumTouchTarget,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    PositionedDirectional(
                      start: thumbSize / 2,
                      end: thumbSize / 2,
                      child: ClipRRect(
                        borderRadius: context.echoRadii.pill,
                        child: SizedBox(
                          height: 4,
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              ColoredBox(color: resolvedInactive),
                              Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: FractionallySizedBox(
                                  widthFactor: secondaryProgress,
                                  heightFactor: 1,
                                  child: ColoredBox(color: resolvedSecondary),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: FractionallySizedBox(
                                  widthFactor: progress,
                                  heightFactor: 1,
                                  child: ColoredBox(color: resolvedActive),
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
                        decoration: BoxDecoration(
                          color: enabled ? resolvedThumb : colors.onDisabled,
                          shape: BoxShape.circle,
                          border: Border.all(color: colors.surface, width: 3),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: colors.scrim.withValues(alpha: 0.22),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const SizedBox.square(dimension: thumbSize),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
