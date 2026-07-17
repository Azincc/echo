import 'dart:async';

import 'package:echoes/core/design/echo_design.dart';
import 'package:echoes/core/theme/app_theme.dart';
import 'package:echoes/data/models/embed_service_config.dart';
import 'package:echoes/data/models/song.dart';
import 'package:echoes/data/sources/remote/embed_service_client.dart';
import 'package:echoes/features/library/pages/song_metadata_edit_page.dart';
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
  _FakeEmbedServiceClient({
    this.createJobCompleter,
    this.createJobError,
    this.candidateStatus,
    this.searchStatus,
  });

  final Completer<String>? createJobCompleter;
  final Object? createJobError;
  final MetadataCandidatesJobStatus? candidateStatus;
  final MetadataCandidatesJobStatus? searchStatus;

  int createJobCalls = 0;
  int applyMetadataCalls = 0;
  final List<MetadataSearchOptions?> searches = <MetadataSearchOptions?>[];

  @override
  Future<String> createMetadataCandidatesJob({
    required EmbedServiceConfig config,
    required Song song,
    MetadataSearchOptions? search,
  }) async {
    createJobCalls += 1;
    searches.add(search);
    if (createJobError != null) throw createJobError!;
    if (createJobCompleter != null) return createJobCompleter!.future;
    return 'candidate-job-$createJobCalls';
  }

  @override
  Future<MetadataCandidatesJobStatus> getMetadataCandidatesJobStatus({
    required EmbedServiceConfig config,
    required String jobId,
  }) async {
    if (jobId == 'candidate-job-2' && searchStatus != null) {
      return searchStatus!;
    }
    return candidateStatus ??
        (throw StateError('candidateStatus is required for this test'));
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

MetadataCandidatesJobStatus _completedStatus(
  MetadataCandidatesResponse response,
) {
  final timestamp = DateTime(2025, 1, 1);
  return MetadataCandidatesJobStatus(
    jobId: 'candidate-job-1',
    status: 'done',
    result: response,
    createdAt: timestamp,
    updatedAt: timestamp,
  );
}

Future<void> _pumpPage(
  WidgetTester tester, {
  required EmbedServiceClient client,
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
        musicRepositoryProvider.overrideWithValue(null),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: EchoShellObstructionScope(
          bottom: bottomObstruction,
          child: SongMetadataEditPage(song: _song),
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
    'shows a stable loading state while current metadata is pending',
    (tester) async {
      final client = _FakeEmbedServiceClient(
        createJobCompleter: Completer<String>(),
      );

      await _pumpPage(tester, client: client);
      await tester.pump();

      expect(find.text('正在读取元数据'), findsOneWidget);
      expect(find.text('正在读取音频文件中的当前值'), findsOneWidget);
      expect(find.text('正在读取当前值'), findsOneWidget);
      expect(find.text('应用到文件'), findsOneWidget);
      expect(client.createJobCalls, 1);
      expect(client.searches.single?.dimensions, isEmpty);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('renders current metadata failures with a retry action', (
    tester,
  ) async {
    final client = _FakeEmbedServiceClient(
      createJobError: Exception('候选服务暂不可用'),
    );

    await _pumpPage(tester, client: client);
    await tester.pumpAndSettle();

    expect(find.text('无法读取当前元数据'), findsOneWidget);
    expect(find.text('Exception: 候选服务暂不可用'), findsOneWidget);
    expect(find.text('重试'), findsOneWidget);
    expect(find.text('当前元数据不可用，请重试'), findsOneWidget);
    expect(client.createJobCalls, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'opens with current metadata and explicit search controls without auto-searching',
    (tester) async {
      const current = EditableSongMetadata(
        title: 'Current title',
        artist: 'Current artist',
        album: 'Current album',
        albumArtist: 'Current album artist',
        trackNumber: 7,
        discNumber: 2,
        year: 2024,
        genre: 'Dream pop',
        composer: 'Current composer',
        label: 'Current label',
        comment: 'Current note',
        lyrics: 'Current lyrics',
      );
      final client = _FakeEmbedServiceClient(
        candidateStatus: _completedStatus(
          const MetadataCandidatesResponse(
            current: current,
            candidates: <MetadataCandidate>[],
          ),
        ),
      );

      await _pumpPage(tester, client: client);
      await tester.pumpAndSettle();

      expect(find.text('当前文件元数据'), findsOneWidget);
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
      expect(_controllerFor(tester, '歌词').text, 'Current lyrics');
      expect(find.text('可检查字段后写入音频文件'), findsOneWidget);
      expect(client.createJobCalls, 1);
      expect(client.searches.single?.dimensions, isEmpty);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'searches selected dimensions and keeps netease and kuwo results separate',
    (tester) async {
      const current = EditableSongMetadata(
        title: 'Slow Down',
        artist: '雷米克斯 / Settle一虾子',
        album: 'Slow Down',
        albumArtist: '雷米克斯 / Settle一虾子',
      );
      final client = _FakeEmbedServiceClient(
        candidateStatus: _completedStatus(
          const MetadataCandidatesResponse(
            current: current,
            candidates: <MetadataCandidate>[],
          ),
        ),
        searchStatus: _completedStatus(
          const MetadataCandidatesResponse(
            current: current,
            candidates: <MetadataCandidate>[
              MetadataCandidate(
                source: 'gdstudio_netease',
                trackId: 'netease-1',
                confidence: 0,
                metadata: EditableSongMetadata(
                  title: 'Slow Down (Official)',
                  artist: "Keb' Mo'",
                  album: 'Slow Down',
                  albumArtist: "Keb' Mo'",
                ),
              ),
              MetadataCandidate(
                source: 'gdstudio_kuwo',
                trackId: 'kuwo-1',
                confidence: 0,
                metadata: EditableSongMetadata(
                  title: 'Slow Down (Live)',
                  artist: "Keb' Mo'",
                  album: 'Live Session',
                  albumArtist: "Keb' Mo'",
                ),
              ),
            ],
          ),
        ),
      );

      await _pumpPage(tester, client: client);
      await tester.pumpAndSettle();

      expect(find.text('将搜索：Slow Down - 雷米克斯, Settle一虾子'), findsOneWidget);
      final searchButton = find.widgetWithText(EchoButton, '搜索');
      await tester.ensureVisible(searchButton);
      await tester.tap(searchButton);
      await tester.pumpAndSettle();

      expect(client.createJobCalls, 2);
      final submittedSearch = client.searches.last!;
      expect(submittedSearch.dimensions, <MetadataSearchDimension>{
        MetadataSearchDimension.title,
        MetadataSearchDimension.artist,
      });
      expect(submittedSearch.title, 'Slow Down');
      expect(submittedSearch.artist, '雷米克斯, Settle一虾子');
      expect(find.text('网易云音乐'), findsOneWidget);
      expect(find.text('酷我音乐'), findsOneWidget);
      expect(find.text('Slow Down (Official)'), findsOneWidget);
      expect(find.text('Slow Down (Live)'), findsOneWidget);

      final result = find.text('Slow Down (Official)');
      await tester.ensureVisible(result);
      await tester.tap(result);
      await tester.pumpAndSettle();

      expect(find.textContaining('曲目 ID netease-1'), findsOneWidget);
      await tester.tap(find.text('应用 3 个字段'));
      await tester.pumpAndSettle();

      expect(_controllerFor(tester, '标题').text, 'Slow Down (Official)');
      expect(_controllerFor(tester, '歌手').text, "Keb' Mo'");
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('allows any search dimension combination', (tester) async {
    const current = EditableSongMetadata(
      title: 'Track title',
      artist: 'Track artist',
      album: 'Album title',
    );
    final client = _FakeEmbedServiceClient(
      candidateStatus: _completedStatus(
        const MetadataCandidatesResponse(
          current: current,
          candidates: <MetadataCandidate>[],
        ),
      ),
    );

    await _pumpPage(tester, client: client);
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

    expect(client.searches.last?.dimensions, <MetadataSearchDimension>{
      MetadataSearchDimension.title,
      MetadataSearchDimension.album,
    });
    expect(tester.takeException(), isNull);
  });

  testWidgets('editor bottom padding includes the shell obstruction', (
    tester,
  ) async {
    final client = _FakeEmbedServiceClient(
      candidateStatus: _completedStatus(
        const MetadataCandidatesResponse(
          current: EditableSongMetadata(
            title: 'Current title',
            artist: 'Current artist',
          ),
          candidates: <MetadataCandidate>[],
        ),
      ),
    );

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
    final client = _FakeEmbedServiceClient(
      candidateStatus: _completedStatus(
        const MetadataCandidatesResponse(
          current: EditableSongMetadata(
            title: 'Valid title',
            artist: 'Valid artist',
            year: 2024,
          ),
          candidates: <MetadataCandidate>[],
        ),
      ),
    );

    await _pumpPage(tester, client: client);
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
    final client = _FakeEmbedServiceClient(
      candidateStatus: _completedStatus(
        const MetadataCandidatesResponse(
          current: EditableSongMetadata(
            title: 'Original title',
            artist: 'Original artist',
          ),
          candidates: <MetadataCandidate>[],
        ),
      ),
    );

    await _pumpPage(tester, client: client);
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
