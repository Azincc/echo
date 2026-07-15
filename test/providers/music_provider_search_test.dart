import 'dart:async';

import 'package:echoes/data/models/server_address.dart';
import 'package:echoes/data/repositories/music_repository.dart';
import 'package:echoes/providers/api_provider.dart';
import 'package:echoes/providers/music_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockMusicRepository extends Mock implements MusicRepository {}

void main() {
  test('disposed search requests cannot publish stale failure state', () async {
    final repository = _MockMusicRepository();
    final pending = Completer<SearchResult>();
    when(
      () => repository.search(
        query: '旧查询',
        artistCount: 10,
        albumCount: 20,
        songCount: 30,
      ),
    ).thenAnswer((_) => pending.future);

    final container = ProviderContainer(
      overrides: <Override>[
        musicRepositoryProvider.overrideWithValue(repository),
        ensureActiveAddressProvider.overrideWith(
          (ref) async => ServerAddress(
            id: 'server-1',
            libraryId: 'library-1',
            label: 'Test server',
            url: 'https://example.test',
            priority: 0,
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    final subscription = container.listen(
      searchProvider('旧查询'),
      (_, _) {},
      fireImmediately: true,
    );
    await container.pump();
    await Future<void>.delayed(Duration.zero);
    await container.pump();
    verify(
      () => repository.search(
        query: '旧查询',
        artistCount: 10,
        albumCount: 20,
        songCount: 30,
      ),
    ).called(1);

    subscription.close();
    await container.pump();
    pending.completeError(StateError('offline'));
    await container.pump();

    expect(container.read(searchLoadFailedProvider('旧查询')), isFalse);
  });

  test('query failure state is released after its last listener', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final provider = searchLoadFailedProvider('临时查询');
    final subscription = container.listen(
      provider,
      (_, _) {},
      fireImmediately: true,
    );

    container.read(provider.notifier).state = true;
    expect(subscription.read(), isTrue);

    subscription.close();
    await container.pump();
    expect(container.read(provider), isFalse);
  });
}
