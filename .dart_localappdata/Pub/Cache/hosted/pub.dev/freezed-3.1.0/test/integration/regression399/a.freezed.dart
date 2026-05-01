// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'a.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Regression399A {
  Regression399B? get b;

  /// Create a copy of Regression399A
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Regression399ACopyWith<Regression399A> get copyWith =>
      _$Regression399ACopyWithImpl<Regression399A>(
          this as Regression399A, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Regression399A &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, b);

  @override
  String toString() {
    return 'Regression399A(b: $b)';
  }
}

/// @nodoc
abstract mixin class $Regression399ACopyWith<$Res> {
  factory $Regression399ACopyWith(
          Regression399A value, $Res Function(Regression399A) _then) =
      _$Regression399ACopyWithImpl;
  @useResult
  $Res call({Regression399B? b});

  $Regression399BCopyWith<$Res>? get b;
}

/// @nodoc
class _$Regression399ACopyWithImpl<$Res>
    implements $Regression399ACopyWith<$Res> {
  _$Regression399ACopyWithImpl(this._self, this._then);

  final Regression399A _self;
  final $Res Function(Regression399A) _then;

  /// Create a copy of Regression399A
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? b = freezed,
  }) {
    return _then(_self.copyWith(
      b: freezed == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as Regression399B?,
    ));
  }

  /// Create a copy of Regression399A
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Regression399BCopyWith<$Res>? get b {
    if (_self.b == null) {
      return null;
    }

    return $Regression399BCopyWith<$Res>(_self.b!, (value) {
      return _then(_self.copyWith(b: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Regression399A].
extension Regression399APatterns on Regression399A {
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
    TResult Function(_Regression399A value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Regression399A() when $default != null:
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
    TResult Function(_Regression399A value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression399A():
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
    TResult? Function(_Regression399A value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression399A() when $default != null:
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
    TResult Function(Regression399B? b)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Regression399A() when $default != null:
        return $default(_that.b);
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
    TResult Function(Regression399B? b) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression399A():
        return $default(_that.b);
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
    TResult? Function(Regression399B? b)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression399A() when $default != null:
        return $default(_that.b);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Regression399A implements Regression399A {
  const _Regression399A({required this.b});

  @override
  final Regression399B? b;

  /// Create a copy of Regression399A
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$Regression399ACopyWith<_Regression399A> get copyWith =>
      __$Regression399ACopyWithImpl<_Regression399A>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Regression399A &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, b);

  @override
  String toString() {
    return 'Regression399A(b: $b)';
  }
}

/// @nodoc
abstract mixin class _$Regression399ACopyWith<$Res>
    implements $Regression399ACopyWith<$Res> {
  factory _$Regression399ACopyWith(
          _Regression399A value, $Res Function(_Regression399A) _then) =
      __$Regression399ACopyWithImpl;
  @override
  @useResult
  $Res call({Regression399B? b});

  @override
  $Regression399BCopyWith<$Res>? get b;
}

/// @nodoc
class __$Regression399ACopyWithImpl<$Res>
    implements _$Regression399ACopyWith<$Res> {
  __$Regression399ACopyWithImpl(this._self, this._then);

  final _Regression399A _self;
  final $Res Function(_Regression399A) _then;

  /// Create a copy of Regression399A
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? b = freezed,
  }) {
    return _then(_Regression399A(
      b: freezed == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as Regression399B?,
    ));
  }

  /// Create a copy of Regression399A
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Regression399BCopyWith<$Res>? get b {
    if (_self.b == null) {
      return null;
    }

    return $Regression399BCopyWith<$Res>(_self.b!, (value) {
      return _then(_self.copyWith(b: value));
    });
  }
}

/// @nodoc
mixin _$GenericRegression399A<T> {
  GenericRegression399B<T>? get b;

  /// Create a copy of GenericRegression399A
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GenericRegression399ACopyWith<T, GenericRegression399A<T>> get copyWith =>
      _$GenericRegression399ACopyWithImpl<T, GenericRegression399A<T>>(
          this as GenericRegression399A<T>, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GenericRegression399A<T> &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, b);

  @override
  String toString() {
    return 'GenericRegression399A<$T>(b: $b)';
  }
}

/// @nodoc
abstract mixin class $GenericRegression399ACopyWith<T, $Res> {
  factory $GenericRegression399ACopyWith(GenericRegression399A<T> value,
          $Res Function(GenericRegression399A<T>) _then) =
      _$GenericRegression399ACopyWithImpl;
  @useResult
  $Res call({GenericRegression399B<T>? b});

  $GenericRegression399BCopyWith<T, $Res>? get b;
}

/// @nodoc
class _$GenericRegression399ACopyWithImpl<T, $Res>
    implements $GenericRegression399ACopyWith<T, $Res> {
  _$GenericRegression399ACopyWithImpl(this._self, this._then);

  final GenericRegression399A<T> _self;
  final $Res Function(GenericRegression399A<T>) _then;

  /// Create a copy of GenericRegression399A
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? b = freezed,
  }) {
    return _then(_self.copyWith(
      b: freezed == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as GenericRegression399B<T>?,
    ));
  }

  /// Create a copy of GenericRegression399A
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GenericRegression399BCopyWith<T, $Res>? get b {
    if (_self.b == null) {
      return null;
    }

    return $GenericRegression399BCopyWith<T, $Res>(_self.b!, (value) {
      return _then(_self.copyWith(b: value));
    });
  }
}

/// Adds pattern-matching-related methods to [GenericRegression399A].
extension GenericRegression399APatterns<T> on GenericRegression399A<T> {
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
    TResult Function(_GenericRegression399A<T> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GenericRegression399A() when $default != null:
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
    TResult Function(_GenericRegression399A<T> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenericRegression399A():
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
    TResult? Function(_GenericRegression399A<T> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenericRegression399A() when $default != null:
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
    TResult Function(GenericRegression399B<T>? b)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GenericRegression399A() when $default != null:
        return $default(_that.b);
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
    TResult Function(GenericRegression399B<T>? b) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenericRegression399A():
        return $default(_that.b);
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
    TResult? Function(GenericRegression399B<T>? b)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenericRegression399A() when $default != null:
        return $default(_that.b);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GenericRegression399A<T> implements GenericRegression399A<T> {
  const _GenericRegression399A({required this.b});

  @override
  final GenericRegression399B<T>? b;

  /// Create a copy of GenericRegression399A
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GenericRegression399ACopyWith<T, _GenericRegression399A<T>> get copyWith =>
      __$GenericRegression399ACopyWithImpl<T, _GenericRegression399A<T>>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GenericRegression399A<T> &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, b);

  @override
  String toString() {
    return 'GenericRegression399A<$T>(b: $b)';
  }
}

/// @nodoc
abstract mixin class _$GenericRegression399ACopyWith<T, $Res>
    implements $GenericRegression399ACopyWith<T, $Res> {
  factory _$GenericRegression399ACopyWith(_GenericRegression399A<T> value,
          $Res Function(_GenericRegression399A<T>) _then) =
      __$GenericRegression399ACopyWithImpl;
  @override
  @useResult
  $Res call({GenericRegression399B<T>? b});

  @override
  $GenericRegression399BCopyWith<T, $Res>? get b;
}

/// @nodoc
class __$GenericRegression399ACopyWithImpl<T, $Res>
    implements _$GenericRegression399ACopyWith<T, $Res> {
  __$GenericRegression399ACopyWithImpl(this._self, this._then);

  final _GenericRegression399A<T> _self;
  final $Res Function(_GenericRegression399A<T>) _then;

  /// Create a copy of GenericRegression399A
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? b = freezed,
  }) {
    return _then(_GenericRegression399A<T>(
      b: freezed == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as GenericRegression399B<T>?,
    ));
  }

  /// Create a copy of GenericRegression399A
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GenericRegression399BCopyWith<T, $Res>? get b {
    if (_self.b == null) {
      return null;
    }

    return $GenericRegression399BCopyWith<T, $Res>(_self.b!, (value) {
      return _then(_self.copyWith(b: value));
    });
  }
}
