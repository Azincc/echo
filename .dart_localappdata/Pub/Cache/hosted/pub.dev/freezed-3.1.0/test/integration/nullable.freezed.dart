// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nullable.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RequiredPositional {
  int get a;

  /// Create a copy of RequiredPositional
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RequiredPositionalCopyWith<RequiredPositional> get copyWith =>
      _$RequiredPositionalCopyWithImpl<RequiredPositional>(
          this as RequiredPositional, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RequiredPositional &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'RequiredPositional(a: $a)';
  }
}

/// @nodoc
abstract mixin class $RequiredPositionalCopyWith<$Res> {
  factory $RequiredPositionalCopyWith(
          RequiredPositional value, $Res Function(RequiredPositional) _then) =
      _$RequiredPositionalCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$RequiredPositionalCopyWithImpl<$Res>
    implements $RequiredPositionalCopyWith<$Res> {
  _$RequiredPositionalCopyWithImpl(this._self, this._then);

  final RequiredPositional _self;
  final $Res Function(RequiredPositional) _then;

  /// Create a copy of RequiredPositional
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
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [RequiredPositional].
extension RequiredPositionalPatterns on RequiredPositional {
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
    TResult Function(_RequiredPositional value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RequiredPositional() when $default != null:
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
    TResult Function(_RequiredPositional value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequiredPositional():
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
    TResult? Function(_RequiredPositional value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequiredPositional() when $default != null:
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
    TResult Function(int a)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RequiredPositional() when $default != null:
        return $default(_that.a);
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
    TResult Function(int a) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequiredPositional():
        return $default(_that.a);
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
    TResult? Function(int a)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequiredPositional() when $default != null:
        return $default(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _RequiredPositional implements RequiredPositional {
  _RequiredPositional(this.a);

  @override
  final int a;

  /// Create a copy of RequiredPositional
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RequiredPositionalCopyWith<_RequiredPositional> get copyWith =>
      __$RequiredPositionalCopyWithImpl<_RequiredPositional>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RequiredPositional &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'RequiredPositional(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$RequiredPositionalCopyWith<$Res>
    implements $RequiredPositionalCopyWith<$Res> {
  factory _$RequiredPositionalCopyWith(
          _RequiredPositional value, $Res Function(_RequiredPositional) _then) =
      __$RequiredPositionalCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$RequiredPositionalCopyWithImpl<$Res>
    implements _$RequiredPositionalCopyWith<$Res> {
  __$RequiredPositionalCopyWithImpl(this._self, this._then);

  final _RequiredPositional _self;
  final $Res Function(_RequiredPositional) _then;

  /// Create a copy of RequiredPositional
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_RequiredPositional(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$NullableRequiredPositional {
  int? get a;

  /// Create a copy of NullableRequiredPositional
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NullableRequiredPositionalCopyWith<NullableRequiredPositional>
      get copyWith =>
          _$NullableRequiredPositionalCopyWithImpl<NullableRequiredPositional>(
              this as NullableRequiredPositional, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NullableRequiredPositional &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'NullableRequiredPositional(a: $a)';
  }
}

/// @nodoc
abstract mixin class $NullableRequiredPositionalCopyWith<$Res> {
  factory $NullableRequiredPositionalCopyWith(NullableRequiredPositional value,
          $Res Function(NullableRequiredPositional) _then) =
      _$NullableRequiredPositionalCopyWithImpl;
  @useResult
  $Res call({int? a});
}

/// @nodoc
class _$NullableRequiredPositionalCopyWithImpl<$Res>
    implements $NullableRequiredPositionalCopyWith<$Res> {
  _$NullableRequiredPositionalCopyWithImpl(this._self, this._then);

  final NullableRequiredPositional _self;
  final $Res Function(NullableRequiredPositional) _then;

  /// Create a copy of NullableRequiredPositional
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? a = freezed,
  }) {
    return _then(_self.copyWith(
      a: freezed == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [NullableRequiredPositional].
extension NullableRequiredPositionalPatterns on NullableRequiredPositional {
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
    TResult Function(_NullableRequiredPositional value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NullableRequiredPositional() when $default != null:
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
    TResult Function(_NullableRequiredPositional value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NullableRequiredPositional():
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
    TResult? Function(_NullableRequiredPositional value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NullableRequiredPositional() when $default != null:
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
    TResult Function(int? a)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NullableRequiredPositional() when $default != null:
        return $default(_that.a);
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
    TResult Function(int? a) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NullableRequiredPositional():
        return $default(_that.a);
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
    TResult? Function(int? a)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NullableRequiredPositional() when $default != null:
        return $default(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _NullableRequiredPositional implements NullableRequiredPositional {
  _NullableRequiredPositional(this.a);

  @override
  final int? a;

  /// Create a copy of NullableRequiredPositional
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NullableRequiredPositionalCopyWith<_NullableRequiredPositional>
      get copyWith => __$NullableRequiredPositionalCopyWithImpl<
          _NullableRequiredPositional>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NullableRequiredPositional &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'NullableRequiredPositional(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$NullableRequiredPositionalCopyWith<$Res>
    implements $NullableRequiredPositionalCopyWith<$Res> {
  factory _$NullableRequiredPositionalCopyWith(
          _NullableRequiredPositional value,
          $Res Function(_NullableRequiredPositional) _then) =
      __$NullableRequiredPositionalCopyWithImpl;
  @override
  @useResult
  $Res call({int? a});
}

/// @nodoc
class __$NullableRequiredPositionalCopyWithImpl<$Res>
    implements _$NullableRequiredPositionalCopyWith<$Res> {
  __$NullableRequiredPositionalCopyWithImpl(this._self, this._then);

  final _NullableRequiredPositional _self;
  final $Res Function(_NullableRequiredPositional) _then;

  /// Create a copy of NullableRequiredPositional
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = freezed,
  }) {
    return _then(_NullableRequiredPositional(
      freezed == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
mixin _$Positional {
  int? get a;

  /// Create a copy of Positional
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PositionalCopyWith<Positional> get copyWith =>
      _$PositionalCopyWithImpl<Positional>(this as Positional, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Positional &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'Positional(a: $a)';
  }
}

/// @nodoc
abstract mixin class $PositionalCopyWith<$Res> {
  factory $PositionalCopyWith(
          Positional value, $Res Function(Positional) _then) =
      _$PositionalCopyWithImpl;
  @useResult
  $Res call({int? a});
}

/// @nodoc
class _$PositionalCopyWithImpl<$Res> implements $PositionalCopyWith<$Res> {
  _$PositionalCopyWithImpl(this._self, this._then);

  final Positional _self;
  final $Res Function(Positional) _then;

  /// Create a copy of Positional
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? a = freezed,
  }) {
    return _then(_self.copyWith(
      a: freezed == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Positional].
extension PositionalPatterns on Positional {
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
    TResult Function(_Positional value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Positional() when $default != null:
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
    TResult Function(_Positional value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Positional():
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
    TResult? Function(_Positional value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Positional() when $default != null:
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
    TResult Function(int? a)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Positional() when $default != null:
        return $default(_that.a);
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
    TResult Function(int? a) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Positional():
        return $default(_that.a);
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
    TResult? Function(int? a)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Positional() when $default != null:
        return $default(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Positional implements Positional {
  _Positional([this.a]);

  @override
  final int? a;

  /// Create a copy of Positional
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PositionalCopyWith<_Positional> get copyWith =>
      __$PositionalCopyWithImpl<_Positional>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Positional &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'Positional(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$PositionalCopyWith<$Res>
    implements $PositionalCopyWith<$Res> {
  factory _$PositionalCopyWith(
          _Positional value, $Res Function(_Positional) _then) =
      __$PositionalCopyWithImpl;
  @override
  @useResult
  $Res call({int? a});
}

/// @nodoc
class __$PositionalCopyWithImpl<$Res> implements _$PositionalCopyWith<$Res> {
  __$PositionalCopyWithImpl(this._self, this._then);

  final _Positional _self;
  final $Res Function(_Positional) _then;

  /// Create a copy of Positional
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = freezed,
  }) {
    return _then(_Positional(
      freezed == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
mixin _$DefaultPositional {
  int get a;

  /// Create a copy of DefaultPositional
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DefaultPositionalCopyWith<DefaultPositional> get copyWith =>
      _$DefaultPositionalCopyWithImpl<DefaultPositional>(
          this as DefaultPositional, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DefaultPositional &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'DefaultPositional(a: $a)';
  }
}

/// @nodoc
abstract mixin class $DefaultPositionalCopyWith<$Res> {
  factory $DefaultPositionalCopyWith(
          DefaultPositional value, $Res Function(DefaultPositional) _then) =
      _$DefaultPositionalCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$DefaultPositionalCopyWithImpl<$Res>
    implements $DefaultPositionalCopyWith<$Res> {
  _$DefaultPositionalCopyWithImpl(this._self, this._then);

  final DefaultPositional _self;
  final $Res Function(DefaultPositional) _then;

  /// Create a copy of DefaultPositional
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
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [DefaultPositional].
extension DefaultPositionalPatterns on DefaultPositional {
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
    TResult Function(_DefaultPositional value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DefaultPositional() when $default != null:
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
    TResult Function(_DefaultPositional value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DefaultPositional():
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
    TResult? Function(_DefaultPositional value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DefaultPositional() when $default != null:
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
    TResult Function(int a)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DefaultPositional() when $default != null:
        return $default(_that.a);
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
    TResult Function(int a) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DefaultPositional():
        return $default(_that.a);
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
    TResult? Function(int a)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DefaultPositional() when $default != null:
        return $default(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DefaultPositional implements DefaultPositional {
  _DefaultPositional([this.a = 0]);

  @override
  @JsonKey()
  final int a;

  /// Create a copy of DefaultPositional
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DefaultPositionalCopyWith<_DefaultPositional> get copyWith =>
      __$DefaultPositionalCopyWithImpl<_DefaultPositional>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DefaultPositional &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'DefaultPositional(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$DefaultPositionalCopyWith<$Res>
    implements $DefaultPositionalCopyWith<$Res> {
  factory _$DefaultPositionalCopyWith(
          _DefaultPositional value, $Res Function(_DefaultPositional) _then) =
      __$DefaultPositionalCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$DefaultPositionalCopyWithImpl<$Res>
    implements _$DefaultPositionalCopyWith<$Res> {
  __$DefaultPositionalCopyWithImpl(this._self, this._then);

  final _DefaultPositional _self;
  final $Res Function(_DefaultPositional) _then;

  /// Create a copy of DefaultPositional
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_DefaultPositional(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$Named {
  int? get a;

  /// Create a copy of Named
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NamedCopyWith<Named> get copyWith =>
      _$NamedCopyWithImpl<Named>(this as Named, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Named &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'Named(a: $a)';
  }
}

/// @nodoc
abstract mixin class $NamedCopyWith<$Res> {
  factory $NamedCopyWith(Named value, $Res Function(Named) _then) =
      _$NamedCopyWithImpl;
  @useResult
  $Res call({int? a});
}

/// @nodoc
class _$NamedCopyWithImpl<$Res> implements $NamedCopyWith<$Res> {
  _$NamedCopyWithImpl(this._self, this._then);

  final Named _self;
  final $Res Function(Named) _then;

  /// Create a copy of Named
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? a = freezed,
  }) {
    return _then(_self.copyWith(
      a: freezed == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Named].
extension NamedPatterns on Named {
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
    TResult Function(_Named value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Named() when $default != null:
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
    TResult Function(_Named value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Named():
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
    TResult? Function(_Named value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Named() when $default != null:
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
    TResult Function(int? a)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Named() when $default != null:
        return $default(_that.a);
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
    TResult Function(int? a) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Named():
        return $default(_that.a);
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
    TResult? Function(int? a)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Named() when $default != null:
        return $default(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Named implements Named {
  _Named({this.a});

  @override
  final int? a;

  /// Create a copy of Named
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NamedCopyWith<_Named> get copyWith =>
      __$NamedCopyWithImpl<_Named>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Named &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'Named(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$NamedCopyWith<$Res> implements $NamedCopyWith<$Res> {
  factory _$NamedCopyWith(_Named value, $Res Function(_Named) _then) =
      __$NamedCopyWithImpl;
  @override
  @useResult
  $Res call({int? a});
}

/// @nodoc
class __$NamedCopyWithImpl<$Res> implements _$NamedCopyWith<$Res> {
  __$NamedCopyWithImpl(this._self, this._then);

  final _Named _self;
  final $Res Function(_Named) _then;

  /// Create a copy of Named
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = freezed,
  }) {
    return _then(_Named(
      a: freezed == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
mixin _$DefaultNamed {
  int get a;

  /// Create a copy of DefaultNamed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DefaultNamedCopyWith<DefaultNamed> get copyWith =>
      _$DefaultNamedCopyWithImpl<DefaultNamed>(
          this as DefaultNamed, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DefaultNamed &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'DefaultNamed(a: $a)';
  }
}

/// @nodoc
abstract mixin class $DefaultNamedCopyWith<$Res> {
  factory $DefaultNamedCopyWith(
          DefaultNamed value, $Res Function(DefaultNamed) _then) =
      _$DefaultNamedCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$DefaultNamedCopyWithImpl<$Res> implements $DefaultNamedCopyWith<$Res> {
  _$DefaultNamedCopyWithImpl(this._self, this._then);

  final DefaultNamed _self;
  final $Res Function(DefaultNamed) _then;

  /// Create a copy of DefaultNamed
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
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [DefaultNamed].
extension DefaultNamedPatterns on DefaultNamed {
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
    TResult Function(_DefaultNamed value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DefaultNamed() when $default != null:
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
    TResult Function(_DefaultNamed value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DefaultNamed():
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
    TResult? Function(_DefaultNamed value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DefaultNamed() when $default != null:
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
    TResult Function(int a)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DefaultNamed() when $default != null:
        return $default(_that.a);
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
    TResult Function(int a) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DefaultNamed():
        return $default(_that.a);
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
    TResult? Function(int a)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DefaultNamed() when $default != null:
        return $default(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DefaultNamed implements DefaultNamed {
  _DefaultNamed({this.a = 0});

  @override
  @JsonKey()
  final int a;

  /// Create a copy of DefaultNamed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DefaultNamedCopyWith<_DefaultNamed> get copyWith =>
      __$DefaultNamedCopyWithImpl<_DefaultNamed>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DefaultNamed &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'DefaultNamed(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$DefaultNamedCopyWith<$Res>
    implements $DefaultNamedCopyWith<$Res> {
  factory _$DefaultNamedCopyWith(
          _DefaultNamed value, $Res Function(_DefaultNamed) _then) =
      __$DefaultNamedCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$DefaultNamedCopyWithImpl<$Res>
    implements _$DefaultNamedCopyWith<$Res> {
  __$DefaultNamedCopyWithImpl(this._self, this._then);

  final _DefaultNamed _self;
  final $Res Function(_DefaultNamed) _then;

  /// Create a copy of DefaultNamed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_DefaultNamed(
      a: null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$RequiredNamed {
  int get a;

  /// Create a copy of RequiredNamed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RequiredNamedCopyWith<RequiredNamed> get copyWith =>
      _$RequiredNamedCopyWithImpl<RequiredNamed>(
          this as RequiredNamed, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RequiredNamed &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'RequiredNamed(a: $a)';
  }
}

/// @nodoc
abstract mixin class $RequiredNamedCopyWith<$Res> {
  factory $RequiredNamedCopyWith(
          RequiredNamed value, $Res Function(RequiredNamed) _then) =
      _$RequiredNamedCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$RequiredNamedCopyWithImpl<$Res>
    implements $RequiredNamedCopyWith<$Res> {
  _$RequiredNamedCopyWithImpl(this._self, this._then);

  final RequiredNamed _self;
  final $Res Function(RequiredNamed) _then;

  /// Create a copy of RequiredNamed
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
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [RequiredNamed].
extension RequiredNamedPatterns on RequiredNamed {
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
    TResult Function(_RequiredNamed value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RequiredNamed() when $default != null:
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
    TResult Function(_RequiredNamed value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequiredNamed():
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
    TResult? Function(_RequiredNamed value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequiredNamed() when $default != null:
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
    TResult Function(int a)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RequiredNamed() when $default != null:
        return $default(_that.a);
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
    TResult Function(int a) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequiredNamed():
        return $default(_that.a);
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
    TResult? Function(int a)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RequiredNamed() when $default != null:
        return $default(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _RequiredNamed implements RequiredNamed {
  _RequiredNamed({required this.a});

  @override
  final int a;

  /// Create a copy of RequiredNamed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RequiredNamedCopyWith<_RequiredNamed> get copyWith =>
      __$RequiredNamedCopyWithImpl<_RequiredNamed>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RequiredNamed &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'RequiredNamed(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$RequiredNamedCopyWith<$Res>
    implements $RequiredNamedCopyWith<$Res> {
  factory _$RequiredNamedCopyWith(
          _RequiredNamed value, $Res Function(_RequiredNamed) _then) =
      __$RequiredNamedCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$RequiredNamedCopyWithImpl<$Res>
    implements _$RequiredNamedCopyWith<$Res> {
  __$RequiredNamedCopyWithImpl(this._self, this._then);

  final _RequiredNamed _self;
  final $Res Function(_RequiredNamed) _then;

  /// Create a copy of RequiredNamed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_RequiredNamed(
      a: null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$NullableRequiredNamed {
  int? get a;

  /// Create a copy of NullableRequiredNamed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NullableRequiredNamedCopyWith<NullableRequiredNamed> get copyWith =>
      _$NullableRequiredNamedCopyWithImpl<NullableRequiredNamed>(
          this as NullableRequiredNamed, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NullableRequiredNamed &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'NullableRequiredNamed(a: $a)';
  }
}

/// @nodoc
abstract mixin class $NullableRequiredNamedCopyWith<$Res> {
  factory $NullableRequiredNamedCopyWith(NullableRequiredNamed value,
          $Res Function(NullableRequiredNamed) _then) =
      _$NullableRequiredNamedCopyWithImpl;
  @useResult
  $Res call({int? a});
}

/// @nodoc
class _$NullableRequiredNamedCopyWithImpl<$Res>
    implements $NullableRequiredNamedCopyWith<$Res> {
  _$NullableRequiredNamedCopyWithImpl(this._self, this._then);

  final NullableRequiredNamed _self;
  final $Res Function(NullableRequiredNamed) _then;

  /// Create a copy of NullableRequiredNamed
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? a = freezed,
  }) {
    return _then(_self.copyWith(
      a: freezed == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [NullableRequiredNamed].
extension NullableRequiredNamedPatterns on NullableRequiredNamed {
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
    TResult Function(_NullableRequiredNamed value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NullableRequiredNamed() when $default != null:
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
    TResult Function(_NullableRequiredNamed value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NullableRequiredNamed():
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
    TResult? Function(_NullableRequiredNamed value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NullableRequiredNamed() when $default != null:
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
    TResult Function(int? a)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NullableRequiredNamed() when $default != null:
        return $default(_that.a);
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
    TResult Function(int? a) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NullableRequiredNamed():
        return $default(_that.a);
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
    TResult? Function(int? a)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NullableRequiredNamed() when $default != null:
        return $default(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _NullableRequiredNamed implements NullableRequiredNamed {
  _NullableRequiredNamed({required this.a});

  @override
  final int? a;

  /// Create a copy of NullableRequiredNamed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NullableRequiredNamedCopyWith<_NullableRequiredNamed> get copyWith =>
      __$NullableRequiredNamedCopyWithImpl<_NullableRequiredNamed>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NullableRequiredNamed &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'NullableRequiredNamed(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$NullableRequiredNamedCopyWith<$Res>
    implements $NullableRequiredNamedCopyWith<$Res> {
  factory _$NullableRequiredNamedCopyWith(_NullableRequiredNamed value,
          $Res Function(_NullableRequiredNamed) _then) =
      __$NullableRequiredNamedCopyWithImpl;
  @override
  @useResult
  $Res call({int? a});
}

/// @nodoc
class __$NullableRequiredNamedCopyWithImpl<$Res>
    implements _$NullableRequiredNamedCopyWith<$Res> {
  __$NullableRequiredNamedCopyWithImpl(this._self, this._then);

  final _NullableRequiredNamed _self;
  final $Res Function(_NullableRequiredNamed) _then;

  /// Create a copy of NullableRequiredNamed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = freezed,
  }) {
    return _then(_NullableRequiredNamed(
      a: freezed == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}
