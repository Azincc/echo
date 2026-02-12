// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_library.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MusicLibrary _$MusicLibraryFromJson(Map<String, dynamic> json) =>
    _MusicLibrary(
      id: json['id'] as String,
      name: json['name'] as String,
      authType:
          $enumDecodeNullable(
            _$MusicLibraryAuthTypeEnumMap,
            json['authType'],
          ) ??
          MusicLibraryAuthType.token,
      username: json['username'] as String?,
      password: json['password'] as String?,
      apiKey: json['apiKey'] as String?,
      serverType: json['serverType'] as String?,
      serverVersion: json['serverVersion'] as String?,
      isOpenSubsonic: json['isOpenSubsonic'] as bool? ?? false,
      extensions: json['extensions'] as Map<String, dynamic>? ?? const {},
      isActive: json['isActive'] as bool? ?? false,
      addresses:
          (json['addresses'] as List<dynamic>?)
              ?.map((e) => ServerAddress.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$MusicLibraryToJson(_MusicLibrary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'authType': _$MusicLibraryAuthTypeEnumMap[instance.authType]!,
      'username': instance.username,
      'password': instance.password,
      'apiKey': instance.apiKey,
      'serverType': instance.serverType,
      'serverVersion': instance.serverVersion,
      'isOpenSubsonic': instance.isOpenSubsonic,
      'extensions': instance.extensions,
      'isActive': instance.isActive,
      'addresses': instance.addresses,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$MusicLibraryAuthTypeEnumMap = {
  MusicLibraryAuthType.token: 'token',
  MusicLibraryAuthType.apiKey: 'apiKey',
};
