// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recursive2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$B {
  A? get parent;

  /// Create a copy of B
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BCopyWith<B> get copyWith => _$BCopyWithImpl<B>(this as B, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is B &&
            (identical(other.parent, parent) || other.parent == parent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, parent);

  @override
  String toString() {
    return 'B(parent: $parent)';
  }
}

/// @nodoc
abstract mixin class $BCopyWith<$Res> {
  factory $BCopyWith(B value, $Res Function(B) _then) = _$BCopyWithImpl;
  @useResult
  $Res call({A? parent});

  $ACopyWith<$Res>? get parent;
}

/// @nodoc
class _$BCopyWithImpl<$Res> implements $BCopyWith<$Res> {
  _$BCopyWithImpl(this._self, this._then);

  final B _self;
  final $Res Function(B) _then;

  /// Create a copy of B
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
              as A?,
    ));
  }

  /// Create a copy of B
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ACopyWith<$Res>? get parent {
    if (_self.parent == null) {
      return null;
    }

    return $ACopyWith<$Res>(_self.parent!, (value) {
      return _then(_self.copyWith(parent: value));
    });
  }
}

/// Adds pattern-matching-related methods to [B].
extension BPatterns on B {
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
    TResult Function(_B value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _B() when $default != null:
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
    TResult Function(_B value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _B():
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
    TResult? Function(_B value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _B() when $default != null:
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
    TResult Function(A? parent)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _B() when $default != null:
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
    TResult Function(A? parent) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _B():
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
    TResult? Function(A? parent)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _B() when $default != null:
        return $default(_that.parent);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _B implements B {
  _B({this.parent});

  @override
  final A? parent;

  /// Create a copy of B
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BCopyWith<_B> get copyWith => __$BCopyWithImpl<_B>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _B &&
            (identical(other.parent, parent) || other.parent == parent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, parent);

  @override
  String toString() {
    return 'B(parent: $parent)';
  }
}

/// @nodoc
abstract mixin class _$BCopyWith<$Res> implements $BCopyWith<$Res> {
  factory _$BCopyWith(_B value, $Res Function(_B) _then) = __$BCopyWithImpl;
  @override
  @useResult
  $Res call({A? parent});

  @override
  $ACopyWith<$Res>? get parent;
}

/// @nodoc
class __$BCopyWithImpl<$Res> implements _$BCopyWith<$Res> {
  __$BCopyWithImpl(this._self, this._then);

  final _B _self;
  final $Res Function(_B) _then;

  /// Create a copy of B
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? parent = freezed,
  }) {
    return _then(_B(
      parent: freezed == parent
          ? _self.parent
          : parent // ignore: cast_nullable_to_non_nullable
              as A?,
    ));
  }

  /// Create a copy of B
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ACopyWith<$Res>? get parent {
    if (_self.parent == null) {
      return null;
    }

    return $ACopyWith<$Res>(_self.parent!, (value) {
      return _then(_self.copyWith(parent: value));
    });
  }
}
