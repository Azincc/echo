import 'package:flutter/material.dart';

RectTween playerLinearRectTween(Rect? begin, Rect? end) {
  return RectTween(begin: begin ?? Rect.zero, end: end ?? Rect.zero);
}

/// Arc-based rect tween for cover image Hero — produces a more natural
/// curved flight path when the horizontal offset is significant.
RectTween playerCoverRectTween(Rect? begin, Rect? end) {
  return MaterialRectCenterArcTween(
    begin: begin ?? Rect.zero,
    end: end ?? Rect.zero,
  );
}

class _TextSnapshot {
  final String data;
  final TextStyle style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final StrutStyle? strutStyle;
  final Locale? locale;

  const _TextSnapshot({
    required this.data,
    required this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.strutStyle,
    this.locale,
  });
}

_TextSnapshot? _extractTextSnapshot(Widget widget, BuildContext context) {
  Text? found;

  void visit(Widget current) {
    if (found != null) return;
    if (current is Text) {
      found = current;
      return;
    }
    if (current is Material && current.child != null) {
      visit(current.child!);
      return;
    }
    if (current is Padding) {
      final child = current.child;
      if (child != null) {
        visit(child);
      }
      return;
    }
    if (current is Align && current.child != null) {
      visit(current.child!);
      return;
    }
    if (current is Center && current.child != null) {
      visit(current.child!);
      return;
    }
    if (current is SizedBox && current.child != null) {
      visit(current.child!);
      return;
    }
  }

  visit(widget);
  final textWidget = found;
  if (textWidget == null || textWidget.data == null) return null;

  final style = DefaultTextStyle.of(context).style.merge(textWidget.style);

  return _TextSnapshot(
    data: textWidget.data!,
    style: style,
    textAlign: textWidget.textAlign,
    maxLines: textWidget.maxLines,
    overflow: textWidget.overflow,
    softWrap: textWidget.softWrap,
    textWidthBasis: textWidget.textWidthBasis,
    textHeightBehavior: textWidget.textHeightBehavior,
    strutStyle: textWidget.strutStyle,
    locale: textWidget.locale,
  );
}

bool _isPrefixTextPair(String from, String to) {
  final fromText = _normalizeForComparison(from);
  final toText = _normalizeForComparison(to);
  if (fromText.isEmpty || toText.isEmpty) return false;
  if (fromText == toText) return true;
  return fromText.startsWith(toText) || toText.startsWith(fromText);
}

/// Strip middle-dots, interpuncts and surrounding whitespace so that
/// "artist" matches "artist · album" after normalisation.
String _normalizeForComparison(String s) {
  return s.trim().replaceAll(RegExp(r'[\s·・•]+'), ' ');
}

Widget playerTextFlightShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  final fromHero = fromHeroContext.widget as Hero;
  final toHero = toHeroContext.widget as Hero;
  final fromChild = fromHero.child;
  final toChild = toHero.child;

  final fromText = _extractTextSnapshot(fromChild, fromHeroContext);
  final toText = _extractTextSnapshot(toChild, toHeroContext);

  // 文本英雄使用"单文本样式插值"，避免双层叠加导致的颜色重影。
  //
  // 三个维度分别使用不同的插值策略：
  //
  // 1) 字号/字重 — 线性，与 Hero Rect 线性 tween 保持同步，
  //    防止 FittedBox 缩放与字号变化产生冲突导致大小跳变。
  //
  // 2) 颜色 — 方向感知的陡峭曲线：
  //    Push (mini→full): easeOutQuart — 文字迅速变白，匹配背景快速变暗
  //    Pop  (full→mini): easeInQuart — 文字保持白色更久，直到背景变亮才转暗
  //
  // 3) 对齐 — 从源端对齐平滑过渡到目标端对齐（左↔居中），
  //    避免 Hero 降落最后一帧的对齐跳变。
  if (fromText != null &&
      toText != null &&
      _isPrefixTextPair(fromText.data, toText.data)) {
    // Resolve effective alignment for each side.
    final fromAlign = _textAlignToAlignment(fromText.textAlign);
    final toAlign = _textAlignToAlignment(toText.textAlign);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final raw = animation.value;

        // 1) Size/weight — linear to match the linear Hero Rect tween.
        //    This prevents FittedBox from fighting with fontSize changes.
        final sizeStyle = TextStyle.lerp(fromText.style, toText.style, raw);

        // 2) Colour — direction-aware steep curve.
        final double tColor;
        if (flightDirection == HeroFlightDirection.push) {
          // Push: background darkens fast → text should whiten fast
          tColor = Curves.easeOutQuart.transform(raw);
        } else {
          // Pop: background lightens late → text should stay white longer
          tColor = Curves.easeInQuart.transform(raw);
        }
        final colorStyle = TextStyle.lerp(fromText.style, toText.style, tColor);
        final style = sizeStyle?.copyWith(color: colorStyle?.color);

        // 3) Alignment — smooth interpolation from source to destination.
        final alignment = Alignment.lerp(fromAlign, toAlign, raw)!;

        final switched = raw < 0.52 ? fromText : toText;
        return Material(
          type: MaterialType.transparency,
          child: Align(
            alignment: alignment,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: alignment,
              child: Text(
                switched.data,
                style: style,
                textAlign: switched.textAlign,
                maxLines: switched.maxLines,
                overflow: switched.overflow,
                softWrap: switched.softWrap,
                textWidthBasis: switched.textWidthBasis,
                textHeightBehavior: switched.textHeightBehavior,
                strutStyle: switched.strutStyle,
                locale: switched.locale,
              ),
            ),
          ),
        );
      },
    );
  }

  // 非文本场景的兜底，避免双层绘制。
  return flightDirection == HeroFlightDirection.push ? toChild : fromChild;
}

/// Map [TextAlign] to an [Alignment] for use in the shuttle layout.
Alignment _textAlignToAlignment(TextAlign? textAlign) {
  return switch (textAlign) {
    TextAlign.center => Alignment.center,
    TextAlign.right || TextAlign.end => Alignment.centerRight,
    _ => Alignment.centerLeft,
  };
}
