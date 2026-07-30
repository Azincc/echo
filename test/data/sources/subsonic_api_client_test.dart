import 'package:dio/dio.dart';
import 'package:echoes/core/network/fallback_interceptor.dart';
import 'package:echoes/data/sources/subsonic_api_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('non-idempotent request marker reaches Dio request options', () async {
    final dio = Dio();
    RequestOptions? capturedOptions;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          capturedOptions = options;
          handler.resolve(
            Response<Map<String, dynamic>>(
              requestOptions: options,
              data: <String, dynamic>{
                'subsonic-response': <String, dynamic>{'status': 'ok'},
              },
            ),
          );
        },
      ),
    );
    final client = SubsonicApiClient(dio: dio);

    await client.get('/rest/updatePlaylist', allowFallbackRetry: false);

    expect(
      capturedOptions?.extra[FallbackInterceptor.allowRetryExtraKey],
      isFalse,
    );
  });
}
