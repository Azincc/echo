import 'package:flutter/material.dart';

import '../core/theme/app_icons.dart';
import 'music_chrome.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MusicIconButton(
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      icon: AppIcons.arrow_back_ios_new,
      margin: const EdgeInsets.only(left: 8),
      onPressed: () => Navigator.maybePop(context),
    );
  }
}
