// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'multiple_constructors.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EjectCaseToPart {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is EjectCaseToPart);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EjectCaseToPart()';
  }
}

/// @nodoc
class $EjectCaseToPartCopyWith<$Res> {
  $EjectCaseToPartCopyWith(
      EjectCaseToPart _, $Res Function(EjectCaseToPart) __);
}

/// Adds pattern-matching-related methods to [EjectCaseToPart].
extension EjectCaseToPartPatterns on EjectCaseToPart {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EjectedToPart value)? a,
    TResult Function(EjectedToLocal value)? b,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case EjectedToPart() when a != null:
        return a(_that);
      case EjectedToLocal() when b != null:
        return b(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EjectedToPart value) a,
    required TResult Function(EjectedToLocal value) b,
  }) {
    final _that = this;
    switch (_that) {
      case EjectedToPart():
        return a(_that);
      case EjectedToLocal():
        return b(_that);
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EjectedToPart value)? a,
    TResult? Function(EjectedToLocal value)? b,
  }) {
    final _that = this;
    switch (_that) {
      case EjectedToPart() when a != null:
        return a(_that);
      case EjectedToLocal() when b != null:
        return b(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? a,
    TResult Function()? b,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case EjectedToPart() when a != null:
        return a();
      case EjectedToLocal() when b != null:
        return b();
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() a,
    required TResult Function() b,
  }) {
    final _that = this;
    switch (_that) {
      case EjectedToPart():
        return a();
      case EjectedToLocal():
        return b();
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? a,
    TResult? Function()? b,
  }) {
    final _that = this;
    switch (_that) {
      case EjectedToPart() when a != null:
        return a();
      case EjectedToLocal() when b != null:
        return b();
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$PrivateUnion {
  int get value;

  /// Create a copy of PrivateUnion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PrivateUnionCopyWith<PrivateUnion> get copyWith =>
      _$PrivateUnionCopyWithImpl<PrivateUnion>(
          this as PrivateUnion, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PrivateUnion &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'PrivateUnion(value: $value)';
  }
}

/// @nodoc
abstract mixin class $PrivateUnionCopyWith<$Res> {
  factory $PrivateUnionCopyWith(
          PrivateUnion value, $Res Function(PrivateUnion) _then) =
      _$PrivateUnionCopyWithImpl;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$PrivateUnionCopyWithImpl<$Res> implements $PrivateUnionCopyWith<$Res> {
  _$PrivateUnionCopyWithImpl(this._self, this._then);

  final PrivateUnion _self;
  final $Res Function(PrivateUnion) _then;

  /// Create a copy of PrivateUnion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_self.copyWith(
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _PrivateUnion implements PrivateUnion {
  const _PrivateUnion(this.value);

  @override
  final int value;

  /// Create a copy of PrivateUnion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PrivateUnionCopyWith<_PrivateUnion> get copyWith =>
      __$PrivateUnionCopyWithImpl<_PrivateUnion>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PrivateUnion &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'PrivateUnion._(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$PrivateUnionCopyWith<$Res>
    implements $PrivateUnionCopyWith<$Res> {
  factory _$PrivateUnionCopyWith(
          _PrivateUnion value, $Res Function(_PrivateUnion) _then) =
      __$PrivateUnionCopyWithImpl;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$PrivateUnionCopyWithImpl<$Res>
    implements _$PrivateUnionCopyWith<$Res> {
  __$PrivateUnionCopyWithImpl(this._self, this._then);

  final _PrivateUnion _self;
  final $Res Function(_PrivateUnion) _then;

  /// Create a copy of PrivateUnion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_PrivateUnion(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _PrivateUnionB implements PrivateUnion {
  const _PrivateUnionB(this.value);

  @override
  final int value;

  /// Create a copy of PrivateUnion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PrivateUnionBCopyWith<_PrivateUnionB> get copyWith =>
      __$PrivateUnionBCopyWithImpl<_PrivateUnionB>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PrivateUnionB &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'PrivateUnion._b(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$PrivateUnionBCopyWith<$Res>
    implements $PrivateUnionCopyWith<$Res> {
  factory _$PrivateUnionBCopyWith(
          _PrivateUnionB value, $Res Function(_PrivateUnionB) _then) =
      __$PrivateUnionBCopyWithImpl;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$PrivateUnionBCopyWithImpl<$Res>
    implements _$PrivateUnionBCopyWith<$Res> {
  __$PrivateUnionBCopyWithImpl(this._self, this._then);

  final _PrivateUnionB _self;
  final $Res Function(_PrivateUnionB) _then;

  /// Create a copy of PrivateUnion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_PrivateUnionB(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$Response<T> {
  DateTime get time;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Response<T> &&
            (identical(other.time, time) || other.time == time));
  }

  @override
  int get hashCode => Object.hash(runtimeType, time);

  @override
  String toString() {
    return 'Response<$T>(time: $time)';
  }
}

/// @nodoc
class $ResponseCopyWith<T, $Res> {
  $ResponseCopyWith(Response<T> _, $Res Function(Response<T>) __);
}

/// Adds pattern-matching-related methods to [Response].
extension ResponsePatterns<T> on Response<T> {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResponseData<T> value)? data,
    TResult Function(ResponseError<T> value)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ResponseData() when data != null:
        return data(_that);
      case ResponseError() when error != null:
        return error(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ResponseData<T> value) data,
    required TResult Function(ResponseError<T> value) error,
  }) {
    final _that = this;
    switch (_that) {
      case ResponseData():
        return data(_that);
      case ResponseError():
        return error(_that);
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ResponseData<T> value)? data,
    TResult? Function(ResponseError<T> value)? error,
  }) {
    final _that = this;
    switch (_that) {
      case ResponseData() when data != null:
        return data(_that);
      case ResponseError() when error != null:
        return error(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T value, DateTime? time)? data,
    TResult Function(Object error)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ResponseData() when data != null:
        return data(_that.value, _that.time);
      case ResponseError() when error != null:
        return error(_that.error);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T value, DateTime? time) data,
    required TResult Function(Object error) error,
  }) {
    final _that = this;
    switch (_that) {
      case ResponseData():
        return data(_that.value, _that.time);
      case ResponseError():
        return error(_that.error);
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T value, DateTime? time)? data,
    TResult? Function(Object error)? error,
  }) {
    final _that = this;
    switch (_that) {
      case ResponseData() when data != null:
        return data(_that.value, _that.time);
      case ResponseError() when error != null:
        return error(_that.error);
      case _:
        return null;
    }
  }
}

/// @nodoc

class ResponseData<T> extends Response<T> {
  ResponseData(this.value, {final DateTime? time}) : super._(time: time);

  final T value;

  /// Create a copy of Response
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ResponseDataCopyWith<T, ResponseData<T>> get copyWith =>
      _$ResponseDataCopyWithImpl<T, ResponseData<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ResponseData<T> &&
            const DeepCollectionEquality().equals(other.value, value) &&
            (identical(other.time, time) || other.time == time));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(value), time);

  @override
  String toString() {
    return 'Response<$T>.data(value: $value, time: $time)';
  }
}

/// @nodoc
abstract mixin class $ResponseDataCopyWith<T, $Res>
    implements $ResponseCopyWith<T, $Res> {
  factory $ResponseDataCopyWith(
          ResponseData<T> value, $Res Function(ResponseData<T>) _then) =
      _$ResponseDataCopyWithImpl;
  @useResult
  $Res call({T value, DateTime? time});
}

/// @nodoc
class _$ResponseDataCopyWithImpl<T, $Res>
    implements $ResponseDataCopyWith<T, $Res> {
  _$ResponseDataCopyWithImpl(this._self, this._then);

  final ResponseData<T> _self;
  final $Res Function(ResponseData<T>) _then;

  /// Create a copy of Response
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = freezed,
    Object? time = freezed,
  }) {
    return _then(ResponseData<T>(
      freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
      time: freezed == time
          ? _self.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class ResponseError<T> extends Response<T> {
  ResponseError(this.error) : super._();

  final Object error;

  /// Create a copy of Response
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ResponseErrorCopyWith<T, ResponseError<T>> get copyWith =>
      _$ResponseErrorCopyWithImpl<T, ResponseError<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ResponseError<T> &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @override
  String toString() {
    return 'Response<$T>.error(error: $error)';
  }
}

/// @nodoc
abstract mixin class $ResponseErrorCopyWith<T, $Res>
    implements $ResponseCopyWith<T, $Res> {
  factory $ResponseErrorCopyWith(
          ResponseError<T> value, $Res Function(ResponseError<T>) _then) =
      _$ResponseErrorCopyWithImpl;
  @useResult
  $Res call({Object error});
}

/// @nodoc
class _$ResponseErrorCopyWithImpl<T, $Res>
    implements $ResponseErrorCopyWith<T, $Res> {
  _$ResponseErrorCopyWithImpl(this._self, this._then);

  final ResponseError<T> _self;
  final $Res Function(ResponseError<T>) _then;

  /// Create a copy of Response
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? error = null,
  }) {
    return _then(ResponseError<T>(
      null == error ? _self.error : error,
    ));
  }
}

/// @nodoc
mixin _$ManualPositionInAnyOrder {
  String get a;
  int get b;

  /// Create a copy of ManualPositionInAnyOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ManualPositionInAnyOrderCopyWith<ManualPositionInAnyOrder> get copyWith =>
      _$ManualPositionInAnyOrderCopyWithImpl<ManualPositionInAnyOrder>(
          this as ManualPositionInAnyOrder, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ManualPositionInAnyOrder &&
            (identical(other.a, a) || other.a == a) &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a, b);

  @override
  String toString() {
    return 'ManualPositionInAnyOrder(a: $a, b: $b)';
  }
}

/// @nodoc
abstract mixin class $ManualPositionInAnyOrderCopyWith<$Res> {
  factory $ManualPositionInAnyOrderCopyWith(ManualPositionInAnyOrder value,
          $Res Function(ManualPositionInAnyOrder) _then) =
      _$ManualPositionInAnyOrderCopyWithImpl;
  @useResult
  $Res call({String a, int b});
}

/// @nodoc
class _$ManualPositionInAnyOrderCopyWithImpl<$Res>
    implements $ManualPositionInAnyOrderCopyWith<$Res> {
  _$ManualPositionInAnyOrderCopyWithImpl(this._self, this._then);

  final ManualPositionInAnyOrder _self;
  final $Res Function(ManualPositionInAnyOrder) _then;

  /// Create a copy of ManualPositionInAnyOrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? a = null,
    Object? b = null,
  }) {
    return _then(_self.copyWith(
      a: null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
      b: null == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [ManualPositionInAnyOrder].
extension ManualPositionInAnyOrderPatterns on ManualPositionInAnyOrder {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ManualPositionInAnyOrder value)? $default, {
    TResult Function(_ManualPositionInAnyOrder2 value)? other,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ManualPositionInAnyOrder() when $default != null:
        return $default(_that);
      case _ManualPositionInAnyOrder2() when other != null:
        return other(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ManualPositionInAnyOrder value) $default, {
    required TResult Function(_ManualPositionInAnyOrder2 value) other,
  }) {
    final _that = this;
    switch (_that) {
      case _ManualPositionInAnyOrder():
        return $default(_that);
      case _ManualPositionInAnyOrder2():
        return other(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ManualPositionInAnyOrder value)? $default, {
    TResult? Function(_ManualPositionInAnyOrder2 value)? other,
  }) {
    final _that = this;
    switch (_that) {
      case _ManualPositionInAnyOrder() when $default != null:
        return $default(_that);
      case _ManualPositionInAnyOrder2() when other != null:
        return other(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String a, int b)? $default, {
    TResult Function(int b, String a)? other,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ManualPositionInAnyOrder() when $default != null:
        return $default(_that.a, _that.b);
      case _ManualPositionInAnyOrder2() when other != null:
        return other(_that.b, _that.a);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String a, int b) $default, {
    required TResult Function(int b, String a) other,
  }) {
    final _that = this;
    switch (_that) {
      case _ManualPositionInAnyOrder():
        return $default(_that.a, _that.b);
      case _ManualPositionInAnyOrder2():
        return other(_that.b, _that.a);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String a, int b)? $default, {
    TResult? Function(int b, String a)? other,
  }) {
    final _that = this;
    switch (_that) {
      case _ManualPositionInAnyOrder() when $default != null:
        return $default(_that.a, _that.b);
      case _ManualPositionInAnyOrder2() when other != null:
        return other(_that.b, _that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ManualPositionInAnyOrder extends ManualPositionInAnyOrder {
  const _ManualPositionInAnyOrder(final String a, final int b) : super._(a, b);

  /// Create a copy of ManualPositionInAnyOrder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ManualPositionInAnyOrderCopyWith<_ManualPositionInAnyOrder> get copyWith =>
      __$ManualPositionInAnyOrderCopyWithImpl<_ManualPositionInAnyOrder>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ManualPositionInAnyOrder &&
            (identical(other.a, a) || other.a == a) &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a, b);

  @override
  String toString() {
    return 'ManualPositionInAnyOrder(a: $a, b: $b)';
  }
}

/// @nodoc
abstract mixin class _$ManualPositionInAnyOrderCopyWith<$Res>
    implements $ManualPositionInAnyOrderCopyWith<$Res> {
  factory _$ManualPositionInAnyOrderCopyWith(_ManualPositionInAnyOrder value,
          $Res Function(_ManualPositionInAnyOrder) _then) =
      __$ManualPositionInAnyOrderCopyWithImpl;
  @override
  @useResult
  $Res call({String a, int b});
}

/// @nodoc
class __$ManualPositionInAnyOrderCopyWithImpl<$Res>
    implements _$ManualPositionInAnyOrderCopyWith<$Res> {
  __$ManualPositionInAnyOrderCopyWithImpl(this._self, this._then);

  final _ManualPositionInAnyOrder _self;
  final $Res Function(_ManualPositionInAnyOrder) _then;

  /// Create a copy of ManualPositionInAnyOrder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
    Object? b = null,
  }) {
    return _then(_ManualPositionInAnyOrder(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
      null == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _ManualPositionInAnyOrder2 extends ManualPositionInAnyOrder {
  const _ManualPositionInAnyOrder2(final int b, final String a) : super._(a, b);

  /// Create a copy of ManualPositionInAnyOrder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ManualPositionInAnyOrder2CopyWith<_ManualPositionInAnyOrder2>
      get copyWith =>
          __$ManualPositionInAnyOrder2CopyWithImpl<_ManualPositionInAnyOrder2>(
              this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ManualPositionInAnyOrder2 &&
            (identical(other.b, b) || other.b == b) &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, b, a);

  @override
  String toString() {
    return 'ManualPositionInAnyOrder.other(b: $b, a: $a)';
  }
}

/// @nodoc
abstract mixin class _$ManualPositionInAnyOrder2CopyWith<$Res>
    implements $ManualPositionInAnyOrderCopyWith<$Res> {
  factory _$ManualPositionInAnyOrder2CopyWith(_ManualPositionInAnyOrder2 value,
          $Res Function(_ManualPositionInAnyOrder2) _then) =
      __$ManualPositionInAnyOrder2CopyWithImpl;
  @override
  @useResult
  $Res call({int b, String a});
}

/// @nodoc
class __$ManualPositionInAnyOrder2CopyWithImpl<$Res>
    implements _$ManualPositionInAnyOrder2CopyWith<$Res> {
  __$ManualPositionInAnyOrder2CopyWithImpl(this._self, this._then);

  final _ManualPositionInAnyOrder2 _self;
  final $Res Function(_ManualPositionInAnyOrder2) _then;

  /// Create a copy of ManualPositionInAnyOrder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? b = null,
    Object? a = null,
  }) {
    return _then(_ManualPositionInAnyOrder2(
      null == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as int,
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$ManualNamedOptionalProperty {
  int get value;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ManualNamedOptionalProperty &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'ManualNamedOptionalProperty(value: $value)';
  }
}

/// @nodoc
class $ManualNamedOptionalPropertyCopyWith<$Res> {
  $ManualNamedOptionalPropertyCopyWith(ManualNamedOptionalProperty _,
      $Res Function(ManualNamedOptionalProperty) __);
}

/// Adds pattern-matching-related methods to [ManualNamedOptionalProperty].
extension ManualNamedOptionalPropertyPatterns on ManualNamedOptionalProperty {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ManualNamedProperty value)? $default, {
    TResult Function(_ManualNamedPropertyA value)? a,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ManualNamedProperty() when $default != null:
        return $default(_that);
      case _ManualNamedPropertyA() when a != null:
        return a(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ManualNamedProperty value) $default, {
    required TResult Function(_ManualNamedPropertyA value) a,
  }) {
    final _that = this;
    switch (_that) {
      case _ManualNamedProperty():
        return $default(_that);
      case _ManualNamedPropertyA():
        return a(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ManualNamedProperty value)? $default, {
    TResult? Function(_ManualNamedPropertyA value)? a,
  }) {
    final _that = this;
    switch (_that) {
      case _ManualNamedProperty() when $default != null:
        return $default(_that);
      case _ManualNamedPropertyA() when a != null:
        return a(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int value)? $default, {
    TResult Function()? a,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ManualNamedProperty() when $default != null:
        return $default(_that.value);
      case _ManualNamedPropertyA() when a != null:
        return a();
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int value) $default, {
    required TResult Function() a,
  }) {
    final _that = this;
    switch (_that) {
      case _ManualNamedProperty():
        return $default(_that.value);
      case _ManualNamedPropertyA():
        return a();
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int value)? $default, {
    TResult? Function()? a,
  }) {
    final _that = this;
    switch (_that) {
      case _ManualNamedProperty() when $default != null:
        return $default(_that.value);
      case _ManualNamedPropertyA() when a != null:
        return a();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ManualNamedProperty extends ManualNamedOptionalProperty {
  const _ManualNamedProperty(final int value) : super._(value: value);

  /// Create a copy of ManualNamedOptionalProperty
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ManualNamedPropertyCopyWith<_ManualNamedProperty> get copyWith =>
      __$ManualNamedPropertyCopyWithImpl<_ManualNamedProperty>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ManualNamedProperty &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'ManualNamedOptionalProperty(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$ManualNamedPropertyCopyWith<$Res>
    implements $ManualNamedOptionalPropertyCopyWith<$Res> {
  factory _$ManualNamedPropertyCopyWith(_ManualNamedProperty value,
          $Res Function(_ManualNamedProperty) _then) =
      __$ManualNamedPropertyCopyWithImpl;
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$ManualNamedPropertyCopyWithImpl<$Res>
    implements _$ManualNamedPropertyCopyWith<$Res> {
  __$ManualNamedPropertyCopyWithImpl(this._self, this._then);

  final _ManualNamedProperty _self;
  final $Res Function(_ManualNamedProperty) _then;

  /// Create a copy of ManualNamedOptionalProperty
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_ManualNamedProperty(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _ManualNamedPropertyA extends ManualNamedOptionalProperty {
  const _ManualNamedPropertyA() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ManualNamedPropertyA);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ManualNamedOptionalProperty.a()';
  }
}

/// @nodoc
mixin _$Subclass {
// Check that no @override is nu
  int get value;

  /// Create a copy of Subclass
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SubclassCopyWith<Subclass> get copyWith =>
      _$SubclassCopyWithImpl<Subclass>(this as Subclass, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Subclass &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'Subclass(value: $value)';
  }
}

/// @nodoc
abstract mixin class $SubclassCopyWith<$Res> {
  factory $SubclassCopyWith(Subclass value, $Res Function(Subclass) _then) =
      _$SubclassCopyWithImpl;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$SubclassCopyWithImpl<$Res> implements $SubclassCopyWith<$Res> {
  _$SubclassCopyWithImpl(this._self, this._then);

  final Subclass _self;
  final $Res Function(Subclass) _then;

  /// Create a copy of Subclass
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_self.copyWith(
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [Subclass].
extension SubclassPatterns on Subclass {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SubclassA value)? a,
    TResult Function(_SubclassB value)? b,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SubclassA() when a != null:
        return a(_that);
      case _SubclassB() when b != null:
        return b(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SubclassA value) a,
    required TResult Function(_SubclassB value) b,
  }) {
    final _that = this;
    switch (_that) {
      case _SubclassA():
        return a(_that);
      case _SubclassB():
        return b(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SubclassA value)? a,
    TResult? Function(_SubclassB value)? b,
  }) {
    final _that = this;
    switch (_that) {
      case _SubclassA() when a != null:
        return a(_that);
      case _SubclassB() when b != null:
        return b(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int value)? a,
    TResult Function(int value)? b,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SubclassA() when a != null:
        return a(_that.value);
      case _SubclassB() when b != null:
        return b(_that.value);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int value) a,
    required TResult Function(int value) b,
  }) {
    final _that = this;
    switch (_that) {
      case _SubclassA():
        return a(_that.value);
      case _SubclassB():
        return b(_that.value);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int value)? a,
    TResult? Function(int value)? b,
  }) {
    final _that = this;
    switch (_that) {
      case _SubclassA() when a != null:
        return a(_that.value);
      case _SubclassB() when b != null:
        return b(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SubclassA extends Subclass {
  const _SubclassA(final int value) : super._(value: value);

  /// Create a copy of Subclass
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SubclassACopyWith<_SubclassA> get copyWith =>
      __$SubclassACopyWithImpl<_SubclassA>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SubclassA &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'Subclass.a(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$SubclassACopyWith<$Res>
    implements $SubclassCopyWith<$Res> {
  factory _$SubclassACopyWith(
          _SubclassA value, $Res Function(_SubclassA) _then) =
      __$SubclassACopyWithImpl;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$SubclassACopyWithImpl<$Res> implements _$SubclassACopyWith<$Res> {
  __$SubclassACopyWithImpl(this._self, this._then);

  final _SubclassA _self;
  final $Res Function(_SubclassA) _then;

  /// Create a copy of Subclass
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_SubclassA(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _SubclassB extends Subclass {
  const _SubclassB(final int value) : super._(value: value);

  /// Create a copy of Subclass
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SubclassBCopyWith<_SubclassB> get copyWith =>
      __$SubclassBCopyWithImpl<_SubclassB>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SubclassB &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'Subclass.b(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$SubclassBCopyWith<$Res>
    implements $SubclassCopyWith<$Res> {
  factory _$SubclassBCopyWith(
          _SubclassB value, $Res Function(_SubclassB) _then) =
      __$SubclassBCopyWithImpl;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$SubclassBCopyWithImpl<$Res> implements _$SubclassBCopyWith<$Res> {
  __$SubclassBCopyWithImpl(this._self, this._then);

  final _SubclassB _self;
  final $Res Function(_SubclassB) _then;

  /// Create a copy of Subclass
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_SubclassB(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$UnfreezedImmutableUnion {
  String get a;

  /// Create a copy of UnfreezedImmutableUnion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnfreezedImmutableUnionCopyWith<UnfreezedImmutableUnion> get copyWith =>
      _$UnfreezedImmutableUnionCopyWithImpl<UnfreezedImmutableUnion>(
          this as UnfreezedImmutableUnion, _$identity);

  @override
  String toString() {
    return 'UnfreezedImmutableUnion(a: $a)';
  }
}

/// @nodoc
abstract mixin class $UnfreezedImmutableUnionCopyWith<$Res> {
  factory $UnfreezedImmutableUnionCopyWith(UnfreezedImmutableUnion value,
          $Res Function(UnfreezedImmutableUnion) _then) =
      _$UnfreezedImmutableUnionCopyWithImpl;
  @useResult
  $Res call({String a});
}

/// @nodoc
class _$UnfreezedImmutableUnionCopyWithImpl<$Res>
    implements $UnfreezedImmutableUnionCopyWith<$Res> {
  _$UnfreezedImmutableUnionCopyWithImpl(this._self, this._then);

  final UnfreezedImmutableUnion _self;
  final $Res Function(UnfreezedImmutableUnion) _then;

  /// Create a copy of UnfreezedImmutableUnion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? a = null,
  }) {
    return _then(_self.copyWith(
      a: null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [UnfreezedImmutableUnion].
extension UnfreezedImmutableUnionPatterns on UnfreezedImmutableUnion {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(DirectUnfreezedImmutableUnion value)? $default, {
    TResult Function(DirectUnfreezedImmutableUnionNamed value)? named,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case DirectUnfreezedImmutableUnion() when $default != null:
        return $default(_that);
      case DirectUnfreezedImmutableUnionNamed() when named != null:
        return named(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(DirectUnfreezedImmutableUnion value) $default, {
    required TResult Function(DirectUnfreezedImmutableUnionNamed value) named,
  }) {
    final _that = this;
    switch (_that) {
      case DirectUnfreezedImmutableUnion():
        return $default(_that);
      case DirectUnfreezedImmutableUnionNamed():
        return named(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(DirectUnfreezedImmutableUnion value)? $default, {
    TResult? Function(DirectUnfreezedImmutableUnionNamed value)? named,
  }) {
    final _that = this;
    switch (_that) {
      case DirectUnfreezedImmutableUnion() when $default != null:
        return $default(_that);
      case DirectUnfreezedImmutableUnionNamed() when named != null:
        return named(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String a)? $default, {
    TResult Function(String a)? named,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case DirectUnfreezedImmutableUnion() when $default != null:
        return $default(_that.a);
      case DirectUnfreezedImmutableUnionNamed() when named != null:
        return named(_that.a);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String a) $default, {
    required TResult Function(String a) named,
  }) {
    final _that = this;
    switch (_that) {
      case DirectUnfreezedImmutableUnion():
        return $default(_that.a);
      case DirectUnfreezedImmutableUnionNamed():
        return named(_that.a);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String a)? $default, {
    TResult? Function(String a)? named,
  }) {
    final _that = this;
    switch (_that) {
      case DirectUnfreezedImmutableUnion() when $default != null:
        return $default(_that.a);
      case DirectUnfreezedImmutableUnionNamed() when named != null:
        return named(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

class DirectUnfreezedImmutableUnion implements UnfreezedImmutableUnion {
  DirectUnfreezedImmutableUnion(this.a);

  @override
  final String a;

  /// Create a copy of UnfreezedImmutableUnion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DirectUnfreezedImmutableUnionCopyWith<DirectUnfreezedImmutableUnion>
      get copyWith => _$DirectUnfreezedImmutableUnionCopyWithImpl<
          DirectUnfreezedImmutableUnion>(this, _$identity);

  @override
  String toString() {
    return 'UnfreezedImmutableUnion(a: $a)';
  }
}

/// @nodoc
abstract mixin class $DirectUnfreezedImmutableUnionCopyWith<$Res>
    implements $UnfreezedImmutableUnionCopyWith<$Res> {
  factory $DirectUnfreezedImmutableUnionCopyWith(
          DirectUnfreezedImmutableUnion value,
          $Res Function(DirectUnfreezedImmutableUnion) _then) =
      _$DirectUnfreezedImmutableUnionCopyWithImpl;
  @override
  @useResult
  $Res call({String a});
}

/// @nodoc
class _$DirectUnfreezedImmutableUnionCopyWithImpl<$Res>
    implements $DirectUnfreezedImmutableUnionCopyWith<$Res> {
  _$DirectUnfreezedImmutableUnionCopyWithImpl(this._self, this._then);

  final DirectUnfreezedImmutableUnion _self;
  final $Res Function(DirectUnfreezedImmutableUnion) _then;

  /// Create a copy of UnfreezedImmutableUnion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(DirectUnfreezedImmutableUnion(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class DirectUnfreezedImmutableUnionNamed implements UnfreezedImmutableUnion {
  DirectUnfreezedImmutableUnionNamed(this.a);

  @override
  String a;

  /// Create a copy of UnfreezedImmutableUnion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DirectUnfreezedImmutableUnionNamedCopyWith<
          DirectUnfreezedImmutableUnionNamed>
      get copyWith => _$DirectUnfreezedImmutableUnionNamedCopyWithImpl<
          DirectUnfreezedImmutableUnionNamed>(this, _$identity);

  @override
  String toString() {
    return 'UnfreezedImmutableUnion.named(a: $a)';
  }
}

/// @nodoc
abstract mixin class $DirectUnfreezedImmutableUnionNamedCopyWith<$Res>
    implements $UnfreezedImmutableUnionCopyWith<$Res> {
  factory $DirectUnfreezedImmutableUnionNamedCopyWith(
          DirectUnfreezedImmutableUnionNamed value,
          $Res Function(DirectUnfreezedImmutableUnionNamed) _then) =
      _$DirectUnfreezedImmutableUnionNamedCopyWithImpl;
  @override
  @useResult
  $Res call({String a});
}

/// @nodoc
class _$DirectUnfreezedImmutableUnionNamedCopyWithImpl<$Res>
    implements $DirectUnfreezedImmutableUnionNamedCopyWith<$Res> {
  _$DirectUnfreezedImmutableUnionNamedCopyWithImpl(this._self, this._then);

  final DirectUnfreezedImmutableUnionNamed _self;
  final $Res Function(DirectUnfreezedImmutableUnionNamed) _then;

  /// Create a copy of UnfreezedImmutableUnion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(DirectUnfreezedImmutableUnionNamed(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$UnfreezedImmutableUnion2 {
  String get a;

  /// Create a copy of UnfreezedImmutableUnion2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnfreezedImmutableUnion2CopyWith<UnfreezedImmutableUnion2> get copyWith =>
      _$UnfreezedImmutableUnion2CopyWithImpl<UnfreezedImmutableUnion2>(
          this as UnfreezedImmutableUnion2, _$identity);

  @override
  String toString() {
    return 'UnfreezedImmutableUnion2(a: $a)';
  }
}

/// @nodoc
abstract mixin class $UnfreezedImmutableUnion2CopyWith<$Res> {
  factory $UnfreezedImmutableUnion2CopyWith(UnfreezedImmutableUnion2 value,
          $Res Function(UnfreezedImmutableUnion2) _then) =
      _$UnfreezedImmutableUnion2CopyWithImpl;
  @useResult
  $Res call({String a});
}

/// @nodoc
class _$UnfreezedImmutableUnion2CopyWithImpl<$Res>
    implements $UnfreezedImmutableUnion2CopyWith<$Res> {
  _$UnfreezedImmutableUnion2CopyWithImpl(this._self, this._then);

  final UnfreezedImmutableUnion2 _self;
  final $Res Function(UnfreezedImmutableUnion2) _then;

  /// Create a copy of UnfreezedImmutableUnion2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? a = null,
  }) {
    return _then(_self.copyWith(
      a: null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [UnfreezedImmutableUnion2].
extension UnfreezedImmutableUnion2Patterns on UnfreezedImmutableUnion2 {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(DirectUnfreezedImmutableUnion2 value)? $default, {
    TResult Function(DirectUnfreezedImmutableUnionNamed2 value)? named,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case DirectUnfreezedImmutableUnion2() when $default != null:
        return $default(_that);
      case DirectUnfreezedImmutableUnionNamed2() when named != null:
        return named(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(DirectUnfreezedImmutableUnion2 value) $default, {
    required TResult Function(DirectUnfreezedImmutableUnionNamed2 value) named,
  }) {
    final _that = this;
    switch (_that) {
      case DirectUnfreezedImmutableUnion2():
        return $default(_that);
      case DirectUnfreezedImmutableUnionNamed2():
        return named(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(DirectUnfreezedImmutableUnion2 value)? $default, {
    TResult? Function(DirectUnfreezedImmutableUnionNamed2 value)? named,
  }) {
    final _that = this;
    switch (_that) {
      case DirectUnfreezedImmutableUnion2() when $default != null:
        return $default(_that);
      case DirectUnfreezedImmutableUnionNamed2() when named != null:
        return named(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String a)? $default, {
    TResult Function(String a)? named,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case DirectUnfreezedImmutableUnion2() when $default != null:
        return $default(_that.a);
      case DirectUnfreezedImmutableUnionNamed2() when named != null:
        return named(_that.a);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String a) $default, {
    required TResult Function(String a) named,
  }) {
    final _that = this;
    switch (_that) {
      case DirectUnfreezedImmutableUnion2():
        return $default(_that.a);
      case DirectUnfreezedImmutableUnionNamed2():
        return named(_that.a);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String a)? $default, {
    TResult? Function(String a)? named,
  }) {
    final _that = this;
    switch (_that) {
      case DirectUnfreezedImmutableUnion2() when $default != null:
        return $default(_that.a);
      case DirectUnfreezedImmutableUnionNamed2() when named != null:
        return named(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

class DirectUnfreezedImmutableUnion2 implements UnfreezedImmutableUnion2 {
  DirectUnfreezedImmutableUnion2(this.a);

  @override
  String a;

  /// Create a copy of UnfreezedImmutableUnion2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DirectUnfreezedImmutableUnion2CopyWith<DirectUnfreezedImmutableUnion2>
      get copyWith => _$DirectUnfreezedImmutableUnion2CopyWithImpl<
          DirectUnfreezedImmutableUnion2>(this, _$identity);

  @override
  String toString() {
    return 'UnfreezedImmutableUnion2(a: $a)';
  }
}

/// @nodoc
abstract mixin class $DirectUnfreezedImmutableUnion2CopyWith<$Res>
    implements $UnfreezedImmutableUnion2CopyWith<$Res> {
  factory $DirectUnfreezedImmutableUnion2CopyWith(
          DirectUnfreezedImmutableUnion2 value,
          $Res Function(DirectUnfreezedImmutableUnion2) _then) =
      _$DirectUnfreezedImmutableUnion2CopyWithImpl;
  @override
  @useResult
  $Res call({String a});
}

/// @nodoc
class _$DirectUnfreezedImmutableUnion2CopyWithImpl<$Res>
    implements $DirectUnfreezedImmutableUnion2CopyWith<$Res> {
  _$DirectUnfreezedImmutableUnion2CopyWithImpl(this._self, this._then);

  final DirectUnfreezedImmutableUnion2 _self;
  final $Res Function(DirectUnfreezedImmutableUnion2) _then;

  /// Create a copy of UnfreezedImmutableUnion2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(DirectUnfreezedImmutableUnion2(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class DirectUnfreezedImmutableUnionNamed2 implements UnfreezedImmutableUnion2 {
  DirectUnfreezedImmutableUnionNamed2(this.a);

  @override
  final String a;

  /// Create a copy of UnfreezedImmutableUnion2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DirectUnfreezedImmutableUnionNamed2CopyWith<
          DirectUnfreezedImmutableUnionNamed2>
      get copyWith => _$DirectUnfreezedImmutableUnionNamed2CopyWithImpl<
          DirectUnfreezedImmutableUnionNamed2>(this, _$identity);

  @override
  String toString() {
    return 'UnfreezedImmutableUnion2.named(a: $a)';
  }
}

/// @nodoc
abstract mixin class $DirectUnfreezedImmutableUnionNamed2CopyWith<$Res>
    implements $UnfreezedImmutableUnion2CopyWith<$Res> {
  factory $DirectUnfreezedImmutableUnionNamed2CopyWith(
          DirectUnfreezedImmutableUnionNamed2 value,
          $Res Function(DirectUnfreezedImmutableUnionNamed2) _then) =
      _$DirectUnfreezedImmutableUnionNamed2CopyWithImpl;
  @override
  @useResult
  $Res call({String a});
}

/// @nodoc
class _$DirectUnfreezedImmutableUnionNamed2CopyWithImpl<$Res>
    implements $DirectUnfreezedImmutableUnionNamed2CopyWith<$Res> {
  _$DirectUnfreezedImmutableUnionNamed2CopyWithImpl(this._self, this._then);

  final DirectUnfreezedImmutableUnionNamed2 _self;
  final $Res Function(DirectUnfreezedImmutableUnionNamed2) _then;

  /// Create a copy of UnfreezedImmutableUnion2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(DirectUnfreezedImmutableUnionNamed2(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$MutableUnion {
  String get a;
  set a(String value);

  /// Create a copy of MutableUnion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MutableUnionCopyWith<MutableUnion> get copyWith =>
      _$MutableUnionCopyWithImpl<MutableUnion>(
          this as MutableUnion, _$identity);

  @override
  String toString() {
    return 'MutableUnion(a: $a)';
  }
}

/// @nodoc
abstract mixin class $MutableUnionCopyWith<$Res> {
  factory $MutableUnionCopyWith(
          MutableUnion value, $Res Function(MutableUnion) _then) =
      _$MutableUnionCopyWithImpl;
  @useResult
  $Res call({String a});
}

/// @nodoc
class _$MutableUnionCopyWithImpl<$Res> implements $MutableUnionCopyWith<$Res> {
  _$MutableUnionCopyWithImpl(this._self, this._then);

  final MutableUnion _self;
  final $Res Function(MutableUnion) _then;

  /// Create a copy of MutableUnion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? a = null,
  }) {
    return _then(_self.copyWith(
      a: null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [MutableUnion].
extension MutableUnionPatterns on MutableUnion {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(MutableUnion0 value)? $default, {
    TResult Function(MutableUnion1 value)? named,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case MutableUnion0() when $default != null:
        return $default(_that);
      case MutableUnion1() when named != null:
        return named(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(MutableUnion0 value) $default, {
    required TResult Function(MutableUnion1 value) named,
  }) {
    final _that = this;
    switch (_that) {
      case MutableUnion0():
        return $default(_that);
      case MutableUnion1():
        return named(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(MutableUnion0 value)? $default, {
    TResult? Function(MutableUnion1 value)? named,
  }) {
    final _that = this;
    switch (_that) {
      case MutableUnion0() when $default != null:
        return $default(_that);
      case MutableUnion1() when named != null:
        return named(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String a, int b)? $default, {
    TResult Function(String a, int c)? named,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case MutableUnion0() when $default != null:
        return $default(_that.a, _that.b);
      case MutableUnion1() when named != null:
        return named(_that.a, _that.c);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String a, int b) $default, {
    required TResult Function(String a, int c) named,
  }) {
    final _that = this;
    switch (_that) {
      case MutableUnion0():
        return $default(_that.a, _that.b);
      case MutableUnion1():
        return named(_that.a, _that.c);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String a, int b)? $default, {
    TResult? Function(String a, int c)? named,
  }) {
    final _that = this;
    switch (_that) {
      case MutableUnion0() when $default != null:
        return $default(_that.a, _that.b);
      case MutableUnion1() when named != null:
        return named(_that.a, _that.c);
      case _:
        return null;
    }
  }
}

/// @nodoc

class MutableUnion0 implements MutableUnion {
  MutableUnion0(this.a, this.b);

  @override
  String a;
  int b;

  /// Create a copy of MutableUnion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MutableUnion0CopyWith<MutableUnion0> get copyWith =>
      _$MutableUnion0CopyWithImpl<MutableUnion0>(this, _$identity);

  @override
  String toString() {
    return 'MutableUnion(a: $a, b: $b)';
  }
}

/// @nodoc
abstract mixin class $MutableUnion0CopyWith<$Res>
    implements $MutableUnionCopyWith<$Res> {
  factory $MutableUnion0CopyWith(
          MutableUnion0 value, $Res Function(MutableUnion0) _then) =
      _$MutableUnion0CopyWithImpl;
  @override
  @useResult
  $Res call({String a, int b});
}

/// @nodoc
class _$MutableUnion0CopyWithImpl<$Res>
    implements $MutableUnion0CopyWith<$Res> {
  _$MutableUnion0CopyWithImpl(this._self, this._then);

  final MutableUnion0 _self;
  final $Res Function(MutableUnion0) _then;

  /// Create a copy of MutableUnion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
    Object? b = null,
  }) {
    return _then(MutableUnion0(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
      null == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class MutableUnion1 implements MutableUnion {
  MutableUnion1(this.a, this.c);

  @override
  String a;
  int c;

  /// Create a copy of MutableUnion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MutableUnion1CopyWith<MutableUnion1> get copyWith =>
      _$MutableUnion1CopyWithImpl<MutableUnion1>(this, _$identity);

  @override
  String toString() {
    return 'MutableUnion.named(a: $a, c: $c)';
  }
}

/// @nodoc
abstract mixin class $MutableUnion1CopyWith<$Res>
    implements $MutableUnionCopyWith<$Res> {
  factory $MutableUnion1CopyWith(
          MutableUnion1 value, $Res Function(MutableUnion1) _then) =
      _$MutableUnion1CopyWithImpl;
  @override
  @useResult
  $Res call({String a, int c});
}

/// @nodoc
class _$MutableUnion1CopyWithImpl<$Res>
    implements $MutableUnion1CopyWith<$Res> {
  _$MutableUnion1CopyWithImpl(this._self, this._then);

  final MutableUnion1 _self;
  final $Res Function(MutableUnion1) _then;

  /// Create a copy of MutableUnion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
    Object? c = null,
  }) {
    return _then(MutableUnion1(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
      null == c
          ? _self.c
          : c // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$DefaultValueNamedConstructor {
  int get value;

  /// Create a copy of DefaultValueNamedConstructor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DefaultValueNamedConstructorCopyWith<DefaultValueNamedConstructor>
      get copyWith => _$DefaultValueNamedConstructorCopyWithImpl<
              DefaultValueNamedConstructor>(
          this as DefaultValueNamedConstructor, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DefaultValueNamedConstructor &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'DefaultValueNamedConstructor(value: $value)';
  }
}

/// @nodoc
abstract mixin class $DefaultValueNamedConstructorCopyWith<$Res> {
  factory $DefaultValueNamedConstructorCopyWith(
          DefaultValueNamedConstructor value,
          $Res Function(DefaultValueNamedConstructor) _then) =
      _$DefaultValueNamedConstructorCopyWithImpl;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$DefaultValueNamedConstructorCopyWithImpl<$Res>
    implements $DefaultValueNamedConstructorCopyWith<$Res> {
  _$DefaultValueNamedConstructorCopyWithImpl(this._self, this._then);

  final DefaultValueNamedConstructor _self;
  final $Res Function(DefaultValueNamedConstructor) _then;

  /// Create a copy of DefaultValueNamedConstructor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_self.copyWith(
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [DefaultValueNamedConstructor].
extension DefaultValueNamedConstructorPatterns on DefaultValueNamedConstructor {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ADefaultValueNamedConstructor value)? a,
    TResult Function(_BDefaultValueNamedConstructor value)? b,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ADefaultValueNamedConstructor() when a != null:
        return a(_that);
      case _BDefaultValueNamedConstructor() when b != null:
        return b(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ADefaultValueNamedConstructor value) a,
    required TResult Function(_BDefaultValueNamedConstructor value) b,
  }) {
    final _that = this;
    switch (_that) {
      case _ADefaultValueNamedConstructor():
        return a(_that);
      case _BDefaultValueNamedConstructor():
        return b(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ADefaultValueNamedConstructor value)? a,
    TResult? Function(_BDefaultValueNamedConstructor value)? b,
  }) {
    final _that = this;
    switch (_that) {
      case _ADefaultValueNamedConstructor() when a != null:
        return a(_that);
      case _BDefaultValueNamedConstructor() when b != null:
        return b(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int value)? a,
    TResult Function(int value)? b,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ADefaultValueNamedConstructor() when a != null:
        return a(_that.value);
      case _BDefaultValueNamedConstructor() when b != null:
        return b(_that.value);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int value) a,
    required TResult Function(int value) b,
  }) {
    final _that = this;
    switch (_that) {
      case _ADefaultValueNamedConstructor():
        return a(_that.value);
      case _BDefaultValueNamedConstructor():
        return b(_that.value);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int value)? a,
    TResult? Function(int value)? b,
  }) {
    final _that = this;
    switch (_that) {
      case _ADefaultValueNamedConstructor() when a != null:
        return a(_that.value);
      case _BDefaultValueNamedConstructor() when b != null:
        return b(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ADefaultValueNamedConstructor implements DefaultValueNamedConstructor {
  _ADefaultValueNamedConstructor([this.value = 42]);

  @override
  @JsonKey()
  final int value;

  /// Create a copy of DefaultValueNamedConstructor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ADefaultValueNamedConstructorCopyWith<_ADefaultValueNamedConstructor>
      get copyWith => __$ADefaultValueNamedConstructorCopyWithImpl<
          _ADefaultValueNamedConstructor>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ADefaultValueNamedConstructor &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'DefaultValueNamedConstructor.a(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$ADefaultValueNamedConstructorCopyWith<$Res>
    implements $DefaultValueNamedConstructorCopyWith<$Res> {
  factory _$ADefaultValueNamedConstructorCopyWith(
          _ADefaultValueNamedConstructor value,
          $Res Function(_ADefaultValueNamedConstructor) _then) =
      __$ADefaultValueNamedConstructorCopyWithImpl;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$ADefaultValueNamedConstructorCopyWithImpl<$Res>
    implements _$ADefaultValueNamedConstructorCopyWith<$Res> {
  __$ADefaultValueNamedConstructorCopyWithImpl(this._self, this._then);

  final _ADefaultValueNamedConstructor _self;
  final $Res Function(_ADefaultValueNamedConstructor) _then;

  /// Create a copy of DefaultValueNamedConstructor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_ADefaultValueNamedConstructor(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _BDefaultValueNamedConstructor implements DefaultValueNamedConstructor {
  _BDefaultValueNamedConstructor([this.value = 42]);

  @override
  @JsonKey()
  final int value;

  /// Create a copy of DefaultValueNamedConstructor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BDefaultValueNamedConstructorCopyWith<_BDefaultValueNamedConstructor>
      get copyWith => __$BDefaultValueNamedConstructorCopyWithImpl<
          _BDefaultValueNamedConstructor>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BDefaultValueNamedConstructor &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'DefaultValueNamedConstructor.b(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$BDefaultValueNamedConstructorCopyWith<$Res>
    implements $DefaultValueNamedConstructorCopyWith<$Res> {
  factory _$BDefaultValueNamedConstructorCopyWith(
          _BDefaultValueNamedConstructor value,
          $Res Function(_BDefaultValueNamedConstructor) _then) =
      __$BDefaultValueNamedConstructorCopyWithImpl;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$BDefaultValueNamedConstructorCopyWithImpl<$Res>
    implements _$BDefaultValueNamedConstructorCopyWith<$Res> {
  __$BDefaultValueNamedConstructorCopyWithImpl(this._self, this._then);

  final _BDefaultValueNamedConstructor _self;
  final $Res Function(_BDefaultValueNamedConstructor) _then;

  /// Create a copy of DefaultValueNamedConstructor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_BDefaultValueNamedConstructor(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$NamedDefaultValueNamedConstructor {
  int get value;

  /// Create a copy of NamedDefaultValueNamedConstructor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NamedDefaultValueNamedConstructorCopyWith<NamedDefaultValueNamedConstructor>
      get copyWith => _$NamedDefaultValueNamedConstructorCopyWithImpl<
              NamedDefaultValueNamedConstructor>(
          this as NamedDefaultValueNamedConstructor, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NamedDefaultValueNamedConstructor &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'NamedDefaultValueNamedConstructor(value: $value)';
  }
}

/// @nodoc
abstract mixin class $NamedDefaultValueNamedConstructorCopyWith<$Res> {
  factory $NamedDefaultValueNamedConstructorCopyWith(
          NamedDefaultValueNamedConstructor value,
          $Res Function(NamedDefaultValueNamedConstructor) _then) =
      _$NamedDefaultValueNamedConstructorCopyWithImpl;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$NamedDefaultValueNamedConstructorCopyWithImpl<$Res>
    implements $NamedDefaultValueNamedConstructorCopyWith<$Res> {
  _$NamedDefaultValueNamedConstructorCopyWithImpl(this._self, this._then);

  final NamedDefaultValueNamedConstructor _self;
  final $Res Function(NamedDefaultValueNamedConstructor) _then;

  /// Create a copy of NamedDefaultValueNamedConstructor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_self.copyWith(
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [NamedDefaultValueNamedConstructor].
extension NamedDefaultValueNamedConstructorPatterns
    on NamedDefaultValueNamedConstructor {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BNamedDefaultValueNamedConstructor value)? a,
    TResult Function(_ANamedDefaultValueNamedConstructor value)? b,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BNamedDefaultValueNamedConstructor() when a != null:
        return a(_that);
      case _ANamedDefaultValueNamedConstructor() when b != null:
        return b(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BNamedDefaultValueNamedConstructor value) a,
    required TResult Function(_ANamedDefaultValueNamedConstructor value) b,
  }) {
    final _that = this;
    switch (_that) {
      case _BNamedDefaultValueNamedConstructor():
        return a(_that);
      case _ANamedDefaultValueNamedConstructor():
        return b(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_BNamedDefaultValueNamedConstructor value)? a,
    TResult? Function(_ANamedDefaultValueNamedConstructor value)? b,
  }) {
    final _that = this;
    switch (_that) {
      case _BNamedDefaultValueNamedConstructor() when a != null:
        return a(_that);
      case _ANamedDefaultValueNamedConstructor() when b != null:
        return b(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int value)? a,
    TResult Function(int value)? b,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BNamedDefaultValueNamedConstructor() when a != null:
        return a(_that.value);
      case _ANamedDefaultValueNamedConstructor() when b != null:
        return b(_that.value);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int value) a,
    required TResult Function(int value) b,
  }) {
    final _that = this;
    switch (_that) {
      case _BNamedDefaultValueNamedConstructor():
        return a(_that.value);
      case _ANamedDefaultValueNamedConstructor():
        return b(_that.value);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int value)? a,
    TResult? Function(int value)? b,
  }) {
    final _that = this;
    switch (_that) {
      case _BNamedDefaultValueNamedConstructor() when a != null:
        return a(_that.value);
      case _ANamedDefaultValueNamedConstructor() when b != null:
        return b(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _BNamedDefaultValueNamedConstructor
    implements NamedDefaultValueNamedConstructor {
  _BNamedDefaultValueNamedConstructor({this.value = 42});

  @override
  @JsonKey()
  final int value;

  /// Create a copy of NamedDefaultValueNamedConstructor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BNamedDefaultValueNamedConstructorCopyWith<
          _BNamedDefaultValueNamedConstructor>
      get copyWith => __$BNamedDefaultValueNamedConstructorCopyWithImpl<
          _BNamedDefaultValueNamedConstructor>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BNamedDefaultValueNamedConstructor &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'NamedDefaultValueNamedConstructor.a(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$BNamedDefaultValueNamedConstructorCopyWith<$Res>
    implements $NamedDefaultValueNamedConstructorCopyWith<$Res> {
  factory _$BNamedDefaultValueNamedConstructorCopyWith(
          _BNamedDefaultValueNamedConstructor value,
          $Res Function(_BNamedDefaultValueNamedConstructor) _then) =
      __$BNamedDefaultValueNamedConstructorCopyWithImpl;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$BNamedDefaultValueNamedConstructorCopyWithImpl<$Res>
    implements _$BNamedDefaultValueNamedConstructorCopyWith<$Res> {
  __$BNamedDefaultValueNamedConstructorCopyWithImpl(this._self, this._then);

  final _BNamedDefaultValueNamedConstructor _self;
  final $Res Function(_BNamedDefaultValueNamedConstructor) _then;

  /// Create a copy of NamedDefaultValueNamedConstructor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_BNamedDefaultValueNamedConstructor(
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _ANamedDefaultValueNamedConstructor
    implements NamedDefaultValueNamedConstructor {
  _ANamedDefaultValueNamedConstructor({this.value = 42});

  @override
  @JsonKey()
  final int value;

  /// Create a copy of NamedDefaultValueNamedConstructor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ANamedDefaultValueNamedConstructorCopyWith<
          _ANamedDefaultValueNamedConstructor>
      get copyWith => __$ANamedDefaultValueNamedConstructorCopyWithImpl<
          _ANamedDefaultValueNamedConstructor>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ANamedDefaultValueNamedConstructor &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'NamedDefaultValueNamedConstructor.b(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$ANamedDefaultValueNamedConstructorCopyWith<$Res>
    implements $NamedDefaultValueNamedConstructorCopyWith<$Res> {
  factory _$ANamedDefaultValueNamedConstructorCopyWith(
          _ANamedDefaultValueNamedConstructor value,
          $Res Function(_ANamedDefaultValueNamedConstructor) _then) =
      __$ANamedDefaultValueNamedConstructorCopyWithImpl;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$ANamedDefaultValueNamedConstructorCopyWithImpl<$Res>
    implements _$ANamedDefaultValueNamedConstructorCopyWith<$Res> {
  __$ANamedDefaultValueNamedConstructorCopyWithImpl(this._self, this._then);

  final _ANamedDefaultValueNamedConstructor _self;
  final $Res Function(_ANamedDefaultValueNamedConstructor) _then;

  /// Create a copy of NamedDefaultValueNamedConstructor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_ANamedDefaultValueNamedConstructor(
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$NoCommonParam {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is NoCommonParam);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'NoCommonParam()';
  }
}

/// @nodoc
class $NoCommonParamCopyWith<$Res> {
  $NoCommonParamCopyWith(NoCommonParam _, $Res Function(NoCommonParam) __);
}

/// Adds pattern-matching-related methods to [NoCommonParam].
extension NoCommonParamPatterns on NoCommonParam {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(NoCommonParam0 value)? $default, {
    TResult Function(NoCommonParam1 value)? named,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case NoCommonParam0() when $default != null:
        return $default(_that);
      case NoCommonParam1() when named != null:
        return named(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(NoCommonParam0 value) $default, {
    required TResult Function(NoCommonParam1 value) named,
  }) {
    final _that = this;
    switch (_that) {
      case NoCommonParam0():
        return $default(_that);
      case NoCommonParam1():
        return named(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(NoCommonParam0 value)? $default, {
    TResult? Function(NoCommonParam1 value)? named,
  }) {
    final _that = this;
    switch (_that) {
      case NoCommonParam0() when $default != null:
        return $default(_that);
      case NoCommonParam1() when named != null:
        return named(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String a, int? b)? $default, {
    TResult Function(double c, Object? d)? named,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case NoCommonParam0() when $default != null:
        return $default(_that.a, _that.b);
      case NoCommonParam1() when named != null:
        return named(_that.c, _that.d);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String a, int? b) $default, {
    required TResult Function(double c, Object? d) named,
  }) {
    final _that = this;
    switch (_that) {
      case NoCommonParam0():
        return $default(_that.a, _that.b);
      case NoCommonParam1():
        return named(_that.c, _that.d);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String a, int? b)? $default, {
    TResult? Function(double c, Object? d)? named,
  }) {
    final _that = this;
    switch (_that) {
      case NoCommonParam0() when $default != null:
        return $default(_that.a, _that.b);
      case NoCommonParam1() when named != null:
        return named(_that.c, _that.d);
      case _:
        return null;
    }
  }
}

/// @nodoc

class NoCommonParam0 implements NoCommonParam {
  const NoCommonParam0(this.a, {this.b});

  final String a;
  final int? b;

  /// Create a copy of NoCommonParam
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NoCommonParam0CopyWith<NoCommonParam0> get copyWith =>
      _$NoCommonParam0CopyWithImpl<NoCommonParam0>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NoCommonParam0 &&
            (identical(other.a, a) || other.a == a) &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a, b);

  @override
  String toString() {
    return 'NoCommonParam(a: $a, b: $b)';
  }
}

/// @nodoc
abstract mixin class $NoCommonParam0CopyWith<$Res>
    implements $NoCommonParamCopyWith<$Res> {
  factory $NoCommonParam0CopyWith(
          NoCommonParam0 value, $Res Function(NoCommonParam0) _then) =
      _$NoCommonParam0CopyWithImpl;
  @useResult
  $Res call({String a, int? b});
}

/// @nodoc
class _$NoCommonParam0CopyWithImpl<$Res>
    implements $NoCommonParam0CopyWith<$Res> {
  _$NoCommonParam0CopyWithImpl(this._self, this._then);

  final NoCommonParam0 _self;
  final $Res Function(NoCommonParam0) _then;

  /// Create a copy of NoCommonParam
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
    Object? b = freezed,
  }) {
    return _then(NoCommonParam0(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
      b: freezed == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class NoCommonParam1 implements NoCommonParam {
  const NoCommonParam1(this.c, [this.d]);

  final double c;
  final Object? d;

  /// Create a copy of NoCommonParam
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NoCommonParam1CopyWith<NoCommonParam1> get copyWith =>
      _$NoCommonParam1CopyWithImpl<NoCommonParam1>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NoCommonParam1 &&
            (identical(other.c, c) || other.c == c) &&
            const DeepCollectionEquality().equals(other.d, d));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, c, const DeepCollectionEquality().hash(d));

  @override
  String toString() {
    return 'NoCommonParam.named(c: $c, d: $d)';
  }
}

/// @nodoc
abstract mixin class $NoCommonParam1CopyWith<$Res>
    implements $NoCommonParamCopyWith<$Res> {
  factory $NoCommonParam1CopyWith(
          NoCommonParam1 value, $Res Function(NoCommonParam1) _then) =
      _$NoCommonParam1CopyWithImpl;
  @useResult
  $Res call({double c, Object? d});
}

/// @nodoc
class _$NoCommonParam1CopyWithImpl<$Res>
    implements $NoCommonParam1CopyWith<$Res> {
  _$NoCommonParam1CopyWithImpl(this._self, this._then);

  final NoCommonParam1 _self;
  final $Res Function(NoCommonParam1) _then;

  /// Create a copy of NoCommonParam
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? c = null,
    Object? d = freezed,
  }) {
    return _then(NoCommonParam1(
      null == c
          ? _self.c
          : c // ignore: cast_nullable_to_non_nullable
              as double,
      freezed == d ? _self.d : d,
    ));
  }
}

/// @nodoc
mixin _$Regression358 {
  int get number;

  /// Create a copy of Regression358
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Regression358CopyWith<Regression358> get copyWith =>
      _$Regression358CopyWithImpl<Regression358>(
          this as Regression358, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Regression358 &&
            (identical(other.number, number) || other.number == number));
  }

  @override
  int get hashCode => Object.hash(runtimeType, number);

  @override
  String toString() {
    return 'Regression358(number: $number)';
  }
}

/// @nodoc
abstract mixin class $Regression358CopyWith<$Res> {
  factory $Regression358CopyWith(
          Regression358 value, $Res Function(Regression358) _then) =
      _$Regression358CopyWithImpl;
  @useResult
  $Res call({int number});
}

/// @nodoc
class _$Regression358CopyWithImpl<$Res>
    implements $Regression358CopyWith<$Res> {
  _$Regression358CopyWithImpl(this._self, this._then);

  final Regression358 _self;
  final $Res Function(Regression358) _then;

  /// Create a copy of Regression358
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = null,
  }) {
    return _then(_self.copyWith(
      number: null == number
          ? _self.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [Regression358].
extension Regression358Patterns on Regression358 {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Regression358 value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Regression358() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Regression358 value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression358():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Regression358 value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression358() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int number)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Regression358() when $default != null:
        return $default(_that.number);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int number) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression358():
        return $default(_that.number);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int number)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression358() when $default != null:
        return $default(_that.number);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Regression358 implements Regression358 {
  const _Regression358({required this.number});

  @override
  final int number;

  /// Create a copy of Regression358
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$Regression358CopyWith<_Regression358> get copyWith =>
      __$Regression358CopyWithImpl<_Regression358>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Regression358 &&
            (identical(other.number, number) || other.number == number));
  }

  @override
  int get hashCode => Object.hash(runtimeType, number);

  @override
  String toString() {
    return 'Regression358(number: $number)';
  }
}

/// @nodoc
abstract mixin class _$Regression358CopyWith<$Res>
    implements $Regression358CopyWith<$Res> {
  factory _$Regression358CopyWith(
          _Regression358 value, $Res Function(_Regression358) _then) =
      __$Regression358CopyWithImpl;
  @override
  @useResult
  $Res call({int number});
}

/// @nodoc
class __$Regression358CopyWithImpl<$Res>
    implements _$Regression358CopyWith<$Res> {
  __$Regression358CopyWithImpl(this._self, this._then);

  final _Regression358 _self;
  final $Res Function(_Regression358) _then;

  /// Create a copy of Regression358
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? number = null,
  }) {
    return _then(_Regression358(
      number: null == number
          ? _self.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$SharedParam {
  String get a;

  /// Create a copy of SharedParam
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SharedParamCopyWith<SharedParam> get copyWith =>
      _$SharedParamCopyWithImpl<SharedParam>(this as SharedParam, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SharedParam &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'SharedParam(a: $a)';
  }
}

/// @nodoc
abstract mixin class $SharedParamCopyWith<$Res> {
  factory $SharedParamCopyWith(
          SharedParam value, $Res Function(SharedParam) _then) =
      _$SharedParamCopyWithImpl;
  @useResult
  $Res call({String a});
}

/// @nodoc
class _$SharedParamCopyWithImpl<$Res> implements $SharedParamCopyWith<$Res> {
  _$SharedParamCopyWithImpl(this._self, this._then);

  final SharedParam _self;
  final $Res Function(SharedParam) _then;

  /// Create a copy of SharedParam
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? a = null,
  }) {
    return _then(_self.copyWith(
      a: null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [SharedParam].
extension SharedParamPatterns on SharedParam {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(SharedParam0 value)? $default, {
    TResult Function(SharedParam1 value)? named,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SharedParam0() when $default != null:
        return $default(_that);
      case SharedParam1() when named != null:
        return named(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(SharedParam0 value) $default, {
    required TResult Function(SharedParam1 value) named,
  }) {
    final _that = this;
    switch (_that) {
      case SharedParam0():
        return $default(_that);
      case SharedParam1():
        return named(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(SharedParam0 value)? $default, {
    TResult? Function(SharedParam1 value)? named,
  }) {
    final _that = this;
    switch (_that) {
      case SharedParam0() when $default != null:
        return $default(_that);
      case SharedParam1() when named != null:
        return named(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String a, int b)? $default, {
    TResult Function(String a, int c)? named,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SharedParam0() when $default != null:
        return $default(_that.a, _that.b);
      case SharedParam1() when named != null:
        return named(_that.a, _that.c);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String a, int b) $default, {
    required TResult Function(String a, int c) named,
  }) {
    final _that = this;
    switch (_that) {
      case SharedParam0():
        return $default(_that.a, _that.b);
      case SharedParam1():
        return named(_that.a, _that.c);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String a, int b)? $default, {
    TResult? Function(String a, int c)? named,
  }) {
    final _that = this;
    switch (_that) {
      case SharedParam0() when $default != null:
        return $default(_that.a, _that.b);
      case SharedParam1() when named != null:
        return named(_that.a, _that.c);
      case _:
        return null;
    }
  }
}

/// @nodoc

class SharedParam0 implements SharedParam {
  const SharedParam0(this.a, this.b);

  @override
  final String a;
  final int b;

  /// Create a copy of SharedParam
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SharedParam0CopyWith<SharedParam0> get copyWith =>
      _$SharedParam0CopyWithImpl<SharedParam0>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SharedParam0 &&
            (identical(other.a, a) || other.a == a) &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a, b);

  @override
  String toString() {
    return 'SharedParam(a: $a, b: $b)';
  }
}

/// @nodoc
abstract mixin class $SharedParam0CopyWith<$Res>
    implements $SharedParamCopyWith<$Res> {
  factory $SharedParam0CopyWith(
          SharedParam0 value, $Res Function(SharedParam0) _then) =
      _$SharedParam0CopyWithImpl;
  @override
  @useResult
  $Res call({String a, int b});
}

/// @nodoc
class _$SharedParam0CopyWithImpl<$Res> implements $SharedParam0CopyWith<$Res> {
  _$SharedParam0CopyWithImpl(this._self, this._then);

  final SharedParam0 _self;
  final $Res Function(SharedParam0) _then;

  /// Create a copy of SharedParam
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
    Object? b = null,
  }) {
    return _then(SharedParam0(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
      null == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class SharedParam1 implements SharedParam {
  const SharedParam1(this.a, this.c);

  @override
  final String a;
  final int c;

  /// Create a copy of SharedParam
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SharedParam1CopyWith<SharedParam1> get copyWith =>
      _$SharedParam1CopyWithImpl<SharedParam1>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SharedParam1 &&
            (identical(other.a, a) || other.a == a) &&
            (identical(other.c, c) || other.c == c));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a, c);

  @override
  String toString() {
    return 'SharedParam.named(a: $a, c: $c)';
  }
}

/// @nodoc
abstract mixin class $SharedParam1CopyWith<$Res>
    implements $SharedParamCopyWith<$Res> {
  factory $SharedParam1CopyWith(
          SharedParam1 value, $Res Function(SharedParam1) _then) =
      _$SharedParam1CopyWithImpl;
  @override
  @useResult
  $Res call({String a, int c});
}

/// @nodoc
class _$SharedParam1CopyWithImpl<$Res> implements $SharedParam1CopyWith<$Res> {
  _$SharedParam1CopyWithImpl(this._self, this._then);

  final SharedParam1 _self;
  final $Res Function(SharedParam1) _then;

  /// Create a copy of SharedParam
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
    Object? c = null,
  }) {
    return _then(SharedParam1(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
      null == c
          ? _self.c
          : c // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$Complex {
  /// Hello
  String get a;

  /// Create a copy of Complex
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComplexCopyWith<Complex> get copyWith =>
      _$ComplexCopyWithImpl<Complex>(this as Complex, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Complex &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'Complex(a: $a)';
  }
}

/// @nodoc
abstract mixin class $ComplexCopyWith<$Res> {
  factory $ComplexCopyWith(Complex value, $Res Function(Complex) _then) =
      _$ComplexCopyWithImpl;
  @useResult
  $Res call({String a});
}

/// @nodoc
class _$ComplexCopyWithImpl<$Res> implements $ComplexCopyWith<$Res> {
  _$ComplexCopyWithImpl(this._self, this._then);

  final Complex _self;
  final $Res Function(Complex) _then;

  /// Create a copy of Complex
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? a = null,
  }) {
    return _then(_self.copyWith(
      a: null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [Complex].
extension ComplexPatterns on Complex {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Complex0 value)? $default, {
    TResult Function(Complex1 value)? first,
    TResult Function(Complex2 value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Complex0() when $default != null:
        return $default(_that);
      case Complex1() when first != null:
        return first(_that);
      case Complex2() when second != null:
        return second(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Complex0 value) $default, {
    required TResult Function(Complex1 value) first,
    required TResult Function(Complex2 value) second,
  }) {
    final _that = this;
    switch (_that) {
      case Complex0():
        return $default(_that);
      case Complex1():
        return first(_that);
      case Complex2():
        return second(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(Complex0 value)? $default, {
    TResult? Function(Complex1 value)? first,
    TResult? Function(Complex2 value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case Complex0() when $default != null:
        return $default(_that);
      case Complex1() when first != null:
        return first(_that);
      case Complex2() when second != null:
        return second(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String a)? $default, {
    TResult Function(String a, bool? b, double? d)? first,
    TResult Function(String a, int? c, double? d)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Complex0() when $default != null:
        return $default(_that.a);
      case Complex1() when first != null:
        return first(_that.a, _that.b, _that.d);
      case Complex2() when second != null:
        return second(_that.a, _that.c, _that.d);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String a) $default, {
    required TResult Function(String a, bool? b, double? d) first,
    required TResult Function(String a, int? c, double? d) second,
  }) {
    final _that = this;
    switch (_that) {
      case Complex0():
        return $default(_that.a);
      case Complex1():
        return first(_that.a, _that.b, _that.d);
      case Complex2():
        return second(_that.a, _that.c, _that.d);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String a)? $default, {
    TResult? Function(String a, bool? b, double? d)? first,
    TResult? Function(String a, int? c, double? d)? second,
  }) {
    final _that = this;
    switch (_that) {
      case Complex0() when $default != null:
        return $default(_that.a);
      case Complex1() when first != null:
        return first(_that.a, _that.b, _that.d);
      case Complex2() when second != null:
        return second(_that.a, _that.c, _that.d);
      case _:
        return null;
    }
  }
}

/// @nodoc

class Complex0 implements Complex {
  const Complex0(this.a) : assert(a != '', '"Hello"');

  /// Hello
  @override
  final String a;

  /// Create a copy of Complex
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Complex0CopyWith<Complex0> get copyWith =>
      _$Complex0CopyWithImpl<Complex0>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Complex0 &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'Complex(a: $a)';
  }
}

/// @nodoc
abstract mixin class $Complex0CopyWith<$Res> implements $ComplexCopyWith<$Res> {
  factory $Complex0CopyWith(Complex0 value, $Res Function(Complex0) _then) =
      _$Complex0CopyWithImpl;
  @override
  @useResult
  $Res call({String a});
}

/// @nodoc
class _$Complex0CopyWithImpl<$Res> implements $Complex0CopyWith<$Res> {
  _$Complex0CopyWithImpl(this._self, this._then);

  final Complex0 _self;
  final $Res Function(Complex0) _then;

  /// Create a copy of Complex
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(Complex0(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class Complex1 implements Complex {
  const Complex1(this.a, {this.b, this.d})
      : assert(a == ''),
        assert(b == true, 'b must be true');

  /// World
  @override
  final String a;

  /// B
  final bool? b;
  final double? d;

  /// Create a copy of Complex
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Complex1CopyWith<Complex1> get copyWith =>
      _$Complex1CopyWithImpl<Complex1>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Complex1 &&
            (identical(other.a, a) || other.a == a) &&
            (identical(other.b, b) || other.b == b) &&
            (identical(other.d, d) || other.d == d));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a, b, d);

  @override
  String toString() {
    return 'Complex.first(a: $a, b: $b, d: $d)';
  }
}

/// @nodoc
abstract mixin class $Complex1CopyWith<$Res> implements $ComplexCopyWith<$Res> {
  factory $Complex1CopyWith(Complex1 value, $Res Function(Complex1) _then) =
      _$Complex1CopyWithImpl;
  @override
  @useResult
  $Res call({String a, bool? b, double? d});
}

/// @nodoc
class _$Complex1CopyWithImpl<$Res> implements $Complex1CopyWith<$Res> {
  _$Complex1CopyWithImpl(this._self, this._then);

  final Complex1 _self;
  final $Res Function(Complex1) _then;

  /// Create a copy of Complex
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
    Object? b = freezed,
    Object? d = freezed,
  }) {
    return _then(Complex1(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
      b: freezed == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as bool?,
      d: freezed == d
          ? _self.d
          : d // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class Complex2 implements Complex {
  const Complex2(this.a, [this.c, this.d]);

  @override
  final String a;

  /// C
  final int? c;
  final double? d;

  /// Create a copy of Complex
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Complex2CopyWith<Complex2> get copyWith =>
      _$Complex2CopyWithImpl<Complex2>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Complex2 &&
            (identical(other.a, a) || other.a == a) &&
            (identical(other.c, c) || other.c == c) &&
            (identical(other.d, d) || other.d == d));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a, c, d);

  @override
  String toString() {
    return 'Complex.second(a: $a, c: $c, d: $d)';
  }
}

/// @nodoc
abstract mixin class $Complex2CopyWith<$Res> implements $ComplexCopyWith<$Res> {
  factory $Complex2CopyWith(Complex2 value, $Res Function(Complex2) _then) =
      _$Complex2CopyWithImpl;
  @override
  @useResult
  $Res call({String a, int? c, double? d});
}

/// @nodoc
class _$Complex2CopyWithImpl<$Res> implements $Complex2CopyWith<$Res> {
  _$Complex2CopyWithImpl(this._self, this._then);

  final Complex2 _self;
  final $Res Function(Complex2) _then;

  /// Create a copy of Complex
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
    Object? c = freezed,
    Object? d = freezed,
  }) {
    return _then(Complex2(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == c
          ? _self.c
          : c // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == d
          ? _self.d
          : d // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
mixin _$SwitchTest {
  String get a;

  /// Create a copy of SwitchTest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SwitchTestCopyWith<SwitchTest> get copyWith =>
      _$SwitchTestCopyWithImpl<SwitchTest>(this as SwitchTest, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SwitchTest &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'SwitchTest(a: $a)';
  }
}

/// @nodoc
abstract mixin class $SwitchTestCopyWith<$Res> {
  factory $SwitchTestCopyWith(
          SwitchTest value, $Res Function(SwitchTest) _then) =
      _$SwitchTestCopyWithImpl;
  @useResult
  $Res call({String a});
}

/// @nodoc
class _$SwitchTestCopyWithImpl<$Res> implements $SwitchTestCopyWith<$Res> {
  _$SwitchTestCopyWithImpl(this._self, this._then);

  final SwitchTest _self;
  final $Res Function(SwitchTest) _then;

  /// Create a copy of SwitchTest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? a = null,
  }) {
    return _then(_self.copyWith(
      a: null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [SwitchTest].
extension SwitchTestPatterns on SwitchTest {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(SwitchTest0 value)? $default, {
    TResult Function(SwitchTest1 value)? first,
    TResult Function(SwitchTest2 value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SwitchTest0() when $default != null:
        return $default(_that);
      case SwitchTest1() when first != null:
        return first(_that);
      case SwitchTest2() when second != null:
        return second(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(SwitchTest0 value) $default, {
    required TResult Function(SwitchTest1 value) first,
    required TResult Function(SwitchTest2 value) second,
  }) {
    final _that = this;
    switch (_that) {
      case SwitchTest0():
        return $default(_that);
      case SwitchTest1():
        return first(_that);
      case SwitchTest2():
        return second(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(SwitchTest0 value)? $default, {
    TResult? Function(SwitchTest1 value)? first,
    TResult? Function(SwitchTest2 value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case SwitchTest0() when $default != null:
        return $default(_that);
      case SwitchTest1() when first != null:
        return first(_that);
      case SwitchTest2() when second != null:
        return second(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String a)? $default, {
    TResult Function(String a, bool? b, double? d)? first,
    TResult Function(String a, int? c, double? d)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SwitchTest0() when $default != null:
        return $default(_that.a);
      case SwitchTest1() when first != null:
        return first(_that.a, _that.b, _that.d);
      case SwitchTest2() when second != null:
        return second(_that.a, _that.c, _that.d);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String a) $default, {
    required TResult Function(String a, bool? b, double? d) first,
    required TResult Function(String a, int? c, double? d) second,
  }) {
    final _that = this;
    switch (_that) {
      case SwitchTest0():
        return $default(_that.a);
      case SwitchTest1():
        return first(_that.a, _that.b, _that.d);
      case SwitchTest2():
        return second(_that.a, _that.c, _that.d);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String a)? $default, {
    TResult? Function(String a, bool? b, double? d)? first,
    TResult? Function(String a, int? c, double? d)? second,
  }) {
    final _that = this;
    switch (_that) {
      case SwitchTest0() when $default != null:
        return $default(_that.a);
      case SwitchTest1() when first != null:
        return first(_that.a, _that.b, _that.d);
      case SwitchTest2() when second != null:
        return second(_that.a, _that.c, _that.d);
      case _:
        return null;
    }
  }
}

/// @nodoc

class SwitchTest0 implements SwitchTest {
  const SwitchTest0(this.a);

  @override
  final String a;

  /// Create a copy of SwitchTest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SwitchTest0CopyWith<SwitchTest0> get copyWith =>
      _$SwitchTest0CopyWithImpl<SwitchTest0>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SwitchTest0 &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'SwitchTest(a: $a)';
  }
}

/// @nodoc
abstract mixin class $SwitchTest0CopyWith<$Res>
    implements $SwitchTestCopyWith<$Res> {
  factory $SwitchTest0CopyWith(
          SwitchTest0 value, $Res Function(SwitchTest0) _then) =
      _$SwitchTest0CopyWithImpl;
  @override
  @useResult
  $Res call({String a});
}

/// @nodoc
class _$SwitchTest0CopyWithImpl<$Res> implements $SwitchTest0CopyWith<$Res> {
  _$SwitchTest0CopyWithImpl(this._self, this._then);

  final SwitchTest0 _self;
  final $Res Function(SwitchTest0) _then;

  /// Create a copy of SwitchTest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(SwitchTest0(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class SwitchTest1 implements SwitchTest {
  const SwitchTest1(this.a, {this.b, this.d});

  @override
  final String a;
  final bool? b;
  final double? d;

  /// Create a copy of SwitchTest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SwitchTest1CopyWith<SwitchTest1> get copyWith =>
      _$SwitchTest1CopyWithImpl<SwitchTest1>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SwitchTest1 &&
            (identical(other.a, a) || other.a == a) &&
            (identical(other.b, b) || other.b == b) &&
            (identical(other.d, d) || other.d == d));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a, b, d);

  @override
  String toString() {
    return 'SwitchTest.first(a: $a, b: $b, d: $d)';
  }
}

/// @nodoc
abstract mixin class $SwitchTest1CopyWith<$Res>
    implements $SwitchTestCopyWith<$Res> {
  factory $SwitchTest1CopyWith(
          SwitchTest1 value, $Res Function(SwitchTest1) _then) =
      _$SwitchTest1CopyWithImpl;
  @override
  @useResult
  $Res call({String a, bool? b, double? d});
}

/// @nodoc
class _$SwitchTest1CopyWithImpl<$Res> implements $SwitchTest1CopyWith<$Res> {
  _$SwitchTest1CopyWithImpl(this._self, this._then);

  final SwitchTest1 _self;
  final $Res Function(SwitchTest1) _then;

  /// Create a copy of SwitchTest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
    Object? b = freezed,
    Object? d = freezed,
  }) {
    return _then(SwitchTest1(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
      b: freezed == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as bool?,
      d: freezed == d
          ? _self.d
          : d // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class SwitchTest2 implements SwitchTest {
  const SwitchTest2(this.a, [this.c, this.d]);

  @override
  final String a;
  final int? c;
  final double? d;

  /// Create a copy of SwitchTest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SwitchTest2CopyWith<SwitchTest2> get copyWith =>
      _$SwitchTest2CopyWithImpl<SwitchTest2>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SwitchTest2 &&
            (identical(other.a, a) || other.a == a) &&
            (identical(other.c, c) || other.c == c) &&
            (identical(other.d, d) || other.d == d));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a, c, d);

  @override
  String toString() {
    return 'SwitchTest.second(a: $a, c: $c, d: $d)';
  }
}

/// @nodoc
abstract mixin class $SwitchTest2CopyWith<$Res>
    implements $SwitchTestCopyWith<$Res> {
  factory $SwitchTest2CopyWith(
          SwitchTest2 value, $Res Function(SwitchTest2) _then) =
      _$SwitchTest2CopyWithImpl;
  @override
  @useResult
  $Res call({String a, int? c, double? d});
}

/// @nodoc
class _$SwitchTest2CopyWithImpl<$Res> implements $SwitchTest2CopyWith<$Res> {
  _$SwitchTest2CopyWithImpl(this._self, this._then);

  final SwitchTest2 _self;
  final $Res Function(SwitchTest2) _then;

  /// Create a copy of SwitchTest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
    Object? c = freezed,
    Object? d = freezed,
  }) {
    return _then(SwitchTest2(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == c
          ? _self.c
          : c // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == d
          ? _self.d
          : d // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
mixin _$NoDefault {
  String get a;

  /// Create a copy of NoDefault
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NoDefaultCopyWith<NoDefault> get copyWith =>
      _$NoDefaultCopyWithImpl<NoDefault>(this as NoDefault, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NoDefault &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'NoDefault(a: $a)';
  }
}

/// @nodoc
abstract mixin class $NoDefaultCopyWith<$Res> {
  factory $NoDefaultCopyWith(NoDefault value, $Res Function(NoDefault) _then) =
      _$NoDefaultCopyWithImpl;
  @useResult
  $Res call({String a});
}

/// @nodoc
class _$NoDefaultCopyWithImpl<$Res> implements $NoDefaultCopyWith<$Res> {
  _$NoDefaultCopyWithImpl(this._self, this._then);

  final NoDefault _self;
  final $Res Function(NoDefault) _then;

  /// Create a copy of NoDefault
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? a = null,
  }) {
    return _then(_self.copyWith(
      a: null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [NoDefault].
extension NoDefaultPatterns on NoDefault {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NoDefault1 value)? first,
    TResult Function(NoDefault2 value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case NoDefault1() when first != null:
        return first(_that);
      case NoDefault2() when second != null:
        return second(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NoDefault1 value) first,
    required TResult Function(NoDefault2 value) second,
  }) {
    final _that = this;
    switch (_that) {
      case NoDefault1():
        return first(_that);
      case NoDefault2():
        return second(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NoDefault1 value)? first,
    TResult? Function(NoDefault2 value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case NoDefault1() when first != null:
        return first(_that);
      case NoDefault2() when second != null:
        return second(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String a)? first,
    TResult Function(String a)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case NoDefault1() when first != null:
        return first(_that.a);
      case NoDefault2() when second != null:
        return second(_that.a);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String a) first,
    required TResult Function(String a) second,
  }) {
    final _that = this;
    switch (_that) {
      case NoDefault1():
        return first(_that.a);
      case NoDefault2():
        return second(_that.a);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String a)? first,
    TResult? Function(String a)? second,
  }) {
    final _that = this;
    switch (_that) {
      case NoDefault1() when first != null:
        return first(_that.a);
      case NoDefault2() when second != null:
        return second(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

class NoDefault1 implements NoDefault {
  const NoDefault1(this.a);

  @override
  final String a;

  /// Create a copy of NoDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NoDefault1CopyWith<NoDefault1> get copyWith =>
      _$NoDefault1CopyWithImpl<NoDefault1>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NoDefault1 &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'NoDefault.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class $NoDefault1CopyWith<$Res>
    implements $NoDefaultCopyWith<$Res> {
  factory $NoDefault1CopyWith(
          NoDefault1 value, $Res Function(NoDefault1) _then) =
      _$NoDefault1CopyWithImpl;
  @override
  @useResult
  $Res call({String a});
}

/// @nodoc
class _$NoDefault1CopyWithImpl<$Res> implements $NoDefault1CopyWith<$Res> {
  _$NoDefault1CopyWithImpl(this._self, this._then);

  final NoDefault1 _self;
  final $Res Function(NoDefault1) _then;

  /// Create a copy of NoDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(NoDefault1(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class NoDefault2 implements NoDefault {
  const NoDefault2(this.a);

  @override
  final String a;

  /// Create a copy of NoDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NoDefault2CopyWith<NoDefault2> get copyWith =>
      _$NoDefault2CopyWithImpl<NoDefault2>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NoDefault2 &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'NoDefault.second(a: $a)';
  }
}

/// @nodoc
abstract mixin class $NoDefault2CopyWith<$Res>
    implements $NoDefaultCopyWith<$Res> {
  factory $NoDefault2CopyWith(
          NoDefault2 value, $Res Function(NoDefault2) _then) =
      _$NoDefault2CopyWithImpl;
  @override
  @useResult
  $Res call({String a});
}

/// @nodoc
class _$NoDefault2CopyWithImpl<$Res> implements $NoDefault2CopyWith<$Res> {
  _$NoDefault2CopyWithImpl(this._self, this._then);

  final NoDefault2 _self;
  final $Res Function(NoDefault2) _then;

  /// Create a copy of NoDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(NoDefault2(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$NameConflict {
  Error get error;

  /// Create a copy of NameConflict
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NameConflictCopyWith<NameConflict> get copyWith =>
      _$NameConflictCopyWithImpl<NameConflict>(
          this as NameConflict, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NameConflict &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @override
  String toString() {
    return 'NameConflict(error: $error)';
  }
}

/// @nodoc
abstract mixin class $NameConflictCopyWith<$Res> {
  factory $NameConflictCopyWith(
          NameConflict value, $Res Function(NameConflict) _then) =
      _$NameConflictCopyWithImpl;
  @useResult
  $Res call({Error error});
}

/// @nodoc
class _$NameConflictCopyWithImpl<$Res> implements $NameConflictCopyWith<$Res> {
  _$NameConflictCopyWithImpl(this._self, this._then);

  final NameConflict _self;
  final $Res Function(NameConflict) _then;

  /// Create a copy of NameConflict
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_self.copyWith(
      error: null == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as Error,
    ));
  }
}

/// Adds pattern-matching-related methods to [NameConflict].
extension NameConflictPatterns on NameConflict {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Something value)? something,
    TResult Function(SomeError value)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Something() when something != null:
        return something(_that);
      case SomeError() when error != null:
        return error(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Something value) something,
    required TResult Function(SomeError value) error,
  }) {
    final _that = this;
    switch (_that) {
      case Something():
        return something(_that);
      case SomeError():
        return error(_that);
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Something value)? something,
    TResult? Function(SomeError value)? error,
  }) {
    final _that = this;
    switch (_that) {
      case Something() when something != null:
        return something(_that);
      case SomeError() when error != null:
        return error(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Error error)? something,
    TResult Function(Error error)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Something() when something != null:
        return something(_that.error);
      case SomeError() when error != null:
        return error(_that.error);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Error error) something,
    required TResult Function(Error error) error,
  }) {
    final _that = this;
    switch (_that) {
      case Something():
        return something(_that.error);
      case SomeError():
        return error(_that.error);
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Error error)? something,
    TResult? Function(Error error)? error,
  }) {
    final _that = this;
    switch (_that) {
      case Something() when something != null:
        return something(_that.error);
      case SomeError() when error != null:
        return error(_that.error);
      case _:
        return null;
    }
  }
}

/// @nodoc

class Something implements NameConflict {
  Something(this.error);

  @override
  final Error error;

  /// Create a copy of NameConflict
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SomethingCopyWith<Something> get copyWith =>
      _$SomethingCopyWithImpl<Something>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Something &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @override
  String toString() {
    return 'NameConflict.something(error: $error)';
  }
}

/// @nodoc
abstract mixin class $SomethingCopyWith<$Res>
    implements $NameConflictCopyWith<$Res> {
  factory $SomethingCopyWith(Something value, $Res Function(Something) _then) =
      _$SomethingCopyWithImpl;
  @override
  @useResult
  $Res call({Error error});
}

/// @nodoc
class _$SomethingCopyWithImpl<$Res> implements $SomethingCopyWith<$Res> {
  _$SomethingCopyWithImpl(this._self, this._then);

  final Something _self;
  final $Res Function(Something) _then;

  /// Create a copy of NameConflict
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? error = null,
  }) {
    return _then(Something(
      null == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as Error,
    ));
  }
}

/// @nodoc

class SomeError implements NameConflict {
  SomeError(this.error);

  @override
  final Error error;

  /// Create a copy of NameConflict
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SomeErrorCopyWith<SomeError> get copyWith =>
      _$SomeErrorCopyWithImpl<SomeError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SomeError &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @override
  String toString() {
    return 'NameConflict.error(error: $error)';
  }
}

/// @nodoc
abstract mixin class $SomeErrorCopyWith<$Res>
    implements $NameConflictCopyWith<$Res> {
  factory $SomeErrorCopyWith(SomeError value, $Res Function(SomeError) _then) =
      _$SomeErrorCopyWithImpl;
  @override
  @useResult
  $Res call({Error error});
}

/// @nodoc
class _$SomeErrorCopyWithImpl<$Res> implements $SomeErrorCopyWith<$Res> {
  _$SomeErrorCopyWithImpl(this._self, this._then);

  final SomeError _self;
  final $Res Function(SomeError) _then;

  /// Create a copy of NameConflict
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? error = null,
  }) {
    return _then(SomeError(
      null == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as Error,
    ));
  }
}

/// @nodoc
mixin _$Recursive {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Recursive);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Recursive()';
  }
}

/// @nodoc
class $RecursiveCopyWith<$Res> {
  $RecursiveCopyWith(Recursive _, $Res Function(Recursive) __);
}

/// Adds pattern-matching-related methods to [Recursive].
extension RecursivePatterns on Recursive {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(RecursiveImpl value)? $default, {
    TResult Function(_RecursiveNext value)? next,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case RecursiveImpl() when $default != null:
        return $default(_that);
      case _RecursiveNext() when next != null:
        return next(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(RecursiveImpl value) $default, {
    required TResult Function(_RecursiveNext value) next,
  }) {
    final _that = this;
    switch (_that) {
      case RecursiveImpl():
        return $default(_that);
      case _RecursiveNext():
        return next(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(RecursiveImpl value)? $default, {
    TResult? Function(_RecursiveNext value)? next,
  }) {
    final _that = this;
    switch (_that) {
      case RecursiveImpl() when $default != null:
        return $default(_that);
      case _RecursiveNext() when next != null:
        return next(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function(RecursiveImpl value)? next,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case RecursiveImpl() when $default != null:
        return $default();
      case _RecursiveNext() when next != null:
        return next(_that.value);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function(RecursiveImpl value) next,
  }) {
    final _that = this;
    switch (_that) {
      case RecursiveImpl():
        return $default();
      case _RecursiveNext():
        return next(_that.value);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function(RecursiveImpl value)? next,
  }) {
    final _that = this;
    switch (_that) {
      case RecursiveImpl() when $default != null:
        return $default();
      case _RecursiveNext() when next != null:
        return next(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class RecursiveImpl implements Recursive {
  RecursiveImpl();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is RecursiveImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Recursive()';
  }
}

/// @nodoc

class _RecursiveNext implements Recursive {
  _RecursiveNext(this.value);

  final RecursiveImpl value;

  /// Create a copy of Recursive
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RecursiveNextCopyWith<_RecursiveNext> get copyWith =>
      __$RecursiveNextCopyWithImpl<_RecursiveNext>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RecursiveNext &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'Recursive.next(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$RecursiveNextCopyWith<$Res>
    implements $RecursiveCopyWith<$Res> {
  factory _$RecursiveNextCopyWith(
          _RecursiveNext value, $Res Function(_RecursiveNext) _then) =
      __$RecursiveNextCopyWithImpl;
  @useResult
  $Res call({RecursiveImpl value});
}

/// @nodoc
class __$RecursiveNextCopyWithImpl<$Res>
    implements _$RecursiveNextCopyWith<$Res> {
  __$RecursiveNextCopyWithImpl(this._self, this._then);

  final _RecursiveNext _self;
  final $Res Function(_RecursiveNext) _then;

  /// Create a copy of Recursive
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_RecursiveNext(
      freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as RecursiveImpl,
    ));
  }
}

/// @nodoc
mixin _$RecursiveWith$Dollar {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is RecursiveWith$Dollar);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'RecursiveWith\$Dollar()';
  }
}

/// @nodoc
class $RecursiveWith$DollarCopyWith<$Res> {
  $RecursiveWith$DollarCopyWith(
      RecursiveWith$Dollar _, $Res Function(RecursiveWith$Dollar) __);
}

/// Adds pattern-matching-related methods to [RecursiveWith$Dollar].
extension RecursiveWith$DollarPatterns on RecursiveWith$Dollar {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(RecursiveWith$DollarImpl value)? $default, {
    TResult Function(_RecursiveWith$DollarNext value)? next,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case RecursiveWith$DollarImpl() when $default != null:
        return $default(_that);
      case _RecursiveWith$DollarNext() when next != null:
        return next(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(RecursiveWith$DollarImpl value) $default, {
    required TResult Function(_RecursiveWith$DollarNext value) next,
  }) {
    final _that = this;
    switch (_that) {
      case RecursiveWith$DollarImpl():
        return $default(_that);
      case _RecursiveWith$DollarNext():
        return next(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(RecursiveWith$DollarImpl value)? $default, {
    TResult? Function(_RecursiveWith$DollarNext value)? next,
  }) {
    final _that = this;
    switch (_that) {
      case RecursiveWith$DollarImpl() when $default != null:
        return $default(_that);
      case _RecursiveWith$DollarNext() when next != null:
        return next(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function(RecursiveWith$DollarImpl value)? next,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case RecursiveWith$DollarImpl() when $default != null:
        return $default();
      case _RecursiveWith$DollarNext() when next != null:
        return next(_that.value);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function(RecursiveWith$DollarImpl value) next,
  }) {
    final _that = this;
    switch (_that) {
      case RecursiveWith$DollarImpl():
        return $default();
      case _RecursiveWith$DollarNext():
        return next(_that.value);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function(RecursiveWith$DollarImpl value)? next,
  }) {
    final _that = this;
    switch (_that) {
      case RecursiveWith$DollarImpl() when $default != null:
        return $default();
      case _RecursiveWith$DollarNext() when next != null:
        return next(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class RecursiveWith$DollarImpl implements RecursiveWith$Dollar {
  RecursiveWith$DollarImpl();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is RecursiveWith$DollarImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'RecursiveWith\$Dollar()';
  }
}

/// @nodoc

class _RecursiveWith$DollarNext implements RecursiveWith$Dollar {
  _RecursiveWith$DollarNext(this.value);

  final RecursiveWith$DollarImpl value;

  /// Create a copy of RecursiveWith$Dollar
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RecursiveWith$DollarNextCopyWith<_RecursiveWith$DollarNext> get copyWith =>
      __$RecursiveWith$DollarNextCopyWithImpl<_RecursiveWith$DollarNext>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RecursiveWith$DollarNext &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'RecursiveWith\$Dollar.next(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$RecursiveWith$DollarNextCopyWith<$Res>
    implements $RecursiveWith$DollarCopyWith<$Res> {
  factory _$RecursiveWith$DollarNextCopyWith(_RecursiveWith$DollarNext value,
          $Res Function(_RecursiveWith$DollarNext) _then) =
      __$RecursiveWith$DollarNextCopyWithImpl;
  @useResult
  $Res call({RecursiveWith$DollarImpl value});
}

/// @nodoc
class __$RecursiveWith$DollarNextCopyWithImpl<$Res>
    implements _$RecursiveWith$DollarNextCopyWith<$Res> {
  __$RecursiveWith$DollarNextCopyWithImpl(this._self, this._then);

  final _RecursiveWith$DollarNext _self;
  final $Res Function(_RecursiveWith$DollarNext) _then;

  /// Create a copy of RecursiveWith$Dollar
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_RecursiveWith$DollarNext(
      freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as RecursiveWith$DollarImpl,
    ));
  }
}

/// @nodoc
mixin _$RequiredParams {
  String get a;

  /// Create a copy of RequiredParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RequiredParamsCopyWith<RequiredParams> get copyWith =>
      _$RequiredParamsCopyWithImpl<RequiredParams>(
          this as RequiredParams, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RequiredParams &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'RequiredParams(a: $a)';
  }
}

/// @nodoc
abstract mixin class $RequiredParamsCopyWith<$Res> {
  factory $RequiredParamsCopyWith(
          RequiredParams value, $Res Function(RequiredParams) _then) =
      _$RequiredParamsCopyWithImpl;
  @useResult
  $Res call({String a});
}

/// @nodoc
class _$RequiredParamsCopyWithImpl<$Res>
    implements $RequiredParamsCopyWith<$Res> {
  _$RequiredParamsCopyWithImpl(this._self, this._then);

  final RequiredParams _self;
  final $Res Function(RequiredParams) _then;

  /// Create a copy of RequiredParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? a = null,
  }) {
    return _then(_self.copyWith(
      a: null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [RequiredParams].
extension RequiredParamsPatterns on RequiredParams {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(RequiredParams0 value)? $default, {
    TResult Function(RequiredParams1 value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case RequiredParams0() when $default != null:
        return $default(_that);
      case RequiredParams1() when second != null:
        return second(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(RequiredParams0 value) $default, {
    required TResult Function(RequiredParams1 value) second,
  }) {
    final _that = this;
    switch (_that) {
      case RequiredParams0():
        return $default(_that);
      case RequiredParams1():
        return second(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(RequiredParams0 value)? $default, {
    TResult? Function(RequiredParams1 value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case RequiredParams0() when $default != null:
        return $default(_that);
      case RequiredParams1() when second != null:
        return second(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String a)? $default, {
    TResult Function(String a)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case RequiredParams0() when $default != null:
        return $default(_that.a);
      case RequiredParams1() when second != null:
        return second(_that.a);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String a) $default, {
    required TResult Function(String a) second,
  }) {
    final _that = this;
    switch (_that) {
      case RequiredParams0():
        return $default(_that.a);
      case RequiredParams1():
        return second(_that.a);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String a)? $default, {
    TResult? Function(String a)? second,
  }) {
    final _that = this;
    switch (_that) {
      case RequiredParams0() when $default != null:
        return $default(_that.a);
      case RequiredParams1() when second != null:
        return second(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

class RequiredParams0 implements RequiredParams {
  const RequiredParams0({required this.a});

  @override
  final String a;

  /// Create a copy of RequiredParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RequiredParams0CopyWith<RequiredParams0> get copyWith =>
      _$RequiredParams0CopyWithImpl<RequiredParams0>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RequiredParams0 &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'RequiredParams(a: $a)';
  }
}

/// @nodoc
abstract mixin class $RequiredParams0CopyWith<$Res>
    implements $RequiredParamsCopyWith<$Res> {
  factory $RequiredParams0CopyWith(
          RequiredParams0 value, $Res Function(RequiredParams0) _then) =
      _$RequiredParams0CopyWithImpl;
  @override
  @useResult
  $Res call({String a});
}

/// @nodoc
class _$RequiredParams0CopyWithImpl<$Res>
    implements $RequiredParams0CopyWith<$Res> {
  _$RequiredParams0CopyWithImpl(this._self, this._then);

  final RequiredParams0 _self;
  final $Res Function(RequiredParams0) _then;

  /// Create a copy of RequiredParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(RequiredParams0(
      a: null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class RequiredParams1 implements RequiredParams {
  const RequiredParams1({required this.a});

  @override
  final String a;

  /// Create a copy of RequiredParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RequiredParams1CopyWith<RequiredParams1> get copyWith =>
      _$RequiredParams1CopyWithImpl<RequiredParams1>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RequiredParams1 &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'RequiredParams.second(a: $a)';
  }
}

/// @nodoc
abstract mixin class $RequiredParams1CopyWith<$Res>
    implements $RequiredParamsCopyWith<$Res> {
  factory $RequiredParams1CopyWith(
          RequiredParams1 value, $Res Function(RequiredParams1) _then) =
      _$RequiredParams1CopyWithImpl;
  @override
  @useResult
  $Res call({String a});
}

/// @nodoc
class _$RequiredParams1CopyWithImpl<$Res>
    implements $RequiredParams1CopyWith<$Res> {
  _$RequiredParams1CopyWithImpl(this._self, this._then);

  final RequiredParams1 _self;
  final $Res Function(RequiredParams1) _then;

  /// Create a copy of RequiredParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(RequiredParams1(
      a: null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$NestedList {
  List<dynamic> get children;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NestedList &&
            const DeepCollectionEquality().equals(other.children, children));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(children));

  @override
  String toString() {
    return 'NestedList(children: $children)';
  }
}

/// Adds pattern-matching-related methods to [NestedList].
extension NestedListPatterns on NestedList {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShallowNestedList value)? shallow,
    TResult Function(DeepNestedList value)? deep,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ShallowNestedList() when shallow != null:
        return shallow(_that);
      case DeepNestedList() when deep != null:
        return deep(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShallowNestedList value) shallow,
    required TResult Function(DeepNestedList value) deep,
  }) {
    final _that = this;
    switch (_that) {
      case ShallowNestedList():
        return shallow(_that);
      case DeepNestedList():
        return deep(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShallowNestedList value)? shallow,
    TResult? Function(DeepNestedList value)? deep,
  }) {
    final _that = this;
    switch (_that) {
      case ShallowNestedList() when shallow != null:
        return shallow(_that);
      case DeepNestedList() when deep != null:
        return deep(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<LeafNestedListItem> children)? shallow,
    TResult Function(List<InnerNestedListItem> children)? deep,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ShallowNestedList() when shallow != null:
        return shallow(_that.children);
      case DeepNestedList() when deep != null:
        return deep(_that.children);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<LeafNestedListItem> children) shallow,
    required TResult Function(List<InnerNestedListItem> children) deep,
  }) {
    final _that = this;
    switch (_that) {
      case ShallowNestedList():
        return shallow(_that.children);
      case DeepNestedList():
        return deep(_that.children);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<LeafNestedListItem> children)? shallow,
    TResult? Function(List<InnerNestedListItem> children)? deep,
  }) {
    final _that = this;
    switch (_that) {
      case ShallowNestedList() when shallow != null:
        return shallow(_that.children);
      case DeepNestedList() when deep != null:
        return deep(_that.children);
      case _:
        return null;
    }
  }
}

/// @nodoc

class ShallowNestedList implements NestedList {
  ShallowNestedList(final List<LeafNestedListItem> children)
      : _children = children;

  final List<LeafNestedListItem> _children;
  @override
  List<LeafNestedListItem> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ShallowNestedList &&
            const DeepCollectionEquality().equals(other._children, _children));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_children));

  @override
  String toString() {
    return 'NestedList.shallow(children: $children)';
  }
}

/// @nodoc

class DeepNestedList implements NestedList {
  DeepNestedList(final List<InnerNestedListItem> children)
      : _children = children;

  final List<InnerNestedListItem> _children;
  @override
  List<InnerNestedListItem> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DeepNestedList &&
            const DeepCollectionEquality().equals(other._children, _children));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_children));

  @override
  String toString() {
    return 'NestedList.deep(children: $children)';
  }
}

/// @nodoc
mixin _$NestedListItem {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is NestedListItem);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'NestedListItem()';
  }
}

/// @nodoc
class $NestedListItemCopyWith<$Res> {
  $NestedListItemCopyWith(NestedListItem _, $Res Function(NestedListItem) __);
}

/// Adds pattern-matching-related methods to [NestedListItem].
extension NestedListItemPatterns on NestedListItem {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LeafNestedListItem value)? leaf,
    TResult Function(InnerNestedListItem value)? inner,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case LeafNestedListItem() when leaf != null:
        return leaf(_that);
      case InnerNestedListItem() when inner != null:
        return inner(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LeafNestedListItem value) leaf,
    required TResult Function(InnerNestedListItem value) inner,
  }) {
    final _that = this;
    switch (_that) {
      case LeafNestedListItem():
        return leaf(_that);
      case InnerNestedListItem():
        return inner(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LeafNestedListItem value)? leaf,
    TResult? Function(InnerNestedListItem value)? inner,
  }) {
    final _that = this;
    switch (_that) {
      case LeafNestedListItem() when leaf != null:
        return leaf(_that);
      case InnerNestedListItem() when inner != null:
        return inner(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? leaf,
    TResult Function(List<LeafNestedListItem> children)? inner,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case LeafNestedListItem() when leaf != null:
        return leaf();
      case InnerNestedListItem() when inner != null:
        return inner(_that.children);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() leaf,
    required TResult Function(List<LeafNestedListItem> children) inner,
  }) {
    final _that = this;
    switch (_that) {
      case LeafNestedListItem():
        return leaf();
      case InnerNestedListItem():
        return inner(_that.children);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? leaf,
    TResult? Function(List<LeafNestedListItem> children)? inner,
  }) {
    final _that = this;
    switch (_that) {
      case LeafNestedListItem() when leaf != null:
        return leaf();
      case InnerNestedListItem() when inner != null:
        return inner(_that.children);
      case _:
        return null;
    }
  }
}

/// @nodoc

class LeafNestedListItem implements NestedListItem {
  LeafNestedListItem();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LeafNestedListItem);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'NestedListItem.leaf()';
  }
}

/// @nodoc

class InnerNestedListItem implements NestedListItem {
  InnerNestedListItem(final List<LeafNestedListItem> children)
      : _children = children;

  final List<LeafNestedListItem> _children;
  List<LeafNestedListItem> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  /// Create a copy of NestedListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InnerNestedListItemCopyWith<InnerNestedListItem> get copyWith =>
      _$InnerNestedListItemCopyWithImpl<InnerNestedListItem>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InnerNestedListItem &&
            const DeepCollectionEquality().equals(other._children, _children));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_children));

  @override
  String toString() {
    return 'NestedListItem.inner(children: $children)';
  }
}

/// @nodoc
abstract mixin class $InnerNestedListItemCopyWith<$Res>
    implements $NestedListItemCopyWith<$Res> {
  factory $InnerNestedListItemCopyWith(
          InnerNestedListItem value, $Res Function(InnerNestedListItem) _then) =
      _$InnerNestedListItemCopyWithImpl;
  @useResult
  $Res call({List<LeafNestedListItem> children});
}

/// @nodoc
class _$InnerNestedListItemCopyWithImpl<$Res>
    implements $InnerNestedListItemCopyWith<$Res> {
  _$InnerNestedListItemCopyWithImpl(this._self, this._then);

  final InnerNestedListItem _self;
  final $Res Function(InnerNestedListItem) _then;

  /// Create a copy of NestedListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? children = null,
  }) {
    return _then(InnerNestedListItem(
      null == children
          ? _self._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<LeafNestedListItem>,
    ));
  }
}

/// @nodoc
mixin _$NestedMap {
  Map<String, dynamic> get children;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NestedMap &&
            const DeepCollectionEquality().equals(other.children, children));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(children));

  @override
  String toString() {
    return 'NestedMap(children: $children)';
  }
}

/// Adds pattern-matching-related methods to [NestedMap].
extension NestedMapPatterns on NestedMap {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShallowNestedMap value)? shallow,
    TResult Function(DeepNestedMap value)? deep,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ShallowNestedMap() when shallow != null:
        return shallow(_that);
      case DeepNestedMap() when deep != null:
        return deep(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShallowNestedMap value) shallow,
    required TResult Function(DeepNestedMap value) deep,
  }) {
    final _that = this;
    switch (_that) {
      case ShallowNestedMap():
        return shallow(_that);
      case DeepNestedMap():
        return deep(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShallowNestedMap value)? shallow,
    TResult? Function(DeepNestedMap value)? deep,
  }) {
    final _that = this;
    switch (_that) {
      case ShallowNestedMap() when shallow != null:
        return shallow(_that);
      case DeepNestedMap() when deep != null:
        return deep(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, LeafNestedMapItem> children)? shallow,
    TResult Function(Map<String, InnerNestedMapItem> children)? deep,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ShallowNestedMap() when shallow != null:
        return shallow(_that.children);
      case DeepNestedMap() when deep != null:
        return deep(_that.children);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, LeafNestedMapItem> children) shallow,
    required TResult Function(Map<String, InnerNestedMapItem> children) deep,
  }) {
    final _that = this;
    switch (_that) {
      case ShallowNestedMap():
        return shallow(_that.children);
      case DeepNestedMap():
        return deep(_that.children);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, LeafNestedMapItem> children)? shallow,
    TResult? Function(Map<String, InnerNestedMapItem> children)? deep,
  }) {
    final _that = this;
    switch (_that) {
      case ShallowNestedMap() when shallow != null:
        return shallow(_that.children);
      case DeepNestedMap() when deep != null:
        return deep(_that.children);
      case _:
        return null;
    }
  }
}

/// @nodoc

class ShallowNestedMap implements NestedMap {
  ShallowNestedMap(final Map<String, LeafNestedMapItem> children)
      : _children = children;

  final Map<String, LeafNestedMapItem> _children;
  @override
  Map<String, LeafNestedMapItem> get children {
    if (_children is EqualUnmodifiableMapView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_children);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ShallowNestedMap &&
            const DeepCollectionEquality().equals(other._children, _children));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_children));

  @override
  String toString() {
    return 'NestedMap.shallow(children: $children)';
  }
}

/// @nodoc

class DeepNestedMap implements NestedMap {
  DeepNestedMap(final Map<String, InnerNestedMapItem> children)
      : _children = children;

  final Map<String, InnerNestedMapItem> _children;
  @override
  Map<String, InnerNestedMapItem> get children {
    if (_children is EqualUnmodifiableMapView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_children);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DeepNestedMap &&
            const DeepCollectionEquality().equals(other._children, _children));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_children));

  @override
  String toString() {
    return 'NestedMap.deep(children: $children)';
  }
}

/// @nodoc
mixin _$NestedMapItem {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is NestedMapItem);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'NestedMapItem()';
  }
}

/// @nodoc
class $NestedMapItemCopyWith<$Res> {
  $NestedMapItemCopyWith(NestedMapItem _, $Res Function(NestedMapItem) __);
}

/// Adds pattern-matching-related methods to [NestedMapItem].
extension NestedMapItemPatterns on NestedMapItem {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LeafNestedMapItem value)? leaf,
    TResult Function(InnerNestedMapItem value)? inner,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case LeafNestedMapItem() when leaf != null:
        return leaf(_that);
      case InnerNestedMapItem() when inner != null:
        return inner(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LeafNestedMapItem value) leaf,
    required TResult Function(InnerNestedMapItem value) inner,
  }) {
    final _that = this;
    switch (_that) {
      case LeafNestedMapItem():
        return leaf(_that);
      case InnerNestedMapItem():
        return inner(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LeafNestedMapItem value)? leaf,
    TResult? Function(InnerNestedMapItem value)? inner,
  }) {
    final _that = this;
    switch (_that) {
      case LeafNestedMapItem() when leaf != null:
        return leaf(_that);
      case InnerNestedMapItem() when inner != null:
        return inner(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? leaf,
    TResult Function(Map<String, LeafNestedMapItem> children)? inner,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case LeafNestedMapItem() when leaf != null:
        return leaf();
      case InnerNestedMapItem() when inner != null:
        return inner(_that.children);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() leaf,
    required TResult Function(Map<String, LeafNestedMapItem> children) inner,
  }) {
    final _that = this;
    switch (_that) {
      case LeafNestedMapItem():
        return leaf();
      case InnerNestedMapItem():
        return inner(_that.children);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? leaf,
    TResult? Function(Map<String, LeafNestedMapItem> children)? inner,
  }) {
    final _that = this;
    switch (_that) {
      case LeafNestedMapItem() when leaf != null:
        return leaf();
      case InnerNestedMapItem() when inner != null:
        return inner(_that.children);
      case _:
        return null;
    }
  }
}

/// @nodoc

class LeafNestedMapItem implements NestedMapItem {
  LeafNestedMapItem();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LeafNestedMapItem);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'NestedMapItem.leaf()';
  }
}

/// @nodoc

class InnerNestedMapItem implements NestedMapItem {
  InnerNestedMapItem(final Map<String, LeafNestedMapItem> children)
      : _children = children;

  final Map<String, LeafNestedMapItem> _children;
  Map<String, LeafNestedMapItem> get children {
    if (_children is EqualUnmodifiableMapView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_children);
  }

  /// Create a copy of NestedMapItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InnerNestedMapItemCopyWith<InnerNestedMapItem> get copyWith =>
      _$InnerNestedMapItemCopyWithImpl<InnerNestedMapItem>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InnerNestedMapItem &&
            const DeepCollectionEquality().equals(other._children, _children));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_children));

  @override
  String toString() {
    return 'NestedMapItem.inner(children: $children)';
  }
}

/// @nodoc
abstract mixin class $InnerNestedMapItemCopyWith<$Res>
    implements $NestedMapItemCopyWith<$Res> {
  factory $InnerNestedMapItemCopyWith(
          InnerNestedMapItem value, $Res Function(InnerNestedMapItem) _then) =
      _$InnerNestedMapItemCopyWithImpl;
  @useResult
  $Res call({Map<String, LeafNestedMapItem> children});
}

/// @nodoc
class _$InnerNestedMapItemCopyWithImpl<$Res>
    implements $InnerNestedMapItemCopyWith<$Res> {
  _$InnerNestedMapItemCopyWithImpl(this._self, this._then);

  final InnerNestedMapItem _self;
  final $Res Function(InnerNestedMapItem) _then;

  /// Create a copy of NestedMapItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? children = null,
  }) {
    return _then(InnerNestedMapItem(
      null == children
          ? _self._children
          : children // ignore: cast_nullable_to_non_nullable
              as Map<String, LeafNestedMapItem>,
    ));
  }
}

/// @nodoc
mixin _$ToBeGenerated {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ToBeGenerated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ToBeGenerated()';
  }
}

/// @nodoc
class $ToBeGeneratedCopyWith<$Res> {
  $ToBeGeneratedCopyWith(ToBeGenerated _, $Res Function(ToBeGenerated) __);
}

/// Adds pattern-matching-related methods to [ToBeGenerated].
extension ToBeGeneratedPatterns on ToBeGenerated {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CodeGenerated value)? generated,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CodeGenerated() when generated != null:
        return generated(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CodeGenerated value) generated,
  }) {
    final _that = this;
    switch (_that) {
      case CodeGenerated():
        return generated(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CodeGenerated value)? generated,
  }) {
    final _that = this;
    switch (_that) {
      case CodeGenerated() when generated != null:
        return generated(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? generated,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CodeGenerated() when generated != null:
        return generated();
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() generated,
  }) {
    final _that = this;
    switch (_that) {
      case CodeGenerated():
        return generated();
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? generated,
  }) {
    final _that = this;
    switch (_that) {
      case CodeGenerated() when generated != null:
        return generated();
      case _:
        return null;
    }
  }
}

/// @nodoc

class CodeGenerated implements ToBeGenerated {
  const CodeGenerated();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CodeGenerated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ToBeGenerated.generated()';
  }
}

/// @nodoc
mixin _$UsesGenerated {
  CodeGenerated get value;
  List<CodeGenerated> get list;
  List<List<CodeGenerated>> get nestedList;
  Map<int, CodeGenerated> get map;

  /// Create a copy of UsesGenerated
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UsesGeneratedCopyWith<UsesGenerated> get copyWith =>
      _$UsesGeneratedCopyWithImpl<UsesGenerated>(
          this as UsesGenerated, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UsesGenerated &&
            const DeepCollectionEquality().equals(other.value, value) &&
            const DeepCollectionEquality().equals(other.list, list) &&
            const DeepCollectionEquality()
                .equals(other.nestedList, nestedList) &&
            const DeepCollectionEquality().equals(other.map, map));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(value),
      const DeepCollectionEquality().hash(list),
      const DeepCollectionEquality().hash(nestedList),
      const DeepCollectionEquality().hash(map));

  @override
  String toString() {
    return 'UsesGenerated(value: $value, list: $list, nestedList: $nestedList, map: $map)';
  }
}

/// @nodoc
abstract mixin class $UsesGeneratedCopyWith<$Res> {
  factory $UsesGeneratedCopyWith(
          UsesGenerated value, $Res Function(UsesGenerated) _then) =
      _$UsesGeneratedCopyWithImpl;
  @useResult
  $Res call(
      {CodeGenerated value,
      List<CodeGenerated> list,
      List<List<CodeGenerated>> nestedList,
      Map<int, CodeGenerated> map});
}

/// @nodoc
class _$UsesGeneratedCopyWithImpl<$Res>
    implements $UsesGeneratedCopyWith<$Res> {
  _$UsesGeneratedCopyWithImpl(this._self, this._then);

  final UsesGenerated _self;
  final $Res Function(UsesGenerated) _then;

  /// Create a copy of UsesGenerated
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? list = null,
    Object? nestedList = null,
    Object? map = null,
  }) {
    return _then(_self.copyWith(
      value: freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as CodeGenerated,
      list: null == list
          ? _self.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<CodeGenerated>,
      nestedList: null == nestedList
          ? _self.nestedList
          : nestedList // ignore: cast_nullable_to_non_nullable
              as List<List<CodeGenerated>>,
      map: null == map
          ? _self.map
          : map // ignore: cast_nullable_to_non_nullable
              as Map<int, CodeGenerated>,
    ));
  }
}

/// Adds pattern-matching-related methods to [UsesGenerated].
extension UsesGeneratedPatterns on UsesGenerated {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_UsesGenerated value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UsesGenerated() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_UsesGenerated value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UsesGenerated():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_UsesGenerated value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UsesGenerated() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(CodeGenerated value, List<CodeGenerated> list,
            List<List<CodeGenerated>> nestedList, Map<int, CodeGenerated> map)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UsesGenerated() when $default != null:
        return $default(_that.value, _that.list, _that.nestedList, _that.map);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(CodeGenerated value, List<CodeGenerated> list,
            List<List<CodeGenerated>> nestedList, Map<int, CodeGenerated> map)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UsesGenerated():
        return $default(_that.value, _that.list, _that.nestedList, _that.map);
      case _:
        throw StateError('Unexpected subclass');
    }
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(CodeGenerated value, List<CodeGenerated> list,
            List<List<CodeGenerated>> nestedList, Map<int, CodeGenerated> map)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UsesGenerated() when $default != null:
        return $default(_that.value, _that.list, _that.nestedList, _that.map);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _UsesGenerated implements UsesGenerated {
  _UsesGenerated(
      this.value,
      final List<CodeGenerated> list,
      final List<List<CodeGenerated>> nestedList,
      final Map<int, CodeGenerated> map)
      : _list = list,
        _nestedList = nestedList,
        _map = map;

  @override
  final CodeGenerated value;
  final List<CodeGenerated> _list;
  @override
  List<CodeGenerated> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  final List<List<CodeGenerated>> _nestedList;
  @override
  List<List<CodeGenerated>> get nestedList {
    if (_nestedList is EqualUnmodifiableListView) return _nestedList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nestedList);
  }

  final Map<int, CodeGenerated> _map;
  @override
  Map<int, CodeGenerated> get map {
    if (_map is EqualUnmodifiableMapView) return _map;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_map);
  }

  /// Create a copy of UsesGenerated
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UsesGeneratedCopyWith<_UsesGenerated> get copyWith =>
      __$UsesGeneratedCopyWithImpl<_UsesGenerated>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UsesGenerated &&
            const DeepCollectionEquality().equals(other.value, value) &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            const DeepCollectionEquality()
                .equals(other._nestedList, _nestedList) &&
            const DeepCollectionEquality().equals(other._map, _map));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(value),
      const DeepCollectionEquality().hash(_list),
      const DeepCollectionEquality().hash(_nestedList),
      const DeepCollectionEquality().hash(_map));

  @override
  String toString() {
    return 'UsesGenerated(value: $value, list: $list, nestedList: $nestedList, map: $map)';
  }
}

/// @nodoc
abstract mixin class _$UsesGeneratedCopyWith<$Res>
    implements $UsesGeneratedCopyWith<$Res> {
  factory _$UsesGeneratedCopyWith(
          _UsesGenerated value, $Res Function(_UsesGenerated) _then) =
      __$UsesGeneratedCopyWithImpl;
  @override
  @useResult
  $Res call(
      {CodeGenerated value,
      List<CodeGenerated> list,
      List<List<CodeGenerated>> nestedList,
      Map<int, CodeGenerated> map});
}

/// @nodoc
class __$UsesGeneratedCopyWithImpl<$Res>
    implements _$UsesGeneratedCopyWith<$Res> {
  __$UsesGeneratedCopyWithImpl(this._self, this._then);

  final _UsesGenerated _self;
  final $Res Function(_UsesGenerated) _then;

  /// Create a copy of UsesGenerated
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = freezed,
    Object? list = null,
    Object? nestedList = null,
    Object? map = null,
  }) {
    return _then(_UsesGenerated(
      freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as CodeGenerated,
      null == list
          ? _self._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<CodeGenerated>,
      null == nestedList
          ? _self._nestedList
          : nestedList // ignore: cast_nullable_to_non_nullable
              as List<List<CodeGenerated>>,
      null == map
          ? _self._map
          : map // ignore: cast_nullable_to_non_nullable
              as Map<int, CodeGenerated>,
    ));
  }
}
