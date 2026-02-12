import 'package:freezed_annotation/freezed_annotation.dart';

part 'server_address.freezed.dart';
part 'server_address.g.dart';

@freezed
sealed class ServerAddress with _$ServerAddress {
  const factory ServerAddress({
    required String id,
    required String libraryId,
    required String label,
    required String url,
    required int priority,
    @Default(false) bool isLocked,
    int? lastLatencyMs,
    @Default(ServerAddressStatus.unknown) ServerAddressStatus status,
  }) = _ServerAddress;

  factory ServerAddress.fromJson(Map<String, dynamic> json) =>
      _$ServerAddressFromJson(json);
}

enum ServerAddressStatus { unknown, ok, failed }
