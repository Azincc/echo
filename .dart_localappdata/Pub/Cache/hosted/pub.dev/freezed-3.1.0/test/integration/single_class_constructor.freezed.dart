// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'single_class_constructor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Regression1204 {
  StringAlias get id;

  /// Create a copy of Regression1204
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Regression1204CopyWith<Regression1204> get copyWith =>
      _$Regression1204CopyWithImpl<Regression1204>(
          this as Regression1204, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Regression1204 &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @override
  String toString() {
    return 'Regression1204(id: $id)';
  }
}

/// @nodoc
abstract mixin class $Regression1204CopyWith<$Res> {
  factory $Regression1204CopyWith(
          Regression1204 value, $Res Function(Regression1204) _then) =
      _$Regression1204CopyWithImpl;
  @useResult
  $Res call({StringAlias id});
}

/// @nodoc
class _$Regression1204CopyWithImpl<$Res>
    implements $Regression1204CopyWith<$Res> {
  _$Regression1204CopyWithImpl(this._self, this._then);

  final Regression1204 _self;
  final $Res Function(Regression1204) _then;

  /// Create a copy of Regression1204
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as StringAlias,
    ));
  }
}

/// Adds pattern-matching-related methods to [Regression1204].
extension Regression1204Patterns on Regression1204 {
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
    TResult Function(_Regression1204 value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Regression1204() when $default != null:
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
    TResult Function(_Regression1204 value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression1204():
        return $default(_that);
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
    TResult? Function(_Regression1204 value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression1204() when $default != null:
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
    TResult Function(StringAlias id)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Regression1204() when $default != null:
        return $default(_that.id);
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
    TResult Function(StringAlias id) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression1204():
        return $default(_that.id);
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
    TResult? Function(StringAlias id)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression1204() when $default != null:
        return $default(_that.id);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Regression1204 implements Regression1204 {
  const _Regression1204({required this.id});

  @override
  final StringAlias id;

  /// Create a copy of Regression1204
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$Regression1204CopyWith<_Regression1204> get copyWith =>
      __$Regression1204CopyWithImpl<_Regression1204>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Regression1204 &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @override
  String toString() {
    return 'Regression1204(id: $id)';
  }
}

/// @nodoc
abstract mixin class _$Regression1204CopyWith<$Res>
    implements $Regression1204CopyWith<$Res> {
  factory _$Regression1204CopyWith(
          _Regression1204 value, $Res Function(_Regression1204) _then) =
      __$Regression1204CopyWithImpl;
  @override
  @useResult
  $Res call({StringAlias id});
}

/// @nodoc
class __$Regression1204CopyWithImpl<$Res>
    implements _$Regression1204CopyWith<$Res> {
  __$Regression1204CopyWithImpl(this._self, this._then);

  final _Regression1204 _self;
  final $Res Function(_Regression1204) _then;

  /// Create a copy of Regression1204
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
  }) {
    return _then(_Regression1204(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as StringAlias,
    ));
  }
}

/// @nodoc
mixin _$ClassicUnspecifiedOuter {
  Inner? get innerData;

  /// Create a copy of ClassicUnspecifiedOuter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ClassicUnspecifiedOuterCopyWith<ClassicUnspecifiedOuter> get copyWith =>
      _$ClassicUnspecifiedOuterCopyWithImpl<ClassicUnspecifiedOuter>(
          this as ClassicUnspecifiedOuter, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ClassicUnspecifiedOuter &&
            (identical(other.innerData, innerData) ||
                other.innerData == innerData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, innerData);

  @override
  String toString() {
    return 'ClassicUnspecifiedOuter(innerData: $innerData)';
  }
}

/// @nodoc
abstract mixin class $ClassicUnspecifiedOuterCopyWith<$Res> {
  factory $ClassicUnspecifiedOuterCopyWith(ClassicUnspecifiedOuter value,
          $Res Function(ClassicUnspecifiedOuter) _then) =
      _$ClassicUnspecifiedOuterCopyWithImpl;
  @useResult
  $Res call({Inner<dynamic>? innerData});
}

/// @nodoc
class _$ClassicUnspecifiedOuterCopyWithImpl<$Res>
    implements $ClassicUnspecifiedOuterCopyWith<$Res> {
  _$ClassicUnspecifiedOuterCopyWithImpl(this._self, this._then);

  final ClassicUnspecifiedOuter _self;
  final $Res Function(ClassicUnspecifiedOuter) _then;

  /// Create a copy of ClassicUnspecifiedOuter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? innerData = freezed,
  }) {
    return _then(ClassicUnspecifiedOuter(
      innerData: freezed == innerData
          ? _self.innerData
          : innerData // ignore: cast_nullable_to_non_nullable
              as Inner<dynamic>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ClassicUnspecifiedOuter].
extension ClassicUnspecifiedOuterPatterns on ClassicUnspecifiedOuter {
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
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
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
  TResult map<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
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
  TResult? mapOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
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
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
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
  TResult when<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
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
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$R1212 {
  List<String>? get labels;
  Map<String, dynamic>? get data;

  /// Create a copy of R1212
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $R1212CopyWith<R1212> get copyWith =>
      _$R1212CopyWithImpl<R1212>(this as R1212, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is R1212 &&
            const DeepCollectionEquality().equals(other.labels, labels) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(labels),
      const DeepCollectionEquality().hash(data));

  @override
  String toString() {
    return 'R1212(labels: $labels, data: $data)';
  }
}

/// @nodoc
abstract mixin class $R1212CopyWith<$Res> {
  factory $R1212CopyWith(R1212 value, $Res Function(R1212) _then) =
      _$R1212CopyWithImpl;
  @useResult
  $Res call({List<String>? labels, Map<String, dynamic>? data});
}

/// @nodoc
class _$R1212CopyWithImpl<$Res> implements $R1212CopyWith<$Res> {
  _$R1212CopyWithImpl(this._self, this._then);

  final R1212 _self;
  final $Res Function(R1212) _then;

  /// Create a copy of R1212
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? labels = freezed,
    Object? data = freezed,
  }) {
    return _then(_self.copyWith(
      labels: freezed == labels
          ? _self.labels
          : labels // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [R1212].
extension R1212Patterns on R1212 {
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
    TResult Function(_R1212 value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _R1212() when $default != null:
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
    TResult Function(_R1212 value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _R1212():
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
    TResult? Function(_R1212 value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _R1212() when $default != null:
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
    TResult Function(List<String>? labels, Map<String, dynamic>? data)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _R1212() when $default != null:
        return $default(_that.labels, _that.data);
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
    TResult Function(List<String>? labels, Map<String, dynamic>? data) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _R1212():
        return $default(_that.labels, _that.data);
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
    TResult? Function(List<String>? labels, Map<String, dynamic>? data)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _R1212() when $default != null:
        return $default(_that.labels, _that.data);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _R1212 extends R1212 {
  _R1212({final List<String>? labels, final Map<String, dynamic>? data})
      : _labels = labels,
        _data = data,
        super._();

  final List<String>? _labels;
  @override
  List<String>? get labels {
    final value = _labels;
    if (value == null) return null;
    if (_labels is EqualUnmodifiableListView) return _labels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _data;
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Create a copy of R1212
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$R1212CopyWith<_R1212> get copyWith =>
      __$R1212CopyWithImpl<_R1212>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _R1212 &&
            const DeepCollectionEquality().equals(other._labels, _labels) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_labels),
      const DeepCollectionEquality().hash(_data));

  @override
  String toString() {
    return 'R1212(labels: $labels, data: $data)';
  }
}

/// @nodoc
abstract mixin class _$R1212CopyWith<$Res> implements $R1212CopyWith<$Res> {
  factory _$R1212CopyWith(_R1212 value, $Res Function(_R1212) _then) =
      __$R1212CopyWithImpl;
  @override
  @useResult
  $Res call({List<String>? labels, Map<String, dynamic>? data});
}

/// @nodoc
class __$R1212CopyWithImpl<$Res> implements _$R1212CopyWith<$Res> {
  __$R1212CopyWithImpl(this._self, this._then);

  final _R1212 _self;
  final $Res Function(_R1212) _then;

  /// Create a copy of R1212
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? labels = freezed,
    Object? data = freezed,
  }) {
    return _then(_R1212(
      labels: freezed == labels
          ? _self._labels
          : labels // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      data: freezed == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
mixin _$ImplementedClass {
  String get brand;

  /// Create a copy of ImplementedClass
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ImplementedClassCopyWith<ImplementedClass> get copyWith =>
      _$ImplementedClassCopyWithImpl<ImplementedClass>(
          this as ImplementedClass, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ImplementedClass &&
            (identical(other.brand, brand) || other.brand == brand));
  }

  @override
  int get hashCode => Object.hash(runtimeType, brand);

  @override
  String toString() {
    return 'ImplementedClass(brand: $brand)';
  }
}

/// @nodoc
abstract mixin class $ImplementedClassCopyWith<$Res> {
  factory $ImplementedClassCopyWith(
          ImplementedClass value, $Res Function(ImplementedClass) _then) =
      _$ImplementedClassCopyWithImpl;
  @useResult
  $Res call({String brand});
}

/// @nodoc
class _$ImplementedClassCopyWithImpl<$Res>
    implements $ImplementedClassCopyWith<$Res> {
  _$ImplementedClassCopyWithImpl(this._self, this._then);

  final ImplementedClass _self;
  final $Res Function(ImplementedClass) _then;

  /// Create a copy of ImplementedClass
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brand = null,
  }) {
    return _then(_self.copyWith(
      brand: null == brand
          ? _self.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ImplementedClass].
extension ImplementedClassPatterns on ImplementedClass {
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
    TResult Function(_ImplementedClass value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ImplementedClass() when $default != null:
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
    TResult Function(_ImplementedClass value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImplementedClass():
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
    TResult? Function(_ImplementedClass value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImplementedClass() when $default != null:
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
    TResult Function(String brand)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ImplementedClass() when $default != null:
        return $default(_that.brand);
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
    TResult Function(String brand) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImplementedClass():
        return $default(_that.brand);
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
    TResult? Function(String brand)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImplementedClass() when $default != null:
        return $default(_that.brand);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ImplementedClass implements ImplementedClass {
  _ImplementedClass({required this.brand});

  @override
  final String brand;

  /// Create a copy of ImplementedClass
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ImplementedClassCopyWith<_ImplementedClass> get copyWith =>
      __$ImplementedClassCopyWithImpl<_ImplementedClass>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ImplementedClass &&
            (identical(other.brand, brand) || other.brand == brand));
  }

  @override
  int get hashCode => Object.hash(runtimeType, brand);

  @override
  String toString() {
    return 'ImplementedClass(brand: $brand)';
  }
}

/// @nodoc
abstract mixin class _$ImplementedClassCopyWith<$Res>
    implements $ImplementedClassCopyWith<$Res> {
  factory _$ImplementedClassCopyWith(
          _ImplementedClass value, $Res Function(_ImplementedClass) _then) =
      __$ImplementedClassCopyWithImpl;
  @override
  @useResult
  $Res call({String brand});
}

/// @nodoc
class __$ImplementedClassCopyWithImpl<$Res>
    implements _$ImplementedClassCopyWith<$Res> {
  __$ImplementedClassCopyWithImpl(this._self, this._then);

  final _ImplementedClass _self;
  final $Res Function(_ImplementedClass) _then;

  /// Create a copy of ImplementedClass
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? brand = null,
  }) {
    return _then(_ImplementedClass(
      brand: null == brand
          ? _self.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$Vehicle {
  String get brand;

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VehicleCopyWith<Vehicle> get copyWith =>
      _$VehicleCopyWithImpl<Vehicle>(this as Vehicle, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Vehicle &&
            (identical(other.brand, brand) || other.brand == brand));
  }

  @override
  int get hashCode => Object.hash(runtimeType, brand);

  @override
  String toString() {
    return 'Vehicle(brand: $brand)';
  }
}

/// @nodoc
abstract mixin class $VehicleCopyWith<$Res> {
  factory $VehicleCopyWith(Vehicle value, $Res Function(Vehicle) _then) =
      _$VehicleCopyWithImpl;
  @useResult
  $Res call({String brand});
}

/// @nodoc
class _$VehicleCopyWithImpl<$Res> implements $VehicleCopyWith<$Res> {
  _$VehicleCopyWithImpl(this._self, this._then);

  final Vehicle _self;
  final $Res Function(Vehicle) _then;

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brand = null,
  }) {
    return _then(_self.copyWith(
      brand: null == brand
          ? _self.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [Vehicle].
extension VehiclePatterns on Vehicle {
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
    TResult Function(_Vehicle value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Vehicle() when $default != null:
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
    TResult Function(_Vehicle value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Vehicle():
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
    TResult? Function(_Vehicle value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Vehicle() when $default != null:
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
    TResult Function(String brand)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Vehicle() when $default != null:
        return $default(_that.brand);
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
    TResult Function(String brand) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Vehicle():
        return $default(_that.brand);
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
    TResult? Function(String brand)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Vehicle() when $default != null:
        return $default(_that.brand);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Vehicle extends Vehicle {
  _Vehicle({required this.brand}) : super._();

  @override
  final String brand;

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VehicleCopyWith<_Vehicle> get copyWith =>
      __$VehicleCopyWithImpl<_Vehicle>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Vehicle &&
            (identical(other.brand, brand) || other.brand == brand));
  }

  @override
  int get hashCode => Object.hash(runtimeType, brand);

  @override
  String toString() {
    return 'Vehicle(brand: $brand)';
  }
}

/// @nodoc
abstract mixin class _$VehicleCopyWith<$Res> implements $VehicleCopyWith<$Res> {
  factory _$VehicleCopyWith(_Vehicle value, $Res Function(_Vehicle) _then) =
      __$VehicleCopyWithImpl;
  @override
  @useResult
  $Res call({String brand});
}

/// @nodoc
class __$VehicleCopyWithImpl<$Res> implements _$VehicleCopyWith<$Res> {
  __$VehicleCopyWithImpl(this._self, this._then);

  final _Vehicle _self;
  final $Res Function(_Vehicle) _then;

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? brand = null,
  }) {
    return _then(_Vehicle(
      brand: null == brand
          ? _self.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$Car {
  String get brand;
  int get doors;

  /// Create a copy of Car
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CarCopyWith<Car> get copyWith =>
      _$CarCopyWithImpl<Car>(this as Car, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Car &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.doors, doors) || other.doors == doors));
  }

  @override
  int get hashCode => Object.hash(runtimeType, brand, doors);

  @override
  String toString() {
    return 'Car(brand: $brand, doors: $doors)';
  }
}

/// @nodoc
abstract mixin class $CarCopyWith<$Res>
    implements $VehicleCopyWith<$Res>, $ImplementedClassCopyWith<$Res> {
  factory $CarCopyWith(Car value, $Res Function(Car) _then) = _$CarCopyWithImpl;
  @useResult
  $Res call({String brand, int doors});
}

/// @nodoc
class _$CarCopyWithImpl<$Res> implements $CarCopyWith<$Res> {
  _$CarCopyWithImpl(this._self, this._then);

  final Car _self;
  final $Res Function(Car) _then;

  /// Create a copy of Car
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brand = null,
    Object? doors = null,
  }) {
    return _then(_self.copyWith(
      brand: null == brand
          ? _self.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      doors: null == doors
          ? _self.doors
          : doors // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [Car].
extension CarPatterns on Car {
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
    TResult Function(_Car value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Car() when $default != null:
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
    TResult Function(_Car value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Car():
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
    TResult? Function(_Car value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Car() when $default != null:
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
    TResult Function(String brand, int doors)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Car() when $default != null:
        return $default(_that.brand, _that.doors);
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
    TResult Function(String brand, int doors) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Car():
        return $default(_that.brand, _that.doors);
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
    TResult? Function(String brand, int doors)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Car() when $default != null:
        return $default(_that.brand, _that.doors);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Car extends Car {
  _Car({required this.brand, required this.doors}) : super._();

  @override
  final String brand;
  @override
  final int doors;

  /// Create a copy of Car
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CarCopyWith<_Car> get copyWith =>
      __$CarCopyWithImpl<_Car>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Car &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.doors, doors) || other.doors == doors));
  }

  @override
  int get hashCode => Object.hash(runtimeType, brand, doors);

  @override
  String toString() {
    return 'Car(brand: $brand, doors: $doors)';
  }
}

/// @nodoc
abstract mixin class _$CarCopyWith<$Res> implements $CarCopyWith<$Res> {
  factory _$CarCopyWith(_Car value, $Res Function(_Car) _then) =
      __$CarCopyWithImpl;
  @override
  @useResult
  $Res call({String brand, int doors});
}

/// @nodoc
class __$CarCopyWithImpl<$Res> implements _$CarCopyWith<$Res> {
  __$CarCopyWithImpl(this._self, this._then);

  final _Car _self;
  final $Res Function(_Car) _then;

  /// Create a copy of Car
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? brand = null,
    Object? doors = null,
  }) {
    return _then(_Car(
      brand: null == brand
          ? _self.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      doors: null == doors
          ? _self.doors
          : doors // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$Subclass {
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
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Subclass value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Subclass() when $default != null:
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
    TResult Function(_Subclass value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Subclass():
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
    TResult? Function(_Subclass value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Subclass() when $default != null:
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
      case _Subclass() when $default != null:
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
      case _Subclass():
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
      case _Subclass() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Subclass extends Subclass {
  const _Subclass(final int value) : super._(value);

  /// Create a copy of Subclass
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SubclassCopyWith<_Subclass> get copyWith =>
      __$SubclassCopyWithImpl<_Subclass>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Subclass &&
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
abstract mixin class _$SubclassCopyWith<$Res>
    implements $SubclassCopyWith<$Res> {
  factory _$SubclassCopyWith(_Subclass value, $Res Function(_Subclass) _then) =
      __$SubclassCopyWithImpl;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$SubclassCopyWithImpl<$Res> implements _$SubclassCopyWith<$Res> {
  __$SubclassCopyWithImpl(this._self, this._then);

  final _Subclass _self;
  final $Res Function(_Subclass) _then;

  /// Create a copy of Subclass
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_Subclass(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$Dynamic {
  dynamic get foo;
  dynamic? get bar;

  /// Create a copy of Dynamic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DynamicCopyWith<Dynamic> get copyWith =>
      _$DynamicCopyWithImpl<Dynamic>(this as Dynamic, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Dynamic &&
            const DeepCollectionEquality().equals(other.foo, foo) &&
            const DeepCollectionEquality().equals(other.bar, bar));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(foo),
      const DeepCollectionEquality().hash(bar));

  @override
  String toString() {
    return 'Dynamic(foo: $foo, bar: $bar)';
  }
}

/// @nodoc
abstract mixin class $DynamicCopyWith<$Res> {
  factory $DynamicCopyWith(Dynamic value, $Res Function(Dynamic) _then) =
      _$DynamicCopyWithImpl;
  @useResult
  $Res call({dynamic foo, dynamic? bar});
}

/// @nodoc
class _$DynamicCopyWithImpl<$Res> implements $DynamicCopyWith<$Res> {
  _$DynamicCopyWithImpl(this._self, this._then);

  final Dynamic _self;
  final $Res Function(Dynamic) _then;

  /// Create a copy of Dynamic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? foo = freezed,
    Object? bar = freezed,
  }) {
    return _then(_self.copyWith(
      foo: freezed == foo
          ? _self.foo
          : foo // ignore: cast_nullable_to_non_nullable
              as dynamic,
      bar: freezed == bar
          ? _self.bar
          : bar // ignore: cast_nullable_to_non_nullable
              as dynamic?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Dynamic].
extension DynamicPatterns on Dynamic {
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
    TResult Function(DynamicFirst value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case DynamicFirst() when $default != null:
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
    TResult Function(DynamicFirst value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case DynamicFirst():
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
    TResult? Function(DynamicFirst value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case DynamicFirst() when $default != null:
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
    TResult Function(dynamic foo, dynamic? bar)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case DynamicFirst() when $default != null:
        return $default(_that.foo, _that.bar);
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
    TResult Function(dynamic foo, dynamic? bar) $default,
  ) {
    final _that = this;
    switch (_that) {
      case DynamicFirst():
        return $default(_that.foo, _that.bar);
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
    TResult? Function(dynamic foo, dynamic? bar)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case DynamicFirst() when $default != null:
        return $default(_that.foo, _that.bar);
      case _:
        return null;
    }
  }
}

/// @nodoc

class DynamicFirst implements Dynamic {
  DynamicFirst({this.foo, this.bar});

  @override
  final dynamic foo;
  @override
  final dynamic? bar;

  /// Create a copy of Dynamic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DynamicFirstCopyWith<DynamicFirst> get copyWith =>
      _$DynamicFirstCopyWithImpl<DynamicFirst>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DynamicFirst &&
            const DeepCollectionEquality().equals(other.foo, foo) &&
            const DeepCollectionEquality().equals(other.bar, bar));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(foo),
      const DeepCollectionEquality().hash(bar));

  @override
  String toString() {
    return 'Dynamic(foo: $foo, bar: $bar)';
  }
}

/// @nodoc
abstract mixin class $DynamicFirstCopyWith<$Res>
    implements $DynamicCopyWith<$Res> {
  factory $DynamicFirstCopyWith(
          DynamicFirst value, $Res Function(DynamicFirst) _then) =
      _$DynamicFirstCopyWithImpl;
  @override
  @useResult
  $Res call({dynamic foo, dynamic? bar});
}

/// @nodoc
class _$DynamicFirstCopyWithImpl<$Res> implements $DynamicFirstCopyWith<$Res> {
  _$DynamicFirstCopyWithImpl(this._self, this._then);

  final DynamicFirst _self;
  final $Res Function(DynamicFirst) _then;

  /// Create a copy of Dynamic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? foo = freezed,
    Object? bar = freezed,
  }) {
    return _then(DynamicFirst(
      foo: freezed == foo
          ? _self.foo
          : foo // ignore: cast_nullable_to_non_nullable
              as dynamic,
      bar: freezed == bar
          ? _self.bar
          : bar // ignore: cast_nullable_to_non_nullable
              as dynamic?,
    ));
  }
}

/// @nodoc
mixin _$CustomListEqual {
  CustomList<int> get list;

  /// Create a copy of CustomListEqual
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomListEqualCopyWith<CustomListEqual> get copyWith =>
      _$CustomListEqualCopyWithImpl<CustomListEqual>(
          this as CustomListEqual, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomListEqual &&
            const DeepCollectionEquality().equals(other.list, list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(list));

  @override
  String toString() {
    return 'CustomListEqual(list: $list)';
  }
}

/// @nodoc
abstract mixin class $CustomListEqualCopyWith<$Res> {
  factory $CustomListEqualCopyWith(
          CustomListEqual value, $Res Function(CustomListEqual) _then) =
      _$CustomListEqualCopyWithImpl;
  @useResult
  $Res call({CustomList<int> list});
}

/// @nodoc
class _$CustomListEqualCopyWithImpl<$Res>
    implements $CustomListEqualCopyWith<$Res> {
  _$CustomListEqualCopyWithImpl(this._self, this._then);

  final CustomListEqual _self;
  final $Res Function(CustomListEqual) _then;

  /// Create a copy of CustomListEqual
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
  }) {
    return _then(_self.copyWith(
      list: null == list
          ? _self.list
          : list // ignore: cast_nullable_to_non_nullable
              as CustomList<int>,
    ));
  }
}

/// Adds pattern-matching-related methods to [CustomListEqual].
extension CustomListEqualPatterns on CustomListEqual {
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
    TResult Function(CustomListEqualFirst value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CustomListEqualFirst() when $default != null:
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
    TResult Function(CustomListEqualFirst value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case CustomListEqualFirst():
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
    TResult? Function(CustomListEqualFirst value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case CustomListEqualFirst() when $default != null:
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
    TResult Function(CustomList<int> list)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CustomListEqualFirst() when $default != null:
        return $default(_that.list);
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
    TResult Function(CustomList<int> list) $default,
  ) {
    final _that = this;
    switch (_that) {
      case CustomListEqualFirst():
        return $default(_that.list);
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
    TResult? Function(CustomList<int> list)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case CustomListEqualFirst() when $default != null:
        return $default(_that.list);
      case _:
        return null;
    }
  }
}

/// @nodoc

class CustomListEqualFirst implements CustomListEqual {
  CustomListEqualFirst(this.list);

  @override
  final CustomList<int> list;

  /// Create a copy of CustomListEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomListEqualFirstCopyWith<CustomListEqualFirst> get copyWith =>
      _$CustomListEqualFirstCopyWithImpl<CustomListEqualFirst>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomListEqualFirst &&
            const DeepCollectionEquality().equals(other.list, list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(list));

  @override
  String toString() {
    return 'CustomListEqual(list: $list)';
  }
}

/// @nodoc
abstract mixin class $CustomListEqualFirstCopyWith<$Res>
    implements $CustomListEqualCopyWith<$Res> {
  factory $CustomListEqualFirstCopyWith(CustomListEqualFirst value,
          $Res Function(CustomListEqualFirst) _then) =
      _$CustomListEqualFirstCopyWithImpl;
  @override
  @useResult
  $Res call({CustomList<int> list});
}

/// @nodoc
class _$CustomListEqualFirstCopyWithImpl<$Res>
    implements $CustomListEqualFirstCopyWith<$Res> {
  _$CustomListEqualFirstCopyWithImpl(this._self, this._then);

  final CustomListEqualFirst _self;
  final $Res Function(CustomListEqualFirst) _then;

  /// Create a copy of CustomListEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? list = null,
  }) {
    return _then(CustomListEqualFirst(
      null == list
          ? _self.list
          : list // ignore: cast_nullable_to_non_nullable
              as CustomList<int>,
    ));
  }
}

/// @nodoc
mixin _$ListEqual {
  List<int> get list;

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
            const DeepCollectionEquality().equals(other.list, list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(list));

  @override
  String toString() {
    return 'ListEqual(list: $list)';
  }
}

/// @nodoc
abstract mixin class $ListEqualCopyWith<$Res> {
  factory $ListEqualCopyWith(ListEqual value, $Res Function(ListEqual) _then) =
      _$ListEqualCopyWithImpl;
  @useResult
  $Res call({List<int> list});
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
    Object? list = null,
  }) {
    return _then(_self.copyWith(
      list: null == list
          ? _self.list
          : list // ignore: cast_nullable_to_non_nullable
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
    TResult Function(ListEqualFirst value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ListEqualFirst() when $default != null:
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
    TResult Function(ListEqualFirst value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case ListEqualFirst():
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
    TResult? Function(ListEqualFirst value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case ListEqualFirst() when $default != null:
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
    TResult Function(List<int> list)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ListEqualFirst() when $default != null:
        return $default(_that.list);
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
    TResult Function(List<int> list) $default,
  ) {
    final _that = this;
    switch (_that) {
      case ListEqualFirst():
        return $default(_that.list);
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
    TResult? Function(List<int> list)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case ListEqualFirst() when $default != null:
        return $default(_that.list);
      case _:
        return null;
    }
  }
}

/// @nodoc

class ListEqualFirst implements ListEqual {
  ListEqualFirst(this.list);

  @override
  final List<int> list;

  /// Create a copy of ListEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ListEqualFirstCopyWith<ListEqualFirst> get copyWith =>
      _$ListEqualFirstCopyWithImpl<ListEqualFirst>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ListEqualFirst &&
            const DeepCollectionEquality().equals(other.list, list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(list));

  @override
  String toString() {
    return 'ListEqual(list: $list)';
  }
}

/// @nodoc
abstract mixin class $ListEqualFirstCopyWith<$Res>
    implements $ListEqualCopyWith<$Res> {
  factory $ListEqualFirstCopyWith(
          ListEqualFirst value, $Res Function(ListEqualFirst) _then) =
      _$ListEqualFirstCopyWithImpl;
  @override
  @useResult
  $Res call({List<int> list});
}

/// @nodoc
class _$ListEqualFirstCopyWithImpl<$Res>
    implements $ListEqualFirstCopyWith<$Res> {
  _$ListEqualFirstCopyWithImpl(this._self, this._then);

  final ListEqualFirst _self;
  final $Res Function(ListEqualFirst) _then;

  /// Create a copy of ListEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? list = null,
  }) {
    return _then(ListEqualFirst(
      null == list
          ? _self.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
mixin _$UnmodifiableListEqual {
  List<int> get list;

  /// Create a copy of UnmodifiableListEqual
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnmodifiableListEqualCopyWith<UnmodifiableListEqual> get copyWith =>
      _$UnmodifiableListEqualCopyWithImpl<UnmodifiableListEqual>(
          this as UnmodifiableListEqual, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnmodifiableListEqual &&
            const DeepCollectionEquality().equals(other.list, list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(list));

  @override
  String toString() {
    return 'UnmodifiableListEqual(list: $list)';
  }
}

/// @nodoc
abstract mixin class $UnmodifiableListEqualCopyWith<$Res> {
  factory $UnmodifiableListEqualCopyWith(UnmodifiableListEqual value,
          $Res Function(UnmodifiableListEqual) _then) =
      _$UnmodifiableListEqualCopyWithImpl;
  @useResult
  $Res call({List<int> list});
}

/// @nodoc
class _$UnmodifiableListEqualCopyWithImpl<$Res>
    implements $UnmodifiableListEqualCopyWith<$Res> {
  _$UnmodifiableListEqualCopyWithImpl(this._self, this._then);

  final UnmodifiableListEqual _self;
  final $Res Function(UnmodifiableListEqual) _then;

  /// Create a copy of UnmodifiableListEqual
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
  }) {
    return _then(_self.copyWith(
      list: null == list
          ? _self.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// Adds pattern-matching-related methods to [UnmodifiableListEqual].
extension UnmodifiableListEqualPatterns on UnmodifiableListEqual {
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
    TResult Function(UnmodifiableListEqualFirst value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case UnmodifiableListEqualFirst() when $default != null:
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
    TResult Function(UnmodifiableListEqualFirst value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case UnmodifiableListEqualFirst():
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
    TResult? Function(UnmodifiableListEqualFirst value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case UnmodifiableListEqualFirst() when $default != null:
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
    TResult Function(List<int> list)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case UnmodifiableListEqualFirst() when $default != null:
        return $default(_that.list);
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
    TResult Function(List<int> list) $default,
  ) {
    final _that = this;
    switch (_that) {
      case UnmodifiableListEqualFirst():
        return $default(_that.list);
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
    TResult? Function(List<int> list)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case UnmodifiableListEqualFirst() when $default != null:
        return $default(_that.list);
      case _:
        return null;
    }
  }
}

/// @nodoc

class UnmodifiableListEqualFirst implements UnmodifiableListEqual {
  UnmodifiableListEqualFirst(final List<int> list) : _list = list;

  final List<int> _list;
  @override
  List<int> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  /// Create a copy of UnmodifiableListEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnmodifiableListEqualFirstCopyWith<UnmodifiableListEqualFirst>
      get copyWith =>
          _$UnmodifiableListEqualFirstCopyWithImpl<UnmodifiableListEqualFirst>(
              this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnmodifiableListEqualFirst &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_list));

  @override
  String toString() {
    return 'UnmodifiableListEqual(list: $list)';
  }
}

/// @nodoc
abstract mixin class $UnmodifiableListEqualFirstCopyWith<$Res>
    implements $UnmodifiableListEqualCopyWith<$Res> {
  factory $UnmodifiableListEqualFirstCopyWith(UnmodifiableListEqualFirst value,
          $Res Function(UnmodifiableListEqualFirst) _then) =
      _$UnmodifiableListEqualFirstCopyWithImpl;
  @override
  @useResult
  $Res call({List<int> list});
}

/// @nodoc
class _$UnmodifiableListEqualFirstCopyWithImpl<$Res>
    implements $UnmodifiableListEqualFirstCopyWith<$Res> {
  _$UnmodifiableListEqualFirstCopyWithImpl(this._self, this._then);

  final UnmodifiableListEqualFirst _self;
  final $Res Function(UnmodifiableListEqualFirst) _then;

  /// Create a copy of UnmodifiableListEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? list = null,
  }) {
    return _then(UnmodifiableListEqualFirst(
      null == list
          ? _self._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
mixin _$NullUnmodifiableListEqual {
  List<int>? get list;

  /// Create a copy of NullUnmodifiableListEqual
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NullUnmodifiableListEqualCopyWith<NullUnmodifiableListEqual> get copyWith =>
      _$NullUnmodifiableListEqualCopyWithImpl<NullUnmodifiableListEqual>(
          this as NullUnmodifiableListEqual, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NullUnmodifiableListEqual &&
            const DeepCollectionEquality().equals(other.list, list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(list));

  @override
  String toString() {
    return 'NullUnmodifiableListEqual(list: $list)';
  }
}

/// @nodoc
abstract mixin class $NullUnmodifiableListEqualCopyWith<$Res> {
  factory $NullUnmodifiableListEqualCopyWith(NullUnmodifiableListEqual value,
          $Res Function(NullUnmodifiableListEqual) _then) =
      _$NullUnmodifiableListEqualCopyWithImpl;
  @useResult
  $Res call({List<int>? list});
}

/// @nodoc
class _$NullUnmodifiableListEqualCopyWithImpl<$Res>
    implements $NullUnmodifiableListEqualCopyWith<$Res> {
  _$NullUnmodifiableListEqualCopyWithImpl(this._self, this._then);

  final NullUnmodifiableListEqual _self;
  final $Res Function(NullUnmodifiableListEqual) _then;

  /// Create a copy of NullUnmodifiableListEqual
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = freezed,
  }) {
    return _then(_self.copyWith(
      list: freezed == list
          ? _self.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [NullUnmodifiableListEqual].
extension NullUnmodifiableListEqualPatterns on NullUnmodifiableListEqual {
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
    TResult Function(NullUnmodifiableListEqualFirst value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case NullUnmodifiableListEqualFirst() when $default != null:
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
    TResult Function(NullUnmodifiableListEqualFirst value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case NullUnmodifiableListEqualFirst():
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
    TResult? Function(NullUnmodifiableListEqualFirst value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case NullUnmodifiableListEqualFirst() when $default != null:
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
    TResult Function(List<int>? list)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case NullUnmodifiableListEqualFirst() when $default != null:
        return $default(_that.list);
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
    TResult Function(List<int>? list) $default,
  ) {
    final _that = this;
    switch (_that) {
      case NullUnmodifiableListEqualFirst():
        return $default(_that.list);
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
    TResult? Function(List<int>? list)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case NullUnmodifiableListEqualFirst() when $default != null:
        return $default(_that.list);
      case _:
        return null;
    }
  }
}

/// @nodoc

class NullUnmodifiableListEqualFirst implements NullUnmodifiableListEqual {
  NullUnmodifiableListEqualFirst(final List<int>? list) : _list = list;

  final List<int>? _list;
  @override
  List<int>? get list {
    final value = _list;
    if (value == null) return null;
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of NullUnmodifiableListEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NullUnmodifiableListEqualFirstCopyWith<NullUnmodifiableListEqualFirst>
      get copyWith => _$NullUnmodifiableListEqualFirstCopyWithImpl<
          NullUnmodifiableListEqualFirst>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NullUnmodifiableListEqualFirst &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_list));

  @override
  String toString() {
    return 'NullUnmodifiableListEqual(list: $list)';
  }
}

/// @nodoc
abstract mixin class $NullUnmodifiableListEqualFirstCopyWith<$Res>
    implements $NullUnmodifiableListEqualCopyWith<$Res> {
  factory $NullUnmodifiableListEqualFirstCopyWith(
          NullUnmodifiableListEqualFirst value,
          $Res Function(NullUnmodifiableListEqualFirst) _then) =
      _$NullUnmodifiableListEqualFirstCopyWithImpl;
  @override
  @useResult
  $Res call({List<int>? list});
}

/// @nodoc
class _$NullUnmodifiableListEqualFirstCopyWithImpl<$Res>
    implements $NullUnmodifiableListEqualFirstCopyWith<$Res> {
  _$NullUnmodifiableListEqualFirstCopyWithImpl(this._self, this._then);

  final NullUnmodifiableListEqualFirst _self;
  final $Res Function(NullUnmodifiableListEqualFirst) _then;

  /// Create a copy of NullUnmodifiableListEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? list = freezed,
  }) {
    return _then(NullUnmodifiableListEqualFirst(
      freezed == list
          ? _self._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc
mixin _$CustomSetEqual {
  CustomSet<int> get dartSet;

  /// Create a copy of CustomSetEqual
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomSetEqualCopyWith<CustomSetEqual> get copyWith =>
      _$CustomSetEqualCopyWithImpl<CustomSetEqual>(
          this as CustomSetEqual, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomSetEqual &&
            const DeepCollectionEquality().equals(other.dartSet, dartSet));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(dartSet));

  @override
  String toString() {
    return 'CustomSetEqual(dartSet: $dartSet)';
  }
}

/// @nodoc
abstract mixin class $CustomSetEqualCopyWith<$Res> {
  factory $CustomSetEqualCopyWith(
          CustomSetEqual value, $Res Function(CustomSetEqual) _then) =
      _$CustomSetEqualCopyWithImpl;
  @useResult
  $Res call({CustomSet<int> dartSet});
}

/// @nodoc
class _$CustomSetEqualCopyWithImpl<$Res>
    implements $CustomSetEqualCopyWith<$Res> {
  _$CustomSetEqualCopyWithImpl(this._self, this._then);

  final CustomSetEqual _self;
  final $Res Function(CustomSetEqual) _then;

  /// Create a copy of CustomSetEqual
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dartSet = null,
  }) {
    return _then(_self.copyWith(
      dartSet: null == dartSet
          ? _self.dartSet
          : dartSet // ignore: cast_nullable_to_non_nullable
              as CustomSet<int>,
    ));
  }
}

/// Adds pattern-matching-related methods to [CustomSetEqual].
extension CustomSetEqualPatterns on CustomSetEqual {
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
    TResult Function(CustomSetEqualFirst value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CustomSetEqualFirst() when $default != null:
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
    TResult Function(CustomSetEqualFirst value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case CustomSetEqualFirst():
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
    TResult? Function(CustomSetEqualFirst value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case CustomSetEqualFirst() when $default != null:
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
    TResult Function(CustomSet<int> dartSet)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CustomSetEqualFirst() when $default != null:
        return $default(_that.dartSet);
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
    TResult Function(CustomSet<int> dartSet) $default,
  ) {
    final _that = this;
    switch (_that) {
      case CustomSetEqualFirst():
        return $default(_that.dartSet);
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
    TResult? Function(CustomSet<int> dartSet)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case CustomSetEqualFirst() when $default != null:
        return $default(_that.dartSet);
      case _:
        return null;
    }
  }
}

/// @nodoc

class CustomSetEqualFirst implements CustomSetEqual {
  CustomSetEqualFirst(this.dartSet);

  @override
  final CustomSet<int> dartSet;

  /// Create a copy of CustomSetEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomSetEqualFirstCopyWith<CustomSetEqualFirst> get copyWith =>
      _$CustomSetEqualFirstCopyWithImpl<CustomSetEqualFirst>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomSetEqualFirst &&
            const DeepCollectionEquality().equals(other.dartSet, dartSet));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(dartSet));

  @override
  String toString() {
    return 'CustomSetEqual(dartSet: $dartSet)';
  }
}

/// @nodoc
abstract mixin class $CustomSetEqualFirstCopyWith<$Res>
    implements $CustomSetEqualCopyWith<$Res> {
  factory $CustomSetEqualFirstCopyWith(
          CustomSetEqualFirst value, $Res Function(CustomSetEqualFirst) _then) =
      _$CustomSetEqualFirstCopyWithImpl;
  @override
  @useResult
  $Res call({CustomSet<int> dartSet});
}

/// @nodoc
class _$CustomSetEqualFirstCopyWithImpl<$Res>
    implements $CustomSetEqualFirstCopyWith<$Res> {
  _$CustomSetEqualFirstCopyWithImpl(this._self, this._then);

  final CustomSetEqualFirst _self;
  final $Res Function(CustomSetEqualFirst) _then;

  /// Create a copy of CustomSetEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? dartSet = null,
  }) {
    return _then(CustomSetEqualFirst(
      null == dartSet
          ? _self.dartSet
          : dartSet // ignore: cast_nullable_to_non_nullable
              as CustomSet<int>,
    ));
  }
}

/// @nodoc
mixin _$SetEqual {
  Set<int> get dartSet;

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
            const DeepCollectionEquality().equals(other.dartSet, dartSet));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(dartSet));

  @override
  String toString() {
    return 'SetEqual(dartSet: $dartSet)';
  }
}

/// @nodoc
abstract mixin class $SetEqualCopyWith<$Res> {
  factory $SetEqualCopyWith(SetEqual value, $Res Function(SetEqual) _then) =
      _$SetEqualCopyWithImpl;
  @useResult
  $Res call({Set<int> dartSet});
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
    Object? dartSet = null,
  }) {
    return _then(_self.copyWith(
      dartSet: null == dartSet
          ? _self.dartSet
          : dartSet // ignore: cast_nullable_to_non_nullable
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
    TResult Function(SetEqualFirst value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SetEqualFirst() when $default != null:
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
    TResult Function(SetEqualFirst value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case SetEqualFirst():
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
    TResult? Function(SetEqualFirst value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case SetEqualFirst() when $default != null:
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
    TResult Function(Set<int> dartSet)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SetEqualFirst() when $default != null:
        return $default(_that.dartSet);
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
    TResult Function(Set<int> dartSet) $default,
  ) {
    final _that = this;
    switch (_that) {
      case SetEqualFirst():
        return $default(_that.dartSet);
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
    TResult? Function(Set<int> dartSet)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case SetEqualFirst() when $default != null:
        return $default(_that.dartSet);
      case _:
        return null;
    }
  }
}

/// @nodoc

class SetEqualFirst implements SetEqual {
  SetEqualFirst(this.dartSet);

  @override
  final Set<int> dartSet;

  /// Create a copy of SetEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SetEqualFirstCopyWith<SetEqualFirst> get copyWith =>
      _$SetEqualFirstCopyWithImpl<SetEqualFirst>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SetEqualFirst &&
            const DeepCollectionEquality().equals(other.dartSet, dartSet));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(dartSet));

  @override
  String toString() {
    return 'SetEqual(dartSet: $dartSet)';
  }
}

/// @nodoc
abstract mixin class $SetEqualFirstCopyWith<$Res>
    implements $SetEqualCopyWith<$Res> {
  factory $SetEqualFirstCopyWith(
          SetEqualFirst value, $Res Function(SetEqualFirst) _then) =
      _$SetEqualFirstCopyWithImpl;
  @override
  @useResult
  $Res call({Set<int> dartSet});
}

/// @nodoc
class _$SetEqualFirstCopyWithImpl<$Res>
    implements $SetEqualFirstCopyWith<$Res> {
  _$SetEqualFirstCopyWithImpl(this._self, this._then);

  final SetEqualFirst _self;
  final $Res Function(SetEqualFirst) _then;

  /// Create a copy of SetEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? dartSet = null,
  }) {
    return _then(SetEqualFirst(
      null == dartSet
          ? _self.dartSet
          : dartSet // ignore: cast_nullable_to_non_nullable
              as Set<int>,
    ));
  }
}

/// @nodoc
mixin _$UnmodifiableSetEqual {
  Set<int> get dartSet;

  /// Create a copy of UnmodifiableSetEqual
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnmodifiableSetEqualCopyWith<UnmodifiableSetEqual> get copyWith =>
      _$UnmodifiableSetEqualCopyWithImpl<UnmodifiableSetEqual>(
          this as UnmodifiableSetEqual, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnmodifiableSetEqual &&
            const DeepCollectionEquality().equals(other.dartSet, dartSet));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(dartSet));

  @override
  String toString() {
    return 'UnmodifiableSetEqual(dartSet: $dartSet)';
  }
}

/// @nodoc
abstract mixin class $UnmodifiableSetEqualCopyWith<$Res> {
  factory $UnmodifiableSetEqualCopyWith(UnmodifiableSetEqual value,
          $Res Function(UnmodifiableSetEqual) _then) =
      _$UnmodifiableSetEqualCopyWithImpl;
  @useResult
  $Res call({Set<int> dartSet});
}

/// @nodoc
class _$UnmodifiableSetEqualCopyWithImpl<$Res>
    implements $UnmodifiableSetEqualCopyWith<$Res> {
  _$UnmodifiableSetEqualCopyWithImpl(this._self, this._then);

  final UnmodifiableSetEqual _self;
  final $Res Function(UnmodifiableSetEqual) _then;

  /// Create a copy of UnmodifiableSetEqual
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dartSet = null,
  }) {
    return _then(_self.copyWith(
      dartSet: null == dartSet
          ? _self.dartSet
          : dartSet // ignore: cast_nullable_to_non_nullable
              as Set<int>,
    ));
  }
}

/// Adds pattern-matching-related methods to [UnmodifiableSetEqual].
extension UnmodifiableSetEqualPatterns on UnmodifiableSetEqual {
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
    TResult Function(UnmodifiableSetEqualFirst value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case UnmodifiableSetEqualFirst() when $default != null:
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
    TResult Function(UnmodifiableSetEqualFirst value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case UnmodifiableSetEqualFirst():
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
    TResult? Function(UnmodifiableSetEqualFirst value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case UnmodifiableSetEqualFirst() when $default != null:
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
    TResult Function(Set<int> dartSet)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case UnmodifiableSetEqualFirst() when $default != null:
        return $default(_that.dartSet);
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
    TResult Function(Set<int> dartSet) $default,
  ) {
    final _that = this;
    switch (_that) {
      case UnmodifiableSetEqualFirst():
        return $default(_that.dartSet);
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
    TResult? Function(Set<int> dartSet)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case UnmodifiableSetEqualFirst() when $default != null:
        return $default(_that.dartSet);
      case _:
        return null;
    }
  }
}

/// @nodoc

class UnmodifiableSetEqualFirst implements UnmodifiableSetEqual {
  UnmodifiableSetEqualFirst(final Set<int> dartSet) : _dartSet = dartSet;

  final Set<int> _dartSet;
  @override
  Set<int> get dartSet {
    if (_dartSet is EqualUnmodifiableSetView) return _dartSet;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_dartSet);
  }

  /// Create a copy of UnmodifiableSetEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnmodifiableSetEqualFirstCopyWith<UnmodifiableSetEqualFirst> get copyWith =>
      _$UnmodifiableSetEqualFirstCopyWithImpl<UnmodifiableSetEqualFirst>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnmodifiableSetEqualFirst &&
            const DeepCollectionEquality().equals(other._dartSet, _dartSet));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_dartSet));

  @override
  String toString() {
    return 'UnmodifiableSetEqual(dartSet: $dartSet)';
  }
}

/// @nodoc
abstract mixin class $UnmodifiableSetEqualFirstCopyWith<$Res>
    implements $UnmodifiableSetEqualCopyWith<$Res> {
  factory $UnmodifiableSetEqualFirstCopyWith(UnmodifiableSetEqualFirst value,
          $Res Function(UnmodifiableSetEqualFirst) _then) =
      _$UnmodifiableSetEqualFirstCopyWithImpl;
  @override
  @useResult
  $Res call({Set<int> dartSet});
}

/// @nodoc
class _$UnmodifiableSetEqualFirstCopyWithImpl<$Res>
    implements $UnmodifiableSetEqualFirstCopyWith<$Res> {
  _$UnmodifiableSetEqualFirstCopyWithImpl(this._self, this._then);

  final UnmodifiableSetEqualFirst _self;
  final $Res Function(UnmodifiableSetEqualFirst) _then;

  /// Create a copy of UnmodifiableSetEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? dartSet = null,
  }) {
    return _then(UnmodifiableSetEqualFirst(
      null == dartSet
          ? _self._dartSet
          : dartSet // ignore: cast_nullable_to_non_nullable
              as Set<int>,
    ));
  }
}

/// @nodoc
mixin _$NullUnmodifiableSetEqual {
  Set<int>? get dartSet;

  /// Create a copy of NullUnmodifiableSetEqual
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NullUnmodifiableSetEqualCopyWith<NullUnmodifiableSetEqual> get copyWith =>
      _$NullUnmodifiableSetEqualCopyWithImpl<NullUnmodifiableSetEqual>(
          this as NullUnmodifiableSetEqual, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NullUnmodifiableSetEqual &&
            const DeepCollectionEquality().equals(other.dartSet, dartSet));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(dartSet));

  @override
  String toString() {
    return 'NullUnmodifiableSetEqual(dartSet: $dartSet)';
  }
}

/// @nodoc
abstract mixin class $NullUnmodifiableSetEqualCopyWith<$Res> {
  factory $NullUnmodifiableSetEqualCopyWith(NullUnmodifiableSetEqual value,
          $Res Function(NullUnmodifiableSetEqual) _then) =
      _$NullUnmodifiableSetEqualCopyWithImpl;
  @useResult
  $Res call({Set<int>? dartSet});
}

/// @nodoc
class _$NullUnmodifiableSetEqualCopyWithImpl<$Res>
    implements $NullUnmodifiableSetEqualCopyWith<$Res> {
  _$NullUnmodifiableSetEqualCopyWithImpl(this._self, this._then);

  final NullUnmodifiableSetEqual _self;
  final $Res Function(NullUnmodifiableSetEqual) _then;

  /// Create a copy of NullUnmodifiableSetEqual
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dartSet = freezed,
  }) {
    return _then(_self.copyWith(
      dartSet: freezed == dartSet
          ? _self.dartSet
          : dartSet // ignore: cast_nullable_to_non_nullable
              as Set<int>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [NullUnmodifiableSetEqual].
extension NullUnmodifiableSetEqualPatterns on NullUnmodifiableSetEqual {
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
    TResult Function(NullUnmodifiableSetEqualFirst value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case NullUnmodifiableSetEqualFirst() when $default != null:
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
    TResult Function(NullUnmodifiableSetEqualFirst value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case NullUnmodifiableSetEqualFirst():
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
    TResult? Function(NullUnmodifiableSetEqualFirst value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case NullUnmodifiableSetEqualFirst() when $default != null:
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
    TResult Function(Set<int>? dartSet)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case NullUnmodifiableSetEqualFirst() when $default != null:
        return $default(_that.dartSet);
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
    TResult Function(Set<int>? dartSet) $default,
  ) {
    final _that = this;
    switch (_that) {
      case NullUnmodifiableSetEqualFirst():
        return $default(_that.dartSet);
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
    TResult? Function(Set<int>? dartSet)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case NullUnmodifiableSetEqualFirst() when $default != null:
        return $default(_that.dartSet);
      case _:
        return null;
    }
  }
}

/// @nodoc

class NullUnmodifiableSetEqualFirst implements NullUnmodifiableSetEqual {
  NullUnmodifiableSetEqualFirst(final Set<int>? dartSet) : _dartSet = dartSet;

  final Set<int>? _dartSet;
  @override
  Set<int>? get dartSet {
    final value = _dartSet;
    if (value == null) return null;
    if (_dartSet is EqualUnmodifiableSetView) return _dartSet;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(value);
  }

  /// Create a copy of NullUnmodifiableSetEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NullUnmodifiableSetEqualFirstCopyWith<NullUnmodifiableSetEqualFirst>
      get copyWith => _$NullUnmodifiableSetEqualFirstCopyWithImpl<
          NullUnmodifiableSetEqualFirst>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NullUnmodifiableSetEqualFirst &&
            const DeepCollectionEquality().equals(other._dartSet, _dartSet));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_dartSet));

  @override
  String toString() {
    return 'NullUnmodifiableSetEqual(dartSet: $dartSet)';
  }
}

/// @nodoc
abstract mixin class $NullUnmodifiableSetEqualFirstCopyWith<$Res>
    implements $NullUnmodifiableSetEqualCopyWith<$Res> {
  factory $NullUnmodifiableSetEqualFirstCopyWith(
          NullUnmodifiableSetEqualFirst value,
          $Res Function(NullUnmodifiableSetEqualFirst) _then) =
      _$NullUnmodifiableSetEqualFirstCopyWithImpl;
  @override
  @useResult
  $Res call({Set<int>? dartSet});
}

/// @nodoc
class _$NullUnmodifiableSetEqualFirstCopyWithImpl<$Res>
    implements $NullUnmodifiableSetEqualFirstCopyWith<$Res> {
  _$NullUnmodifiableSetEqualFirstCopyWithImpl(this._self, this._then);

  final NullUnmodifiableSetEqualFirst _self;
  final $Res Function(NullUnmodifiableSetEqualFirst) _then;

  /// Create a copy of NullUnmodifiableSetEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? dartSet = freezed,
  }) {
    return _then(NullUnmodifiableSetEqualFirst(
      freezed == dartSet
          ? _self._dartSet
          : dartSet // ignore: cast_nullable_to_non_nullable
              as Set<int>?,
    ));
  }
}

/// @nodoc
mixin _$CustomMapEqual {
  CustomMap<String, Object?> get map;

  /// Create a copy of CustomMapEqual
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomMapEqualCopyWith<CustomMapEqual> get copyWith =>
      _$CustomMapEqualCopyWithImpl<CustomMapEqual>(
          this as CustomMapEqual, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomMapEqual &&
            const DeepCollectionEquality().equals(other.map, map));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(map));

  @override
  String toString() {
    return 'CustomMapEqual(map: $map)';
  }
}

/// @nodoc
abstract mixin class $CustomMapEqualCopyWith<$Res> {
  factory $CustomMapEqualCopyWith(
          CustomMapEqual value, $Res Function(CustomMapEqual) _then) =
      _$CustomMapEqualCopyWithImpl;
  @useResult
  $Res call({CustomMap<String, Object?> map});
}

/// @nodoc
class _$CustomMapEqualCopyWithImpl<$Res>
    implements $CustomMapEqualCopyWith<$Res> {
  _$CustomMapEqualCopyWithImpl(this._self, this._then);

  final CustomMapEqual _self;
  final $Res Function(CustomMapEqual) _then;

  /// Create a copy of CustomMapEqual
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? map = null,
  }) {
    return _then(_self.copyWith(
      map: null == map
          ? _self.map
          : map // ignore: cast_nullable_to_non_nullable
              as CustomMap<String, Object?>,
    ));
  }
}

/// Adds pattern-matching-related methods to [CustomMapEqual].
extension CustomMapEqualPatterns on CustomMapEqual {
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
    TResult Function(CustomMapEqualFirst value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CustomMapEqualFirst() when $default != null:
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
    TResult Function(CustomMapEqualFirst value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case CustomMapEqualFirst():
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
    TResult? Function(CustomMapEqualFirst value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case CustomMapEqualFirst() when $default != null:
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
    TResult Function(CustomMap<String, Object?> map)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CustomMapEqualFirst() when $default != null:
        return $default(_that.map);
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
    TResult Function(CustomMap<String, Object?> map) $default,
  ) {
    final _that = this;
    switch (_that) {
      case CustomMapEqualFirst():
        return $default(_that.map);
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
    TResult? Function(CustomMap<String, Object?> map)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case CustomMapEqualFirst() when $default != null:
        return $default(_that.map);
      case _:
        return null;
    }
  }
}

/// @nodoc

class CustomMapEqualFirst implements CustomMapEqual {
  CustomMapEqualFirst(this.map);

  @override
  final CustomMap<String, Object?> map;

  /// Create a copy of CustomMapEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomMapEqualFirstCopyWith<CustomMapEqualFirst> get copyWith =>
      _$CustomMapEqualFirstCopyWithImpl<CustomMapEqualFirst>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomMapEqualFirst &&
            const DeepCollectionEquality().equals(other.map, map));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(map));

  @override
  String toString() {
    return 'CustomMapEqual(map: $map)';
  }
}

/// @nodoc
abstract mixin class $CustomMapEqualFirstCopyWith<$Res>
    implements $CustomMapEqualCopyWith<$Res> {
  factory $CustomMapEqualFirstCopyWith(
          CustomMapEqualFirst value, $Res Function(CustomMapEqualFirst) _then) =
      _$CustomMapEqualFirstCopyWithImpl;
  @override
  @useResult
  $Res call({CustomMap<String, Object?> map});
}

/// @nodoc
class _$CustomMapEqualFirstCopyWithImpl<$Res>
    implements $CustomMapEqualFirstCopyWith<$Res> {
  _$CustomMapEqualFirstCopyWithImpl(this._self, this._then);

  final CustomMapEqualFirst _self;
  final $Res Function(CustomMapEqualFirst) _then;

  /// Create a copy of CustomMapEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? map = null,
  }) {
    return _then(CustomMapEqualFirst(
      null == map
          ? _self.map
          : map // ignore: cast_nullable_to_non_nullable
              as CustomMap<String, Object?>,
    ));
  }
}

/// @nodoc
mixin _$MapEqual {
  Map<String, Object?> get map;

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
            const DeepCollectionEquality().equals(other.map, map));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(map));

  @override
  String toString() {
    return 'MapEqual(map: $map)';
  }
}

/// @nodoc
abstract mixin class $MapEqualCopyWith<$Res> {
  factory $MapEqualCopyWith(MapEqual value, $Res Function(MapEqual) _then) =
      _$MapEqualCopyWithImpl;
  @useResult
  $Res call({Map<String, Object?> map});
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
    Object? map = null,
  }) {
    return _then(_self.copyWith(
      map: null == map
          ? _self.map
          : map // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>,
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
    TResult Function(MapEqualFirst value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case MapEqualFirst() when $default != null:
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
    TResult Function(MapEqualFirst value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case MapEqualFirst():
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
    TResult? Function(MapEqualFirst value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case MapEqualFirst() when $default != null:
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
    TResult Function(Map<String, Object?> map)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case MapEqualFirst() when $default != null:
        return $default(_that.map);
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
    TResult Function(Map<String, Object?> map) $default,
  ) {
    final _that = this;
    switch (_that) {
      case MapEqualFirst():
        return $default(_that.map);
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
    TResult? Function(Map<String, Object?> map)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case MapEqualFirst() when $default != null:
        return $default(_that.map);
      case _:
        return null;
    }
  }
}

/// @nodoc

class MapEqualFirst implements MapEqual {
  MapEqualFirst(this.map);

  @override
  final Map<String, Object?> map;

  /// Create a copy of MapEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MapEqualFirstCopyWith<MapEqualFirst> get copyWith =>
      _$MapEqualFirstCopyWithImpl<MapEqualFirst>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MapEqualFirst &&
            const DeepCollectionEquality().equals(other.map, map));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(map));

  @override
  String toString() {
    return 'MapEqual(map: $map)';
  }
}

/// @nodoc
abstract mixin class $MapEqualFirstCopyWith<$Res>
    implements $MapEqualCopyWith<$Res> {
  factory $MapEqualFirstCopyWith(
          MapEqualFirst value, $Res Function(MapEqualFirst) _then) =
      _$MapEqualFirstCopyWithImpl;
  @override
  @useResult
  $Res call({Map<String, Object?> map});
}

/// @nodoc
class _$MapEqualFirstCopyWithImpl<$Res>
    implements $MapEqualFirstCopyWith<$Res> {
  _$MapEqualFirstCopyWithImpl(this._self, this._then);

  final MapEqualFirst _self;
  final $Res Function(MapEqualFirst) _then;

  /// Create a copy of MapEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? map = null,
  }) {
    return _then(MapEqualFirst(
      null == map
          ? _self.map
          : map // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>,
    ));
  }
}

/// @nodoc
mixin _$UnmodifiableMapEqual {
  Map<String, Object?> get map;

  /// Create a copy of UnmodifiableMapEqual
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnmodifiableMapEqualCopyWith<UnmodifiableMapEqual> get copyWith =>
      _$UnmodifiableMapEqualCopyWithImpl<UnmodifiableMapEqual>(
          this as UnmodifiableMapEqual, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnmodifiableMapEqual &&
            const DeepCollectionEquality().equals(other.map, map));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(map));

  @override
  String toString() {
    return 'UnmodifiableMapEqual(map: $map)';
  }
}

/// @nodoc
abstract mixin class $UnmodifiableMapEqualCopyWith<$Res> {
  factory $UnmodifiableMapEqualCopyWith(UnmodifiableMapEqual value,
          $Res Function(UnmodifiableMapEqual) _then) =
      _$UnmodifiableMapEqualCopyWithImpl;
  @useResult
  $Res call({Map<String, Object?> map});
}

/// @nodoc
class _$UnmodifiableMapEqualCopyWithImpl<$Res>
    implements $UnmodifiableMapEqualCopyWith<$Res> {
  _$UnmodifiableMapEqualCopyWithImpl(this._self, this._then);

  final UnmodifiableMapEqual _self;
  final $Res Function(UnmodifiableMapEqual) _then;

  /// Create a copy of UnmodifiableMapEqual
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? map = null,
  }) {
    return _then(_self.copyWith(
      map: null == map
          ? _self.map
          : map // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>,
    ));
  }
}

/// Adds pattern-matching-related methods to [UnmodifiableMapEqual].
extension UnmodifiableMapEqualPatterns on UnmodifiableMapEqual {
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
    TResult Function(UnmodifiableMapEqualFirst value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case UnmodifiableMapEqualFirst() when $default != null:
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
    TResult Function(UnmodifiableMapEqualFirst value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case UnmodifiableMapEqualFirst():
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
    TResult? Function(UnmodifiableMapEqualFirst value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case UnmodifiableMapEqualFirst() when $default != null:
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
    TResult Function(Map<String, Object?> map)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case UnmodifiableMapEqualFirst() when $default != null:
        return $default(_that.map);
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
    TResult Function(Map<String, Object?> map) $default,
  ) {
    final _that = this;
    switch (_that) {
      case UnmodifiableMapEqualFirst():
        return $default(_that.map);
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
    TResult? Function(Map<String, Object?> map)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case UnmodifiableMapEqualFirst() when $default != null:
        return $default(_that.map);
      case _:
        return null;
    }
  }
}

/// @nodoc

class UnmodifiableMapEqualFirst implements UnmodifiableMapEqual {
  UnmodifiableMapEqualFirst(final Map<String, Object?> map) : _map = map;

  final Map<String, Object?> _map;
  @override
  Map<String, Object?> get map {
    if (_map is EqualUnmodifiableMapView) return _map;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_map);
  }

  /// Create a copy of UnmodifiableMapEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnmodifiableMapEqualFirstCopyWith<UnmodifiableMapEqualFirst> get copyWith =>
      _$UnmodifiableMapEqualFirstCopyWithImpl<UnmodifiableMapEqualFirst>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnmodifiableMapEqualFirst &&
            const DeepCollectionEquality().equals(other._map, _map));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_map));

  @override
  String toString() {
    return 'UnmodifiableMapEqual(map: $map)';
  }
}

/// @nodoc
abstract mixin class $UnmodifiableMapEqualFirstCopyWith<$Res>
    implements $UnmodifiableMapEqualCopyWith<$Res> {
  factory $UnmodifiableMapEqualFirstCopyWith(UnmodifiableMapEqualFirst value,
          $Res Function(UnmodifiableMapEqualFirst) _then) =
      _$UnmodifiableMapEqualFirstCopyWithImpl;
  @override
  @useResult
  $Res call({Map<String, Object?> map});
}

/// @nodoc
class _$UnmodifiableMapEqualFirstCopyWithImpl<$Res>
    implements $UnmodifiableMapEqualFirstCopyWith<$Res> {
  _$UnmodifiableMapEqualFirstCopyWithImpl(this._self, this._then);

  final UnmodifiableMapEqualFirst _self;
  final $Res Function(UnmodifiableMapEqualFirst) _then;

  /// Create a copy of UnmodifiableMapEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? map = null,
  }) {
    return _then(UnmodifiableMapEqualFirst(
      null == map
          ? _self._map
          : map // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>,
    ));
  }
}

/// @nodoc
mixin _$NullUnmodifiableMapEqual {
  Map<String, Object?>? get map;

  /// Create a copy of NullUnmodifiableMapEqual
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NullUnmodifiableMapEqualCopyWith<NullUnmodifiableMapEqual> get copyWith =>
      _$NullUnmodifiableMapEqualCopyWithImpl<NullUnmodifiableMapEqual>(
          this as NullUnmodifiableMapEqual, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NullUnmodifiableMapEqual &&
            const DeepCollectionEquality().equals(other.map, map));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(map));

  @override
  String toString() {
    return 'NullUnmodifiableMapEqual(map: $map)';
  }
}

/// @nodoc
abstract mixin class $NullUnmodifiableMapEqualCopyWith<$Res> {
  factory $NullUnmodifiableMapEqualCopyWith(NullUnmodifiableMapEqual value,
          $Res Function(NullUnmodifiableMapEqual) _then) =
      _$NullUnmodifiableMapEqualCopyWithImpl;
  @useResult
  $Res call({Map<String, Object?>? map});
}

/// @nodoc
class _$NullUnmodifiableMapEqualCopyWithImpl<$Res>
    implements $NullUnmodifiableMapEqualCopyWith<$Res> {
  _$NullUnmodifiableMapEqualCopyWithImpl(this._self, this._then);

  final NullUnmodifiableMapEqual _self;
  final $Res Function(NullUnmodifiableMapEqual) _then;

  /// Create a copy of NullUnmodifiableMapEqual
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? map = freezed,
  }) {
    return _then(_self.copyWith(
      map: freezed == map
          ? _self.map
          : map // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [NullUnmodifiableMapEqual].
extension NullUnmodifiableMapEqualPatterns on NullUnmodifiableMapEqual {
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
    TResult Function(NullUnmodifiableMapEqualFirst value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case NullUnmodifiableMapEqualFirst() when $default != null:
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
    TResult Function(NullUnmodifiableMapEqualFirst value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case NullUnmodifiableMapEqualFirst():
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
    TResult? Function(NullUnmodifiableMapEqualFirst value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case NullUnmodifiableMapEqualFirst() when $default != null:
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
    TResult Function(Map<String, Object?>? map)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case NullUnmodifiableMapEqualFirst() when $default != null:
        return $default(_that.map);
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
    TResult Function(Map<String, Object?>? map) $default,
  ) {
    final _that = this;
    switch (_that) {
      case NullUnmodifiableMapEqualFirst():
        return $default(_that.map);
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
    TResult? Function(Map<String, Object?>? map)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case NullUnmodifiableMapEqualFirst() when $default != null:
        return $default(_that.map);
      case _:
        return null;
    }
  }
}

/// @nodoc

class NullUnmodifiableMapEqualFirst implements NullUnmodifiableMapEqual {
  NullUnmodifiableMapEqualFirst(final Map<String, Object?>? map) : _map = map;

  final Map<String, Object?>? _map;
  @override
  Map<String, Object?>? get map {
    final value = _map;
    if (value == null) return null;
    if (_map is EqualUnmodifiableMapView) return _map;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Create a copy of NullUnmodifiableMapEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NullUnmodifiableMapEqualFirstCopyWith<NullUnmodifiableMapEqualFirst>
      get copyWith => _$NullUnmodifiableMapEqualFirstCopyWithImpl<
          NullUnmodifiableMapEqualFirst>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NullUnmodifiableMapEqualFirst &&
            const DeepCollectionEquality().equals(other._map, _map));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_map));

  @override
  String toString() {
    return 'NullUnmodifiableMapEqual(map: $map)';
  }
}

/// @nodoc
abstract mixin class $NullUnmodifiableMapEqualFirstCopyWith<$Res>
    implements $NullUnmodifiableMapEqualCopyWith<$Res> {
  factory $NullUnmodifiableMapEqualFirstCopyWith(
          NullUnmodifiableMapEqualFirst value,
          $Res Function(NullUnmodifiableMapEqualFirst) _then) =
      _$NullUnmodifiableMapEqualFirstCopyWithImpl;
  @override
  @useResult
  $Res call({Map<String, Object?>? map});
}

/// @nodoc
class _$NullUnmodifiableMapEqualFirstCopyWithImpl<$Res>
    implements $NullUnmodifiableMapEqualFirstCopyWith<$Res> {
  _$NullUnmodifiableMapEqualFirstCopyWithImpl(this._self, this._then);

  final NullUnmodifiableMapEqualFirst _self;
  final $Res Function(NullUnmodifiableMapEqualFirst) _then;

  /// Create a copy of NullUnmodifiableMapEqual
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? map = freezed,
  }) {
    return _then(NullUnmodifiableMapEqualFirst(
      freezed == map
          ? _self._map
          : map // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
    ));
  }
}

/// @nodoc
mixin _$WithAlias {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is WithAlias);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'WithAlias()';
  }
}

/// @nodoc
class $WithAliasCopyWith<$Res> {
  $WithAliasCopyWith(WithAlias _, $Res Function(WithAlias) __);
}

/// Adds pattern-matching-related methods to [WithAlias].
extension WithAliasPatterns on WithAlias {
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
    TResult Function(WithAliasFirst value)? first,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case WithAliasFirst() when first != null:
        return first(_that);
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
    required TResult Function(WithAliasFirst value) first,
  }) {
    final _that = this;
    switch (_that) {
      case WithAliasFirst():
        return first(_that);
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
    TResult? Function(WithAliasFirst value)? first,
  }) {
    final _that = this;
    switch (_that) {
      case WithAliasFirst() when first != null:
        return first(_that);
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
    TResult Function()? first,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case WithAliasFirst() when first != null:
        return first();
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
    required TResult Function() first,
  }) {
    final _that = this;
    switch (_that) {
      case WithAliasFirst():
        return first();
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
    TResult? Function()? first,
  }) {
    final _that = this;
    switch (_that) {
      case WithAliasFirst() when first != null:
        return first();
      case _:
        return null;
    }
  }
}

/// @nodoc

@withAlias
class WithAliasFirst with Some<Complex<Type>> implements WithAlias {
  WithAliasFirst();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is WithAliasFirst);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'WithAlias.first()';
  }
}

/// @nodoc
mixin _$ImplementsAlias {
  Complex<Type>? get value;

  /// Create a copy of ImplementsAlias
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ImplementsAliasCopyWith<ImplementsAlias> get copyWith =>
      _$ImplementsAliasCopyWithImpl<ImplementsAlias>(
          this as ImplementsAlias, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ImplementsAlias &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'ImplementsAlias(value: $value)';
  }
}

/// @nodoc
abstract mixin class $ImplementsAliasCopyWith<$Res> {
  factory $ImplementsAliasCopyWith(
          ImplementsAlias value, $Res Function(ImplementsAlias) _then) =
      _$ImplementsAliasCopyWithImpl;
  @useResult
  $Res call({Complex<Type>? value});
}

/// @nodoc
class _$ImplementsAliasCopyWithImpl<$Res>
    implements $ImplementsAliasCopyWith<$Res> {
  _$ImplementsAliasCopyWithImpl(this._self, this._then);

  final ImplementsAlias _self;
  final $Res Function(ImplementsAlias) _then;

  /// Create a copy of ImplementsAlias
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
              as Complex<Type>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ImplementsAlias].
extension ImplementsAliasPatterns on ImplementsAlias {
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
    TResult Function(ImplementsAliasFirst value)? first,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ImplementsAliasFirst() when first != null:
        return first(_that);
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
    required TResult Function(ImplementsAliasFirst value) first,
  }) {
    final _that = this;
    switch (_that) {
      case ImplementsAliasFirst():
        return first(_that);
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
    TResult? Function(ImplementsAliasFirst value)? first,
  }) {
    final _that = this;
    switch (_that) {
      case ImplementsAliasFirst() when first != null:
        return first(_that);
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
    TResult Function(Complex<Type>? value)? first,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ImplementsAliasFirst() when first != null:
        return first(_that.value);
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
    required TResult Function(Complex<Type>? value) first,
  }) {
    final _that = this;
    switch (_that) {
      case ImplementsAliasFirst():
        return first(_that.value);
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
    TResult? Function(Complex<Type>? value)? first,
  }) {
    final _that = this;
    switch (_that) {
      case ImplementsAliasFirst() when first != null:
        return first(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

@implementsAlias
class ImplementsAliasFirst implements ImplementsAlias, Some<Complex<Type>> {
  ImplementsAliasFirst({this.value});

  @override
  final Complex<Type>? value;

  /// Create a copy of ImplementsAlias
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ImplementsAliasFirstCopyWith<ImplementsAliasFirst> get copyWith =>
      _$ImplementsAliasFirstCopyWithImpl<ImplementsAliasFirst>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ImplementsAliasFirst &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'ImplementsAlias.first(value: $value)';
  }
}

/// @nodoc
abstract mixin class $ImplementsAliasFirstCopyWith<$Res>
    implements $ImplementsAliasCopyWith<$Res> {
  factory $ImplementsAliasFirstCopyWith(ImplementsAliasFirst value,
          $Res Function(ImplementsAliasFirst) _then) =
      _$ImplementsAliasFirstCopyWithImpl;
  @override
  @useResult
  $Res call({Complex<Type>? value});
}

/// @nodoc
class _$ImplementsAliasFirstCopyWithImpl<$Res>
    implements $ImplementsAliasFirstCopyWith<$Res> {
  _$ImplementsAliasFirstCopyWithImpl(this._self, this._then);

  final ImplementsAliasFirst _self;
  final $Res Function(ImplementsAliasFirst) _then;

  /// Create a copy of ImplementsAlias
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = freezed,
  }) {
    return _then(ImplementsAliasFirst(
      value: freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as Complex<Type>?,
    ));
  }
}

/// @nodoc
mixin _$Large {
  int? get a0;
  int? get a1;
  int? get a2;
  int? get a3;
  int? get a4;
  int? get a5;
  int? get a6;
  int? get a7;
  int? get a8;
  int? get a9;
  int? get a10;
  int? get a11;
  int? get a12;
  int? get a13;
  int? get a14;
  int? get a15;
  int? get a16;
  int? get a17;
  int? get a18;
  int? get a19;
  int? get a20;
  int? get a21;
  int? get a22;
  int? get a23;
  int? get a24;
  int? get a25;
  int? get a26;
  int? get a27;
  int? get a28;
  int? get a29;

  /// Create a copy of Large
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LargeCopyWith<Large> get copyWith =>
      _$LargeCopyWithImpl<Large>(this as Large, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Large &&
            (identical(other.a0, a0) || other.a0 == a0) &&
            (identical(other.a1, a1) || other.a1 == a1) &&
            (identical(other.a2, a2) || other.a2 == a2) &&
            (identical(other.a3, a3) || other.a3 == a3) &&
            (identical(other.a4, a4) || other.a4 == a4) &&
            (identical(other.a5, a5) || other.a5 == a5) &&
            (identical(other.a6, a6) || other.a6 == a6) &&
            (identical(other.a7, a7) || other.a7 == a7) &&
            (identical(other.a8, a8) || other.a8 == a8) &&
            (identical(other.a9, a9) || other.a9 == a9) &&
            (identical(other.a10, a10) || other.a10 == a10) &&
            (identical(other.a11, a11) || other.a11 == a11) &&
            (identical(other.a12, a12) || other.a12 == a12) &&
            (identical(other.a13, a13) || other.a13 == a13) &&
            (identical(other.a14, a14) || other.a14 == a14) &&
            (identical(other.a15, a15) || other.a15 == a15) &&
            (identical(other.a16, a16) || other.a16 == a16) &&
            (identical(other.a17, a17) || other.a17 == a17) &&
            (identical(other.a18, a18) || other.a18 == a18) &&
            (identical(other.a19, a19) || other.a19 == a19) &&
            (identical(other.a20, a20) || other.a20 == a20) &&
            (identical(other.a21, a21) || other.a21 == a21) &&
            (identical(other.a22, a22) || other.a22 == a22) &&
            (identical(other.a23, a23) || other.a23 == a23) &&
            (identical(other.a24, a24) || other.a24 == a24) &&
            (identical(other.a25, a25) || other.a25 == a25) &&
            (identical(other.a26, a26) || other.a26 == a26) &&
            (identical(other.a27, a27) || other.a27 == a27) &&
            (identical(other.a28, a28) || other.a28 == a28) &&
            (identical(other.a29, a29) || other.a29 == a29));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        a0,
        a1,
        a2,
        a3,
        a4,
        a5,
        a6,
        a7,
        a8,
        a9,
        a10,
        a11,
        a12,
        a13,
        a14,
        a15,
        a16,
        a17,
        a18,
        a19,
        a20,
        a21,
        a22,
        a23,
        a24,
        a25,
        a26,
        a27,
        a28,
        a29
      ]);

  @override
  String toString() {
    return 'Large(a0: $a0, a1: $a1, a2: $a2, a3: $a3, a4: $a4, a5: $a5, a6: $a6, a7: $a7, a8: $a8, a9: $a9, a10: $a10, a11: $a11, a12: $a12, a13: $a13, a14: $a14, a15: $a15, a16: $a16, a17: $a17, a18: $a18, a19: $a19, a20: $a20, a21: $a21, a22: $a22, a23: $a23, a24: $a24, a25: $a25, a26: $a26, a27: $a27, a28: $a28, a29: $a29)';
  }
}

/// @nodoc
abstract mixin class $LargeCopyWith<$Res> {
  factory $LargeCopyWith(Large value, $Res Function(Large) _then) =
      _$LargeCopyWithImpl;
  @useResult
  $Res call(
      {int? a0,
      int? a1,
      int? a2,
      int? a3,
      int? a4,
      int? a5,
      int? a6,
      int? a7,
      int? a8,
      int? a9,
      int? a10,
      int? a11,
      int? a12,
      int? a13,
      int? a14,
      int? a15,
      int? a16,
      int? a17,
      int? a18,
      int? a19,
      int? a20,
      int? a21,
      int? a22,
      int? a23,
      int? a24,
      int? a25,
      int? a26,
      int? a27,
      int? a28,
      int? a29});
}

/// @nodoc
class _$LargeCopyWithImpl<$Res> implements $LargeCopyWith<$Res> {
  _$LargeCopyWithImpl(this._self, this._then);

  final Large _self;
  final $Res Function(Large) _then;

  /// Create a copy of Large
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? a0 = freezed,
    Object? a1 = freezed,
    Object? a2 = freezed,
    Object? a3 = freezed,
    Object? a4 = freezed,
    Object? a5 = freezed,
    Object? a6 = freezed,
    Object? a7 = freezed,
    Object? a8 = freezed,
    Object? a9 = freezed,
    Object? a10 = freezed,
    Object? a11 = freezed,
    Object? a12 = freezed,
    Object? a13 = freezed,
    Object? a14 = freezed,
    Object? a15 = freezed,
    Object? a16 = freezed,
    Object? a17 = freezed,
    Object? a18 = freezed,
    Object? a19 = freezed,
    Object? a20 = freezed,
    Object? a21 = freezed,
    Object? a22 = freezed,
    Object? a23 = freezed,
    Object? a24 = freezed,
    Object? a25 = freezed,
    Object? a26 = freezed,
    Object? a27 = freezed,
    Object? a28 = freezed,
    Object? a29 = freezed,
  }) {
    return _then(_self.copyWith(
      a0: freezed == a0
          ? _self.a0
          : a0 // ignore: cast_nullable_to_non_nullable
              as int?,
      a1: freezed == a1
          ? _self.a1
          : a1 // ignore: cast_nullable_to_non_nullable
              as int?,
      a2: freezed == a2
          ? _self.a2
          : a2 // ignore: cast_nullable_to_non_nullable
              as int?,
      a3: freezed == a3
          ? _self.a3
          : a3 // ignore: cast_nullable_to_non_nullable
              as int?,
      a4: freezed == a4
          ? _self.a4
          : a4 // ignore: cast_nullable_to_non_nullable
              as int?,
      a5: freezed == a5
          ? _self.a5
          : a5 // ignore: cast_nullable_to_non_nullable
              as int?,
      a6: freezed == a6
          ? _self.a6
          : a6 // ignore: cast_nullable_to_non_nullable
              as int?,
      a7: freezed == a7
          ? _self.a7
          : a7 // ignore: cast_nullable_to_non_nullable
              as int?,
      a8: freezed == a8
          ? _self.a8
          : a8 // ignore: cast_nullable_to_non_nullable
              as int?,
      a9: freezed == a9
          ? _self.a9
          : a9 // ignore: cast_nullable_to_non_nullable
              as int?,
      a10: freezed == a10
          ? _self.a10
          : a10 // ignore: cast_nullable_to_non_nullable
              as int?,
      a11: freezed == a11
          ? _self.a11
          : a11 // ignore: cast_nullable_to_non_nullable
              as int?,
      a12: freezed == a12
          ? _self.a12
          : a12 // ignore: cast_nullable_to_non_nullable
              as int?,
      a13: freezed == a13
          ? _self.a13
          : a13 // ignore: cast_nullable_to_non_nullable
              as int?,
      a14: freezed == a14
          ? _self.a14
          : a14 // ignore: cast_nullable_to_non_nullable
              as int?,
      a15: freezed == a15
          ? _self.a15
          : a15 // ignore: cast_nullable_to_non_nullable
              as int?,
      a16: freezed == a16
          ? _self.a16
          : a16 // ignore: cast_nullable_to_non_nullable
              as int?,
      a17: freezed == a17
          ? _self.a17
          : a17 // ignore: cast_nullable_to_non_nullable
              as int?,
      a18: freezed == a18
          ? _self.a18
          : a18 // ignore: cast_nullable_to_non_nullable
              as int?,
      a19: freezed == a19
          ? _self.a19
          : a19 // ignore: cast_nullable_to_non_nullable
              as int?,
      a20: freezed == a20
          ? _self.a20
          : a20 // ignore: cast_nullable_to_non_nullable
              as int?,
      a21: freezed == a21
          ? _self.a21
          : a21 // ignore: cast_nullable_to_non_nullable
              as int?,
      a22: freezed == a22
          ? _self.a22
          : a22 // ignore: cast_nullable_to_non_nullable
              as int?,
      a23: freezed == a23
          ? _self.a23
          : a23 // ignore: cast_nullable_to_non_nullable
              as int?,
      a24: freezed == a24
          ? _self.a24
          : a24 // ignore: cast_nullable_to_non_nullable
              as int?,
      a25: freezed == a25
          ? _self.a25
          : a25 // ignore: cast_nullable_to_non_nullable
              as int?,
      a26: freezed == a26
          ? _self.a26
          : a26 // ignore: cast_nullable_to_non_nullable
              as int?,
      a27: freezed == a27
          ? _self.a27
          : a27 // ignore: cast_nullable_to_non_nullable
              as int?,
      a28: freezed == a28
          ? _self.a28
          : a28 // ignore: cast_nullable_to_non_nullable
              as int?,
      a29: freezed == a29
          ? _self.a29
          : a29 // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Large].
extension LargePatterns on Large {
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
    TResult Function(_Large value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Large() when $default != null:
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
    TResult Function(_Large value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Large():
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
    TResult? Function(_Large value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Large() when $default != null:
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
    TResult Function(
            int? a0,
            int? a1,
            int? a2,
            int? a3,
            int? a4,
            int? a5,
            int? a6,
            int? a7,
            int? a8,
            int? a9,
            int? a10,
            int? a11,
            int? a12,
            int? a13,
            int? a14,
            int? a15,
            int? a16,
            int? a17,
            int? a18,
            int? a19,
            int? a20,
            int? a21,
            int? a22,
            int? a23,
            int? a24,
            int? a25,
            int? a26,
            int? a27,
            int? a28,
            int? a29)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Large() when $default != null:
        return $default(
            _that.a0,
            _that.a1,
            _that.a2,
            _that.a3,
            _that.a4,
            _that.a5,
            _that.a6,
            _that.a7,
            _that.a8,
            _that.a9,
            _that.a10,
            _that.a11,
            _that.a12,
            _that.a13,
            _that.a14,
            _that.a15,
            _that.a16,
            _that.a17,
            _that.a18,
            _that.a19,
            _that.a20,
            _that.a21,
            _that.a22,
            _that.a23,
            _that.a24,
            _that.a25,
            _that.a26,
            _that.a27,
            _that.a28,
            _that.a29);
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
    TResult Function(
            int? a0,
            int? a1,
            int? a2,
            int? a3,
            int? a4,
            int? a5,
            int? a6,
            int? a7,
            int? a8,
            int? a9,
            int? a10,
            int? a11,
            int? a12,
            int? a13,
            int? a14,
            int? a15,
            int? a16,
            int? a17,
            int? a18,
            int? a19,
            int? a20,
            int? a21,
            int? a22,
            int? a23,
            int? a24,
            int? a25,
            int? a26,
            int? a27,
            int? a28,
            int? a29)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Large():
        return $default(
            _that.a0,
            _that.a1,
            _that.a2,
            _that.a3,
            _that.a4,
            _that.a5,
            _that.a6,
            _that.a7,
            _that.a8,
            _that.a9,
            _that.a10,
            _that.a11,
            _that.a12,
            _that.a13,
            _that.a14,
            _that.a15,
            _that.a16,
            _that.a17,
            _that.a18,
            _that.a19,
            _that.a20,
            _that.a21,
            _that.a22,
            _that.a23,
            _that.a24,
            _that.a25,
            _that.a26,
            _that.a27,
            _that.a28,
            _that.a29);
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
    TResult? Function(
            int? a0,
            int? a1,
            int? a2,
            int? a3,
            int? a4,
            int? a5,
            int? a6,
            int? a7,
            int? a8,
            int? a9,
            int? a10,
            int? a11,
            int? a12,
            int? a13,
            int? a14,
            int? a15,
            int? a16,
            int? a17,
            int? a18,
            int? a19,
            int? a20,
            int? a21,
            int? a22,
            int? a23,
            int? a24,
            int? a25,
            int? a26,
            int? a27,
            int? a28,
            int? a29)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Large() when $default != null:
        return $default(
            _that.a0,
            _that.a1,
            _that.a2,
            _that.a3,
            _that.a4,
            _that.a5,
            _that.a6,
            _that.a7,
            _that.a8,
            _that.a9,
            _that.a10,
            _that.a11,
            _that.a12,
            _that.a13,
            _that.a14,
            _that.a15,
            _that.a16,
            _that.a17,
            _that.a18,
            _that.a19,
            _that.a20,
            _that.a21,
            _that.a22,
            _that.a23,
            _that.a24,
            _that.a25,
            _that.a26,
            _that.a27,
            _that.a28,
            _that.a29);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Large implements Large {
  _Large(
      {this.a0 = 0,
      this.a1 = 1,
      this.a2 = 2,
      this.a3 = 3,
      this.a4 = 4,
      this.a5 = 5,
      this.a6 = 6,
      this.a7 = 7,
      this.a8 = 8,
      this.a9 = 9,
      this.a10 = 10,
      this.a11 = 11,
      this.a12 = 12,
      this.a13 = 13,
      this.a14 = 14,
      this.a15 = 15,
      this.a16 = 16,
      this.a17 = 17,
      this.a18 = 18,
      this.a19 = 19,
      this.a20 = 20,
      this.a21 = 21,
      this.a22 = 22,
      this.a23 = 23,
      this.a24 = 24,
      this.a25 = 25,
      this.a26 = 26,
      this.a27 = 27,
      this.a28 = 28,
      this.a29 = 29});

  @override
  @JsonKey()
  final int? a0;
  @override
  @JsonKey()
  final int? a1;
  @override
  @JsonKey()
  final int? a2;
  @override
  @JsonKey()
  final int? a3;
  @override
  @JsonKey()
  final int? a4;
  @override
  @JsonKey()
  final int? a5;
  @override
  @JsonKey()
  final int? a6;
  @override
  @JsonKey()
  final int? a7;
  @override
  @JsonKey()
  final int? a8;
  @override
  @JsonKey()
  final int? a9;
  @override
  @JsonKey()
  final int? a10;
  @override
  @JsonKey()
  final int? a11;
  @override
  @JsonKey()
  final int? a12;
  @override
  @JsonKey()
  final int? a13;
  @override
  @JsonKey()
  final int? a14;
  @override
  @JsonKey()
  final int? a15;
  @override
  @JsonKey()
  final int? a16;
  @override
  @JsonKey()
  final int? a17;
  @override
  @JsonKey()
  final int? a18;
  @override
  @JsonKey()
  final int? a19;
  @override
  @JsonKey()
  final int? a20;
  @override
  @JsonKey()
  final int? a21;
  @override
  @JsonKey()
  final int? a22;
  @override
  @JsonKey()
  final int? a23;
  @override
  @JsonKey()
  final int? a24;
  @override
  @JsonKey()
  final int? a25;
  @override
  @JsonKey()
  final int? a26;
  @override
  @JsonKey()
  final int? a27;
  @override
  @JsonKey()
  final int? a28;
  @override
  @JsonKey()
  final int? a29;

  /// Create a copy of Large
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LargeCopyWith<_Large> get copyWith =>
      __$LargeCopyWithImpl<_Large>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Large &&
            (identical(other.a0, a0) || other.a0 == a0) &&
            (identical(other.a1, a1) || other.a1 == a1) &&
            (identical(other.a2, a2) || other.a2 == a2) &&
            (identical(other.a3, a3) || other.a3 == a3) &&
            (identical(other.a4, a4) || other.a4 == a4) &&
            (identical(other.a5, a5) || other.a5 == a5) &&
            (identical(other.a6, a6) || other.a6 == a6) &&
            (identical(other.a7, a7) || other.a7 == a7) &&
            (identical(other.a8, a8) || other.a8 == a8) &&
            (identical(other.a9, a9) || other.a9 == a9) &&
            (identical(other.a10, a10) || other.a10 == a10) &&
            (identical(other.a11, a11) || other.a11 == a11) &&
            (identical(other.a12, a12) || other.a12 == a12) &&
            (identical(other.a13, a13) || other.a13 == a13) &&
            (identical(other.a14, a14) || other.a14 == a14) &&
            (identical(other.a15, a15) || other.a15 == a15) &&
            (identical(other.a16, a16) || other.a16 == a16) &&
            (identical(other.a17, a17) || other.a17 == a17) &&
            (identical(other.a18, a18) || other.a18 == a18) &&
            (identical(other.a19, a19) || other.a19 == a19) &&
            (identical(other.a20, a20) || other.a20 == a20) &&
            (identical(other.a21, a21) || other.a21 == a21) &&
            (identical(other.a22, a22) || other.a22 == a22) &&
            (identical(other.a23, a23) || other.a23 == a23) &&
            (identical(other.a24, a24) || other.a24 == a24) &&
            (identical(other.a25, a25) || other.a25 == a25) &&
            (identical(other.a26, a26) || other.a26 == a26) &&
            (identical(other.a27, a27) || other.a27 == a27) &&
            (identical(other.a28, a28) || other.a28 == a28) &&
            (identical(other.a29, a29) || other.a29 == a29));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        a0,
        a1,
        a2,
        a3,
        a4,
        a5,
        a6,
        a7,
        a8,
        a9,
        a10,
        a11,
        a12,
        a13,
        a14,
        a15,
        a16,
        a17,
        a18,
        a19,
        a20,
        a21,
        a22,
        a23,
        a24,
        a25,
        a26,
        a27,
        a28,
        a29
      ]);

  @override
  String toString() {
    return 'Large(a0: $a0, a1: $a1, a2: $a2, a3: $a3, a4: $a4, a5: $a5, a6: $a6, a7: $a7, a8: $a8, a9: $a9, a10: $a10, a11: $a11, a12: $a12, a13: $a13, a14: $a14, a15: $a15, a16: $a16, a17: $a17, a18: $a18, a19: $a19, a20: $a20, a21: $a21, a22: $a22, a23: $a23, a24: $a24, a25: $a25, a26: $a26, a27: $a27, a28: $a28, a29: $a29)';
  }
}

/// @nodoc
abstract mixin class _$LargeCopyWith<$Res> implements $LargeCopyWith<$Res> {
  factory _$LargeCopyWith(_Large value, $Res Function(_Large) _then) =
      __$LargeCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int? a0,
      int? a1,
      int? a2,
      int? a3,
      int? a4,
      int? a5,
      int? a6,
      int? a7,
      int? a8,
      int? a9,
      int? a10,
      int? a11,
      int? a12,
      int? a13,
      int? a14,
      int? a15,
      int? a16,
      int? a17,
      int? a18,
      int? a19,
      int? a20,
      int? a21,
      int? a22,
      int? a23,
      int? a24,
      int? a25,
      int? a26,
      int? a27,
      int? a28,
      int? a29});
}

/// @nodoc
class __$LargeCopyWithImpl<$Res> implements _$LargeCopyWith<$Res> {
  __$LargeCopyWithImpl(this._self, this._then);

  final _Large _self;
  final $Res Function(_Large) _then;

  /// Create a copy of Large
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a0 = freezed,
    Object? a1 = freezed,
    Object? a2 = freezed,
    Object? a3 = freezed,
    Object? a4 = freezed,
    Object? a5 = freezed,
    Object? a6 = freezed,
    Object? a7 = freezed,
    Object? a8 = freezed,
    Object? a9 = freezed,
    Object? a10 = freezed,
    Object? a11 = freezed,
    Object? a12 = freezed,
    Object? a13 = freezed,
    Object? a14 = freezed,
    Object? a15 = freezed,
    Object? a16 = freezed,
    Object? a17 = freezed,
    Object? a18 = freezed,
    Object? a19 = freezed,
    Object? a20 = freezed,
    Object? a21 = freezed,
    Object? a22 = freezed,
    Object? a23 = freezed,
    Object? a24 = freezed,
    Object? a25 = freezed,
    Object? a26 = freezed,
    Object? a27 = freezed,
    Object? a28 = freezed,
    Object? a29 = freezed,
  }) {
    return _then(_Large(
      a0: freezed == a0
          ? _self.a0
          : a0 // ignore: cast_nullable_to_non_nullable
              as int?,
      a1: freezed == a1
          ? _self.a1
          : a1 // ignore: cast_nullable_to_non_nullable
              as int?,
      a2: freezed == a2
          ? _self.a2
          : a2 // ignore: cast_nullable_to_non_nullable
              as int?,
      a3: freezed == a3
          ? _self.a3
          : a3 // ignore: cast_nullable_to_non_nullable
              as int?,
      a4: freezed == a4
          ? _self.a4
          : a4 // ignore: cast_nullable_to_non_nullable
              as int?,
      a5: freezed == a5
          ? _self.a5
          : a5 // ignore: cast_nullable_to_non_nullable
              as int?,
      a6: freezed == a6
          ? _self.a6
          : a6 // ignore: cast_nullable_to_non_nullable
              as int?,
      a7: freezed == a7
          ? _self.a7
          : a7 // ignore: cast_nullable_to_non_nullable
              as int?,
      a8: freezed == a8
          ? _self.a8
          : a8 // ignore: cast_nullable_to_non_nullable
              as int?,
      a9: freezed == a9
          ? _self.a9
          : a9 // ignore: cast_nullable_to_non_nullable
              as int?,
      a10: freezed == a10
          ? _self.a10
          : a10 // ignore: cast_nullable_to_non_nullable
              as int?,
      a11: freezed == a11
          ? _self.a11
          : a11 // ignore: cast_nullable_to_non_nullable
              as int?,
      a12: freezed == a12
          ? _self.a12
          : a12 // ignore: cast_nullable_to_non_nullable
              as int?,
      a13: freezed == a13
          ? _self.a13
          : a13 // ignore: cast_nullable_to_non_nullable
              as int?,
      a14: freezed == a14
          ? _self.a14
          : a14 // ignore: cast_nullable_to_non_nullable
              as int?,
      a15: freezed == a15
          ? _self.a15
          : a15 // ignore: cast_nullable_to_non_nullable
              as int?,
      a16: freezed == a16
          ? _self.a16
          : a16 // ignore: cast_nullable_to_non_nullable
              as int?,
      a17: freezed == a17
          ? _self.a17
          : a17 // ignore: cast_nullable_to_non_nullable
              as int?,
      a18: freezed == a18
          ? _self.a18
          : a18 // ignore: cast_nullable_to_non_nullable
              as int?,
      a19: freezed == a19
          ? _self.a19
          : a19 // ignore: cast_nullable_to_non_nullable
              as int?,
      a20: freezed == a20
          ? _self.a20
          : a20 // ignore: cast_nullable_to_non_nullable
              as int?,
      a21: freezed == a21
          ? _self.a21
          : a21 // ignore: cast_nullable_to_non_nullable
              as int?,
      a22: freezed == a22
          ? _self.a22
          : a22 // ignore: cast_nullable_to_non_nullable
              as int?,
      a23: freezed == a23
          ? _self.a23
          : a23 // ignore: cast_nullable_to_non_nullable
              as int?,
      a24: freezed == a24
          ? _self.a24
          : a24 // ignore: cast_nullable_to_non_nullable
              as int?,
      a25: freezed == a25
          ? _self.a25
          : a25 // ignore: cast_nullable_to_non_nullable
              as int?,
      a26: freezed == a26
          ? _self.a26
          : a26 // ignore: cast_nullable_to_non_nullable
              as int?,
      a27: freezed == a27
          ? _self.a27
          : a27 // ignore: cast_nullable_to_non_nullable
              as int?,
      a28: freezed == a28
          ? _self.a28
          : a28 // ignore: cast_nullable_to_non_nullable
              as int?,
      a29: freezed == a29
          ? _self.a29
          : a29 // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
mixin _$Regression131 {
  String get versionName;

  /// Create a copy of Regression131
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Regression131CopyWith<Regression131> get copyWith =>
      _$Regression131CopyWithImpl<Regression131>(
          this as Regression131, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Regression131 &&
            (identical(other.versionName, versionName) ||
                other.versionName == versionName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, versionName);

  @override
  String toString() {
    return 'Regression131(versionName: $versionName)';
  }
}

/// @nodoc
abstract mixin class $Regression131CopyWith<$Res> {
  factory $Regression131CopyWith(
          Regression131 value, $Res Function(Regression131) _then) =
      _$Regression131CopyWithImpl;
  @useResult
  $Res call({String versionName});
}

/// @nodoc
class _$Regression131CopyWithImpl<$Res>
    implements $Regression131CopyWith<$Res> {
  _$Regression131CopyWithImpl(this._self, this._then);

  final Regression131 _self;
  final $Res Function(Regression131) _then;

  /// Create a copy of Regression131
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? versionName = null,
  }) {
    return _then(_self.copyWith(
      versionName: null == versionName
          ? _self.versionName
          : versionName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [Regression131].
extension Regression131Patterns on Regression131 {
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
    TResult Function(_Regression131 value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Regression131() when $default != null:
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
    TResult Function(_Regression131 value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression131():
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
    TResult? Function(_Regression131 value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression131() when $default != null:
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
    TResult Function(String versionName)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Regression131() when $default != null:
        return $default(_that.versionName);
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
    TResult Function(String versionName) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression131():
        return $default(_that.versionName);
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
    TResult? Function(String versionName)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression131() when $default != null:
        return $default(_that.versionName);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Regression131 extends Regression131 {
  _Regression131(this.versionName) : super._();

  @override
  final String versionName;

  /// Create a copy of Regression131
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$Regression131CopyWith<_Regression131> get copyWith =>
      __$Regression131CopyWithImpl<_Regression131>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Regression131 &&
            (identical(other.versionName, versionName) ||
                other.versionName == versionName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, versionName);

  @override
  String toString() {
    return 'Regression131(versionName: $versionName)';
  }
}

/// @nodoc
abstract mixin class _$Regression131CopyWith<$Res>
    implements $Regression131CopyWith<$Res> {
  factory _$Regression131CopyWith(
          _Regression131 value, $Res Function(_Regression131) _then) =
      __$Regression131CopyWithImpl;
  @override
  @useResult
  $Res call({String versionName});
}

/// @nodoc
class __$Regression131CopyWithImpl<$Res>
    implements _$Regression131CopyWith<$Res> {
  __$Regression131CopyWithImpl(this._self, this._then);

  final _Regression131 _self;
  final $Res Function(_Regression131) _then;

  /// Create a copy of Regression131
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? versionName = null,
  }) {
    return _then(_Regression131(
      null == versionName
          ? _self.versionName
          : versionName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$UnimplementedGetter {
  int get value;

  /// Create a copy of UnimplementedGetter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnimplementedGetterCopyWith<UnimplementedGetter> get copyWith =>
      _$UnimplementedGetterCopyWithImpl<UnimplementedGetter>(
          this as UnimplementedGetter, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnimplementedGetter &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'UnimplementedGetter(value: $value)';
  }
}

/// @nodoc
abstract mixin class $UnimplementedGetterCopyWith<$Res> {
  factory $UnimplementedGetterCopyWith(
          UnimplementedGetter value, $Res Function(UnimplementedGetter) _then) =
      _$UnimplementedGetterCopyWithImpl;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$UnimplementedGetterCopyWithImpl<$Res>
    implements $UnimplementedGetterCopyWith<$Res> {
  _$UnimplementedGetterCopyWithImpl(this._self, this._then);

  final UnimplementedGetter _self;
  final $Res Function(UnimplementedGetter) _then;

  /// Create a copy of UnimplementedGetter
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

/// Adds pattern-matching-related methods to [UnimplementedGetter].
extension UnimplementedGetterPatterns on UnimplementedGetter {
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
    TResult Function(_UnimplementedGetter value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnimplementedGetter() when $default != null:
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
    TResult Function(_UnimplementedGetter value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UnimplementedGetter():
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
    TResult? Function(_UnimplementedGetter value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UnimplementedGetter() when $default != null:
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
      case _UnimplementedGetter() when $default != null:
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
      case _UnimplementedGetter():
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
      case _UnimplementedGetter() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _UnimplementedGetter implements UnimplementedGetter {
  _UnimplementedGetter(this.value);

  @override
  final int value;

  /// Create a copy of UnimplementedGetter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnimplementedGetterCopyWith<_UnimplementedGetter> get copyWith =>
      __$UnimplementedGetterCopyWithImpl<_UnimplementedGetter>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnimplementedGetter &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'UnimplementedGetter(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$UnimplementedGetterCopyWith<$Res>
    implements $UnimplementedGetterCopyWith<$Res> {
  factory _$UnimplementedGetterCopyWith(_UnimplementedGetter value,
          $Res Function(_UnimplementedGetter) _then) =
      __$UnimplementedGetterCopyWithImpl;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$UnimplementedGetterCopyWithImpl<$Res>
    implements _$UnimplementedGetterCopyWith<$Res> {
  __$UnimplementedGetterCopyWithImpl(this._self, this._then);

  final _UnimplementedGetter _self;
  final $Res Function(_UnimplementedGetter) _then;

  /// Create a copy of UnimplementedGetter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_UnimplementedGetter(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$Assertion {
  int get a;
  int get b;

  /// Create a copy of Assertion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AssertionCopyWith<Assertion> get copyWith =>
      _$AssertionCopyWithImpl<Assertion>(this as Assertion, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Assertion &&
            (identical(other.a, a) || other.a == a) &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a, b);

  @override
  String toString() {
    return 'Assertion(a: $a, b: $b)';
  }
}

/// @nodoc
abstract mixin class $AssertionCopyWith<$Res> {
  factory $AssertionCopyWith(Assertion value, $Res Function(Assertion) _then) =
      _$AssertionCopyWithImpl;
  @useResult
  $Res call({int a, int b});
}

/// @nodoc
class _$AssertionCopyWithImpl<$Res> implements $AssertionCopyWith<$Res> {
  _$AssertionCopyWithImpl(this._self, this._then);

  final Assertion _self;
  final $Res Function(Assertion) _then;

  /// Create a copy of Assertion
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
              as int,
      b: null == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [Assertion].
extension AssertionPatterns on Assertion {
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
    TResult Function(_Assertion value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Assertion() when $default != null:
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
    TResult Function(_Assertion value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Assertion():
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
    TResult? Function(_Assertion value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Assertion() when $default != null:
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
    TResult Function(int a, int b)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Assertion() when $default != null:
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
    TResult Function(int a, int b) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Assertion():
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
    TResult? Function(int a, int b)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Assertion() when $default != null:
        return $default(_that.a, _that.b);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Assertion implements Assertion {
  _Assertion(this.a, this.b)
      : assert(a > 0),
        assert(b > a);

  @override
  final int a;
  @override
  final int b;

  /// Create a copy of Assertion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AssertionCopyWith<_Assertion> get copyWith =>
      __$AssertionCopyWithImpl<_Assertion>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Assertion &&
            (identical(other.a, a) || other.a == a) &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a, b);

  @override
  String toString() {
    return 'Assertion(a: $a, b: $b)';
  }
}

/// @nodoc
abstract mixin class _$AssertionCopyWith<$Res>
    implements $AssertionCopyWith<$Res> {
  factory _$AssertionCopyWith(
          _Assertion value, $Res Function(_Assertion) _then) =
      __$AssertionCopyWithImpl;
  @override
  @useResult
  $Res call({int a, int b});
}

/// @nodoc
class __$AssertionCopyWithImpl<$Res> implements _$AssertionCopyWith<$Res> {
  __$AssertionCopyWithImpl(this._self, this._then);

  final _Assertion _self;
  final $Res Function(_Assertion) _then;

  /// Create a copy of Assertion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
    Object? b = null,
  }) {
    return _then(_Assertion(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
      null == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$Doc326 {
  int? get named;

  /// Create a copy of Doc326
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Doc326CopyWith<Doc326> get copyWith =>
      _$Doc326CopyWithImpl<Doc326>(this as Doc326, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Doc326 &&
            (identical(other.named, named) || other.named == named));
  }

  @override
  int get hashCode => Object.hash(runtimeType, named);

  @override
  String toString() {
    return 'Doc326(named: $named)';
  }
}

/// @nodoc
abstract mixin class $Doc326CopyWith<$Res> {
  factory $Doc326CopyWith(Doc326 value, $Res Function(Doc326) _then) =
      _$Doc326CopyWithImpl;
  @useResult
  $Res call({int? named});
}

/// @nodoc
class _$Doc326CopyWithImpl<$Res> implements $Doc326CopyWith<$Res> {
  _$Doc326CopyWithImpl(this._self, this._then);

  final Doc326 _self;
  final $Res Function(Doc326) _then;

  /// Create a copy of Doc326
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? named = freezed,
  }) {
    return _then(_self.copyWith(
      named: freezed == named
          ? _self.named
          : named // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Doc326].
extension Doc326Patterns on Doc326 {
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
    TResult Function(_Doc326 value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Doc326() when $default != null:
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
    TResult Function(_Doc326 value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Doc326():
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
    TResult? Function(_Doc326 value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Doc326() when $default != null:
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
    TResult Function(int? named)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Doc326() when $default != null:
        return $default(_that.named);
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
    TResult Function(int? named) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Doc326():
        return $default(_that.named);
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
    TResult? Function(int? named)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Doc326() when $default != null:
        return $default(_that.named);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Doc326 implements Doc326 {
  _Doc326({this.named});

  @override
  final int? named;

  /// Create a copy of Doc326
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$Doc326CopyWith<_Doc326> get copyWith =>
      __$Doc326CopyWithImpl<_Doc326>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Doc326 &&
            (identical(other.named, named) || other.named == named));
  }

  @override
  int get hashCode => Object.hash(runtimeType, named);

  @override
  String toString() {
    return 'Doc326(named: $named)';
  }
}

/// @nodoc
abstract mixin class _$Doc326CopyWith<$Res> implements $Doc326CopyWith<$Res> {
  factory _$Doc326CopyWith(_Doc326 value, $Res Function(_Doc326) _then) =
      __$Doc326CopyWithImpl;
  @override
  @useResult
  $Res call({int? named});
}

/// @nodoc
class __$Doc326CopyWithImpl<$Res> implements _$Doc326CopyWith<$Res> {
  __$Doc326CopyWithImpl(this._self, this._then);

  final _Doc326 _self;
  final $Res Function(_Doc326) _then;

  /// Create a copy of Doc326
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? named = freezed,
  }) {
    return _then(_Doc326(
      named: freezed == named
          ? _self.named
          : named // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
mixin _$Doc317 {
  /// )
  int? get named;

  /// Create a copy of Doc317
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Doc317CopyWith<Doc317> get copyWith =>
      _$Doc317CopyWithImpl<Doc317>(this as Doc317, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Doc317 &&
            (identical(other.named, named) || other.named == named));
  }

  @override
  int get hashCode => Object.hash(runtimeType, named);

  @override
  String toString() {
    return 'Doc317(named: $named)';
  }
}

/// @nodoc
abstract mixin class $Doc317CopyWith<$Res> {
  factory $Doc317CopyWith(Doc317 value, $Res Function(Doc317) _then) =
      _$Doc317CopyWithImpl;
  @useResult
  $Res call({int? named});
}

/// @nodoc
class _$Doc317CopyWithImpl<$Res> implements $Doc317CopyWith<$Res> {
  _$Doc317CopyWithImpl(this._self, this._then);

  final Doc317 _self;
  final $Res Function(Doc317) _then;

  /// Create a copy of Doc317
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? named = freezed,
  }) {
    return _then(_self.copyWith(
      named: freezed == named
          ? _self.named
          : named // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Doc317].
extension Doc317Patterns on Doc317 {
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
    TResult Function(_Doc317 value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Doc317() when $default != null:
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
    TResult Function(_Doc317 value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Doc317():
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
    TResult? Function(_Doc317 value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Doc317() when $default != null:
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
    TResult Function(int? named)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Doc317() when $default != null:
        return $default(_that.named);
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
    TResult Function(int? named) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Doc317():
        return $default(_that.named);
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
    TResult? Function(int? named)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Doc317() when $default != null:
        return $default(_that.named);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Doc317 implements Doc317 {
  _Doc317({this.named});

  /// )
  @override
  final int? named;

  /// Create a copy of Doc317
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$Doc317CopyWith<_Doc317> get copyWith =>
      __$Doc317CopyWithImpl<_Doc317>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Doc317 &&
            (identical(other.named, named) || other.named == named));
  }

  @override
  int get hashCode => Object.hash(runtimeType, named);

  @override
  String toString() {
    return 'Doc317(named: $named)';
  }
}

/// @nodoc
abstract mixin class _$Doc317CopyWith<$Res> implements $Doc317CopyWith<$Res> {
  factory _$Doc317CopyWith(_Doc317 value, $Res Function(_Doc317) _then) =
      __$Doc317CopyWithImpl;
  @override
  @useResult
  $Res call({int? named});
}

/// @nodoc
class __$Doc317CopyWithImpl<$Res> implements _$Doc317CopyWith<$Res> {
  __$Doc317CopyWithImpl(this._self, this._then);

  final _Doc317 _self;
  final $Res Function(_Doc317) _then;

  /// Create a copy of Doc317
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? named = freezed,
  }) {
    return _then(_Doc317(
      named: freezed == named
          ? _self.named
          : named // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
mixin _$Doc {
  /// Multi
  /// line
  /// positional
  int get positional;

  /// Single line named
  int? get named; // Simple
  int? get simple;

  /// Create a copy of Doc
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DocCopyWith<Doc> get copyWith =>
      _$DocCopyWithImpl<Doc>(this as Doc, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Doc &&
            (identical(other.positional, positional) ||
                other.positional == positional) &&
            (identical(other.named, named) || other.named == named) &&
            (identical(other.simple, simple) || other.simple == simple));
  }

  @override
  int get hashCode => Object.hash(runtimeType, positional, named, simple);

  @override
  String toString() {
    return 'Doc(positional: $positional, named: $named, simple: $simple)';
  }
}

/// @nodoc
abstract mixin class $DocCopyWith<$Res> {
  factory $DocCopyWith(Doc value, $Res Function(Doc) _then) = _$DocCopyWithImpl;
  @useResult
  $Res call({int positional, int? named, int? simple});
}

/// @nodoc
class _$DocCopyWithImpl<$Res> implements $DocCopyWith<$Res> {
  _$DocCopyWithImpl(this._self, this._then);

  final Doc _self;
  final $Res Function(Doc) _then;

  /// Create a copy of Doc
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? positional = null,
    Object? named = freezed,
    Object? simple = freezed,
  }) {
    return _then(_self.copyWith(
      positional: null == positional
          ? _self.positional
          : positional // ignore: cast_nullable_to_non_nullable
              as int,
      named: freezed == named
          ? _self.named
          : named // ignore: cast_nullable_to_non_nullable
              as int?,
      simple: freezed == simple
          ? _self.simple
          : simple // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Doc].
extension DocPatterns on Doc {
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
    TResult Function(_Doc value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Doc() when $default != null:
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
    TResult Function(_Doc value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Doc():
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
    TResult? Function(_Doc value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Doc() when $default != null:
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
    TResult Function(int positional, int? named, int? simple)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Doc() when $default != null:
        return $default(_that.positional, _that.named, _that.simple);
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
    TResult Function(int positional, int? named, int? simple) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Doc():
        return $default(_that.positional, _that.named, _that.simple);
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
    TResult? Function(int positional, int? named, int? simple)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Doc() when $default != null:
        return $default(_that.positional, _that.named, _that.simple);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Doc implements Doc {
  _Doc(this.positional, {this.named, this.simple});

  /// Multi
  /// line
  /// positional
  @override
  final int positional;

  /// Single line named
  @override
  final int? named;
// Simple
  @override
  final int? simple;

  /// Create a copy of Doc
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DocCopyWith<_Doc> get copyWith =>
      __$DocCopyWithImpl<_Doc>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Doc &&
            (identical(other.positional, positional) ||
                other.positional == positional) &&
            (identical(other.named, named) || other.named == named) &&
            (identical(other.simple, simple) || other.simple == simple));
  }

  @override
  int get hashCode => Object.hash(runtimeType, positional, named, simple);

  @override
  String toString() {
    return 'Doc(positional: $positional, named: $named, simple: $simple)';
  }
}

/// @nodoc
abstract mixin class _$DocCopyWith<$Res> implements $DocCopyWith<$Res> {
  factory _$DocCopyWith(_Doc value, $Res Function(_Doc) _then) =
      __$DocCopyWithImpl;
  @override
  @useResult
  $Res call({int positional, int? named, int? simple});
}

/// @nodoc
class __$DocCopyWithImpl<$Res> implements _$DocCopyWith<$Res> {
  __$DocCopyWithImpl(this._self, this._then);

  final _Doc _self;
  final $Res Function(_Doc) _then;

  /// Create a copy of Doc
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? positional = null,
    Object? named = freezed,
    Object? simple = freezed,
  }) {
    return _then(_Doc(
      null == positional
          ? _self.positional
          : positional // ignore: cast_nullable_to_non_nullable
              as int,
      named: freezed == named
          ? _self.named
          : named // ignore: cast_nullable_to_non_nullable
              as int?,
      simple: freezed == simple
          ? _self.simple
          : simple // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
mixin _$Product {
  String? get name;
  Product? get parent;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProductCopyWith<Product> get copyWith =>
      _$ProductCopyWithImpl<Product>(this as Product, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Product &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.parent, parent) || other.parent == parent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, parent);

  @override
  String toString() {
    return 'Product(name: $name, parent: $parent)';
  }
}

/// @nodoc
abstract mixin class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) _then) =
      _$ProductCopyWithImpl;
  @useResult
  $Res call({String? name, Product? parent});

  $ProductCopyWith<$Res>? get parent;
}

/// @nodoc
class _$ProductCopyWithImpl<$Res> implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._self, this._then);

  final Product _self;
  final $Res Function(Product) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? parent = freezed,
  }) {
    return _then(_self.copyWith(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      parent: freezed == parent
          ? _self.parent
          : parent // ignore: cast_nullable_to_non_nullable
              as Product?,
    ));
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res>? get parent {
    if (_self.parent == null) {
      return null;
    }

    return $ProductCopyWith<$Res>(_self.parent!, (value) {
      return _then(_self.copyWith(parent: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Product].
extension ProductPatterns on Product {
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
    TResult Function(_ProductDataClass value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProductDataClass() when $default != null:
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
    TResult Function(_ProductDataClass value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductDataClass():
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
    TResult? Function(_ProductDataClass value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductDataClass() when $default != null:
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
    TResult Function(String? name, Product? parent)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProductDataClass() when $default != null:
        return $default(_that.name, _that.parent);
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
    TResult Function(String? name, Product? parent) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductDataClass():
        return $default(_that.name, _that.parent);
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
    TResult? Function(String? name, Product? parent)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductDataClass() when $default != null:
        return $default(_that.name, _that.parent);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ProductDataClass implements Product {
  const _ProductDataClass({this.name, this.parent});

  @override
  final String? name;
  @override
  final Product? parent;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProductDataClassCopyWith<_ProductDataClass> get copyWith =>
      __$ProductDataClassCopyWithImpl<_ProductDataClass>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProductDataClass &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.parent, parent) || other.parent == parent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, parent);

  @override
  String toString() {
    return 'Product(name: $name, parent: $parent)';
  }
}

/// @nodoc
abstract mixin class _$ProductDataClassCopyWith<$Res>
    implements $ProductCopyWith<$Res> {
  factory _$ProductDataClassCopyWith(
          _ProductDataClass value, $Res Function(_ProductDataClass) _then) =
      __$ProductDataClassCopyWithImpl;
  @override
  @useResult
  $Res call({String? name, Product? parent});

  @override
  $ProductCopyWith<$Res>? get parent;
}

/// @nodoc
class __$ProductDataClassCopyWithImpl<$Res>
    implements _$ProductDataClassCopyWith<$Res> {
  __$ProductDataClassCopyWithImpl(this._self, this._then);

  final _ProductDataClass _self;
  final $Res Function(_ProductDataClass) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = freezed,
    Object? parent = freezed,
  }) {
    return _then(_ProductDataClass(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      parent: freezed == parent
          ? _self.parent
          : parent // ignore: cast_nullable_to_non_nullable
              as Product?,
    ));
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res>? get parent {
    if (_self.parent == null) {
      return null;
    }

    return $ProductCopyWith<$Res>(_self.parent!, (value) {
      return _then(_self.copyWith(parent: value));
    });
  }
}

/// @nodoc
mixin _$Test {
  Completer<void> get completer;

  /// Create a copy of Test
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TestCopyWith<Test> get copyWith =>
      _$TestCopyWithImpl<Test>(this as Test, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Test &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, completer);

  @override
  String toString() {
    return 'Test(completer: $completer)';
  }
}

/// @nodoc
abstract mixin class $TestCopyWith<$Res> {
  factory $TestCopyWith(Test value, $Res Function(Test) _then) =
      _$TestCopyWithImpl;
  @useResult
  $Res call({Completer<void> completer});
}

/// @nodoc
class _$TestCopyWithImpl<$Res> implements $TestCopyWith<$Res> {
  _$TestCopyWithImpl(this._self, this._then);

  final Test _self;
  final $Res Function(Test) _then;

  /// Create a copy of Test
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? completer = null,
  }) {
    return _then(_self.copyWith(
      completer: null == completer
          ? _self.completer
          : completer // ignore: cast_nullable_to_non_nullable
              as Completer<void>,
    ));
  }
}

/// Adds pattern-matching-related methods to [Test].
extension TestPatterns on Test {
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
    TResult Function(TestSomething value)? something,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case TestSomething() when something != null:
        return something(_that);
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
    required TResult Function(TestSomething value) something,
  }) {
    final _that = this;
    switch (_that) {
      case TestSomething():
        return something(_that);
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
    TResult? Function(TestSomething value)? something,
  }) {
    final _that = this;
    switch (_that) {
      case TestSomething() when something != null:
        return something(_that);
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
    TResult Function(Completer<void> completer)? something,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case TestSomething() when something != null:
        return something(_that.completer);
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
    required TResult Function(Completer<void> completer) something,
  }) {
    final _that = this;
    switch (_that) {
      case TestSomething():
        return something(_that.completer);
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
    TResult? Function(Completer<void> completer)? something,
  }) {
    final _that = this;
    switch (_that) {
      case TestSomething() when something != null:
        return something(_that.completer);
      case _:
        return null;
    }
  }
}

/// @nodoc

class TestSomething implements Test {
  const TestSomething(this.completer);

  @override
  final Completer<void> completer;

  /// Create a copy of Test
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TestSomethingCopyWith<TestSomething> get copyWith =>
      _$TestSomethingCopyWithImpl<TestSomething>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TestSomething &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, completer);

  @override
  String toString() {
    return 'Test.something(completer: $completer)';
  }
}

/// @nodoc
abstract mixin class $TestSomethingCopyWith<$Res>
    implements $TestCopyWith<$Res> {
  factory $TestSomethingCopyWith(
          TestSomething value, $Res Function(TestSomething) _then) =
      _$TestSomethingCopyWithImpl;
  @override
  @useResult
  $Res call({Completer<void> completer});
}

/// @nodoc
class _$TestSomethingCopyWithImpl<$Res>
    implements $TestSomethingCopyWith<$Res> {
  _$TestSomethingCopyWithImpl(this._self, this._then);

  final TestSomething _self;
  final $Res Function(TestSomething) _then;

  /// Create a copy of Test
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? completer = null,
  }) {
    return _then(TestSomething(
      null == completer
          ? _self.completer
          : completer // ignore: cast_nullable_to_non_nullable
              as Completer<void>,
    ));
  }
}

/// @nodoc
mixin _$Private {
  Iterable<String> get items;

  /// Create a copy of Private
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PrivateCopyWith<Private> get copyWith =>
      _$PrivateCopyWithImpl<Private>(this as Private, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Private &&
            const DeepCollectionEquality().equals(other.items, items));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(items));

  @override
  String toString() {
    return 'Private(items: $items)';
  }
}

/// @nodoc
abstract mixin class $PrivateCopyWith<$Res> {
  factory $PrivateCopyWith(Private value, $Res Function(Private) _then) =
      _$PrivateCopyWithImpl;
  @useResult
  $Res call({Iterable<String> items});
}

/// @nodoc
class _$PrivateCopyWithImpl<$Res> implements $PrivateCopyWith<$Res> {
  _$PrivateCopyWithImpl(this._self, this._then);

  final Private _self;
  final $Res Function(Private) _then;

  /// Create a copy of Private
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_self.copyWith(
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as Iterable<String>,
    ));
  }
}

/// @nodoc

class _Private implements Private {
  const _Private(this.items);

  @override
  final Iterable<String> items;

  /// Create a copy of Private
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PrivateCopyWith<_Private> get copyWith =>
      __$PrivateCopyWithImpl<_Private>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Private &&
            const DeepCollectionEquality().equals(other.items, items));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(items));

  @override
  String toString() {
    return 'Private._internal(items: $items)';
  }
}

/// @nodoc
abstract mixin class _$PrivateCopyWith<$Res> implements $PrivateCopyWith<$Res> {
  factory _$PrivateCopyWith(_Private value, $Res Function(_Private) _then) =
      __$PrivateCopyWithImpl;
  @override
  @useResult
  $Res call({Iterable<String> items});
}

/// @nodoc
class __$PrivateCopyWithImpl<$Res> implements _$PrivateCopyWith<$Res> {
  __$PrivateCopyWithImpl(this._self, this._then);

  final _Private _self;
  final $Res Function(_Private) _then;

  /// Create a copy of Private
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? items = null,
  }) {
    return _then(_Private(
      null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as Iterable<String>,
    ));
  }
}

/// @nodoc
mixin _$MyClass {
  String? get a;
  int? get b;

  /// Create a copy of MyClass
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MyClassCopyWith<MyClass> get copyWith =>
      _$MyClassCopyWithImpl<MyClass>(this as MyClass, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MyClass &&
            (identical(other.a, a) || other.a == a) &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a, b);

  @override
  String toString() {
    return 'MyClass(a: $a, b: $b)';
  }
}

/// @nodoc
abstract mixin class $MyClassCopyWith<$Res> {
  factory $MyClassCopyWith(MyClass value, $Res Function(MyClass) _then) =
      _$MyClassCopyWithImpl;
  @useResult
  $Res call({String? a, int? b});
}

/// @nodoc
class _$MyClassCopyWithImpl<$Res> implements $MyClassCopyWith<$Res> {
  _$MyClassCopyWithImpl(this._self, this._then);

  final MyClass _self;
  final $Res Function(MyClass) _then;

  /// Create a copy of MyClass
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

/// Adds pattern-matching-related methods to [MyClass].
extension MyClassPatterns on MyClass {
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
    TResult Function(WhateverIWant value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case WhateverIWant() when $default != null:
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
    TResult Function(WhateverIWant value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case WhateverIWant():
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
    TResult? Function(WhateverIWant value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case WhateverIWant() when $default != null:
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
      case WhateverIWant() when $default != null:
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
      case WhateverIWant():
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
      case WhateverIWant() when $default != null:
        return $default(_that.a, _that.b);
      case _:
        return null;
    }
  }
}

/// @nodoc

class WhateverIWant implements MyClass {
  const WhateverIWant({this.a, this.b});

  @override
  final String? a;
  @override
  final int? b;

  /// Create a copy of MyClass
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WhateverIWantCopyWith<WhateverIWant> get copyWith =>
      _$WhateverIWantCopyWithImpl<WhateverIWant>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WhateverIWant &&
            (identical(other.a, a) || other.a == a) &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a, b);

  @override
  String toString() {
    return 'MyClass(a: $a, b: $b)';
  }
}

/// @nodoc
abstract mixin class $WhateverIWantCopyWith<$Res>
    implements $MyClassCopyWith<$Res> {
  factory $WhateverIWantCopyWith(
          WhateverIWant value, $Res Function(WhateverIWant) _then) =
      _$WhateverIWantCopyWithImpl;
  @override
  @useResult
  $Res call({String? a, int? b});
}

/// @nodoc
class _$WhateverIWantCopyWithImpl<$Res>
    implements $WhateverIWantCopyWith<$Res> {
  _$WhateverIWantCopyWithImpl(this._self, this._then);

  final WhateverIWant _self;
  final $Res Function(WhateverIWant) _then;

  /// Create a copy of MyClass
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = freezed,
    Object? b = freezed,
  }) {
    return _then(WhateverIWant(
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

/// @nodoc
mixin _$MixedParam {
  String get a;
  int? get b;

  /// Create a copy of MixedParam
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MixedParamCopyWith<MixedParam> get copyWith =>
      _$MixedParamCopyWithImpl<MixedParam>(this as MixedParam, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MixedParam &&
            (identical(other.a, a) || other.a == a) &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a, b);

  @override
  String toString() {
    return 'MixedParam(a: $a, b: $b)';
  }
}

/// @nodoc
abstract mixin class $MixedParamCopyWith<$Res> {
  factory $MixedParamCopyWith(
          MixedParam value, $Res Function(MixedParam) _then) =
      _$MixedParamCopyWithImpl;
  @useResult
  $Res call({String a, int? b});
}

/// @nodoc
class _$MixedParamCopyWithImpl<$Res> implements $MixedParamCopyWith<$Res> {
  _$MixedParamCopyWithImpl(this._self, this._then);

  final MixedParam _self;
  final $Res Function(MixedParam) _then;

  /// Create a copy of MixedParam
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? a = null,
    Object? b = freezed,
  }) {
    return _then(_self.copyWith(
      a: null == a
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

/// Adds pattern-matching-related methods to [MixedParam].
extension MixedParamPatterns on MixedParam {
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
    TResult Function(WhateverMixedParam value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case WhateverMixedParam() when $default != null:
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
    TResult Function(WhateverMixedParam value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case WhateverMixedParam():
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
    TResult? Function(WhateverMixedParam value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case WhateverMixedParam() when $default != null:
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
    TResult Function(String a, int? b)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case WhateverMixedParam() when $default != null:
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
    TResult Function(String a, int? b) $default,
  ) {
    final _that = this;
    switch (_that) {
      case WhateverMixedParam():
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
    TResult? Function(String a, int? b)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case WhateverMixedParam() when $default != null:
        return $default(_that.a, _that.b);
      case _:
        return null;
    }
  }
}

/// @nodoc

class WhateverMixedParam implements MixedParam {
  const WhateverMixedParam(this.a, {this.b});

  @override
  final String a;
  @override
  final int? b;

  /// Create a copy of MixedParam
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WhateverMixedParamCopyWith<WhateverMixedParam> get copyWith =>
      _$WhateverMixedParamCopyWithImpl<WhateverMixedParam>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WhateverMixedParam &&
            (identical(other.a, a) || other.a == a) &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a, b);

  @override
  String toString() {
    return 'MixedParam(a: $a, b: $b)';
  }
}

/// @nodoc
abstract mixin class $WhateverMixedParamCopyWith<$Res>
    implements $MixedParamCopyWith<$Res> {
  factory $WhateverMixedParamCopyWith(
          WhateverMixedParam value, $Res Function(WhateverMixedParam) _then) =
      _$WhateverMixedParamCopyWithImpl;
  @override
  @useResult
  $Res call({String a, int? b});
}

/// @nodoc
class _$WhateverMixedParamCopyWithImpl<$Res>
    implements $WhateverMixedParamCopyWith<$Res> {
  _$WhateverMixedParamCopyWithImpl(this._self, this._then);

  final WhateverMixedParam _self;
  final $Res Function(WhateverMixedParam) _then;

  /// Create a copy of MixedParam
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
    Object? b = freezed,
  }) {
    return _then(WhateverMixedParam(
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
mixin _$PositionalMixedParam {
  String get a;
  int? get b;

  /// Create a copy of PositionalMixedParam
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PositionalMixedParamCopyWith<PositionalMixedParam> get copyWith =>
      _$PositionalMixedParamCopyWithImpl<PositionalMixedParam>(
          this as PositionalMixedParam, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PositionalMixedParam &&
            (identical(other.a, a) || other.a == a) &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a, b);

  @override
  String toString() {
    return 'PositionalMixedParam(a: $a, b: $b)';
  }
}

/// @nodoc
abstract mixin class $PositionalMixedParamCopyWith<$Res> {
  factory $PositionalMixedParamCopyWith(PositionalMixedParam value,
          $Res Function(PositionalMixedParam) _then) =
      _$PositionalMixedParamCopyWithImpl;
  @useResult
  $Res call({String a, int? b});
}

/// @nodoc
class _$PositionalMixedParamCopyWithImpl<$Res>
    implements $PositionalMixedParamCopyWith<$Res> {
  _$PositionalMixedParamCopyWithImpl(this._self, this._then);

  final PositionalMixedParam _self;
  final $Res Function(PositionalMixedParam) _then;

  /// Create a copy of PositionalMixedParam
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? a = null,
    Object? b = freezed,
  }) {
    return _then(_self.copyWith(
      a: null == a
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

/// Adds pattern-matching-related methods to [PositionalMixedParam].
extension PositionalMixedParamPatterns on PositionalMixedParam {
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
    TResult Function(WhateverPositionalMixedParam value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case WhateverPositionalMixedParam() when $default != null:
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
    TResult Function(WhateverPositionalMixedParam value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case WhateverPositionalMixedParam():
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
    TResult? Function(WhateverPositionalMixedParam value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case WhateverPositionalMixedParam() when $default != null:
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
    TResult Function(String a, int? b)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case WhateverPositionalMixedParam() when $default != null:
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
    TResult Function(String a, int? b) $default,
  ) {
    final _that = this;
    switch (_that) {
      case WhateverPositionalMixedParam():
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
    TResult? Function(String a, int? b)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case WhateverPositionalMixedParam() when $default != null:
        return $default(_that.a, _that.b);
      case _:
        return null;
    }
  }
}

/// @nodoc

class WhateverPositionalMixedParam implements PositionalMixedParam {
  const WhateverPositionalMixedParam(this.a, [this.b]);

  @override
  final String a;
  @override
  final int? b;

  /// Create a copy of PositionalMixedParam
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WhateverPositionalMixedParamCopyWith<WhateverPositionalMixedParam>
      get copyWith => _$WhateverPositionalMixedParamCopyWithImpl<
          WhateverPositionalMixedParam>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WhateverPositionalMixedParam &&
            (identical(other.a, a) || other.a == a) &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a, b);

  @override
  String toString() {
    return 'PositionalMixedParam(a: $a, b: $b)';
  }
}

/// @nodoc
abstract mixin class $WhateverPositionalMixedParamCopyWith<$Res>
    implements $PositionalMixedParamCopyWith<$Res> {
  factory $WhateverPositionalMixedParamCopyWith(
          WhateverPositionalMixedParam value,
          $Res Function(WhateverPositionalMixedParam) _then) =
      _$WhateverPositionalMixedParamCopyWithImpl;
  @override
  @useResult
  $Res call({String a, int? b});
}

/// @nodoc
class _$WhateverPositionalMixedParamCopyWithImpl<$Res>
    implements $WhateverPositionalMixedParamCopyWith<$Res> {
  _$WhateverPositionalMixedParamCopyWithImpl(this._self, this._then);

  final WhateverPositionalMixedParam _self;
  final $Res Function(WhateverPositionalMixedParam) _then;

  /// Create a copy of PositionalMixedParam
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
    Object? b = freezed,
  }) {
    return _then(WhateverPositionalMixedParam(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
mixin _$Required {
  String? get a;

  /// Create a copy of Required
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RequiredCopyWith<Required> get copyWith =>
      _$RequiredCopyWithImpl<Required>(this as Required, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Required &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'Required(a: $a)';
  }
}

/// @nodoc
abstract mixin class $RequiredCopyWith<$Res> {
  factory $RequiredCopyWith(Required value, $Res Function(Required) _then) =
      _$RequiredCopyWithImpl;
  @useResult
  $Res call({String? a});
}

/// @nodoc
class _$RequiredCopyWithImpl<$Res> implements $RequiredCopyWith<$Res> {
  _$RequiredCopyWithImpl(this._self, this._then);

  final Required _self;
  final $Res Function(Required) _then;

  /// Create a copy of Required
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

/// Adds pattern-matching-related methods to [Required].
extension RequiredPatterns on Required {
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
    TResult Function(WhateverRequired value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case WhateverRequired() when $default != null:
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
    TResult Function(WhateverRequired value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case WhateverRequired():
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
    TResult? Function(WhateverRequired value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case WhateverRequired() when $default != null:
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
    TResult Function(String? a)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case WhateverRequired() when $default != null:
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
    TResult Function(String? a) $default,
  ) {
    final _that = this;
    switch (_that) {
      case WhateverRequired():
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
    TResult? Function(String? a)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case WhateverRequired() when $default != null:
        return $default(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

class WhateverRequired implements Required {
  const WhateverRequired({required this.a});

  @override
  final String? a;

  /// Create a copy of Required
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WhateverRequiredCopyWith<WhateverRequired> get copyWith =>
      _$WhateverRequiredCopyWithImpl<WhateverRequired>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WhateverRequired &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'Required(a: $a)';
  }
}

/// @nodoc
abstract mixin class $WhateverRequiredCopyWith<$Res>
    implements $RequiredCopyWith<$Res> {
  factory $WhateverRequiredCopyWith(
          WhateverRequired value, $Res Function(WhateverRequired) _then) =
      _$WhateverRequiredCopyWithImpl;
  @override
  @useResult
  $Res call({String? a});
}

/// @nodoc
class _$WhateverRequiredCopyWithImpl<$Res>
    implements $WhateverRequiredCopyWith<$Res> {
  _$WhateverRequiredCopyWithImpl(this._self, this._then);

  final WhateverRequired _self;
  final $Res Function(WhateverRequired) _then;

  /// Create a copy of Required
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = freezed,
  }) {
    return _then(WhateverRequired(
      a: freezed == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$Empty {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Empty);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Empty()';
  }
}

/// @nodoc
class $EmptyCopyWith<$Res> {
  $EmptyCopyWith(Empty _, $Res Function(Empty) __);
}

/// Adds pattern-matching-related methods to [Empty].
extension EmptyPatterns on Empty {
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
    TResult Function(WhateverEmpty value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case WhateverEmpty() when $default != null:
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
    TResult Function(WhateverEmpty value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case WhateverEmpty():
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
    TResult? Function(WhateverEmpty value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case WhateverEmpty() when $default != null:
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
    TResult Function()? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case WhateverEmpty() when $default != null:
        return $default();
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
    TResult Function() $default,
  ) {
    final _that = this;
    switch (_that) {
      case WhateverEmpty():
        return $default();
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
    TResult? Function()? $default,
  ) {
    final _that = this;
    switch (_that) {
      case WhateverEmpty() when $default != null:
        return $default();
      case _:
        return null;
    }
  }
}

/// @nodoc

class WhateverEmpty implements Empty {
  const WhateverEmpty();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is WhateverEmpty);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Empty()';
  }
}

/// @nodoc
mixin _$Empty2 {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Empty2);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Empty2()';
  }
}

/// @nodoc
class $Empty2CopyWith<$Res> {
  $Empty2CopyWith(Empty2 _, $Res Function(Empty2) __);
}

/// Adds pattern-matching-related methods to [Empty2].
extension Empty2Patterns on Empty2 {
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
    TResult Function(WhateverEmpty2 value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case WhateverEmpty2() when $default != null:
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
    TResult Function(WhateverEmpty2 value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case WhateverEmpty2():
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
    TResult? Function(WhateverEmpty2 value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case WhateverEmpty2() when $default != null:
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
    TResult Function()? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case WhateverEmpty2() when $default != null:
        return $default();
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
    TResult Function() $default,
  ) {
    final _that = this;
    switch (_that) {
      case WhateverEmpty2():
        return $default();
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
    TResult? Function()? $default,
  ) {
    final _that = this;
    switch (_that) {
      case WhateverEmpty2() when $default != null:
        return $default();
      case _:
        return null;
    }
  }
}

/// @nodoc

class WhateverEmpty2 implements Empty2 {
  const WhateverEmpty2();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is WhateverEmpty2);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Empty2()';
  }
}

/// @nodoc
mixin _$SingleNamedCtor {
  int get a;

  /// Create a copy of SingleNamedCtor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SingleNamedCtorCopyWith<SingleNamedCtor> get copyWith =>
      _$SingleNamedCtorCopyWithImpl<SingleNamedCtor>(
          this as SingleNamedCtor, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SingleNamedCtor &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'SingleNamedCtor(a: $a)';
  }
}

/// @nodoc
abstract mixin class $SingleNamedCtorCopyWith<$Res> {
  factory $SingleNamedCtorCopyWith(
          SingleNamedCtor value, $Res Function(SingleNamedCtor) _then) =
      _$SingleNamedCtorCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$SingleNamedCtorCopyWithImpl<$Res>
    implements $SingleNamedCtorCopyWith<$Res> {
  _$SingleNamedCtorCopyWithImpl(this._self, this._then);

  final SingleNamedCtor _self;
  final $Res Function(SingleNamedCtor) _then;

  /// Create a copy of SingleNamedCtor
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

/// Adds pattern-matching-related methods to [SingleNamedCtor].
extension SingleNamedCtorPatterns on SingleNamedCtor {
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
    TResult Function(WhateverSingleNamedCtor value)? named,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case WhateverSingleNamedCtor() when named != null:
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
  TResult map<TResult extends Object?>({
    required TResult Function(WhateverSingleNamedCtor value) named,
  }) {
    final _that = this;
    switch (_that) {
      case WhateverSingleNamedCtor():
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WhateverSingleNamedCtor value)? named,
  }) {
    final _that = this;
    switch (_that) {
      case WhateverSingleNamedCtor() when named != null:
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int a)? named,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case WhateverSingleNamedCtor() when named != null:
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
  TResult when<TResult extends Object?>({
    required TResult Function(int a) named,
  }) {
    final _that = this;
    switch (_that) {
      case WhateverSingleNamedCtor():
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int a)? named,
  }) {
    final _that = this;
    switch (_that) {
      case WhateverSingleNamedCtor() when named != null:
        return named(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

class WhateverSingleNamedCtor implements SingleNamedCtor {
  const WhateverSingleNamedCtor(this.a);

  @override
  final int a;

  /// Create a copy of SingleNamedCtor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WhateverSingleNamedCtorCopyWith<WhateverSingleNamedCtor> get copyWith =>
      _$WhateverSingleNamedCtorCopyWithImpl<WhateverSingleNamedCtor>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WhateverSingleNamedCtor &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'SingleNamedCtor.named(a: $a)';
  }
}

/// @nodoc
abstract mixin class $WhateverSingleNamedCtorCopyWith<$Res>
    implements $SingleNamedCtorCopyWith<$Res> {
  factory $WhateverSingleNamedCtorCopyWith(WhateverSingleNamedCtor value,
          $Res Function(WhateverSingleNamedCtor) _then) =
      _$WhateverSingleNamedCtorCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$WhateverSingleNamedCtorCopyWithImpl<$Res>
    implements $WhateverSingleNamedCtorCopyWith<$Res> {
  _$WhateverSingleNamedCtorCopyWithImpl(this._self, this._then);

  final WhateverSingleNamedCtor _self;
  final $Res Function(WhateverSingleNamedCtor) _then;

  /// Create a copy of SingleNamedCtor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(WhateverSingleNamedCtor(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
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
    TResult Function(GenericA<T> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case GenericA() when $default != null:
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
    TResult Function(GenericA<T> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case GenericA():
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
    TResult? Function(GenericA<T> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case GenericA() when $default != null:
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
      case GenericA() when $default != null:
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
      case GenericA():
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
      case GenericA() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class GenericA<T> implements Generic<T> {
  const GenericA(this.value);

  @override
  final T value;

  /// Create a copy of Generic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GenericACopyWith<T, GenericA<T>> get copyWith =>
      _$GenericACopyWithImpl<T, GenericA<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GenericA<T> &&
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
abstract mixin class $GenericACopyWith<T, $Res>
    implements $GenericCopyWith<T, $Res> {
  factory $GenericACopyWith(
          GenericA<T> value, $Res Function(GenericA<T>) _then) =
      _$GenericACopyWithImpl;
  @override
  @useResult
  $Res call({T value});
}

/// @nodoc
class _$GenericACopyWithImpl<T, $Res> implements $GenericACopyWith<T, $Res> {
  _$GenericACopyWithImpl(this._self, this._then);

  final GenericA<T> _self;
  final $Res Function(GenericA<T>) _then;

  /// Create a copy of Generic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = freezed,
  }) {
    return _then(GenericA<T>(
      freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc
mixin _$Example {
  String get a;
  int? get b;

  /// Create a copy of Example
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExampleCopyWith<Example> get copyWith =>
      _$ExampleCopyWithImpl<Example>(this as Example, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Example &&
            (identical(other.a, a) || other.a == a) &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a, b);

  @override
  String toString() {
    return 'Example(a: $a, b: $b)';
  }
}

/// @nodoc
abstract mixin class $ExampleCopyWith<$Res> {
  factory $ExampleCopyWith(Example value, $Res Function(Example) _then) =
      _$ExampleCopyWithImpl;
  @useResult
  $Res call({String a, int? b});
}

/// @nodoc
class _$ExampleCopyWithImpl<$Res> implements $ExampleCopyWith<$Res> {
  _$ExampleCopyWithImpl(this._self, this._then);

  final Example _self;
  final $Res Function(Example) _then;

  /// Create a copy of Example
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? a = null,
    Object? b = freezed,
  }) {
    return _then(_self.copyWith(
      a: null == a
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

/// Adds pattern-matching-related methods to [Example].
extension ExamplePatterns on Example {
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
    TResult Function(Example0 value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Example0() when $default != null:
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
    TResult Function(Example0 value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case Example0():
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
    TResult? Function(Example0 value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case Example0() when $default != null:
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
    TResult Function(String a, int? b)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Example0() when $default != null:
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
    TResult Function(String a, int? b) $default,
  ) {
    final _that = this;
    switch (_that) {
      case Example0():
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
    TResult? Function(String a, int? b)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case Example0() when $default != null:
        return $default(_that.a, _that.b);
      case _:
        return null;
    }
  }
}

/// @nodoc

class Example0 implements Example {
  const Example0(this.a, {this.b});

  @override
  final String a;
  @override
  final int? b;

  /// Create a copy of Example
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Example0CopyWith<Example0> get copyWith =>
      _$Example0CopyWithImpl<Example0>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Example0 &&
            (identical(other.a, a) || other.a == a) &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a, b);

  @override
  String toString() {
    return 'Example(a: $a, b: $b)';
  }
}

/// @nodoc
abstract mixin class $Example0CopyWith<$Res> implements $ExampleCopyWith<$Res> {
  factory $Example0CopyWith(Example0 value, $Res Function(Example0) _then) =
      _$Example0CopyWithImpl;
  @override
  @useResult
  $Res call({String a, int? b});
}

/// @nodoc
class _$Example0CopyWithImpl<$Res> implements $Example0CopyWith<$Res> {
  _$Example0CopyWithImpl(this._self, this._then);

  final Example0 _self;
  final $Res Function(Example0) _then;

  /// Create a copy of Example
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
    Object? b = freezed,
  }) {
    return _then(Example0(
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
mixin _$NoConst {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is NoConst);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'NoConst()';
  }
}

/// @nodoc
class $NoConstCopyWith<$Res> {
  $NoConstCopyWith(NoConst _, $Res Function(NoConst) __);
}

/// Adds pattern-matching-related methods to [NoConst].
extension NoConstPatterns on NoConst {
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
    TResult Function(NoConstImpl value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case NoConstImpl() when $default != null:
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
    TResult Function(NoConstImpl value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case NoConstImpl():
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
    TResult? Function(NoConstImpl value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case NoConstImpl() when $default != null:
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
    TResult Function()? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case NoConstImpl() when $default != null:
        return $default();
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
    TResult Function() $default,
  ) {
    final _that = this;
    switch (_that) {
      case NoConstImpl():
        return $default();
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
    TResult? Function()? $default,
  ) {
    final _that = this;
    switch (_that) {
      case NoConstImpl() when $default != null:
        return $default();
      case _:
        return null;
    }
  }
}

/// @nodoc

class NoConstImpl implements NoConst {
  NoConstImpl();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is NoConstImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'NoConst()';
  }
}

/// @nodoc
mixin _$SecondState {
  String? get dateTime;
  String? get uuid;

  /// Create a copy of SecondState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SecondStateCopyWith<SecondState> get copyWith =>
      _$SecondStateCopyWithImpl<SecondState>(this as SecondState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SecondState &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.uuid, uuid) || other.uuid == uuid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dateTime, uuid);

  @override
  String toString() {
    return 'SecondState(dateTime: $dateTime, uuid: $uuid)';
  }
}

/// @nodoc
abstract mixin class $SecondStateCopyWith<$Res> {
  factory $SecondStateCopyWith(
          SecondState value, $Res Function(SecondState) _then) =
      _$SecondStateCopyWithImpl;
  @useResult
  $Res call({String? dateTime, String? uuid});
}

/// @nodoc
class _$SecondStateCopyWithImpl<$Res> implements $SecondStateCopyWith<$Res> {
  _$SecondStateCopyWithImpl(this._self, this._then);

  final SecondState _self;
  final $Res Function(SecondState) _then;

  /// Create a copy of SecondState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateTime = freezed,
    Object? uuid = freezed,
  }) {
    return _then(_self.copyWith(
      dateTime: freezed == dateTime
          ? _self.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String?,
      uuid: freezed == uuid
          ? _self.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SecondState].
extension SecondStatePatterns on SecondState {
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
    TResult Function(_SecondState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SecondState() when $default != null:
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
    TResult Function(_SecondState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SecondState():
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
    TResult? Function(_SecondState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SecondState() when $default != null:
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
    TResult Function(String? dateTime, String? uuid)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SecondState() when $default != null:
        return $default(_that.dateTime, _that.uuid);
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
    TResult Function(String? dateTime, String? uuid) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SecondState():
        return $default(_that.dateTime, _that.uuid);
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
    TResult? Function(String? dateTime, String? uuid)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SecondState() when $default != null:
        return $default(_that.dateTime, _that.uuid);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SecondState implements SecondState {
  const _SecondState({this.dateTime, this.uuid});

  @override
  final String? dateTime;
  @override
  final String? uuid;

  /// Create a copy of SecondState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SecondStateCopyWith<_SecondState> get copyWith =>
      __$SecondStateCopyWithImpl<_SecondState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SecondState &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.uuid, uuid) || other.uuid == uuid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dateTime, uuid);

  @override
  String toString() {
    return 'SecondState(dateTime: $dateTime, uuid: $uuid)';
  }
}

/// @nodoc
abstract mixin class _$SecondStateCopyWith<$Res>
    implements $SecondStateCopyWith<$Res> {
  factory _$SecondStateCopyWith(
          _SecondState value, $Res Function(_SecondState) _then) =
      __$SecondStateCopyWithImpl;
  @override
  @useResult
  $Res call({String? dateTime, String? uuid});
}

/// @nodoc
class __$SecondStateCopyWithImpl<$Res> implements _$SecondStateCopyWith<$Res> {
  __$SecondStateCopyWithImpl(this._self, this._then);

  final _SecondState _self;
  final $Res Function(_SecondState) _then;

  /// Create a copy of SecondState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? dateTime = freezed,
    Object? uuid = freezed,
  }) {
    return _then(_SecondState(
      dateTime: freezed == dateTime
          ? _self.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String?,
      uuid: freezed == uuid
          ? _self.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$Static {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Static);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Static()';
  }
}

/// @nodoc
class $StaticCopyWith<$Res> {
  $StaticCopyWith(Static _, $Res Function(Static) __);
}

/// Adds pattern-matching-related methods to [Static].
extension StaticPatterns on Static {
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
    TResult Function(_Static value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Static() when $default != null:
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
    TResult Function(_Static value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Static():
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
    TResult? Function(_Static value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Static() when $default != null:
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
    TResult Function()? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Static() when $default != null:
        return $default();
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
    TResult Function() $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Static():
        return $default();
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
    TResult? Function()? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Static() when $default != null:
        return $default();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Static implements Static {
  const _Static();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Static);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Static()';
  }
}

/// @nodoc
mixin _$Late {
  dynamic get container;
  int get value;

  /// Create a copy of Late
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LateCopyWith<Late> get copyWith =>
      _$LateCopyWithImpl<Late>(this as Late, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Late &&
            const DeepCollectionEquality().equals(other.container, container) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(container), value);

  @override
  String toString() {
    return 'Late(container: $container, value: $value)';
  }
}

/// @nodoc
abstract mixin class $LateCopyWith<$Res> {
  factory $LateCopyWith(Late value, $Res Function(Late) _then) =
      _$LateCopyWithImpl;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$LateCopyWithImpl<$Res> implements $LateCopyWith<$Res> {
  _$LateCopyWithImpl(this._self, this._then);

  final Late _self;
  final $Res Function(Late) _then;

  /// Create a copy of Late
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

/// Adds pattern-matching-related methods to [Late].
extension LatePatterns on Late {
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
    TResult Function(_Late value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Late() when $default != null:
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
    TResult Function(_Late value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Late():
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
    TResult? Function(_Late value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Late() when $default != null:
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
      case _Late() when $default != null:
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
      case _Late():
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
      case _Late() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Late extends Late {
  _Late(this.value) : super._();

  @override
  final int value;

  /// Create a copy of Late
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LateCopyWith<_Late> get copyWith =>
      __$LateCopyWithImpl<_Late>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Late &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'Late(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$LateCopyWith<$Res> implements $LateCopyWith<$Res> {
  factory _$LateCopyWith(_Late value, $Res Function(_Late) _then) =
      __$LateCopyWithImpl;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$LateCopyWithImpl<$Res> implements _$LateCopyWith<$Res> {
  __$LateCopyWithImpl(this._self, this._then);

  final _Late _self;
  final $Res Function(_Late) _then;

  /// Create a copy of Late
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_Late(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$AllProperties {
  dynamic get b;
  dynamic get c;
  int get value;

  /// Create a copy of AllProperties
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AllPropertiesCopyWith<AllProperties> get copyWith =>
      _$AllPropertiesCopyWithImpl<AllProperties>(
          this as AllProperties, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AllProperties &&
            const DeepCollectionEquality().equals(other.b, b) &&
            const DeepCollectionEquality().equals(other.c, c) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(b),
      const DeepCollectionEquality().hash(c),
      value);

  @override
  String toString() {
    return 'AllProperties(b: $b, c: $c, value: $value)';
  }
}

/// @nodoc
abstract mixin class $AllPropertiesCopyWith<$Res> {
  factory $AllPropertiesCopyWith(
          AllProperties value, $Res Function(AllProperties) _then) =
      _$AllPropertiesCopyWithImpl;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$AllPropertiesCopyWithImpl<$Res>
    implements $AllPropertiesCopyWith<$Res> {
  _$AllPropertiesCopyWithImpl(this._self, this._then);

  final AllProperties _self;
  final $Res Function(AllProperties) _then;

  /// Create a copy of AllProperties
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

/// Adds pattern-matching-related methods to [AllProperties].
extension AllPropertiesPatterns on AllProperties {
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
    TResult Function(_AllProperties value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AllProperties() when $default != null:
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
    TResult Function(_AllProperties value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AllProperties():
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
    TResult? Function(_AllProperties value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AllProperties() when $default != null:
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
      case _AllProperties() when $default != null:
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
      case _AllProperties():
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
      case _AllProperties() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AllProperties extends AllProperties {
  _AllProperties(this.value) : super._();

  @override
  final int value;

  /// Create a copy of AllProperties
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AllPropertiesCopyWith<_AllProperties> get copyWith =>
      __$AllPropertiesCopyWithImpl<_AllProperties>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AllProperties &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'AllProperties(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$AllPropertiesCopyWith<$Res>
    implements $AllPropertiesCopyWith<$Res> {
  factory _$AllPropertiesCopyWith(
          _AllProperties value, $Res Function(_AllProperties) _then) =
      __$AllPropertiesCopyWithImpl;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$AllPropertiesCopyWithImpl<$Res>
    implements _$AllPropertiesCopyWith<$Res> {
  __$AllPropertiesCopyWithImpl(this._self, this._then);

  final _AllProperties _self;
  final $Res Function(_AllProperties) _then;

  /// Create a copy of AllProperties
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_AllProperties(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$Late2 {
  int? get first;
  int? Function() get cb;

  /// Create a copy of Late2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Late2CopyWith<Late2> get copyWith =>
      _$Late2CopyWithImpl<Late2>(this as Late2, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Late2 &&
            (identical(other.first, first) || other.first == first) &&
            (identical(other.cb, cb) || other.cb == cb));
  }

  @override
  int get hashCode => Object.hash(runtimeType, first, cb);

  @override
  String toString() {
    return 'Late2(first: $first, cb: $cb)';
  }
}

/// @nodoc
abstract mixin class $Late2CopyWith<$Res> {
  factory $Late2CopyWith(Late2 value, $Res Function(Late2) _then) =
      _$Late2CopyWithImpl;
  @useResult
  $Res call({int? Function() cb});
}

/// @nodoc
class _$Late2CopyWithImpl<$Res> implements $Late2CopyWith<$Res> {
  _$Late2CopyWithImpl(this._self, this._then);

  final Late2 _self;
  final $Res Function(Late2) _then;

  /// Create a copy of Late2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cb = null,
  }) {
    return _then(_self.copyWith(
      cb: null == cb
          ? _self.cb
          : cb // ignore: cast_nullable_to_non_nullable
              as int? Function(),
    ));
  }
}

/// Adds pattern-matching-related methods to [Late2].
extension Late2Patterns on Late2 {
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
    TResult Function(_Late2 value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Late2() when $default != null:
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
    TResult Function(_Late2 value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Late2():
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
    TResult? Function(_Late2 value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Late2() when $default != null:
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
    TResult Function(int? Function() cb)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Late2() when $default != null:
        return $default(_that.cb);
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
    TResult Function(int? Function() cb) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Late2():
        return $default(_that.cb);
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
    TResult? Function(int? Function() cb)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Late2() when $default != null:
        return $default(_that.cb);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Late2 extends Late2 {
  _Late2(this.cb) : super._();

  @override
  final int? Function() cb;

  /// Create a copy of Late2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$Late2CopyWith<_Late2> get copyWith =>
      __$Late2CopyWithImpl<_Late2>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Late2 &&
            (identical(other.cb, cb) || other.cb == cb));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cb);

  @override
  String toString() {
    return 'Late2(cb: $cb)';
  }
}

/// @nodoc
abstract mixin class _$Late2CopyWith<$Res> implements $Late2CopyWith<$Res> {
  factory _$Late2CopyWith(_Late2 value, $Res Function(_Late2) _then) =
      __$Late2CopyWithImpl;
  @override
  @useResult
  $Res call({int? Function() cb});
}

/// @nodoc
class __$Late2CopyWithImpl<$Res> implements _$Late2CopyWith<$Res> {
  __$Late2CopyWithImpl(this._self, this._then);

  final _Late2 _self;
  final $Res Function(_Late2) _then;

  /// Create a copy of Late2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? cb = null,
  }) {
    return _then(_Late2(
      null == cb
          ? _self.cb
          : cb // ignore: cast_nullable_to_non_nullable
              as int? Function(),
    ));
  }
}

/// @nodoc
mixin _$ComplexLate {
  List<int> get odd;
  List<int> get values;

  /// Create a copy of ComplexLate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComplexLateCopyWith<ComplexLate> get copyWith =>
      _$ComplexLateCopyWithImpl<ComplexLate>(this as ComplexLate, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComplexLate &&
            const DeepCollectionEquality().equals(other.odd, odd) &&
            const DeepCollectionEquality().equals(other.values, values));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(odd),
      const DeepCollectionEquality().hash(values));

  @override
  String toString() {
    return 'ComplexLate(odd: $odd, values: $values)';
  }
}

/// @nodoc
abstract mixin class $ComplexLateCopyWith<$Res> {
  factory $ComplexLateCopyWith(
          ComplexLate value, $Res Function(ComplexLate) _then) =
      _$ComplexLateCopyWithImpl;
  @useResult
  $Res call({List<int> values});
}

/// @nodoc
class _$ComplexLateCopyWithImpl<$Res> implements $ComplexLateCopyWith<$Res> {
  _$ComplexLateCopyWithImpl(this._self, this._then);

  final ComplexLate _self;
  final $Res Function(ComplexLate) _then;

  /// Create a copy of ComplexLate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_self.copyWith(
      values: null == values
          ? _self.values
          : values // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ComplexLate].
extension ComplexLatePatterns on ComplexLate {
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
    TResult Function(_ComplexLate value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplexLate() when $default != null:
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
    TResult Function(_ComplexLate value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplexLate():
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
    TResult? Function(_ComplexLate value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplexLate() when $default != null:
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
    TResult Function(List<int> values)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplexLate() when $default != null:
        return $default(_that.values);
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
    TResult Function(List<int> values) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplexLate():
        return $default(_that.values);
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
    TResult? Function(List<int> values)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplexLate() when $default != null:
        return $default(_that.values);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ComplexLate extends ComplexLate {
  _ComplexLate(final List<int> values)
      : _values = values,
        super._();

  final List<int> _values;
  @override
  List<int> get values {
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  /// Create a copy of ComplexLate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComplexLateCopyWith<_ComplexLate> get copyWith =>
      __$ComplexLateCopyWithImpl<_ComplexLate>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComplexLate &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_values));

  @override
  String toString() {
    return 'ComplexLate(values: $values)';
  }
}

/// @nodoc
abstract mixin class _$ComplexLateCopyWith<$Res>
    implements $ComplexLateCopyWith<$Res> {
  factory _$ComplexLateCopyWith(
          _ComplexLate value, $Res Function(_ComplexLate) _then) =
      __$ComplexLateCopyWithImpl;
  @override
  @useResult
  $Res call({List<int> values});
}

/// @nodoc
class __$ComplexLateCopyWithImpl<$Res> implements _$ComplexLateCopyWith<$Res> {
  __$ComplexLateCopyWithImpl(this._self, this._then);

  final _ComplexLate _self;
  final $Res Function(_ComplexLate) _then;

  /// Create a copy of ComplexLate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? values = null,
  }) {
    return _then(_ComplexLate(
      null == values
          ? _self._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
mixin _$IntDefault {
  int get value;

  /// Create a copy of IntDefault
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $IntDefaultCopyWith<IntDefault> get copyWith =>
      _$IntDefaultCopyWithImpl<IntDefault>(this as IntDefault, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is IntDefault &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'IntDefault(value: $value)';
  }
}

/// @nodoc
abstract mixin class $IntDefaultCopyWith<$Res> {
  factory $IntDefaultCopyWith(
          IntDefault value, $Res Function(IntDefault) _then) =
      _$IntDefaultCopyWithImpl;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$IntDefaultCopyWithImpl<$Res> implements $IntDefaultCopyWith<$Res> {
  _$IntDefaultCopyWithImpl(this._self, this._then);

  final IntDefault _self;
  final $Res Function(IntDefault) _then;

  /// Create a copy of IntDefault
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

/// Adds pattern-matching-related methods to [IntDefault].
extension IntDefaultPatterns on IntDefault {
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
    TResult Function(_IntDefault value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _IntDefault() when $default != null:
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
    TResult Function(_IntDefault value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IntDefault():
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
    TResult? Function(_IntDefault value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IntDefault() when $default != null:
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
      case _IntDefault() when $default != null:
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
      case _IntDefault():
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
      case _IntDefault() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _IntDefault implements IntDefault {
  _IntDefault([this.value = 42]);

  @override
  @JsonKey()
  final int value;

  /// Create a copy of IntDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$IntDefaultCopyWith<_IntDefault> get copyWith =>
      __$IntDefaultCopyWithImpl<_IntDefault>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _IntDefault &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'IntDefault(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$IntDefaultCopyWith<$Res>
    implements $IntDefaultCopyWith<$Res> {
  factory _$IntDefaultCopyWith(
          _IntDefault value, $Res Function(_IntDefault) _then) =
      __$IntDefaultCopyWithImpl;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$IntDefaultCopyWithImpl<$Res> implements _$IntDefaultCopyWith<$Res> {
  __$IntDefaultCopyWithImpl(this._self, this._then);

  final _IntDefault _self;
  final $Res Function(_IntDefault) _then;

  /// Create a copy of IntDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_IntDefault(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$StringDefault {
  String get value;

  /// Create a copy of StringDefault
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StringDefaultCopyWith<StringDefault> get copyWith =>
      _$StringDefaultCopyWithImpl<StringDefault>(
          this as StringDefault, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StringDefault &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'StringDefault(value: $value)';
  }
}

/// @nodoc
abstract mixin class $StringDefaultCopyWith<$Res> {
  factory $StringDefaultCopyWith(
          StringDefault value, $Res Function(StringDefault) _then) =
      _$StringDefaultCopyWithImpl;
  @useResult
  $Res call({String value});
}

/// @nodoc
class _$StringDefaultCopyWithImpl<$Res>
    implements $StringDefaultCopyWith<$Res> {
  _$StringDefaultCopyWithImpl(this._self, this._then);

  final StringDefault _self;
  final $Res Function(StringDefault) _then;

  /// Create a copy of StringDefault
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
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [StringDefault].
extension StringDefaultPatterns on StringDefault {
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
    TResult Function(_StringDefault value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StringDefault() when $default != null:
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
    TResult Function(_StringDefault value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StringDefault():
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
    TResult? Function(_StringDefault value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StringDefault() when $default != null:
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
    TResult Function(String value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StringDefault() when $default != null:
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
    TResult Function(String value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StringDefault():
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
    TResult? Function(String value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StringDefault() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _StringDefault implements StringDefault {
  _StringDefault([this.value = '42']);

  @override
  @JsonKey()
  final String value;

  /// Create a copy of StringDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StringDefaultCopyWith<_StringDefault> get copyWith =>
      __$StringDefaultCopyWithImpl<_StringDefault>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StringDefault &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'StringDefault(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$StringDefaultCopyWith<$Res>
    implements $StringDefaultCopyWith<$Res> {
  factory _$StringDefaultCopyWith(
          _StringDefault value, $Res Function(_StringDefault) _then) =
      __$StringDefaultCopyWithImpl;
  @override
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$StringDefaultCopyWithImpl<$Res>
    implements _$StringDefaultCopyWith<$Res> {
  __$StringDefaultCopyWithImpl(this._self, this._then);

  final _StringDefault _self;
  final $Res Function(_StringDefault) _then;

  /// Create a copy of StringDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_StringDefault(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$SpecialStringDefault {
  String get value;

  /// Create a copy of SpecialStringDefault
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SpecialStringDefaultCopyWith<SpecialStringDefault> get copyWith =>
      _$SpecialStringDefaultCopyWithImpl<SpecialStringDefault>(
          this as SpecialStringDefault, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SpecialStringDefault &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'SpecialStringDefault(value: $value)';
  }
}

/// @nodoc
abstract mixin class $SpecialStringDefaultCopyWith<$Res> {
  factory $SpecialStringDefaultCopyWith(SpecialStringDefault value,
          $Res Function(SpecialStringDefault) _then) =
      _$SpecialStringDefaultCopyWithImpl;
  @useResult
  $Res call({String value});
}

/// @nodoc
class _$SpecialStringDefaultCopyWithImpl<$Res>
    implements $SpecialStringDefaultCopyWith<$Res> {
  _$SpecialStringDefaultCopyWithImpl(this._self, this._then);

  final SpecialStringDefault _self;
  final $Res Function(SpecialStringDefault) _then;

  /// Create a copy of SpecialStringDefault
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
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [SpecialStringDefault].
extension SpecialStringDefaultPatterns on SpecialStringDefault {
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
    TResult Function(_SpecialStringDefault value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SpecialStringDefault() when $default != null:
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
    TResult Function(_SpecialStringDefault value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SpecialStringDefault():
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
    TResult? Function(_SpecialStringDefault value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SpecialStringDefault() when $default != null:
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
    TResult Function(String value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SpecialStringDefault() when $default != null:
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
    TResult Function(String value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SpecialStringDefault():
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
    TResult? Function(String value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SpecialStringDefault() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SpecialStringDefault implements SpecialStringDefault {
  _SpecialStringDefault([this.value = '(1)[2]{3}']);

  @override
  @JsonKey()
  final String value;

  /// Create a copy of SpecialStringDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SpecialStringDefaultCopyWith<_SpecialStringDefault> get copyWith =>
      __$SpecialStringDefaultCopyWithImpl<_SpecialStringDefault>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SpecialStringDefault &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'SpecialStringDefault(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$SpecialStringDefaultCopyWith<$Res>
    implements $SpecialStringDefaultCopyWith<$Res> {
  factory _$SpecialStringDefaultCopyWith(_SpecialStringDefault value,
          $Res Function(_SpecialStringDefault) _then) =
      __$SpecialStringDefaultCopyWithImpl;
  @override
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$SpecialStringDefaultCopyWithImpl<$Res>
    implements _$SpecialStringDefaultCopyWith<$Res> {
  __$SpecialStringDefaultCopyWithImpl(this._self, this._then);

  final _SpecialStringDefault _self;
  final $Res Function(_SpecialStringDefault) _then;

  /// Create a copy of SpecialStringDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_SpecialStringDefault(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$DefaultNonLiteralConst {
  Object get listObject;

  /// Create a copy of DefaultNonLiteralConst
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DefaultNonLiteralConstCopyWith<DefaultNonLiteralConst> get copyWith =>
      _$DefaultNonLiteralConstCopyWithImpl<DefaultNonLiteralConst>(
          this as DefaultNonLiteralConst, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DefaultNonLiteralConst &&
            const DeepCollectionEquality()
                .equals(other.listObject, listObject));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(listObject));

  @override
  String toString() {
    return 'DefaultNonLiteralConst(listObject: $listObject)';
  }
}

/// @nodoc
abstract mixin class $DefaultNonLiteralConstCopyWith<$Res> {
  factory $DefaultNonLiteralConstCopyWith(DefaultNonLiteralConst value,
          $Res Function(DefaultNonLiteralConst) _then) =
      _$DefaultNonLiteralConstCopyWithImpl;
  @useResult
  $Res call({Object listObject});
}

/// @nodoc
class _$DefaultNonLiteralConstCopyWithImpl<$Res>
    implements $DefaultNonLiteralConstCopyWith<$Res> {
  _$DefaultNonLiteralConstCopyWithImpl(this._self, this._then);

  final DefaultNonLiteralConst _self;
  final $Res Function(DefaultNonLiteralConst) _then;

  /// Create a copy of DefaultNonLiteralConst
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listObject = null,
  }) {
    return _then(_self.copyWith(
      listObject: null == listObject ? _self.listObject : listObject,
    ));
  }
}

/// Adds pattern-matching-related methods to [DefaultNonLiteralConst].
extension DefaultNonLiteralConstPatterns on DefaultNonLiteralConst {
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
    TResult Function(_DefaultNonLiteralConst value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DefaultNonLiteralConst() when $default != null:
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
    TResult Function(_DefaultNonLiteralConst value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DefaultNonLiteralConst():
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
    TResult? Function(_DefaultNonLiteralConst value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DefaultNonLiteralConst() when $default != null:
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
    TResult Function(Object listObject)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DefaultNonLiteralConst() when $default != null:
        return $default(_that.listObject);
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
    TResult Function(Object listObject) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DefaultNonLiteralConst():
        return $default(_that.listObject);
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
    TResult? Function(Object listObject)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DefaultNonLiteralConst() when $default != null:
        return $default(_that.listObject);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DefaultNonLiteralConst implements DefaultNonLiteralConst {
  _DefaultNonLiteralConst({this.listObject = const Object()});

  @override
  @JsonKey()
  final Object listObject;

  /// Create a copy of DefaultNonLiteralConst
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DefaultNonLiteralConstCopyWith<_DefaultNonLiteralConst> get copyWith =>
      __$DefaultNonLiteralConstCopyWithImpl<_DefaultNonLiteralConst>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DefaultNonLiteralConst &&
            const DeepCollectionEquality()
                .equals(other.listObject, listObject));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(listObject));

  @override
  String toString() {
    return 'DefaultNonLiteralConst(listObject: $listObject)';
  }
}

/// @nodoc
abstract mixin class _$DefaultNonLiteralConstCopyWith<$Res>
    implements $DefaultNonLiteralConstCopyWith<$Res> {
  factory _$DefaultNonLiteralConstCopyWith(_DefaultNonLiteralConst value,
          $Res Function(_DefaultNonLiteralConst) _then) =
      __$DefaultNonLiteralConstCopyWithImpl;
  @override
  @useResult
  $Res call({Object listObject});
}

/// @nodoc
class __$DefaultNonLiteralConstCopyWithImpl<$Res>
    implements _$DefaultNonLiteralConstCopyWith<$Res> {
  __$DefaultNonLiteralConstCopyWithImpl(this._self, this._then);

  final _DefaultNonLiteralConst _self;
  final $Res Function(_DefaultNonLiteralConst) _then;

  /// Create a copy of DefaultNonLiteralConst
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? listObject = null,
  }) {
    return _then(_DefaultNonLiteralConst(
      listObject: null == listObject ? _self.listObject : listObject,
    ));
  }
}

/// @nodoc
mixin _$DefaultNonLiteralAlreadyConst {
  Object get listObject;

  /// Create a copy of DefaultNonLiteralAlreadyConst
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DefaultNonLiteralAlreadyConstCopyWith<DefaultNonLiteralAlreadyConst>
      get copyWith => _$DefaultNonLiteralAlreadyConstCopyWithImpl<
              DefaultNonLiteralAlreadyConst>(
          this as DefaultNonLiteralAlreadyConst, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DefaultNonLiteralAlreadyConst &&
            const DeepCollectionEquality()
                .equals(other.listObject, listObject));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(listObject));

  @override
  String toString() {
    return 'DefaultNonLiteralAlreadyConst(listObject: $listObject)';
  }
}

/// @nodoc
abstract mixin class $DefaultNonLiteralAlreadyConstCopyWith<$Res> {
  factory $DefaultNonLiteralAlreadyConstCopyWith(
          DefaultNonLiteralAlreadyConst value,
          $Res Function(DefaultNonLiteralAlreadyConst) _then) =
      _$DefaultNonLiteralAlreadyConstCopyWithImpl;
  @useResult
  $Res call({Object listObject});
}

/// @nodoc
class _$DefaultNonLiteralAlreadyConstCopyWithImpl<$Res>
    implements $DefaultNonLiteralAlreadyConstCopyWith<$Res> {
  _$DefaultNonLiteralAlreadyConstCopyWithImpl(this._self, this._then);

  final DefaultNonLiteralAlreadyConst _self;
  final $Res Function(DefaultNonLiteralAlreadyConst) _then;

  /// Create a copy of DefaultNonLiteralAlreadyConst
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listObject = null,
  }) {
    return _then(_self.copyWith(
      listObject: null == listObject ? _self.listObject : listObject,
    ));
  }
}

/// Adds pattern-matching-related methods to [DefaultNonLiteralAlreadyConst].
extension DefaultNonLiteralAlreadyConstPatterns
    on DefaultNonLiteralAlreadyConst {
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
    TResult Function(_DefaultNonLiteralAlreadyConst value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DefaultNonLiteralAlreadyConst() when $default != null:
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
    TResult Function(_DefaultNonLiteralAlreadyConst value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DefaultNonLiteralAlreadyConst():
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
    TResult? Function(_DefaultNonLiteralAlreadyConst value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DefaultNonLiteralAlreadyConst() when $default != null:
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
    TResult Function(Object listObject)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DefaultNonLiteralAlreadyConst() when $default != null:
        return $default(_that.listObject);
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
    TResult Function(Object listObject) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DefaultNonLiteralAlreadyConst():
        return $default(_that.listObject);
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
    TResult? Function(Object listObject)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DefaultNonLiteralAlreadyConst() when $default != null:
        return $default(_that.listObject);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DefaultNonLiteralAlreadyConst implements DefaultNonLiteralAlreadyConst {
  _DefaultNonLiteralAlreadyConst({this.listObject = const Object()});

  @override
  @JsonKey()
  final Object listObject;

  /// Create a copy of DefaultNonLiteralAlreadyConst
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DefaultNonLiteralAlreadyConstCopyWith<_DefaultNonLiteralAlreadyConst>
      get copyWith => __$DefaultNonLiteralAlreadyConstCopyWithImpl<
          _DefaultNonLiteralAlreadyConst>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DefaultNonLiteralAlreadyConst &&
            const DeepCollectionEquality()
                .equals(other.listObject, listObject));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(listObject));

  @override
  String toString() {
    return 'DefaultNonLiteralAlreadyConst(listObject: $listObject)';
  }
}

/// @nodoc
abstract mixin class _$DefaultNonLiteralAlreadyConstCopyWith<$Res>
    implements $DefaultNonLiteralAlreadyConstCopyWith<$Res> {
  factory _$DefaultNonLiteralAlreadyConstCopyWith(
          _DefaultNonLiteralAlreadyConst value,
          $Res Function(_DefaultNonLiteralAlreadyConst) _then) =
      __$DefaultNonLiteralAlreadyConstCopyWithImpl;
  @override
  @useResult
  $Res call({Object listObject});
}

/// @nodoc
class __$DefaultNonLiteralAlreadyConstCopyWithImpl<$Res>
    implements _$DefaultNonLiteralAlreadyConstCopyWith<$Res> {
  __$DefaultNonLiteralAlreadyConstCopyWithImpl(this._self, this._then);

  final _DefaultNonLiteralAlreadyConst _self;
  final $Res Function(_DefaultNonLiteralAlreadyConst) _then;

  /// Create a copy of DefaultNonLiteralAlreadyConst
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? listObject = null,
  }) {
    return _then(_DefaultNonLiteralAlreadyConst(
      listObject: null == listObject ? _self.listObject : listObject,
    ));
  }
}

/// @nodoc
mixin _$DoubleDefault {
  double get value;

  /// Create a copy of DoubleDefault
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DoubleDefaultCopyWith<DoubleDefault> get copyWith =>
      _$DoubleDefaultCopyWithImpl<DoubleDefault>(
          this as DoubleDefault, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DoubleDefault &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'DoubleDefault(value: $value)';
  }
}

/// @nodoc
abstract mixin class $DoubleDefaultCopyWith<$Res> {
  factory $DoubleDefaultCopyWith(
          DoubleDefault value, $Res Function(DoubleDefault) _then) =
      _$DoubleDefaultCopyWithImpl;
  @useResult
  $Res call({double value});
}

/// @nodoc
class _$DoubleDefaultCopyWithImpl<$Res>
    implements $DoubleDefaultCopyWith<$Res> {
  _$DoubleDefaultCopyWithImpl(this._self, this._then);

  final DoubleDefault _self;
  final $Res Function(DoubleDefault) _then;

  /// Create a copy of DoubleDefault
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
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [DoubleDefault].
extension DoubleDefaultPatterns on DoubleDefault {
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
    TResult Function(_DoubleDefault value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DoubleDefault() when $default != null:
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
    TResult Function(_DoubleDefault value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DoubleDefault():
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
    TResult? Function(_DoubleDefault value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DoubleDefault() when $default != null:
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
    TResult Function(double value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DoubleDefault() when $default != null:
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
    TResult Function(double value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DoubleDefault():
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
    TResult? Function(double value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DoubleDefault() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DoubleDefault implements DoubleDefault {
  _DoubleDefault([this.value = 42.0]);

  @override
  @JsonKey()
  final double value;

  /// Create a copy of DoubleDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DoubleDefaultCopyWith<_DoubleDefault> get copyWith =>
      __$DoubleDefaultCopyWithImpl<_DoubleDefault>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DoubleDefault &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'DoubleDefault(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$DoubleDefaultCopyWith<$Res>
    implements $DoubleDefaultCopyWith<$Res> {
  factory _$DoubleDefaultCopyWith(
          _DoubleDefault value, $Res Function(_DoubleDefault) _then) =
      __$DoubleDefaultCopyWithImpl;
  @override
  @useResult
  $Res call({double value});
}

/// @nodoc
class __$DoubleDefaultCopyWithImpl<$Res>
    implements _$DoubleDefaultCopyWith<$Res> {
  __$DoubleDefaultCopyWithImpl(this._self, this._then);

  final _DoubleDefault _self;
  final $Res Function(_DoubleDefault) _then;

  /// Create a copy of DoubleDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_DoubleDefault(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$TypeDefault {
  Type get value;

  /// Create a copy of TypeDefault
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TypeDefaultCopyWith<TypeDefault> get copyWith =>
      _$TypeDefaultCopyWithImpl<TypeDefault>(this as TypeDefault, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TypeDefault &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'TypeDefault(value: $value)';
  }
}

/// @nodoc
abstract mixin class $TypeDefaultCopyWith<$Res> {
  factory $TypeDefaultCopyWith(
          TypeDefault value, $Res Function(TypeDefault) _then) =
      _$TypeDefaultCopyWithImpl;
  @useResult
  $Res call({Type value});
}

/// @nodoc
class _$TypeDefaultCopyWithImpl<$Res> implements $TypeDefaultCopyWith<$Res> {
  _$TypeDefaultCopyWithImpl(this._self, this._then);

  final TypeDefault _self;
  final $Res Function(TypeDefault) _then;

  /// Create a copy of TypeDefault
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
              as Type,
    ));
  }
}

/// Adds pattern-matching-related methods to [TypeDefault].
extension TypeDefaultPatterns on TypeDefault {
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
    TResult Function(_TypeDefault value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TypeDefault() when $default != null:
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
    TResult Function(_TypeDefault value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TypeDefault():
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
    TResult? Function(_TypeDefault value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TypeDefault() when $default != null:
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
    TResult Function(Type value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TypeDefault() when $default != null:
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
    TResult Function(Type value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TypeDefault():
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
    TResult? Function(Type value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TypeDefault() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _TypeDefault implements TypeDefault {
  _TypeDefault([this.value = TypeDefault]);

  @override
  @JsonKey()
  final Type value;

  /// Create a copy of TypeDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TypeDefaultCopyWith<_TypeDefault> get copyWith =>
      __$TypeDefaultCopyWithImpl<_TypeDefault>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TypeDefault &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'TypeDefault(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$TypeDefaultCopyWith<$Res>
    implements $TypeDefaultCopyWith<$Res> {
  factory _$TypeDefaultCopyWith(
          _TypeDefault value, $Res Function(_TypeDefault) _then) =
      __$TypeDefaultCopyWithImpl;
  @override
  @useResult
  $Res call({Type value});
}

/// @nodoc
class __$TypeDefaultCopyWithImpl<$Res> implements _$TypeDefaultCopyWith<$Res> {
  __$TypeDefaultCopyWithImpl(this._self, this._then);

  final _TypeDefault _self;
  final $Res Function(_TypeDefault) _then;

  /// Create a copy of TypeDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_TypeDefault(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as Type,
    ));
  }
}

/// @nodoc
mixin _$ListDefault {
  List<int> get value;

  /// Create a copy of ListDefault
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ListDefaultCopyWith<ListDefault> get copyWith =>
      _$ListDefaultCopyWithImpl<ListDefault>(this as ListDefault, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ListDefault &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'ListDefault(value: $value)';
  }
}

/// @nodoc
abstract mixin class $ListDefaultCopyWith<$Res> {
  factory $ListDefaultCopyWith(
          ListDefault value, $Res Function(ListDefault) _then) =
      _$ListDefaultCopyWithImpl;
  @useResult
  $Res call({List<int> value});
}

/// @nodoc
class _$ListDefaultCopyWithImpl<$Res> implements $ListDefaultCopyWith<$Res> {
  _$ListDefaultCopyWithImpl(this._self, this._then);

  final ListDefault _self;
  final $Res Function(ListDefault) _then;

  /// Create a copy of ListDefault
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

/// Adds pattern-matching-related methods to [ListDefault].
extension ListDefaultPatterns on ListDefault {
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
    TResult Function(_ListDefault value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ListDefault() when $default != null:
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
    TResult Function(_ListDefault value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ListDefault():
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
    TResult? Function(_ListDefault value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ListDefault() when $default != null:
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
      case _ListDefault() when $default != null:
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
      case _ListDefault():
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
      case _ListDefault() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ListDefault implements ListDefault {
  _ListDefault([final List<int> value = const <int>[42]]) : _value = value;

  final List<int> _value;
  @override
  @JsonKey()
  List<int> get value {
    if (_value is EqualUnmodifiableListView) return _value;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_value);
  }

  /// Create a copy of ListDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ListDefaultCopyWith<_ListDefault> get copyWith =>
      __$ListDefaultCopyWithImpl<_ListDefault>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ListDefault &&
            const DeepCollectionEquality().equals(other._value, _value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_value));

  @override
  String toString() {
    return 'ListDefault(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$ListDefaultCopyWith<$Res>
    implements $ListDefaultCopyWith<$Res> {
  factory _$ListDefaultCopyWith(
          _ListDefault value, $Res Function(_ListDefault) _then) =
      __$ListDefaultCopyWithImpl;
  @override
  @useResult
  $Res call({List<int> value});
}

/// @nodoc
class __$ListDefaultCopyWithImpl<$Res> implements _$ListDefaultCopyWith<$Res> {
  __$ListDefaultCopyWithImpl(this._self, this._then);

  final _ListDefault _self;
  final $Res Function(_ListDefault) _then;

  /// Create a copy of ListDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_ListDefault(
      null == value
          ? _self._value
          : value // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
mixin _$SetDefault {
  Set<int> get value;

  /// Create a copy of SetDefault
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SetDefaultCopyWith<SetDefault> get copyWith =>
      _$SetDefaultCopyWithImpl<SetDefault>(this as SetDefault, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SetDefault &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'SetDefault(value: $value)';
  }
}

/// @nodoc
abstract mixin class $SetDefaultCopyWith<$Res> {
  factory $SetDefaultCopyWith(
          SetDefault value, $Res Function(SetDefault) _then) =
      _$SetDefaultCopyWithImpl;
  @useResult
  $Res call({Set<int> value});
}

/// @nodoc
class _$SetDefaultCopyWithImpl<$Res> implements $SetDefaultCopyWith<$Res> {
  _$SetDefaultCopyWithImpl(this._self, this._then);

  final SetDefault _self;
  final $Res Function(SetDefault) _then;

  /// Create a copy of SetDefault
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

/// Adds pattern-matching-related methods to [SetDefault].
extension SetDefaultPatterns on SetDefault {
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
    TResult Function(_SetDefault value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SetDefault() when $default != null:
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
    TResult Function(_SetDefault value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SetDefault():
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
    TResult? Function(_SetDefault value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SetDefault() when $default != null:
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
      case _SetDefault() when $default != null:
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
      case _SetDefault():
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
      case _SetDefault() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SetDefault implements SetDefault {
  _SetDefault([final Set<int> value = const <int>{42}]) : _value = value;

  final Set<int> _value;
  @override
  @JsonKey()
  Set<int> get value {
    if (_value is EqualUnmodifiableSetView) return _value;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_value);
  }

  /// Create a copy of SetDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SetDefaultCopyWith<_SetDefault> get copyWith =>
      __$SetDefaultCopyWithImpl<_SetDefault>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SetDefault &&
            const DeepCollectionEquality().equals(other._value, _value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_value));

  @override
  String toString() {
    return 'SetDefault(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$SetDefaultCopyWith<$Res>
    implements $SetDefaultCopyWith<$Res> {
  factory _$SetDefaultCopyWith(
          _SetDefault value, $Res Function(_SetDefault) _then) =
      __$SetDefaultCopyWithImpl;
  @override
  @useResult
  $Res call({Set<int> value});
}

/// @nodoc
class __$SetDefaultCopyWithImpl<$Res> implements _$SetDefaultCopyWith<$Res> {
  __$SetDefaultCopyWithImpl(this._self, this._then);

  final _SetDefault _self;
  final $Res Function(_SetDefault) _then;

  /// Create a copy of SetDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_SetDefault(
      null == value
          ? _self._value
          : value // ignore: cast_nullable_to_non_nullable
              as Set<int>,
    ));
  }
}

/// @nodoc
mixin _$MapDefault {
  Map<int, int> get value;

  /// Create a copy of MapDefault
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MapDefaultCopyWith<MapDefault> get copyWith =>
      _$MapDefaultCopyWithImpl<MapDefault>(this as MapDefault, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MapDefault &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'MapDefault(value: $value)';
  }
}

/// @nodoc
abstract mixin class $MapDefaultCopyWith<$Res> {
  factory $MapDefaultCopyWith(
          MapDefault value, $Res Function(MapDefault) _then) =
      _$MapDefaultCopyWithImpl;
  @useResult
  $Res call({Map<int, int> value});
}

/// @nodoc
class _$MapDefaultCopyWithImpl<$Res> implements $MapDefaultCopyWith<$Res> {
  _$MapDefaultCopyWithImpl(this._self, this._then);

  final MapDefault _self;
  final $Res Function(MapDefault) _then;

  /// Create a copy of MapDefault
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

/// Adds pattern-matching-related methods to [MapDefault].
extension MapDefaultPatterns on MapDefault {
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
    TResult Function(_MapDefault value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MapDefault() when $default != null:
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
    TResult Function(_MapDefault value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MapDefault():
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
    TResult? Function(_MapDefault value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MapDefault() when $default != null:
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
      case _MapDefault() when $default != null:
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
      case _MapDefault():
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
      case _MapDefault() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _MapDefault implements MapDefault {
  _MapDefault([final Map<int, int> value = const <int, int>{42: 42}])
      : _value = value;

  final Map<int, int> _value;
  @override
  @JsonKey()
  Map<int, int> get value {
    if (_value is EqualUnmodifiableMapView) return _value;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_value);
  }

  /// Create a copy of MapDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MapDefaultCopyWith<_MapDefault> get copyWith =>
      __$MapDefaultCopyWithImpl<_MapDefault>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MapDefault &&
            const DeepCollectionEquality().equals(other._value, _value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_value));

  @override
  String toString() {
    return 'MapDefault(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$MapDefaultCopyWith<$Res>
    implements $MapDefaultCopyWith<$Res> {
  factory _$MapDefaultCopyWith(
          _MapDefault value, $Res Function(_MapDefault) _then) =
      __$MapDefaultCopyWithImpl;
  @override
  @useResult
  $Res call({Map<int, int> value});
}

/// @nodoc
class __$MapDefaultCopyWithImpl<$Res> implements _$MapDefaultCopyWith<$Res> {
  __$MapDefaultCopyWithImpl(this._self, this._then);

  final _MapDefault _self;
  final $Res Function(_MapDefault) _then;

  /// Create a copy of MapDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_MapDefault(
      null == value
          ? _self._value
          : value // ignore: cast_nullable_to_non_nullable
              as Map<int, int>,
    ));
  }
}

/// @nodoc
mixin _$BoolDefault {
  bool get value;

  /// Create a copy of BoolDefault
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BoolDefaultCopyWith<BoolDefault> get copyWith =>
      _$BoolDefaultCopyWithImpl<BoolDefault>(this as BoolDefault, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BoolDefault &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'BoolDefault(value: $value)';
  }
}

/// @nodoc
abstract mixin class $BoolDefaultCopyWith<$Res> {
  factory $BoolDefaultCopyWith(
          BoolDefault value, $Res Function(BoolDefault) _then) =
      _$BoolDefaultCopyWithImpl;
  @useResult
  $Res call({bool value});
}

/// @nodoc
class _$BoolDefaultCopyWithImpl<$Res> implements $BoolDefaultCopyWith<$Res> {
  _$BoolDefaultCopyWithImpl(this._self, this._then);

  final BoolDefault _self;
  final $Res Function(BoolDefault) _then;

  /// Create a copy of BoolDefault
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
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [BoolDefault].
extension BoolDefaultPatterns on BoolDefault {
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
    TResult Function(_BoolDefault value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BoolDefault() when $default != null:
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
    TResult Function(_BoolDefault value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BoolDefault():
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
    TResult? Function(_BoolDefault value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BoolDefault() when $default != null:
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
    TResult Function(bool value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BoolDefault() when $default != null:
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
    TResult Function(bool value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BoolDefault():
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
    TResult? Function(bool value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BoolDefault() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _BoolDefault implements BoolDefault {
  _BoolDefault([this.value = false]);

  @override
  @JsonKey()
  final bool value;

  /// Create a copy of BoolDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BoolDefaultCopyWith<_BoolDefault> get copyWith =>
      __$BoolDefaultCopyWithImpl<_BoolDefault>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BoolDefault &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'BoolDefault(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$BoolDefaultCopyWith<$Res>
    implements $BoolDefaultCopyWith<$Res> {
  factory _$BoolDefaultCopyWith(
          _BoolDefault value, $Res Function(_BoolDefault) _then) =
      __$BoolDefaultCopyWithImpl;
  @override
  @useResult
  $Res call({bool value});
}

/// @nodoc
class __$BoolDefaultCopyWithImpl<$Res> implements _$BoolDefaultCopyWith<$Res> {
  __$BoolDefaultCopyWithImpl(this._self, this._then);

  final _BoolDefault _self;
  final $Res Function(_BoolDefault) _then;

  /// Create a copy of BoolDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_BoolDefault(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$NullDefault {
  bool? get value;

  /// Create a copy of NullDefault
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NullDefaultCopyWith<NullDefault> get copyWith =>
      _$NullDefaultCopyWithImpl<NullDefault>(this as NullDefault, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NullDefault &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'NullDefault(value: $value)';
  }
}

/// @nodoc
abstract mixin class $NullDefaultCopyWith<$Res> {
  factory $NullDefaultCopyWith(
          NullDefault value, $Res Function(NullDefault) _then) =
      _$NullDefaultCopyWithImpl;
  @useResult
  $Res call({bool? value});
}

/// @nodoc
class _$NullDefaultCopyWithImpl<$Res> implements $NullDefaultCopyWith<$Res> {
  _$NullDefaultCopyWithImpl(this._self, this._then);

  final NullDefault _self;
  final $Res Function(NullDefault) _then;

  /// Create a copy of NullDefault
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
              as bool?,
    ));
  }
}

/// Adds pattern-matching-related methods to [NullDefault].
extension NullDefaultPatterns on NullDefault {
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
    TResult Function(_NullDefault value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NullDefault() when $default != null:
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
    TResult Function(_NullDefault value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NullDefault():
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
    TResult? Function(_NullDefault value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NullDefault() when $default != null:
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
    TResult Function(bool? value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NullDefault() when $default != null:
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
    TResult Function(bool? value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NullDefault():
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
    TResult? Function(bool? value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NullDefault() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _NullDefault implements NullDefault {
  _NullDefault([this.value = null]);

  @override
  @JsonKey()
  final bool? value;

  /// Create a copy of NullDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NullDefaultCopyWith<_NullDefault> get copyWith =>
      __$NullDefaultCopyWithImpl<_NullDefault>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NullDefault &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'NullDefault(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$NullDefaultCopyWith<$Res>
    implements $NullDefaultCopyWith<$Res> {
  factory _$NullDefaultCopyWith(
          _NullDefault value, $Res Function(_NullDefault) _then) =
      __$NullDefaultCopyWithImpl;
  @override
  @useResult
  $Res call({bool? value});
}

/// @nodoc
class __$NullDefaultCopyWithImpl<$Res> implements _$NullDefaultCopyWith<$Res> {
  __$NullDefaultCopyWithImpl(this._self, this._then);

  final _NullDefault _self;
  final $Res Function(_NullDefault) _then;

  /// Create a copy of NullDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_NullDefault(
      freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
mixin _$ExplicitConstDefault {
  List<Object> get value;

  /// Create a copy of ExplicitConstDefault
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExplicitConstDefaultCopyWith<ExplicitConstDefault> get copyWith =>
      _$ExplicitConstDefaultCopyWithImpl<ExplicitConstDefault>(
          this as ExplicitConstDefault, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExplicitConstDefault &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'ExplicitConstDefault(value: $value)';
  }
}

/// @nodoc
abstract mixin class $ExplicitConstDefaultCopyWith<$Res> {
  factory $ExplicitConstDefaultCopyWith(ExplicitConstDefault value,
          $Res Function(ExplicitConstDefault) _then) =
      _$ExplicitConstDefaultCopyWithImpl;
  @useResult
  $Res call({List<Object> value});
}

/// @nodoc
class _$ExplicitConstDefaultCopyWithImpl<$Res>
    implements $ExplicitConstDefaultCopyWith<$Res> {
  _$ExplicitConstDefaultCopyWithImpl(this._self, this._then);

  final ExplicitConstDefault _self;
  final $Res Function(ExplicitConstDefault) _then;

  /// Create a copy of ExplicitConstDefault
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

/// Adds pattern-matching-related methods to [ExplicitConstDefault].
extension ExplicitConstDefaultPatterns on ExplicitConstDefault {
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
    TResult Function(_ExplicitConstDefault value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExplicitConstDefault() when $default != null:
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
    TResult Function(_ExplicitConstDefault value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExplicitConstDefault():
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
    TResult? Function(_ExplicitConstDefault value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExplicitConstDefault() when $default != null:
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
      case _ExplicitConstDefault() when $default != null:
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
      case _ExplicitConstDefault():
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
      case _ExplicitConstDefault() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ExplicitConstDefault implements ExplicitConstDefault {
  _ExplicitConstDefault([final List<Object> value = const <Object>[]])
      : _value = value;

  final List<Object> _value;
  @override
  @JsonKey()
  List<Object> get value {
    if (_value is EqualUnmodifiableListView) return _value;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_value);
  }

  /// Create a copy of ExplicitConstDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExplicitConstDefaultCopyWith<_ExplicitConstDefault> get copyWith =>
      __$ExplicitConstDefaultCopyWithImpl<_ExplicitConstDefault>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExplicitConstDefault &&
            const DeepCollectionEquality().equals(other._value, _value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_value));

  @override
  String toString() {
    return 'ExplicitConstDefault(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$ExplicitConstDefaultCopyWith<$Res>
    implements $ExplicitConstDefaultCopyWith<$Res> {
  factory _$ExplicitConstDefaultCopyWith(_ExplicitConstDefault value,
          $Res Function(_ExplicitConstDefault) _then) =
      __$ExplicitConstDefaultCopyWithImpl;
  @override
  @useResult
  $Res call({List<Object> value});
}

/// @nodoc
class __$ExplicitConstDefaultCopyWithImpl<$Res>
    implements _$ExplicitConstDefaultCopyWith<$Res> {
  __$ExplicitConstDefaultCopyWithImpl(this._self, this._then);

  final _ExplicitConstDefault _self;
  final $Res Function(_ExplicitConstDefault) _then;

  /// Create a copy of ExplicitConstDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_ExplicitConstDefault(
      null == value
          ? _self._value
          : value // ignore: cast_nullable_to_non_nullable
              as List<Object>,
    ));
  }
}

/// @nodoc
mixin _$StaticConstDefault {
  Duration get value;

  /// Create a copy of StaticConstDefault
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StaticConstDefaultCopyWith<StaticConstDefault> get copyWith =>
      _$StaticConstDefaultCopyWithImpl<StaticConstDefault>(
          this as StaticConstDefault, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StaticConstDefault &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'StaticConstDefault(value: $value)';
  }
}

/// @nodoc
abstract mixin class $StaticConstDefaultCopyWith<$Res> {
  factory $StaticConstDefaultCopyWith(
          StaticConstDefault value, $Res Function(StaticConstDefault) _then) =
      _$StaticConstDefaultCopyWithImpl;
  @useResult
  $Res call({Duration value});
}

/// @nodoc
class _$StaticConstDefaultCopyWithImpl<$Res>
    implements $StaticConstDefaultCopyWith<$Res> {
  _$StaticConstDefaultCopyWithImpl(this._self, this._then);

  final StaticConstDefault _self;
  final $Res Function(StaticConstDefault) _then;

  /// Create a copy of StaticConstDefault
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
              as Duration,
    ));
  }
}

/// Adds pattern-matching-related methods to [StaticConstDefault].
extension StaticConstDefaultPatterns on StaticConstDefault {
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
    TResult Function(_StaticConstDefault value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StaticConstDefault() when $default != null:
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
    TResult Function(_StaticConstDefault value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StaticConstDefault():
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
    TResult? Function(_StaticConstDefault value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StaticConstDefault() when $default != null:
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
    TResult Function(Duration value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StaticConstDefault() when $default != null:
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
    TResult Function(Duration value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StaticConstDefault():
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
    TResult? Function(Duration value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StaticConstDefault() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _StaticConstDefault implements StaticConstDefault {
  _StaticConstDefault([this.value = Duration.zero]);

  @override
  @JsonKey()
  final Duration value;

  /// Create a copy of StaticConstDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StaticConstDefaultCopyWith<_StaticConstDefault> get copyWith =>
      __$StaticConstDefaultCopyWithImpl<_StaticConstDefault>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StaticConstDefault &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'StaticConstDefault(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$StaticConstDefaultCopyWith<$Res>
    implements $StaticConstDefaultCopyWith<$Res> {
  factory _$StaticConstDefaultCopyWith(
          _StaticConstDefault value, $Res Function(_StaticConstDefault) _then) =
      __$StaticConstDefaultCopyWithImpl;
  @override
  @useResult
  $Res call({Duration value});
}

/// @nodoc
class __$StaticConstDefaultCopyWithImpl<$Res>
    implements _$StaticConstDefaultCopyWith<$Res> {
  __$StaticConstDefaultCopyWithImpl(this._self, this._then);

  final _StaticConstDefault _self;
  final $Res Function(_StaticConstDefault) _then;

  /// Create a copy of StaticConstDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_StaticConstDefault(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
mixin _$EnumDefault {
  _Enum get value;

  /// Create a copy of EnumDefault
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EnumDefaultCopyWith<EnumDefault> get copyWith =>
      _$EnumDefaultCopyWithImpl<EnumDefault>(this as EnumDefault, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EnumDefault &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'EnumDefault(value: $value)';
  }
}

/// @nodoc
abstract mixin class $EnumDefaultCopyWith<$Res> {
  factory $EnumDefaultCopyWith(
          EnumDefault value, $Res Function(EnumDefault) _then) =
      _$EnumDefaultCopyWithImpl;
  @useResult
  $Res call({_Enum value});
}

/// @nodoc
class _$EnumDefaultCopyWithImpl<$Res> implements $EnumDefaultCopyWith<$Res> {
  _$EnumDefaultCopyWithImpl(this._self, this._then);

  final EnumDefault _self;
  final $Res Function(EnumDefault) _then;

  /// Create a copy of EnumDefault
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
              as _Enum,
    ));
  }
}

/// Adds pattern-matching-related methods to [EnumDefault].
extension EnumDefaultPatterns on EnumDefault {
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
    TResult Function(_EnumDefault value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EnumDefault() when $default != null:
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
    TResult Function(_EnumDefault value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EnumDefault():
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
    TResult? Function(_EnumDefault value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EnumDefault() when $default != null:
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
    TResult Function(_Enum value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EnumDefault() when $default != null:
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
    TResult Function(_Enum value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EnumDefault():
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
    TResult? Function(_Enum value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EnumDefault() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _EnumDefault implements EnumDefault {
  _EnumDefault([this.value = _Enum.a]);

  @override
  @JsonKey()
  final _Enum value;

  /// Create a copy of EnumDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EnumDefaultCopyWith<_EnumDefault> get copyWith =>
      __$EnumDefaultCopyWithImpl<_EnumDefault>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EnumDefault &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'EnumDefault(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$EnumDefaultCopyWith<$Res>
    implements $EnumDefaultCopyWith<$Res> {
  factory _$EnumDefaultCopyWith(
          _EnumDefault value, $Res Function(_EnumDefault) _then) =
      __$EnumDefaultCopyWithImpl;
  @override
  @useResult
  $Res call({_Enum value});
}

/// @nodoc
class __$EnumDefaultCopyWithImpl<$Res> implements _$EnumDefaultCopyWith<$Res> {
  __$EnumDefaultCopyWithImpl(this._self, this._then);

  final _EnumDefault _self;
  final $Res Function(_EnumDefault) _then;

  /// Create a copy of EnumDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_EnumDefault(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as _Enum,
    ));
  }
}
