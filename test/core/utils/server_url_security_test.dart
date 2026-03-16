import 'package:echoes/core/utils/server_url_security.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isSupportedServerUrl', () {
    test('accepts http and https urls', () {
      expect(isSupportedServerUrl('http://192.168.1.5:4533'), isTrue);
      expect(isSupportedServerUrl('https://music.example.com'), isTrue);
    });

    test('rejects urls without a supported scheme', () {
      expect(isSupportedServerUrl('music.example.com'), isFalse);
      expect(isSupportedServerUrl('ftp://music.example.com'), isFalse);
      expect(isSupportedServerUrl('https:///missing-host'), isFalse);
    });
  });

  group('isInsecureHttpUrl', () {
    test('detects cleartext http even with surrounding whitespace', () {
      expect(isInsecureHttpUrl('  http://nas.local:4533  '), isTrue);
    });

    test('does not flag https or invalid urls', () {
      expect(isInsecureHttpUrl('https://music.example.com'), isFalse);
      expect(isInsecureHttpUrl('not a url'), isFalse);
    });
  });
}
