// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'decorator.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Decorator {
  @deprecated
  @_WeirdDecorator('a', b: 0.42)
  String? get a;

  /// Create a copy of Decorator
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DecoratorCopyWith<Decorator> get copyWith =>
      _$DecoratorCopyWithImpl<Decorator>(this as Decorator, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Decorator &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'Decorator(a: $a)';
  }
}

/// @nodoc
abstract mixin class $DecoratorCopyWith<$Res> {
  factory $DecoratorCopyWith(Decorator value, $Res Function(Decorator) _then) =
      _$DecoratorCopyWithImpl;
  @useResult
  $Res call({@deprecated @_WeirdDecorator('a', b: 0.42) String? a});
}

/// @nodoc
class _$DecoratorCopyWithImpl<$Res> implements $DecoratorCopyWith<$Res> {
  _$DecoratorCopyWithImpl(this._self, this._then);

  final Decorator _self;
  final $Res Function(Decorator) _then;

  /// Create a copy of Decorator
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
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Decorator].
extension DecoratorPatterns on Decorator {
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
    TResult Function(Decorator0 value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Decorator0() when $default != null:
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
    TResult Function(Decorator0 value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case Decorator0():
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
    TResult? Function(Decorator0 value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case Decorator0() when $default != null:
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
    TResult Function(@deprecated @_WeirdDecorator('a', b: 0.42) String? a)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Decorator0() when $default != null:
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
    TResult Function(@deprecated @_WeirdDecorator('a', b: 0.42) String? a)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case Decorator0():
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
    TResult? Function(@deprecated @_WeirdDecorator('a', b: 0.42) String? a)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case Decorator0() when $default != null:
        return $default(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

class Decorator0 implements Decorator {
  Decorator0({@deprecated @_WeirdDecorator('a', b: 0.42) this.a});

  @override
  @deprecated
  @_WeirdDecorator('a', b: 0.42)
  final String? a;

  /// Create a copy of Decorator
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Decorator0CopyWith<Decorator0> get copyWith =>
      _$Decorator0CopyWithImpl<Decorator0>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Decorator0 &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'Decorator(a: $a)';
  }
}

/// @nodoc
abstract mixin class $Decorator0CopyWith<$Res>
    implements $DecoratorCopyWith<$Res> {
  factory $Decorator0CopyWith(
          Decorator0 value, $Res Function(Decorator0) _then) =
      _$Decorator0CopyWithImpl;
  @override
  @useResult
  $Res call({@deprecated @_WeirdDecorator('a', b: 0.42) String? a});
}

/// @nodoc
class _$Decorator0CopyWithImpl<$Res> implements $Decorator0CopyWith<$Res> {
  _$Decorator0CopyWithImpl(this._self, this._then);

  final Decorator0 _self;
  final $Res Function(Decorator0) _then;

  /// Create a copy of Decorator
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = freezed,
  }) {
    return _then(Decorator0(
      a: freezed == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$ListDecorator {
  @Foo()
  List<int> get a;

  /// Create a copy of ListDecorator
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ListDecoratorCopyWith<ListDecorator> get copyWith =>
      _$ListDecoratorCopyWithImpl<ListDecorator>(
          this as ListDecorator, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ListDecorator &&
            const DeepCollectionEquality().equals(other.a, a));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(a));

  @override
  String toString() {
    return 'ListDecorator(a: $a)';
  }
}

/// @nodoc
abstract mixin class $ListDecoratorCopyWith<$Res> {
  factory $ListDecoratorCopyWith(
          ListDecorator value, $Res Function(ListDecorator) _then) =
      _$ListDecoratorCopyWithImpl;
  @useResult
  $Res call({@Foo() List<int> a});
}

/// @nodoc
class _$ListDecoratorCopyWithImpl<$Res>
    implements $ListDecoratorCopyWith<$Res> {
  _$ListDecoratorCopyWithImpl(this._self, this._then);

  final ListDecorator _self;
  final $Res Function(ListDecorator) _then;

  /// Create a copy of ListDecorator
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
              as List<int>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ListDecorator].
extension ListDecoratorPatterns on ListDecorator {
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
    TResult Function(ListDecorator0 value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ListDecorator0() when $default != null:
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
    TResult Function(ListDecorator0 value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case ListDecorator0():
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
    TResult? Function(ListDecorator0 value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case ListDecorator0() when $default != null:
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
    TResult Function(@Foo() List<int> a)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ListDecorator0() when $default != null:
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
    TResult Function(@Foo() List<int> a) $default,
  ) {
    final _that = this;
    switch (_that) {
      case ListDecorator0():
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
    TResult? Function(@Foo() List<int> a)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case ListDecorator0() when $default != null:
        return $default(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

class ListDecorator0 implements ListDecorator {
  ListDecorator0(@Foo() final List<int> a) : _a = a;

  final List<int> _a;
  @override
  @Foo()
  List<int> get a {
    if (_a is EqualUnmodifiableListView) return _a;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_a);
  }

  /// Create a copy of ListDecorator
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ListDecorator0CopyWith<ListDecorator0> get copyWith =>
      _$ListDecorator0CopyWithImpl<ListDecorator0>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ListDecorator0 &&
            const DeepCollectionEquality().equals(other._a, _a));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_a));

  @override
  String toString() {
    return 'ListDecorator(a: $a)';
  }
}

/// @nodoc
abstract mixin class $ListDecorator0CopyWith<$Res>
    implements $ListDecoratorCopyWith<$Res> {
  factory $ListDecorator0CopyWith(
          ListDecorator0 value, $Res Function(ListDecorator0) _then) =
      _$ListDecorator0CopyWithImpl;
  @override
  @useResult
  $Res call({@Foo() List<int> a});
}

/// @nodoc
class _$ListDecorator0CopyWithImpl<$Res>
    implements $ListDecorator0CopyWith<$Res> {
  _$ListDecorator0CopyWithImpl(this._self, this._then);

  final ListDecorator0 _self;
  final $Res Function(ListDecorator0) _then;

  /// Create a copy of ListDecorator
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(ListDecorator0(
      null == a
          ? _self._a
          : a // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}
