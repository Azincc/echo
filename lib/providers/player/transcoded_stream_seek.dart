/// Describes how a logical song position maps onto a stream that was started
/// with Subsonic's `timeOffset` parameter.
class TranscodedStreamSeekTarget {
  final Duration logicalPosition;
  final Duration serverOffset;
  final Duration sourcePosition;

  const TranscodedStreamSeekTarget._({
    required this.logicalPosition,
    required this.serverOffset,
    required this.sourcePosition,
  });

  factory TranscodedStreamSeekTarget.fromLogical(Duration position) {
    final logicalPosition = position < Duration.zero ? Duration.zero : position;
    final serverOffset = Duration(seconds: logicalPosition.inSeconds);
    return TranscodedStreamSeekTarget._(
      logicalPosition: logicalPosition,
      serverOffset: serverOffset,
      sourcePosition: logicalPosition - serverOffset,
    );
  }

  Duration toLogical(Duration sourcePosition, {Duration? maximum}) {
    return addPlaybackPositionOffset(
      sourcePosition,
      serverOffset,
      maximum: maximum,
    );
  }
}

/// Whether the requested Subsonic stream is expected to be transcoded.
///
/// Navidrome transcodes when the requested format differs from the source, or
/// when the requested maximum bitrate is below the source bitrate. Requesting
/// the source's existing format with a high enough bitrate can still return the
/// original byte-seekable file. Live transcoding responses are not byte-
/// seekable until the server-side cache is complete, so only those streams
/// should be seeked by rebuilding the URL with `timeOffset`.
bool shouldUseServerTimeOffsetSeek({
  required String? requestedFormat,
  required int? requestedMaxBitRate,
  required String? sourceFormat,
  required int? sourceBitRate,
}) {
  final format = _normalizeFormat(requestedFormat);
  if (format != null && format.isNotEmpty && format != 'raw') {
    final originalFormat = _normalizeFormat(sourceFormat);
    final maxBitRate = _normalizeBitRateKbps(requestedMaxBitRate);
    final originalBitRate = _normalizeBitRateKbps(sourceBitRate);
    final canUseOriginalStream =
        originalFormat == format &&
        (maxBitRate == 0 ||
            (originalBitRate > 0 && maxBitRate >= originalBitRate));
    if (canUseOriginalStream) return false;
    return true;
  }

  final maxBitRate = _normalizeBitRateKbps(requestedMaxBitRate);
  final originalBitRate = _normalizeBitRateKbps(sourceBitRate);
  return maxBitRate > 0 && originalBitRate > maxBitRate;
}

Duration addPlaybackPositionOffset(
  Duration sourcePosition,
  Duration offset, {
  Duration? maximum,
}) {
  var logical = sourcePosition + offset;
  if (logical < Duration.zero) logical = Duration.zero;
  if (maximum != null && maximum > Duration.zero && logical > maximum) {
    logical = maximum;
  }
  return logical;
}

int _normalizeBitRateKbps(int? bitRate) {
  if (bitRate == null || bitRate <= 0) return 0;
  return bitRate >= 10000 ? bitRate ~/ 1000 : bitRate;
}

String? _normalizeFormat(String? format) {
  final normalized = format?.trim().toLowerCase();
  if (normalized == null || normalized.isEmpty) return null;
  return normalized.startsWith('.') ? normalized.substring(1) : normalized;
}
