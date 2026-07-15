import 'package:flutter/material.dart';

import '../tokens/echo_colors.dart';
import '../tokens/echo_typography.dart';
import 'echo_media_visuals.dart';

enum EchoMediaSurfaceRole { stage, mini, panel }

/// Installs artwork-derived Echo tokens for one media-led subtree.
///
/// Spacing, radii, motion, breakpoints, and interaction extensions are kept
/// from the parent theme. Only colour and typography semantics are replaced.
class EchoMediaColorScope extends StatelessWidget {
  const EchoMediaColorScope({
    super.key,
    required this.visuals,
    required this.role,
    required this.child,
  });

  final EchoMediaVisuals visuals;
  final EchoMediaSurfaceRole role;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final parentTheme = Theme.of(context);
    final parentColors =
        parentTheme.extension<EchoColors>() ??
        (parentTheme.brightness == Brightness.dark
            ? EchoColors.dark()
            : EchoColors.light());
    final parentTypography =
        parentTheme.extension<EchoTypography>() ??
        EchoTypography.standard(parentColors);
    final colors = _mediaColors(parentColors, visuals, role);
    final typography = _mediaTypography(parentTypography, colors);
    final extensions =
        List<ThemeExtension<dynamic>>.of(parentTheme.extensions.values)
          ..removeWhere(
            (extension) =>
                extension is EchoColors || extension is EchoTypography,
          );
    extensions.addAll(<ThemeExtension<dynamic>>[colors, typography]);

    return Theme(
      data: parentTheme.copyWith(extensions: extensions),
      child: child,
    );
  }
}

EchoColors _mediaColors(
  EchoColors parent,
  EchoMediaVisuals visuals,
  EchoMediaSurfaceRole role,
) {
  final (canvas, surface, raised) = switch (role) {
    EchoMediaSurfaceRole.stage => (
      visuals.stageBase,
      visuals.stageBase,
      visuals.stageGlow,
    ),
    EchoMediaSurfaceRole.mini => (
      visuals.miniSurface,
      visuals.miniSurface,
      visuals.panelSurface,
    ),
    EchoMediaSurfaceRole.panel => (
      visuals.panelSurface,
      visuals.panelSurface,
      visuals.miniSurface,
    ),
  };
  final mediaSurfaces = <Color>[
    visuals.stageBase,
    visuals.stageGlow,
    visuals.stageBottom,
    visuals.miniSurface,
    visuals.panelSurface,
  ];
  final error = EchoColors.ensureColorContrastAcross(
    parent.error,
    backgrounds: mediaSurfaces,
  );
  final warning = EchoColors.ensureColorContrastAcross(
    parent.warning,
    backgrounds: mediaSurfaces,
  );
  final divider = EchoColors.ensureColorContrastAcross(
    parent.divider,
    backgrounds: mediaSurfaces,
    minimumRatio: 3,
  );
  final onDisabled = EchoColors.ensureColorContrastAcross(
    Color.lerp(visuals.mutedForeground, surface, 0.18)!,
    backgrounds: mediaSurfaces,
    minimumRatio: 3,
  );
  final onAccent = EchoColors.ensureColorContrast(
    EchoColors.readableOn(visuals.controlAccent),
    background: visuals.controlAccent,
  );

  return parent.copyWith(
    accent: visuals.controlAccent,
    onAccent: onAccent,
    contentTint: visuals.controlAccent,
    onContentTint: onAccent,
    canvas: canvas,
    surface: surface,
    raised: raised,
    ink: visuals.foreground,
    muted: visuals.mutedForeground,
    divider: divider,
    controlBoundary: visuals.controlAccent,
    error: error,
    onError: EchoColors.readableOn(error),
    warning: warning,
    onWarning: EchoColors.readableOn(warning),
    disabled: raised,
    onDisabled: onDisabled,
  );
}

EchoTypography _mediaTypography(EchoTypography parent, EchoColors colors) {
  return parent.copyWith(
    display: parent.display.copyWith(color: colors.ink),
    headline: parent.headline.copyWith(color: colors.ink),
    title: parent.title.copyWith(color: colors.ink),
    body: parent.body.copyWith(color: colors.ink),
    label: parent.label.copyWith(color: colors.ink),
    metadata: parent.metadata.copyWith(color: colors.muted),
  );
}
