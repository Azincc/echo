const _trustedCoverUrlPrefix = 'trusted-url:';

final RegExp _safeServerCoverIdPattern = RegExp(
  r'^(?!https?://)(?!file://)(?!/)(?!.*\.\.)(?!.*[\\/\s?#])[A-Za-z0-9._:-]{1,256}$',
);

final RegExp _trustedCoverUrlRefPattern = RegExp(
  r'^trusted-url:(https?://[^\s]+)$',
);

String? sanitizeServerCoverArtId(String? value) {
  final trimmed = value?.trim() ?? '';
  if (trimmed.isEmpty) return null;
  if (!_safeServerCoverIdPattern.hasMatch(trimmed)) {
    return null;
  }
  return trimmed;
}

bool isSafeServerCoverArtId(String? value) {
  return sanitizeServerCoverArtId(value) != null;
}

String toTrustedCoverUrlRef(String url) {
  final trimmed = url.trim();
  if (!_trustedCoverUrlRefPattern.hasMatch('$_trustedCoverUrlPrefix$trimmed')) {
    throw ArgumentError.value(url, 'url', 'Invalid trusted cover URL');
  }
  return '$_trustedCoverUrlPrefix$trimmed';
}

String? tryToTrustedCoverUrlRef(String? url) {
  final trimmed = url?.trim() ?? '';
  if (trimmed.isEmpty) return null;
  if (!_trustedCoverUrlRefPattern.hasMatch('$_trustedCoverUrlPrefix$trimmed')) {
    return null;
  }
  return '$_trustedCoverUrlPrefix$trimmed';
}

String? extractTrustedCoverUrl(String? value) {
  final trimmed = value?.trim() ?? '';
  if (trimmed.isEmpty) return null;
  final match = _trustedCoverUrlRefPattern.firstMatch(trimmed);
  return match?.group(1);
}

bool isTrustedCoverUrlRef(String? value) {
  return extractTrustedCoverUrl(value) != null;
}
