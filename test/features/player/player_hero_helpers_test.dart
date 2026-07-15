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
}
