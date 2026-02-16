import 'package:flutter/material.dart';

RectTween playerLinearRectTween(Rect? begin, Rect? end) {
  return RectTween(begin: begin ?? Rect.zero, end: end ?? Rect.zero);
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

  final style = DefaultTextStyle.of(context).style.merge(
    textWidget.style,
  );

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

  // 文本英雄使用“单文本样式插值”，避免双层叠加导致的颜色重影。
  if (fromText != null && toText != null && fromText.data == toText.data) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final t = Curves.easeInOut.transform(animation.value);
        final style = TextStyle.lerp(fromText.style, toText.style, t);
        final switched = t < 0.5 ? fromText : toText;
        return Material(
          type: MaterialType.transparency,
          child: Align(
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
              child: Text(
                fromText.data,
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
