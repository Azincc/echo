import 'dart:io';

import 'package:echoes/core/theme/app_icons.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AppIcons covers every semantic name used by production code', () {
    final declarations = _matches(
      File('lib/core/theme/app_icons.dart').readAsStringSync(),
      RegExp(r'static const ([A-Za-z][A-Za-z0-9]*)\s*='),
    );

    final usages = <String>{};
    for (final entity in Directory('lib').listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      if (entity.path
          .replaceAll('\\', '/')
          .endsWith('lib/core/theme/app_icons.dart')) {
        continue;
      }
      usages.addAll(
        _matches(
          entity.readAsStringSync(),
          RegExp(r'AppIcons\.([A-Za-z][A-Za-z0-9]*)'),
        ),
      );
    }

    expect(
      usages.difference(declarations),
      isEmpty,
      reason: 'Every AppIcons call must resolve through the semantic map.',
    );
    expect(declarations, hasLength(93));
  });

  test('product symbols use Remix and platform actions use Cupertino', () {
    const productSymbols = [
      AppIcons.home,
      AppIcons.discover,
      AppIcons.library,
      AppIcons.music,
      AppIcons.play,
      AppIcons.lyrics,
      AppIcons.settings,
    ];
    const platformActions = [AppIcons.back, AppIcons.forward, AppIcons.close];

    for (final icon in productSymbols) {
      expect(icon.fontPackage, 'remixicon');
    }
    for (final icon in platformActions) {
      expect(icon.fontPackage, 'cupertino_icons');
    }
  });

  test('state and destination pairs remain visually distinguishable', () {
    expect(AppIcons.home, isNot(AppIcons.homeFilled));
    expect(AppIcons.discover, isNot(AppIcons.discoverFilled));
    expect(AppIcons.library, isNot(AppIcons.libraryFilled));
    expect(AppIcons.profile, isNot(AppIcons.profileFilled));
    expect(AppIcons.lyrics, isNot(AppIcons.lyricsFilled));
    expect(AppIcons.queue, isNot(AppIcons.playlist));
    expect(AppIcons.warning, isNot(AppIcons.error));
    expect(AppIcons.download, isNot(AppIcons.offline));
  });
}

Set<String> _matches(String source, RegExp pattern) {
  return pattern.allMatches(source).map((match) => match.group(1)!).toSet();
}
