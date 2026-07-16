import 'package:flutter/material.dart';

import '../../theme/app_icons.dart';
import '../echo_context.dart';
import '../layout/echo_shell_obstruction.dart';
import 'echo_icon_button.dart';

/// Stable page frame for Echo feature surfaces.
///
/// Flutter's [Scaffold] remains the route, keyboard and messenger
/// infrastructure; every visible surface is supplied by Echo tokens.
class EchoScaffold extends StatelessWidget {
  const EchoScaffold({
    super.key,
    required this.body,
    this.topBar,
    this.bottomBar,
    this.floatingAction,
    this.resizeToAvoidBottomInset = true,
  });

  final Widget body;
  final Widget? topBar;
  final Widget? bottomBar;
  final Widget? floatingAction;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.echoColors.canvas,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (topBar != null) topBar!,
          Expanded(child: body),
        ],
      ),
      bottomNavigationBar: bottomBar == null
          ? null
          : Padding(
              padding: EdgeInsets.only(
                bottom: context.echoShellBottomObstruction,
              ),
              child: bottomBar,
            ),
      floatingActionButton: floatingAction,
    );
  }
}

class EchoTopBar extends StatelessWidget {
  const EchoTopBar({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.actions = const <Widget>[],
    this.showDivider = false,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final List<Widget> actions;
  final bool showDivider;

  factory EchoTopBar.back({
    Key? key,
    required BuildContext context,
    required String title,
    String? subtitle,
    List<Widget> actions = const <Widget>[],
  }) {
    return EchoTopBar(
      key: key,
      title: title,
      subtitle: subtitle,
      leading: EchoIconButton(
        icon: AppIcons.back,
        label: '返回',
        onPressed: () => Navigator.maybePop(context),
      ),
      actions: actions,
    );
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.echoSpacing;
    final colors = context.echoColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.canvas,
        border: showDivider
            ? Border(bottom: BorderSide(color: colors.divider))
            : null,
      ),
      child: SafeArea(
        bottom: false,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 64),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
              leading == null ? spacing.md : spacing.xs,
              spacing.xs,
              actions.isEmpty ? spacing.md : spacing.xs,
              spacing.xs,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (leading != null) ...<Widget>[
                  leading!,
                  SizedBox(width: spacing.xs),
                ],
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Semantics(
                        header: true,
                        child: Text(
                          title,
                          style: context.echoTypography.headline,
                        ),
                      ),
                      if (subtitle != null &&
                          subtitle!.trim().isNotEmpty) ...<Widget>[
                        SizedBox(height: spacing.xxs),
                        Text(
                          subtitle!,
                          style: context.echoTypography.metadata.copyWith(
                            color: colors.muted,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (actions.isNotEmpty) ...<Widget>[
                  SizedBox(width: spacing.xs),
                  ...actions,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
