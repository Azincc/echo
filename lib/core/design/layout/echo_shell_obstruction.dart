import 'package:flutter/widgets.dart';

/// Exposes the vertical space occupied by Echo's bottom shell chrome.
///
/// Compact pages can use this value to keep their final interactive content
/// clear of the overlaid MiniPlayer and navigation while still painting behind
/// the transparent MiniPlayer gutter. Outside an [EchoShellObstructionScope],
/// the obstruction is zero.
class EchoShellObstructionScope extends InheritedWidget {
  const EchoShellObstructionScope({
    super.key,
    required this.bottom,
    required super.child,
  }) : assert(bottom >= 0);

  final double bottom;

  static double of(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<EchoShellObstructionScope>()
            ?.bottom ??
        0;
  }

  @override
  bool updateShouldNotify(EchoShellObstructionScope oldWidget) {
    return bottom != oldWidget.bottom;
  }
}

extension EchoShellObstructionContext on BuildContext {
  /// Height of the bottom chrome currently covering this shell's body.
  double get echoShellBottomObstruction => EchoShellObstructionScope.of(this);
}
