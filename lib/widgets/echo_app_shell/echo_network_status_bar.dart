import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/design/echo_design.dart';

/// The reachability states surfaced by Echo's application shell.
///
/// [online] is intentionally quiet. The shell only becomes visible when the
/// connection affects remote work, then briefly confirms recovery.
enum EchoNetworkStatus { online, weak, offline }

enum _EchoNetworkBannerState { hidden, weak, offline, restored }

/// A layout-bound network status strip that preserves already loaded content.
///
/// This is deliberately not a Material banner or snackbar. It uses Echo's
/// semantic colors, typography, spacing, motion, and icon vocabulary while
/// remaining inside the shell's normal layout flow.
class EchoNetworkStatusBar extends StatefulWidget {
  const EchoNetworkStatusBar({
    super.key,
    required this.status,
    this.recoveryDisplayDuration = const Duration(seconds: 3),
    this.includeBottomSafeArea = false,
  });

  final EchoNetworkStatus status;
  final Duration recoveryDisplayDuration;
  final bool includeBottomSafeArea;

  @override
  State<EchoNetworkStatusBar> createState() => _EchoNetworkStatusBarState();
}

class _EchoNetworkStatusBarState extends State<EchoNetworkStatusBar> {
  Timer? _recoveryTimer;
  late _EchoNetworkBannerState _bannerState;

  @override
  void initState() {
    super.initState();
    _bannerState = _stateForStatus(widget.status);
  }

  @override
  void didUpdateWidget(covariant EchoNetworkStatusBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.status == widget.status) return;

    _recoveryTimer?.cancel();
    if (widget.status == EchoNetworkStatus.online &&
        oldWidget.status != EchoNetworkStatus.online) {
      _showRecovery();
      return;
    }

    setState(() {
      _bannerState = _stateForStatus(widget.status);
    });
  }

  @override
  void dispose() {
    _recoveryTimer?.cancel();
    super.dispose();
  }

  void _showRecovery() {
    setState(() {
      _bannerState = _EchoNetworkBannerState.restored;
    });
    _recoveryTimer = Timer(widget.recoveryDisplayDuration, () {
      if (!mounted || widget.status != EchoNetworkStatus.online) return;
      setState(() {
        _bannerState = _EchoNetworkBannerState.hidden;
      });
    });
  }

  static _EchoNetworkBannerState _stateForStatus(EchoNetworkStatus status) {
    return switch (status) {
      EchoNetworkStatus.online => _EchoNetworkBannerState.hidden,
      EchoNetworkStatus.weak => _EchoNetworkBannerState.weak,
      EchoNetworkStatus.offline => _EchoNetworkBannerState.offline,
    };
  }

  @override
  Widget build(BuildContext context) {
    final motion = context.echoMotion;
    final duration = motion.resolve(context, motion.state);

    return SizedBox(
      key: const ValueKey<String>('echo-network-status-slot'),
      width: double.infinity,
      child: ClipRect(
        child: AnimatedSize(
          alignment: Alignment.bottomCenter,
          duration: duration,
          curve: motion.easeOut,
          child: _bannerState == _EchoNetworkBannerState.hidden
              ? const SizedBox.shrink()
              : AnimatedSwitcher(
                  duration: duration,
                  switchInCurve: motion.easeOut,
                  switchOutCurve: motion.easeOut,
                  child: _EchoNetworkStatusContent(
                    key: ValueKey<_EchoNetworkBannerState>(_bannerState),
                    state: _bannerState,
                    includeBottomSafeArea: widget.includeBottomSafeArea,
                  ),
                ),
        ),
      ),
    );
  }
}

class _EchoNetworkStatusContent extends StatelessWidget {
  const _EchoNetworkStatusContent({
    super.key,
    required this.state,
    required this.includeBottomSafeArea,
  });

  final _EchoNetworkBannerState state;
  final bool includeBottomSafeArea;

  @override
  Widget build(BuildContext context) {
    final colors = context.echoColors;
    final isRestored = state == _EchoNetworkBannerState.restored;
    final statusColor = isRestored ? colors.accent : colors.warning;
    final background = Color.alphaBlend(
      statusColor.withValues(
        alpha: Theme.of(context).brightness == Brightness.dark ? 0.2 : 0.12,
      ),
      colors.surface,
    );
    final iconColor = EchoColors.ensureColorContrast(
      statusColor,
      background: background,
      minimumRatio: 3,
    );
    final titleColor = EchoColors.ensureColorContrast(
      colors.ink,
      background: background,
    );
    final descriptionColor = EchoColors.ensureColorContrast(
      colors.muted,
      background: background,
    );
    final presentation = _presentationFor(state);
    final semanticsLabel = '${presentation.title}。${presentation.description}';

    return Semantics(
      key: ValueKey<String>('echo-network-status-${state.name}'),
      container: true,
      liveRegion: true,
      label: semanticsLabel,
      child: ExcludeSemantics(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.echoSpacing.sm),
          child: EchoSurface(
            key: const ValueKey<String>('echo-network-status-surface'),
            level: EchoSurfaceLevel.surface,
            color: background,
            borderRadius: context.echoRadii.surface,
            child: SafeArea(
              top: false,
              bottom: includeBottomSafeArea,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                  context.echoPageHorizontalPadding,
                  context.echoSpacing.xs,
                  context.echoPageHorizontalPadding,
                  context.echoSpacing.xs,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: context.echoSpacing.xxs / 2,
                      ),
                      child: Icon(
                        presentation.icon,
                        size: 20,
                        color: iconColor,
                      ),
                    ),
                    SizedBox(width: context.echoSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            presentation.title,
                            style: context.echoTypography.label.copyWith(
                              color: titleColor,
                            ),
                          ),
                          SizedBox(height: context.echoSpacing.xxs),
                          Text(
                            presentation.description,
                            style: context.echoTypography.metadata.copyWith(
                              color: descriptionColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static _EchoNetworkPresentation _presentationFor(
    _EchoNetworkBannerState state,
  ) {
    return switch (state) {
      _EchoNetworkBannerState.weak => const _EchoNetworkPresentation(
        title: '网络不稳定',
        description: '正在重试可用线路，已加载内容和离线歌曲仍可使用',
        icon: AppIcons.signal,
      ),
      _EchoNetworkBannerState.offline => const _EchoNetworkPresentation(
        title: '当前离线',
        description: '已加载内容和离线歌曲仍可使用，在线操作将在联网后恢复',
        icon: AppIcons.wifiOff,
      ),
      _EchoNetworkBannerState.restored => const _EchoNetworkPresentation(
        title: '网络已恢复',
        description: '已重新连接可用线路',
        icon: AppIcons.checkCircle,
      ),
      _EchoNetworkBannerState.hidden => throw StateError(
        'Hidden network state has no visible presentation.',
      ),
    };
  }
}

class _EchoNetworkPresentation {
  const _EchoNetworkPresentation({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;
}
