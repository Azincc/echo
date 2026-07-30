import 'package:echoes/core/constants/api_constants.dart';
import 'package:echoes/data/repositories/playlist_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mocks.dart';

void main() {
  test(
    'song removal uses original indexes and disables fallback replay',
    () async {
      final apiClient = MockSubsonicApiClient();
      final repository = PlaylistRepository(apiClient);
      when(
        () => apiClient.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          allowFallbackRetry: any(named: 'allowFallbackRetry'),
        ),
      ).thenAnswer((_) async => <String, dynamic>{});

      await repository.updatePlaylist(
        playlistId: 'playlist-1',
        songIndexesToRemove: <int>[3, 1],
      );

      final call = verify(
        () => apiClient.get(
          ApiConstants.updatePlaylist,
          queryParameters: captureAny(named: 'queryParameters'),
          allowFallbackRetry: false,
        ),
      );
      final parameters = call.captured.single as Map<String, dynamic>;
      expect(parameters, <String, dynamic>{
        'playlistId': 'playlist-1',
        'songIndexToRemove': <String>['3', '1'],
      });
      verifyNoMoreInteractions(apiClient);
    },
  );
}
