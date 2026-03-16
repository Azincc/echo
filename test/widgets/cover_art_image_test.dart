import 'package:cached_network_image/cached_network_image.dart';
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
    expect(find.byIcon(Icons.music_note), findsOneWidget);

    await tester.pumpWidget(buildSubject('https://evil.example/cover.jpg'));
    await tester.pump();

    expect(find.byType(CachedNetworkImage), findsNothing);
    expect(find.byIcon(Icons.music_note), findsOneWidget);
  });

  testWidgets('allows trusted direct cover url refs', (tester) async {
    await tester.pumpWidget(
      buildSubject(
        toTrustedCoverUrlRef('https://img.example.com/cover.jpg?size=800'),
      ),
    );
    await tester.pump();

    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });
}
