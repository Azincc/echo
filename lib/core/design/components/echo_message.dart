import 'package:flutter/material.dart';

import '../../theme/app_icons.dart';
import '../echo_context.dart';
import '../tokens/echo_colors.dart';
import 'echo_icon_button.dart';
import 'echo_surface.dart';

enum EchoMessageKind { info, success, warning, error }

class EchoMessage extends StatelessWidget {
  const EchoMessage({
    super.key,
    required this.message,
    this.kind = EchoMessageKind.info,
    this.onDismiss,
  });

  final String message;
  final EchoMessageKind kind;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    final colors = context.echoColors;
    final accent = switch (kind) {
      EchoMessageKind.info => colors.accent,
      EchoMessageKind.success => colors.accent,
      EchoMessageKind.warning => colors.warning,
      EchoMessageKind.error => colors.error,
    };
    final icon = switch (kind) {
      EchoMessageKind.info => AppIcons.info,
      EchoMessageKind.success => AppIcons.checkCircle,
      EchoMessageKind.warning => AppIcons.warning,
      EchoMessageKind.error => AppIcons.error,
    };
    final background = colors.ink;
    final messageAccent = EchoColors.ensureColorContrast(
      accent,
      background: background,
      minimumRatio: 3,
    );
    final foreground = colors.canvas;

    return Semantics(
      container: true,
      liveRegion: true,
      label: message,
      child: EchoSurface(
        level: EchoSurfaceLevel.floating,
        color: background,
        borderRadius: context.echoRadii.control,
        borderColor: messageAccent,
        padding: EdgeInsetsDirectional.only(
          start: context.echoSpacing.sm,
          top: context.echoSpacing.xs,
          bottom: context.echoSpacing.xs,
          end: context.echoSpacing.xs,
        ),
        child: Row(
          children: <Widget>[
            SizedBox.square(
              dimension: context.echoInteraction.minimumTouchTarget,
              child: Center(child: Icon(icon, size: 22, color: messageAccent)),
            ),
            SizedBox(width: context.echoSpacing.xs),
            Expanded(
              child: ExcludeSemantics(
                child: Text(
                  message,
                  style: context.echoTypography.body.copyWith(
                    color: foreground,
                  ),
                ),
              ),
            ),
            if (onDismiss != null) ...<Widget>[
              SizedBox(width: context.echoSpacing.xs),
              EchoIconButton(
                icon: AppIcons.close,
                label: '关闭通知',
                foregroundColor: foreground,
                backgroundColor: Colors.transparent,
                onPressed: onDismiss,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showEchoMessage(
  BuildContext context,
  String message, {
  EchoMessageKind kind = EchoMessageKind.info,
  ScaffoldMessengerState? messenger,
  Duration? duration,
}) {
  final messengerState = messenger ?? ScaffoldMessenger.of(context);
  final animationsDisabled =
      MediaQuery.maybeOf(context)?.disableAnimations ?? false;
  final motion = context.echoMotion;
  messengerState.hideCurrentSnackBar();

  final snackBar = SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    padding: EdgeInsets.zero,
    margin: EdgeInsets.fromLTRB(
      context.echoSpacing.md,
      context.echoSpacing.xs,
      context.echoSpacing.md,
      context.echoSpacing.md,
    ),
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.horizontal,
    duration:
        duration ??
        (kind == EchoMessageKind.error
            ? const Duration(seconds: 5)
            : const Duration(seconds: 3)),
    content: EchoMessage(
      message: message,
      kind: kind,
      onDismiss: messengerState.hideCurrentSnackBar,
    ),
  );

  return messengerState.showSnackBar(
    snackBar,
    snackBarAnimationStyle: animationsDisabled
        ? AnimationStyle.noAnimation
        : AnimationStyle(
            duration: motion.resolve(context, motion.feedback),
            reverseDuration: motion.resolve(context, motion.feedback),
          ),
  );
}
