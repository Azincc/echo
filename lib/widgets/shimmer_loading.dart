import 'package:flutter/material.dart';

import '../core/design/echo_design.dart';

/// 微光动画效果容器
///
/// 在子组件上叠加一个从左向右循环流动的线性渐变，
/// 呈现出 "微光掠过" 的动态感。
class ShimmerEffect extends StatefulWidget {
  final Widget child;

  const ShimmerEffect({super.key, required this.child});

  @override
  State<ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _reduceMotion = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduceMotion = context.echoReduceMotion;
    if (_reduceMotion == reduceMotion &&
        (reduceMotion || _controller.isAnimating)) {
      return;
    }

    _reduceMotion = reduceMotion;
    if (reduceMotion) {
      _controller
        ..stop()
        ..value = 0.5;
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
    final baseColor = colors.raised;
    final highlightColor = Color.alphaBlend(
      colors.ink.withValues(alpha: 0.1),
      baseColor,
    );

    if (_reduceMotion) {
      return ExcludeSemantics(child: RepaintBoundary(child: widget.child));
    }

    return ExcludeSemantics(
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return ShaderMask(
              blendMode: BlendMode.srcATop,
              shaderCallback: (bounds) {
                final slide = _controller.value * 2 - 0.5;
                return LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[baseColor, highlightColor, baseColor],
                  stops: <double>[
                    (slide - 0.3).clamp(0.0, 1.0),
                    slide.clamp(0.0, 1.0),
                    (slide + 0.3).clamp(0.0, 1.0),
                  ],
                ).createShader(bounds);
              },
              child: child,
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
}

/// 骨架占位块
///
/// 灰色圆角矩形，用于模拟真实内容加载前的结构占位。
class SkeletonBox extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final bool isCircle;

  const SkeletonBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 4.0,
    this.isCircle = false,
  });

  /// 圆形骨架块，适用于头像占位
  const SkeletonBox.circle({super.key, required double size})
    : width = size,
      height = size,
      borderRadius = 0,
      isCircle = true;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: RepaintBoundary(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: context.echoColors.raised,
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: isCircle ? null : BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
