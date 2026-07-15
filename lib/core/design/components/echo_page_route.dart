import 'package:flutter/material.dart';

import '../echo_context.dart';

/// Echo's spatial page transition for imperative navigation.
///
/// The route resolves its durations before it is pushed, so a system request
/// for reduced motion becomes an actual jump cut instead of an invisible wait.
class EchoPageRoute<T> extends PageRouteBuilder<T> {
  // Explicit parameters keep the context-derived route setup in one initializer.
  // ignore: use_super_parameters
  EchoPageRoute({
    required BuildContext context,
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool fullscreenDialog = false,
  }) : super(
         settings: settings,
         fullscreenDialog: fullscreenDialog,
         transitionDuration: context.echoMotion.resolve(
           context,
           context.echoMotion.scene,
         ),
         reverseTransitionDuration: context.echoMotion.resolve(
           context,
           context.echoMotion.state,
         ),
         pageBuilder: (context, animation, secondaryAnimation) {
           return builder(context);
         },
         transitionsBuilder: _buildTransitions,
       );

  static Widget _buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (context.echoMotion.resolve(context, context.echoMotion.scene) ==
        Duration.zero) {
      return child;
    }

    final direction = Directionality.of(context) == TextDirection.ltr
        ? 1.0
        : -1.0;
    final curved = CurvedAnimation(
      parent: animation,
      curve: context.echoMotion.sceneCurve,
      reverseCurve: context.echoMotion.easeOut,
    );

    return FadeTransition(
      opacity: Tween<double>(begin: 0.86, end: 1).animate(curved),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0.035 * direction, 0),
          end: Offset.zero,
        ).animate(curved),
        child: child,
      ),
    );
  }
}

/// Declarative counterpart used by GoRouter page builders.
class EchoTransitionPage<T> extends Page<T> {
  const EchoTransitionPage({
    required this.child,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) {
    return EchoPageRoute<T>(
      context: context,
      settings: this,
      builder: (context) => child,
    );
  }
}
