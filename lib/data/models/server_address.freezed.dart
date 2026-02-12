// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'server_address.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ServerAddress {

 String get id; String get libraryId; String get label; String get url; int get priority; bool get isLocked; int? get lastLatencyMs; ServerAddressStatus get status;
/// Create a copy of ServerAddress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerAddressCopyWith<ServerAddress> get copyWith => _$ServerAddressCopyWithImpl<ServerAddress>(this as ServerAddress, _$identity);

  /// Serializes this ServerAddress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerAddress&&(identical(other.id, id) || other.id == id)&&(identical(other.libraryId, libraryId) || other.libraryId == libraryId)&&(identical(other.label, label) || other.label == label)&&(identical(other.url, url) || other.url == url)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.lastLatencyMs, lastLatencyMs) || other.lastLatencyMs == lastLatencyMs)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,libraryId,label,url,priority,isLocked,lastLatencyMs,status);

@override
String toString() {
  return 'ServerAddress(id: $id, libraryId: $libraryId, label: $label, url: $url, priority: $priority, isLocked: $isLocked, lastLatencyMs: $lastLatencyMs, status: $status)';
}


}

/// @nodoc
abstract mixin class $ServerAddressCopyWith<$Res>  {
  factory $ServerAddressCopyWith(ServerAddress value, $Res Function(ServerAddress) _then) = _$ServerAddressCopyWithImpl;
@useResult
$Res call({
 String id, String libraryId, String label, String url, int priority, bool isLocked, int? lastLatencyMs, ServerAddressStatus status
});




}
/// @nodoc
class _$ServerAddressCopyWithImpl<$Res>
    implements $ServerAddressCopyWith<$Res> {
  _$ServerAddressCopyWithImpl(this._self, this._then);

  final ServerAddress _self;
  final $Res Function(ServerAddress) _then;

/// Create a copy of ServerAddress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? libraryId = null,Object? label = null,Object? url = null,Object? priority = null,Object? isLocked = null,Object? lastLatencyMs = freezed,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,libraryId: null == libraryId ? _self.libraryId : libraryId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,lastLatencyMs: freezed == lastLatencyMs ? _self.lastLatencyMs : lastLatencyMs // ignore: cast_nullable_to_non_nullable
as int?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ServerAddressStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [ServerAddress].
extension ServerAddressPatterns on ServerAddress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServerAddress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServerAddress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServerAddress value)  $default,){
final _that = this;
switch (_that) {
case _ServerAddress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServerAddress value)?  $default,){
final _that = this;
switch (_that) {
case _ServerAddress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String libraryId,  String label,  String url,  int priority,  bool isLocked,  int? lastLatencyMs,  ServerAddressStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServerAddress() when $default != null:
return $default(_that.id,_that.libraryId,_that.label,_that.url,_that.priority,_that.isLocked,_that.lastLatencyMs,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String libraryId,  String label,  String url,  int priority,  bool isLocked,  int? lastLatencyMs,  ServerAddressStatus status)  $default,) {final _that = this;
switch (_that) {
case _ServerAddress():
return $default(_that.id,_that.libraryId,_that.label,_that.url,_that.priority,_that.isLocked,_that.lastLatencyMs,_that.status);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String libraryId,  String label,  String url,  int priority,  bool isLocked,  int? lastLatencyMs,  ServerAddressStatus status)?  $default,) {final _that = this;
switch (_that) {
case _ServerAddress() when $default != null:
return $default(_that.id,_that.libraryId,_that.label,_that.url,_that.priority,_that.isLocked,_that.lastLatencyMs,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServerAddress implements ServerAddress {
  const _ServerAddress({required this.id, required this.libraryId, required this.label, required this.url, required this.priority, this.isLocked = false, this.lastLatencyMs, this.status = ServerAddressStatus.unknown});
  factory _ServerAddress.fromJson(Map<String, dynamic> json) => _$ServerAddressFromJson(json);

@override final  String id;
@override final  String libraryId;
@override final  String label;
@override final  String url;
@override final  int priority;
@override@JsonKey() final  bool isLocked;
@override final  int? lastLatencyMs;
@override@JsonKey() final  ServerAddressStatus status;

/// Create a copy of ServerAddress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServerAddressCopyWith<_ServerAddress> get copyWith => __$ServerAddressCopyWithImpl<_ServerAddress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServerAddressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServerAddress&&(identical(other.id, id) || other.id == id)&&(identical(other.libraryId, libraryId) || other.libraryId == libraryId)&&(identical(other.label, label) || other.label == label)&&(identical(other.url, url) || other.url == url)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.lastLatencyMs, lastLatencyMs) || other.lastLatencyMs == lastLatencyMs)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,libraryId,label,url,priority,isLocked,lastLatencyMs,status);

@override
String toString() {
  return 'ServerAddress(id: $id, libraryId: $libraryId, label: $label, url: $url, priority: $priority, isLocked: $isLocked, lastLatencyMs: $lastLatencyMs, status: $status)';
}


}

/// @nodoc
abstract mixin class _$ServerAddressCopyWith<$Res> implements $ServerAddressCopyWith<$Res> {
  factory _$ServerAddressCopyWith(_ServerAddress value, $Res Function(_ServerAddress) _then) = __$ServerAddressCopyWithImpl;
@override @useResult
$Res call({
 String id, String libraryId, String label, String url, int priority, bool isLocked, int? lastLatencyMs, ServerAddressStatus status
});




}
/// @nodoc
class __$ServerAddressCopyWithImpl<$Res>
    implements _$ServerAddressCopyWith<$Res> {
  __$ServerAddressCopyWithImpl(this._self, this._then);

  final _ServerAddress _self;
  final $Res Function(_ServerAddress) _then;

/// Create a copy of ServerAddress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? libraryId = null,Object? label = null,Object? url = null,Object? priority = null,Object? isLocked = null,Object? lastLatencyMs = freezed,Object? status = null,}) {
  return _then(_ServerAddress(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,libraryId: null == libraryId ? _self.libraryId : libraryId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,lastLatencyMs: freezed == lastLatencyMs ? _self.lastLatencyMs : lastLatencyMs // ignore: cast_nullable_to_non_nullable
as int?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ServerAddressStatus,
  ));
}


}

// dart format on
