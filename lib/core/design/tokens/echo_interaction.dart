import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

/// Shared physical metrics for touch, focus, and high-frequency media rows.
@immutable
class EchoInteraction extends ThemeExtension<EchoInteraction> {
  const EchoInteraction({
    required this.minimumTouchTarget,
    required this.buttonHeight,
    required this.inputHeight,
    required this.songRowHeight,
    required this.expandedSongRowHeight,
    required this.iconSize,
    required this.smallIconSize,
    required this.focusRingWidth,
    required this.pressedScale,
    required this.disabledOpacity,
  });

  static const EchoInteraction standard = EchoInteraction(
    minimumTouchTarget: 48,
    buttonHeight: 48,
    inputHeight: 48,
    songRowHeight: 64,
    expandedSongRowHeight: 72,
    iconSize: 24,
    smallIconSize: 22,
    focusRingWidth: 2,
    pressedScale: 0.98,
    disabledOpacity: 0.56,
  );

  final double minimumTouchTarget;
  final double buttonHeight;
  final double inputHeight;
  final double songRowHeight;
  final double expandedSongRowHeight;
  final double iconSize;
  final double smallIconSize;
  final double focusRingWidth;
  final double pressedScale;
  final double disabledOpacity;

  Size get minimumTouchSize => Size.square(minimumTouchTarget);

  @override
  EchoInteraction copyWith({
    double? minimumTouchTarget,
    double? buttonHeight,
    double? inputHeight,
    double? songRowHeight,
    double? expandedSongRowHeight,
    double? iconSize,
    double? smallIconSize,
    double? focusRingWidth,
    double? pressedScale,
    double? disabledOpacity,
  }) {
    return EchoInteraction(
      minimumTouchTarget: minimumTouchTarget ?? this.minimumTouchTarget,
      buttonHeight: buttonHeight ?? this.buttonHeight,
      inputHeight: inputHeight ?? this.inputHeight,
      songRowHeight: songRowHeight ?? this.songRowHeight,
      expandedSongRowHeight:
          expandedSongRowHeight ?? this.expandedSongRowHeight,
      iconSize: iconSize ?? this.iconSize,
      smallIconSize: smallIconSize ?? this.smallIconSize,
      focusRingWidth: focusRingWidth ?? this.focusRingWidth,
      pressedScale: pressedScale ?? this.pressedScale,
      disabledOpacity: disabledOpacity ?? this.disabledOpacity,
    );
  }

  @override
  EchoInteraction lerp(covariant EchoInteraction? other, double t) {
    if (other == null) {
      return this;
    }
    return EchoInteraction(
      minimumTouchTarget: lerpDouble(
        minimumTouchTarget,
        other.minimumTouchTarget,
        t,
      )!,
      buttonHeight: lerpDouble(buttonHeight, other.buttonHeight, t)!,
      inputHeight: lerpDouble(inputHeight, other.inputHeight, t)!,
      songRowHeight: lerpDouble(songRowHeight, other.songRowHeight, t)!,
      expandedSongRowHeight: lerpDouble(
        expandedSongRowHeight,
        other.expandedSongRowHeight,
        t,
      )!,
      iconSize: lerpDouble(iconSize, other.iconSize, t)!,
      smallIconSize: lerpDouble(smallIconSize, other.smallIconSize, t)!,
      focusRingWidth: lerpDouble(focusRingWidth, other.focusRingWidth, t)!,
      pressedScale: lerpDouble(pressedScale, other.pressedScale, t)!,
      disabledOpacity: lerpDouble(disabledOpacity, other.disabledOpacity, t)!,
    );
  }
}
