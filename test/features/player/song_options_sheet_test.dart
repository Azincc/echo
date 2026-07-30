import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/data/models/music_library.dart';
import 'package:echoes/data/models/song.dart';
import 'package:echoes/data/repositories/library_repository.dart';
import 'package:echoes/features/player/widgets/song_options_sheet.dart';
import 'package:echoes/providers/library_provider.dart';
import 'package:echoes/providers/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'test_player_notifier.dart';

class _MockLibraryRepository extends Mock implements LibraryRepository {}

void main() {
  late LibraryRepository libraryRepository;

  setUp(() {
    libraryRepository = _MockLibraryRepository();
    when(
      () => libraryRepository.watchLibraries(),
    ).thenAnswer((_) => Stream.value(const <MusicLibrary>[]));
  });

  final song = Song(
    id: 'song',
    title: 'A long song title used by the action sheet',
    artist: 'Artist name',
    album: 'Album name',
  );

  testWidgets('offline mode keeps extra actions operable at 200% text', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 800);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    final notifier = TestPlayerNotifier(
      PlayerState(currentSong: song, queue: <Song>[song]),
    );
    var activations = 0;
    late BuildContext hostContext;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          libraryRepositoryProvider.overrideWithValue(libraryRepository),
          playerProvider.overrideWith((ref) => notifier),
        ],
        child: MaterialApp(
          theme: AppTheme.dark(),
          builder: (context, child) {
            final media = MediaQuery.of(context);
            return MediaQuery(
              data: media.copyWith(
                textScaler: const TextScaler.linear(2),
                disableAnimations: true,
              ),
              child: child!,
            );
          },
          home: Scaffold(
            body: Builder(
              builder: (context) {
                hostContext = context;
                return TextButton(
                  onPressed: () => showSongOptionsSheet(
                    context: context,
                    song: song,
                    mode: SongOptionsSheetMode.offlineOnly,
                    extraActions: <SongOptionsExtraAction>[
                      SongOptionsExtraAction(
                        icon: AppIcons.downloadOutline,
                        title: '添加到离线下载队列',
                        onPressed: () => activations += 1,
                      ),
                    ],
                  ),
                  child: const Text('打开操作'),
                );
              },
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('打开操作'));
    await tester.pumpAndSettle();
    expect(find.text('离线曲目操作'), findsOneWidget);
    expect(find.text('添加到离线下载队列'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('添加到离线下载队列'));
    await tester.pumpAndSettle();
    expect(activations, 1);
    expect(hostContext.mounted, isTrue);
  });

  testWidgets('full mode exposes the established business actions', (
    tester,
  ) async {
    final notifier = TestPlayerNotifier(
      PlayerState(currentSong: song, queue: <Song>[song]),
    );
    late BuildContext hostContext;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          libraryRepositoryProvider.overrideWithValue(libraryRepository),
          playerProvider.overrideWith((ref) => notifier),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: Builder(
              builder: (context) {
                hostContext = context;
                return TextButton(
                  onPressed: () =>
                      showSongOptionsSheet(context: context, song: song),
                  child: const Text('打开操作'),
                );
              },
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('打开操作'));
    await tester.pumpAndSettle();

    expect(find.text('红心'), findsOneWidget);
    expect(find.text('添加到歌单'), findsOneWidget);
    expect(find.text('下载'), findsOneWidget);
    expect(find.text('歌手：Artist name'), findsOneWidget);
    expect(find.text('专辑：Album name'), findsOneWidget);
    expect(hostContext.mounted, isTrue);
  });

  testWidgets(
    'preview mode keeps queue actions but hides library-only actions',
    (tester) async {
      final currentSong = Song(id: 'current', title: 'Current song');
      final previewSong = Song(
        id: 'gd_netease_preview',
        title: 'Preview song',
        artist: 'Remote artist',
        album: 'Remote album',
        isPreview: true,
        previewSource: 'netease',
        previewTrackId: 'preview',
        previewCoverUrl: 'https://images.example.test/preview.jpg',
      );
      final notifier = TestPlayerNotifier(
        PlayerState(currentSong: currentSong, queue: <Song>[currentSong]),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            libraryRepositoryProvider.overrideWithValue(libraryRepository),
            playerProvider.overrideWith((ref) => notifier),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: Scaffold(
              body: Builder(
                builder: (context) => TextButton(
                  onPressed: () =>
                      showSongOptionsSheet(context: context, song: previewSong),
                  child: const Text('打开试听操作'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('打开试听操作'));
      await tester.pumpAndSettle();

      expect(find.text('试听歌曲操作'), findsOneWidget);
      expect(find.text('下一曲播放'), findsOneWidget);
      expect(find.text('添加到离线下载队列'), findsOneWidget);
      expect(find.text('远程试听 · netease'), findsOneWidget);
      expect(find.text('红心'), findsNothing);
      expect(find.text('添加到歌单'), findsNothing);
      expect(find.text('下载'), findsNothing);

      await tester.tap(find.text('下一曲播放'));
      await tester.pumpAndSettle();

      expect(notifier.state.queue, <Song>[currentSong, previewSong]);
    },
  );
}
