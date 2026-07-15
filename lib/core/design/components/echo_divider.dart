import 'package:flutter/material.dart';

import '../echo_context.dart';

class EchoDivider extends StatelessWidget {
  const EchoDivider({
    super.key,
    this.axis = Axis.horizontal,
    this.inset = 0,
    this.endInset = 0,
    this.color,
  });

  final Axis axis;
  final double inset;
  final double endInset;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final line = ColoredBox(color: color ?? context.echoColors.divider);
    return ExcludeSemantics(
      child: axis == Axis.horizontal
          ? Padding(
              padding: EdgeInsetsDirectional.only(start: inset, end: endInset),
              child: SizedBox(height: 1, child: line),
            )
          : Padding(
              padding: EdgeInsets.only(top: inset, bottom: endInset),
              child: SizedBox(width: 1, child: line),
            ),
    );
  }
}
