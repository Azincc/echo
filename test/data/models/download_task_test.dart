import 'package:flutter_test/flutter_test.dart';
import 'package:echoes/data/models/download_task.dart';

void main() {
  // -------------------------------------------------------------------------
  // Test fixtures
  // -------------------------------------------------------------------------

  DownloadTask sampleTask() => DownloadTask(
        id: 'task-1',
        libraryId: 'lib-1',
        songId: 'song-1',
        title: 'Test Song',
        artist: 'Test Artist',
        album: 'Test Album',
        coverArt: 'cover-1',
        duration: 245,
        suffix: 'flac',
        bitRate: 320,
        contentType: 'audio/flac',
        status: DownloadTaskStatus.downloading,
        progress: 0.5,
        createdAt: 1700000000,
      );

  // -------------------------------------------------------------------------
  // copyWith
  // -------------------------------------------------------------------------

  group('DownloadTask.copyWith', () {
    test('changes status, keeps other fields', () {
      final original = sampleTask();
      final copy = original.copyWith(status: DownloadTaskStatus.completed);

      expect(copy.status, DownloadTaskStatus.completed);
      expect(copy.id, original.id);
      expect(copy.songId, original.songId);
      expect(copy.title, original.title);
      expect(copy.progress, original.progress);
    });

    test('changes progress', () {
      final copy = sampleTask().copyWith(progress: 0.99);
      expect(copy.progress, 0.99);
    });

    test('changes filePath and completedAt', () {
      final copy = sampleTask().copyWith(
        filePath: '/path/to/file.flac',
        completedAt: 1700001000,
      );
      expect(copy.filePath, '/path/to/file.flac');
      expect(copy.completedAt, 1700001000);
    });
  });

  // -------------------------------------------------------------------------
  // durationString
  // -------------------------------------------------------------------------

  group('DownloadTask.durationString', () {
    test('formats non-null duration', () {
      expect(sampleTask().durationString, '04:05');
    });

    test('returns --:-- for null duration', () {
      final task = DownloadTask(
        id: 't',
        libraryId: 'l',
        songId: 's',
        title: 'T',
        createdAt: 0,
      );
      expect(task.durationString, '--:--');
    });
  });

  // -------------------------------------------------------------------------
  // DownloadTaskStatus extension
  // -------------------------------------------------------------------------

  group('DownloadTaskStatus', () {
    test('displayName returns correct Chinese text', () {
      expect(DownloadTaskStatus.pending.displayName, '等待中');
      expect(DownloadTaskStatus.downloading.displayName, '下载中');
      expect(DownloadTaskStatus.completed.displayName, '已完成');
      expect(DownloadTaskStatus.failed.displayName, '失败');
      expect(DownloadTaskStatus.paused.displayName, '已暂停');
    });

    test('fromString parses known values', () {
      expect(
        DownloadTaskStatusExt.fromString('downloading'),
        DownloadTaskStatus.downloading,
      );
      expect(
        DownloadTaskStatusExt.fromString('completed'),
        DownloadTaskStatus.completed,
      );
    });

    test('fromString defaults to pending for unknown value', () {
      expect(
        DownloadTaskStatusExt.fromString('unknown_value'),
        DownloadTaskStatus.pending,
      );
    });
  });
}
