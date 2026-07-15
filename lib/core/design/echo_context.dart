import 'package:flutter/material.dart';

import 'tokens/echo_breakpoints.dart';
import 'tokens/echo_colors.dart';
import 'tokens/echo_interaction.dart';
import 'tokens/echo_motion.dart';
import 'tokens/echo_radii.dart';
import 'tokens/echo_spacing.dart';
import 'tokens/echo_typography.dart';

/// Typed access to Echo's semantic design vocabulary.
extension EchoDesignContext on BuildContext {
  EchoColors get echoColors {
    final theme = Theme.of(this);
    return theme.extension<EchoColors>() ??
        (theme.brightness == Brightness.dark
            ? EchoColors.dark()
            : EchoColors.light());
  }

  EchoTypography get echoTypography {
    return Theme.of(this).extension<EchoTypography>() ??
        EchoTypography.standard(echoColors);
  }

  EchoSpacing get echoSpacing {
    return Theme.of(this).extension<EchoSpacing>() ?? EchoSpacing.standard;
  }

  EchoRadii get echoRadii {
    return Theme.of(this).extension<EchoRadii>() ?? EchoRadii.standard;
  }

  EchoMotion get echoMotion {
    return Theme.of(this).extension<EchoMotion>() ?? EchoMotion.standard;
  }

  EchoInteraction get echoInteraction {
    return Theme.of(this).extension<EchoInteraction>() ??
        EchoInteraction.standard;
  }

  EchoBreakpoints get echoBreakpoints {
    return Theme.of(this).extension<EchoBreakpoints>() ??
        EchoBreakpoints.standard;
  }

  bool get echoReduceMotion {
    final mediaQuery = MediaQuery.maybeOf(this);
    return mediaQuery?.disableAnimations ??
        WidgetsBinding
            .instance
            .platformDispatcher
            .accessibilityFeatures
            .disableAnimations;
  }

  EchoWindowClass get echoWindowClass {
    final width = MediaQuery.maybeSizeOf(this)?.width ?? 0;
    return echoBreakpoints.classify(width);
  }

  double get echoPageHorizontalPadding {
    return switch (echoWindowClass) {
      EchoWindowClass.compact => echoSpacing.md,
      EchoWindowClass.medium => echoSpacing.lg,
      EchoWindowClass.expanded => echoSpacing.xl,
    };
  }
}
