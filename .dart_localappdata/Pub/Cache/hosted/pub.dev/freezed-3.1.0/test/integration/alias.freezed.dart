// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alias.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Alias {
  concrete.Empty get value;
  int? get a;
  Model<int>? get b;

  /// Create a copy of Alias
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AliasCopyWith<Alias> get copyWith =>
      _$AliasCopyWithImpl<Alias>(this as Alias, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Alias &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.a, a) || other.a == a) &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value, a, b);

  @override
  String toString() {
    return 'Alias(value: $value, a: $a, b: $b)';
  }
}

/// @nodoc
abstract mixin class $AliasCopyWith<$Res> {
  factory $AliasCopyWith(Alias value, $Res Function(Alias) _then) =
      _$AliasCopyWithImpl;
  @useResult
  $Res call({concrete.Empty value, int? a, Model<int>? b});
}

/// @nodoc
class _$AliasCopyWithImpl<$Res> implements $AliasCopyWith<$Res> {
  _$AliasCopyWithImpl(this._self, this._then);

  final Alias _self;
  final $Res Function(Alias) _then;

  /// Create a copy of Alias
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? a = freezed,
    Object? b = freezed,
  }) {
    return _then(_self.copyWith(
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as concrete.Empty,
      a: freezed == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int?,
      b: freezed == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as Model<int>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Alias].
extension AliasPatterns on Alias {
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
    TResult Function(_Alias value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Alias() when $default != null:
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
    TResult Function(_Alias value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Alias():
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
    TResult? Function(_Alias value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Alias() when $default != null:
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
    TResult Function(concrete.Empty value, int? a, Model<int>? b)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Alias() when $default != null:
        return $default(_that.value, _that.a, _that.b);
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
    TResult Function(concrete.Empty value, int? a, Model<int>? b) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Alias():
        return $default(_that.value, _that.a, _that.b);
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
    TResult? Function(concrete.Empty value, int? a, Model<int>? b)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Alias() when $default != null:
        return $default(_that.value, _that.a, _that.b);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Alias with concrete.Mixin implements Alias, concrete.Empty {
  _Alias([this.value = const concrete.Empty(), this.a, this.b]);

  @override
  @JsonKey()
  final concrete.Empty value;
  @override
  final int? a;
  @override
  final Model<int>? b;

  /// Create a copy of Alias
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AliasCopyWith<_Alias> get copyWith =>
      __$AliasCopyWithImpl<_Alias>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Alias &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.a, a) || other.a == a) &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value, a, b);

  @override
  String toString() {
    return 'Alias(value: $value, a: $a, b: $b)';
  }
}

/// @nodoc
abstract mixin class _$AliasCopyWith<$Res> implements $AliasCopyWith<$Res> {
  factory _$AliasCopyWith(_Alias value, $Res Function(_Alias) _then) =
      __$AliasCopyWithImpl;
  @override
  @useResult
  $Res call({concrete.Empty value, int? a, Model<int>? b});
}

/// @nodoc
class __$AliasCopyWithImpl<$Res> implements _$AliasCopyWith<$Res> {
  __$AliasCopyWithImpl(this._self, this._then);

  final _Alias _self;
  final $Res Function(_Alias) _then;

  /// Create a copy of Alias
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
    Object? a = freezed,
    Object? b = freezed,
  }) {
    return _then(_Alias(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as concrete.Empty,
      freezed == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as Model<int>?,
    ));
  }
}
