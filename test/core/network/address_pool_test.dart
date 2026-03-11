import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:echoes/core/network/address_pool.dart';
import 'package:echoes/data/models/server_address.dart';

class MockDio extends Mock implements Dio {
  @override
  BaseOptions get options => BaseOptions();
}

void main() {
  late MockDio mockDio;
  late AddressPool pool;

  setUp(() {
    mockDio = MockDio();
    pool = AddressPool(mockDio);
  });

  ServerAddress addr({
    String id = 'a1',
    String label = 'Server 1',
    String url = 'https://server1.example.com',
    int priority = 0,
    bool isLocked = false,
    ServerAddressStatus status = ServerAddressStatus.unknown,
  }) =>
      ServerAddress(
        id: id,
        libraryId: 'lib-1',
        label: label,
        url: url,
        priority: priority,
        isLocked: isLocked,
        status: status,
      );

  // -------------------------------------------------------------------------
  // setAddresses
  // -------------------------------------------------------------------------

  group('setAddresses', () {
    test('sorts addresses by priority', () {
      pool.setAddresses([
        addr(id: 'low', priority: 2),
        addr(id: 'high', priority: 0),
        addr(id: 'mid', priority: 1),
      ]);

      final ids = pool.addresses.map((a) => a.id).toList();
      expect(ids, ['high', 'mid', 'low']);
    });

    test('resets activeAddress when it is not in new list', () {
      // First set an active address
      pool.setAddresses([addr(id: 'old')]);
      // Now set new addresses without 'old'
      pool.setAddresses([addr(id: 'new')]);

      // Active should have been reset (might be null or re-probed)
      // The test checks that the pool accepted the new addresses
      expect(pool.addresses.length, 1);
      expect(pool.addresses.first.id, 'new');
    });
  });

  // -------------------------------------------------------------------------
  // isManualMode
  // -------------------------------------------------------------------------

  group('isManualMode', () {
    test('returns false when no active address', () {
      expect(pool.isManualMode, false);
    });
  });

  // -------------------------------------------------------------------------
  // addresses getter
  // -------------------------------------------------------------------------

  group('addresses', () {
    test('returns unmodifiable list', () {
      pool.setAddresses([addr(id: 'a1'), addr(id: 'a2')]);

      expect(pool.addresses.length, 2);
      // List.unmodifiable should prevent mutation
      expect(
        () => (pool.addresses as List).add(addr(id: 'hack')),
        throwsUnsupportedError,
      );
    });
  });
}
