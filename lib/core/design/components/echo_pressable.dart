import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../echo_context.dart';

/// Controls how [EchoPressable] exposes the semantics of its
/// [EchoPressable.child].
enum EchoPressableSemanticsMode {
  /// Exposes the pressable as one semantic node.
  ///
  /// When [EchoPressable.semanticLabel] is provided, descendant semantics are
  /// replaced by that label. This is the default for simple buttons and media
  /// rows, where announcing visible text a second time would be redundant.
  singleNode,

  /// Keeps semantic descendants as explicit nodes below the pressable.
  ///
  /// Use this for composite rows that contain independently actionable child
  /// controls. Descriptive content already covered by the parent label should
  /// be wrapped in [ExcludeSemantics] by the caller to avoid duplicate speech.
  explicitChildren,
}

/// Echo's shared interaction target.
///
/// Pointer feedback is delegated to [InkWell]. Keyboard activation is exposed
/// through Flutter's [Shortcuts] and [Actions] system, so a long-press-only
/// target still has an accessible keyboard path without changing its pointer
/// tap behavior.
class EchoPressable extends StatelessWidget {
  const EchoPressable({
    super.key,
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.semanticLabel,
    this.minimumSize = const Size.square(48),
    this.borderRadius,
    this.selected,
    this.toggled,
    this.semanticsMode = EchoPressableSemanticsMode.singleNode,
    this.enableHaptics = false,
    this.autofocus = false,
  }) : assert(
         semanticsMode != EchoPressableSemanticsMode.explicitChildren ||
             semanticLabel != null,
         'explicitChildren requires a semanticLabel for the parent node.',
       );

  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final String? semanticLabel;
  final Size minimumSize;
  final BorderRadius? borderRadius;
  final bool? selected;
  final bool? toggled;
  final EchoPressableSemanticsMode semanticsMode;
  final bool enableHaptics;
  final bool autofocus;

  static const Map<ShortcutActivator, Intent> _shortcuts =
      <ShortcutActivator, Intent>{
        SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
        SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
      };

  @override
  Widget build(BuildContext context) {
    final interactive = onPressed != null || onLongPress != null;
    final radius = borderRadius ?? context.echoRadii.control;
    final motion = context.echoMotion;
    final colors = context.echoColors;
    final interaction = context.echoInteraction;
    final hasExplicitChildren =
        semanticsMode == EchoPressableSemanticsMode.explicitChildren;
    final exposesControlRole = !hasExplicitChildren || interactive;
    final visuallyEnabled = interactive || hasExplicitChildren;

    Widget target = ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minimumSize.width.isFinite ? minimumSize.width : 0,
        minHeight: minimumSize.height.isFinite ? minimumSize.height : 0,
      ),
      child: child,
    );
    if (!minimumSize.width.isFinite) {
      target = SizedBox(width: double.infinity, child: target);
    }
    if (!minimumSize.height.isFinite) {
      target = SizedBox(height: double.infinity, child: target);
    }

    return Semantics(
      container: true,
      explicitChildNodes: hasExplicitChildren,
      excludeSemantics:
          semanticLabel != null &&
          semanticsMode == EchoPressableSemanticsMode.singleNode,
      button: exposesControlRole,
      enabled: interactive ? true : (exposesControlRole ? false : null),
      focusable: interactive,
      selected: selected,
      toggled: toggled,
      label: semanticLabel,
      onTap: onPressed,
      onLongPress: onLongPress,
      child: Shortcuts(
        shortcuts: _shortcuts,
        child: Actions(
          actions: <Type, Action<Intent>>{
            ActivateIntent: CallbackAction<ActivateIntent>(
              onInvoke: (intent) {
                final action = onPressed ?? onLongPress;
                if (action != null) _invoke(action);
                return null;
              },
            ),
          },
          child: _EchoPressableFocus(
            canRequestFocus: interactive,
            autofocus: autofocus && interactive,
            builder: (focusContext, showFocusHighlight) {
              final focusColor = showFocusHighlight
                  ? colors.accent
                  : Colors.transparent;

              return AnimatedOpacity(
                duration: motion.resolve(context, motion.feedback),
                curve: motion.easeOut,
                opacity: visuallyEnabled ? 1 : 0.5,
                child: AnimatedContainer(
                  duration: motion.resolve(context, motion.feedback),
                  curve: motion.easeOut,
                  foregroundDecoration: BoxDecoration(
                    borderRadius: radius,
                    border: Border.all(
                      color: focusColor,
                      width: interaction.focusRingWidth,
                    ),
                  ),
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: onPressed == null
                          ? null
                          : () => _invoke(onPressed!),
                      onLongPress: onLongPress == null
                          ? null
                          : () => _invoke(onLongPress!),
                      canRequestFocus: false,
                      excludeFromSemantics: true,
                      borderRadius: radius,
                      splashFactory: NoSplash.splashFactory,
                      mouseCursor: interactive
                          ? SystemMouseCursors.click
                          : SystemMouseCursors.basic,
                      overlayColor: WidgetStateProperty.resolveWith<Color?>((
                        states,
                      ) {
                        if (!interactive) return Colors.transparent;
                        if (states.contains(WidgetState.pressed)) {
                          return colors.accent.withValues(alpha: 0.14);
                        }
                        if (states.contains(WidgetState.hovered)) {
                          return colors.accent.withValues(alpha: 0.08);
                        }
                        return Colors.transparent;
                      }),
                      child: target,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _invoke(VoidCallback action) {
    if (enableHaptics) HapticFeedback.selectionClick();
    action();
  }
}

class _EchoPressableFocus extends StatefulWidget {
  const _EchoPressableFocus({
    required this.canRequestFocus,
    required this.autofocus,
    required this.builder,
  });

  final bool canRequestFocus;
  final bool autofocus;
  final Widget Function(BuildContext context, bool showFocusHighlight) builder;

  @override
  State<_EchoPressableFocus> createState() => _EchoPressableFocusState();
}

class _EchoPressableFocusState extends State<_EchoPressableFocus> {
  late final FocusNode _focusNode;
  late FocusHighlightMode _highlightMode;
  bool _hasPrimaryFocus = false;
  bool _listeningForHighlightMode = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode(debugLabel: 'EchoPressable')
      ..addListener(_handleFocusNodeChange);
    _highlightMode = FocusManager.instance.highlightMode;
  }

  @override
  void dispose() {
    if (_listeningForHighlightMode) {
      FocusManager.instance.removeHighlightModeListener(
        _handleHighlightModeChange,
      );
    }
    _focusNode
      ..removeListener(_handleFocusNodeChange)
      ..dispose();
    super.dispose();
  }

  void _handleFocusNodeChange() {
    final hasPrimaryFocus = _focusNode.hasPrimaryFocus;
    if (_hasPrimaryFocus == hasPrimaryFocus) return;

    if (hasPrimaryFocus) {
      _highlightMode = FocusManager.instance.highlightMode;
      FocusManager.instance.addHighlightModeListener(
        _handleHighlightModeChange,
      );
      _listeningForHighlightMode = true;
    } else if (_listeningForHighlightMode) {
      FocusManager.instance.removeHighlightModeListener(
        _handleHighlightModeChange,
      );
      _listeningForHighlightMode = false;
    }

    setState(() => _hasPrimaryFocus = hasPrimaryFocus);
  }

  void _handleHighlightModeChange(FocusHighlightMode highlightMode) {
    if (_highlightMode == highlightMode) return;
    setState(() => _highlightMode = highlightMode);
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      canRequestFocus: widget.canRequestFocus,
      autofocus: widget.autofocus,
      child: Builder(
        builder: (focusContext) => widget.builder(
          focusContext,
          _hasPrimaryFocus && _highlightMode == FocusHighlightMode.traditional,
        ),
      ),
    );
  }
}
