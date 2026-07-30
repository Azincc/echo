import 'package:echoes/data/models/song.dart';
import 'package:echoes/providers/player_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final normalSong = Song(id: 'normal', title: 'Normal song');
  final previewSong = Song(
    id: 'gd_netease_preview',
    title: 'Preview song',
    isPreview: true,
    previewSource: 'netease',
    previewTrackId: 'preview',
  );
  final resolvedPreview = previewSong.copyWith(
    previewStreamUrl: 'https://audio.example.test/preview.mp3',
    previewCoverUrl: 'https://images.example.test/preview.jpg',
  );

  test('resolving the current preview keeps following normal songs', () {
    final result = resolvePreviewPlaybackQueue(
      queue: <Song>[previewSong, normalSong],
      preferredIndex: 0,
      unresolvedSong: previewSong,
      resolvedSong: resolvedPreview,
    );

    expect(result.index, 0);
    expect(result.queue, <Song>[resolvedPreview, normalSong]);
    expect(result.queue, hasLength(2));
    expect(
      result.queue.first.previewStreamUrl,
      'https://audio.example.test/preview.mp3',
    );
    expect(result.queue.last.id, normalSong.id);
  });

  test('resolving a preview added as next keeps the normal current song', () {
    final result = resolvePreviewPlaybackQueue(
      queue: <Song>[normalSong, previewSong],
      preferredIndex: 1,
      unresolvedSong: previewSong,
      resolvedSong: resolvedPreview,
    );

    expect(result.index, 1);
    expect(result.queue, <Song>[normalSong, resolvedPreview]);
    expect(result.queue, hasLength(2));
    expect(result.queue.first.id, normalSong.id);
    expect(
      result.queue.last.previewStreamUrl,
      'https://audio.example.test/preview.mp3',
    );
  });
}
