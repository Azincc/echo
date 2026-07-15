import 'package:flutter/material.dart';

import '../core/design/echo_design.dart';

@immutable
class EchoMediaAction {
  const EchoMediaAction({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final bool selected;
}

/// Shared action hierarchy for albums, artists, and playlists.
///
/// Play and shuffle remain labeled primary actions. Lower-frequency actions
/// are rendered as a separate icon toolbar so they do not compete with the
/// main listening decision.
class EchoMediaActions extends StatelessWidget {
  const EchoMediaActions({
    super.key,
    required this.onPlay,
    this.onShuffle,
    this.showShuffle = false,
    this.playLabel = '播放',
    this.shuffleLabel = '随机播放',
    this.playIcon = AppIcons.play,
    this.shuffleIcon = AppIcons.shuffle,
    this.secondaryActions = const <EchoMediaAction>[],
  });

  final VoidCallback? onPlay;
  final VoidCallback? onShuffle;

  /// Keeps the shuffle action in the hierarchy when [onShuffle] is null.
  final bool showShuffle;
  final String playLabel;
  final String shuffleLabel;
  final IconData playIcon;
  final IconData shuffleIcon;
  final List<EchoMediaAction> secondaryActions;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final scaledLabelSize = MediaQuery.textScalerOf(
          context,
        ).scale(context.echoTypography.label.fontSize ?? 13);
        final stackPrimaryActions =
            constraints.maxWidth < 340 || scaledLabelSize >= 20;

        final play = EchoButton.primary(
          label: playLabel,
          semanticLabel: playLabel,
          leadingIcon: playIcon,
          onPressed: onPlay,
          expand: true,
          enableHaptics: true,
        );
        final shuffle = EchoButton.secondary(
          label: shuffleLabel,
          semanticLabel: shuffleLabel,
          leadingIcon: shuffleIcon,
          onPressed: onShuffle,
          expand: true,
          enableHaptics: true,
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (!showShuffle && onShuffle == null)
              play
            else if (stackPrimaryActions) ...<Widget>[
              play,
              SizedBox(height: context.echoSpacing.xs),
              shuffle,
            ] else
              Row(
                children: <Widget>[
                  Expanded(child: play),
                  SizedBox(width: context.echoSpacing.sm),
                  Expanded(child: shuffle),
                ],
              ),
            if (secondaryActions.isNotEmpty) ...<Widget>[
              SizedBox(height: context.echoSpacing.sm),
              Wrap(
                spacing: context.echoSpacing.xs,
                runSpacing: context.echoSpacing.xs,
                children: <Widget>[
                  for (final action in secondaryActions)
                    EchoIconButton(
                      icon: action.icon,
                      label: action.label,
                      selected: action.selected,
                      onPressed: action.onPressed,
                      enableHaptics: true,
                    ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }
}
