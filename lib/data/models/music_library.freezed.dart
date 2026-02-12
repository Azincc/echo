// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'music_library.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MusicLibrary {

 String get id; String get name; MusicLibraryAuthType get authType; String? get username; String? get password;// Encrypted
 String? get apiKey;// Encrypted
 String? get serverType; String? get serverVersion; bool get isOpenSubsonic; Map<String, dynamic> get extensions; bool get isActive; List<ServerAddress> get addresses; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of MusicLibrary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MusicLibraryCopyWith<MusicLibrary> get copyWith => _$MusicLibraryCopyWithImpl<MusicLibrary>(this as MusicLibrary, _$identity);

  /// Serializes this MusicLibrary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MusicLibrary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.authType, authType) || other.authType == authType)&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.serverType, serverType) || other.serverType == serverType)&&(identical(other.serverVersion, serverVersion) || other.serverVersion == serverVersion)&&(identical(other.isOpenSubsonic, isOpenSubsonic) || other.isOpenSubsonic == isOpenSubsonic)&&const DeepCollectionEquality().equals(other.extensions, extensions)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other.addresses, addresses)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,authType,username,password,apiKey,serverType,serverVersion,isOpenSubsonic,const DeepCollectionEquality().hash(extensions),isActive,const DeepCollectionEquality().hash(addresses),createdAt,updatedAt);

@override
String toString() {
  return 'MusicLibrary(id: $id, name: $name, authType: $authType, username: $username, password: $password, apiKey: $apiKey, serverType: $serverType, serverVersion: $serverVersion, isOpenSubsonic: $isOpenSubsonic, extensions: $extensions, isActive: $isActive, addresses: $addresses, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $MusicLibraryCopyWith<$Res>  {
  factory $MusicLibraryCopyWith(MusicLibrary value, $Res Function(MusicLibrary) _then) = _$MusicLibraryCopyWithImpl;
@useResult
$Res call({
 String id, String name, MusicLibraryAuthType authType, String? username, String? password, String? apiKey, String? serverType, String? serverVersion, bool isOpenSubsonic, Map<String, dynamic> extensions, bool isActive, List<ServerAddress> addresses, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$MusicLibraryCopyWithImpl<$Res>
    implements $MusicLibraryCopyWith<$Res> {
  _$MusicLibraryCopyWithImpl(this._self, this._then);

  final MusicLibrary _self;
  final $Res Function(MusicLibrary) _then;

/// Create a copy of MusicLibrary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? authType = null,Object? username = freezed,Object? password = freezed,Object? apiKey = freezed,Object? serverType = freezed,Object? serverVersion = freezed,Object? isOpenSubsonic = null,Object? extensions = null,Object? isActive = null,Object? addresses = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,authType: null == authType ? _self.authType : authType // ignore: cast_nullable_to_non_nullable
as MusicLibraryAuthType,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,apiKey: freezed == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String?,serverType: freezed == serverType ? _self.serverType : serverType // ignore: cast_nullable_to_non_nullable
as String?,serverVersion: freezed == serverVersion ? _self.serverVersion : serverVersion // ignore: cast_nullable_to_non_nullable
as String?,isOpenSubsonic: null == isOpenSubsonic ? _self.isOpenSubsonic : isOpenSubsonic // ignore: cast_nullable_to_non_nullable
as bool,extensions: null == extensions ? _self.extensions : extensions // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,addresses: null == addresses ? _self.addresses : addresses // ignore: cast_nullable_to_non_nullable
as List<ServerAddress>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [MusicLibrary].
extension MusicLibraryPatterns on MusicLibrary {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MusicLibrary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MusicLibrary() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MusicLibrary value)  $default,){
final _that = this;
switch (_that) {
case _MusicLibrary():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MusicLibrary value)?  $default,){
final _that = this;
switch (_that) {
case _MusicLibrary() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  MusicLibraryAuthType authType,  String? username,  String? password,  String? apiKey,  String? serverType,  String? serverVersion,  bool isOpenSubsonic,  Map<String, dynamic> extensions,  bool isActive,  List<ServerAddress> addresses,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MusicLibrary() when $default != null:
return $default(_that.id,_that.name,_that.authType,_that.username,_that.password,_that.apiKey,_that.serverType,_that.serverVersion,_that.isOpenSubsonic,_that.extensions,_that.isActive,_that.addresses,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  MusicLibraryAuthType authType,  String? username,  String? password,  String? apiKey,  String? serverType,  String? serverVersion,  bool isOpenSubsonic,  Map<String, dynamic> extensions,  bool isActive,  List<ServerAddress> addresses,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _MusicLibrary():
return $default(_that.id,_that.name,_that.authType,_that.username,_that.password,_that.apiKey,_that.serverType,_that.serverVersion,_that.isOpenSubsonic,_that.extensions,_that.isActive,_that.addresses,_that.createdAt,_that.updatedAt);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  MusicLibraryAuthType authType,  String? username,  String? password,  String? apiKey,  String? serverType,  String? serverVersion,  bool isOpenSubsonic,  Map<String, dynamic> extensions,  bool isActive,  List<ServerAddress> addresses,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _MusicLibrary() when $default != null:
return $default(_that.id,_that.name,_that.authType,_that.username,_that.password,_that.apiKey,_that.serverType,_that.serverVersion,_that.isOpenSubsonic,_that.extensions,_that.isActive,_that.addresses,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MusicLibrary implements MusicLibrary {
  const _MusicLibrary({required this.id, required this.name, this.authType = MusicLibraryAuthType.token, this.username, this.password, this.apiKey, this.serverType, this.serverVersion, this.isOpenSubsonic = false, final  Map<String, dynamic> extensions = const {}, this.isActive = false, final  List<ServerAddress> addresses = const [], required this.createdAt, required this.updatedAt}): _extensions = extensions,_addresses = addresses;
  factory _MusicLibrary.fromJson(Map<String, dynamic> json) => _$MusicLibraryFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  MusicLibraryAuthType authType;
@override final  String? username;
@override final  String? password;
// Encrypted
@override final  String? apiKey;
// Encrypted
@override final  String? serverType;
@override final  String? serverVersion;
@override@JsonKey() final  bool isOpenSubsonic;
 final  Map<String, dynamic> _extensions;
@override@JsonKey() Map<String, dynamic> get extensions {
  if (_extensions is EqualUnmodifiableMapView) return _extensions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_extensions);
}

@override@JsonKey() final  bool isActive;
 final  List<ServerAddress> _addresses;
@override@JsonKey() List<ServerAddress> get addresses {
  if (_addresses is EqualUnmodifiableListView) return _addresses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_addresses);
}

@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of MusicLibrary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MusicLibraryCopyWith<_MusicLibrary> get copyWith => __$MusicLibraryCopyWithImpl<_MusicLibrary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MusicLibraryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MusicLibrary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.authType, authType) || other.authType == authType)&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.serverType, serverType) || other.serverType == serverType)&&(identical(other.serverVersion, serverVersion) || other.serverVersion == serverVersion)&&(identical(other.isOpenSubsonic, isOpenSubsonic) || other.isOpenSubsonic == isOpenSubsonic)&&const DeepCollectionEquality().equals(other._extensions, _extensions)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other._addresses, _addresses)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,authType,username,password,apiKey,serverType,serverVersion,isOpenSubsonic,const DeepCollectionEquality().hash(_extensions),isActive,const DeepCollectionEquality().hash(_addresses),createdAt,updatedAt);

@override
String toString() {
  return 'MusicLibrary(id: $id, name: $name, authType: $authType, username: $username, password: $password, apiKey: $apiKey, serverType: $serverType, serverVersion: $serverVersion, isOpenSubsonic: $isOpenSubsonic, extensions: $extensions, isActive: $isActive, addresses: $addresses, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$MusicLibraryCopyWith<$Res> implements $MusicLibraryCopyWith<$Res> {
  factory _$MusicLibraryCopyWith(_MusicLibrary value, $Res Function(_MusicLibrary) _then) = __$MusicLibraryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, MusicLibraryAuthType authType, String? username, String? password, String? apiKey, String? serverType, String? serverVersion, bool isOpenSubsonic, Map<String, dynamic> extensions, bool isActive, List<ServerAddress> addresses, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$MusicLibraryCopyWithImpl<$Res>
    implements _$MusicLibraryCopyWith<$Res> {
  __$MusicLibraryCopyWithImpl(this._self, this._then);

  final _MusicLibrary _self;
  final $Res Function(_MusicLibrary) _then;

/// Create a copy of MusicLibrary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? authType = null,Object? username = freezed,Object? password = freezed,Object? apiKey = freezed,Object? serverType = freezed,Object? serverVersion = freezed,Object? isOpenSubsonic = null,Object? extensions = null,Object? isActive = null,Object? addresses = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_MusicLibrary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,authType: null == authType ? _self.authType : authType // ignore: cast_nullable_to_non_nullable
as MusicLibraryAuthType,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,apiKey: freezed == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String?,serverType: freezed == serverType ? _self.serverType : serverType // ignore: cast_nullable_to_non_nullable
as String?,serverVersion: freezed == serverVersion ? _self.serverVersion : serverVersion // ignore: cast_nullable_to_non_nullable
as String?,isOpenSubsonic: null == isOpenSubsonic ? _self.isOpenSubsonic : isOpenSubsonic // ignore: cast_nullable_to_non_nullable
as bool,extensions: null == extensions ? _self._extensions : extensions // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,addresses: null == addresses ? _self._addresses : addresses // ignore: cast_nullable_to_non_nullable
as List<ServerAddress>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
