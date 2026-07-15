import 'package:flutter/material.dart';

import '../../core/design/echo_design.dart';

@immutable
class EchoShellDestination {
  const EchoShellDestination({
    required this.branchIndex,
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final int branchIndex;
  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

class EchoCompactNavigation extends StatelessWidget {
  const EchoCompactNavigation({
    super.key,
    required this.destinations,
    required this.selectedBranchIndex,
    required this.onDestinationSelected,
  });

  final List<EchoShellDestination> destinations;
  final int selectedBranchIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.echoColors;
    final spacing = context.echoSpacing;

    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: '主导航',
      child: ColoredBox(
        key: const ValueKey<String>('echo-compact-navigation'),
        color: colors.surface,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: spacing.xs,
              vertical: spacing.xxs,
            ),
            child: Row(
              children: <Widget>[
                for (final destination in destinations)
                  Expanded(
                    child: _CompactDestination(
                      destination: destination,
                      selected: destination.branchIndex == selectedBranchIndex,
                      onPressed: () =>
                          onDestinationSelected(destination.branchIndex),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EchoMediumNavigationRail extends StatelessWidget {
  const EchoMediumNavigationRail({
    super.key,
    required this.destinations,
    required this.selectedBranchIndex,
    required this.onDestinationSelected,
    required this.onOpenDrawer,
  });

  final List<EchoShellDestination> destinations;
  final int selectedBranchIndex;
  final ValueChanged<int> onDestinationSelected;
  final VoidCallback onOpenDrawer;

  @override
  Widget build(BuildContext context) {
    final spacing = context.echoSpacing;

    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: '主导航',
      child: ColoredBox(
        key: const ValueKey<String>('echo-medium-navigation'),
        color: context.echoColors.surface,
        child: SafeArea(
          right: false,
          child: SizedBox(
            width: 112,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(spacing.xs),
                  child: EchoIconButton(
                    icon: AppIcons.menu,
                    label: '打开应用菜单',
                    onPressed: onOpenDrawer,
                  ),
                ),
                EchoDivider(inset: spacing.sm, endInset: spacing.sm),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: spacing.xs,
                      vertical: spacing.sm,
                    ),
                    itemCount: destinations.length,
                    itemBuilder: (context, index) {
                      final destination = destinations[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: spacing.xs),
                        child: _RailDestination(
                          destination: destination,
                          selected:
                              destination.branchIndex == selectedBranchIndex,
                          onPressed: () =>
                              onDestinationSelected(destination.branchIndex),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EchoExpandedNavigationSidebar extends StatelessWidget {
  const EchoExpandedNavigationSidebar({
    super.key,
    required this.destinations,
    required this.selectedBranchIndex,
    required this.onDestinationSelected,
    required this.onOpenDrawer,
  });

  final List<EchoShellDestination> destinations;
  final int selectedBranchIndex;
  final ValueChanged<int> onDestinationSelected;
  final VoidCallback onOpenDrawer;

  @override
  Widget build(BuildContext context) {
    final spacing = context.echoSpacing;

    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: '主导航',
      child: ColoredBox(
        key: const ValueKey<String>('echo-expanded-navigation'),
        color: context.echoColors.surface,
        child: SafeArea(
          right: false,
          child: SizedBox(
            width: 232,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    spacing.sm,
                    spacing.xs,
                    spacing.md,
                    spacing.xs,
                  ),
                  child: Row(
                    children: <Widget>[
                      EchoIconButton(
                        icon: AppIcons.menu,
                        label: '打开应用菜单',
                        onPressed: onOpenDrawer,
                      ),
                      SizedBox(width: spacing.sm),
                      Expanded(
                        child: Semantics(
                          header: true,
                          child: Text(
                            'Echo',
                            style: context.echoTypography.title,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                EchoDivider(inset: spacing.md, endInset: spacing.md),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: spacing.sm,
                      vertical: spacing.md,
                    ),
                    itemCount: destinations.length,
                    itemBuilder: (context, index) {
                      final destination = destinations[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: spacing.xs),
                        child: _SidebarDestination(
                          destination: destination,
                          selected:
                              destination.branchIndex == selectedBranchIndex,
                          onPressed: () =>
                              onDestinationSelected(destination.branchIndex),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CompactDestination extends StatelessWidget {
  const _CompactDestination({
    required this.destination,
    required this.selected,
    required this.onPressed,
  });

  final EchoShellDestination destination;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.echoColors;
    final spacing = context.echoSpacing;
    final motion = context.echoMotion;
    final foreground = selected ? colors.accent : colors.muted;

    return EchoPressable(
      semanticLabel: destination.label,
      selected: selected,
      onPressed: onPressed,
      enableHaptics: true,
      minimumSize: const Size(double.infinity, 64),
      borderRadius: context.echoRadii.control,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: spacing.xxs,
          vertical: spacing.xs,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              duration: motion.resolve(context, motion.state),
              curve: motion.easeOut,
              width: 48,
              height: 32,
              decoration: BoxDecoration(
                color: selected
                    ? colors.accent.withValues(alpha: 0.14)
                    : Colors.transparent,
                borderRadius: context.echoRadii.pill,
              ),
              child: Icon(
                selected ? destination.selectedIcon : destination.icon,
                size: context.echoInteraction.smallIconSize,
                color: foreground,
              ),
            ),
            SizedBox(height: spacing.xxs),
            Text(
              destination.label,
              textAlign: TextAlign.center,
              style: context.echoTypography.label.copyWith(
                color: foreground,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RailDestination extends StatelessWidget {
  const _RailDestination({
    required this.destination,
    required this.selected,
    required this.onPressed,
  });

  final EchoShellDestination destination;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.echoColors;
    final spacing = context.echoSpacing;
    final motion = context.echoMotion;
    final foreground = selected ? colors.accent : colors.muted;

    return EchoPressable(
      semanticLabel: destination.label,
      selected: selected,
      onPressed: onPressed,
      enableHaptics: true,
      minimumSize: const Size(double.infinity, 72),
      borderRadius: context.echoRadii.control,
      child: AnimatedContainer(
        duration: motion.resolve(context, motion.state),
        curve: motion.easeOut,
        padding: EdgeInsets.symmetric(
          horizontal: spacing.xxs,
          vertical: spacing.xs,
        ),
        decoration: BoxDecoration(
          color: selected
              ? colors.accent.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: context.echoRadii.control,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              selected ? destination.selectedIcon : destination.icon,
              size: context.echoInteraction.iconSize,
              color: foreground,
            ),
            SizedBox(height: spacing.xxs),
            Text(
              destination.label,
              textAlign: TextAlign.center,
              style: context.echoTypography.label.copyWith(
                color: foreground,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SidebarDestination extends StatelessWidget {
  const _SidebarDestination({
    required this.destination,
    required this.selected,
    required this.onPressed,
  });

  final EchoShellDestination destination;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.echoColors;
    final spacing = context.echoSpacing;
    final motion = context.echoMotion;
    final foreground = selected ? colors.accent : colors.ink;

    return EchoPressable(
      semanticLabel: destination.label,
      selected: selected,
      onPressed: onPressed,
      enableHaptics: true,
      minimumSize: const Size(double.infinity, 56),
      borderRadius: context.echoRadii.control,
      child: AnimatedContainer(
        duration: motion.resolve(context, motion.state),
        curve: motion.easeOut,
        padding: EdgeInsets.symmetric(
          horizontal: spacing.sm,
          vertical: spacing.xs,
        ),
        decoration: BoxDecoration(
          color: selected
              ? colors.accent.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: context.echoRadii.control,
        ),
        child: Row(
          children: <Widget>[
            SizedBox.square(
              dimension: context.echoInteraction.minimumTouchTarget,
              child: Center(
                child: Icon(
                  selected ? destination.selectedIcon : destination.icon,
                  size: context.echoInteraction.iconSize,
                  color: foreground,
                ),
              ),
            ),
            SizedBox(width: spacing.xs),
            Expanded(
              child: Text(
                destination.label,
                style: context.echoTypography.title.copyWith(
                  color: foreground,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
