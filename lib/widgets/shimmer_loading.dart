import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final scheme = theme.colorScheme;
    final baseColor = Color.lerp(
      scheme.surfaceContainerHighest,
      scheme.primary,
      isDark ? 0.10 : 0.04,
    )!.withValues(alpha: isDark ? 0.58 : 0.64);
    final highlightColor = Color.lerp(
      scheme.surfaceContainerHighest,
      scheme.primary,
      isDark ? 0.28 : 0.16,
    )!.withValues(alpha: isDark ? 0.88 : 0.78);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            final double slide = _controller.value * 2 - 0.5;
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [baseColor, highlightColor, baseColor],
              stops: [
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final color = theme.colorScheme.surfaceContainerHighest.withValues(
      alpha: isDark ? 0.64 : 0.70,
    );

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle ? null : BorderRadius.circular(borderRadius),
        border: isCircle
            ? null
            : Border.all(
                color: theme.colorScheme.outlineVariant.withValues(
                  alpha: isDark ? 0.18 : 0.32,
                ),
                width: 0.5,
              ),
      ),
    );
  }
}
