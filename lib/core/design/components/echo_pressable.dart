import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../echo_context.dart';

/// Echo's shared interaction target.
///
/// Pointer feedback is delegated to [InkWell]. Keyboard activation is exposed
/// through Flutter's [Shortcuts] and [Actions] system, so a long-press-only
/// target still has an accessible keyboard path without changing its pointer
/// tap behavior.
class EchoPressable extends StatelessWidget {
  const EchoPressable({
    super.key,
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.semanticLabel,
    this.minimumSize = const Size.square(48),
    this.borderRadius,
    this.selected,
    this.enableHaptics = false,
    this.autofocus = false,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final String? semanticLabel;
  final Size minimumSize;
  final BorderRadius? borderRadius;
  final bool? selected;
  final bool enableHaptics;
  final bool autofocus;

  static const Map<ShortcutActivator, Intent> _shortcuts =
      <ShortcutActivator, Intent>{
        SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
        SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
      };

  @override
  Widget build(BuildContext context) {
    final interactive = onPressed != null || onLongPress != null;
    final radius = borderRadius ?? context.echoRadii.control;
    final motion = context.echoMotion;
    final colors = context.echoColors;
    final interaction = context.echoInteraction;

    Widget semanticsChild = child;
    if (semanticLabel != null) {
      semanticsChild = ExcludeSemantics(child: semanticsChild);
    }

    Widget target = ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minimumSize.width.isFinite ? minimumSize.width : 0,
        minHeight: minimumSize.height.isFinite ? minimumSize.height : 0,
      ),
      child: semanticsChild,
    );
    if (!minimumSize.width.isFinite) {
      target = SizedBox(width: double.infinity, child: target);
    }
    if (!minimumSize.height.isFinite) {
      target = SizedBox(height: double.infinity, child: target);
    }

    return Semantics(
      container: true,
      button: true,
      enabled: interactive,
      focusable: interactive,
      selected: selected,
      label: semanticLabel,
      onTap: onPressed,
      onLongPress: onLongPress,
      child: Shortcuts(
        shortcuts: _shortcuts,
        child: Actions(
          actions: <Type, Action<Intent>>{
            ActivateIntent: CallbackAction<ActivateIntent>(
              onInvoke: (intent) {
                final action = onPressed ?? onLongPress;
                if (action != null) _invoke(action);
                return null;
              },
            ),
          },
          child: Focus(
            canRequestFocus: interactive,
            autofocus: autofocus && interactive,
            child: Builder(
              builder: (focusContext) {
                final focusNode = Focus.of(focusContext);
                final focused = focusNode.hasFocus;
                final focusColor = focused ? colors.accent : Colors.transparent;

                return AnimatedOpacity(
                  duration: motion.resolve(context, motion.feedback),
                  curve: motion.easeOut,
                  opacity: interactive ? 1 : 0.5,
                  child: AnimatedContainer(
                    duration: motion.resolve(context, motion.feedback),
                    curve: motion.easeOut,
                    foregroundDecoration: BoxDecoration(
                      borderRadius: radius,
                      border: Border.all(
                        color: focusColor,
                        width: interaction.focusRingWidth,
                      ),
                    ),
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        onTap: onPressed == null
                            ? null
                            : () {
                                focusNode.requestFocus();
                                _invoke(onPressed!);
                              },
                        onLongPress: onLongPress == null
                            ? null
                            : () {
                                focusNode.requestFocus();
                                _invoke(onLongPress!);
                              },
                        canRequestFocus: false,
                        excludeFromSemantics: true,
                        borderRadius: radius,
                        splashFactory: NoSplash.splashFactory,
                        mouseCursor: interactive
                            ? SystemMouseCursors.click
                            : SystemMouseCursors.basic,
                        overlayColor: WidgetStateProperty.resolveWith<Color?>((
                          states,
                        ) {
                          if (!interactive) return Colors.transparent;
                          if (states.contains(WidgetState.pressed)) {
                            return colors.accent.withValues(alpha: 0.14);
                          }
                          if (states.contains(WidgetState.hovered)) {
                            return colors.accent.withValues(alpha: 0.08);
                          }
                          return Colors.transparent;
                        }),
                        child: target,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _invoke(VoidCallback action) {
    if (enableHaptics) HapticFeedback.selectionClick();
    action();
  }
}
