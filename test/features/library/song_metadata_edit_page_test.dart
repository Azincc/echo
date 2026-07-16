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
  });

  final Completer<String>? createJobCompleter;
  final Object? createJobError;
  final MetadataCandidatesJobStatus? candidateStatus;

  int createJobCalls = 0;
  int applyMetadataCalls = 0;

  @override
  Future<String> createMetadataCandidatesJob({
    required EmbedServiceConfig config,
    required Song song,
  }) async {
    createJobCalls += 1;
    if (createJobError != null) throw createJobError!;
    if (createJobCompleter != null) return createJobCompleter!.future;
    return 'candidate-job';
  }

  @override
  Future<MetadataCandidatesJobStatus> getMetadataCandidatesJobStatus({
    required EmbedServiceConfig config,
    required String jobId,
  }) async {
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
    jobId: 'candidate-job',
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
    'shows a stable loading state while candidate lookup is pending',
    (tester) async {
      final client = _FakeEmbedServiceClient(
        createJobCompleter: Completer<String>(),
      );

      await _pumpPage(tester, client: client);
      await tester.pump();

      expect(find.text('正在读取元数据'), findsOneWidget);
      expect(find.text('正在获取当前值与候选来源'), findsOneWidget);
      expect(find.text('正在获取候选'), findsOneWidget);
      expect(find.text('应用到文件'), findsOneWidget);
      expect(client.createJobCalls, 1);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('renders candidate lookup failures with a retry action', (
    tester,
  ) async {
    final client = _FakeEmbedServiceClient(
      createJobError: Exception('候选服务暂不可用'),
    );

    await _pumpPage(tester, client: client);
    await tester.pumpAndSettle();

    expect(find.text('无法读取元数据候选'), findsOneWidget);
    expect(find.text('Exception: 候选服务暂不可用'), findsOneWidget);
    expect(find.text('重试'), findsOneWidget);
    expect(find.text('候选数据不可用，请重试'), findsOneWidget);
    expect(client.createJobCalls, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'keeps current metadata visible and editable without candidates',
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
      expect(find.text('候选来源'), findsOneWidget);
      expect(find.text('没有候选来源，当前文件值已保留在编辑表单中。'), findsOneWidget);
      expect(find.text('Current title'), findsNWidgets(2));
      expect(find.text('Current artist'), findsNWidgets(2));
      expect(find.text('Current album'), findsNWidgets(2));
      expect(_controllerFor(tester, '标题').text, 'Current title');
      expect(_controllerFor(tester, '歌手').text, 'Current artist');
      expect(_controllerFor(tester, '曲号').text, '7');
      expect(_controllerFor(tester, '碟号').text, '2');
      expect(_controllerFor(tester, '年份').text, '2024');
      expect(_controllerFor(tester, '歌词').text, 'Current lyrics');
      expect(find.text('可检查字段后写入音频文件'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

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
