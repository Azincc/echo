import 'package:flutter/material.dart';

import '../echo_context.dart';
import 'echo_button.dart';

class EchoSectionHeader extends StatelessWidget {
  const EchoSectionHeader({
    super.key,
    required this.title,
    this.description,
    this.actionLabel,
    this.onAction,
    this.trailing,
    this.padding = EdgeInsets.zero,
  });

  final String title;
  final String? description;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final action =
        trailing ??
        (actionLabel == null
            ? null
            : EchoButton.ghost(label: actionLabel!, onPressed: onAction));
    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Semantics(
          header: true,
          child: Text(title, style: context.echoTypography.headline),
        ),
        if (description != null) ...<Widget>[
          SizedBox(height: context.echoSpacing.xxs),
          Text(
            description!,
            style: context.echoTypography.body.copyWith(
              color: context.echoColors.muted,
            ),
          ),
        ],
      ],
    );

    return Padding(
      padding: padding,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final scale = MediaQuery.textScalerOf(context).scale(1);
          final stack =
              action != null && (constraints.maxWidth < 360 || scale > 1.3);
          if (stack) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                text,
                SizedBox(height: context.echoSpacing.xs),
                action,
              ],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(child: text),
              if (action != null) ...<Widget>[
                SizedBox(width: context.echoSpacing.sm),
                action,
              ],
            ],
          );
        },
      ),
    );
  }
}
