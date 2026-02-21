import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/sources/remote/gd_music_api_client.dart';

final gdMusicApiClientProvider = Provider<GdMusicApiClient>((ref) {
  return GdMusicApiClient();
});
