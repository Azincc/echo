import 'package:flutter/material.dart';

import '../../theme/app_icons.dart';
import '../echo_context.dart';
import 'echo_button.dart';

class EchoEmptyState extends StatelessWidget {
  const EchoEmptyState({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.actionLabel,
    this.onAction,
    this.padding = const EdgeInsets.all(32),
  });

  final String title;
  final String description;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: padding,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox.square(
                dimension: context.echoInteraction.minimumTouchTarget,
                child: Center(
                  child: Icon(icon, size: 34, color: context.echoColors.muted),
                ),
              ),
              SizedBox(height: context.echoSpacing.md),
              Semantics(
                header: true,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: context.echoTypography.headline,
                ),
              ),
              SizedBox(height: context.echoSpacing.xs),
              Text(
                description,
                textAlign: TextAlign.center,
                style: context.echoTypography.body.copyWith(
                  color: context.echoColors.muted,
                ),
              ),
              if (actionLabel != null) ...<Widget>[
                SizedBox(height: context.echoSpacing.lg),
                EchoButton.secondary(label: actionLabel!, onPressed: onAction),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class EchoErrorState extends StatelessWidget {
  const EchoErrorState({
    super.key,
    required this.title,
    required this.description,
    this.icon = AppIcons.cloudOff,
    this.actionLabel,
    this.onAction,
    this.padding = const EdgeInsets.all(32),
  });

  final String title;
  final String description;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: padding,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox.square(
                dimension: context.echoInteraction.minimumTouchTarget,
                child: Center(
                  child: Icon(icon, size: 34, color: context.echoColors.error),
                ),
              ),
              SizedBox(height: context.echoSpacing.md),
              Semantics(
                header: true,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: context.echoTypography.headline,
                ),
              ),
              SizedBox(height: context.echoSpacing.xs),
              Text(
                description,
                textAlign: TextAlign.center,
                style: context.echoTypography.body.copyWith(
                  color: context.echoColors.muted,
                ),
              ),
              if (actionLabel != null) ...<Widget>[
                SizedBox(height: context.echoSpacing.lg),
                EchoButton.secondary(label: actionLabel!, onPressed: onAction),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
