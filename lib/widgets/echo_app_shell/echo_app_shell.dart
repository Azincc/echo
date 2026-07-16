import 'package:flutter/material.dart';

import '../../core/design/echo_design.dart';
import 'echo_network_status_bar.dart';
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
    this.networkStatus = EchoNetworkStatus.online,
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
  final EchoNetworkStatus networkStatus;
  final VoidCallback? onOpenDrawer;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final windowClass = context.echoBreakpoints.classify(width);
    final colors = context.echoColors;
    final networkStatusBar = EchoNetworkStatusBar(
      status: networkStatus,
      includeBottomSafeArea:
          windowClass != EchoWindowClass.compact && !showMiniPlayer,
    );

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: colors.canvas,
      extendBody: windowClass == EchoWindowClass.compact,
      drawer: drawer,
      drawerScrimColor: colors.scrim,
      body: switch (windowClass) {
        EchoWindowClass.compact => _CompactShellBody(
          color: colors.canvas,
          body: body,
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
          networkStatusBar: networkStatusBar,
        ),
      },
      bottomNavigationBar: windowClass == EchoWindowClass.compact
          ? Column(
              key: const ValueKey<String>('echo-compact-bottom-chrome'),
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                networkStatusBar,
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

class _CompactShellBody extends StatelessWidget {
  const _CompactShellBody({required this.color, required this.body});

  final Color color;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return EchoShellObstructionScope(
      bottom: mediaQuery.padding.bottom,
      child: MediaQuery(
        data: mediaQuery.removePadding(removeBottom: true),
        child: ColoredBox(
          key: const ValueKey<String>('echo-shell-content'),
          color: color,
          child: body,
        ),
      ),
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
    final spacing = context.echoSpacing;

    return SizedBox(
      key: const ValueKey<String>('echo-mini-player-slot'),
      width: double.infinity,
      child: ClipRect(
        child: AnimatedSize(
          alignment: Alignment.topCenter,
          duration: motion.resolve(context, motion.state),
          curve: motion.easeOut,
          child: visible
              ? Listener(
                  key: const ValueKey<String>(
                    'echo-mini-player-pointer-shield',
                  ),
                  behavior: HitTestBehavior.opaque,
                  child: SafeArea(
                    top: false,
                    bottom: includeBottomSafeArea,
                    child: Padding(
                      key: const ValueKey<String>('echo-mini-player-chrome'),
                      padding: EdgeInsets.fromLTRB(
                        spacing.sm,
                        spacing.xs,
                        spacing.sm,
                        spacing.xxs,
                      ),
                      child: child,
                    ),
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
    required this.networkStatusBar,
  });

  final EchoWindowClass windowClass;
  final List<EchoShellDestination> destinations;
  final int selectedBranchIndex;
  final ValueChanged<int> onDestinationSelected;
  final VoidCallback onOpenDrawer;
  final Widget body;
  final Widget miniPlayer;
  final bool showMiniPlayer;
  final Widget networkStatusBar;

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
        Expanded(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ColoredBox(
                  key: const ValueKey<String>('echo-shell-content'),
                  color: context.echoColors.canvas,
                  child: EchoShellObstructionScope(bottom: 0, child: body),
                ),
              ),
              networkStatusBar,
              EchoMiniPlayerSlot(visible: showMiniPlayer, child: miniPlayer),
            ],
          ),
        ),
      ],
    );
  }
}
