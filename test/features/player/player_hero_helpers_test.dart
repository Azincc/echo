import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/features/player/widgets/player_hero_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('keeps the established Hero tag contract', () {
    expect(playerBackgroundHeroTag, 'player-background');
    expect(playerCoverHeroTag, 'player-cover');
    expect(playerTitleHeroTag, 'player-title');
    expect(playerSubtitleHeroTag, 'player-subtitle');
    expect(
      playerCoverRectTween(Rect.zero, const Rect.fromLTWH(0, 0, 10, 10)),
      isA<MaterialRectCenterArcTween>(),
    );
  });

  testWidgets('album surfaces preserve text contrast in light and dark modes', (
    tester,
  ) async {
    for (final theme in <ThemeData>[AppTheme.light(), AppTheme.dark()]) {
      late Color miniSurface;
      late Color stageSurface;
      late EchoColors colors;
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Builder(
            builder: (context) {
              colors = context.echoColors;
              miniSurface = playerMiniSurfaceColor(
                context,
                const Color(0xFFFFFF00),
              );
              stageSurface = playerStageColor(context, const Color(0xFF00E5FF));
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(
        EchoColors.contrastRatio(colors.ink, miniSurface),
        greaterThanOrEqualTo(4.5),
      );
      expect(
        EchoColors.contrastRatio(Colors.white, stageSurface),
        greaterThanOrEqualTo(7),
      );
    }
  });
}
