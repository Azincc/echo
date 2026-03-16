bool isSupportedServerUrl(String rawUrl) {
  final uri = Uri.tryParse(rawUrl.trim());
  if (uri == null || !uri.hasScheme || uri.host.isEmpty) {
    return false;
  }

  final scheme = uri.scheme.toLowerCase();
  return scheme == 'http' || scheme == 'https';
}

bool isInsecureHttpUrl(String rawUrl) {
  final uri = Uri.tryParse(rawUrl.trim());
  if (uri == null || uri.host.isEmpty) {
    return false;
  }

  return uri.scheme.toLowerCase() == 'http';
}
