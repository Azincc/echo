import 'package:echoes/providers/player/transcoded_stream_seek.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('shouldUseServerTimeOffsetSeek', () {
    test('detects explicit format transcoding', () {
      expect(
        shouldUseServerTimeOffsetSeek(
          requestedFormat: 'mp3',
          requestedMaxBitRate: 320,
          sourceFormat: 'flac',
          sourceBitRate: 1011,
        ),
        isTrue,
      );
    });

    test('keeps a matching source format below the limit seekable', () {
      expect(
        shouldUseServerTimeOffsetSeek(
          requestedFormat: 'mp3',
          requestedMaxBitRate: 320,
          sourceFormat: 'mp3',
          sourceBitRate: 192,
        ),
        isFalse,
      );
    });

    test('detects bitrate-limited transcoding', () {
      expect(
        shouldUseServerTimeOffsetSeek(
          requestedFormat: null,
          requestedMaxBitRate: 192,
          sourceFormat: 'flac',
          sourceBitRate: 1011,
        ),
        isTrue,
      );
    });

    test('normalizes source bitrate expressed in bps', () {
      expect(
        shouldUseServerTimeOffsetSeek(
          requestedFormat: null,
          requestedMaxBitRate: 192,
          sourceFormat: 'mp3',
          sourceBitRate: 320000,
        ),
        isTrue,
      );
    });

    test('keeps raw streams on ordinary byte seek', () {
      expect(
        shouldUseServerTimeOffsetSeek(
          requestedFormat: 'raw',
          requestedMaxBitRate: null,
          sourceFormat: 'flac',
          sourceBitRate: 1011,
        ),
        isFalse,
      );
    });

    test(
      'does not classify a source already below the limit as transcoded',
      () {
        expect(
          shouldUseServerTimeOffsetSeek(
            requestedFormat: null,
            requestedMaxBitRate: 192,
            sourceFormat: 'mp3',
            sourceBitRate: 128,
          ),
          isFalse,
        );
      },
    );
  });

  group('TranscodedStreamSeekTarget', () {
    test(
      'splits logical time into whole-second offset and source remainder',
      () {
        final target = TranscodedStreamSeekTarget.fromLogical(
          const Duration(milliseconds: 45070),
        );

        expect(target.serverOffset, const Duration(seconds: 45));
        expect(target.sourcePosition, const Duration(milliseconds: 70));
        expect(
          target.toLogical(const Duration(milliseconds: 292)),
          const Duration(milliseconds: 45292),
        );
      },
    );

    test('clamps logical positions to the song duration', () {
      final target = TranscodedStreamSeekTarget.fromLogical(
        const Duration(seconds: 150),
      );

      expect(
        target.toLogical(
          const Duration(seconds: 5),
          maximum: const Duration(seconds: 152),
        ),
        const Duration(seconds: 152),
      );
    });
  });
}
