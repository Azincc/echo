import 'package:flutter/material.dart';

import '../../core/design/echo_design.dart';
import 'echo_shell_navigation.dart';

class EchoAppShell extends StatelessWidget {
  const EchoAppShell({
    super.key,
    required this.scaffoldKey,
    required this.body,
    required this.drawer,
    required this.destinations,
    required this.selectedBranchIndex,
    required this.onDestinationSelected,
    required this.miniPlayer,
    required this.showMiniPlayer,
    this.onOpenDrawer,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final Widget body;
  final Widget drawer;
  final List<EchoShellDestination> destinations;
  final int selectedBranchIndex;
  final ValueChanged<int> onDestinationSelected;
  final Widget miniPlayer;
  final bool showMiniPlayer;
  final VoidCallback? onOpenDrawer;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final windowClass = context.echoBreakpoints.classify(width);
    final colors = context.echoColors;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: colors.canvas,
      drawer: drawer,
      drawerScrimColor: colors.scrim,
      body: switch (windowClass) {
        EchoWindowClass.compact => ColoredBox(
          key: const ValueKey<String>('echo-shell-content'),
          color: colors.canvas,
          child: body,
        ),
        EchoWindowClass.medium || EchoWindowClass.expanded => _WideShellBody(
          windowClass: windowClass,
          destinations: destinations,
          selectedBranchIndex: selectedBranchIndex,
          onDestinationSelected: onDestinationSelected,
          onOpenDrawer:
              onOpenDrawer ?? () => scaffoldKey.currentState?.openDrawer(),
          body: body,
          miniPlayer: miniPlayer,
          showMiniPlayer: showMiniPlayer,
        ),
      },
      bottomNavigationBar: windowClass == EchoWindowClass.compact
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                EchoMiniPlayerSlot(
                  visible: showMiniPlayer,
                  includeBottomSafeArea: false,
                  child: miniPlayer,
                ),
                EchoCompactNavigation(
                  destinations: destinations,
                  selectedBranchIndex: selectedBranchIndex,
                  onDestinationSelected: onDestinationSelected,
                ),
              ],
            )
          : null,
    );
  }
}

class EchoMiniPlayerSlot extends StatelessWidget {
  const EchoMiniPlayerSlot({
    super.key,
    required this.visible,
    required this.child,
    this.includeBottomSafeArea = true,
  });

  final bool visible;
  final Widget child;
  final bool includeBottomSafeArea;

  @override
  Widget build(BuildContext context) {
    final motion = context.echoMotion;

    return SizedBox(
      key: const ValueKey<String>('echo-mini-player-slot'),
      width: double.infinity,
      child: ClipRect(
        child: AnimatedSize(
          alignment: Alignment.topCenter,
          duration: motion.resolve(context, motion.state),
          curve: motion.easeOut,
          child: visible
              ? ColoredBox(
                  color: context.echoColors.surface,
                  child: SafeArea(
                    top: false,
                    bottom: includeBottomSafeArea,
                    child: child,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}

class _WideShellBody extends StatelessWidget {
  const _WideShellBody({
    required this.windowClass,
    required this.destinations,
    required this.selectedBranchIndex,
    required this.onDestinationSelected,
    required this.onOpenDrawer,
    required this.body,
    required this.miniPlayer,
    required this.showMiniPlayer,
  });

  final EchoWindowClass windowClass;
  final List<EchoShellDestination> destinations;
  final int selectedBranchIndex;
  final ValueChanged<int> onDestinationSelected;
  final VoidCallback onOpenDrawer;
  final Widget body;
  final Widget miniPlayer;
  final bool showMiniPlayer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (windowClass == EchoWindowClass.medium)
          EchoMediumNavigationRail(
            destinations: destinations,
            selectedBranchIndex: selectedBranchIndex,
            onDestinationSelected: onDestinationSelected,
            onOpenDrawer: onOpenDrawer,
          )
        else
          EchoExpandedNavigationSidebar(
            destinations: destinations,
            selectedBranchIndex: selectedBranchIndex,
            onDestinationSelected: onDestinationSelected,
            onOpenDrawer: onOpenDrawer,
          ),
        const EchoDivider(axis: Axis.vertical),
        Expanded(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ColoredBox(
                  key: const ValueKey<String>('echo-shell-content'),
                  color: context.echoColors.canvas,
                  child: body,
                ),
              ),
              EchoMiniPlayerSlot(visible: showMiniPlayer, child: miniPlayer),
            ],
          ),
        ),
      ],
    );
  }
}
