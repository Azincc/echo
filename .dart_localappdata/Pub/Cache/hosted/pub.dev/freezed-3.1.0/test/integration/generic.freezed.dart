// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generic.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AnyGeneric<T> {
  T get value;

  /// Create a copy of AnyGeneric
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AnyGenericCopyWith<T, AnyGeneric<T>> get copyWith =>
      _$AnyGenericCopyWithImpl<T, AnyGeneric<T>>(
          this as AnyGeneric<T>, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AnyGeneric<T> &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'AnyGeneric<$T>(value: $value)';
  }
}

/// @nodoc
abstract mixin class $AnyGenericCopyWith<T, $Res> {
  factory $AnyGenericCopyWith(
          AnyGeneric<T> value, $Res Function(AnyGeneric<T>) _then) =
      _$AnyGenericCopyWithImpl;
  @useResult
  $Res call({T value});
}

/// @nodoc
class _$AnyGenericCopyWithImpl<T, $Res>
    implements $AnyGenericCopyWith<T, $Res> {
  _$AnyGenericCopyWithImpl(this._self, this._then);

  final AnyGeneric<T> _self;
  final $Res Function(AnyGeneric<T>) _then;

  /// Create a copy of AnyGeneric
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_self.copyWith(
      value: freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// Adds pattern-matching-related methods to [AnyGeneric].
extension AnyGenericPatterns<T> on AnyGeneric<T> {
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
    TResult Function(_AnyGeneric<T> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AnyGeneric() when $default != null:
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
    TResult Function(_AnyGeneric<T> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AnyGeneric():
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
    TResult? Function(_AnyGeneric<T> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AnyGeneric() when $default != null:
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
    TResult Function(T value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AnyGeneric() when $default != null:
        return $default(_that.value);
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
    TResult Function(T value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AnyGeneric():
        return $default(_that.value);
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
    TResult? Function(T value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AnyGeneric() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AnyGeneric<T> implements AnyGeneric<T> {
  _AnyGeneric(this.value);

  @override
  final T value;

  /// Create a copy of AnyGeneric
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AnyGenericCopyWith<T, _AnyGeneric<T>> get copyWith =>
      __$AnyGenericCopyWithImpl<T, _AnyGeneric<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AnyGeneric<T> &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'AnyGeneric<$T>(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$AnyGenericCopyWith<T, $Res>
    implements $AnyGenericCopyWith<T, $Res> {
  factory _$AnyGenericCopyWith(
          _AnyGeneric<T> value, $Res Function(_AnyGeneric<T>) _then) =
      __$AnyGenericCopyWithImpl;
  @override
  @useResult
  $Res call({T value});
}

/// @nodoc
class __$AnyGenericCopyWithImpl<T, $Res>
    implements _$AnyGenericCopyWith<T, $Res> {
  __$AnyGenericCopyWithImpl(this._self, this._then);

  final _AnyGeneric<T> _self;
  final $Res Function(_AnyGeneric<T>) _then;

  /// Create a copy of AnyGeneric
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_AnyGeneric<T>(
      freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc
mixin _$NullableGeneric<T extends Object?> {
  T get value;

  /// Create a copy of NullableGeneric
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NullableGenericCopyWith<T, NullableGeneric<T>> get copyWith =>
      _$NullableGenericCopyWithImpl<T, NullableGeneric<T>>(
          this as NullableGeneric<T>, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NullableGeneric<T> &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'NullableGeneric<$T>(value: $value)';
  }
}

/// @nodoc
abstract mixin class $NullableGenericCopyWith<T extends Object?, $Res> {
  factory $NullableGenericCopyWith(
          NullableGeneric<T> value, $Res Function(NullableGeneric<T>) _then) =
      _$NullableGenericCopyWithImpl;
  @useResult
  $Res call({T value});
}

/// @nodoc
class _$NullableGenericCopyWithImpl<T extends Object?, $Res>
    implements $NullableGenericCopyWith<T, $Res> {
  _$NullableGenericCopyWithImpl(this._self, this._then);

  final NullableGeneric<T> _self;
  final $Res Function(NullableGeneric<T>) _then;

  /// Create a copy of NullableGeneric
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_self.copyWith(
      value: freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// Adds pattern-matching-related methods to [NullableGeneric].
extension NullableGenericPatterns<T extends Object?> on NullableGeneric<T> {
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
    TResult Function(_NullableGeneric<T> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NullableGeneric() when $default != null:
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
    TResult Function(_NullableGeneric<T> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NullableGeneric():
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
    TResult? Function(_NullableGeneric<T> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NullableGeneric() when $default != null:
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
    TResult Function(T value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NullableGeneric() when $default != null:
        return $default(_that.value);
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
    TResult Function(T value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NullableGeneric():
        return $default(_that.value);
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
    TResult? Function(T value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NullableGeneric() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _NullableGeneric<T extends Object?> implements NullableGeneric<T> {
  _NullableGeneric(this.value);

  @override
  final T value;

  /// Create a copy of NullableGeneric
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NullableGenericCopyWith<T, _NullableGeneric<T>> get copyWith =>
      __$NullableGenericCopyWithImpl<T, _NullableGeneric<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NullableGeneric<T> &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'NullableGeneric<$T>(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$NullableGenericCopyWith<T extends Object?, $Res>
    implements $NullableGenericCopyWith<T, $Res> {
  factory _$NullableGenericCopyWith(
          _NullableGeneric<T> value, $Res Function(_NullableGeneric<T>) _then) =
      __$NullableGenericCopyWithImpl;
  @override
  @useResult
  $Res call({T value});
}

/// @nodoc
class __$NullableGenericCopyWithImpl<T extends Object?, $Res>
    implements _$NullableGenericCopyWith<T, $Res> {
  __$NullableGenericCopyWithImpl(this._self, this._then);

  final _NullableGeneric<T> _self;
  final $Res Function(_NullableGeneric<T>) _then;

  /// Create a copy of NullableGeneric
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_NullableGeneric<T>(
      freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc
mixin _$NonNullableGeneric<T extends Object> {
  T get value;

  /// Create a copy of NonNullableGeneric
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NonNullableGenericCopyWith<T, NonNullableGeneric<T>> get copyWith =>
      _$NonNullableGenericCopyWithImpl<T, NonNullableGeneric<T>>(
          this as NonNullableGeneric<T>, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NonNullableGeneric<T> &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'NonNullableGeneric<$T>(value: $value)';
  }
}

/// @nodoc
abstract mixin class $NonNullableGenericCopyWith<T extends Object, $Res> {
  factory $NonNullableGenericCopyWith(NonNullableGeneric<T> value,
          $Res Function(NonNullableGeneric<T>) _then) =
      _$NonNullableGenericCopyWithImpl;
  @useResult
  $Res call({T value});
}

/// @nodoc
class _$NonNullableGenericCopyWithImpl<T extends Object, $Res>
    implements $NonNullableGenericCopyWith<T, $Res> {
  _$NonNullableGenericCopyWithImpl(this._self, this._then);

  final NonNullableGeneric<T> _self;
  final $Res Function(NonNullableGeneric<T>) _then;

  /// Create a copy of NonNullableGeneric
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
              as T,
    ));
  }
}

/// Adds pattern-matching-related methods to [NonNullableGeneric].
extension NonNullableGenericPatterns<T extends Object>
    on NonNullableGeneric<T> {
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
    TResult Function(_NonNullableGeneric<T> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NonNullableGeneric() when $default != null:
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
    TResult Function(_NonNullableGeneric<T> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NonNullableGeneric():
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
    TResult? Function(_NonNullableGeneric<T> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NonNullableGeneric() when $default != null:
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
    TResult Function(T value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NonNullableGeneric() when $default != null:
        return $default(_that.value);
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
    TResult Function(T value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NonNullableGeneric():
        return $default(_that.value);
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
    TResult? Function(T value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NonNullableGeneric() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _NonNullableGeneric<T extends Object> implements NonNullableGeneric<T> {
  _NonNullableGeneric(this.value);

  @override
  final T value;

  /// Create a copy of NonNullableGeneric
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NonNullableGenericCopyWith<T, _NonNullableGeneric<T>> get copyWith =>
      __$NonNullableGenericCopyWithImpl<T, _NonNullableGeneric<T>>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NonNullableGeneric<T> &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'NonNullableGeneric<$T>(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$NonNullableGenericCopyWith<T extends Object, $Res>
    implements $NonNullableGenericCopyWith<T, $Res> {
  factory _$NonNullableGenericCopyWith(_NonNullableGeneric<T> value,
          $Res Function(_NonNullableGeneric<T>) _then) =
      __$NonNullableGenericCopyWithImpl;
  @override
  @useResult
  $Res call({T value});
}

/// @nodoc
class __$NonNullableGenericCopyWithImpl<T extends Object, $Res>
    implements _$NonNullableGenericCopyWith<T, $Res> {
  __$NonNullableGenericCopyWithImpl(this._self, this._then);

  final _NonNullableGeneric<T> _self;
  final $Res Function(_NonNullableGeneric<T>) _then;

  /// Create a copy of NonNullableGeneric
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_NonNullableGeneric<T>(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc
mixin _$GenericOrNull<T extends Object> {
  T? get value;

  /// Create a copy of GenericOrNull
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GenericOrNullCopyWith<T, GenericOrNull<T>> get copyWith =>
      _$GenericOrNullCopyWithImpl<T, GenericOrNull<T>>(
          this as GenericOrNull<T>, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GenericOrNull<T> &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'GenericOrNull<$T>(value: $value)';
  }
}

/// @nodoc
abstract mixin class $GenericOrNullCopyWith<T extends Object, $Res> {
  factory $GenericOrNullCopyWith(
          GenericOrNull<T> value, $Res Function(GenericOrNull<T>) _then) =
      _$GenericOrNullCopyWithImpl;
  @useResult
  $Res call({T? value});
}

/// @nodoc
class _$GenericOrNullCopyWithImpl<T extends Object, $Res>
    implements $GenericOrNullCopyWith<T, $Res> {
  _$GenericOrNullCopyWithImpl(this._self, this._then);

  final GenericOrNull<T> _self;
  final $Res Function(GenericOrNull<T>) _then;

  /// Create a copy of GenericOrNull
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_self.copyWith(
      value: freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as T?,
    ));
  }
}

/// Adds pattern-matching-related methods to [GenericOrNull].
extension GenericOrNullPatterns<T extends Object> on GenericOrNull<T> {
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
    TResult Function(_GenericOrNull<T> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GenericOrNull() when $default != null:
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
    TResult Function(_GenericOrNull<T> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenericOrNull():
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
    TResult? Function(_GenericOrNull<T> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenericOrNull() when $default != null:
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
    TResult Function(T? value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GenericOrNull() when $default != null:
        return $default(_that.value);
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
    TResult Function(T? value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenericOrNull():
        return $default(_that.value);
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
    TResult? Function(T? value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenericOrNull() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GenericOrNull<T extends Object> implements GenericOrNull<T> {
  _GenericOrNull(this.value);

  @override
  final T? value;

  /// Create a copy of GenericOrNull
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GenericOrNullCopyWith<T, _GenericOrNull<T>> get copyWith =>
      __$GenericOrNullCopyWithImpl<T, _GenericOrNull<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GenericOrNull<T> &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'GenericOrNull<$T>(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$GenericOrNullCopyWith<T extends Object, $Res>
    implements $GenericOrNullCopyWith<T, $Res> {
  factory _$GenericOrNullCopyWith(
          _GenericOrNull<T> value, $Res Function(_GenericOrNull<T>) _then) =
      __$GenericOrNullCopyWithImpl;
  @override
  @useResult
  $Res call({T? value});
}

/// @nodoc
class __$GenericOrNullCopyWithImpl<T extends Object, $Res>
    implements _$GenericOrNullCopyWith<T, $Res> {
  __$GenericOrNullCopyWithImpl(this._self, this._then);

  final _GenericOrNull<T> _self;
  final $Res Function(_GenericOrNull<T>) _then;

  /// Create a copy of GenericOrNull
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_GenericOrNull<T>(
      freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as T?,
    ));
  }
}

/// @nodoc
mixin _$Generic<T extends Model<dynamic>> {
  T get model;

  /// Create a copy of Generic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GenericCopyWith<T, Generic<T>> get copyWith =>
      _$GenericCopyWithImpl<T, Generic<T>>(this as Generic<T>, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Generic<T> &&
            const DeepCollectionEquality().equals(other.model, model));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(model));

  @override
  String toString() {
    return 'Generic<$T>(model: $model)';
  }
}

/// @nodoc
abstract mixin class $GenericCopyWith<T extends Model<dynamic>, $Res> {
  factory $GenericCopyWith(Generic<T> value, $Res Function(Generic<T>) _then) =
      _$GenericCopyWithImpl;
  @useResult
  $Res call({T model});
}

/// @nodoc
class _$GenericCopyWithImpl<T extends Model<dynamic>, $Res>
    implements $GenericCopyWith<T, $Res> {
  _$GenericCopyWithImpl(this._self, this._then);

  final Generic<T> _self;
  final $Res Function(Generic<T>) _then;

  /// Create a copy of Generic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = null,
  }) {
    return _then(_self.copyWith(
      model: null == model
          ? _self.model
          : model // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// Adds pattern-matching-related methods to [Generic].
extension GenericPatterns<T extends Model<dynamic>> on Generic<T> {
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
    TResult Function(_Generic<T> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Generic() when $default != null:
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
    TResult Function(_Generic<T> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Generic():
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
    TResult? Function(_Generic<T> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Generic() when $default != null:
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
    TResult Function(T model)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Generic() when $default != null:
        return $default(_that.model);
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
    TResult Function(T model) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Generic():
        return $default(_that.model);
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
    TResult? Function(T model)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Generic() when $default != null:
        return $default(_that.model);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Generic<T extends Model<dynamic>> implements Generic<T> {
  _Generic(this.model);

  @override
  final T model;

  /// Create a copy of Generic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GenericCopyWith<T, _Generic<T>> get copyWith =>
      __$GenericCopyWithImpl<T, _Generic<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Generic<T> &&
            const DeepCollectionEquality().equals(other.model, model));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(model));

  @override
  String toString() {
    return 'Generic<$T>(model: $model)';
  }
}

/// @nodoc
abstract mixin class _$GenericCopyWith<T extends Model<dynamic>, $Res>
    implements $GenericCopyWith<T, $Res> {
  factory _$GenericCopyWith(
          _Generic<T> value, $Res Function(_Generic<T>) _then) =
      __$GenericCopyWithImpl;
  @override
  @useResult
  $Res call({T model});
}

/// @nodoc
class __$GenericCopyWithImpl<T extends Model<dynamic>, $Res>
    implements _$GenericCopyWith<T, $Res> {
  __$GenericCopyWithImpl(this._self, this._then);

  final _Generic<T> _self;
  final $Res Function(_Generic<T>) _then;

  /// Create a copy of Generic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? model = null,
  }) {
    return _then(_Generic<T>(
      null == model
          ? _self.model
          : model // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc
mixin _$MultiGeneric<A, T extends Model<A>> {
  T get model;

  /// Create a copy of MultiGeneric
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MultiGenericCopyWith<A, T, MultiGeneric<A, T>> get copyWith =>
      _$MultiGenericCopyWithImpl<A, T, MultiGeneric<A, T>>(
          this as MultiGeneric<A, T>, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MultiGeneric<A, T> &&
            const DeepCollectionEquality().equals(other.model, model));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(model));

  @override
  String toString() {
    return 'MultiGeneric<$A, $T>(model: $model)';
  }
}

/// @nodoc
abstract mixin class $MultiGenericCopyWith<A, T extends Model<A>, $Res> {
  factory $MultiGenericCopyWith(
          MultiGeneric<A, T> value, $Res Function(MultiGeneric<A, T>) _then) =
      _$MultiGenericCopyWithImpl;
  @useResult
  $Res call({T model});
}

/// @nodoc
class _$MultiGenericCopyWithImpl<A, T extends Model<A>, $Res>
    implements $MultiGenericCopyWith<A, T, $Res> {
  _$MultiGenericCopyWithImpl(this._self, this._then);

  final MultiGeneric<A, T> _self;
  final $Res Function(MultiGeneric<A, T>) _then;

  /// Create a copy of MultiGeneric
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = null,
  }) {
    return _then(_self.copyWith(
      model: null == model
          ? _self.model
          : model // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// Adds pattern-matching-related methods to [MultiGeneric].
extension MultiGenericPatterns<A, T extends Model<A>> on MultiGeneric<A, T> {
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
    TResult Function(_MultiGeneric<A, T> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MultiGeneric() when $default != null:
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
    TResult Function(_MultiGeneric<A, T> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MultiGeneric():
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
    TResult? Function(_MultiGeneric<A, T> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MultiGeneric() when $default != null:
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
    TResult Function(T model)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MultiGeneric() when $default != null:
        return $default(_that.model);
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
    TResult Function(T model) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MultiGeneric():
        return $default(_that.model);
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
    TResult? Function(T model)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MultiGeneric() when $default != null:
        return $default(_that.model);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _MultiGeneric<A, T extends Model<A>> implements MultiGeneric<A, T> {
  _MultiGeneric(this.model);

  @override
  final T model;

  /// Create a copy of MultiGeneric
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MultiGenericCopyWith<A, T, _MultiGeneric<A, T>> get copyWith =>
      __$MultiGenericCopyWithImpl<A, T, _MultiGeneric<A, T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MultiGeneric<A, T> &&
            const DeepCollectionEquality().equals(other.model, model));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(model));

  @override
  String toString() {
    return 'MultiGeneric<$A, $T>(model: $model)';
  }
}

/// @nodoc
abstract mixin class _$MultiGenericCopyWith<A, T extends Model<A>, $Res>
    implements $MultiGenericCopyWith<A, T, $Res> {
  factory _$MultiGenericCopyWith(
          _MultiGeneric<A, T> value, $Res Function(_MultiGeneric<A, T>) _then) =
      __$MultiGenericCopyWithImpl;
  @override
  @useResult
  $Res call({T model});
}

/// @nodoc
class __$MultiGenericCopyWithImpl<A, T extends Model<A>, $Res>
    implements _$MultiGenericCopyWith<A, T, $Res> {
  __$MultiGenericCopyWithImpl(this._self, this._then);

  final _MultiGeneric<A, T> _self;
  final $Res Function(_MultiGeneric<A, T>) _then;

  /// Create a copy of MultiGeneric
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? model = null,
  }) {
    return _then(_MultiGeneric<A, T>(
      null == model
          ? _self.model
          : model // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc
mixin _$MultipleConstructors<A, B> {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MultipleConstructors<A, B>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MultipleConstructors<$A, $B>()';
  }
}

/// @nodoc
class $MultipleConstructorsCopyWith<A, B, $Res> {
  $MultipleConstructorsCopyWith(MultipleConstructors<A, B> _,
      $Res Function(MultipleConstructors<A, B>) __);
}

/// Adds pattern-matching-related methods to [MultipleConstructors].
extension MultipleConstructorsPatterns<A, B> on MultipleConstructors<A, B> {
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
    TResult Function(Default<A, B> value)? $default, {
    TResult Function(First<A, B> value)? first,
    TResult Function(Second<A, B> value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Default() when $default != null:
        return $default(_that);
      case First() when first != null:
        return first(_that);
      case Second() when second != null:
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
    TResult Function(Default<A, B> value) $default, {
    required TResult Function(First<A, B> value) first,
    required TResult Function(Second<A, B> value) second,
  }) {
    final _that = this;
    switch (_that) {
      case Default():
        return $default(_that);
      case First():
        return first(_that);
      case Second():
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
    TResult? Function(Default<A, B> value)? $default, {
    TResult? Function(First<A, B> value)? first,
    TResult? Function(Second<A, B> value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case Default() when $default != null:
        return $default(_that);
      case First() when first != null:
        return first(_that);
      case Second() when second != null:
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
    TResult Function(bool flag)? $default, {
    TResult Function(A a)? first,
    TResult Function(B b)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Default() when $default != null:
        return $default(_that.flag);
      case First() when first != null:
        return first(_that.a);
      case Second() when second != null:
        return second(_that.b);
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
    TResult Function(bool flag) $default, {
    required TResult Function(A a) first,
    required TResult Function(B b) second,
  }) {
    final _that = this;
    switch (_that) {
      case Default():
        return $default(_that.flag);
      case First():
        return first(_that.a);
      case Second():
        return second(_that.b);
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
    TResult? Function(bool flag)? $default, {
    TResult? Function(A a)? first,
    TResult? Function(B b)? second,
  }) {
    final _that = this;
    switch (_that) {
      case Default() when $default != null:
        return $default(_that.flag);
      case First() when first != null:
        return first(_that.a);
      case Second() when second != null:
        return second(_that.b);
      case _:
        return null;
    }
  }
}

/// @nodoc

class Default<A, B> implements MultipleConstructors<A, B> {
  Default(this.flag);

  final bool flag;

  /// Create a copy of MultipleConstructors
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DefaultCopyWith<A, B, Default<A, B>> get copyWith =>
      _$DefaultCopyWithImpl<A, B, Default<A, B>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Default<A, B> &&
            (identical(other.flag, flag) || other.flag == flag));
  }

  @override
  int get hashCode => Object.hash(runtimeType, flag);

  @override
  String toString() {
    return 'MultipleConstructors<$A, $B>(flag: $flag)';
  }
}

/// @nodoc
abstract mixin class $DefaultCopyWith<A, B, $Res>
    implements $MultipleConstructorsCopyWith<A, B, $Res> {
  factory $DefaultCopyWith(
          Default<A, B> value, $Res Function(Default<A, B>) _then) =
      _$DefaultCopyWithImpl;
  @useResult
  $Res call({bool flag});
}

/// @nodoc
class _$DefaultCopyWithImpl<A, B, $Res>
    implements $DefaultCopyWith<A, B, $Res> {
  _$DefaultCopyWithImpl(this._self, this._then);

  final Default<A, B> _self;
  final $Res Function(Default<A, B>) _then;

  /// Create a copy of MultipleConstructors
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? flag = null,
  }) {
    return _then(Default<A, B>(
      null == flag
          ? _self.flag
          : flag // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class First<A, B> implements MultipleConstructors<A, B> {
  First(this.a);

  final A a;

  /// Create a copy of MultipleConstructors
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FirstCopyWith<A, B, First<A, B>> get copyWith =>
      _$FirstCopyWithImpl<A, B, First<A, B>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is First<A, B> &&
            const DeepCollectionEquality().equals(other.a, a));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(a));

  @override
  String toString() {
    return 'MultipleConstructors<$A, $B>.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class $FirstCopyWith<A, B, $Res>
    implements $MultipleConstructorsCopyWith<A, B, $Res> {
  factory $FirstCopyWith(First<A, B> value, $Res Function(First<A, B>) _then) =
      _$FirstCopyWithImpl;
  @useResult
  $Res call({A a});
}

/// @nodoc
class _$FirstCopyWithImpl<A, B, $Res> implements $FirstCopyWith<A, B, $Res> {
  _$FirstCopyWithImpl(this._self, this._then);

  final First<A, B> _self;
  final $Res Function(First<A, B>) _then;

  /// Create a copy of MultipleConstructors
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = freezed,
  }) {
    return _then(First<A, B>(
      freezed == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as A,
    ));
  }
}

/// @nodoc

class Second<A, B> implements MultipleConstructors<A, B> {
  Second(this.b);

  final B b;

  /// Create a copy of MultipleConstructors
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SecondCopyWith<A, B, Second<A, B>> get copyWith =>
      _$SecondCopyWithImpl<A, B, Second<A, B>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Second<A, B> &&
            const DeepCollectionEquality().equals(other.b, b));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(b));

  @override
  String toString() {
    return 'MultipleConstructors<$A, $B>.second(b: $b)';
  }
}

/// @nodoc
abstract mixin class $SecondCopyWith<A, B, $Res>
    implements $MultipleConstructorsCopyWith<A, B, $Res> {
  factory $SecondCopyWith(
          Second<A, B> value, $Res Function(Second<A, B>) _then) =
      _$SecondCopyWithImpl;
  @useResult
  $Res call({B b});
}

/// @nodoc
class _$SecondCopyWithImpl<A, B, $Res> implements $SecondCopyWith<A, B, $Res> {
  _$SecondCopyWithImpl(this._self, this._then);

  final Second<A, B> _self;
  final $Res Function(Second<A, B>) _then;

  /// Create a copy of MultipleConstructors
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? b = freezed,
  }) {
    return _then(Second<A, B>(
      freezed == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as B,
    ));
  }
}

/// @nodoc
mixin _$Union<T> {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Union<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Union<$T>()';
  }
}

/// @nodoc
class $UnionCopyWith<T, $Res> {
  $UnionCopyWith(Union<T> _, $Res Function(Union<T>) __);
}

/// Adds pattern-matching-related methods to [Union].
extension UnionPatterns<T> on Union<T> {
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
    TResult Function(Data<T> value)? $default, {
    TResult Function(Loading<T> value)? loading,
    TResult Function(ErrorDetails<T> value)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Data() when $default != null:
        return $default(_that);
      case Loading() when loading != null:
        return loading(_that);
      case ErrorDetails() when error != null:
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
  TResult map<TResult extends Object?>(
    TResult Function(Data<T> value) $default, {
    required TResult Function(Loading<T> value) loading,
    required TResult Function(ErrorDetails<T> value) error,
  }) {
    final _that = this;
    switch (_that) {
      case Data():
        return $default(_that);
      case Loading():
        return loading(_that);
      case ErrorDetails():
        return error(_that);
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
    TResult? Function(Data<T> value)? $default, {
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(ErrorDetails<T> value)? error,
  }) {
    final _that = this;
    switch (_that) {
      case Data() when $default != null:
        return $default(_that);
      case Loading() when loading != null:
        return loading(_that);
      case ErrorDetails() when error != null:
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(T value)? $default, {
    TResult Function()? loading,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Data() when $default != null:
        return $default(_that.value);
      case Loading() when loading != null:
        return loading();
      case ErrorDetails() when error != null:
        return error(_that.message);
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
    TResult Function(T value) $default, {
    required TResult Function() loading,
    required TResult Function(String? message) error,
  }) {
    final _that = this;
    switch (_that) {
      case Data():
        return $default(_that.value);
      case Loading():
        return loading();
      case ErrorDetails():
        return error(_that.message);
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
    TResult? Function(T value)? $default, {
    TResult? Function()? loading,
    TResult? Function(String? message)? error,
  }) {
    final _that = this;
    switch (_that) {
      case Data() when $default != null:
        return $default(_that.value);
      case Loading() when loading != null:
        return loading();
      case ErrorDetails() when error != null:
        return error(_that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc

class Data<T> implements Union<T> {
  const Data(this.value);

  final T value;

  /// Create a copy of Union
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DataCopyWith<T, Data<T>> get copyWith =>
      _$DataCopyWithImpl<T, Data<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Data<T> &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'Union<$T>(value: $value)';
  }
}

/// @nodoc
abstract mixin class $DataCopyWith<T, $Res> implements $UnionCopyWith<T, $Res> {
  factory $DataCopyWith(Data<T> value, $Res Function(Data<T>) _then) =
      _$DataCopyWithImpl;
  @useResult
  $Res call({T value});
}

/// @nodoc
class _$DataCopyWithImpl<T, $Res> implements $DataCopyWith<T, $Res> {
  _$DataCopyWithImpl(this._self, this._then);

  final Data<T> _self;
  final $Res Function(Data<T>) _then;

  /// Create a copy of Union
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = freezed,
  }) {
    return _then(Data<T>(
      freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class Loading<T> implements Union<T> {
  const Loading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Loading<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Union<$T>.loading()';
  }
}

/// @nodoc

class ErrorDetails<T> implements Union<T> {
  const ErrorDetails([this.message]);

  final String? message;

  /// Create a copy of Union
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ErrorDetailsCopyWith<T, ErrorDetails<T>> get copyWith =>
      _$ErrorDetailsCopyWithImpl<T, ErrorDetails<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ErrorDetails<T> &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'Union<$T>.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $ErrorDetailsCopyWith<T, $Res>
    implements $UnionCopyWith<T, $Res> {
  factory $ErrorDetailsCopyWith(
          ErrorDetails<T> value, $Res Function(ErrorDetails<T>) _then) =
      _$ErrorDetailsCopyWithImpl;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$ErrorDetailsCopyWithImpl<T, $Res>
    implements $ErrorDetailsCopyWith<T, $Res> {
  _$ErrorDetailsCopyWithImpl(this._self, this._then);

  final ErrorDetails<T> _self;
  final $Res Function(ErrorDetails<T>) _then;

  /// Create a copy of Union
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = freezed,
  }) {
    return _then(ErrorDetails<T>(
      freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$ComplexParameters<T> {
  List<T> get value;

  /// Create a copy of ComplexParameters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComplexParametersCopyWith<T, ComplexParameters<T>> get copyWith =>
      _$ComplexParametersCopyWithImpl<T, ComplexParameters<T>>(
          this as ComplexParameters<T>, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComplexParameters<T> &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'ComplexParameters<$T>(value: $value)';
  }
}

/// @nodoc
abstract mixin class $ComplexParametersCopyWith<T, $Res> {
  factory $ComplexParametersCopyWith(ComplexParameters<T> value,
          $Res Function(ComplexParameters<T>) _then) =
      _$ComplexParametersCopyWithImpl;
  @useResult
  $Res call({List<T> value});
}

/// @nodoc
class _$ComplexParametersCopyWithImpl<T, $Res>
    implements $ComplexParametersCopyWith<T, $Res> {
  _$ComplexParametersCopyWithImpl(this._self, this._then);

  final ComplexParameters<T> _self;
  final $Res Function(ComplexParameters<T>) _then;

  /// Create a copy of ComplexParameters
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
              as List<T>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ComplexParameters].
extension ComplexParametersPatterns<T> on ComplexParameters<T> {
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
    TResult Function(_ComplexParameters<T> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplexParameters() when $default != null:
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
    TResult Function(_ComplexParameters<T> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplexParameters():
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
    TResult? Function(_ComplexParameters<T> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplexParameters() when $default != null:
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
    TResult Function(List<T> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplexParameters() when $default != null:
        return $default(_that.value);
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
    TResult Function(List<T> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplexParameters():
        return $default(_that.value);
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
    TResult? Function(List<T> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplexParameters() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ComplexParameters<T> implements ComplexParameters<T> {
  const _ComplexParameters(final List<T> value) : _value = value;

  final List<T> _value;
  @override
  List<T> get value {
    if (_value is EqualUnmodifiableListView) return _value;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_value);
  }

  /// Create a copy of ComplexParameters
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComplexParametersCopyWith<T, _ComplexParameters<T>> get copyWith =>
      __$ComplexParametersCopyWithImpl<T, _ComplexParameters<T>>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComplexParameters<T> &&
            const DeepCollectionEquality().equals(other._value, _value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_value));

  @override
  String toString() {
    return 'ComplexParameters<$T>(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$ComplexParametersCopyWith<T, $Res>
    implements $ComplexParametersCopyWith<T, $Res> {
  factory _$ComplexParametersCopyWith(_ComplexParameters<T> value,
          $Res Function(_ComplexParameters<T>) _then) =
      __$ComplexParametersCopyWithImpl;
  @override
  @useResult
  $Res call({List<T> value});
}

/// @nodoc
class __$ComplexParametersCopyWithImpl<T, $Res>
    implements _$ComplexParametersCopyWith<T, $Res> {
  __$ComplexParametersCopyWithImpl(this._self, this._then);

  final _ComplexParameters<T> _self;
  final $Res Function(_ComplexParameters<T>) _then;

  /// Create a copy of ComplexParameters
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_ComplexParameters<T>(
      null == value
          ? _self._value
          : value // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc
mixin _$Inner<I> {
  I? get data;

  /// Create a copy of Inner
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InnerCopyWith<I, Inner<I>> get copyWith =>
      _$InnerCopyWithImpl<I, Inner<I>>(this as Inner<I>, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Inner<I> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @override
  String toString() {
    return 'Inner<$I>(data: $data)';
  }
}

/// @nodoc
abstract mixin class $InnerCopyWith<I, $Res> {
  factory $InnerCopyWith(Inner<I> value, $Res Function(Inner<I>) _then) =
      _$InnerCopyWithImpl;
  @useResult
  $Res call({I? data});
}

/// @nodoc
class _$InnerCopyWithImpl<I, $Res> implements $InnerCopyWith<I, $Res> {
  _$InnerCopyWithImpl(this._self, this._then);

  final Inner<I> _self;
  final $Res Function(Inner<I>) _then;

  /// Create a copy of Inner
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_self.copyWith(
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as I?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Inner].
extension InnerPatterns<I> on Inner<I> {
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
    TResult Function(_Inner<I> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Inner() when $default != null:
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
    TResult Function(_Inner<I> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Inner():
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
    TResult? Function(_Inner<I> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Inner() when $default != null:
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
    TResult Function(I? data)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Inner() when $default != null:
        return $default(_that.data);
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
    TResult Function(I? data) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Inner():
        return $default(_that.data);
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
    TResult? Function(I? data)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Inner() when $default != null:
        return $default(_that.data);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Inner<I> implements Inner<I> {
  const _Inner({this.data});

  @override
  final I? data;

  /// Create a copy of Inner
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$InnerCopyWith<I, _Inner<I>> get copyWith =>
      __$InnerCopyWithImpl<I, _Inner<I>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Inner<I> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @override
  String toString() {
    return 'Inner<$I>(data: $data)';
  }
}

/// @nodoc
abstract mixin class _$InnerCopyWith<I, $Res>
    implements $InnerCopyWith<I, $Res> {
  factory _$InnerCopyWith(_Inner<I> value, $Res Function(_Inner<I>) _then) =
      __$InnerCopyWithImpl;
  @override
  @useResult
  $Res call({I? data});
}

/// @nodoc
class __$InnerCopyWithImpl<I, $Res> implements _$InnerCopyWith<I, $Res> {
  __$InnerCopyWithImpl(this._self, this._then);

  final _Inner<I> _self;
  final $Res Function(_Inner<I>) _then;

  /// Create a copy of Inner
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_Inner<I>(
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as I?,
    ));
  }
}

/// @nodoc
mixin _$Outer {
  Inner<int>? get innerData;

  /// Create a copy of Outer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OuterCopyWith<Outer> get copyWith =>
      _$OuterCopyWithImpl<Outer>(this as Outer, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Outer &&
            (identical(other.innerData, innerData) ||
                other.innerData == innerData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, innerData);

  @override
  String toString() {
    return 'Outer(innerData: $innerData)';
  }
}

/// @nodoc
abstract mixin class $OuterCopyWith<$Res> {
  factory $OuterCopyWith(Outer value, $Res Function(Outer) _then) =
      _$OuterCopyWithImpl;
  @useResult
  $Res call({Inner<int>? innerData});

  $InnerCopyWith<int, $Res>? get innerData;
}

/// @nodoc
class _$OuterCopyWithImpl<$Res> implements $OuterCopyWith<$Res> {
  _$OuterCopyWithImpl(this._self, this._then);

  final Outer _self;
  final $Res Function(Outer) _then;

  /// Create a copy of Outer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? innerData = freezed,
  }) {
    return _then(_self.copyWith(
      innerData: freezed == innerData
          ? _self.innerData
          : innerData // ignore: cast_nullable_to_non_nullable
              as Inner<int>?,
    ));
  }

  /// Create a copy of Outer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InnerCopyWith<int, $Res>? get innerData {
    if (_self.innerData == null) {
      return null;
    }

    return $InnerCopyWith<int, $Res>(_self.innerData!, (value) {
      return _then(_self.copyWith(innerData: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Outer].
extension OuterPatterns on Outer {
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
    TResult Function(_Outer value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Outer() when $default != null:
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
    TResult Function(_Outer value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Outer():
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
    TResult? Function(_Outer value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Outer() when $default != null:
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
    TResult Function(Inner<int>? innerData)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Outer() when $default != null:
        return $default(_that.innerData);
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
    TResult Function(Inner<int>? innerData) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Outer():
        return $default(_that.innerData);
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
    TResult? Function(Inner<int>? innerData)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Outer() when $default != null:
        return $default(_that.innerData);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Outer implements Outer {
  const _Outer({this.innerData});

  @override
  final Inner<int>? innerData;

  /// Create a copy of Outer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OuterCopyWith<_Outer> get copyWith =>
      __$OuterCopyWithImpl<_Outer>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Outer &&
            (identical(other.innerData, innerData) ||
                other.innerData == innerData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, innerData);

  @override
  String toString() {
    return 'Outer(innerData: $innerData)';
  }
}

/// @nodoc
abstract mixin class _$OuterCopyWith<$Res> implements $OuterCopyWith<$Res> {
  factory _$OuterCopyWith(_Outer value, $Res Function(_Outer) _then) =
      __$OuterCopyWithImpl;
  @override
  @useResult
  $Res call({Inner<int>? innerData});

  @override
  $InnerCopyWith<int, $Res>? get innerData;
}

/// @nodoc
class __$OuterCopyWithImpl<$Res> implements _$OuterCopyWith<$Res> {
  __$OuterCopyWithImpl(this._self, this._then);

  final _Outer _self;
  final $Res Function(_Outer) _then;

  /// Create a copy of Outer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? innerData = freezed,
  }) {
    return _then(_Outer(
      innerData: freezed == innerData
          ? _self.innerData
          : innerData // ignore: cast_nullable_to_non_nullable
              as Inner<int>?,
    ));
  }

  /// Create a copy of Outer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InnerCopyWith<int, $Res>? get innerData {
    if (_self.innerData == null) {
      return null;
    }

    return $InnerCopyWith<int, $Res>(_self.innerData!, (value) {
      return _then(_self.copyWith(innerData: value));
    });
  }
}
