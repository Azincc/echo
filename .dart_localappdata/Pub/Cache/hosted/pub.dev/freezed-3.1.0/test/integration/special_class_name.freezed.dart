// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'special_class_name.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Class$With$Special$Name {
  String? get a;
  int? get b;

  /// Create a copy of Class$With$Special$Name
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Class$With$Special$NameCopyWith<Class$With$Special$Name> get copyWith =>
      _$Class$With$Special$NameCopyWithImpl<Class$With$Special$Name>(
          this as Class$With$Special$Name, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Class$With$Special$Name &&
            (identical(other.a, a) || other.a == a) &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a, b);

  @override
  String toString() {
    return 'Class\$With\$Special\$Name(a: $a, b: $b)';
  }
}

/// @nodoc
abstract mixin class $Class$With$Special$NameCopyWith<$Res> {
  factory $Class$With$Special$NameCopyWith(Class$With$Special$Name value,
          $Res Function(Class$With$Special$Name) _then) =
      _$Class$With$Special$NameCopyWithImpl;
  @useResult
  $Res call({String? a, int? b});
}

/// @nodoc
class _$Class$With$Special$NameCopyWithImpl<$Res>
    implements $Class$With$Special$NameCopyWith<$Res> {
  _$Class$With$Special$NameCopyWithImpl(this._self, this._then);

  final Class$With$Special$Name _self;
  final $Res Function(Class$With$Special$Name) _then;

  /// Create a copy of Class$With$Special$Name
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? a = freezed,
    Object? b = freezed,
  }) {
    return _then(_self.copyWith(
      a: freezed == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String?,
      b: freezed == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Class$With$Special$Name].
extension Class$With$Special$NamePatterns on Class$With$Special$Name {
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
    TResult Function(_Class$With$Special$Name value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Class$With$Special$Name() when $default != null:
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
    TResult Function(_Class$With$Special$Name value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Class$With$Special$Name():
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
    TResult? Function(_Class$With$Special$Name value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Class$With$Special$Name() when $default != null:
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
    TResult Function(String? a, int? b)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Class$With$Special$Name() when $default != null:
        return $default(_that.a, _that.b);
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
    TResult Function(String? a, int? b) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Class$With$Special$Name():
        return $default(_that.a, _that.b);
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
    TResult? Function(String? a, int? b)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Class$With$Special$Name() when $default != null:
        return $default(_that.a, _that.b);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Class$With$Special$Name implements Class$With$Special$Name {
  _Class$With$Special$Name({this.a, this.b});

  @override
  final String? a;
  @override
  final int? b;

  /// Create a copy of Class$With$Special$Name
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$Class$With$Special$NameCopyWith<_Class$With$Special$Name> get copyWith =>
      __$Class$With$Special$NameCopyWithImpl<_Class$With$Special$Name>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Class$With$Special$Name &&
            (identical(other.a, a) || other.a == a) &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a, b);

  @override
  String toString() {
    return 'Class\$With\$Special\$Name(a: $a, b: $b)';
  }
}

/// @nodoc
abstract mixin class _$Class$With$Special$NameCopyWith<$Res>
    implements $Class$With$Special$NameCopyWith<$Res> {
  factory _$Class$With$Special$NameCopyWith(_Class$With$Special$Name value,
          $Res Function(_Class$With$Special$Name) _then) =
      __$Class$With$Special$NameCopyWithImpl;
  @override
  @useResult
  $Res call({String? a, int? b});
}

/// @nodoc
class __$Class$With$Special$NameCopyWithImpl<$Res>
    implements _$Class$With$Special$NameCopyWith<$Res> {
  __$Class$With$Special$NameCopyWithImpl(this._self, this._then);

  final _Class$With$Special$Name _self;
  final $Res Function(_Class$With$Special$Name) _then;

  /// Create a copy of Class$With$Special$Name
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = freezed,
    Object? b = freezed,
  }) {
    return _then(_Class$With$Special$Name(
      a: freezed == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String?,
      b: freezed == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}
