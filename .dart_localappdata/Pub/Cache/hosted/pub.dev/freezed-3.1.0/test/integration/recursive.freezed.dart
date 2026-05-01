// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recursive.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$A {
  B? get parent;

  /// Create a copy of A
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ACopyWith<A> get copyWith => _$ACopyWithImpl<A>(this as A, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is A &&
            (identical(other.parent, parent) || other.parent == parent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, parent);

  @override
  String toString() {
    return 'A(parent: $parent)';
  }
}

/// @nodoc
abstract mixin class $ACopyWith<$Res> {
  factory $ACopyWith(A value, $Res Function(A) _then) = _$ACopyWithImpl;
  @useResult
  $Res call({B? parent});

  $BCopyWith<$Res>? get parent;
}

/// @nodoc
class _$ACopyWithImpl<$Res> implements $ACopyWith<$Res> {
  _$ACopyWithImpl(this._self, this._then);

  final A _self;
  final $Res Function(A) _then;

  /// Create a copy of A
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parent = freezed,
  }) {
    return _then(_self.copyWith(
      parent: freezed == parent
          ? _self.parent
          : parent // ignore: cast_nullable_to_non_nullable
              as B?,
    ));
  }

  /// Create a copy of A
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BCopyWith<$Res>? get parent {
    if (_self.parent == null) {
      return null;
    }

    return $BCopyWith<$Res>(_self.parent!, (value) {
      return _then(_self.copyWith(parent: value));
    });
  }
}

/// Adds pattern-matching-related methods to [A].
extension APatterns on A {
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
    TResult Function(_A value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _A() when $default != null:
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
    TResult Function(_A value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _A():
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
    TResult? Function(_A value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _A() when $default != null:
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
    TResult Function(B? parent)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _A() when $default != null:
        return $default(_that.parent);
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
    TResult Function(B? parent) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _A():
        return $default(_that.parent);
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
    TResult? Function(B? parent)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _A() when $default != null:
        return $default(_that.parent);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _A implements A {
  _A({this.parent});

  @override
  final B? parent;

  /// Create a copy of A
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ACopyWith<_A> get copyWith => __$ACopyWithImpl<_A>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _A &&
            (identical(other.parent, parent) || other.parent == parent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, parent);

  @override
  String toString() {
    return 'A(parent: $parent)';
  }
}

/// @nodoc
abstract mixin class _$ACopyWith<$Res> implements $ACopyWith<$Res> {
  factory _$ACopyWith(_A value, $Res Function(_A) _then) = __$ACopyWithImpl;
  @override
  @useResult
  $Res call({B? parent});

  @override
  $BCopyWith<$Res>? get parent;
}

/// @nodoc
class __$ACopyWithImpl<$Res> implements _$ACopyWith<$Res> {
  __$ACopyWithImpl(this._self, this._then);

  final _A _self;
  final $Res Function(_A) _then;

  /// Create a copy of A
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? parent = freezed,
  }) {
    return _then(_A(
      parent: freezed == parent
          ? _self.parent
          : parent // ignore: cast_nullable_to_non_nullable
              as B?,
    ));
  }

  /// Create a copy of A
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BCopyWith<$Res>? get parent {
    if (_self.parent == null) {
      return null;
    }

    return $BCopyWith<$Res>(_self.parent!, (value) {
      return _then(_self.copyWith(parent: value));
    });
  }
}
