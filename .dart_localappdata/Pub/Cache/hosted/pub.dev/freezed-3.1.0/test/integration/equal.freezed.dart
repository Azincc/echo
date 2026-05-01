// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'equal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Simple {
  int get value;

  /// Create a copy of Simple
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SimpleCopyWith<Simple> get copyWith =>
      _$SimpleCopyWithImpl<Simple>(this as Simple, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Simple &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'Simple(value: $value)';
  }
}

/// @nodoc
abstract mixin class $SimpleCopyWith<$Res> {
  factory $SimpleCopyWith(Simple value, $Res Function(Simple) _then) =
      _$SimpleCopyWithImpl;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$SimpleCopyWithImpl<$Res> implements $SimpleCopyWith<$Res> {
  _$SimpleCopyWithImpl(this._self, this._then);

  final Simple _self;
  final $Res Function(Simple) _then;

  /// Create a copy of Simple
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

/// Adds pattern-matching-related methods to [Simple].
extension SimplePatterns on Simple {
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
    TResult Function(_Simple value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Simple() when $default != null:
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
    TResult Function(_Simple value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Simple():
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
    TResult? Function(_Simple value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Simple() when $default != null:
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
    TResult Function(int value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Simple() when $default != null:
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
    TResult Function(int value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Simple():
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
    TResult? Function(int value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Simple() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Simple implements Simple {
  _Simple(this.value);

  @override
  final int value;

  /// Create a copy of Simple
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SimpleCopyWith<_Simple> get copyWith =>
      __$SimpleCopyWithImpl<_Simple>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Simple &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'Simple(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$SimpleCopyWith<$Res> implements $SimpleCopyWith<$Res> {
  factory _$SimpleCopyWith(_Simple value, $Res Function(_Simple) _then) =
      __$SimpleCopyWithImpl;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$SimpleCopyWithImpl<$Res> implements _$SimpleCopyWith<$Res> {
  __$SimpleCopyWithImpl(this._self, this._then);

  final _Simple _self;
  final $Res Function(_Simple) _then;

  /// Create a copy of Simple
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_Simple(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$ListEqual {
  List<int> get value;

  /// Create a copy of ListEqual
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ListEqualCopyWith<ListEqual> get copyWith =>
      _$ListEqualCopyWithImpl<ListEqual>(this as ListEqual, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ListEqual &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'ListEqual(value: $value)';
  }
}

/// @nodoc
abstract mixin class $ListEqualCopyWith<$Res> {
  factory $ListEqualCopyWith(ListEqual value, $Res Function(ListEqual) _then) =
      _$ListEqualCopyWithImpl;
  @useResult
  $Res call({List<int> value});
}

/// @nodoc
class _$ListEqualCopyWithImpl<$Res> implements $ListEqualCopyWith<$Res> {
  _$ListEqualCopyWithImpl(this._self, this._then);

  final ListEqual _self;
  final $Res Function(ListEqual) _then;

  /// Create a copy of ListEqual
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
              as List<int>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ListEqual].
extension ListEqualPatterns on ListEqual {
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
    TResult Function(_ListEqual value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ListEqual() when $default != null:
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
    TResult Function(_ListEqual value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ListEqual():
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
    TResult? Function(_ListEqual value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ListEqual() when $default != null:
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
    TResult Function(List<int> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ListEqual() when $default != null:
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
    TResult Function(List<int> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ListEqual():
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
    TResult? Function(List<int> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ListEqual() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ListEqual implements ListEqual {
  _ListEqual(final List<int> value) : _value = value;

  final List<int> _value;
  @override
  List<int> get value {
    if (_value is EqualUnmodifiableListView) return _value;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_value);
  }

  /// Create a copy of ListEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ListEqualCopyWith<_ListEqual> get copyWith =>
      __$ListEqualCopyWithImpl<_ListEqual>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ListEqual &&
            const DeepCollectionEquality().equals(other._value, _value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_value));

  @override
  String toString() {
    return 'ListEqual(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$ListEqualCopyWith<$Res>
    implements $ListEqualCopyWith<$Res> {
  factory _$ListEqualCopyWith(
          _ListEqual value, $Res Function(_ListEqual) _then) =
      __$ListEqualCopyWithImpl;
  @override
  @useResult
  $Res call({List<int> value});
}

/// @nodoc
class __$ListEqualCopyWithImpl<$Res> implements _$ListEqualCopyWith<$Res> {
  __$ListEqualCopyWithImpl(this._self, this._then);

  final _ListEqual _self;
  final $Res Function(_ListEqual) _then;

  /// Create a copy of ListEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_ListEqual(
      null == value
          ? _self._value
          : value // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
mixin _$MapEqual {
  Map<int, int> get value;

  /// Create a copy of MapEqual
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MapEqualCopyWith<MapEqual> get copyWith =>
      _$MapEqualCopyWithImpl<MapEqual>(this as MapEqual, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MapEqual &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'MapEqual(value: $value)';
  }
}

/// @nodoc
abstract mixin class $MapEqualCopyWith<$Res> {
  factory $MapEqualCopyWith(MapEqual value, $Res Function(MapEqual) _then) =
      _$MapEqualCopyWithImpl;
  @useResult
  $Res call({Map<int, int> value});
}

/// @nodoc
class _$MapEqualCopyWithImpl<$Res> implements $MapEqualCopyWith<$Res> {
  _$MapEqualCopyWithImpl(this._self, this._then);

  final MapEqual _self;
  final $Res Function(MapEqual) _then;

  /// Create a copy of MapEqual
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
              as Map<int, int>,
    ));
  }
}

/// Adds pattern-matching-related methods to [MapEqual].
extension MapEqualPatterns on MapEqual {
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
    TResult Function(_MapEqual value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MapEqual() when $default != null:
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
    TResult Function(_MapEqual value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MapEqual():
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
    TResult? Function(_MapEqual value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MapEqual() when $default != null:
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
    TResult Function(Map<int, int> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MapEqual() when $default != null:
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
    TResult Function(Map<int, int> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MapEqual():
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
    TResult? Function(Map<int, int> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MapEqual() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _MapEqual implements MapEqual {
  _MapEqual(final Map<int, int> value) : _value = value;

  final Map<int, int> _value;
  @override
  Map<int, int> get value {
    if (_value is EqualUnmodifiableMapView) return _value;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_value);
  }

  /// Create a copy of MapEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MapEqualCopyWith<_MapEqual> get copyWith =>
      __$MapEqualCopyWithImpl<_MapEqual>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MapEqual &&
            const DeepCollectionEquality().equals(other._value, _value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_value));

  @override
  String toString() {
    return 'MapEqual(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$MapEqualCopyWith<$Res>
    implements $MapEqualCopyWith<$Res> {
  factory _$MapEqualCopyWith(_MapEqual value, $Res Function(_MapEqual) _then) =
      __$MapEqualCopyWithImpl;
  @override
  @useResult
  $Res call({Map<int, int> value});
}

/// @nodoc
class __$MapEqualCopyWithImpl<$Res> implements _$MapEqualCopyWith<$Res> {
  __$MapEqualCopyWithImpl(this._self, this._then);

  final _MapEqual _self;
  final $Res Function(_MapEqual) _then;

  /// Create a copy of MapEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_MapEqual(
      null == value
          ? _self._value
          : value // ignore: cast_nullable_to_non_nullable
              as Map<int, int>,
    ));
  }
}

/// @nodoc
mixin _$SetEqual {
  Set<int> get value;

  /// Create a copy of SetEqual
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SetEqualCopyWith<SetEqual> get copyWith =>
      _$SetEqualCopyWithImpl<SetEqual>(this as SetEqual, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SetEqual &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'SetEqual(value: $value)';
  }
}

/// @nodoc
abstract mixin class $SetEqualCopyWith<$Res> {
  factory $SetEqualCopyWith(SetEqual value, $Res Function(SetEqual) _then) =
      _$SetEqualCopyWithImpl;
  @useResult
  $Res call({Set<int> value});
}

/// @nodoc
class _$SetEqualCopyWithImpl<$Res> implements $SetEqualCopyWith<$Res> {
  _$SetEqualCopyWithImpl(this._self, this._then);

  final SetEqual _self;
  final $Res Function(SetEqual) _then;

  /// Create a copy of SetEqual
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
              as Set<int>,
    ));
  }
}

/// Adds pattern-matching-related methods to [SetEqual].
extension SetEqualPatterns on SetEqual {
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
    TResult Function(_SetEqual value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SetEqual() when $default != null:
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
    TResult Function(_SetEqual value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SetEqual():
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
    TResult? Function(_SetEqual value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SetEqual() when $default != null:
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
    TResult Function(Set<int> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SetEqual() when $default != null:
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
    TResult Function(Set<int> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SetEqual():
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
    TResult? Function(Set<int> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SetEqual() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SetEqual implements SetEqual {
  _SetEqual(final Set<int> value) : _value = value;

  final Set<int> _value;
  @override
  Set<int> get value {
    if (_value is EqualUnmodifiableSetView) return _value;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_value);
  }

  /// Create a copy of SetEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SetEqualCopyWith<_SetEqual> get copyWith =>
      __$SetEqualCopyWithImpl<_SetEqual>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SetEqual &&
            const DeepCollectionEquality().equals(other._value, _value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_value));

  @override
  String toString() {
    return 'SetEqual(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$SetEqualCopyWith<$Res>
    implements $SetEqualCopyWith<$Res> {
  factory _$SetEqualCopyWith(_SetEqual value, $Res Function(_SetEqual) _then) =
      __$SetEqualCopyWithImpl;
  @override
  @useResult
  $Res call({Set<int> value});
}

/// @nodoc
class __$SetEqualCopyWithImpl<$Res> implements _$SetEqualCopyWith<$Res> {
  __$SetEqualCopyWithImpl(this._self, this._then);

  final _SetEqual _self;
  final $Res Function(_SetEqual) _then;

  /// Create a copy of SetEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_SetEqual(
      null == value
          ? _self._value
          : value // ignore: cast_nullable_to_non_nullable
              as Set<int>,
    ));
  }
}

/// @nodoc
mixin _$IterableEqual {
  Iterable<int> get value;

  /// Create a copy of IterableEqual
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $IterableEqualCopyWith<IterableEqual> get copyWith =>
      _$IterableEqualCopyWithImpl<IterableEqual>(
          this as IterableEqual, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is IterableEqual &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'IterableEqual(value: $value)';
  }
}

/// @nodoc
abstract mixin class $IterableEqualCopyWith<$Res> {
  factory $IterableEqualCopyWith(
          IterableEqual value, $Res Function(IterableEqual) _then) =
      _$IterableEqualCopyWithImpl;
  @useResult
  $Res call({Iterable<int> value});
}

/// @nodoc
class _$IterableEqualCopyWithImpl<$Res>
    implements $IterableEqualCopyWith<$Res> {
  _$IterableEqualCopyWithImpl(this._self, this._then);

  final IterableEqual _self;
  final $Res Function(IterableEqual) _then;

  /// Create a copy of IterableEqual
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
              as Iterable<int>,
    ));
  }
}

/// Adds pattern-matching-related methods to [IterableEqual].
extension IterableEqualPatterns on IterableEqual {
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
    TResult Function(_IterableEqual value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _IterableEqual() when $default != null:
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
    TResult Function(_IterableEqual value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IterableEqual():
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
    TResult? Function(_IterableEqual value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IterableEqual() when $default != null:
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
    TResult Function(Iterable<int> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _IterableEqual() when $default != null:
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
    TResult Function(Iterable<int> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IterableEqual():
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
    TResult? Function(Iterable<int> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IterableEqual() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _IterableEqual implements IterableEqual {
  _IterableEqual(this.value);

  @override
  final Iterable<int> value;

  /// Create a copy of IterableEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$IterableEqualCopyWith<_IterableEqual> get copyWith =>
      __$IterableEqualCopyWithImpl<_IterableEqual>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _IterableEqual &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'IterableEqual(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$IterableEqualCopyWith<$Res>
    implements $IterableEqualCopyWith<$Res> {
  factory _$IterableEqualCopyWith(
          _IterableEqual value, $Res Function(_IterableEqual) _then) =
      __$IterableEqualCopyWithImpl;
  @override
  @useResult
  $Res call({Iterable<int> value});
}

/// @nodoc
class __$IterableEqualCopyWithImpl<$Res>
    implements _$IterableEqualCopyWith<$Res> {
  __$IterableEqualCopyWithImpl(this._self, this._then);

  final _IterableEqual _self;
  final $Res Function(_IterableEqual) _then;

  /// Create a copy of IterableEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_IterableEqual(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as Iterable<int>,
    ));
  }
}

/// @nodoc
mixin _$ListObjectEqual {
  List<Object> get value;

  /// Create a copy of ListObjectEqual
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ListObjectEqualCopyWith<ListObjectEqual> get copyWith =>
      _$ListObjectEqualCopyWithImpl<ListObjectEqual>(
          this as ListObjectEqual, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ListObjectEqual &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'ListObjectEqual(value: $value)';
  }
}

/// @nodoc
abstract mixin class $ListObjectEqualCopyWith<$Res> {
  factory $ListObjectEqualCopyWith(
          ListObjectEqual value, $Res Function(ListObjectEqual) _then) =
      _$ListObjectEqualCopyWithImpl;
  @useResult
  $Res call({List<Object> value});
}

/// @nodoc
class _$ListObjectEqualCopyWithImpl<$Res>
    implements $ListObjectEqualCopyWith<$Res> {
  _$ListObjectEqualCopyWithImpl(this._self, this._then);

  final ListObjectEqual _self;
  final $Res Function(ListObjectEqual) _then;

  /// Create a copy of ListObjectEqual
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
              as List<Object>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ListObjectEqual].
extension ListObjectEqualPatterns on ListObjectEqual {
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
    TResult Function(_ListObjectEqual value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ListObjectEqual() when $default != null:
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
    TResult Function(_ListObjectEqual value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ListObjectEqual():
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
    TResult? Function(_ListObjectEqual value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ListObjectEqual() when $default != null:
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
    TResult Function(List<Object> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ListObjectEqual() when $default != null:
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
    TResult Function(List<Object> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ListObjectEqual():
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
    TResult? Function(List<Object> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ListObjectEqual() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ListObjectEqual implements ListObjectEqual {
  _ListObjectEqual(final List<Object> value) : _value = value;

  final List<Object> _value;
  @override
  List<Object> get value {
    if (_value is EqualUnmodifiableListView) return _value;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_value);
  }

  /// Create a copy of ListObjectEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ListObjectEqualCopyWith<_ListObjectEqual> get copyWith =>
      __$ListObjectEqualCopyWithImpl<_ListObjectEqual>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ListObjectEqual &&
            const DeepCollectionEquality().equals(other._value, _value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_value));

  @override
  String toString() {
    return 'ListObjectEqual(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$ListObjectEqualCopyWith<$Res>
    implements $ListObjectEqualCopyWith<$Res> {
  factory _$ListObjectEqualCopyWith(
          _ListObjectEqual value, $Res Function(_ListObjectEqual) _then) =
      __$ListObjectEqualCopyWithImpl;
  @override
  @useResult
  $Res call({List<Object> value});
}

/// @nodoc
class __$ListObjectEqualCopyWithImpl<$Res>
    implements _$ListObjectEqualCopyWith<$Res> {
  __$ListObjectEqualCopyWithImpl(this._self, this._then);

  final _ListObjectEqual _self;
  final $Res Function(_ListObjectEqual) _then;

  /// Create a copy of ListObjectEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_ListObjectEqual(
      null == value
          ? _self._value
          : value // ignore: cast_nullable_to_non_nullable
              as List<Object>,
    ));
  }
}

/// @nodoc
mixin _$ListDynamicEqual {
  List<dynamic> get value;

  /// Create a copy of ListDynamicEqual
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ListDynamicEqualCopyWith<ListDynamicEqual> get copyWith =>
      _$ListDynamicEqualCopyWithImpl<ListDynamicEqual>(
          this as ListDynamicEqual, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ListDynamicEqual &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'ListDynamicEqual(value: $value)';
  }
}

/// @nodoc
abstract mixin class $ListDynamicEqualCopyWith<$Res> {
  factory $ListDynamicEqualCopyWith(
          ListDynamicEqual value, $Res Function(ListDynamicEqual) _then) =
      _$ListDynamicEqualCopyWithImpl;
  @useResult
  $Res call({List<dynamic> value});
}

/// @nodoc
class _$ListDynamicEqualCopyWithImpl<$Res>
    implements $ListDynamicEqualCopyWith<$Res> {
  _$ListDynamicEqualCopyWithImpl(this._self, this._then);

  final ListDynamicEqual _self;
  final $Res Function(ListDynamicEqual) _then;

  /// Create a copy of ListDynamicEqual
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
              as List<dynamic>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ListDynamicEqual].
extension ListDynamicEqualPatterns on ListDynamicEqual {
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
    TResult Function(_ListDynamicEqual value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ListDynamicEqual() when $default != null:
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
    TResult Function(_ListDynamicEqual value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ListDynamicEqual():
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
    TResult? Function(_ListDynamicEqual value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ListDynamicEqual() when $default != null:
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
    TResult Function(List<dynamic> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ListDynamicEqual() when $default != null:
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
    TResult Function(List<dynamic> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ListDynamicEqual():
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
    TResult? Function(List<dynamic> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ListDynamicEqual() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ListDynamicEqual implements ListDynamicEqual {
  _ListDynamicEqual(final List<dynamic> value) : _value = value;

  final List<dynamic> _value;
  @override
  List<dynamic> get value {
    if (_value is EqualUnmodifiableListView) return _value;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_value);
  }

  /// Create a copy of ListDynamicEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ListDynamicEqualCopyWith<_ListDynamicEqual> get copyWith =>
      __$ListDynamicEqualCopyWithImpl<_ListDynamicEqual>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ListDynamicEqual &&
            const DeepCollectionEquality().equals(other._value, _value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_value));

  @override
  String toString() {
    return 'ListDynamicEqual(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$ListDynamicEqualCopyWith<$Res>
    implements $ListDynamicEqualCopyWith<$Res> {
  factory _$ListDynamicEqualCopyWith(
          _ListDynamicEqual value, $Res Function(_ListDynamicEqual) _then) =
      __$ListDynamicEqualCopyWithImpl;
  @override
  @useResult
  $Res call({List<dynamic> value});
}

/// @nodoc
class __$ListDynamicEqualCopyWithImpl<$Res>
    implements _$ListDynamicEqualCopyWith<$Res> {
  __$ListDynamicEqualCopyWithImpl(this._self, this._then);

  final _ListDynamicEqual _self;
  final $Res Function(_ListDynamicEqual) _then;

  /// Create a copy of ListDynamicEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_ListDynamicEqual(
      null == value
          ? _self._value
          : value // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ));
  }
}

/// @nodoc
mixin _$ObjectEqual {
  Object get value;

  /// Create a copy of ObjectEqual
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ObjectEqualCopyWith<ObjectEqual> get copyWith =>
      _$ObjectEqualCopyWithImpl<ObjectEqual>(this as ObjectEqual, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ObjectEqual &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'ObjectEqual(value: $value)';
  }
}

/// @nodoc
abstract mixin class $ObjectEqualCopyWith<$Res> {
  factory $ObjectEqualCopyWith(
          ObjectEqual value, $Res Function(ObjectEqual) _then) =
      _$ObjectEqualCopyWithImpl;
  @useResult
  $Res call({Object value});
}

/// @nodoc
class _$ObjectEqualCopyWithImpl<$Res> implements $ObjectEqualCopyWith<$Res> {
  _$ObjectEqualCopyWithImpl(this._self, this._then);

  final ObjectEqual _self;
  final $Res Function(ObjectEqual) _then;

  /// Create a copy of ObjectEqual
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_self.copyWith(
      value: null == value ? _self.value : value,
    ));
  }
}

/// Adds pattern-matching-related methods to [ObjectEqual].
extension ObjectEqualPatterns on ObjectEqual {
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
    TResult Function(_ObjectEqual value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ObjectEqual() when $default != null:
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
    TResult Function(_ObjectEqual value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ObjectEqual():
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
    TResult? Function(_ObjectEqual value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ObjectEqual() when $default != null:
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
    TResult Function(Object value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ObjectEqual() when $default != null:
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
    TResult Function(Object value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ObjectEqual():
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
    TResult? Function(Object value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ObjectEqual() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ObjectEqual implements ObjectEqual {
  _ObjectEqual(this.value);

  @override
  final Object value;

  /// Create a copy of ObjectEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ObjectEqualCopyWith<_ObjectEqual> get copyWith =>
      __$ObjectEqualCopyWithImpl<_ObjectEqual>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ObjectEqual &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'ObjectEqual(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$ObjectEqualCopyWith<$Res>
    implements $ObjectEqualCopyWith<$Res> {
  factory _$ObjectEqualCopyWith(
          _ObjectEqual value, $Res Function(_ObjectEqual) _then) =
      __$ObjectEqualCopyWithImpl;
  @override
  @useResult
  $Res call({Object value});
}

/// @nodoc
class __$ObjectEqualCopyWithImpl<$Res> implements _$ObjectEqualCopyWith<$Res> {
  __$ObjectEqualCopyWithImpl(this._self, this._then);

  final _ObjectEqual _self;
  final $Res Function(_ObjectEqual) _then;

  /// Create a copy of ObjectEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_ObjectEqual(
      null == value ? _self.value : value,
    ));
  }
}

/// @nodoc
mixin _$NullableObjectEqual {
  Object? get value;

  /// Create a copy of NullableObjectEqual
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NullableObjectEqualCopyWith<NullableObjectEqual> get copyWith =>
      _$NullableObjectEqualCopyWithImpl<NullableObjectEqual>(
          this as NullableObjectEqual, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NullableObjectEqual &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'NullableObjectEqual(value: $value)';
  }
}

/// @nodoc
abstract mixin class $NullableObjectEqualCopyWith<$Res> {
  factory $NullableObjectEqualCopyWith(
          NullableObjectEqual value, $Res Function(NullableObjectEqual) _then) =
      _$NullableObjectEqualCopyWithImpl;
  @useResult
  $Res call({Object? value});
}

/// @nodoc
class _$NullableObjectEqualCopyWithImpl<$Res>
    implements $NullableObjectEqualCopyWith<$Res> {
  _$NullableObjectEqualCopyWithImpl(this._self, this._then);

  final NullableObjectEqual _self;
  final $Res Function(NullableObjectEqual) _then;

  /// Create a copy of NullableObjectEqual
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_self.copyWith(
      value: freezed == value ? _self.value : value,
    ));
  }
}

/// Adds pattern-matching-related methods to [NullableObjectEqual].
extension NullableObjectEqualPatterns on NullableObjectEqual {
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
    TResult Function(_NullableObjectEqual value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NullableObjectEqual() when $default != null:
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
    TResult Function(_NullableObjectEqual value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NullableObjectEqual():
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
    TResult? Function(_NullableObjectEqual value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NullableObjectEqual() when $default != null:
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
    TResult Function(Object? value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NullableObjectEqual() when $default != null:
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
    TResult Function(Object? value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NullableObjectEqual():
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
    TResult? Function(Object? value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NullableObjectEqual() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _NullableObjectEqual implements NullableObjectEqual {
  _NullableObjectEqual(this.value);

  @override
  final Object? value;

  /// Create a copy of NullableObjectEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NullableObjectEqualCopyWith<_NullableObjectEqual> get copyWith =>
      __$NullableObjectEqualCopyWithImpl<_NullableObjectEqual>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NullableObjectEqual &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'NullableObjectEqual(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$NullableObjectEqualCopyWith<$Res>
    implements $NullableObjectEqualCopyWith<$Res> {
  factory _$NullableObjectEqualCopyWith(_NullableObjectEqual value,
          $Res Function(_NullableObjectEqual) _then) =
      __$NullableObjectEqualCopyWithImpl;
  @override
  @useResult
  $Res call({Object? value});
}

/// @nodoc
class __$NullableObjectEqualCopyWithImpl<$Res>
    implements _$NullableObjectEqualCopyWith<$Res> {
  __$NullableObjectEqualCopyWithImpl(this._self, this._then);

  final _NullableObjectEqual _self;
  final $Res Function(_NullableObjectEqual) _then;

  /// Create a copy of NullableObjectEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_NullableObjectEqual(
      freezed == value ? _self.value : value,
    ));
  }
}

/// @nodoc
mixin _$DynamicEqual {
  dynamic get value;

  /// Create a copy of DynamicEqual
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DynamicEqualCopyWith<DynamicEqual> get copyWith =>
      _$DynamicEqualCopyWithImpl<DynamicEqual>(
          this as DynamicEqual, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DynamicEqual &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'DynamicEqual(value: $value)';
  }
}

/// @nodoc
abstract mixin class $DynamicEqualCopyWith<$Res> {
  factory $DynamicEqualCopyWith(
          DynamicEqual value, $Res Function(DynamicEqual) _then) =
      _$DynamicEqualCopyWithImpl;
  @useResult
  $Res call({dynamic value});
}

/// @nodoc
class _$DynamicEqualCopyWithImpl<$Res> implements $DynamicEqualCopyWith<$Res> {
  _$DynamicEqualCopyWithImpl(this._self, this._then);

  final DynamicEqual _self;
  final $Res Function(DynamicEqual) _then;

  /// Create a copy of DynamicEqual
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
              as dynamic,
    ));
  }
}

/// Adds pattern-matching-related methods to [DynamicEqual].
extension DynamicEqualPatterns on DynamicEqual {
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
    TResult Function(_DynamicEqual value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DynamicEqual() when $default != null:
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
    TResult Function(_DynamicEqual value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DynamicEqual():
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
    TResult? Function(_DynamicEqual value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DynamicEqual() when $default != null:
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
    TResult Function(dynamic value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DynamicEqual() when $default != null:
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
    TResult Function(dynamic value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DynamicEqual():
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
    TResult? Function(dynamic value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DynamicEqual() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DynamicEqual implements DynamicEqual {
  _DynamicEqual(this.value);

  @override
  final dynamic value;

  /// Create a copy of DynamicEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DynamicEqualCopyWith<_DynamicEqual> get copyWith =>
      __$DynamicEqualCopyWithImpl<_DynamicEqual>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DynamicEqual &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'DynamicEqual(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$DynamicEqualCopyWith<$Res>
    implements $DynamicEqualCopyWith<$Res> {
  factory _$DynamicEqualCopyWith(
          _DynamicEqual value, $Res Function(_DynamicEqual) _then) =
      __$DynamicEqualCopyWithImpl;
  @override
  @useResult
  $Res call({dynamic value});
}

/// @nodoc
class __$DynamicEqualCopyWithImpl<$Res>
    implements _$DynamicEqualCopyWith<$Res> {
  __$DynamicEqualCopyWithImpl(this._self, this._then);

  final _DynamicEqual _self;
  final $Res Function(_DynamicEqual) _then;

  /// Create a copy of DynamicEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_DynamicEqual(
      freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
mixin _$Generic<T> {
  T get value;

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
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'Generic<$T>(value: $value)';
  }
}

/// @nodoc
abstract mixin class $GenericCopyWith<T, $Res> {
  factory $GenericCopyWith(Generic<T> value, $Res Function(Generic<T>) _then) =
      _$GenericCopyWithImpl;
  @useResult
  $Res call({T value});
}

/// @nodoc
class _$GenericCopyWithImpl<T, $Res> implements $GenericCopyWith<T, $Res> {
  _$GenericCopyWithImpl(this._self, this._then);

  final Generic<T> _self;
  final $Res Function(Generic<T>) _then;

  /// Create a copy of Generic
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

/// Adds pattern-matching-related methods to [Generic].
extension GenericPatterns<T> on Generic<T> {
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
    TResult Function(T value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Generic() when $default != null:
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
      case _Generic():
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
      case _Generic() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Generic<T> implements Generic<T> {
  _Generic(this.value);

  @override
  final T value;

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
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'Generic<$T>(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$GenericCopyWith<T, $Res>
    implements $GenericCopyWith<T, $Res> {
  factory _$GenericCopyWith(
          _Generic<T> value, $Res Function(_Generic<T>) _then) =
      __$GenericCopyWithImpl;
  @override
  @useResult
  $Res call({T value});
}

/// @nodoc
class __$GenericCopyWithImpl<T, $Res> implements _$GenericCopyWith<T, $Res> {
  __$GenericCopyWithImpl(this._self, this._then);

  final _Generic<T> _self;
  final $Res Function(_Generic<T>) _then;

  /// Create a copy of Generic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_Generic<T>(
      freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc
mixin _$GenericObject<T extends Object> {
  T get value;

  /// Create a copy of GenericObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GenericObjectCopyWith<T, GenericObject<T>> get copyWith =>
      _$GenericObjectCopyWithImpl<T, GenericObject<T>>(
          this as GenericObject<T>, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GenericObject<T> &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'GenericObject<$T>(value: $value)';
  }
}

/// @nodoc
abstract mixin class $GenericObjectCopyWith<T extends Object, $Res> {
  factory $GenericObjectCopyWith(
          GenericObject<T> value, $Res Function(GenericObject<T>) _then) =
      _$GenericObjectCopyWithImpl;
  @useResult
  $Res call({T value});
}

/// @nodoc
class _$GenericObjectCopyWithImpl<T extends Object, $Res>
    implements $GenericObjectCopyWith<T, $Res> {
  _$GenericObjectCopyWithImpl(this._self, this._then);

  final GenericObject<T> _self;
  final $Res Function(GenericObject<T>) _then;

  /// Create a copy of GenericObject
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

/// Adds pattern-matching-related methods to [GenericObject].
extension GenericObjectPatterns<T extends Object> on GenericObject<T> {
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
    TResult Function(_GenericObject<T> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GenericObject() when $default != null:
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
    TResult Function(_GenericObject<T> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenericObject():
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
    TResult? Function(_GenericObject<T> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenericObject() when $default != null:
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
      case _GenericObject() when $default != null:
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
      case _GenericObject():
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
      case _GenericObject() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GenericObject<T extends Object> implements GenericObject<T> {
  _GenericObject(this.value);

  @override
  final T value;

  /// Create a copy of GenericObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GenericObjectCopyWith<T, _GenericObject<T>> get copyWith =>
      __$GenericObjectCopyWithImpl<T, _GenericObject<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GenericObject<T> &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'GenericObject<$T>(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$GenericObjectCopyWith<T extends Object, $Res>
    implements $GenericObjectCopyWith<T, $Res> {
  factory _$GenericObjectCopyWith(
          _GenericObject<T> value, $Res Function(_GenericObject<T>) _then) =
      __$GenericObjectCopyWithImpl;
  @override
  @useResult
  $Res call({T value});
}

/// @nodoc
class __$GenericObjectCopyWithImpl<T extends Object, $Res>
    implements _$GenericObjectCopyWith<T, $Res> {
  __$GenericObjectCopyWithImpl(this._self, this._then);

  final _GenericObject<T> _self;
  final $Res Function(_GenericObject<T>) _then;

  /// Create a copy of GenericObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_GenericObject<T>(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc
mixin _$GenericIterable<T extends Iterable<dynamic>> {
  T get value;

  /// Create a copy of GenericIterable
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GenericIterableCopyWith<T, GenericIterable<T>> get copyWith =>
      _$GenericIterableCopyWithImpl<T, GenericIterable<T>>(
          this as GenericIterable<T>, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GenericIterable<T> &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'GenericIterable<$T>(value: $value)';
  }
}

/// @nodoc
abstract mixin class $GenericIterableCopyWith<T extends Iterable<dynamic>,
    $Res> {
  factory $GenericIterableCopyWith(
          GenericIterable<T> value, $Res Function(GenericIterable<T>) _then) =
      _$GenericIterableCopyWithImpl;
  @useResult
  $Res call({T value});
}

/// @nodoc
class _$GenericIterableCopyWithImpl<T extends Iterable<dynamic>, $Res>
    implements $GenericIterableCopyWith<T, $Res> {
  _$GenericIterableCopyWithImpl(this._self, this._then);

  final GenericIterable<T> _self;
  final $Res Function(GenericIterable<T>) _then;

  /// Create a copy of GenericIterable
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

/// Adds pattern-matching-related methods to [GenericIterable].
extension GenericIterablePatterns<T extends Iterable<dynamic>>
    on GenericIterable<T> {
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
    TResult Function(_GenericIterable<T> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GenericIterable() when $default != null:
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
    TResult Function(_GenericIterable<T> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenericIterable():
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
    TResult? Function(_GenericIterable<T> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenericIterable() when $default != null:
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
      case _GenericIterable() when $default != null:
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
      case _GenericIterable():
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
      case _GenericIterable() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GenericIterable<T extends Iterable<dynamic>>
    implements GenericIterable<T> {
  _GenericIterable(this.value);

  @override
  final T value;

  /// Create a copy of GenericIterable
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GenericIterableCopyWith<T, _GenericIterable<T>> get copyWith =>
      __$GenericIterableCopyWithImpl<T, _GenericIterable<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GenericIterable<T> &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'GenericIterable<$T>(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$GenericIterableCopyWith<T extends Iterable<dynamic>,
    $Res> implements $GenericIterableCopyWith<T, $Res> {
  factory _$GenericIterableCopyWith(
          _GenericIterable<T> value, $Res Function(_GenericIterable<T>) _then) =
      __$GenericIterableCopyWithImpl;
  @override
  @useResult
  $Res call({T value});
}

/// @nodoc
class __$GenericIterableCopyWithImpl<T extends Iterable<dynamic>, $Res>
    implements _$GenericIterableCopyWith<T, $Res> {
  __$GenericIterableCopyWithImpl(this._self, this._then);

  final _GenericIterable<T> _self;
  final $Res Function(_GenericIterable<T>) _then;

  /// Create a copy of GenericIterable
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_GenericIterable<T>(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc
mixin _$ObjectWithOtherProperty {
  List<int> get other;

  /// Create a copy of ObjectWithOtherProperty
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ObjectWithOtherPropertyCopyWith<ObjectWithOtherProperty> get copyWith =>
      _$ObjectWithOtherPropertyCopyWithImpl<ObjectWithOtherProperty>(
          this as ObjectWithOtherProperty, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ObjectWithOtherProperty &&
            const DeepCollectionEquality().equals(other.other, this.other));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(other));

  @override
  String toString() {
    return 'ObjectWithOtherProperty(other: $other)';
  }
}

/// @nodoc
abstract mixin class $ObjectWithOtherPropertyCopyWith<$Res> {
  factory $ObjectWithOtherPropertyCopyWith(ObjectWithOtherProperty value,
          $Res Function(ObjectWithOtherProperty) _then) =
      _$ObjectWithOtherPropertyCopyWithImpl;
  @useResult
  $Res call({List<int> other});
}

/// @nodoc
class _$ObjectWithOtherPropertyCopyWithImpl<$Res>
    implements $ObjectWithOtherPropertyCopyWith<$Res> {
  _$ObjectWithOtherPropertyCopyWithImpl(this._self, this._then);

  final ObjectWithOtherProperty _self;
  final $Res Function(ObjectWithOtherProperty) _then;

  /// Create a copy of ObjectWithOtherProperty
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? other = null,
  }) {
    return _then(_self.copyWith(
      other: null == other
          ? _self.other
          : other // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ObjectWithOtherProperty].
extension ObjectWithOtherPropertyPatterns on ObjectWithOtherProperty {
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
    TResult Function(_ObjectWithOtherProperty value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ObjectWithOtherProperty() when $default != null:
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
    TResult Function(_ObjectWithOtherProperty value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ObjectWithOtherProperty():
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
    TResult? Function(_ObjectWithOtherProperty value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ObjectWithOtherProperty() when $default != null:
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
    TResult Function(List<int> other)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ObjectWithOtherProperty() when $default != null:
        return $default(_that.other);
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
    TResult Function(List<int> other) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ObjectWithOtherProperty():
        return $default(_that.other);
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
    TResult? Function(List<int> other)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ObjectWithOtherProperty() when $default != null:
        return $default(_that.other);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ObjectWithOtherProperty implements ObjectWithOtherProperty {
  _ObjectWithOtherProperty(final List<int> other) : _other = other;

  final List<int> _other;
  @override
  List<int> get other {
    if (_other is EqualUnmodifiableListView) return _other;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_other);
  }

  /// Create a copy of ObjectWithOtherProperty
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ObjectWithOtherPropertyCopyWith<_ObjectWithOtherProperty> get copyWith =>
      __$ObjectWithOtherPropertyCopyWithImpl<_ObjectWithOtherProperty>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ObjectWithOtherProperty &&
            const DeepCollectionEquality().equals(other._other, this._other));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_other));

  @override
  String toString() {
    return 'ObjectWithOtherProperty(other: $other)';
  }
}

/// @nodoc
abstract mixin class _$ObjectWithOtherPropertyCopyWith<$Res>
    implements $ObjectWithOtherPropertyCopyWith<$Res> {
  factory _$ObjectWithOtherPropertyCopyWith(_ObjectWithOtherProperty value,
          $Res Function(_ObjectWithOtherProperty) _then) =
      __$ObjectWithOtherPropertyCopyWithImpl;
  @override
  @useResult
  $Res call({List<int> other});
}

/// @nodoc
class __$ObjectWithOtherPropertyCopyWithImpl<$Res>
    implements _$ObjectWithOtherPropertyCopyWith<$Res> {
  __$ObjectWithOtherPropertyCopyWithImpl(this._self, this._then);

  final _ObjectWithOtherProperty _self;
  final $Res Function(_ObjectWithOtherProperty) _then;

  /// Create a copy of ObjectWithOtherProperty
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? other = null,
  }) {
    return _then(_ObjectWithOtherProperty(
      null == other
          ? _self._other
          : other // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}
