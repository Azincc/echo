import 'package:flutter/material.dart';

import '../core/theme/app_icons.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      icon: const Icon(AppIcons.arrow_back_ios_new),
      onPressed: () => Navigator.maybePop(context),
    );
  }
}
