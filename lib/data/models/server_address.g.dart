// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ServerAddress _$ServerAddressFromJson(Map<String, dynamic> json) =>
    _ServerAddress(
      id: json['id'] as String,
      libraryId: json['libraryId'] as String,
      label: json['label'] as String,
      url: json['url'] as String,
      priority: (json['priority'] as num).toInt(),
      isLocked: json['isLocked'] as bool? ?? false,
      lastLatencyMs: (json['lastLatencyMs'] as num?)?.toInt(),
      status:
          $enumDecodeNullable(_$ServerAddressStatusEnumMap, json['status']) ??
          ServerAddressStatus.unknown,
    );

Map<String, dynamic> _$ServerAddressToJson(_ServerAddress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'libraryId': instance.libraryId,
      'label': instance.label,
      'url': instance.url,
      'priority': instance.priority,
      'isLocked': instance.isLocked,
      'lastLatencyMs': instance.lastLatencyMs,
      'status': _$ServerAddressStatusEnumMap[instance.status]!,
    };

const _$ServerAddressStatusEnumMap = {
  ServerAddressStatus.unknown: 'unknown',
  ServerAddressStatus.ok: 'ok',
  ServerAddressStatus.failed: 'failed',
};
