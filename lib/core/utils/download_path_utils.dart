import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as p;

const _defaultPathSegmentMaxLength = 64;
const _defaultSuffixMaxLength = 16;

/// Builds a download file path that is guaranteed to stay under [rootDir].
String buildDownloadFilePath({
  required String rootDir,
  required String libraryId,
  required String songId,
  required String suffix,
}) {
  final trimmedRoot = rootDir.trim();
  if (trimmedRoot.isEmpty) {
    throw ArgumentError.value(
      rootDir,
      'rootDir',
      'Download root cannot be empty',
    );
  }

  final safeLibraryId = sanitizeDownloadPathSegment(
    libraryId,
    fallback: 'library',
  );
  final safeSongId = sanitizeDownloadPathSegment(songId, fallback: 'song');
  final safeSuffix = sanitizeDownloadFileSuffix(suffix);
  final normalizedRoot = p.normalize(trimmedRoot);
  final candidate = p.normalize(
    p.join(normalizedRoot, safeLibraryId, '$safeSongId.$safeSuffix'),
  );

  if (!p.isWithin(normalizedRoot, candidate)) {
    throw ArgumentError.value(
      candidate,
      'candidate',
      'Resolved download path escaped the download root',
    );
  }

  return candidate;
}

/// Builds a cache file path that is guaranteed to stay under [rootDir].
String buildCacheFilePath({
  required String rootDir,
  required String libraryId,
  required String songId,
  required String qualityName,
}) {
  final trimmedRoot = rootDir.trim();
  if (trimmedRoot.isEmpty) {
    throw ArgumentError.value(rootDir, 'rootDir', 'Cache root cannot be empty');
  }

  final safeLibraryId = sanitizeDownloadPathSegment(
    libraryId,
    fallback: 'library',
  );
  final safeSongId = sanitizeDownloadPathSegment(songId, fallback: 'song');
  final safeQualityName = sanitizeDownloadPathSegment(
    qualityName,
    fallback: 'quality',
  );
  final normalizedRoot = p.normalize(trimmedRoot);
  final candidate = p.normalize(
    p.join(
      normalizedRoot,
      safeLibraryId,
      '${safeSongId}_$safeQualityName.cache',
    ),
  );

  if (!isPathWithinRoot(rootDir: normalizedRoot, candidatePath: candidate)) {
    throw ArgumentError.value(
      candidate,
      'candidate',
      'Resolved cache path escaped the cache root',
    );
  }

  return candidate;
}

bool isPathWithinRoot({
  required String rootDir,
  required String candidatePath,
  bool allowRoot = false,
}) {
  final normalizedRoot = p.normalize(rootDir.trim());
  final normalizedCandidate = p.normalize(candidatePath.trim());

  if (allowRoot && p.equals(normalizedRoot, normalizedCandidate)) {
    return true;
  }

  return p.isWithin(normalizedRoot, normalizedCandidate);
}

/// Rewrites a user or server controlled path segment into a stable safe name.
String sanitizeDownloadPathSegment(
  String value, {
  required String fallback,
  int maxLength = _defaultPathSegmentMaxLength,
}) {
  final trimmed = value.trim();
  final normalized = trimmed
      .replaceAll(RegExp(r'[^A-Za-z0-9_-]+'), '_')
      .replaceAll(RegExp(r'_+'), '_')
      .replaceAll(RegExp(r'^_+|_+$'), '');

  var base = normalized;
  if (base.isEmpty || base == '.' || base == '..') {
    base = fallback;
  }

  final clipped = base.length > maxLength ? base.substring(0, maxLength) : base;
  final needsHash =
      clipped != trimmed ||
      normalized != trimmed ||
      base != normalized ||
      trimmed.isEmpty ||
      trimmed == '.' ||
      trimmed == '..' ||
      base.length > maxLength;

  if (!needsHash) {
    return clipped;
  }

  final digest = sha256
      .convert(utf8.encode(trimmed))
      .toString()
      .substring(0, 12);
  return _appendStableSuffix(clipped, '_$digest', maxLength);
}

/// Rewrites a file suffix into a safe extension.
String sanitizeDownloadFileSuffix(
  String suffix, {
  String fallback = 'mp3',
  int maxLength = _defaultSuffixMaxLength,
}) {
  final cleaned = suffix.trim().replaceAll(RegExp(r'[^A-Za-z0-9]+'), '');
  final normalized = cleaned.toLowerCase();
  if (normalized.isEmpty) {
    return fallback;
  }
  if (normalized.length <= maxLength) {
    return normalized;
  }
  return normalized.substring(0, maxLength);
}

String _appendStableSuffix(String base, String suffix, int maxLength) {
  if (base.length + suffix.length <= maxLength) {
    return '$base$suffix';
  }

  final prefixLength = maxLength - suffix.length;
  if (prefixLength <= 0) {
    return suffix.substring(suffix.length - maxLength);
  }

  return '${base.substring(0, prefixLength)}$suffix';
}
