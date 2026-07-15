import 'package:cached_network_image/cached_network_image.dart';
import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/utils/cover_ref_security.dart';
import 'package:echoes/widgets/cover_art_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildSubject(String? coverArtId) {
    return ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: Center(child: CoverArtImage(coverArtId: coverArtId, size: 48)),
        ),
      ),
    );
  }

  testWidgets('blocks raw file paths and raw external urls', (tester) async {
    await tester.pumpWidget(buildSubject('file:///sdcard/secret.jpg'));
    await tester.pump();

    expect(find.byType(CachedNetworkImage), findsNothing);
    expect(find.byIcon(AppIcons.music), findsOneWidget);
    expect(find.bySemanticsLabel('暂无封面'), findsOneWidget);

    await tester.pumpWidget(buildSubject('https://evil.example/cover.jpg'));
    await tester.pump();

    expect(find.byType(CachedNetworkImage), findsNothing);
    expect(find.byIcon(AppIcons.music), findsOneWidget);
  });

  testWidgets('allows trusted direct cover url refs', (tester) async {
    await tester.pumpWidget(
      buildSubject(
        toTrustedCoverUrlRef('https://img.example.com/cover.jpg?size=800'),
      ),
    );
    await tester.pump();

    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.bySemanticsLabel('专辑封面'), findsOneWidget);
  });

  testWidgets('uses a caller-provided accessible cover label', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: CoverArtImage(
              coverArtId: null,
              size: 48,
              semanticLabel: '测试歌曲封面',
            ),
          ),
        ),
      ),
    );

    expect(find.bySemanticsLabel('测试歌曲封面'), findsOneWidget);
  });
}
