import 'package:flutter/material.dart';

import '../echo_context.dart';
import 'echo_pressable.dart';

enum EchoButtonVariant { primary, secondary, ghost, destructive }

class EchoButton extends StatelessWidget {
  const EchoButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = EchoButtonVariant.primary,
    this.leadingIcon,
    this.trailingIcon,
    this.expand = false,
    this.enableHaptics = false,
    this.semanticLabel,
  });

  const EchoButton.primary({
    super.key,
    required this.label,
    required this.onPressed,
    this.leadingIcon,
    this.trailingIcon,
    this.expand = false,
    this.enableHaptics = false,
    this.semanticLabel,
  }) : variant = EchoButtonVariant.primary;

  const EchoButton.secondary({
    super.key,
    required this.label,
    required this.onPressed,
    this.leadingIcon,
    this.trailingIcon,
    this.expand = false,
    this.enableHaptics = false,
    this.semanticLabel,
  }) : variant = EchoButtonVariant.secondary;

  const EchoButton.ghost({
    super.key,
    required this.label,
    required this.onPressed,
    this.leadingIcon,
    this.trailingIcon,
    this.expand = false,
    this.enableHaptics = false,
    this.semanticLabel,
  }) : variant = EchoButtonVariant.ghost;

  const EchoButton.destructive({
    super.key,
    required this.label,
    required this.onPressed,
    this.leadingIcon,
    this.trailingIcon,
    this.expand = false,
    this.enableHaptics = false,
    this.semanticLabel,
  }) : variant = EchoButtonVariant.destructive;

  final String label;
  final VoidCallback? onPressed;
  final EchoButtonVariant variant;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool expand;
  final bool enableHaptics;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.echoColors;
    final enabled = onPressed != null;
    final background = enabled
        ? switch (variant) {
            EchoButtonVariant.primary => colors.accent,
            EchoButtonVariant.secondary => colors.raised,
            EchoButtonVariant.ghost => Colors.transparent,
            EchoButtonVariant.destructive => colors.error,
          }
        : switch (variant) {
            EchoButtonVariant.ghost => Colors.transparent,
            EchoButtonVariant.primary ||
            EchoButtonVariant.secondary ||
            EchoButtonVariant.destructive => colors.raised,
          };
    final foreground = enabled
        ? switch (variant) {
            EchoButtonVariant.primary => colors.onAccent,
            EchoButtonVariant.secondary => colors.ink,
            EchoButtonVariant.ghost => colors.accent,
            EchoButtonVariant.destructive => _foregroundOn(colors.error),
          }
        : colors.onDisabled;
    final horizontalPadding = variant == EchoButtonVariant.ghost
        ? context.echoSpacing.sm
        : 20.0;

    return EchoPressable(
      semanticLabel: semanticLabel ?? label,
      onPressed: onPressed,
      minimumSize: Size(
        expand ? double.infinity : context.echoInteraction.minimumTouchTarget,
        context.echoInteraction.buttonHeight,
      ),
      borderRadius: context.echoRadii.control,
      enableHaptics: enableHaptics,
      child: Ink(
        decoration: BoxDecoration(
          color: background,
          borderRadius: context.echoRadii.control,
          border: variant == EchoButtonVariant.secondary
              ? Border.all(color: colors.controlBoundary)
              : null,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: context.echoSpacing.sm,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final text = Text(
                label,
                textAlign: TextAlign.center,
                style: context.echoTypography.label.copyWith(color: foreground),
              );
              final children = <Widget>[
                if (leadingIcon != null) ...<Widget>[
                  Icon(leadingIcon, size: 20, color: foreground),
                  SizedBox(width: context.echoSpacing.xs),
                ],
                if (constraints.hasBoundedWidth)
                  Flexible(child: text)
                else
                  text,
                if (trailingIcon != null) ...<Widget>[
                  SizedBox(width: context.echoSpacing.xs),
                  Icon(trailingIcon, size: 20, color: foreground),
                ],
              ];
              return Row(
                mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              );
            },
          ),
        ),
      ),
    );
  }

  static Color _foregroundOn(Color background) {
    final whiteContrast = _contrastRatio(Colors.white, background);
    final blackContrast = _contrastRatio(Colors.black, background);
    return whiteContrast >= blackContrast ? Colors.white : Colors.black;
  }

  static double _contrastRatio(Color foreground, Color background) {
    final lighter =
        foreground.computeLuminance() >= background.computeLuminance()
        ? foreground.computeLuminance()
        : background.computeLuminance();
    final darker = foreground.computeLuminance() < background.computeLuminance()
        ? foreground.computeLuminance()
        : background.computeLuminance();
    return (lighter + 0.05) / (darker + 0.05);
  }
}
