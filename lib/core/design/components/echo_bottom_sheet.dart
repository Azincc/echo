import 'package:flutter/material.dart';

import '../../theme/app_icons.dart';
import '../echo_context.dart';
import '../tokens/echo_spacing.dart';
import 'echo_icon_button.dart';
import 'echo_pressable.dart';
import 'echo_surface.dart';

Future<T?> showEchoBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool useRootNavigator = false,
  bool isScrollControlled = false,
  bool isDismissible = true,
  bool enableDrag = true,
}) async {
  final previousFocus = FocusManager.instance.primaryFocus;
  final motion = context.echoMotion;
  final duration = motion.resolve(context, motion.scene);
  final result = await showModalBottomSheet<T>(
    context: context,
    useRootNavigator: useRootNavigator,
    isScrollControlled: isScrollControlled,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    // A scroll-controlled sheet can grow to the full viewport. Keep the
    // route below system cut-outs even when large text makes it full-height.
    useSafeArea: true,
    requestFocus: true,
    showDragHandle: false,
    elevation: 0,
    backgroundColor: Colors.transparent,
    barrierColor: context.echoColors.scrim,
    clipBehavior: Clip.none,
    constraints: const BoxConstraints(maxWidth: 640),
    sheetAnimationStyle: duration == Duration.zero
        ? AnimationStyle.noAnimation
        : AnimationStyle(
            duration: duration,
            reverseDuration: motion.resolve(context, motion.state),
          ),
    builder: (sheetContext) => FocusTraversalGroup(
      policy: OrderedTraversalPolicy(),
      child: builder(sheetContext),
    ),
  );

  if (context.mounted && previousFocus?.canRequestFocus == true) {
    previousFocus!.requestFocus();
  }
  return result;
}

class EchoBottomSheet extends StatelessWidget {
  const EchoBottomSheet({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.showCloseButton = true,
    this.constrainToAvailableHeight = false,
    this.padding,
  });

  final String title;
  final String? subtitle;
  final bool showCloseButton;
  final bool constrainToAvailableHeight;
  final EdgeInsetsGeometry? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final spacing = context.echoSpacing;
    final sceneRadius = context.echoRadii.scene;
    final topRadius = BorderRadius.only(
      topLeft: sceneRadius.topLeft,
      topRight: sceneRadius.topRight,
    );

    return Semantics(
      container: true,
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      label: title,
      child: EchoSurface(
        level: EchoSurfaceLevel.modal,
        borderRadius: topRadius,
        clipBehavior: Clip.antiAlias,
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: spacing.xs),
              Center(
                child: ExcludeSemantics(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.echoColors.divider,
                      borderRadius: context.echoRadii.pill,
                    ),
                    child: const SizedBox(width: 36, height: 4),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  spacing.md,
                  spacing.sm,
                  spacing.xs,
                  subtitle == null ? spacing.sm : spacing.xxs,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Semantics(
                        header: true,
                        child: Text(
                          title,
                          style: context.echoTypography.headline,
                        ),
                      ),
                    ),
                    if (showCloseButton) ...<Widget>[
                      SizedBox(width: spacing.sm),
                      EchoIconButton(
                        icon: AppIcons.close,
                        label: '关闭',
                        onPressed: () => Navigator.maybePop(context),
                      ),
                    ],
                  ],
                ),
              ),
              if (subtitle != null)
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    spacing.md,
                    0,
                    spacing.md,
                    spacing.md,
                  ),
                  child: Text(
                    subtitle!,
                    style: context.echoTypography.body.copyWith(
                      color: context.echoColors.muted,
                    ),
                  ),
                ),
              if (constrainToAvailableHeight)
                Flexible(child: _buildBody(spacing))
              else
                _buildBody(spacing),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(EchoSpacing spacing) {
    return Padding(
      padding:
          padding ??
          EdgeInsets.fromLTRB(
            spacing.md,
            subtitle == null ? spacing.xs : 0,
            spacing.md,
            spacing.md,
          ),
      child: child,
    );
  }
}

/// A domain action used inside sheets and menus. It keeps the familiar
/// icon-title-detail structure without falling back to Material [ListTile].
class EchoActionRow extends StatelessWidget {
  const EchoActionRow({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
    this.subtitle,
    this.trailing,
    this.selected = false,
    this.destructive = false,
    this.semanticLabel,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final bool selected;
  final bool destructive;
  final String? semanticLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.echoColors;
    final enabled = onPressed != null;
    final accent = destructive ? colors.error : colors.accent;
    final foreground = enabled
        ? (destructive ? colors.error : colors.ink)
        : colors.onDisabled;
    final detailColor = enabled ? colors.muted : colors.onDisabled;
    final background = selected
        ? accent.withValues(alpha: 0.1)
        : enabled
        ? Colors.transparent
        : colors.raised.withValues(alpha: 0.55);
    final label =
        semanticLabel ??
        <String>[
          title,
          if (subtitle != null) subtitle!,
          if (selected) '已选择',
        ].join('，');

    return EchoPressable(
      semanticLabel: label,
      selected: selected,
      onPressed: onPressed,
      minimumSize: Size(
        double.infinity,
        context.echoInteraction.expandedSongRowHeight,
      ),
      borderRadius: context.echoRadii.control,
      child: Ink(
        decoration: BoxDecoration(
          color: background,
          borderRadius: context.echoRadii.control,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.echoSpacing.xs,
            vertical: context.echoSpacing.xs,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox.square(
                dimension: context.echoInteraction.minimumTouchTarget,
                child: Center(
                  child: Icon(
                    icon,
                    size: 22,
                    color: enabled ? accent : colors.onDisabled,
                  ),
                ),
              ),
              SizedBox(width: context.echoSpacing.xs),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      title,
                      style: context.echoTypography.title.copyWith(
                        color: foreground,
                      ),
                    ),
                    if (subtitle != null) ...<Widget>[
                      SizedBox(height: context.echoSpacing.xxs),
                      Text(
                        subtitle!,
                        style: context.echoTypography.body.copyWith(
                          color: detailColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...<Widget>[
                SizedBox(width: context.echoSpacing.sm),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
