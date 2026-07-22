import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/data/models/embed_service_config.dart';
import 'package:echoes/data/models/song.dart';
import 'package:echoes/data/sources/remote/embed_service_client.dart';
import 'package:echoes/data/sources/remote/gd_music_api_client.dart';
import 'package:echoes/features/library/pages/song_metadata_edit_page.dart';
import 'package:echoes/providers/gd_music_provider.dart';
import 'package:echoes/providers/music_provider.dart';
import 'package:echoes/providers/offline_download_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _configuredEmbedService = EmbedServiceConfig(
  enabled: true,
  baseUrl: 'https://embed.test',
  apiKey: 'test-key',
  libraryId: 'library',
);

final _song = Song(
  id: 'song-1',
  title: 'Page song title',
  artist: 'Page song artist',
  album: 'Page song album',
  path: 'Music/Page song.flac',
);

class _FakeEmbedServiceClient extends EmbedServiceClient {
  int applyMetadataCalls = 0;
  int candidateJobCalls = 0;

  @override
  Future<String> createMetadataCandidatesJob({
    required EmbedServiceConfig config,
    required Song song,
    MetadataSearchOptions? search,
  }) async {
    candidateJobCalls += 1;
    throw StateError('metadata candidate jobs must not be used by the page');
  }

  @override
  Future<String> applyMetadata({
    required EmbedServiceConfig config,
    required Song song,
    required EditableSongMetadata metadata,
  }) async {
    applyMetadataCalls += 1;
    throw StateError('applyMetadata should not be called by validation tests');
  }
}

class _GdSearchCall {
  const _GdSearchCall(this.keyword, this.source, this.limit);

  final String keyword;
  final String source;
  final int limit;
}

class _FakeGdMusicApiClient extends GdMusicApiClient {
  _FakeGdMusicApiClient({Map<String, List<Object>>? responses})
    : responses = responses ?? <String, List<Object>>{};

  final Map<String, List<Object>> responses;
  final Map<String, int> _indices = <String, int>{};
  final List<_GdSearchCall> calls = <_GdSearchCall>[];

  @override
  Future<List<Song>> searchMetadataCandidates({
    required String keyword,
    required String source,
    int limit = 3,
  }) async {
    calls.add(_GdSearchCall(keyword, source, limit));
    final sourceResponses = responses[source] ?? const <Object>[];
    final index = _indices.update(
      source,
      (value) => value + 1,
      ifAbsent: () => 0,
    );
    if (sourceResponses.isEmpty) return const <Song>[];
    final safeIndex = index < sourceResponses.length
        ? index
        : sourceResponses.length - 1;
    final response = sourceResponses[safeIndex];
    if (response is List<Song>) {
      return response.take(limit).toList(growable: false);
    }
    throw response;
  }
}

Future<void> _pumpPage(
  WidgetTester tester, {
  required EmbedServiceClient client,
  GdMusicApiClient? gdClient,
  Song? song,
  double bottomObstruction = 0,
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(800, 1200);
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPhysicalSize);

  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        activeEmbedServiceConfigProvider.overrideWithValue(
          _configuredEmbedService,
        ),
        embedServiceClientProvider.overrideWithValue(client),
        gdMusicApiClientProvider.overrideWithValue(
          gdClient ?? _FakeGdMusicApiClient(),
        ),
        musicRepositoryProvider.overrideWithValue(null),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: EchoShellObstructionScope(
          bottom: bottomObstruction,
          child: SongMetadataEditPage(song: song ?? _song),
        ),
      ),
    ),
  );
}

Finder _echoField(String label) {
  return find.byWidgetPredicate(
    (widget) => widget is EchoTextField && widget.label == label,
    description: 'EchoTextField labeled $label',
  );
}

TextEditingController _controllerFor(WidgetTester tester, String label) {
  return tester.widget<EchoTextField>(_echoField(label)).controller;
}

void main() {
  testWidgets(
    'opens from the local song model without calling candidate services',
    (tester) async {
      final client = _FakeEmbedServiceClient();
      final song = Song(
        id: 'song-current',
        title: 'Current title',
        artist: 'Current artist',
        album: 'Current album',
        track: 7,
        discNumber: 2,
        year: 2024,
        genre: 'Dream pop',
        path: 'Music/Current.flac',
      );

      await _pumpPage(tester, client: client, song: song);
      await tester.pumpAndSettle();

      expect(find.text('当前歌曲元数据'), findsOneWidget);
      expect(find.text('搜索元数据'), findsOneWidget);
      expect(find.text('搜索结果'), findsNothing);
      expect(find.bySemanticsLabel('单曲名称搜索维度，已选择'), findsOneWidget);
      expect(find.bySemanticsLabel('专辑名称搜索维度，未选择'), findsOneWidget);
      expect(find.bySemanticsLabel('艺术家搜索维度，已选择'), findsOneWidget);
      expect(find.text('将搜索：Current title - Current artist'), findsOneWidget);
      expect(_controllerFor(tester, '标题').text, 'Current title');
      expect(_controllerFor(tester, '歌手').text, 'Current artist');
      expect(_controllerFor(tester, '曲号').text, '7');
      expect(_controllerFor(tester, '碟号').text, '2');
      expect(_controllerFor(tester, '年份').text, '2024');
      expect(_controllerFor(tester, '流派').text, 'Dream pop');
      expect(find.text('可检查字段后写入音频文件'), findsOneWidget);
      expect(client.candidateJobCalls, 0);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'searches selected dimensions and keeps netease and kuwo results separate',
    (tester) async {
      final song = Song(
        id: 'slow-down',
        title: 'Slow Down',
        artist: '雷米克斯 / Settle一虾子',
        album: 'Slow Down',
        path: 'Music/Slow Down.flac',
      );
      final client = _FakeEmbedServiceClient();
      final gdClient = _FakeGdMusicApiClient(
        responses: <String, List<Object>>{
          'netease': <Object>[
            <Song>[
              Song(
                id: 'gd_netease_netease-1',
                title: 'Slow Down (Official)',
                artist: "Keb' Mo'",
                album: 'Slow Down Remastered',
                isPreview: true,
                previewSource: 'netease',
                previewTrackId: 'netease-1',
                previewPicId: 'netease-pic-1',
                previewCoverUrl: 'https://cover.test/netease-1.jpg',
              ),
              Song(
                id: 'gd_netease_netease-2',
                title: 'Slow Down (Acoustic)',
                artist: "Keb' Mo'",
                album: 'Acoustic Session',
                isPreview: true,
                previewSource: 'netease',
                previewTrackId: 'netease-2',
              ),
              Song(
                id: 'gd_netease_netease-3',
                title: 'Slow Down (Radio Edit)',
                artist: "Keb' Mo'",
                album: 'Radio Edit',
                isPreview: true,
                previewSource: 'netease',
                previewTrackId: 'netease-3',
              ),
              Song(
                id: 'gd_netease_netease-4',
                title: 'Fourth NetEase Result',
                artist: "Keb' Mo'",
                album: 'Should not be shown',
                isPreview: true,
                previewSource: 'netease',
                previewTrackId: 'netease-4',
              ),
            ],
          ],
          'kuwo': <Object>[
            <Song>[
              Song(
                id: 'gd_kuwo_kuwo-1',
                title: 'Slow Down (Live)',
                artist: "Keb' Mo'",
                album: 'Live Session',
                isPreview: true,
                previewSource: 'kuwo',
                previewTrackId: 'kuwo-1',
                previewCoverUrl: 'https://cover.test/kuwo-1.jpg',
              ),
            ],
          ],
        },
      );

      await _pumpPage(tester, client: client, gdClient: gdClient, song: song);
      await tester.pumpAndSettle();

      expect(find.text('将搜索：Slow Down - 雷米克斯, Settle一虾子'), findsOneWidget);
      final searchButton = find.widgetWithText(EchoButton, '搜索');
      await tester.ensureVisible(searchButton);
      await tester.tap(searchButton);
      await tester.pumpAndSettle();

      expect(gdClient.calls, hasLength(2));
      expect(gdClient.calls.map((call) => call.source).toSet(), <String>{
        'netease',
        'kuwo',
      });
      for (final call in gdClient.calls) {
        expect(call.keyword, 'Slow Down - 雷米克斯, Settle一虾子');
        expect(call.limit, 3);
      }
      expect(client.candidateJobCalls, 0);
      expect(find.text('网易云音乐'), findsOneWidget);
      expect(find.text('酷我音乐'), findsOneWidget);
      expect(find.text('Slow Down (Official)'), findsOneWidget);
      expect(find.text('Slow Down (Live)'), findsOneWidget);
      expect(find.text('Fourth NetEase Result'), findsNothing);

      final result = find.text('Slow Down (Official)');
      await tester.ensureVisible(result);
      await tester.tap(result);
      await tester.pumpAndSettle();

      expect(find.textContaining('曲目 ID netease-1'), findsOneWidget);
      await tester.tap(find.text('应用 5 个字段'));
      await tester.pumpAndSettle();

      expect(_controllerFor(tester, '标题').text, 'Slow Down (Official)');
      expect(_controllerFor(tester, '歌手').text, "Keb' Mo'");
      expect(
        _controllerFor(tester, '封面 URL').text,
        'https://cover.test/netease-1.jpg',
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('allows any search dimension combination', (tester) async {
    final song = Song(
      id: 'dimension-song',
      title: 'Track title',
      artist: 'Track artist',
      album: 'Album title',
      path: 'Music/Track title.flac',
    );
    final client = _FakeEmbedServiceClient();
    final gdClient = _FakeGdMusicApiClient();

    await _pumpPage(tester, client: client, gdClient: gdClient, song: song);
    await tester.pumpAndSettle();

    await tester.tap(find.bySemanticsLabel('专辑名称搜索维度，未选择'));
    await tester.pump();
    await tester.tap(find.bySemanticsLabel('艺术家搜索维度，已选择'));
    await tester.pump();

    expect(find.text('将搜索：Track title - Album title'), findsOneWidget);
    final searchButton = find.widgetWithText(EchoButton, '搜索');
    await tester.ensureVisible(searchButton);
    await tester.tap(searchButton);
    await tester.pumpAndSettle();

    expect(gdClient.calls, hasLength(2));
    expect(gdClient.calls.map((call) => call.keyword).toSet(), <String>{
      'Track title - Album title',
    });
    expect(gdClient.calls.map((call) => call.source).toSet(), <String>{
      'netease',
      'kuwo',
    });
    expect(client.candidateJobCalls, 0);
    expect(tester.takeException(), isNull);
  });

  testWidgets('empty source can refresh independently without losing results', (
    tester,
  ) async {
    final client = _FakeEmbedServiceClient();
    final gdClient = _FakeGdMusicApiClient(
      responses: <String, List<Object>>{
        'netease': <Object>[
          <Song>[],
          <Song>[
            Song(
              id: 'gd_netease_recovered',
              title: 'NetEase Recovered',
              artist: 'Recovered Artist',
              album: 'Recovered Album',
              isPreview: true,
              previewSource: 'netease',
              previewTrackId: 'recovered',
            ),
          ],
        ],
        'kuwo': <Object>[
          <Song>[
            Song(
              id: 'gd_kuwo_stable',
              title: 'Kuwo Stable Result',
              artist: 'Stable Artist',
              album: 'Stable Album',
              isPreview: true,
              previewSource: 'kuwo',
              previewTrackId: 'stable',
            ),
          ],
        ],
      },
    );

    await _pumpPage(tester, client: client, gdClient: gdClient);
    await tester.pumpAndSettle();

    final searchButton = find.widgetWithText(EchoButton, '搜索');
    await tester.ensureVisible(searchButton);
    await tester.tap(searchButton);
    await tester.pumpAndSettle();

    expect(find.text('Kuwo Stable Result'), findsOneWidget);
    expect(find.text('NetEase Recovered'), findsNothing);
    expect(find.text('此渠道返回了空列表，可单独刷新重试。'), findsOneWidget);

    final refresh = find.bySemanticsLabel('刷新网易云音乐');
    await tester.ensureVisible(refresh);
    await tester.tap(refresh);
    await tester.pumpAndSettle();

    expect(find.text('NetEase Recovered'), findsOneWidget);
    expect(find.text('Kuwo Stable Result'), findsOneWidget);
    expect(
      gdClient.calls.where((call) => call.source == 'netease'),
      hasLength(2),
    );
    expect(gdClient.calls.where((call) => call.source == 'kuwo'), hasLength(1));
    expect(client.candidateJobCalls, 0);
    expect(tester.takeException(), isNull);
  });

  testWidgets('editor bottom padding includes the shell obstruction', (
    tester,
  ) async {
    final client = _FakeEmbedServiceClient();

    await _pumpPage(tester, client: client, bottomObstruction: 120);
    await tester.pumpAndSettle();

    final scrollView = tester.widget<SingleChildScrollView>(
      find.byKey(const ValueKey<String>('song-metadata-editor-scroll')),
    );
    expect((scrollView.padding! as EdgeInsets).bottom, 168);
    expect(tester.takeException(), isNull);
  });

  testWidgets('rejects non-numeric metadata before applying it', (
    tester,
  ) async {
    final client = _FakeEmbedServiceClient();
    final song = Song(
      id: 'validation-song',
      title: 'Valid title',
      artist: 'Valid artist',
      year: 2024,
      path: 'Music/Valid title.flac',
    );

    await _pumpPage(tester, client: client, song: song);
    await tester.pumpAndSettle();

    final yearEditor = find.descendant(
      of: _echoField('年份'),
      matching: find.byType(TextField),
    );
    await tester.enterText(yearEditor, 'not-a-year');
    await tester.tap(find.text('应用到文件'));
    await tester.pump();

    expect(find.text('请输入数字'), findsOneWidget);
    expect(client.applyMetadataCalls, 0);
    expect(tester.takeException(), isNull);
  });

  testWidgets('asks before leaving when current metadata has unsaved edits', (
    tester,
  ) async {
    final client = _FakeEmbedServiceClient();
    final song = Song(
      id: 'dirty-song',
      title: 'Original title',
      artist: 'Original artist',
      path: 'Music/Original title.flac',
    );

    await _pumpPage(tester, client: client, song: song);
    await tester.pumpAndSettle();

    final titleEditor = find.descendant(
      of: _echoField('标题'),
      matching: find.byType(TextField),
    );
    await tester.enterText(titleEditor, 'Edited title');
    await tester.pump();

    expect(find.text('有未保存更改'), findsOneWidget);
    expect(find.text('有未保存的更改'), findsOneWidget);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(find.text('放弃未保存的更改？'), findsOneWidget);
    expect(find.text('继续编辑'), findsOneWidget);
    expect(find.text('放弃并退出'), findsOneWidget);

    await tester.tap(find.text('继续编辑'));
    await tester.pumpAndSettle();

    expect(find.text('放弃未保存的更改？'), findsNothing);
    expect(find.text('有未保存更改'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
