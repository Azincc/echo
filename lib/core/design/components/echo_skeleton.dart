import 'package:flutter/material.dart';

import '../echo_context.dart';

class EchoSkeleton extends StatefulWidget {
  const EchoSkeleton({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.borderRadius,
  });

  const EchoSkeleton.line({
    super.key,
    this.width = double.infinity,
    this.height = 12,
  }) : borderRadius = const BorderRadius.all(Radius.circular(4));

  const EchoSkeleton.circle({super.key, double size = 48})
    : width = size,
      height = size,
      borderRadius = const BorderRadius.all(Radius.circular(999));

  final double width;
  final double height;
  final BorderRadiusGeometry? borderRadius;

  @override
  State<EchoSkeleton> createState() => _EchoSkeletonState();
}

class _EchoSkeletonState extends State<EchoSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _animationsDisabled = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final disabled = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (disabled == _animationsDisabled &&
        (disabled || _controller.isAnimating)) {
      return;
    }
    _animationsDisabled = disabled;
    if (disabled) {
      _controller
        ..stop()
        ..value = 0.35;
    } else {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.echoColors;
    final radius = widget.borderRadius ?? context.echoRadii.detail;
    final base = colors.raised;
    final highlight = Color.alphaBlend(
      colors.ink.withValues(alpha: 0.08),
      base,
    );

    Widget block;
    if (_animationsDisabled) {
      block = DecoratedBox(
        decoration: BoxDecoration(color: base, borderRadius: radius),
      );
    } else {
      block = AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final progress = _controller.value;
          return DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: radius,
              gradient: LinearGradient(
                begin: Alignment(-1.8 + progress * 3.6, 0),
                end: Alignment(-0.8 + progress * 3.6, 0),
                colors: <Color>[base, highlight, base],
                stops: const <double>[0, 0.5, 1],
              ),
            ),
          );
        },
      );
    }

    return ExcludeSemantics(
      child: RepaintBoundary(
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: block,
        ),
      ),
    );
  }
}
