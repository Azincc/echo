// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'json.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NoWhen {
  int? get first;

  /// Create a copy of NoWhen
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NoWhenCopyWith<NoWhen> get copyWith =>
      _$NoWhenCopyWithImpl<NoWhen>(this as NoWhen, _$identity);

  /// Serializes this NoWhen to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NoWhen &&
            (identical(other.first, first) || other.first == first));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, first);

  @override
  String toString() {
    return 'NoWhen(first: $first)';
  }
}

/// @nodoc
abstract mixin class $NoWhenCopyWith<$Res> {
  factory $NoWhenCopyWith(NoWhen value, $Res Function(NoWhen) _then) =
      _$NoWhenCopyWithImpl;
  @useResult
  $Res call({int? first});
}

/// @nodoc
class _$NoWhenCopyWithImpl<$Res> implements $NoWhenCopyWith<$Res> {
  _$NoWhenCopyWithImpl(this._self, this._then);

  final NoWhen _self;
  final $Res Function(NoWhen) _then;

  /// Create a copy of NoWhen
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? first = freezed,
  }) {
    return _then(_self.copyWith(
      first: freezed == first
          ? _self.first
          : first // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [NoWhen].
extension NoWhenPatterns on NoWhen {
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
    TResult Function(_NoWhen value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NoWhen() when $default != null:
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
    TResult Function(_NoWhen value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NoWhen():
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
    TResult? Function(_NoWhen value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NoWhen() when $default != null:
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
    TResult Function(int? first)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NoWhen() when $default != null:
        return $default(_that.first);
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
    TResult Function(int? first) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NoWhen():
        return $default(_that.first);
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
    TResult? Function(int? first)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NoWhen() when $default != null:
        return $default(_that.first);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _NoWhen implements NoWhen {
  _NoWhen({this.first});
  factory _NoWhen.fromJson(Map<String, dynamic> json) => _$NoWhenFromJson(json);

  @override
  final int? first;

  /// Create a copy of NoWhen
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NoWhenCopyWith<_NoWhen> get copyWith =>
      __$NoWhenCopyWithImpl<_NoWhen>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NoWhenToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NoWhen &&
            (identical(other.first, first) || other.first == first));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, first);

  @override
  String toString() {
    return 'NoWhen(first: $first)';
  }
}

/// @nodoc
abstract mixin class _$NoWhenCopyWith<$Res> implements $NoWhenCopyWith<$Res> {
  factory _$NoWhenCopyWith(_NoWhen value, $Res Function(_NoWhen) _then) =
      __$NoWhenCopyWithImpl;
  @override
  @useResult
  $Res call({int? first});
}

/// @nodoc
class __$NoWhenCopyWithImpl<$Res> implements _$NoWhenCopyWith<$Res> {
  __$NoWhenCopyWithImpl(this._self, this._then);

  final _NoWhen _self;
  final $Res Function(_NoWhen) _then;

  /// Create a copy of NoWhen
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? first = freezed,
  }) {
    return _then(_NoWhen(
      first: freezed == first
          ? _self.first
          : first // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

UnionJsonWithExtends _$UnionJsonWithExtendsFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'first':
      return _UnionJsonFirstWithExtends.fromJson(json);
    case 'second':
      return _UnionJsonSecondWithExtends.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json,
          'runtimeType',
          'UnionJsonWithExtends',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$UnionJsonWithExtends {
  /// Serializes this UnionJsonWithExtends to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is UnionJsonWithExtends);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'UnionJsonWithExtends()';
  }
}

/// @nodoc
class $UnionJsonWithExtendsCopyWith<$Res> {
  $UnionJsonWithExtendsCopyWith(
      UnionJsonWithExtends _, $Res Function(UnionJsonWithExtends) __);
}

/// Adds pattern-matching-related methods to [UnionJsonWithExtends].
extension UnionJsonWithExtendsPatterns on UnionJsonWithExtends {
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
    TResult Function(_UnionJsonFirstWithExtends value)? first,
    TResult Function(_UnionJsonSecondWithExtends value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnionJsonFirstWithExtends() when first != null:
        return first(_that);
      case _UnionJsonSecondWithExtends() when second != null:
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
  TResult map<TResult extends Object?>({
    required TResult Function(_UnionJsonFirstWithExtends value) first,
    required TResult Function(_UnionJsonSecondWithExtends value) second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionJsonFirstWithExtends():
        return first(_that);
      case _UnionJsonSecondWithExtends():
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnionJsonFirstWithExtends value)? first,
    TResult? Function(_UnionJsonSecondWithExtends value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionJsonFirstWithExtends() when first != null:
        return first(_that);
      case _UnionJsonSecondWithExtends() when second != null:
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? first)? first,
    TResult Function(int? second)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnionJsonFirstWithExtends() when first != null:
        return first(_that.first);
      case _UnionJsonSecondWithExtends() when second != null:
        return second(_that.second);
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
    required TResult Function(int? first) first,
    required TResult Function(int? second) second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionJsonFirstWithExtends():
        return first(_that.first);
      case _UnionJsonSecondWithExtends():
        return second(_that.second);
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
    TResult? Function(int? first)? first,
    TResult? Function(int? second)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionJsonFirstWithExtends() when first != null:
        return first(_that.first);
      case _UnionJsonSecondWithExtends() when second != null:
        return second(_that.second);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UnionJsonFirstWithExtends extends UnionJsonWithExtends {
  _UnionJsonFirstWithExtends({this.first, final String? $type})
      : $type = $type ?? 'first',
        super._();
  factory _UnionJsonFirstWithExtends.fromJson(Map<String, dynamic> json) =>
      _$UnionJsonFirstWithExtendsFromJson(json);

  final int? first;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnionJsonWithExtends
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnionJsonFirstWithExtendsCopyWith<_UnionJsonFirstWithExtends>
      get copyWith =>
          __$UnionJsonFirstWithExtendsCopyWithImpl<_UnionJsonFirstWithExtends>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnionJsonFirstWithExtendsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnionJsonFirstWithExtends &&
            (identical(other.first, first) || other.first == first));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, first);

  @override
  String toString() {
    return 'UnionJsonWithExtends.first(first: $first)';
  }
}

/// @nodoc
abstract mixin class _$UnionJsonFirstWithExtendsCopyWith<$Res>
    implements $UnionJsonWithExtendsCopyWith<$Res> {
  factory _$UnionJsonFirstWithExtendsCopyWith(_UnionJsonFirstWithExtends value,
          $Res Function(_UnionJsonFirstWithExtends) _then) =
      __$UnionJsonFirstWithExtendsCopyWithImpl;
  @useResult
  $Res call({int? first});
}

/// @nodoc
class __$UnionJsonFirstWithExtendsCopyWithImpl<$Res>
    implements _$UnionJsonFirstWithExtendsCopyWith<$Res> {
  __$UnionJsonFirstWithExtendsCopyWithImpl(this._self, this._then);

  final _UnionJsonFirstWithExtends _self;
  final $Res Function(_UnionJsonFirstWithExtends) _then;

  /// Create a copy of UnionJsonWithExtends
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? first = freezed,
  }) {
    return _then(_UnionJsonFirstWithExtends(
      first: freezed == first
          ? _self.first
          : first // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UnionJsonSecondWithExtends extends UnionJsonWithExtends {
  _UnionJsonSecondWithExtends({this.second, final String? $type})
      : $type = $type ?? 'second',
        super._();
  factory _UnionJsonSecondWithExtends.fromJson(Map<String, dynamic> json) =>
      _$UnionJsonSecondWithExtendsFromJson(json);

  final int? second;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnionJsonWithExtends
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnionJsonSecondWithExtendsCopyWith<_UnionJsonSecondWithExtends>
      get copyWith => __$UnionJsonSecondWithExtendsCopyWithImpl<
          _UnionJsonSecondWithExtends>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnionJsonSecondWithExtendsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnionJsonSecondWithExtends &&
            (identical(other.second, second) || other.second == second));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, second);

  @override
  String toString() {
    return 'UnionJsonWithExtends.second(second: $second)';
  }
}

/// @nodoc
abstract mixin class _$UnionJsonSecondWithExtendsCopyWith<$Res>
    implements $UnionJsonWithExtendsCopyWith<$Res> {
  factory _$UnionJsonSecondWithExtendsCopyWith(
          _UnionJsonSecondWithExtends value,
          $Res Function(_UnionJsonSecondWithExtends) _then) =
      __$UnionJsonSecondWithExtendsCopyWithImpl;
  @useResult
  $Res call({int? second});
}

/// @nodoc
class __$UnionJsonSecondWithExtendsCopyWithImpl<$Res>
    implements _$UnionJsonSecondWithExtendsCopyWith<$Res> {
  __$UnionJsonSecondWithExtendsCopyWithImpl(this._self, this._then);

  final _UnionJsonSecondWithExtends _self;
  final $Res Function(_UnionJsonSecondWithExtends) _then;

  /// Create a copy of UnionJsonWithExtends
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? second = freezed,
  }) {
    return _then(_UnionJsonSecondWithExtends(
      second: freezed == second
          ? _self.second
          : second // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

_PUnionJsonWithExtends _$PUnionJsonWithExtendsFromJson(
    Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'first':
      return _PUnionJsonFirstWithExtends.fromJson(json);
    case 'second':
      return _PUnionJsonSecondWithExtends.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json,
          'runtimeType',
          '_PUnionJsonWithExtends',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$PUnionJsonWithExtends {
  /// Serializes this _PUnionJsonWithExtends to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _PUnionJsonWithExtends);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return '_PUnionJsonWithExtends()';
  }
}

/// @nodoc
class _$PUnionJsonWithExtendsCopyWith<$Res> {
  _$PUnionJsonWithExtendsCopyWith(
      _PUnionJsonWithExtends _, $Res Function(_PUnionJsonWithExtends) __);
}

/// Adds pattern-matching-related methods to [_PUnionJsonWithExtends].
extension _PUnionJsonWithExtendsPatterns on _PUnionJsonWithExtends {
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
    TResult Function(_PUnionJsonFirstWithExtends value)? first,
    TResult Function(_PUnionJsonSecondWithExtends value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PUnionJsonFirstWithExtends() when first != null:
        return first(_that);
      case _PUnionJsonSecondWithExtends() when second != null:
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
  TResult map<TResult extends Object?>({
    required TResult Function(_PUnionJsonFirstWithExtends value) first,
    required TResult Function(_PUnionJsonSecondWithExtends value) second,
  }) {
    final _that = this;
    switch (_that) {
      case _PUnionJsonFirstWithExtends():
        return first(_that);
      case _PUnionJsonSecondWithExtends():
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PUnionJsonFirstWithExtends value)? first,
    TResult? Function(_PUnionJsonSecondWithExtends value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _PUnionJsonFirstWithExtends() when first != null:
        return first(_that);
      case _PUnionJsonSecondWithExtends() when second != null:
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? first)? first,
    TResult Function(int? second)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PUnionJsonFirstWithExtends() when first != null:
        return first(_that.first);
      case _PUnionJsonSecondWithExtends() when second != null:
        return second(_that.second);
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
    required TResult Function(int? first) first,
    required TResult Function(int? second) second,
  }) {
    final _that = this;
    switch (_that) {
      case _PUnionJsonFirstWithExtends():
        return first(_that.first);
      case _PUnionJsonSecondWithExtends():
        return second(_that.second);
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
    TResult? Function(int? first)? first,
    TResult? Function(int? second)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _PUnionJsonFirstWithExtends() when first != null:
        return first(_that.first);
      case _PUnionJsonSecondWithExtends() when second != null:
        return second(_that.second);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PUnionJsonFirstWithExtends extends _PUnionJsonWithExtends {
  _PUnionJsonFirstWithExtends({this.first, final String? $type})
      : $type = $type ?? 'first',
        super._();
  factory _PUnionJsonFirstWithExtends.fromJson(Map<String, dynamic> json) =>
      _$PUnionJsonFirstWithExtendsFromJson(json);

  final int? first;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of _PUnionJsonWithExtends
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PUnionJsonFirstWithExtendsCopyWith<_PUnionJsonFirstWithExtends>
      get copyWith => __$PUnionJsonFirstWithExtendsCopyWithImpl<
          _PUnionJsonFirstWithExtends>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PUnionJsonFirstWithExtendsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PUnionJsonFirstWithExtends &&
            (identical(other.first, first) || other.first == first));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, first);

  @override
  String toString() {
    return '_PUnionJsonWithExtends.first(first: $first)';
  }
}

/// @nodoc
abstract mixin class _$PUnionJsonFirstWithExtendsCopyWith<$Res>
    implements _$PUnionJsonWithExtendsCopyWith<$Res> {
  factory _$PUnionJsonFirstWithExtendsCopyWith(
          _PUnionJsonFirstWithExtends value,
          $Res Function(_PUnionJsonFirstWithExtends) _then) =
      __$PUnionJsonFirstWithExtendsCopyWithImpl;
  @useResult
  $Res call({int? first});
}

/// @nodoc
class __$PUnionJsonFirstWithExtendsCopyWithImpl<$Res>
    implements _$PUnionJsonFirstWithExtendsCopyWith<$Res> {
  __$PUnionJsonFirstWithExtendsCopyWithImpl(this._self, this._then);

  final _PUnionJsonFirstWithExtends _self;
  final $Res Function(_PUnionJsonFirstWithExtends) _then;

  /// Create a copy of _PUnionJsonWithExtends
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? first = freezed,
  }) {
    return _then(_PUnionJsonFirstWithExtends(
      first: freezed == first
          ? _self.first
          : first // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PUnionJsonSecondWithExtends extends _PUnionJsonWithExtends {
  _PUnionJsonSecondWithExtends({this.second, final String? $type})
      : $type = $type ?? 'second',
        super._();
  factory _PUnionJsonSecondWithExtends.fromJson(Map<String, dynamic> json) =>
      _$PUnionJsonSecondWithExtendsFromJson(json);

  final int? second;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of _PUnionJsonWithExtends
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PUnionJsonSecondWithExtendsCopyWith<_PUnionJsonSecondWithExtends>
      get copyWith => __$PUnionJsonSecondWithExtendsCopyWithImpl<
          _PUnionJsonSecondWithExtends>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PUnionJsonSecondWithExtendsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PUnionJsonSecondWithExtends &&
            (identical(other.second, second) || other.second == second));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, second);

  @override
  String toString() {
    return '_PUnionJsonWithExtends.second(second: $second)';
  }
}

/// @nodoc
abstract mixin class _$PUnionJsonSecondWithExtendsCopyWith<$Res>
    implements _$PUnionJsonWithExtendsCopyWith<$Res> {
  factory _$PUnionJsonSecondWithExtendsCopyWith(
          _PUnionJsonSecondWithExtends value,
          $Res Function(_PUnionJsonSecondWithExtends) _then) =
      __$PUnionJsonSecondWithExtendsCopyWithImpl;
  @useResult
  $Res call({int? second});
}

/// @nodoc
class __$PUnionJsonSecondWithExtendsCopyWithImpl<$Res>
    implements _$PUnionJsonSecondWithExtendsCopyWith<$Res> {
  __$PUnionJsonSecondWithExtendsCopyWithImpl(this._self, this._then);

  final _PUnionJsonSecondWithExtends _self;
  final $Res Function(_PUnionJsonSecondWithExtends) _then;

  /// Create a copy of _PUnionJsonWithExtends
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? second = freezed,
  }) {
    return _then(_PUnionJsonSecondWithExtends(
      second: freezed == second
          ? _self.second
          : second // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
mixin _$Regression409 {
  dynamic get totalResults;

  /// Create a copy of Regression409
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Regression409CopyWith<Regression409> get copyWith =>
      _$Regression409CopyWithImpl<Regression409>(
          this as Regression409, _$identity);

  /// Serializes this Regression409 to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Regression409 &&
            const DeepCollectionEquality()
                .equals(other.totalResults, totalResults));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(totalResults));

  @override
  String toString() {
    return 'Regression409(totalResults: $totalResults)';
  }
}

/// @nodoc
abstract mixin class $Regression409CopyWith<$Res> {
  factory $Regression409CopyWith(
          Regression409 value, $Res Function(Regression409) _then) =
      _$Regression409CopyWithImpl;
  @useResult
  $Res call({dynamic totalResults});
}

/// @nodoc
class _$Regression409CopyWithImpl<$Res>
    implements $Regression409CopyWith<$Res> {
  _$Regression409CopyWithImpl(this._self, this._then);

  final Regression409 _self;
  final $Res Function(Regression409) _then;

  /// Create a copy of Regression409
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalResults = freezed,
  }) {
    return _then(_self.copyWith(
      totalResults: freezed == totalResults
          ? _self.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// Adds pattern-matching-related methods to [Regression409].
extension Regression409Patterns on Regression409 {
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
    TResult Function(_Regression409 value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Regression409() when $default != null:
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
    TResult Function(_Regression409 value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression409():
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
    TResult? Function(_Regression409 value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression409() when $default != null:
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
    TResult Function(dynamic totalResults)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Regression409() when $default != null:
        return $default(_that.totalResults);
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
    TResult Function(dynamic totalResults) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression409():
        return $default(_that.totalResults);
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
    TResult? Function(dynamic totalResults)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression409() when $default != null:
        return $default(_that.totalResults);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Regression409 implements Regression409 {
  _Regression409({this.totalResults});
  factory _Regression409.fromJson(Map<String, dynamic> json) =>
      _$Regression409FromJson(json);

  @override
  final dynamic totalResults;

  /// Create a copy of Regression409
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$Regression409CopyWith<_Regression409> get copyWith =>
      __$Regression409CopyWithImpl<_Regression409>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$Regression409ToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Regression409 &&
            const DeepCollectionEquality()
                .equals(other.totalResults, totalResults));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(totalResults));

  @override
  String toString() {
    return 'Regression409(totalResults: $totalResults)';
  }
}

/// @nodoc
abstract mixin class _$Regression409CopyWith<$Res>
    implements $Regression409CopyWith<$Res> {
  factory _$Regression409CopyWith(
          _Regression409 value, $Res Function(_Regression409) _then) =
      __$Regression409CopyWithImpl;
  @override
  @useResult
  $Res call({dynamic totalResults});
}

/// @nodoc
class __$Regression409CopyWithImpl<$Res>
    implements _$Regression409CopyWith<$Res> {
  __$Regression409CopyWithImpl(this._self, this._then);

  final _Regression409 _self;
  final $Res Function(_Regression409) _then;

  /// Create a copy of Regression409
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? totalResults = freezed,
  }) {
    return _then(_Regression409(
      totalResults: freezed == totalResults
          ? _self.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
mixin _$Regression351 {
  @JsonKey(name: 'total_results')
  int get totalResults;

  /// Create a copy of Regression351
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Regression351CopyWith<Regression351> get copyWith =>
      _$Regression351CopyWithImpl<Regression351>(
          this as Regression351, _$identity);

  /// Serializes this Regression351 to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Regression351 &&
            (identical(other.totalResults, totalResults) ||
                other.totalResults == totalResults));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalResults);

  @override
  String toString() {
    return 'Regression351(totalResults: $totalResults)';
  }
}

/// @nodoc
abstract mixin class $Regression351CopyWith<$Res> {
  factory $Regression351CopyWith(
          Regression351 value, $Res Function(Regression351) _then) =
      _$Regression351CopyWithImpl;
  @useResult
  $Res call({@JsonKey(name: 'total_results') int totalResults});
}

/// @nodoc
class _$Regression351CopyWithImpl<$Res>
    implements $Regression351CopyWith<$Res> {
  _$Regression351CopyWithImpl(this._self, this._then);

  final Regression351 _self;
  final $Res Function(Regression351) _then;

  /// Create a copy of Regression351
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalResults = null,
  }) {
    return _then(_self.copyWith(
      totalResults: null == totalResults
          ? _self.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [Regression351].
extension Regression351Patterns on Regression351 {
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
    TResult Function(_Regression351 value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Regression351() when $default != null:
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
    TResult Function(_Regression351 value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression351():
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
    TResult? Function(_Regression351 value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression351() when $default != null:
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
    TResult Function(@JsonKey(name: 'total_results') int totalResults)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Regression351() when $default != null:
        return $default(_that.totalResults);
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
    TResult Function(@JsonKey(name: 'total_results') int totalResults) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression351():
        return $default(_that.totalResults);
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
    TResult? Function(@JsonKey(name: 'total_results') int totalResults)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression351() when $default != null:
        return $default(_that.totalResults);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Regression351 implements Regression351 {
  _Regression351({@JsonKey(name: 'total_results') required this.totalResults});
  factory _Regression351.fromJson(Map<String, dynamic> json) =>
      _$Regression351FromJson(json);

  @override
  @JsonKey(name: 'total_results')
  final int totalResults;

  /// Create a copy of Regression351
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$Regression351CopyWith<_Regression351> get copyWith =>
      __$Regression351CopyWithImpl<_Regression351>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$Regression351ToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Regression351 &&
            (identical(other.totalResults, totalResults) ||
                other.totalResults == totalResults));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalResults);

  @override
  String toString() {
    return 'Regression351(totalResults: $totalResults)';
  }
}

/// @nodoc
abstract mixin class _$Regression351CopyWith<$Res>
    implements $Regression351CopyWith<$Res> {
  factory _$Regression351CopyWith(
          _Regression351 value, $Res Function(_Regression351) _then) =
      __$Regression351CopyWithImpl;
  @override
  @useResult
  $Res call({@JsonKey(name: 'total_results') int totalResults});
}

/// @nodoc
class __$Regression351CopyWithImpl<$Res>
    implements _$Regression351CopyWith<$Res> {
  __$Regression351CopyWithImpl(this._self, this._then);

  final _Regression351 _self;
  final $Res Function(_Regression351) _then;

  /// Create a copy of Regression351
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? totalResults = null,
  }) {
    return _then(_Regression351(
      totalResults: null == totalResults
          ? _self.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$Regression323 {
  String get id;
  num get amount;

  /// Create a copy of Regression323
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Regression323CopyWith<Regression323> get copyWith =>
      _$Regression323CopyWithImpl<Regression323>(
          this as Regression323, _$identity);

  /// Serializes this Regression323 to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Regression323 &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, amount);

  @override
  String toString() {
    return 'Regression323(id: $id, amount: $amount)';
  }
}

/// @nodoc
abstract mixin class $Regression323CopyWith<$Res> {
  factory $Regression323CopyWith(
          Regression323 value, $Res Function(Regression323) _then) =
      _$Regression323CopyWithImpl;
  @useResult
  $Res call({String id, num amount});
}

/// @nodoc
class _$Regression323CopyWithImpl<$Res>
    implements $Regression323CopyWith<$Res> {
  _$Regression323CopyWithImpl(this._self, this._then);

  final Regression323 _self;
  final $Res Function(Regression323) _then;

  /// Create a copy of Regression323
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// Adds pattern-matching-related methods to [Regression323].
extension Regression323Patterns on Regression323 {
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
    TResult Function(_Regression323 value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Regression323() when $default != null:
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
    TResult Function(_Regression323 value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression323():
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
    TResult? Function(_Regression323 value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression323() when $default != null:
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
    TResult Function(String id, num amount)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Regression323() when $default != null:
        return $default(_that.id, _that.amount);
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
    TResult Function(String id, num amount) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression323():
        return $default(_that.id, _that.amount);
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
    TResult? Function(String id, num amount)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression323() when $default != null:
        return $default(_that.id, _that.amount);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Regression323 implements Regression323 {
  const _Regression323({required this.id, required this.amount});
  factory _Regression323.fromJson(Map<String, dynamic> json) =>
      _$Regression323FromJson(json);

  @override
  final String id;
  @override
  final num amount;

  /// Create a copy of Regression323
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$Regression323CopyWith<_Regression323> get copyWith =>
      __$Regression323CopyWithImpl<_Regression323>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$Regression323ToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Regression323 &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, amount);

  @override
  String toString() {
    return 'Regression323(id: $id, amount: $amount)';
  }
}

/// @nodoc
abstract mixin class _$Regression323CopyWith<$Res>
    implements $Regression323CopyWith<$Res> {
  factory _$Regression323CopyWith(
          _Regression323 value, $Res Function(_Regression323) _then) =
      __$Regression323CopyWithImpl;
  @override
  @useResult
  $Res call({String id, num amount});
}

/// @nodoc
class __$Regression323CopyWithImpl<$Res>
    implements _$Regression323CopyWith<$Res> {
  __$Regression323CopyWithImpl(this._self, this._then);

  final _Regression323 _self;
  final $Res Function(_Regression323) _then;

  /// Create a copy of Regression323
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? amount = null,
  }) {
    return _then(_Regression323(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
mixin _$Regression280 {
  String get label;

  /// Create a copy of Regression280
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Regression280CopyWith<Regression280> get copyWith =>
      _$Regression280CopyWithImpl<Regression280>(
          this as Regression280, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Regression280 &&
            (identical(other.label, label) || other.label == label));
  }

  @override
  int get hashCode => Object.hash(runtimeType, label);

  @override
  String toString() {
    return 'Regression280(label: $label)';
  }
}

/// @nodoc
abstract mixin class $Regression280CopyWith<$Res> {
  factory $Regression280CopyWith(
          Regression280 value, $Res Function(Regression280) _then) =
      _$Regression280CopyWithImpl;
  @useResult
  $Res call({String label});
}

/// @nodoc
class _$Regression280CopyWithImpl<$Res>
    implements $Regression280CopyWith<$Res> {
  _$Regression280CopyWithImpl(this._self, this._then);

  final Regression280 _self;
  final $Res Function(Regression280) _then;

  /// Create a copy of Regression280
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
  }) {
    return _then(_self.copyWith(
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [Regression280].
extension Regression280Patterns on Regression280 {
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
    TResult Function(_Regression280 value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Regression280() when $default != null:
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
    TResult Function(_Regression280 value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression280():
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
    TResult? Function(_Regression280 value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression280() when $default != null:
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
    TResult Function(String label)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Regression280() when $default != null:
        return $default(_that.label);
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
    TResult Function(String label) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression280():
        return $default(_that.label);
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
    TResult? Function(String label)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression280() when $default != null:
        return $default(_that.label);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Regression280 implements Regression280 {
  const _Regression280(this.label);

  @override
  final String label;

  /// Create a copy of Regression280
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$Regression280CopyWith<_Regression280> get copyWith =>
      __$Regression280CopyWithImpl<_Regression280>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Regression280 &&
            (identical(other.label, label) || other.label == label));
  }

  @override
  int get hashCode => Object.hash(runtimeType, label);

  @override
  String toString() {
    return 'Regression280(label: $label)';
  }
}

/// @nodoc
abstract mixin class _$Regression280CopyWith<$Res>
    implements $Regression280CopyWith<$Res> {
  factory _$Regression280CopyWith(
          _Regression280 value, $Res Function(_Regression280) _then) =
      __$Regression280CopyWithImpl;
  @override
  @useResult
  $Res call({String label});
}

/// @nodoc
class __$Regression280CopyWithImpl<$Res>
    implements _$Regression280CopyWith<$Res> {
  __$Regression280CopyWithImpl(this._self, this._then);

  final _Regression280 _self;
  final $Res Function(_Regression280) _then;

  /// Create a copy of Regression280
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? label = null,
  }) {
    return _then(_Regression280(
      null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$Regression280n2 {
  String get label;

  /// Create a copy of Regression280n2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Regression280n2CopyWith<Regression280n2> get copyWith =>
      _$Regression280n2CopyWithImpl<Regression280n2>(
          this as Regression280n2, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Regression280n2 &&
            (identical(other.label, label) || other.label == label));
  }

  @override
  int get hashCode => Object.hash(runtimeType, label);

  @override
  String toString() {
    return 'Regression280n2(label: $label)';
  }
}

/// @nodoc
abstract mixin class $Regression280n2CopyWith<$Res> {
  factory $Regression280n2CopyWith(
          Regression280n2 value, $Res Function(Regression280n2) _then) =
      _$Regression280n2CopyWithImpl;
  @useResult
  $Res call({String label});
}

/// @nodoc
class _$Regression280n2CopyWithImpl<$Res>
    implements $Regression280n2CopyWith<$Res> {
  _$Regression280n2CopyWithImpl(this._self, this._then);

  final Regression280n2 _self;
  final $Res Function(Regression280n2) _then;

  /// Create a copy of Regression280n2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
  }) {
    return _then(_self.copyWith(
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [Regression280n2].
extension Regression280n2Patterns on Regression280n2 {
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
    TResult Function(_Regression280n2 value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Regression280n2() when $default != null:
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
    TResult Function(_Regression280n2 value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression280n2():
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
    TResult? Function(_Regression280n2 value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression280n2() when $default != null:
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
    TResult Function(String label)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Regression280n2() when $default != null:
        return $default(_that.label);
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
    TResult Function(String label) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression280n2():
        return $default(_that.label);
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
    TResult? Function(String label)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Regression280n2() when $default != null:
        return $default(_that.label);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Regression280n2 implements Regression280n2 {
  const _Regression280n2(this.label);

  @override
  final String label;

  /// Create a copy of Regression280n2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$Regression280n2CopyWith<_Regression280n2> get copyWith =>
      __$Regression280n2CopyWithImpl<_Regression280n2>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Regression280n2 &&
            (identical(other.label, label) || other.label == label));
  }

  @override
  int get hashCode => Object.hash(runtimeType, label);

  @override
  String toString() {
    return 'Regression280n2(label: $label)';
  }
}

/// @nodoc
abstract mixin class _$Regression280n2CopyWith<$Res>
    implements $Regression280n2CopyWith<$Res> {
  factory _$Regression280n2CopyWith(
          _Regression280n2 value, $Res Function(_Regression280n2) _then) =
      __$Regression280n2CopyWithImpl;
  @override
  @useResult
  $Res call({String label});
}

/// @nodoc
class __$Regression280n2CopyWithImpl<$Res>
    implements _$Regression280n2CopyWith<$Res> {
  __$Regression280n2CopyWithImpl(this._self, this._then);

  final _Regression280n2 _self;
  final $Res Function(_Regression280n2) _then;

  /// Create a copy of Regression280n2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? label = null,
  }) {
    return _then(_Regression280n2(
      null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$CustomJson {
  String get label;

  /// Create a copy of CustomJson
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomJsonCopyWith<CustomJson> get copyWith =>
      _$CustomJsonCopyWithImpl<CustomJson>(this as CustomJson, _$identity);

  /// Serializes this CustomJson to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomJson &&
            (identical(other.label, label) || other.label == label));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, label);

  @override
  String toString() {
    return 'CustomJson(label: $label)';
  }
}

/// @nodoc
abstract mixin class $CustomJsonCopyWith<$Res> {
  factory $CustomJsonCopyWith(
          CustomJson value, $Res Function(CustomJson) _then) =
      _$CustomJsonCopyWithImpl;
  @useResult
  $Res call({String label});
}

/// @nodoc
class _$CustomJsonCopyWithImpl<$Res> implements $CustomJsonCopyWith<$Res> {
  _$CustomJsonCopyWithImpl(this._self, this._then);

  final CustomJson _self;
  final $Res Function(CustomJson) _then;

  /// Create a copy of CustomJson
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
  }) {
    return _then(_self.copyWith(
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [CustomJson].
extension CustomJsonPatterns on CustomJson {
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
    TResult Function(_CustomJson value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CustomJson() when $default != null:
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
    TResult Function(_CustomJson value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomJson():
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
    TResult? Function(_CustomJson value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomJson() when $default != null:
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
    TResult Function(String label)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CustomJson() when $default != null:
        return $default(_that.label);
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
    TResult Function(String label) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomJson():
        return $default(_that.label);
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
    TResult? Function(String label)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomJson() when $default != null:
        return $default(_that.label);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CustomJson implements CustomJson {
  const _CustomJson(this.label);
  factory _CustomJson.fromJson(Map<String, dynamic> json) =>
      _$CustomJsonFromJson(json);

  @override
  final String label;

  /// Create a copy of CustomJson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CustomJsonCopyWith<_CustomJson> get copyWith =>
      __$CustomJsonCopyWithImpl<_CustomJson>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CustomJsonToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CustomJson &&
            (identical(other.label, label) || other.label == label));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, label);

  @override
  String toString() {
    return 'CustomJson(label: $label)';
  }
}

/// @nodoc
abstract mixin class _$CustomJsonCopyWith<$Res>
    implements $CustomJsonCopyWith<$Res> {
  factory _$CustomJsonCopyWith(
          _CustomJson value, $Res Function(_CustomJson) _then) =
      __$CustomJsonCopyWithImpl;
  @override
  @useResult
  $Res call({String label});
}

/// @nodoc
class __$CustomJsonCopyWithImpl<$Res> implements _$CustomJsonCopyWith<$Res> {
  __$CustomJsonCopyWithImpl(this._self, this._then);

  final _CustomJson _self;
  final $Res Function(_CustomJson) _then;

  /// Create a copy of CustomJson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? label = null,
  }) {
    return _then(_CustomJson(
      null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

FancyCustomKey _$FancyCustomKeyFromJson(Map<String, dynamic> json) {
  switch (json['ty"\'pe']) {
    case 'first':
      return _FancyCustomKeyFirst.fromJson(json);
    case 'second':
      return _FancyCustomKeySecond.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'ty"\'pe', 'FancyCustomKey',
          'Invalid union type "${json['ty"\'pe']}"!');
  }
}

/// @nodoc
mixin _$FancyCustomKey {
  int get a;

  /// Create a copy of FancyCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FancyCustomKeyCopyWith<FancyCustomKey> get copyWith =>
      _$FancyCustomKeyCopyWithImpl<FancyCustomKey>(
          this as FancyCustomKey, _$identity);

  /// Serializes this FancyCustomKey to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FancyCustomKey &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'FancyCustomKey(a: $a)';
  }
}

/// @nodoc
abstract mixin class $FancyCustomKeyCopyWith<$Res> {
  factory $FancyCustomKeyCopyWith(
          FancyCustomKey value, $Res Function(FancyCustomKey) _then) =
      _$FancyCustomKeyCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$FancyCustomKeyCopyWithImpl<$Res>
    implements $FancyCustomKeyCopyWith<$Res> {
  _$FancyCustomKeyCopyWithImpl(this._self, this._then);

  final FancyCustomKey _self;
  final $Res Function(FancyCustomKey) _then;

  /// Create a copy of FancyCustomKey
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

/// Adds pattern-matching-related methods to [FancyCustomKey].
extension FancyCustomKeyPatterns on FancyCustomKey {
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
    TResult Function(_FancyCustomKeyFirst value)? first,
    TResult Function(_FancyCustomKeySecond value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FancyCustomKeyFirst() when first != null:
        return first(_that);
      case _FancyCustomKeySecond() when second != null:
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
  TResult map<TResult extends Object?>({
    required TResult Function(_FancyCustomKeyFirst value) first,
    required TResult Function(_FancyCustomKeySecond value) second,
  }) {
    final _that = this;
    switch (_that) {
      case _FancyCustomKeyFirst():
        return first(_that);
      case _FancyCustomKeySecond():
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FancyCustomKeyFirst value)? first,
    TResult? Function(_FancyCustomKeySecond value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _FancyCustomKeyFirst() when first != null:
        return first(_that);
      case _FancyCustomKeySecond() when second != null:
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int a)? first,
    TResult Function(int a)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FancyCustomKeyFirst() when first != null:
        return first(_that.a);
      case _FancyCustomKeySecond() when second != null:
        return second(_that.a);
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
    required TResult Function(int a) first,
    required TResult Function(int a) second,
  }) {
    final _that = this;
    switch (_that) {
      case _FancyCustomKeyFirst():
        return first(_that.a);
      case _FancyCustomKeySecond():
        return second(_that.a);
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
    TResult? Function(int a)? first,
    TResult? Function(int a)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _FancyCustomKeyFirst() when first != null:
        return first(_that.a);
      case _FancyCustomKeySecond() when second != null:
        return second(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _FancyCustomKeyFirst implements FancyCustomKey {
  const _FancyCustomKeyFirst(this.a, {final String? $type})
      : $type = $type ?? 'first';
  factory _FancyCustomKeyFirst.fromJson(Map<String, dynamic> json) =>
      _$FancyCustomKeyFirstFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'ty"\'pe')
  final String $type;

  /// Create a copy of FancyCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FancyCustomKeyFirstCopyWith<_FancyCustomKeyFirst> get copyWith =>
      __$FancyCustomKeyFirstCopyWithImpl<_FancyCustomKeyFirst>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FancyCustomKeyFirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FancyCustomKeyFirst &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'FancyCustomKey.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$FancyCustomKeyFirstCopyWith<$Res>
    implements $FancyCustomKeyCopyWith<$Res> {
  factory _$FancyCustomKeyFirstCopyWith(_FancyCustomKeyFirst value,
          $Res Function(_FancyCustomKeyFirst) _then) =
      __$FancyCustomKeyFirstCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$FancyCustomKeyFirstCopyWithImpl<$Res>
    implements _$FancyCustomKeyFirstCopyWith<$Res> {
  __$FancyCustomKeyFirstCopyWithImpl(this._self, this._then);

  final _FancyCustomKeyFirst _self;
  final $Res Function(_FancyCustomKeyFirst) _then;

  /// Create a copy of FancyCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_FancyCustomKeyFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _FancyCustomKeySecond implements FancyCustomKey {
  const _FancyCustomKeySecond(this.a, {final String? $type})
      : $type = $type ?? 'second';
  factory _FancyCustomKeySecond.fromJson(Map<String, dynamic> json) =>
      _$FancyCustomKeySecondFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'ty"\'pe')
  final String $type;

  /// Create a copy of FancyCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FancyCustomKeySecondCopyWith<_FancyCustomKeySecond> get copyWith =>
      __$FancyCustomKeySecondCopyWithImpl<_FancyCustomKeySecond>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FancyCustomKeySecondToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FancyCustomKeySecond &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'FancyCustomKey.second(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$FancyCustomKeySecondCopyWith<$Res>
    implements $FancyCustomKeyCopyWith<$Res> {
  factory _$FancyCustomKeySecondCopyWith(_FancyCustomKeySecond value,
          $Res Function(_FancyCustomKeySecond) _then) =
      __$FancyCustomKeySecondCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$FancyCustomKeySecondCopyWithImpl<$Res>
    implements _$FancyCustomKeySecondCopyWith<$Res> {
  __$FancyCustomKeySecondCopyWithImpl(this._self, this._then);

  final _FancyCustomKeySecond _self;
  final $Res Function(_FancyCustomKeySecond) _then;

  /// Create a copy of FancyCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_FancyCustomKeySecond(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

PositionalOptional _$PositionalOptionalFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'first':
      return _PositionalOptionalFirst.fromJson(json);
    case 'second':
      return _PositionalOptionalSecond.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'PositionalOptional',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$PositionalOptional {
  int? get a;

  /// Create a copy of PositionalOptional
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PositionalOptionalCopyWith<PositionalOptional> get copyWith =>
      _$PositionalOptionalCopyWithImpl<PositionalOptional>(
          this as PositionalOptional, _$identity);

  /// Serializes this PositionalOptional to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PositionalOptional &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'PositionalOptional(a: $a)';
  }
}

/// @nodoc
abstract mixin class $PositionalOptionalCopyWith<$Res> {
  factory $PositionalOptionalCopyWith(
          PositionalOptional value, $Res Function(PositionalOptional) _then) =
      _$PositionalOptionalCopyWithImpl;
  @useResult
  $Res call({int? a});
}

/// @nodoc
class _$PositionalOptionalCopyWithImpl<$Res>
    implements $PositionalOptionalCopyWith<$Res> {
  _$PositionalOptionalCopyWithImpl(this._self, this._then);

  final PositionalOptional _self;
  final $Res Function(PositionalOptional) _then;

  /// Create a copy of PositionalOptional
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

/// Adds pattern-matching-related methods to [PositionalOptional].
extension PositionalOptionalPatterns on PositionalOptional {
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
    TResult Function(_PositionalOptionalFirst value)? first,
    TResult Function(_PositionalOptionalSecond value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PositionalOptionalFirst() when first != null:
        return first(_that);
      case _PositionalOptionalSecond() when second != null:
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
  TResult map<TResult extends Object?>({
    required TResult Function(_PositionalOptionalFirst value) first,
    required TResult Function(_PositionalOptionalSecond value) second,
  }) {
    final _that = this;
    switch (_that) {
      case _PositionalOptionalFirst():
        return first(_that);
      case _PositionalOptionalSecond():
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PositionalOptionalFirst value)? first,
    TResult? Function(_PositionalOptionalSecond value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _PositionalOptionalFirst() when first != null:
        return first(_that);
      case _PositionalOptionalSecond() when second != null:
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? a)? first,
    TResult Function(int? a)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PositionalOptionalFirst() when first != null:
        return first(_that.a);
      case _PositionalOptionalSecond() when second != null:
        return second(_that.a);
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
    required TResult Function(int? a) first,
    required TResult Function(int? a) second,
  }) {
    final _that = this;
    switch (_that) {
      case _PositionalOptionalFirst():
        return first(_that.a);
      case _PositionalOptionalSecond():
        return second(_that.a);
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
    TResult? Function(int? a)? first,
    TResult? Function(int? a)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _PositionalOptionalFirst() when first != null:
        return first(_that.a);
      case _PositionalOptionalSecond() when second != null:
        return second(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PositionalOptionalFirst implements PositionalOptional {
  const _PositionalOptionalFirst([this.a, final String? $type])
      : $type = $type ?? 'first';
  factory _PositionalOptionalFirst.fromJson(Map<String, dynamic> json) =>
      _$PositionalOptionalFirstFromJson(json);

  @override
  final int? a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of PositionalOptional
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PositionalOptionalFirstCopyWith<_PositionalOptionalFirst> get copyWith =>
      __$PositionalOptionalFirstCopyWithImpl<_PositionalOptionalFirst>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PositionalOptionalFirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PositionalOptionalFirst &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'PositionalOptional.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$PositionalOptionalFirstCopyWith<$Res>
    implements $PositionalOptionalCopyWith<$Res> {
  factory _$PositionalOptionalFirstCopyWith(_PositionalOptionalFirst value,
          $Res Function(_PositionalOptionalFirst) _then) =
      __$PositionalOptionalFirstCopyWithImpl;
  @override
  @useResult
  $Res call({int? a});
}

/// @nodoc
class __$PositionalOptionalFirstCopyWithImpl<$Res>
    implements _$PositionalOptionalFirstCopyWith<$Res> {
  __$PositionalOptionalFirstCopyWithImpl(this._self, this._then);

  final _PositionalOptionalFirst _self;
  final $Res Function(_PositionalOptionalFirst) _then;

  /// Create a copy of PositionalOptional
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = freezed,
  }) {
    return _then(_PositionalOptionalFirst(
      freezed == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PositionalOptionalSecond implements PositionalOptional {
  const _PositionalOptionalSecond([this.a, final String? $type])
      : $type = $type ?? 'second';
  factory _PositionalOptionalSecond.fromJson(Map<String, dynamic> json) =>
      _$PositionalOptionalSecondFromJson(json);

  @override
  final int? a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of PositionalOptional
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PositionalOptionalSecondCopyWith<_PositionalOptionalSecond> get copyWith =>
      __$PositionalOptionalSecondCopyWithImpl<_PositionalOptionalSecond>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PositionalOptionalSecondToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PositionalOptionalSecond &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'PositionalOptional.second(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$PositionalOptionalSecondCopyWith<$Res>
    implements $PositionalOptionalCopyWith<$Res> {
  factory _$PositionalOptionalSecondCopyWith(_PositionalOptionalSecond value,
          $Res Function(_PositionalOptionalSecond) _then) =
      __$PositionalOptionalSecondCopyWithImpl;
  @override
  @useResult
  $Res call({int? a});
}

/// @nodoc
class __$PositionalOptionalSecondCopyWithImpl<$Res>
    implements _$PositionalOptionalSecondCopyWith<$Res> {
  __$PositionalOptionalSecondCopyWithImpl(this._self, this._then);

  final _PositionalOptionalSecond _self;
  final $Res Function(_PositionalOptionalSecond) _then;

  /// Create a copy of PositionalOptional
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = freezed,
  }) {
    return _then(_PositionalOptionalSecond(
      freezed == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

RawCustomKey _$RawCustomKeyFromJson(Map<String, dynamic> json) {
  switch (json['\$type']) {
    case 'first':
      return _RawCustomKeyFirst.fromJson(json);
    case 'second':
      return _RawCustomKeySecond.fromJson(json);

    default:
      throw CheckedFromJsonException(json, '\$type', 'RawCustomKey',
          'Invalid union type "${json['\$type']}"!');
  }
}

/// @nodoc
mixin _$RawCustomKey {
  int get a;

  /// Create a copy of RawCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RawCustomKeyCopyWith<RawCustomKey> get copyWith =>
      _$RawCustomKeyCopyWithImpl<RawCustomKey>(
          this as RawCustomKey, _$identity);

  /// Serializes this RawCustomKey to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RawCustomKey &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'RawCustomKey(a: $a)';
  }
}

/// @nodoc
abstract mixin class $RawCustomKeyCopyWith<$Res> {
  factory $RawCustomKeyCopyWith(
          RawCustomKey value, $Res Function(RawCustomKey) _then) =
      _$RawCustomKeyCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$RawCustomKeyCopyWithImpl<$Res> implements $RawCustomKeyCopyWith<$Res> {
  _$RawCustomKeyCopyWithImpl(this._self, this._then);

  final RawCustomKey _self;
  final $Res Function(RawCustomKey) _then;

  /// Create a copy of RawCustomKey
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

/// Adds pattern-matching-related methods to [RawCustomKey].
extension RawCustomKeyPatterns on RawCustomKey {
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
    TResult Function(_RawCustomKeyFirst value)? first,
    TResult Function(_RawCustomKeySecond value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RawCustomKeyFirst() when first != null:
        return first(_that);
      case _RawCustomKeySecond() when second != null:
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
  TResult map<TResult extends Object?>({
    required TResult Function(_RawCustomKeyFirst value) first,
    required TResult Function(_RawCustomKeySecond value) second,
  }) {
    final _that = this;
    switch (_that) {
      case _RawCustomKeyFirst():
        return first(_that);
      case _RawCustomKeySecond():
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RawCustomKeyFirst value)? first,
    TResult? Function(_RawCustomKeySecond value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _RawCustomKeyFirst() when first != null:
        return first(_that);
      case _RawCustomKeySecond() when second != null:
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int a)? first,
    TResult Function(int a)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RawCustomKeyFirst() when first != null:
        return first(_that.a);
      case _RawCustomKeySecond() when second != null:
        return second(_that.a);
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
    required TResult Function(int a) first,
    required TResult Function(int a) second,
  }) {
    final _that = this;
    switch (_that) {
      case _RawCustomKeyFirst():
        return first(_that.a);
      case _RawCustomKeySecond():
        return second(_that.a);
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
    TResult? Function(int a)? first,
    TResult? Function(int a)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _RawCustomKeyFirst() when first != null:
        return first(_that.a);
      case _RawCustomKeySecond() when second != null:
        return second(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RawCustomKeyFirst implements RawCustomKey {
  const _RawCustomKeyFirst(this.a, {final String? $type})
      : $type = $type ?? 'first';
  factory _RawCustomKeyFirst.fromJson(Map<String, dynamic> json) =>
      _$RawCustomKeyFirstFromJson(json);

  @override
  final int a;

  @JsonKey(name: '\$type')
  final String $type;

  /// Create a copy of RawCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RawCustomKeyFirstCopyWith<_RawCustomKeyFirst> get copyWith =>
      __$RawCustomKeyFirstCopyWithImpl<_RawCustomKeyFirst>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RawCustomKeyFirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RawCustomKeyFirst &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'RawCustomKey.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$RawCustomKeyFirstCopyWith<$Res>
    implements $RawCustomKeyCopyWith<$Res> {
  factory _$RawCustomKeyFirstCopyWith(
          _RawCustomKeyFirst value, $Res Function(_RawCustomKeyFirst) _then) =
      __$RawCustomKeyFirstCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$RawCustomKeyFirstCopyWithImpl<$Res>
    implements _$RawCustomKeyFirstCopyWith<$Res> {
  __$RawCustomKeyFirstCopyWithImpl(this._self, this._then);

  final _RawCustomKeyFirst _self;
  final $Res Function(_RawCustomKeyFirst) _then;

  /// Create a copy of RawCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_RawCustomKeyFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _RawCustomKeySecond implements RawCustomKey {
  const _RawCustomKeySecond(this.a, {final String? $type})
      : $type = $type ?? 'second';
  factory _RawCustomKeySecond.fromJson(Map<String, dynamic> json) =>
      _$RawCustomKeySecondFromJson(json);

  @override
  final int a;

  @JsonKey(name: '\$type')
  final String $type;

  /// Create a copy of RawCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RawCustomKeySecondCopyWith<_RawCustomKeySecond> get copyWith =>
      __$RawCustomKeySecondCopyWithImpl<_RawCustomKeySecond>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RawCustomKeySecondToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RawCustomKeySecond &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'RawCustomKey.second(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$RawCustomKeySecondCopyWith<$Res>
    implements $RawCustomKeyCopyWith<$Res> {
  factory _$RawCustomKeySecondCopyWith(
          _RawCustomKeySecond value, $Res Function(_RawCustomKeySecond) _then) =
      __$RawCustomKeySecondCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$RawCustomKeySecondCopyWithImpl<$Res>
    implements _$RawCustomKeySecondCopyWith<$Res> {
  __$RawCustomKeySecondCopyWithImpl(this._self, this._then);

  final _RawCustomKeySecond _self;
  final $Res Function(_RawCustomKeySecond) _then;

  /// Create a copy of RawCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_RawCustomKeySecond(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

CustomKey _$CustomKeyFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'first':
      return _CustomKeyFirst.fromJson(json);
    case 'second':
      return _CustomKeySecond.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json, 'type', 'CustomKey', 'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$CustomKey {
  int get a;

  /// Create a copy of CustomKey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomKeyCopyWith<CustomKey> get copyWith =>
      _$CustomKeyCopyWithImpl<CustomKey>(this as CustomKey, _$identity);

  /// Serializes this CustomKey to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomKey &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'CustomKey(a: $a)';
  }
}

/// @nodoc
abstract mixin class $CustomKeyCopyWith<$Res> {
  factory $CustomKeyCopyWith(CustomKey value, $Res Function(CustomKey) _then) =
      _$CustomKeyCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$CustomKeyCopyWithImpl<$Res> implements $CustomKeyCopyWith<$Res> {
  _$CustomKeyCopyWithImpl(this._self, this._then);

  final CustomKey _self;
  final $Res Function(CustomKey) _then;

  /// Create a copy of CustomKey
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

/// Adds pattern-matching-related methods to [CustomKey].
extension CustomKeyPatterns on CustomKey {
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
    TResult Function(_CustomKeyFirst value)? first,
    TResult Function(_CustomKeySecond value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CustomKeyFirst() when first != null:
        return first(_that);
      case _CustomKeySecond() when second != null:
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
  TResult map<TResult extends Object?>({
    required TResult Function(_CustomKeyFirst value) first,
    required TResult Function(_CustomKeySecond value) second,
  }) {
    final _that = this;
    switch (_that) {
      case _CustomKeyFirst():
        return first(_that);
      case _CustomKeySecond():
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CustomKeyFirst value)? first,
    TResult? Function(_CustomKeySecond value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _CustomKeyFirst() when first != null:
        return first(_that);
      case _CustomKeySecond() when second != null:
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int a)? first,
    TResult Function(int a)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CustomKeyFirst() when first != null:
        return first(_that.a);
      case _CustomKeySecond() when second != null:
        return second(_that.a);
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
    required TResult Function(int a) first,
    required TResult Function(int a) second,
  }) {
    final _that = this;
    switch (_that) {
      case _CustomKeyFirst():
        return first(_that.a);
      case _CustomKeySecond():
        return second(_that.a);
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
    TResult? Function(int a)? first,
    TResult? Function(int a)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _CustomKeyFirst() when first != null:
        return first(_that.a);
      case _CustomKeySecond() when second != null:
        return second(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CustomKeyFirst implements CustomKey {
  const _CustomKeyFirst(this.a, {final String? $type})
      : $type = $type ?? 'first';
  factory _CustomKeyFirst.fromJson(Map<String, dynamic> json) =>
      _$CustomKeyFirstFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'type')
  final String $type;

  /// Create a copy of CustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CustomKeyFirstCopyWith<_CustomKeyFirst> get copyWith =>
      __$CustomKeyFirstCopyWithImpl<_CustomKeyFirst>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CustomKeyFirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CustomKeyFirst &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'CustomKey.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$CustomKeyFirstCopyWith<$Res>
    implements $CustomKeyCopyWith<$Res> {
  factory _$CustomKeyFirstCopyWith(
          _CustomKeyFirst value, $Res Function(_CustomKeyFirst) _then) =
      __$CustomKeyFirstCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$CustomKeyFirstCopyWithImpl<$Res>
    implements _$CustomKeyFirstCopyWith<$Res> {
  __$CustomKeyFirstCopyWithImpl(this._self, this._then);

  final _CustomKeyFirst _self;
  final $Res Function(_CustomKeyFirst) _then;

  /// Create a copy of CustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_CustomKeyFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _CustomKeySecond implements CustomKey {
  const _CustomKeySecond(this.a, {final String? $type})
      : $type = $type ?? 'second';
  factory _CustomKeySecond.fromJson(Map<String, dynamic> json) =>
      _$CustomKeySecondFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'type')
  final String $type;

  /// Create a copy of CustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CustomKeySecondCopyWith<_CustomKeySecond> get copyWith =>
      __$CustomKeySecondCopyWithImpl<_CustomKeySecond>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CustomKeySecondToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CustomKeySecond &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'CustomKey.second(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$CustomKeySecondCopyWith<$Res>
    implements $CustomKeyCopyWith<$Res> {
  factory _$CustomKeySecondCopyWith(
          _CustomKeySecond value, $Res Function(_CustomKeySecond) _then) =
      __$CustomKeySecondCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$CustomKeySecondCopyWithImpl<$Res>
    implements _$CustomKeySecondCopyWith<$Res> {
  __$CustomKeySecondCopyWithImpl(this._self, this._then);

  final _CustomKeySecond _self;
  final $Res Function(_CustomKeySecond) _then;

  /// Create a copy of CustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_CustomKeySecond(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

CustomUnionValue _$CustomUnionValueFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'first':
      return _CustomUnionValueFirst.fromJson(json);
    case 'SECOND':
      return _CustomUnionValueSecond.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'CustomUnionValue',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$CustomUnionValue {
  int get a;

  /// Create a copy of CustomUnionValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUnionValueCopyWith<CustomUnionValue> get copyWith =>
      _$CustomUnionValueCopyWithImpl<CustomUnionValue>(
          this as CustomUnionValue, _$identity);

  /// Serializes this CustomUnionValue to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUnionValue &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'CustomUnionValue(a: $a)';
  }
}

/// @nodoc
abstract mixin class $CustomUnionValueCopyWith<$Res> {
  factory $CustomUnionValueCopyWith(
          CustomUnionValue value, $Res Function(CustomUnionValue) _then) =
      _$CustomUnionValueCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$CustomUnionValueCopyWithImpl<$Res>
    implements $CustomUnionValueCopyWith<$Res> {
  _$CustomUnionValueCopyWithImpl(this._self, this._then);

  final CustomUnionValue _self;
  final $Res Function(CustomUnionValue) _then;

  /// Create a copy of CustomUnionValue
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

/// Adds pattern-matching-related methods to [CustomUnionValue].
extension CustomUnionValuePatterns on CustomUnionValue {
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
    TResult Function(_CustomUnionValueFirst value)? first,
    TResult Function(_CustomUnionValueSecond value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CustomUnionValueFirst() when first != null:
        return first(_that);
      case _CustomUnionValueSecond() when second != null:
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
  TResult map<TResult extends Object?>({
    required TResult Function(_CustomUnionValueFirst value) first,
    required TResult Function(_CustomUnionValueSecond value) second,
  }) {
    final _that = this;
    switch (_that) {
      case _CustomUnionValueFirst():
        return first(_that);
      case _CustomUnionValueSecond():
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CustomUnionValueFirst value)? first,
    TResult? Function(_CustomUnionValueSecond value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _CustomUnionValueFirst() when first != null:
        return first(_that);
      case _CustomUnionValueSecond() when second != null:
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int a)? first,
    TResult Function(int a)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CustomUnionValueFirst() when first != null:
        return first(_that.a);
      case _CustomUnionValueSecond() when second != null:
        return second(_that.a);
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
    required TResult Function(int a) first,
    required TResult Function(int a) second,
  }) {
    final _that = this;
    switch (_that) {
      case _CustomUnionValueFirst():
        return first(_that.a);
      case _CustomUnionValueSecond():
        return second(_that.a);
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
    TResult? Function(int a)? first,
    TResult? Function(int a)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _CustomUnionValueFirst() when first != null:
        return first(_that.a);
      case _CustomUnionValueSecond() when second != null:
        return second(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CustomUnionValueFirst implements CustomUnionValue {
  const _CustomUnionValueFirst(this.a, {final String? $type})
      : $type = $type ?? 'first';
  factory _CustomUnionValueFirst.fromJson(Map<String, dynamic> json) =>
      _$CustomUnionValueFirstFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of CustomUnionValue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CustomUnionValueFirstCopyWith<_CustomUnionValueFirst> get copyWith =>
      __$CustomUnionValueFirstCopyWithImpl<_CustomUnionValueFirst>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CustomUnionValueFirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CustomUnionValueFirst &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'CustomUnionValue.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$CustomUnionValueFirstCopyWith<$Res>
    implements $CustomUnionValueCopyWith<$Res> {
  factory _$CustomUnionValueFirstCopyWith(_CustomUnionValueFirst value,
          $Res Function(_CustomUnionValueFirst) _then) =
      __$CustomUnionValueFirstCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$CustomUnionValueFirstCopyWithImpl<$Res>
    implements _$CustomUnionValueFirstCopyWith<$Res> {
  __$CustomUnionValueFirstCopyWithImpl(this._self, this._then);

  final _CustomUnionValueFirst _self;
  final $Res Function(_CustomUnionValueFirst) _then;

  /// Create a copy of CustomUnionValue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_CustomUnionValueFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _CustomUnionValueSecond implements CustomUnionValue {
  const _CustomUnionValueSecond(this.a, {final String? $type})
      : $type = $type ?? 'SECOND';
  factory _CustomUnionValueSecond.fromJson(Map<String, dynamic> json) =>
      _$CustomUnionValueSecondFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of CustomUnionValue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CustomUnionValueSecondCopyWith<_CustomUnionValueSecond> get copyWith =>
      __$CustomUnionValueSecondCopyWithImpl<_CustomUnionValueSecond>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CustomUnionValueSecondToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CustomUnionValueSecond &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'CustomUnionValue.second(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$CustomUnionValueSecondCopyWith<$Res>
    implements $CustomUnionValueCopyWith<$Res> {
  factory _$CustomUnionValueSecondCopyWith(_CustomUnionValueSecond value,
          $Res Function(_CustomUnionValueSecond) _then) =
      __$CustomUnionValueSecondCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$CustomUnionValueSecondCopyWithImpl<$Res>
    implements _$CustomUnionValueSecondCopyWith<$Res> {
  __$CustomUnionValueSecondCopyWithImpl(this._self, this._then);

  final _CustomUnionValueSecond _self;
  final $Res Function(_CustomUnionValueSecond) _then;

  /// Create a copy of CustomUnionValue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_CustomUnionValueSecond(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

UnionFallback _$UnionFallbackFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'first':
      return _UnionFallbackFirst.fromJson(json);
    case 'second':
      return _UnionFallbackSecond.fromJson(json);

    default:
      return _UnionFallbackFallback.fromJson(json);
  }
}

/// @nodoc
mixin _$UnionFallback {
  int get a;

  /// Create a copy of UnionFallback
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnionFallbackCopyWith<UnionFallback> get copyWith =>
      _$UnionFallbackCopyWithImpl<UnionFallback>(
          this as UnionFallback, _$identity);

  /// Serializes this UnionFallback to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnionFallback &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnionFallback(a: $a)';
  }
}

/// @nodoc
abstract mixin class $UnionFallbackCopyWith<$Res> {
  factory $UnionFallbackCopyWith(
          UnionFallback value, $Res Function(UnionFallback) _then) =
      _$UnionFallbackCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$UnionFallbackCopyWithImpl<$Res>
    implements $UnionFallbackCopyWith<$Res> {
  _$UnionFallbackCopyWithImpl(this._self, this._then);

  final UnionFallback _self;
  final $Res Function(UnionFallback) _then;

  /// Create a copy of UnionFallback
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

/// Adds pattern-matching-related methods to [UnionFallback].
extension UnionFallbackPatterns on UnionFallback {
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
    TResult Function(_UnionFallbackFirst value)? first,
    TResult Function(_UnionFallbackSecond value)? second,
    TResult Function(_UnionFallbackFallback value)? fallback,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnionFallbackFirst() when first != null:
        return first(_that);
      case _UnionFallbackSecond() when second != null:
        return second(_that);
      case _UnionFallbackFallback() when fallback != null:
        return fallback(_that);
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
    required TResult Function(_UnionFallbackFirst value) first,
    required TResult Function(_UnionFallbackSecond value) second,
    required TResult Function(_UnionFallbackFallback value) fallback,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionFallbackFirst():
        return first(_that);
      case _UnionFallbackSecond():
        return second(_that);
      case _UnionFallbackFallback():
        return fallback(_that);
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
    TResult? Function(_UnionFallbackFirst value)? first,
    TResult? Function(_UnionFallbackSecond value)? second,
    TResult? Function(_UnionFallbackFallback value)? fallback,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionFallbackFirst() when first != null:
        return first(_that);
      case _UnionFallbackSecond() when second != null:
        return second(_that);
      case _UnionFallbackFallback() when fallback != null:
        return fallback(_that);
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
    TResult Function(int a)? first,
    TResult Function(int a)? second,
    TResult Function(int a)? fallback,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnionFallbackFirst() when first != null:
        return first(_that.a);
      case _UnionFallbackSecond() when second != null:
        return second(_that.a);
      case _UnionFallbackFallback() when fallback != null:
        return fallback(_that.a);
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
    required TResult Function(int a) first,
    required TResult Function(int a) second,
    required TResult Function(int a) fallback,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionFallbackFirst():
        return first(_that.a);
      case _UnionFallbackSecond():
        return second(_that.a);
      case _UnionFallbackFallback():
        return fallback(_that.a);
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
    TResult? Function(int a)? first,
    TResult? Function(int a)? second,
    TResult? Function(int a)? fallback,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionFallbackFirst() when first != null:
        return first(_that.a);
      case _UnionFallbackSecond() when second != null:
        return second(_that.a);
      case _UnionFallbackFallback() when fallback != null:
        return fallback(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UnionFallbackFirst implements UnionFallback {
  const _UnionFallbackFirst(this.a, {final String? $type})
      : $type = $type ?? 'first';
  factory _UnionFallbackFirst.fromJson(Map<String, dynamic> json) =>
      _$UnionFallbackFirstFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnionFallback
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnionFallbackFirstCopyWith<_UnionFallbackFirst> get copyWith =>
      __$UnionFallbackFirstCopyWithImpl<_UnionFallbackFirst>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnionFallbackFirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnionFallbackFirst &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnionFallback.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnionFallbackFirstCopyWith<$Res>
    implements $UnionFallbackCopyWith<$Res> {
  factory _$UnionFallbackFirstCopyWith(
          _UnionFallbackFirst value, $Res Function(_UnionFallbackFirst) _then) =
      __$UnionFallbackFirstCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnionFallbackFirstCopyWithImpl<$Res>
    implements _$UnionFallbackFirstCopyWith<$Res> {
  __$UnionFallbackFirstCopyWithImpl(this._self, this._then);

  final _UnionFallbackFirst _self;
  final $Res Function(_UnionFallbackFirst) _then;

  /// Create a copy of UnionFallback
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnionFallbackFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UnionFallbackSecond implements UnionFallback {
  const _UnionFallbackSecond(this.a, {final String? $type})
      : $type = $type ?? 'second';
  factory _UnionFallbackSecond.fromJson(Map<String, dynamic> json) =>
      _$UnionFallbackSecondFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnionFallback
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnionFallbackSecondCopyWith<_UnionFallbackSecond> get copyWith =>
      __$UnionFallbackSecondCopyWithImpl<_UnionFallbackSecond>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnionFallbackSecondToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnionFallbackSecond &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnionFallback.second(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnionFallbackSecondCopyWith<$Res>
    implements $UnionFallbackCopyWith<$Res> {
  factory _$UnionFallbackSecondCopyWith(_UnionFallbackSecond value,
          $Res Function(_UnionFallbackSecond) _then) =
      __$UnionFallbackSecondCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnionFallbackSecondCopyWithImpl<$Res>
    implements _$UnionFallbackSecondCopyWith<$Res> {
  __$UnionFallbackSecondCopyWithImpl(this._self, this._then);

  final _UnionFallbackSecond _self;
  final $Res Function(_UnionFallbackSecond) _then;

  /// Create a copy of UnionFallback
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnionFallbackSecond(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UnionFallbackFallback implements UnionFallback {
  const _UnionFallbackFallback(this.a, {final String? $type})
      : $type = $type ?? 'fallback';
  factory _UnionFallbackFallback.fromJson(Map<String, dynamic> json) =>
      _$UnionFallbackFallbackFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnionFallback
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnionFallbackFallbackCopyWith<_UnionFallbackFallback> get copyWith =>
      __$UnionFallbackFallbackCopyWithImpl<_UnionFallbackFallback>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnionFallbackFallbackToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnionFallbackFallback &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnionFallback.fallback(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnionFallbackFallbackCopyWith<$Res>
    implements $UnionFallbackCopyWith<$Res> {
  factory _$UnionFallbackFallbackCopyWith(_UnionFallbackFallback value,
          $Res Function(_UnionFallbackFallback) _then) =
      __$UnionFallbackFallbackCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnionFallbackFallbackCopyWithImpl<$Res>
    implements _$UnionFallbackFallbackCopyWith<$Res> {
  __$UnionFallbackFallbackCopyWithImpl(this._self, this._then);

  final _UnionFallbackFallback _self;
  final $Res Function(_UnionFallbackFallback) _then;

  /// Create a copy of UnionFallback
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnionFallbackFallback(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

UnionFallbackWithDefault _$UnionFallbackWithDefaultFromJson(
    Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'first':
      return _UnionDefaultFallbackFirst.fromJson(json);
    case 'second':
      return _UnionDefaultFallbackSecond.fromJson(json);

    default:
      return _UnionDefaultFallback.fromJson(json);
  }
}

/// @nodoc
mixin _$UnionFallbackWithDefault {
  int get a;

  /// Create a copy of UnionFallbackWithDefault
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnionFallbackWithDefaultCopyWith<UnionFallbackWithDefault> get copyWith =>
      _$UnionFallbackWithDefaultCopyWithImpl<UnionFallbackWithDefault>(
          this as UnionFallbackWithDefault, _$identity);

  /// Serializes this UnionFallbackWithDefault to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnionFallbackWithDefault &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnionFallbackWithDefault(a: $a)';
  }
}

/// @nodoc
abstract mixin class $UnionFallbackWithDefaultCopyWith<$Res> {
  factory $UnionFallbackWithDefaultCopyWith(UnionFallbackWithDefault value,
          $Res Function(UnionFallbackWithDefault) _then) =
      _$UnionFallbackWithDefaultCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$UnionFallbackWithDefaultCopyWithImpl<$Res>
    implements $UnionFallbackWithDefaultCopyWith<$Res> {
  _$UnionFallbackWithDefaultCopyWithImpl(this._self, this._then);

  final UnionFallbackWithDefault _self;
  final $Res Function(UnionFallbackWithDefault) _then;

  /// Create a copy of UnionFallbackWithDefault
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

/// Adds pattern-matching-related methods to [UnionFallbackWithDefault].
extension UnionFallbackWithDefaultPatterns on UnionFallbackWithDefault {
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
    TResult Function(_UnionDefaultFallback value)? $default, {
    TResult Function(_UnionDefaultFallbackFirst value)? first,
    TResult Function(_UnionDefaultFallbackSecond value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnionDefaultFallback() when $default != null:
        return $default(_that);
      case _UnionDefaultFallbackFirst() when first != null:
        return first(_that);
      case _UnionDefaultFallbackSecond() when second != null:
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
    TResult Function(_UnionDefaultFallback value) $default, {
    required TResult Function(_UnionDefaultFallbackFirst value) first,
    required TResult Function(_UnionDefaultFallbackSecond value) second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionDefaultFallback():
        return $default(_that);
      case _UnionDefaultFallbackFirst():
        return first(_that);
      case _UnionDefaultFallbackSecond():
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
    TResult? Function(_UnionDefaultFallback value)? $default, {
    TResult? Function(_UnionDefaultFallbackFirst value)? first,
    TResult? Function(_UnionDefaultFallbackSecond value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionDefaultFallback() when $default != null:
        return $default(_that);
      case _UnionDefaultFallbackFirst() when first != null:
        return first(_that);
      case _UnionDefaultFallbackSecond() when second != null:
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
    TResult Function(int a)? $default, {
    TResult Function(int a)? first,
    TResult Function(int a)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnionDefaultFallback() when $default != null:
        return $default(_that.a);
      case _UnionDefaultFallbackFirst() when first != null:
        return first(_that.a);
      case _UnionDefaultFallbackSecond() when second != null:
        return second(_that.a);
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
    TResult Function(int a) $default, {
    required TResult Function(int a) first,
    required TResult Function(int a) second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionDefaultFallback():
        return $default(_that.a);
      case _UnionDefaultFallbackFirst():
        return first(_that.a);
      case _UnionDefaultFallbackSecond():
        return second(_that.a);
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
    TResult? Function(int a)? $default, {
    TResult? Function(int a)? first,
    TResult? Function(int a)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionDefaultFallback() when $default != null:
        return $default(_that.a);
      case _UnionDefaultFallbackFirst() when first != null:
        return first(_that.a);
      case _UnionDefaultFallbackSecond() when second != null:
        return second(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UnionDefaultFallback implements UnionFallbackWithDefault {
  const _UnionDefaultFallback(this.a, {final String? $type})
      : $type = $type ?? 'default';
  factory _UnionDefaultFallback.fromJson(Map<String, dynamic> json) =>
      _$UnionDefaultFallbackFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnionFallbackWithDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnionDefaultFallbackCopyWith<_UnionDefaultFallback> get copyWith =>
      __$UnionDefaultFallbackCopyWithImpl<_UnionDefaultFallback>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnionDefaultFallbackToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnionDefaultFallback &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnionFallbackWithDefault(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnionDefaultFallbackCopyWith<$Res>
    implements $UnionFallbackWithDefaultCopyWith<$Res> {
  factory _$UnionDefaultFallbackCopyWith(_UnionDefaultFallback value,
          $Res Function(_UnionDefaultFallback) _then) =
      __$UnionDefaultFallbackCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnionDefaultFallbackCopyWithImpl<$Res>
    implements _$UnionDefaultFallbackCopyWith<$Res> {
  __$UnionDefaultFallbackCopyWithImpl(this._self, this._then);

  final _UnionDefaultFallback _self;
  final $Res Function(_UnionDefaultFallback) _then;

  /// Create a copy of UnionFallbackWithDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnionDefaultFallback(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UnionDefaultFallbackFirst implements UnionFallbackWithDefault {
  const _UnionDefaultFallbackFirst(this.a, {final String? $type})
      : $type = $type ?? 'first';
  factory _UnionDefaultFallbackFirst.fromJson(Map<String, dynamic> json) =>
      _$UnionDefaultFallbackFirstFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnionFallbackWithDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnionDefaultFallbackFirstCopyWith<_UnionDefaultFallbackFirst>
      get copyWith =>
          __$UnionDefaultFallbackFirstCopyWithImpl<_UnionDefaultFallbackFirst>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnionDefaultFallbackFirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnionDefaultFallbackFirst &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnionFallbackWithDefault.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnionDefaultFallbackFirstCopyWith<$Res>
    implements $UnionFallbackWithDefaultCopyWith<$Res> {
  factory _$UnionDefaultFallbackFirstCopyWith(_UnionDefaultFallbackFirst value,
          $Res Function(_UnionDefaultFallbackFirst) _then) =
      __$UnionDefaultFallbackFirstCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnionDefaultFallbackFirstCopyWithImpl<$Res>
    implements _$UnionDefaultFallbackFirstCopyWith<$Res> {
  __$UnionDefaultFallbackFirstCopyWithImpl(this._self, this._then);

  final _UnionDefaultFallbackFirst _self;
  final $Res Function(_UnionDefaultFallbackFirst) _then;

  /// Create a copy of UnionFallbackWithDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnionDefaultFallbackFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UnionDefaultFallbackSecond implements UnionFallbackWithDefault {
  const _UnionDefaultFallbackSecond(this.a, {final String? $type})
      : $type = $type ?? 'second';
  factory _UnionDefaultFallbackSecond.fromJson(Map<String, dynamic> json) =>
      _$UnionDefaultFallbackSecondFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnionFallbackWithDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnionDefaultFallbackSecondCopyWith<_UnionDefaultFallbackSecond>
      get copyWith => __$UnionDefaultFallbackSecondCopyWithImpl<
          _UnionDefaultFallbackSecond>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnionDefaultFallbackSecondToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnionDefaultFallbackSecond &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnionFallbackWithDefault.second(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnionDefaultFallbackSecondCopyWith<$Res>
    implements $UnionFallbackWithDefaultCopyWith<$Res> {
  factory _$UnionDefaultFallbackSecondCopyWith(
          _UnionDefaultFallbackSecond value,
          $Res Function(_UnionDefaultFallbackSecond) _then) =
      __$UnionDefaultFallbackSecondCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnionDefaultFallbackSecondCopyWithImpl<$Res>
    implements _$UnionDefaultFallbackSecondCopyWith<$Res> {
  __$UnionDefaultFallbackSecondCopyWithImpl(this._self, this._then);

  final _UnionDefaultFallbackSecond _self;
  final $Res Function(_UnionDefaultFallbackSecond) _then;

  /// Create a copy of UnionFallbackWithDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnionDefaultFallbackSecond(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

UnionKeyFallbackWithDefault _$UnionKeyFallbackWithDefaultFromJson(
    Map<String, dynamic> json) {
  switch (json['key']) {
    case 'first':
      return _UnionKeyDefaultFallbackFirst.fromJson(json);

    default:
      return _UnionKeyDefaultFallback.fromJson(json);
  }
}

/// @nodoc
mixin _$UnionKeyFallbackWithDefault {
  String get key;

  /// Create a copy of UnionKeyFallbackWithDefault
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnionKeyFallbackWithDefaultCopyWith<UnionKeyFallbackWithDefault>
      get copyWith => _$UnionKeyFallbackWithDefaultCopyWithImpl<
              UnionKeyFallbackWithDefault>(
          this as UnionKeyFallbackWithDefault, _$identity);

  /// Serializes this UnionKeyFallbackWithDefault to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnionKeyFallbackWithDefault &&
            (identical(other.key, key) || other.key == key));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, key);

  @override
  String toString() {
    return 'UnionKeyFallbackWithDefault(key: $key)';
  }
}

/// @nodoc
abstract mixin class $UnionKeyFallbackWithDefaultCopyWith<$Res> {
  factory $UnionKeyFallbackWithDefaultCopyWith(
          UnionKeyFallbackWithDefault value,
          $Res Function(UnionKeyFallbackWithDefault) _then) =
      _$UnionKeyFallbackWithDefaultCopyWithImpl;
  @useResult
  $Res call({String key});
}

/// @nodoc
class _$UnionKeyFallbackWithDefaultCopyWithImpl<$Res>
    implements $UnionKeyFallbackWithDefaultCopyWith<$Res> {
  _$UnionKeyFallbackWithDefaultCopyWithImpl(this._self, this._then);

  final UnionKeyFallbackWithDefault _self;
  final $Res Function(UnionKeyFallbackWithDefault) _then;

  /// Create a copy of UnionKeyFallbackWithDefault
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
  }) {
    return _then(_self.copyWith(
      key: null == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [UnionKeyFallbackWithDefault].
extension UnionKeyFallbackWithDefaultPatterns on UnionKeyFallbackWithDefault {
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
    TResult Function(_UnionKeyDefaultFallback value)? $default, {
    TResult Function(_UnionKeyDefaultFallbackFirst value)? first,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnionKeyDefaultFallback() when $default != null:
        return $default(_that);
      case _UnionKeyDefaultFallbackFirst() when first != null:
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
  TResult map<TResult extends Object?>(
    TResult Function(_UnionKeyDefaultFallback value) $default, {
    required TResult Function(_UnionKeyDefaultFallbackFirst value) first,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionKeyDefaultFallback():
        return $default(_that);
      case _UnionKeyDefaultFallbackFirst():
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
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_UnionKeyDefaultFallback value)? $default, {
    TResult? Function(_UnionKeyDefaultFallbackFirst value)? first,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionKeyDefaultFallback() when $default != null:
        return $default(_that);
      case _UnionKeyDefaultFallbackFirst() when first != null:
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String key)? $default, {
    TResult Function(String key)? first,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnionKeyDefaultFallback() when $default != null:
        return $default(_that.key);
      case _UnionKeyDefaultFallbackFirst() when first != null:
        return first(_that.key);
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
    TResult Function(String key) $default, {
    required TResult Function(String key) first,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionKeyDefaultFallback():
        return $default(_that.key);
      case _UnionKeyDefaultFallbackFirst():
        return first(_that.key);
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
    TResult? Function(String key)? $default, {
    TResult? Function(String key)? first,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionKeyDefaultFallback() when $default != null:
        return $default(_that.key);
      case _UnionKeyDefaultFallbackFirst() when first != null:
        return first(_that.key);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UnionKeyDefaultFallback implements UnionKeyFallbackWithDefault {
  const _UnionKeyDefaultFallback(this.key);
  factory _UnionKeyDefaultFallback.fromJson(Map<String, dynamic> json) =>
      _$UnionKeyDefaultFallbackFromJson(json);

  @override
  final String key;

  /// Create a copy of UnionKeyFallbackWithDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnionKeyDefaultFallbackCopyWith<_UnionKeyDefaultFallback> get copyWith =>
      __$UnionKeyDefaultFallbackCopyWithImpl<_UnionKeyDefaultFallback>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnionKeyDefaultFallbackToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnionKeyDefaultFallback &&
            (identical(other.key, key) || other.key == key));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, key);

  @override
  String toString() {
    return 'UnionKeyFallbackWithDefault(key: $key)';
  }
}

/// @nodoc
abstract mixin class _$UnionKeyDefaultFallbackCopyWith<$Res>
    implements $UnionKeyFallbackWithDefaultCopyWith<$Res> {
  factory _$UnionKeyDefaultFallbackCopyWith(_UnionKeyDefaultFallback value,
          $Res Function(_UnionKeyDefaultFallback) _then) =
      __$UnionKeyDefaultFallbackCopyWithImpl;
  @override
  @useResult
  $Res call({String key});
}

/// @nodoc
class __$UnionKeyDefaultFallbackCopyWithImpl<$Res>
    implements _$UnionKeyDefaultFallbackCopyWith<$Res> {
  __$UnionKeyDefaultFallbackCopyWithImpl(this._self, this._then);

  final _UnionKeyDefaultFallback _self;
  final $Res Function(_UnionKeyDefaultFallback) _then;

  /// Create a copy of UnionKeyFallbackWithDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? key = null,
  }) {
    return _then(_UnionKeyDefaultFallback(
      null == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UnionKeyDefaultFallbackFirst implements UnionKeyFallbackWithDefault {
  const _UnionKeyDefaultFallbackFirst(this.key);
  factory _UnionKeyDefaultFallbackFirst.fromJson(Map<String, dynamic> json) =>
      _$UnionKeyDefaultFallbackFirstFromJson(json);

  @override
  final String key;

  /// Create a copy of UnionKeyFallbackWithDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnionKeyDefaultFallbackFirstCopyWith<_UnionKeyDefaultFallbackFirst>
      get copyWith => __$UnionKeyDefaultFallbackFirstCopyWithImpl<
          _UnionKeyDefaultFallbackFirst>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnionKeyDefaultFallbackFirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnionKeyDefaultFallbackFirst &&
            (identical(other.key, key) || other.key == key));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, key);

  @override
  String toString() {
    return 'UnionKeyFallbackWithDefault.first(key: $key)';
  }
}

/// @nodoc
abstract mixin class _$UnionKeyDefaultFallbackFirstCopyWith<$Res>
    implements $UnionKeyFallbackWithDefaultCopyWith<$Res> {
  factory _$UnionKeyDefaultFallbackFirstCopyWith(
          _UnionKeyDefaultFallbackFirst value,
          $Res Function(_UnionKeyDefaultFallbackFirst) _then) =
      __$UnionKeyDefaultFallbackFirstCopyWithImpl;
  @override
  @useResult
  $Res call({String key});
}

/// @nodoc
class __$UnionKeyDefaultFallbackFirstCopyWithImpl<$Res>
    implements _$UnionKeyDefaultFallbackFirstCopyWith<$Res> {
  __$UnionKeyDefaultFallbackFirstCopyWithImpl(this._self, this._then);

  final _UnionKeyDefaultFallbackFirst _self;
  final $Res Function(_UnionKeyDefaultFallbackFirst) _then;

  /// Create a copy of UnionKeyFallbackWithDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? key = null,
  }) {
    return _then(_UnionKeyDefaultFallbackFirst(
      null == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

UnionValueCasePascal _$UnionValueCasePascalFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'First':
      return _UnionValueCasePascalFirst.fromJson(json);
    case 'SecondValue':
      return _UnionValueCasePascalSecondValue.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json,
          'runtimeType',
          'UnionValueCasePascal',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$UnionValueCasePascal {
  int get a;

  /// Create a copy of UnionValueCasePascal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnionValueCasePascalCopyWith<UnionValueCasePascal> get copyWith =>
      _$UnionValueCasePascalCopyWithImpl<UnionValueCasePascal>(
          this as UnionValueCasePascal, _$identity);

  /// Serializes this UnionValueCasePascal to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnionValueCasePascal &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnionValueCasePascal(a: $a)';
  }
}

/// @nodoc
abstract mixin class $UnionValueCasePascalCopyWith<$Res> {
  factory $UnionValueCasePascalCopyWith(UnionValueCasePascal value,
          $Res Function(UnionValueCasePascal) _then) =
      _$UnionValueCasePascalCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$UnionValueCasePascalCopyWithImpl<$Res>
    implements $UnionValueCasePascalCopyWith<$Res> {
  _$UnionValueCasePascalCopyWithImpl(this._self, this._then);

  final UnionValueCasePascal _self;
  final $Res Function(UnionValueCasePascal) _then;

  /// Create a copy of UnionValueCasePascal
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

/// Adds pattern-matching-related methods to [UnionValueCasePascal].
extension UnionValueCasePascalPatterns on UnionValueCasePascal {
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
    TResult Function(_UnionValueCasePascalFirst value)? first,
    TResult Function(_UnionValueCasePascalSecondValue value)? secondValue,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnionValueCasePascalFirst() when first != null:
        return first(_that);
      case _UnionValueCasePascalSecondValue() when secondValue != null:
        return secondValue(_that);
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
    required TResult Function(_UnionValueCasePascalFirst value) first,
    required TResult Function(_UnionValueCasePascalSecondValue value)
        secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionValueCasePascalFirst():
        return first(_that);
      case _UnionValueCasePascalSecondValue():
        return secondValue(_that);
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
    TResult? Function(_UnionValueCasePascalFirst value)? first,
    TResult? Function(_UnionValueCasePascalSecondValue value)? secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionValueCasePascalFirst() when first != null:
        return first(_that);
      case _UnionValueCasePascalSecondValue() when secondValue != null:
        return secondValue(_that);
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
    TResult Function(int a)? first,
    TResult Function(int a)? secondValue,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnionValueCasePascalFirst() when first != null:
        return first(_that.a);
      case _UnionValueCasePascalSecondValue() when secondValue != null:
        return secondValue(_that.a);
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
    required TResult Function(int a) first,
    required TResult Function(int a) secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionValueCasePascalFirst():
        return first(_that.a);
      case _UnionValueCasePascalSecondValue():
        return secondValue(_that.a);
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
    TResult? Function(int a)? first,
    TResult? Function(int a)? secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionValueCasePascalFirst() when first != null:
        return first(_that.a);
      case _UnionValueCasePascalSecondValue() when secondValue != null:
        return secondValue(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UnionValueCasePascalFirst implements UnionValueCasePascal {
  const _UnionValueCasePascalFirst(this.a, {final String? $type})
      : $type = $type ?? 'First';
  factory _UnionValueCasePascalFirst.fromJson(Map<String, dynamic> json) =>
      _$UnionValueCasePascalFirstFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnionValueCasePascal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnionValueCasePascalFirstCopyWith<_UnionValueCasePascalFirst>
      get copyWith =>
          __$UnionValueCasePascalFirstCopyWithImpl<_UnionValueCasePascalFirst>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnionValueCasePascalFirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnionValueCasePascalFirst &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnionValueCasePascal.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnionValueCasePascalFirstCopyWith<$Res>
    implements $UnionValueCasePascalCopyWith<$Res> {
  factory _$UnionValueCasePascalFirstCopyWith(_UnionValueCasePascalFirst value,
          $Res Function(_UnionValueCasePascalFirst) _then) =
      __$UnionValueCasePascalFirstCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnionValueCasePascalFirstCopyWithImpl<$Res>
    implements _$UnionValueCasePascalFirstCopyWith<$Res> {
  __$UnionValueCasePascalFirstCopyWithImpl(this._self, this._then);

  final _UnionValueCasePascalFirst _self;
  final $Res Function(_UnionValueCasePascalFirst) _then;

  /// Create a copy of UnionValueCasePascal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnionValueCasePascalFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UnionValueCasePascalSecondValue implements UnionValueCasePascal {
  const _UnionValueCasePascalSecondValue(this.a, {final String? $type})
      : $type = $type ?? 'SecondValue';
  factory _UnionValueCasePascalSecondValue.fromJson(
          Map<String, dynamic> json) =>
      _$UnionValueCasePascalSecondValueFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnionValueCasePascal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnionValueCasePascalSecondValueCopyWith<_UnionValueCasePascalSecondValue>
      get copyWith => __$UnionValueCasePascalSecondValueCopyWithImpl<
          _UnionValueCasePascalSecondValue>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnionValueCasePascalSecondValueToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnionValueCasePascalSecondValue &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnionValueCasePascal.secondValue(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnionValueCasePascalSecondValueCopyWith<$Res>
    implements $UnionValueCasePascalCopyWith<$Res> {
  factory _$UnionValueCasePascalSecondValueCopyWith(
          _UnionValueCasePascalSecondValue value,
          $Res Function(_UnionValueCasePascalSecondValue) _then) =
      __$UnionValueCasePascalSecondValueCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnionValueCasePascalSecondValueCopyWithImpl<$Res>
    implements _$UnionValueCasePascalSecondValueCopyWith<$Res> {
  __$UnionValueCasePascalSecondValueCopyWithImpl(this._self, this._then);

  final _UnionValueCasePascalSecondValue _self;
  final $Res Function(_UnionValueCasePascalSecondValue) _then;

  /// Create a copy of UnionValueCasePascal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnionValueCasePascalSecondValue(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

UnionValueCaseKebab _$UnionValueCaseKebabFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'first':
      return _UnionValueCaseKebabFirst.fromJson(json);
    case 'second-value':
      return _UnionValueCaseKebabSecondValue.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'UnionValueCaseKebab',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$UnionValueCaseKebab {
  int get a;

  /// Create a copy of UnionValueCaseKebab
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnionValueCaseKebabCopyWith<UnionValueCaseKebab> get copyWith =>
      _$UnionValueCaseKebabCopyWithImpl<UnionValueCaseKebab>(
          this as UnionValueCaseKebab, _$identity);

  /// Serializes this UnionValueCaseKebab to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnionValueCaseKebab &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnionValueCaseKebab(a: $a)';
  }
}

/// @nodoc
abstract mixin class $UnionValueCaseKebabCopyWith<$Res> {
  factory $UnionValueCaseKebabCopyWith(
          UnionValueCaseKebab value, $Res Function(UnionValueCaseKebab) _then) =
      _$UnionValueCaseKebabCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$UnionValueCaseKebabCopyWithImpl<$Res>
    implements $UnionValueCaseKebabCopyWith<$Res> {
  _$UnionValueCaseKebabCopyWithImpl(this._self, this._then);

  final UnionValueCaseKebab _self;
  final $Res Function(UnionValueCaseKebab) _then;

  /// Create a copy of UnionValueCaseKebab
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

/// Adds pattern-matching-related methods to [UnionValueCaseKebab].
extension UnionValueCaseKebabPatterns on UnionValueCaseKebab {
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
    TResult Function(_UnionValueCaseKebabFirst value)? first,
    TResult Function(_UnionValueCaseKebabSecondValue value)? secondValue,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnionValueCaseKebabFirst() when first != null:
        return first(_that);
      case _UnionValueCaseKebabSecondValue() when secondValue != null:
        return secondValue(_that);
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
    required TResult Function(_UnionValueCaseKebabFirst value) first,
    required TResult Function(_UnionValueCaseKebabSecondValue value)
        secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionValueCaseKebabFirst():
        return first(_that);
      case _UnionValueCaseKebabSecondValue():
        return secondValue(_that);
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
    TResult? Function(_UnionValueCaseKebabFirst value)? first,
    TResult? Function(_UnionValueCaseKebabSecondValue value)? secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionValueCaseKebabFirst() when first != null:
        return first(_that);
      case _UnionValueCaseKebabSecondValue() when secondValue != null:
        return secondValue(_that);
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
    TResult Function(int a)? first,
    TResult Function(int a)? secondValue,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnionValueCaseKebabFirst() when first != null:
        return first(_that.a);
      case _UnionValueCaseKebabSecondValue() when secondValue != null:
        return secondValue(_that.a);
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
    required TResult Function(int a) first,
    required TResult Function(int a) secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionValueCaseKebabFirst():
        return first(_that.a);
      case _UnionValueCaseKebabSecondValue():
        return secondValue(_that.a);
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
    TResult? Function(int a)? first,
    TResult? Function(int a)? secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionValueCaseKebabFirst() when first != null:
        return first(_that.a);
      case _UnionValueCaseKebabSecondValue() when secondValue != null:
        return secondValue(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UnionValueCaseKebabFirst implements UnionValueCaseKebab {
  const _UnionValueCaseKebabFirst(this.a, {final String? $type})
      : $type = $type ?? 'first';
  factory _UnionValueCaseKebabFirst.fromJson(Map<String, dynamic> json) =>
      _$UnionValueCaseKebabFirstFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnionValueCaseKebab
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnionValueCaseKebabFirstCopyWith<_UnionValueCaseKebabFirst> get copyWith =>
      __$UnionValueCaseKebabFirstCopyWithImpl<_UnionValueCaseKebabFirst>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnionValueCaseKebabFirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnionValueCaseKebabFirst &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnionValueCaseKebab.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnionValueCaseKebabFirstCopyWith<$Res>
    implements $UnionValueCaseKebabCopyWith<$Res> {
  factory _$UnionValueCaseKebabFirstCopyWith(_UnionValueCaseKebabFirst value,
          $Res Function(_UnionValueCaseKebabFirst) _then) =
      __$UnionValueCaseKebabFirstCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnionValueCaseKebabFirstCopyWithImpl<$Res>
    implements _$UnionValueCaseKebabFirstCopyWith<$Res> {
  __$UnionValueCaseKebabFirstCopyWithImpl(this._self, this._then);

  final _UnionValueCaseKebabFirst _self;
  final $Res Function(_UnionValueCaseKebabFirst) _then;

  /// Create a copy of UnionValueCaseKebab
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnionValueCaseKebabFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UnionValueCaseKebabSecondValue implements UnionValueCaseKebab {
  const _UnionValueCaseKebabSecondValue(this.a, {final String? $type})
      : $type = $type ?? 'second-value';
  factory _UnionValueCaseKebabSecondValue.fromJson(Map<String, dynamic> json) =>
      _$UnionValueCaseKebabSecondValueFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnionValueCaseKebab
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnionValueCaseKebabSecondValueCopyWith<_UnionValueCaseKebabSecondValue>
      get copyWith => __$UnionValueCaseKebabSecondValueCopyWithImpl<
          _UnionValueCaseKebabSecondValue>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnionValueCaseKebabSecondValueToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnionValueCaseKebabSecondValue &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnionValueCaseKebab.secondValue(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnionValueCaseKebabSecondValueCopyWith<$Res>
    implements $UnionValueCaseKebabCopyWith<$Res> {
  factory _$UnionValueCaseKebabSecondValueCopyWith(
          _UnionValueCaseKebabSecondValue value,
          $Res Function(_UnionValueCaseKebabSecondValue) _then) =
      __$UnionValueCaseKebabSecondValueCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnionValueCaseKebabSecondValueCopyWithImpl<$Res>
    implements _$UnionValueCaseKebabSecondValueCopyWith<$Res> {
  __$UnionValueCaseKebabSecondValueCopyWithImpl(this._self, this._then);

  final _UnionValueCaseKebabSecondValue _self;
  final $Res Function(_UnionValueCaseKebabSecondValue) _then;

  /// Create a copy of UnionValueCaseKebab
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnionValueCaseKebabSecondValue(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

UnionValueCaseSnake _$UnionValueCaseSnakeFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'first':
      return _UnionValueCaseSnakeFirst.fromJson(json);
    case 'second_value':
      return _UnionValueCaseSnakeSecondValue.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'UnionValueCaseSnake',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$UnionValueCaseSnake {
  int get a;

  /// Create a copy of UnionValueCaseSnake
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnionValueCaseSnakeCopyWith<UnionValueCaseSnake> get copyWith =>
      _$UnionValueCaseSnakeCopyWithImpl<UnionValueCaseSnake>(
          this as UnionValueCaseSnake, _$identity);

  /// Serializes this UnionValueCaseSnake to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnionValueCaseSnake &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnionValueCaseSnake(a: $a)';
  }
}

/// @nodoc
abstract mixin class $UnionValueCaseSnakeCopyWith<$Res> {
  factory $UnionValueCaseSnakeCopyWith(
          UnionValueCaseSnake value, $Res Function(UnionValueCaseSnake) _then) =
      _$UnionValueCaseSnakeCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$UnionValueCaseSnakeCopyWithImpl<$Res>
    implements $UnionValueCaseSnakeCopyWith<$Res> {
  _$UnionValueCaseSnakeCopyWithImpl(this._self, this._then);

  final UnionValueCaseSnake _self;
  final $Res Function(UnionValueCaseSnake) _then;

  /// Create a copy of UnionValueCaseSnake
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

/// Adds pattern-matching-related methods to [UnionValueCaseSnake].
extension UnionValueCaseSnakePatterns on UnionValueCaseSnake {
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
    TResult Function(_UnionValueCaseSnakeFirst value)? first,
    TResult Function(_UnionValueCaseSnakeSecondValue value)? secondValue,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnionValueCaseSnakeFirst() when first != null:
        return first(_that);
      case _UnionValueCaseSnakeSecondValue() when secondValue != null:
        return secondValue(_that);
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
    required TResult Function(_UnionValueCaseSnakeFirst value) first,
    required TResult Function(_UnionValueCaseSnakeSecondValue value)
        secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionValueCaseSnakeFirst():
        return first(_that);
      case _UnionValueCaseSnakeSecondValue():
        return secondValue(_that);
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
    TResult? Function(_UnionValueCaseSnakeFirst value)? first,
    TResult? Function(_UnionValueCaseSnakeSecondValue value)? secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionValueCaseSnakeFirst() when first != null:
        return first(_that);
      case _UnionValueCaseSnakeSecondValue() when secondValue != null:
        return secondValue(_that);
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
    TResult Function(int a)? first,
    TResult Function(int a)? secondValue,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnionValueCaseSnakeFirst() when first != null:
        return first(_that.a);
      case _UnionValueCaseSnakeSecondValue() when secondValue != null:
        return secondValue(_that.a);
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
    required TResult Function(int a) first,
    required TResult Function(int a) secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionValueCaseSnakeFirst():
        return first(_that.a);
      case _UnionValueCaseSnakeSecondValue():
        return secondValue(_that.a);
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
    TResult? Function(int a)? first,
    TResult? Function(int a)? secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionValueCaseSnakeFirst() when first != null:
        return first(_that.a);
      case _UnionValueCaseSnakeSecondValue() when secondValue != null:
        return secondValue(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UnionValueCaseSnakeFirst implements UnionValueCaseSnake {
  const _UnionValueCaseSnakeFirst(this.a, {final String? $type})
      : $type = $type ?? 'first';
  factory _UnionValueCaseSnakeFirst.fromJson(Map<String, dynamic> json) =>
      _$UnionValueCaseSnakeFirstFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnionValueCaseSnake
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnionValueCaseSnakeFirstCopyWith<_UnionValueCaseSnakeFirst> get copyWith =>
      __$UnionValueCaseSnakeFirstCopyWithImpl<_UnionValueCaseSnakeFirst>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnionValueCaseSnakeFirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnionValueCaseSnakeFirst &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnionValueCaseSnake.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnionValueCaseSnakeFirstCopyWith<$Res>
    implements $UnionValueCaseSnakeCopyWith<$Res> {
  factory _$UnionValueCaseSnakeFirstCopyWith(_UnionValueCaseSnakeFirst value,
          $Res Function(_UnionValueCaseSnakeFirst) _then) =
      __$UnionValueCaseSnakeFirstCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnionValueCaseSnakeFirstCopyWithImpl<$Res>
    implements _$UnionValueCaseSnakeFirstCopyWith<$Res> {
  __$UnionValueCaseSnakeFirstCopyWithImpl(this._self, this._then);

  final _UnionValueCaseSnakeFirst _self;
  final $Res Function(_UnionValueCaseSnakeFirst) _then;

  /// Create a copy of UnionValueCaseSnake
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnionValueCaseSnakeFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UnionValueCaseSnakeSecondValue implements UnionValueCaseSnake {
  const _UnionValueCaseSnakeSecondValue(this.a, {final String? $type})
      : $type = $type ?? 'second_value';
  factory _UnionValueCaseSnakeSecondValue.fromJson(Map<String, dynamic> json) =>
      _$UnionValueCaseSnakeSecondValueFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnionValueCaseSnake
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnionValueCaseSnakeSecondValueCopyWith<_UnionValueCaseSnakeSecondValue>
      get copyWith => __$UnionValueCaseSnakeSecondValueCopyWithImpl<
          _UnionValueCaseSnakeSecondValue>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnionValueCaseSnakeSecondValueToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnionValueCaseSnakeSecondValue &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnionValueCaseSnake.secondValue(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnionValueCaseSnakeSecondValueCopyWith<$Res>
    implements $UnionValueCaseSnakeCopyWith<$Res> {
  factory _$UnionValueCaseSnakeSecondValueCopyWith(
          _UnionValueCaseSnakeSecondValue value,
          $Res Function(_UnionValueCaseSnakeSecondValue) _then) =
      __$UnionValueCaseSnakeSecondValueCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnionValueCaseSnakeSecondValueCopyWithImpl<$Res>
    implements _$UnionValueCaseSnakeSecondValueCopyWith<$Res> {
  __$UnionValueCaseSnakeSecondValueCopyWithImpl(this._self, this._then);

  final _UnionValueCaseSnakeSecondValue _self;
  final $Res Function(_UnionValueCaseSnakeSecondValue) _then;

  /// Create a copy of UnionValueCaseSnake
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnionValueCaseSnakeSecondValue(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

UnionValueCaseScreamingSnake _$UnionValueCaseScreamingSnakeFromJson(
    Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'FIRST':
      return _UnionValueCaseScreamingSnakeFirst.fromJson(json);
    case 'SECOND_VALUE':
      return _UnionValueCaseScreamingSnakeSecondValue.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json,
          'runtimeType',
          'UnionValueCaseScreamingSnake',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$UnionValueCaseScreamingSnake {
  int get a;

  /// Create a copy of UnionValueCaseScreamingSnake
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnionValueCaseScreamingSnakeCopyWith<UnionValueCaseScreamingSnake>
      get copyWith => _$UnionValueCaseScreamingSnakeCopyWithImpl<
              UnionValueCaseScreamingSnake>(
          this as UnionValueCaseScreamingSnake, _$identity);

  /// Serializes this UnionValueCaseScreamingSnake to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnionValueCaseScreamingSnake &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnionValueCaseScreamingSnake(a: $a)';
  }
}

/// @nodoc
abstract mixin class $UnionValueCaseScreamingSnakeCopyWith<$Res> {
  factory $UnionValueCaseScreamingSnakeCopyWith(
          UnionValueCaseScreamingSnake value,
          $Res Function(UnionValueCaseScreamingSnake) _then) =
      _$UnionValueCaseScreamingSnakeCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$UnionValueCaseScreamingSnakeCopyWithImpl<$Res>
    implements $UnionValueCaseScreamingSnakeCopyWith<$Res> {
  _$UnionValueCaseScreamingSnakeCopyWithImpl(this._self, this._then);

  final UnionValueCaseScreamingSnake _self;
  final $Res Function(UnionValueCaseScreamingSnake) _then;

  /// Create a copy of UnionValueCaseScreamingSnake
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

/// Adds pattern-matching-related methods to [UnionValueCaseScreamingSnake].
extension UnionValueCaseScreamingSnakePatterns on UnionValueCaseScreamingSnake {
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
    TResult Function(_UnionValueCaseScreamingSnakeFirst value)? first,
    TResult Function(_UnionValueCaseScreamingSnakeSecondValue value)?
        secondValue,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnionValueCaseScreamingSnakeFirst() when first != null:
        return first(_that);
      case _UnionValueCaseScreamingSnakeSecondValue() when secondValue != null:
        return secondValue(_that);
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
    required TResult Function(_UnionValueCaseScreamingSnakeFirst value) first,
    required TResult Function(_UnionValueCaseScreamingSnakeSecondValue value)
        secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionValueCaseScreamingSnakeFirst():
        return first(_that);
      case _UnionValueCaseScreamingSnakeSecondValue():
        return secondValue(_that);
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
    TResult? Function(_UnionValueCaseScreamingSnakeFirst value)? first,
    TResult? Function(_UnionValueCaseScreamingSnakeSecondValue value)?
        secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionValueCaseScreamingSnakeFirst() when first != null:
        return first(_that);
      case _UnionValueCaseScreamingSnakeSecondValue() when secondValue != null:
        return secondValue(_that);
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
    TResult Function(int a)? first,
    TResult Function(int a)? secondValue,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnionValueCaseScreamingSnakeFirst() when first != null:
        return first(_that.a);
      case _UnionValueCaseScreamingSnakeSecondValue() when secondValue != null:
        return secondValue(_that.a);
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
    required TResult Function(int a) first,
    required TResult Function(int a) secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionValueCaseScreamingSnakeFirst():
        return first(_that.a);
      case _UnionValueCaseScreamingSnakeSecondValue():
        return secondValue(_that.a);
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
    TResult? Function(int a)? first,
    TResult? Function(int a)? secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionValueCaseScreamingSnakeFirst() when first != null:
        return first(_that.a);
      case _UnionValueCaseScreamingSnakeSecondValue() when secondValue != null:
        return secondValue(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UnionValueCaseScreamingSnakeFirst
    implements UnionValueCaseScreamingSnake {
  const _UnionValueCaseScreamingSnakeFirst(this.a, {final String? $type})
      : $type = $type ?? 'FIRST';
  factory _UnionValueCaseScreamingSnakeFirst.fromJson(
          Map<String, dynamic> json) =>
      _$UnionValueCaseScreamingSnakeFirstFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnionValueCaseScreamingSnake
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnionValueCaseScreamingSnakeFirstCopyWith<
          _UnionValueCaseScreamingSnakeFirst>
      get copyWith => __$UnionValueCaseScreamingSnakeFirstCopyWithImpl<
          _UnionValueCaseScreamingSnakeFirst>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnionValueCaseScreamingSnakeFirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnionValueCaseScreamingSnakeFirst &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnionValueCaseScreamingSnake.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnionValueCaseScreamingSnakeFirstCopyWith<$Res>
    implements $UnionValueCaseScreamingSnakeCopyWith<$Res> {
  factory _$UnionValueCaseScreamingSnakeFirstCopyWith(
          _UnionValueCaseScreamingSnakeFirst value,
          $Res Function(_UnionValueCaseScreamingSnakeFirst) _then) =
      __$UnionValueCaseScreamingSnakeFirstCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnionValueCaseScreamingSnakeFirstCopyWithImpl<$Res>
    implements _$UnionValueCaseScreamingSnakeFirstCopyWith<$Res> {
  __$UnionValueCaseScreamingSnakeFirstCopyWithImpl(this._self, this._then);

  final _UnionValueCaseScreamingSnakeFirst _self;
  final $Res Function(_UnionValueCaseScreamingSnakeFirst) _then;

  /// Create a copy of UnionValueCaseScreamingSnake
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnionValueCaseScreamingSnakeFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UnionValueCaseScreamingSnakeSecondValue
    implements UnionValueCaseScreamingSnake {
  const _UnionValueCaseScreamingSnakeSecondValue(this.a, {final String? $type})
      : $type = $type ?? 'SECOND_VALUE';
  factory _UnionValueCaseScreamingSnakeSecondValue.fromJson(
          Map<String, dynamic> json) =>
      _$UnionValueCaseScreamingSnakeSecondValueFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnionValueCaseScreamingSnake
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnionValueCaseScreamingSnakeSecondValueCopyWith<
          _UnionValueCaseScreamingSnakeSecondValue>
      get copyWith => __$UnionValueCaseScreamingSnakeSecondValueCopyWithImpl<
          _UnionValueCaseScreamingSnakeSecondValue>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnionValueCaseScreamingSnakeSecondValueToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnionValueCaseScreamingSnakeSecondValue &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnionValueCaseScreamingSnake.secondValue(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnionValueCaseScreamingSnakeSecondValueCopyWith<$Res>
    implements $UnionValueCaseScreamingSnakeCopyWith<$Res> {
  factory _$UnionValueCaseScreamingSnakeSecondValueCopyWith(
          _UnionValueCaseScreamingSnakeSecondValue value,
          $Res Function(_UnionValueCaseScreamingSnakeSecondValue) _then) =
      __$UnionValueCaseScreamingSnakeSecondValueCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnionValueCaseScreamingSnakeSecondValueCopyWithImpl<$Res>
    implements _$UnionValueCaseScreamingSnakeSecondValueCopyWith<$Res> {
  __$UnionValueCaseScreamingSnakeSecondValueCopyWithImpl(
      this._self, this._then);

  final _UnionValueCaseScreamingSnakeSecondValue _self;
  final $Res Function(_UnionValueCaseScreamingSnakeSecondValue) _then;

  /// Create a copy of UnionValueCaseScreamingSnake
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnionValueCaseScreamingSnakeSecondValue(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

RuntimeTypeKey _$RuntimeTypeKeyFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'first':
      return _RuntimeTypeKeyFirst.fromJson(json);
    case 'second':
      return _RuntimeTypeKeySecond.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'RuntimeTypeKey',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$RuntimeTypeKey {
  int get a;

  /// Create a copy of RuntimeTypeKey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RuntimeTypeKeyCopyWith<RuntimeTypeKey> get copyWith =>
      _$RuntimeTypeKeyCopyWithImpl<RuntimeTypeKey>(
          this as RuntimeTypeKey, _$identity);

  /// Serializes this RuntimeTypeKey to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RuntimeTypeKey &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'RuntimeTypeKey(a: $a)';
  }
}

/// @nodoc
abstract mixin class $RuntimeTypeKeyCopyWith<$Res> {
  factory $RuntimeTypeKeyCopyWith(
          RuntimeTypeKey value, $Res Function(RuntimeTypeKey) _then) =
      _$RuntimeTypeKeyCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$RuntimeTypeKeyCopyWithImpl<$Res>
    implements $RuntimeTypeKeyCopyWith<$Res> {
  _$RuntimeTypeKeyCopyWithImpl(this._self, this._then);

  final RuntimeTypeKey _self;
  final $Res Function(RuntimeTypeKey) _then;

  /// Create a copy of RuntimeTypeKey
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

/// Adds pattern-matching-related methods to [RuntimeTypeKey].
extension RuntimeTypeKeyPatterns on RuntimeTypeKey {
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
    TResult Function(_RuntimeTypeKeyFirst value)? first,
    TResult Function(_RuntimeTypeKeySecond value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RuntimeTypeKeyFirst() when first != null:
        return first(_that);
      case _RuntimeTypeKeySecond() when second != null:
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
  TResult map<TResult extends Object?>({
    required TResult Function(_RuntimeTypeKeyFirst value) first,
    required TResult Function(_RuntimeTypeKeySecond value) second,
  }) {
    final _that = this;
    switch (_that) {
      case _RuntimeTypeKeyFirst():
        return first(_that);
      case _RuntimeTypeKeySecond():
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RuntimeTypeKeyFirst value)? first,
    TResult? Function(_RuntimeTypeKeySecond value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _RuntimeTypeKeyFirst() when first != null:
        return first(_that);
      case _RuntimeTypeKeySecond() when second != null:
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int a)? first,
    TResult Function(int a)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RuntimeTypeKeyFirst() when first != null:
        return first(_that.a);
      case _RuntimeTypeKeySecond() when second != null:
        return second(_that.a);
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
    required TResult Function(int a) first,
    required TResult Function(int a) second,
  }) {
    final _that = this;
    switch (_that) {
      case _RuntimeTypeKeyFirst():
        return first(_that.a);
      case _RuntimeTypeKeySecond():
        return second(_that.a);
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
    TResult? Function(int a)? first,
    TResult? Function(int a)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _RuntimeTypeKeyFirst() when first != null:
        return first(_that.a);
      case _RuntimeTypeKeySecond() when second != null:
        return second(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RuntimeTypeKeyFirst implements RuntimeTypeKey {
  const _RuntimeTypeKeyFirst(this.a, {final String? $type})
      : $type = $type ?? 'first';
  factory _RuntimeTypeKeyFirst.fromJson(Map<String, dynamic> json) =>
      _$RuntimeTypeKeyFirstFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of RuntimeTypeKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RuntimeTypeKeyFirstCopyWith<_RuntimeTypeKeyFirst> get copyWith =>
      __$RuntimeTypeKeyFirstCopyWithImpl<_RuntimeTypeKeyFirst>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RuntimeTypeKeyFirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RuntimeTypeKeyFirst &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'RuntimeTypeKey.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$RuntimeTypeKeyFirstCopyWith<$Res>
    implements $RuntimeTypeKeyCopyWith<$Res> {
  factory _$RuntimeTypeKeyFirstCopyWith(_RuntimeTypeKeyFirst value,
          $Res Function(_RuntimeTypeKeyFirst) _then) =
      __$RuntimeTypeKeyFirstCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$RuntimeTypeKeyFirstCopyWithImpl<$Res>
    implements _$RuntimeTypeKeyFirstCopyWith<$Res> {
  __$RuntimeTypeKeyFirstCopyWithImpl(this._self, this._then);

  final _RuntimeTypeKeyFirst _self;
  final $Res Function(_RuntimeTypeKeyFirst) _then;

  /// Create a copy of RuntimeTypeKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_RuntimeTypeKeyFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _RuntimeTypeKeySecond implements RuntimeTypeKey {
  const _RuntimeTypeKeySecond(this.a, {final String? $type})
      : $type = $type ?? 'second';
  factory _RuntimeTypeKeySecond.fromJson(Map<String, dynamic> json) =>
      _$RuntimeTypeKeySecondFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of RuntimeTypeKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RuntimeTypeKeySecondCopyWith<_RuntimeTypeKeySecond> get copyWith =>
      __$RuntimeTypeKeySecondCopyWithImpl<_RuntimeTypeKeySecond>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RuntimeTypeKeySecondToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RuntimeTypeKeySecond &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'RuntimeTypeKey.second(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$RuntimeTypeKeySecondCopyWith<$Res>
    implements $RuntimeTypeKeyCopyWith<$Res> {
  factory _$RuntimeTypeKeySecondCopyWith(_RuntimeTypeKeySecond value,
          $Res Function(_RuntimeTypeKeySecond) _then) =
      __$RuntimeTypeKeySecondCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$RuntimeTypeKeySecondCopyWithImpl<$Res>
    implements _$RuntimeTypeKeySecondCopyWith<$Res> {
  __$RuntimeTypeKeySecondCopyWithImpl(this._self, this._then);

  final _RuntimeTypeKeySecond _self;
  final $Res Function(_RuntimeTypeKeySecond) _then;

  /// Create a copy of RuntimeTypeKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_RuntimeTypeKeySecond(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

RawRuntimeTypeKey _$RawRuntimeTypeKeyFromJson(Map<String, dynamic> json) {
  switch (json['\$runtimeType']) {
    case 'first':
      return _RawRuntimeTypeKeyFirst.fromJson(json);
    case 'second':
      return _RawRuntimeTypeKeySecond.fromJson(json);

    default:
      throw CheckedFromJsonException(json, '\$runtimeType', 'RawRuntimeTypeKey',
          'Invalid union type "${json['\$runtimeType']}"!');
  }
}

/// @nodoc
mixin _$RawRuntimeTypeKey {
  int get a;

  /// Create a copy of RawRuntimeTypeKey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RawRuntimeTypeKeyCopyWith<RawRuntimeTypeKey> get copyWith =>
      _$RawRuntimeTypeKeyCopyWithImpl<RawRuntimeTypeKey>(
          this as RawRuntimeTypeKey, _$identity);

  /// Serializes this RawRuntimeTypeKey to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RawRuntimeTypeKey &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'RawRuntimeTypeKey(a: $a)';
  }
}

/// @nodoc
abstract mixin class $RawRuntimeTypeKeyCopyWith<$Res> {
  factory $RawRuntimeTypeKeyCopyWith(
          RawRuntimeTypeKey value, $Res Function(RawRuntimeTypeKey) _then) =
      _$RawRuntimeTypeKeyCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$RawRuntimeTypeKeyCopyWithImpl<$Res>
    implements $RawRuntimeTypeKeyCopyWith<$Res> {
  _$RawRuntimeTypeKeyCopyWithImpl(this._self, this._then);

  final RawRuntimeTypeKey _self;
  final $Res Function(RawRuntimeTypeKey) _then;

  /// Create a copy of RawRuntimeTypeKey
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

/// Adds pattern-matching-related methods to [RawRuntimeTypeKey].
extension RawRuntimeTypeKeyPatterns on RawRuntimeTypeKey {
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
    TResult Function(_RawRuntimeTypeKeyFirst value)? first,
    TResult Function(_RawRuntimeTypeKeySecond value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RawRuntimeTypeKeyFirst() when first != null:
        return first(_that);
      case _RawRuntimeTypeKeySecond() when second != null:
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
  TResult map<TResult extends Object?>({
    required TResult Function(_RawRuntimeTypeKeyFirst value) first,
    required TResult Function(_RawRuntimeTypeKeySecond value) second,
  }) {
    final _that = this;
    switch (_that) {
      case _RawRuntimeTypeKeyFirst():
        return first(_that);
      case _RawRuntimeTypeKeySecond():
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RawRuntimeTypeKeyFirst value)? first,
    TResult? Function(_RawRuntimeTypeKeySecond value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _RawRuntimeTypeKeyFirst() when first != null:
        return first(_that);
      case _RawRuntimeTypeKeySecond() when second != null:
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int a)? first,
    TResult Function(int a)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RawRuntimeTypeKeyFirst() when first != null:
        return first(_that.a);
      case _RawRuntimeTypeKeySecond() when second != null:
        return second(_that.a);
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
    required TResult Function(int a) first,
    required TResult Function(int a) second,
  }) {
    final _that = this;
    switch (_that) {
      case _RawRuntimeTypeKeyFirst():
        return first(_that.a);
      case _RawRuntimeTypeKeySecond():
        return second(_that.a);
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
    TResult? Function(int a)? first,
    TResult? Function(int a)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _RawRuntimeTypeKeyFirst() when first != null:
        return first(_that.a);
      case _RawRuntimeTypeKeySecond() when second != null:
        return second(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RawRuntimeTypeKeyFirst implements RawRuntimeTypeKey {
  const _RawRuntimeTypeKeyFirst(this.a, {final String? $type})
      : $type = $type ?? 'first';
  factory _RawRuntimeTypeKeyFirst.fromJson(Map<String, dynamic> json) =>
      _$RawRuntimeTypeKeyFirstFromJson(json);

  @override
  final int a;

  @JsonKey(name: '\$runtimeType')
  final String $type;

  /// Create a copy of RawRuntimeTypeKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RawRuntimeTypeKeyFirstCopyWith<_RawRuntimeTypeKeyFirst> get copyWith =>
      __$RawRuntimeTypeKeyFirstCopyWithImpl<_RawRuntimeTypeKeyFirst>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RawRuntimeTypeKeyFirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RawRuntimeTypeKeyFirst &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'RawRuntimeTypeKey.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$RawRuntimeTypeKeyFirstCopyWith<$Res>
    implements $RawRuntimeTypeKeyCopyWith<$Res> {
  factory _$RawRuntimeTypeKeyFirstCopyWith(_RawRuntimeTypeKeyFirst value,
          $Res Function(_RawRuntimeTypeKeyFirst) _then) =
      __$RawRuntimeTypeKeyFirstCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$RawRuntimeTypeKeyFirstCopyWithImpl<$Res>
    implements _$RawRuntimeTypeKeyFirstCopyWith<$Res> {
  __$RawRuntimeTypeKeyFirstCopyWithImpl(this._self, this._then);

  final _RawRuntimeTypeKeyFirst _self;
  final $Res Function(_RawRuntimeTypeKeyFirst) _then;

  /// Create a copy of RawRuntimeTypeKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_RawRuntimeTypeKeyFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _RawRuntimeTypeKeySecond implements RawRuntimeTypeKey {
  const _RawRuntimeTypeKeySecond(this.a, {final String? $type})
      : $type = $type ?? 'second';
  factory _RawRuntimeTypeKeySecond.fromJson(Map<String, dynamic> json) =>
      _$RawRuntimeTypeKeySecondFromJson(json);

  @override
  final int a;

  @JsonKey(name: '\$runtimeType')
  final String $type;

  /// Create a copy of RawRuntimeTypeKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RawRuntimeTypeKeySecondCopyWith<_RawRuntimeTypeKeySecond> get copyWith =>
      __$RawRuntimeTypeKeySecondCopyWithImpl<_RawRuntimeTypeKeySecond>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RawRuntimeTypeKeySecondToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RawRuntimeTypeKeySecond &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'RawRuntimeTypeKey.second(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$RawRuntimeTypeKeySecondCopyWith<$Res>
    implements $RawRuntimeTypeKeyCopyWith<$Res> {
  factory _$RawRuntimeTypeKeySecondCopyWith(_RawRuntimeTypeKeySecond value,
          $Res Function(_RawRuntimeTypeKeySecond) _then) =
      __$RawRuntimeTypeKeySecondCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$RawRuntimeTypeKeySecondCopyWithImpl<$Res>
    implements _$RawRuntimeTypeKeySecondCopyWith<$Res> {
  __$RawRuntimeTypeKeySecondCopyWithImpl(this._self, this._then);

  final _RawRuntimeTypeKeySecond _self;
  final $Res Function(_RawRuntimeTypeKeySecond) _then;

  /// Create a copy of RawRuntimeTypeKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_RawRuntimeTypeKeySecond(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

FancyRuntimeTypeKey _$FancyRuntimeTypeKeyFromJson(Map<String, dynamic> json) {
  switch (json['run"\'timeType']) {
    case 'first':
      return _FancyRuntimeTypeKeyFirst.fromJson(json);
    case 'second':
      return _FancyRuntimeTypeKeySecond.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json,
          'run"\'timeType',
          'FancyRuntimeTypeKey',
          'Invalid union type "${json['run"\'timeType']}"!');
  }
}

/// @nodoc
mixin _$FancyRuntimeTypeKey {
  int get a;

  /// Create a copy of FancyRuntimeTypeKey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FancyRuntimeTypeKeyCopyWith<FancyRuntimeTypeKey> get copyWith =>
      _$FancyRuntimeTypeKeyCopyWithImpl<FancyRuntimeTypeKey>(
          this as FancyRuntimeTypeKey, _$identity);

  /// Serializes this FancyRuntimeTypeKey to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FancyRuntimeTypeKey &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'FancyRuntimeTypeKey(a: $a)';
  }
}

/// @nodoc
abstract mixin class $FancyRuntimeTypeKeyCopyWith<$Res> {
  factory $FancyRuntimeTypeKeyCopyWith(
          FancyRuntimeTypeKey value, $Res Function(FancyRuntimeTypeKey) _then) =
      _$FancyRuntimeTypeKeyCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$FancyRuntimeTypeKeyCopyWithImpl<$Res>
    implements $FancyRuntimeTypeKeyCopyWith<$Res> {
  _$FancyRuntimeTypeKeyCopyWithImpl(this._self, this._then);

  final FancyRuntimeTypeKey _self;
  final $Res Function(FancyRuntimeTypeKey) _then;

  /// Create a copy of FancyRuntimeTypeKey
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

/// Adds pattern-matching-related methods to [FancyRuntimeTypeKey].
extension FancyRuntimeTypeKeyPatterns on FancyRuntimeTypeKey {
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
    TResult Function(_FancyRuntimeTypeKeyFirst value)? first,
    TResult Function(_FancyRuntimeTypeKeySecond value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FancyRuntimeTypeKeyFirst() when first != null:
        return first(_that);
      case _FancyRuntimeTypeKeySecond() when second != null:
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
  TResult map<TResult extends Object?>({
    required TResult Function(_FancyRuntimeTypeKeyFirst value) first,
    required TResult Function(_FancyRuntimeTypeKeySecond value) second,
  }) {
    final _that = this;
    switch (_that) {
      case _FancyRuntimeTypeKeyFirst():
        return first(_that);
      case _FancyRuntimeTypeKeySecond():
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FancyRuntimeTypeKeyFirst value)? first,
    TResult? Function(_FancyRuntimeTypeKeySecond value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _FancyRuntimeTypeKeyFirst() when first != null:
        return first(_that);
      case _FancyRuntimeTypeKeySecond() when second != null:
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int a)? first,
    TResult Function(int a)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FancyRuntimeTypeKeyFirst() when first != null:
        return first(_that.a);
      case _FancyRuntimeTypeKeySecond() when second != null:
        return second(_that.a);
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
    required TResult Function(int a) first,
    required TResult Function(int a) second,
  }) {
    final _that = this;
    switch (_that) {
      case _FancyRuntimeTypeKeyFirst():
        return first(_that.a);
      case _FancyRuntimeTypeKeySecond():
        return second(_that.a);
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
    TResult? Function(int a)? first,
    TResult? Function(int a)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _FancyRuntimeTypeKeyFirst() when first != null:
        return first(_that.a);
      case _FancyRuntimeTypeKeySecond() when second != null:
        return second(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _FancyRuntimeTypeKeyFirst implements FancyRuntimeTypeKey {
  const _FancyRuntimeTypeKeyFirst(this.a, {final String? $type})
      : $type = $type ?? 'first';
  factory _FancyRuntimeTypeKeyFirst.fromJson(Map<String, dynamic> json) =>
      _$FancyRuntimeTypeKeyFirstFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'run"\'timeType')
  final String $type;

  /// Create a copy of FancyRuntimeTypeKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FancyRuntimeTypeKeyFirstCopyWith<_FancyRuntimeTypeKeyFirst> get copyWith =>
      __$FancyRuntimeTypeKeyFirstCopyWithImpl<_FancyRuntimeTypeKeyFirst>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FancyRuntimeTypeKeyFirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FancyRuntimeTypeKeyFirst &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'FancyRuntimeTypeKey.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$FancyRuntimeTypeKeyFirstCopyWith<$Res>
    implements $FancyRuntimeTypeKeyCopyWith<$Res> {
  factory _$FancyRuntimeTypeKeyFirstCopyWith(_FancyRuntimeTypeKeyFirst value,
          $Res Function(_FancyRuntimeTypeKeyFirst) _then) =
      __$FancyRuntimeTypeKeyFirstCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$FancyRuntimeTypeKeyFirstCopyWithImpl<$Res>
    implements _$FancyRuntimeTypeKeyFirstCopyWith<$Res> {
  __$FancyRuntimeTypeKeyFirstCopyWithImpl(this._self, this._then);

  final _FancyRuntimeTypeKeyFirst _self;
  final $Res Function(_FancyRuntimeTypeKeyFirst) _then;

  /// Create a copy of FancyRuntimeTypeKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_FancyRuntimeTypeKeyFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _FancyRuntimeTypeKeySecond implements FancyRuntimeTypeKey {
  const _FancyRuntimeTypeKeySecond(this.a, {final String? $type})
      : $type = $type ?? 'second';
  factory _FancyRuntimeTypeKeySecond.fromJson(Map<String, dynamic> json) =>
      _$FancyRuntimeTypeKeySecondFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'run"\'timeType')
  final String $type;

  /// Create a copy of FancyRuntimeTypeKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FancyRuntimeTypeKeySecondCopyWith<_FancyRuntimeTypeKeySecond>
      get copyWith =>
          __$FancyRuntimeTypeKeySecondCopyWithImpl<_FancyRuntimeTypeKeySecond>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FancyRuntimeTypeKeySecondToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FancyRuntimeTypeKeySecond &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'FancyRuntimeTypeKey.second(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$FancyRuntimeTypeKeySecondCopyWith<$Res>
    implements $FancyRuntimeTypeKeyCopyWith<$Res> {
  factory _$FancyRuntimeTypeKeySecondCopyWith(_FancyRuntimeTypeKeySecond value,
          $Res Function(_FancyRuntimeTypeKeySecond) _then) =
      __$FancyRuntimeTypeKeySecondCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$FancyRuntimeTypeKeySecondCopyWithImpl<$Res>
    implements _$FancyRuntimeTypeKeySecondCopyWith<$Res> {
  __$FancyRuntimeTypeKeySecondCopyWithImpl(this._self, this._then);

  final _FancyRuntimeTypeKeySecond _self;
  final $Res Function(_FancyRuntimeTypeKeySecond) _then;

  /// Create a copy of FancyRuntimeTypeKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_FancyRuntimeTypeKeySecond(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

RuntimeTypeUnrecognizedKeys _$RuntimeTypeUnrecognizedKeysFromJson(
    Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'first':
      return _RuntimeTypeUnrecognizedKeysFirst.fromJson(json);
    case 'second':
      return _RuntimeTypeUnrecognizedKeysSecond.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json,
          'runtimeType',
          'RuntimeTypeUnrecognizedKeys',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$RuntimeTypeUnrecognizedKeys {
  int get a;

  /// Create a copy of RuntimeTypeUnrecognizedKeys
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RuntimeTypeUnrecognizedKeysCopyWith<RuntimeTypeUnrecognizedKeys>
      get copyWith => _$RuntimeTypeUnrecognizedKeysCopyWithImpl<
              RuntimeTypeUnrecognizedKeys>(
          this as RuntimeTypeUnrecognizedKeys, _$identity);

  /// Serializes this RuntimeTypeUnrecognizedKeys to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RuntimeTypeUnrecognizedKeys &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'RuntimeTypeUnrecognizedKeys(a: $a)';
  }
}

/// @nodoc
abstract mixin class $RuntimeTypeUnrecognizedKeysCopyWith<$Res> {
  factory $RuntimeTypeUnrecognizedKeysCopyWith(
          RuntimeTypeUnrecognizedKeys value,
          $Res Function(RuntimeTypeUnrecognizedKeys) _then) =
      _$RuntimeTypeUnrecognizedKeysCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$RuntimeTypeUnrecognizedKeysCopyWithImpl<$Res>
    implements $RuntimeTypeUnrecognizedKeysCopyWith<$Res> {
  _$RuntimeTypeUnrecognizedKeysCopyWithImpl(this._self, this._then);

  final RuntimeTypeUnrecognizedKeys _self;
  final $Res Function(RuntimeTypeUnrecognizedKeys) _then;

  /// Create a copy of RuntimeTypeUnrecognizedKeys
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

/// Adds pattern-matching-related methods to [RuntimeTypeUnrecognizedKeys].
extension RuntimeTypeUnrecognizedKeysPatterns on RuntimeTypeUnrecognizedKeys {
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
    TResult Function(_RuntimeTypeUnrecognizedKeysFirst value)? first,
    TResult Function(_RuntimeTypeUnrecognizedKeysSecond value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RuntimeTypeUnrecognizedKeysFirst() when first != null:
        return first(_that);
      case _RuntimeTypeUnrecognizedKeysSecond() when second != null:
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
  TResult map<TResult extends Object?>({
    required TResult Function(_RuntimeTypeUnrecognizedKeysFirst value) first,
    required TResult Function(_RuntimeTypeUnrecognizedKeysSecond value) second,
  }) {
    final _that = this;
    switch (_that) {
      case _RuntimeTypeUnrecognizedKeysFirst():
        return first(_that);
      case _RuntimeTypeUnrecognizedKeysSecond():
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RuntimeTypeUnrecognizedKeysFirst value)? first,
    TResult? Function(_RuntimeTypeUnrecognizedKeysSecond value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _RuntimeTypeUnrecognizedKeysFirst() when first != null:
        return first(_that);
      case _RuntimeTypeUnrecognizedKeysSecond() when second != null:
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int a)? first,
    TResult Function(int a)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RuntimeTypeUnrecognizedKeysFirst() when first != null:
        return first(_that.a);
      case _RuntimeTypeUnrecognizedKeysSecond() when second != null:
        return second(_that.a);
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
    required TResult Function(int a) first,
    required TResult Function(int a) second,
  }) {
    final _that = this;
    switch (_that) {
      case _RuntimeTypeUnrecognizedKeysFirst():
        return first(_that.a);
      case _RuntimeTypeUnrecognizedKeysSecond():
        return second(_that.a);
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
    TResult? Function(int a)? first,
    TResult? Function(int a)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _RuntimeTypeUnrecognizedKeysFirst() when first != null:
        return first(_that.a);
      case _RuntimeTypeUnrecognizedKeysSecond() when second != null:
        return second(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(disallowUnrecognizedKeys: true)
class _RuntimeTypeUnrecognizedKeysFirst implements RuntimeTypeUnrecognizedKeys {
  const _RuntimeTypeUnrecognizedKeysFirst(this.a, {final String? $type})
      : $type = $type ?? 'first';
  factory _RuntimeTypeUnrecognizedKeysFirst.fromJson(
          Map<String, dynamic> json) =>
      _$RuntimeTypeUnrecognizedKeysFirstFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of RuntimeTypeUnrecognizedKeys
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RuntimeTypeUnrecognizedKeysFirstCopyWith<_RuntimeTypeUnrecognizedKeysFirst>
      get copyWith => __$RuntimeTypeUnrecognizedKeysFirstCopyWithImpl<
          _RuntimeTypeUnrecognizedKeysFirst>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RuntimeTypeUnrecognizedKeysFirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RuntimeTypeUnrecognizedKeysFirst &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'RuntimeTypeUnrecognizedKeys.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$RuntimeTypeUnrecognizedKeysFirstCopyWith<$Res>
    implements $RuntimeTypeUnrecognizedKeysCopyWith<$Res> {
  factory _$RuntimeTypeUnrecognizedKeysFirstCopyWith(
          _RuntimeTypeUnrecognizedKeysFirst value,
          $Res Function(_RuntimeTypeUnrecognizedKeysFirst) _then) =
      __$RuntimeTypeUnrecognizedKeysFirstCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$RuntimeTypeUnrecognizedKeysFirstCopyWithImpl<$Res>
    implements _$RuntimeTypeUnrecognizedKeysFirstCopyWith<$Res> {
  __$RuntimeTypeUnrecognizedKeysFirstCopyWithImpl(this._self, this._then);

  final _RuntimeTypeUnrecognizedKeysFirst _self;
  final $Res Function(_RuntimeTypeUnrecognizedKeysFirst) _then;

  /// Create a copy of RuntimeTypeUnrecognizedKeys
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_RuntimeTypeUnrecognizedKeysFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(disallowUnrecognizedKeys: true)
class _RuntimeTypeUnrecognizedKeysSecond
    implements RuntimeTypeUnrecognizedKeys {
  const _RuntimeTypeUnrecognizedKeysSecond(this.a, {final String? $type})
      : $type = $type ?? 'second';
  factory _RuntimeTypeUnrecognizedKeysSecond.fromJson(
          Map<String, dynamic> json) =>
      _$RuntimeTypeUnrecognizedKeysSecondFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of RuntimeTypeUnrecognizedKeys
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RuntimeTypeUnrecognizedKeysSecondCopyWith<
          _RuntimeTypeUnrecognizedKeysSecond>
      get copyWith => __$RuntimeTypeUnrecognizedKeysSecondCopyWithImpl<
          _RuntimeTypeUnrecognizedKeysSecond>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RuntimeTypeUnrecognizedKeysSecondToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RuntimeTypeUnrecognizedKeysSecond &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'RuntimeTypeUnrecognizedKeys.second(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$RuntimeTypeUnrecognizedKeysSecondCopyWith<$Res>
    implements $RuntimeTypeUnrecognizedKeysCopyWith<$Res> {
  factory _$RuntimeTypeUnrecognizedKeysSecondCopyWith(
          _RuntimeTypeUnrecognizedKeysSecond value,
          $Res Function(_RuntimeTypeUnrecognizedKeysSecond) _then) =
      __$RuntimeTypeUnrecognizedKeysSecondCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$RuntimeTypeUnrecognizedKeysSecondCopyWithImpl<$Res>
    implements _$RuntimeTypeUnrecognizedKeysSecondCopyWith<$Res> {
  __$RuntimeTypeUnrecognizedKeysSecondCopyWithImpl(this._self, this._then);

  final _RuntimeTypeUnrecognizedKeysSecond _self;
  final $Res Function(_RuntimeTypeUnrecognizedKeysSecond) _then;

  /// Create a copy of RuntimeTypeUnrecognizedKeys
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_RuntimeTypeUnrecognizedKeysSecond(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

RuntimeTypeRawCustomKey _$RuntimeTypeRawCustomKeyFromJson(
    Map<String, dynamic> json) {
  switch (json['\$runtimeType']) {
    case 'first':
      return _RuntimeTypeRawCustomKeyFirst.fromJson(json);
    case 'second':
      return _RuntimeTypeRawCustomKeySecond.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json,
          '\$runtimeType',
          'RuntimeTypeRawCustomKey',
          'Invalid union type "${json['\$runtimeType']}"!');
  }
}

/// @nodoc
mixin _$RuntimeTypeRawCustomKey {
  int get a;

  /// Create a copy of RuntimeTypeRawCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RuntimeTypeRawCustomKeyCopyWith<RuntimeTypeRawCustomKey> get copyWith =>
      _$RuntimeTypeRawCustomKeyCopyWithImpl<RuntimeTypeRawCustomKey>(
          this as RuntimeTypeRawCustomKey, _$identity);

  /// Serializes this RuntimeTypeRawCustomKey to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RuntimeTypeRawCustomKey &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'RuntimeTypeRawCustomKey(a: $a)';
  }
}

/// @nodoc
abstract mixin class $RuntimeTypeRawCustomKeyCopyWith<$Res> {
  factory $RuntimeTypeRawCustomKeyCopyWith(RuntimeTypeRawCustomKey value,
          $Res Function(RuntimeTypeRawCustomKey) _then) =
      _$RuntimeTypeRawCustomKeyCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$RuntimeTypeRawCustomKeyCopyWithImpl<$Res>
    implements $RuntimeTypeRawCustomKeyCopyWith<$Res> {
  _$RuntimeTypeRawCustomKeyCopyWithImpl(this._self, this._then);

  final RuntimeTypeRawCustomKey _self;
  final $Res Function(RuntimeTypeRawCustomKey) _then;

  /// Create a copy of RuntimeTypeRawCustomKey
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

/// Adds pattern-matching-related methods to [RuntimeTypeRawCustomKey].
extension RuntimeTypeRawCustomKeyPatterns on RuntimeTypeRawCustomKey {
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
    TResult Function(_RuntimeTypeRawCustomKeyFirst value)? first,
    TResult Function(_RuntimeTypeRawCustomKeySecond value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RuntimeTypeRawCustomKeyFirst() when first != null:
        return first(_that);
      case _RuntimeTypeRawCustomKeySecond() when second != null:
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
  TResult map<TResult extends Object?>({
    required TResult Function(_RuntimeTypeRawCustomKeyFirst value) first,
    required TResult Function(_RuntimeTypeRawCustomKeySecond value) second,
  }) {
    final _that = this;
    switch (_that) {
      case _RuntimeTypeRawCustomKeyFirst():
        return first(_that);
      case _RuntimeTypeRawCustomKeySecond():
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RuntimeTypeRawCustomKeyFirst value)? first,
    TResult? Function(_RuntimeTypeRawCustomKeySecond value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _RuntimeTypeRawCustomKeyFirst() when first != null:
        return first(_that);
      case _RuntimeTypeRawCustomKeySecond() when second != null:
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int a)? first,
    TResult Function(int a)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RuntimeTypeRawCustomKeyFirst() when first != null:
        return first(_that.a);
      case _RuntimeTypeRawCustomKeySecond() when second != null:
        return second(_that.a);
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
    required TResult Function(int a) first,
    required TResult Function(int a) second,
  }) {
    final _that = this;
    switch (_that) {
      case _RuntimeTypeRawCustomKeyFirst():
        return first(_that.a);
      case _RuntimeTypeRawCustomKeySecond():
        return second(_that.a);
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
    TResult? Function(int a)? first,
    TResult? Function(int a)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _RuntimeTypeRawCustomKeyFirst() when first != null:
        return first(_that.a);
      case _RuntimeTypeRawCustomKeySecond() when second != null:
        return second(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(disallowUnrecognizedKeys: true)
class _RuntimeTypeRawCustomKeyFirst implements RuntimeTypeRawCustomKey {
  const _RuntimeTypeRawCustomKeyFirst(this.a, {final String? $type})
      : $type = $type ?? 'first';
  factory _RuntimeTypeRawCustomKeyFirst.fromJson(Map<String, dynamic> json) =>
      _$RuntimeTypeRawCustomKeyFirstFromJson(json);

  @override
  final int a;

  @JsonKey(name: '\$runtimeType')
  final String $type;

  /// Create a copy of RuntimeTypeRawCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RuntimeTypeRawCustomKeyFirstCopyWith<_RuntimeTypeRawCustomKeyFirst>
      get copyWith => __$RuntimeTypeRawCustomKeyFirstCopyWithImpl<
          _RuntimeTypeRawCustomKeyFirst>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RuntimeTypeRawCustomKeyFirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RuntimeTypeRawCustomKeyFirst &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'RuntimeTypeRawCustomKey.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$RuntimeTypeRawCustomKeyFirstCopyWith<$Res>
    implements $RuntimeTypeRawCustomKeyCopyWith<$Res> {
  factory _$RuntimeTypeRawCustomKeyFirstCopyWith(
          _RuntimeTypeRawCustomKeyFirst value,
          $Res Function(_RuntimeTypeRawCustomKeyFirst) _then) =
      __$RuntimeTypeRawCustomKeyFirstCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$RuntimeTypeRawCustomKeyFirstCopyWithImpl<$Res>
    implements _$RuntimeTypeRawCustomKeyFirstCopyWith<$Res> {
  __$RuntimeTypeRawCustomKeyFirstCopyWithImpl(this._self, this._then);

  final _RuntimeTypeRawCustomKeyFirst _self;
  final $Res Function(_RuntimeTypeRawCustomKeyFirst) _then;

  /// Create a copy of RuntimeTypeRawCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_RuntimeTypeRawCustomKeyFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(disallowUnrecognizedKeys: true)
class _RuntimeTypeRawCustomKeySecond implements RuntimeTypeRawCustomKey {
  const _RuntimeTypeRawCustomKeySecond(this.a, {final String? $type})
      : $type = $type ?? 'second';
  factory _RuntimeTypeRawCustomKeySecond.fromJson(Map<String, dynamic> json) =>
      _$RuntimeTypeRawCustomKeySecondFromJson(json);

  @override
  final int a;

  @JsonKey(name: '\$runtimeType')
  final String $type;

  /// Create a copy of RuntimeTypeRawCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RuntimeTypeRawCustomKeySecondCopyWith<_RuntimeTypeRawCustomKeySecond>
      get copyWith => __$RuntimeTypeRawCustomKeySecondCopyWithImpl<
          _RuntimeTypeRawCustomKeySecond>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RuntimeTypeRawCustomKeySecondToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RuntimeTypeRawCustomKeySecond &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'RuntimeTypeRawCustomKey.second(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$RuntimeTypeRawCustomKeySecondCopyWith<$Res>
    implements $RuntimeTypeRawCustomKeyCopyWith<$Res> {
  factory _$RuntimeTypeRawCustomKeySecondCopyWith(
          _RuntimeTypeRawCustomKeySecond value,
          $Res Function(_RuntimeTypeRawCustomKeySecond) _then) =
      __$RuntimeTypeRawCustomKeySecondCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$RuntimeTypeRawCustomKeySecondCopyWithImpl<$Res>
    implements _$RuntimeTypeRawCustomKeySecondCopyWith<$Res> {
  __$RuntimeTypeRawCustomKeySecondCopyWithImpl(this._self, this._then);

  final _RuntimeTypeRawCustomKeySecond _self;
  final $Res Function(_RuntimeTypeRawCustomKeySecond) _then;

  /// Create a copy of RuntimeTypeRawCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_RuntimeTypeRawCustomKeySecond(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

UnrecognizedKeysFancyCustomKey _$UnrecognizedKeysFancyCustomKeyFromJson(
    Map<String, dynamic> json) {
  switch (json['ty"\'pe']) {
    case 'first':
      return _UnrecognizedKeysFancyCustomKeyFirst.fromJson(json);
    case 'second':
      return _UnrecognizedKeysFancyCustomKeySecond.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json,
          'ty"\'pe',
          'UnrecognizedKeysFancyCustomKey',
          'Invalid union type "${json['ty"\'pe']}"!');
  }
}

/// @nodoc
mixin _$UnrecognizedKeysFancyCustomKey {
  int get a;

  /// Create a copy of UnrecognizedKeysFancyCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnrecognizedKeysFancyCustomKeyCopyWith<UnrecognizedKeysFancyCustomKey>
      get copyWith => _$UnrecognizedKeysFancyCustomKeyCopyWithImpl<
              UnrecognizedKeysFancyCustomKey>(
          this as UnrecognizedKeysFancyCustomKey, _$identity);

  /// Serializes this UnrecognizedKeysFancyCustomKey to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnrecognizedKeysFancyCustomKey &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysFancyCustomKey(a: $a)';
  }
}

/// @nodoc
abstract mixin class $UnrecognizedKeysFancyCustomKeyCopyWith<$Res> {
  factory $UnrecognizedKeysFancyCustomKeyCopyWith(
          UnrecognizedKeysFancyCustomKey value,
          $Res Function(UnrecognizedKeysFancyCustomKey) _then) =
      _$UnrecognizedKeysFancyCustomKeyCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$UnrecognizedKeysFancyCustomKeyCopyWithImpl<$Res>
    implements $UnrecognizedKeysFancyCustomKeyCopyWith<$Res> {
  _$UnrecognizedKeysFancyCustomKeyCopyWithImpl(this._self, this._then);

  final UnrecognizedKeysFancyCustomKey _self;
  final $Res Function(UnrecognizedKeysFancyCustomKey) _then;

  /// Create a copy of UnrecognizedKeysFancyCustomKey
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

/// Adds pattern-matching-related methods to [UnrecognizedKeysFancyCustomKey].
extension UnrecognizedKeysFancyCustomKeyPatterns
    on UnrecognizedKeysFancyCustomKey {
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
    TResult Function(_UnrecognizedKeysFancyCustomKeyFirst value)? first,
    TResult Function(_UnrecognizedKeysFancyCustomKeySecond value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysFancyCustomKeyFirst() when first != null:
        return first(_that);
      case _UnrecognizedKeysFancyCustomKeySecond() when second != null:
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
  TResult map<TResult extends Object?>({
    required TResult Function(_UnrecognizedKeysFancyCustomKeyFirst value) first,
    required TResult Function(_UnrecognizedKeysFancyCustomKeySecond value)
        second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysFancyCustomKeyFirst():
        return first(_that);
      case _UnrecognizedKeysFancyCustomKeySecond():
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnrecognizedKeysFancyCustomKeyFirst value)? first,
    TResult? Function(_UnrecognizedKeysFancyCustomKeySecond value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysFancyCustomKeyFirst() when first != null:
        return first(_that);
      case _UnrecognizedKeysFancyCustomKeySecond() when second != null:
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int a)? first,
    TResult Function(int a)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysFancyCustomKeyFirst() when first != null:
        return first(_that.a);
      case _UnrecognizedKeysFancyCustomKeySecond() when second != null:
        return second(_that.a);
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
    required TResult Function(int a) first,
    required TResult Function(int a) second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysFancyCustomKeyFirst():
        return first(_that.a);
      case _UnrecognizedKeysFancyCustomKeySecond():
        return second(_that.a);
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
    TResult? Function(int a)? first,
    TResult? Function(int a)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysFancyCustomKeyFirst() when first != null:
        return first(_that.a);
      case _UnrecognizedKeysFancyCustomKeySecond() when second != null:
        return second(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(disallowUnrecognizedKeys: true)
class _UnrecognizedKeysFancyCustomKeyFirst
    implements UnrecognizedKeysFancyCustomKey {
  const _UnrecognizedKeysFancyCustomKeyFirst(this.a, {final String? $type})
      : $type = $type ?? 'first';
  factory _UnrecognizedKeysFancyCustomKeyFirst.fromJson(
          Map<String, dynamic> json) =>
      _$UnrecognizedKeysFancyCustomKeyFirstFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'ty"\'pe')
  final String $type;

  /// Create a copy of UnrecognizedKeysFancyCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnrecognizedKeysFancyCustomKeyFirstCopyWith<
          _UnrecognizedKeysFancyCustomKeyFirst>
      get copyWith => __$UnrecognizedKeysFancyCustomKeyFirstCopyWithImpl<
          _UnrecognizedKeysFancyCustomKeyFirst>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnrecognizedKeysFancyCustomKeyFirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnrecognizedKeysFancyCustomKeyFirst &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysFancyCustomKey.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnrecognizedKeysFancyCustomKeyFirstCopyWith<$Res>
    implements $UnrecognizedKeysFancyCustomKeyCopyWith<$Res> {
  factory _$UnrecognizedKeysFancyCustomKeyFirstCopyWith(
          _UnrecognizedKeysFancyCustomKeyFirst value,
          $Res Function(_UnrecognizedKeysFancyCustomKeyFirst) _then) =
      __$UnrecognizedKeysFancyCustomKeyFirstCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnrecognizedKeysFancyCustomKeyFirstCopyWithImpl<$Res>
    implements _$UnrecognizedKeysFancyCustomKeyFirstCopyWith<$Res> {
  __$UnrecognizedKeysFancyCustomKeyFirstCopyWithImpl(this._self, this._then);

  final _UnrecognizedKeysFancyCustomKeyFirst _self;
  final $Res Function(_UnrecognizedKeysFancyCustomKeyFirst) _then;

  /// Create a copy of UnrecognizedKeysFancyCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnrecognizedKeysFancyCustomKeyFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(disallowUnrecognizedKeys: true)
class _UnrecognizedKeysFancyCustomKeySecond
    implements UnrecognizedKeysFancyCustomKey {
  const _UnrecognizedKeysFancyCustomKeySecond(this.a, {final String? $type})
      : $type = $type ?? 'second';
  factory _UnrecognizedKeysFancyCustomKeySecond.fromJson(
          Map<String, dynamic> json) =>
      _$UnrecognizedKeysFancyCustomKeySecondFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'ty"\'pe')
  final String $type;

  /// Create a copy of UnrecognizedKeysFancyCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnrecognizedKeysFancyCustomKeySecondCopyWith<
          _UnrecognizedKeysFancyCustomKeySecond>
      get copyWith => __$UnrecognizedKeysFancyCustomKeySecondCopyWithImpl<
          _UnrecognizedKeysFancyCustomKeySecond>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnrecognizedKeysFancyCustomKeySecondToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnrecognizedKeysFancyCustomKeySecond &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysFancyCustomKey.second(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnrecognizedKeysFancyCustomKeySecondCopyWith<$Res>
    implements $UnrecognizedKeysFancyCustomKeyCopyWith<$Res> {
  factory _$UnrecognizedKeysFancyCustomKeySecondCopyWith(
          _UnrecognizedKeysFancyCustomKeySecond value,
          $Res Function(_UnrecognizedKeysFancyCustomKeySecond) _then) =
      __$UnrecognizedKeysFancyCustomKeySecondCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnrecognizedKeysFancyCustomKeySecondCopyWithImpl<$Res>
    implements _$UnrecognizedKeysFancyCustomKeySecondCopyWith<$Res> {
  __$UnrecognizedKeysFancyCustomKeySecondCopyWithImpl(this._self, this._then);

  final _UnrecognizedKeysFancyCustomKeySecond _self;
  final $Res Function(_UnrecognizedKeysFancyCustomKeySecond) _then;

  /// Create a copy of UnrecognizedKeysFancyCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnrecognizedKeysFancyCustomKeySecond(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

UnrecognizedKeysRawCustomKey _$UnrecognizedKeysRawCustomKeyFromJson(
    Map<String, dynamic> json) {
  switch (json['\$type']) {
    case 'first':
      return _UnrecognizedKeysRawCustomKeyFirst.fromJson(json);
    case 'second':
      return _UnrecognizedKeysRawCustomKeySecond.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json,
          '\$type',
          'UnrecognizedKeysRawCustomKey',
          'Invalid union type "${json['\$type']}"!');
  }
}

/// @nodoc
mixin _$UnrecognizedKeysRawCustomKey {
  int get a;

  /// Create a copy of UnrecognizedKeysRawCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnrecognizedKeysRawCustomKeyCopyWith<UnrecognizedKeysRawCustomKey>
      get copyWith => _$UnrecognizedKeysRawCustomKeyCopyWithImpl<
              UnrecognizedKeysRawCustomKey>(
          this as UnrecognizedKeysRawCustomKey, _$identity);

  /// Serializes this UnrecognizedKeysRawCustomKey to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnrecognizedKeysRawCustomKey &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysRawCustomKey(a: $a)';
  }
}

/// @nodoc
abstract mixin class $UnrecognizedKeysRawCustomKeyCopyWith<$Res> {
  factory $UnrecognizedKeysRawCustomKeyCopyWith(
          UnrecognizedKeysRawCustomKey value,
          $Res Function(UnrecognizedKeysRawCustomKey) _then) =
      _$UnrecognizedKeysRawCustomKeyCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$UnrecognizedKeysRawCustomKeyCopyWithImpl<$Res>
    implements $UnrecognizedKeysRawCustomKeyCopyWith<$Res> {
  _$UnrecognizedKeysRawCustomKeyCopyWithImpl(this._self, this._then);

  final UnrecognizedKeysRawCustomKey _self;
  final $Res Function(UnrecognizedKeysRawCustomKey) _then;

  /// Create a copy of UnrecognizedKeysRawCustomKey
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

/// Adds pattern-matching-related methods to [UnrecognizedKeysRawCustomKey].
extension UnrecognizedKeysRawCustomKeyPatterns on UnrecognizedKeysRawCustomKey {
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
    TResult Function(_UnrecognizedKeysRawCustomKeyFirst value)? first,
    TResult Function(_UnrecognizedKeysRawCustomKeySecond value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysRawCustomKeyFirst() when first != null:
        return first(_that);
      case _UnrecognizedKeysRawCustomKeySecond() when second != null:
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
  TResult map<TResult extends Object?>({
    required TResult Function(_UnrecognizedKeysRawCustomKeyFirst value) first,
    required TResult Function(_UnrecognizedKeysRawCustomKeySecond value) second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysRawCustomKeyFirst():
        return first(_that);
      case _UnrecognizedKeysRawCustomKeySecond():
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnrecognizedKeysRawCustomKeyFirst value)? first,
    TResult? Function(_UnrecognizedKeysRawCustomKeySecond value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysRawCustomKeyFirst() when first != null:
        return first(_that);
      case _UnrecognizedKeysRawCustomKeySecond() when second != null:
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int a)? first,
    TResult Function(int a)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysRawCustomKeyFirst() when first != null:
        return first(_that.a);
      case _UnrecognizedKeysRawCustomKeySecond() when second != null:
        return second(_that.a);
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
    required TResult Function(int a) first,
    required TResult Function(int a) second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysRawCustomKeyFirst():
        return first(_that.a);
      case _UnrecognizedKeysRawCustomKeySecond():
        return second(_that.a);
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
    TResult? Function(int a)? first,
    TResult? Function(int a)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysRawCustomKeyFirst() when first != null:
        return first(_that.a);
      case _UnrecognizedKeysRawCustomKeySecond() when second != null:
        return second(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(disallowUnrecognizedKeys: true)
class _UnrecognizedKeysRawCustomKeyFirst
    implements UnrecognizedKeysRawCustomKey {
  const _UnrecognizedKeysRawCustomKeyFirst(this.a, {final String? $type})
      : $type = $type ?? 'first';
  factory _UnrecognizedKeysRawCustomKeyFirst.fromJson(
          Map<String, dynamic> json) =>
      _$UnrecognizedKeysRawCustomKeyFirstFromJson(json);

  @override
  final int a;

  @JsonKey(name: '\$type')
  final String $type;

  /// Create a copy of UnrecognizedKeysRawCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnrecognizedKeysRawCustomKeyFirstCopyWith<
          _UnrecognizedKeysRawCustomKeyFirst>
      get copyWith => __$UnrecognizedKeysRawCustomKeyFirstCopyWithImpl<
          _UnrecognizedKeysRawCustomKeyFirst>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnrecognizedKeysRawCustomKeyFirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnrecognizedKeysRawCustomKeyFirst &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysRawCustomKey.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnrecognizedKeysRawCustomKeyFirstCopyWith<$Res>
    implements $UnrecognizedKeysRawCustomKeyCopyWith<$Res> {
  factory _$UnrecognizedKeysRawCustomKeyFirstCopyWith(
          _UnrecognizedKeysRawCustomKeyFirst value,
          $Res Function(_UnrecognizedKeysRawCustomKeyFirst) _then) =
      __$UnrecognizedKeysRawCustomKeyFirstCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnrecognizedKeysRawCustomKeyFirstCopyWithImpl<$Res>
    implements _$UnrecognizedKeysRawCustomKeyFirstCopyWith<$Res> {
  __$UnrecognizedKeysRawCustomKeyFirstCopyWithImpl(this._self, this._then);

  final _UnrecognizedKeysRawCustomKeyFirst _self;
  final $Res Function(_UnrecognizedKeysRawCustomKeyFirst) _then;

  /// Create a copy of UnrecognizedKeysRawCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnrecognizedKeysRawCustomKeyFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(disallowUnrecognizedKeys: true)
class _UnrecognizedKeysRawCustomKeySecond
    implements UnrecognizedKeysRawCustomKey {
  const _UnrecognizedKeysRawCustomKeySecond(this.a, {final String? $type})
      : $type = $type ?? 'second';
  factory _UnrecognizedKeysRawCustomKeySecond.fromJson(
          Map<String, dynamic> json) =>
      _$UnrecognizedKeysRawCustomKeySecondFromJson(json);

  @override
  final int a;

  @JsonKey(name: '\$type')
  final String $type;

  /// Create a copy of UnrecognizedKeysRawCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnrecognizedKeysRawCustomKeySecondCopyWith<
          _UnrecognizedKeysRawCustomKeySecond>
      get copyWith => __$UnrecognizedKeysRawCustomKeySecondCopyWithImpl<
          _UnrecognizedKeysRawCustomKeySecond>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnrecognizedKeysRawCustomKeySecondToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnrecognizedKeysRawCustomKeySecond &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysRawCustomKey.second(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnrecognizedKeysRawCustomKeySecondCopyWith<$Res>
    implements $UnrecognizedKeysRawCustomKeyCopyWith<$Res> {
  factory _$UnrecognizedKeysRawCustomKeySecondCopyWith(
          _UnrecognizedKeysRawCustomKeySecond value,
          $Res Function(_UnrecognizedKeysRawCustomKeySecond) _then) =
      __$UnrecognizedKeysRawCustomKeySecondCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnrecognizedKeysRawCustomKeySecondCopyWithImpl<$Res>
    implements _$UnrecognizedKeysRawCustomKeySecondCopyWith<$Res> {
  __$UnrecognizedKeysRawCustomKeySecondCopyWithImpl(this._self, this._then);

  final _UnrecognizedKeysRawCustomKeySecond _self;
  final $Res Function(_UnrecognizedKeysRawCustomKeySecond) _then;

  /// Create a copy of UnrecognizedKeysRawCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnrecognizedKeysRawCustomKeySecond(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

UnrecognizedKeysCustomKey _$UnrecognizedKeysCustomKeyFromJson(
    Map<String, dynamic> json) {
  switch (json['type']) {
    case 'first':
      return _UnrecognizedKeysCustomKeyFirst.fromJson(json);
    case 'second':
      return _UnrecognizedKeysCustomKeySecond.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'type', 'UnrecognizedKeysCustomKey',
          'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$UnrecognizedKeysCustomKey {
  int get a;

  /// Create a copy of UnrecognizedKeysCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnrecognizedKeysCustomKeyCopyWith<UnrecognizedKeysCustomKey> get copyWith =>
      _$UnrecognizedKeysCustomKeyCopyWithImpl<UnrecognizedKeysCustomKey>(
          this as UnrecognizedKeysCustomKey, _$identity);

  /// Serializes this UnrecognizedKeysCustomKey to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnrecognizedKeysCustomKey &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysCustomKey(a: $a)';
  }
}

/// @nodoc
abstract mixin class $UnrecognizedKeysCustomKeyCopyWith<$Res> {
  factory $UnrecognizedKeysCustomKeyCopyWith(UnrecognizedKeysCustomKey value,
          $Res Function(UnrecognizedKeysCustomKey) _then) =
      _$UnrecognizedKeysCustomKeyCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$UnrecognizedKeysCustomKeyCopyWithImpl<$Res>
    implements $UnrecognizedKeysCustomKeyCopyWith<$Res> {
  _$UnrecognizedKeysCustomKeyCopyWithImpl(this._self, this._then);

  final UnrecognizedKeysCustomKey _self;
  final $Res Function(UnrecognizedKeysCustomKey) _then;

  /// Create a copy of UnrecognizedKeysCustomKey
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

/// Adds pattern-matching-related methods to [UnrecognizedKeysCustomKey].
extension UnrecognizedKeysCustomKeyPatterns on UnrecognizedKeysCustomKey {
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
    TResult Function(_UnrecognizedKeysCustomKeyFirst value)? first,
    TResult Function(_UnrecognizedKeysCustomKeySecond value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysCustomKeyFirst() when first != null:
        return first(_that);
      case _UnrecognizedKeysCustomKeySecond() when second != null:
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
  TResult map<TResult extends Object?>({
    required TResult Function(_UnrecognizedKeysCustomKeyFirst value) first,
    required TResult Function(_UnrecognizedKeysCustomKeySecond value) second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysCustomKeyFirst():
        return first(_that);
      case _UnrecognizedKeysCustomKeySecond():
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnrecognizedKeysCustomKeyFirst value)? first,
    TResult? Function(_UnrecognizedKeysCustomKeySecond value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysCustomKeyFirst() when first != null:
        return first(_that);
      case _UnrecognizedKeysCustomKeySecond() when second != null:
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int a)? first,
    TResult Function(int a)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysCustomKeyFirst() when first != null:
        return first(_that.a);
      case _UnrecognizedKeysCustomKeySecond() when second != null:
        return second(_that.a);
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
    required TResult Function(int a) first,
    required TResult Function(int a) second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysCustomKeyFirst():
        return first(_that.a);
      case _UnrecognizedKeysCustomKeySecond():
        return second(_that.a);
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
    TResult? Function(int a)? first,
    TResult? Function(int a)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysCustomKeyFirst() when first != null:
        return first(_that.a);
      case _UnrecognizedKeysCustomKeySecond() when second != null:
        return second(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(disallowUnrecognizedKeys: true)
class _UnrecognizedKeysCustomKeyFirst implements UnrecognizedKeysCustomKey {
  const _UnrecognizedKeysCustomKeyFirst(this.a, {final String? $type})
      : $type = $type ?? 'first';
  factory _UnrecognizedKeysCustomKeyFirst.fromJson(Map<String, dynamic> json) =>
      _$UnrecognizedKeysCustomKeyFirstFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'type')
  final String $type;

  /// Create a copy of UnrecognizedKeysCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnrecognizedKeysCustomKeyFirstCopyWith<_UnrecognizedKeysCustomKeyFirst>
      get copyWith => __$UnrecognizedKeysCustomKeyFirstCopyWithImpl<
          _UnrecognizedKeysCustomKeyFirst>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnrecognizedKeysCustomKeyFirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnrecognizedKeysCustomKeyFirst &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysCustomKey.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnrecognizedKeysCustomKeyFirstCopyWith<$Res>
    implements $UnrecognizedKeysCustomKeyCopyWith<$Res> {
  factory _$UnrecognizedKeysCustomKeyFirstCopyWith(
          _UnrecognizedKeysCustomKeyFirst value,
          $Res Function(_UnrecognizedKeysCustomKeyFirst) _then) =
      __$UnrecognizedKeysCustomKeyFirstCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnrecognizedKeysCustomKeyFirstCopyWithImpl<$Res>
    implements _$UnrecognizedKeysCustomKeyFirstCopyWith<$Res> {
  __$UnrecognizedKeysCustomKeyFirstCopyWithImpl(this._self, this._then);

  final _UnrecognizedKeysCustomKeyFirst _self;
  final $Res Function(_UnrecognizedKeysCustomKeyFirst) _then;

  /// Create a copy of UnrecognizedKeysCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnrecognizedKeysCustomKeyFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(disallowUnrecognizedKeys: true)
class _UnrecognizedKeysCustomKeySecond implements UnrecognizedKeysCustomKey {
  const _UnrecognizedKeysCustomKeySecond(this.a, {final String? $type})
      : $type = $type ?? 'second';
  factory _UnrecognizedKeysCustomKeySecond.fromJson(
          Map<String, dynamic> json) =>
      _$UnrecognizedKeysCustomKeySecondFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'type')
  final String $type;

  /// Create a copy of UnrecognizedKeysCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnrecognizedKeysCustomKeySecondCopyWith<_UnrecognizedKeysCustomKeySecond>
      get copyWith => __$UnrecognizedKeysCustomKeySecondCopyWithImpl<
          _UnrecognizedKeysCustomKeySecond>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnrecognizedKeysCustomKeySecondToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnrecognizedKeysCustomKeySecond &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysCustomKey.second(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnrecognizedKeysCustomKeySecondCopyWith<$Res>
    implements $UnrecognizedKeysCustomKeyCopyWith<$Res> {
  factory _$UnrecognizedKeysCustomKeySecondCopyWith(
          _UnrecognizedKeysCustomKeySecond value,
          $Res Function(_UnrecognizedKeysCustomKeySecond) _then) =
      __$UnrecognizedKeysCustomKeySecondCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnrecognizedKeysCustomKeySecondCopyWithImpl<$Res>
    implements _$UnrecognizedKeysCustomKeySecondCopyWith<$Res> {
  __$UnrecognizedKeysCustomKeySecondCopyWithImpl(this._self, this._then);

  final _UnrecognizedKeysCustomKeySecond _self;
  final $Res Function(_UnrecognizedKeysCustomKeySecond) _then;

  /// Create a copy of UnrecognizedKeysCustomKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnrecognizedKeysCustomKeySecond(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

UnrecognizedKeysCustomUnionValue _$UnrecognizedKeysCustomUnionValueFromJson(
    Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'first':
      return _UnrecognizedKeysCustomUnionValueFirst.fromJson(json);
    case 'SECOND':
      return UnrecognizedKeys_CustomUnionValueSecond.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json,
          'runtimeType',
          'UnrecognizedKeysCustomUnionValue',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$UnrecognizedKeysCustomUnionValue {
  int get a;

  /// Create a copy of UnrecognizedKeysCustomUnionValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnrecognizedKeysCustomUnionValueCopyWith<UnrecognizedKeysCustomUnionValue>
      get copyWith => _$UnrecognizedKeysCustomUnionValueCopyWithImpl<
              UnrecognizedKeysCustomUnionValue>(
          this as UnrecognizedKeysCustomUnionValue, _$identity);

  /// Serializes this UnrecognizedKeysCustomUnionValue to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnrecognizedKeysCustomUnionValue &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysCustomUnionValue(a: $a)';
  }
}

/// @nodoc
abstract mixin class $UnrecognizedKeysCustomUnionValueCopyWith<$Res> {
  factory $UnrecognizedKeysCustomUnionValueCopyWith(
          UnrecognizedKeysCustomUnionValue value,
          $Res Function(UnrecognizedKeysCustomUnionValue) _then) =
      _$UnrecognizedKeysCustomUnionValueCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$UnrecognizedKeysCustomUnionValueCopyWithImpl<$Res>
    implements $UnrecognizedKeysCustomUnionValueCopyWith<$Res> {
  _$UnrecognizedKeysCustomUnionValueCopyWithImpl(this._self, this._then);

  final UnrecognizedKeysCustomUnionValue _self;
  final $Res Function(UnrecognizedKeysCustomUnionValue) _then;

  /// Create a copy of UnrecognizedKeysCustomUnionValue
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

/// Adds pattern-matching-related methods to [UnrecognizedKeysCustomUnionValue].
extension UnrecognizedKeysCustomUnionValuePatterns
    on UnrecognizedKeysCustomUnionValue {
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
    TResult Function(_UnrecognizedKeysCustomUnionValueFirst value)? first,
    TResult Function(UnrecognizedKeys_CustomUnionValueSecond value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysCustomUnionValueFirst() when first != null:
        return first(_that);
      case UnrecognizedKeys_CustomUnionValueSecond() when second != null:
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
  TResult map<TResult extends Object?>({
    required TResult Function(_UnrecognizedKeysCustomUnionValueFirst value)
        first,
    required TResult Function(UnrecognizedKeys_CustomUnionValueSecond value)
        second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysCustomUnionValueFirst():
        return first(_that);
      case UnrecognizedKeys_CustomUnionValueSecond():
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UnrecognizedKeysCustomUnionValueFirst value)? first,
    TResult? Function(UnrecognizedKeys_CustomUnionValueSecond value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysCustomUnionValueFirst() when first != null:
        return first(_that);
      case UnrecognizedKeys_CustomUnionValueSecond() when second != null:
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int a)? first,
    TResult Function(int a)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysCustomUnionValueFirst() when first != null:
        return first(_that.a);
      case UnrecognizedKeys_CustomUnionValueSecond() when second != null:
        return second(_that.a);
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
    required TResult Function(int a) first,
    required TResult Function(int a) second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysCustomUnionValueFirst():
        return first(_that.a);
      case UnrecognizedKeys_CustomUnionValueSecond():
        return second(_that.a);
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
    TResult? Function(int a)? first,
    TResult? Function(int a)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysCustomUnionValueFirst() when first != null:
        return first(_that.a);
      case UnrecognizedKeys_CustomUnionValueSecond() when second != null:
        return second(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(disallowUnrecognizedKeys: true)
class _UnrecognizedKeysCustomUnionValueFirst
    implements UnrecognizedKeysCustomUnionValue {
  const _UnrecognizedKeysCustomUnionValueFirst(this.a, {final String? $type})
      : $type = $type ?? 'first';
  factory _UnrecognizedKeysCustomUnionValueFirst.fromJson(
          Map<String, dynamic> json) =>
      _$UnrecognizedKeysCustomUnionValueFirstFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnrecognizedKeysCustomUnionValue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnrecognizedKeysCustomUnionValueFirstCopyWith<
          _UnrecognizedKeysCustomUnionValueFirst>
      get copyWith => __$UnrecognizedKeysCustomUnionValueFirstCopyWithImpl<
          _UnrecognizedKeysCustomUnionValueFirst>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnrecognizedKeysCustomUnionValueFirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnrecognizedKeysCustomUnionValueFirst &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysCustomUnionValue.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnrecognizedKeysCustomUnionValueFirstCopyWith<$Res>
    implements $UnrecognizedKeysCustomUnionValueCopyWith<$Res> {
  factory _$UnrecognizedKeysCustomUnionValueFirstCopyWith(
          _UnrecognizedKeysCustomUnionValueFirst value,
          $Res Function(_UnrecognizedKeysCustomUnionValueFirst) _then) =
      __$UnrecognizedKeysCustomUnionValueFirstCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnrecognizedKeysCustomUnionValueFirstCopyWithImpl<$Res>
    implements _$UnrecognizedKeysCustomUnionValueFirstCopyWith<$Res> {
  __$UnrecognizedKeysCustomUnionValueFirstCopyWithImpl(this._self, this._then);

  final _UnrecognizedKeysCustomUnionValueFirst _self;
  final $Res Function(_UnrecognizedKeysCustomUnionValueFirst) _then;

  /// Create a copy of UnrecognizedKeysCustomUnionValue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnrecognizedKeysCustomUnionValueFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(disallowUnrecognizedKeys: true)
class UnrecognizedKeys_CustomUnionValueSecond
    implements UnrecognizedKeysCustomUnionValue {
  const UnrecognizedKeys_CustomUnionValueSecond(this.a, {final String? $type})
      : $type = $type ?? 'SECOND';
  factory UnrecognizedKeys_CustomUnionValueSecond.fromJson(
          Map<String, dynamic> json) =>
      _$UnrecognizedKeys_CustomUnionValueSecondFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnrecognizedKeysCustomUnionValue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnrecognizedKeys_CustomUnionValueSecondCopyWith<
          UnrecognizedKeys_CustomUnionValueSecond>
      get copyWith => _$UnrecognizedKeys_CustomUnionValueSecondCopyWithImpl<
          UnrecognizedKeys_CustomUnionValueSecond>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnrecognizedKeys_CustomUnionValueSecondToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnrecognizedKeys_CustomUnionValueSecond &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysCustomUnionValue.second(a: $a)';
  }
}

/// @nodoc
abstract mixin class $UnrecognizedKeys_CustomUnionValueSecondCopyWith<$Res>
    implements $UnrecognizedKeysCustomUnionValueCopyWith<$Res> {
  factory $UnrecognizedKeys_CustomUnionValueSecondCopyWith(
          UnrecognizedKeys_CustomUnionValueSecond value,
          $Res Function(UnrecognizedKeys_CustomUnionValueSecond) _then) =
      _$UnrecognizedKeys_CustomUnionValueSecondCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$UnrecognizedKeys_CustomUnionValueSecondCopyWithImpl<$Res>
    implements $UnrecognizedKeys_CustomUnionValueSecondCopyWith<$Res> {
  _$UnrecognizedKeys_CustomUnionValueSecondCopyWithImpl(this._self, this._then);

  final UnrecognizedKeys_CustomUnionValueSecond _self;
  final $Res Function(UnrecognizedKeys_CustomUnionValueSecond) _then;

  /// Create a copy of UnrecognizedKeysCustomUnionValue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(UnrecognizedKeys_CustomUnionValueSecond(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

UnrecognizedKeysUnionFallback _$UnrecognizedKeysUnionFallbackFromJson(
    Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'first':
      return _UnrecognizedKeysUnionFallbackFirst.fromJson(json);
    case 'second':
      return _UnrecognizedKeysUnionFallbackSecond.fromJson(json);

    default:
      return _UnrecognizedKeysUnionFallbackFallback.fromJson(json);
  }
}

/// @nodoc
mixin _$UnrecognizedKeysUnionFallback {
  int get a;

  /// Create a copy of UnrecognizedKeysUnionFallback
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnrecognizedKeysUnionFallbackCopyWith<UnrecognizedKeysUnionFallback>
      get copyWith => _$UnrecognizedKeysUnionFallbackCopyWithImpl<
              UnrecognizedKeysUnionFallback>(
          this as UnrecognizedKeysUnionFallback, _$identity);

  /// Serializes this UnrecognizedKeysUnionFallback to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnrecognizedKeysUnionFallback &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysUnionFallback(a: $a)';
  }
}

/// @nodoc
abstract mixin class $UnrecognizedKeysUnionFallbackCopyWith<$Res> {
  factory $UnrecognizedKeysUnionFallbackCopyWith(
          UnrecognizedKeysUnionFallback value,
          $Res Function(UnrecognizedKeysUnionFallback) _then) =
      _$UnrecognizedKeysUnionFallbackCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$UnrecognizedKeysUnionFallbackCopyWithImpl<$Res>
    implements $UnrecognizedKeysUnionFallbackCopyWith<$Res> {
  _$UnrecognizedKeysUnionFallbackCopyWithImpl(this._self, this._then);

  final UnrecognizedKeysUnionFallback _self;
  final $Res Function(UnrecognizedKeysUnionFallback) _then;

  /// Create a copy of UnrecognizedKeysUnionFallback
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

/// Adds pattern-matching-related methods to [UnrecognizedKeysUnionFallback].
extension UnrecognizedKeysUnionFallbackPatterns
    on UnrecognizedKeysUnionFallback {
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
    TResult Function(_UnrecognizedKeysUnionFallbackFirst value)? first,
    TResult Function(_UnrecognizedKeysUnionFallbackSecond value)? second,
    TResult Function(_UnrecognizedKeysUnionFallbackFallback value)? fallback,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionFallbackFirst() when first != null:
        return first(_that);
      case _UnrecognizedKeysUnionFallbackSecond() when second != null:
        return second(_that);
      case _UnrecognizedKeysUnionFallbackFallback() when fallback != null:
        return fallback(_that);
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
    required TResult Function(_UnrecognizedKeysUnionFallbackFirst value) first,
    required TResult Function(_UnrecognizedKeysUnionFallbackSecond value)
        second,
    required TResult Function(_UnrecognizedKeysUnionFallbackFallback value)
        fallback,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionFallbackFirst():
        return first(_that);
      case _UnrecognizedKeysUnionFallbackSecond():
        return second(_that);
      case _UnrecognizedKeysUnionFallbackFallback():
        return fallback(_that);
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
    TResult? Function(_UnrecognizedKeysUnionFallbackFirst value)? first,
    TResult? Function(_UnrecognizedKeysUnionFallbackSecond value)? second,
    TResult? Function(_UnrecognizedKeysUnionFallbackFallback value)? fallback,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionFallbackFirst() when first != null:
        return first(_that);
      case _UnrecognizedKeysUnionFallbackSecond() when second != null:
        return second(_that);
      case _UnrecognizedKeysUnionFallbackFallback() when fallback != null:
        return fallback(_that);
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
    TResult Function(int a)? first,
    TResult Function(int a)? second,
    TResult Function(int a)? fallback,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionFallbackFirst() when first != null:
        return first(_that.a);
      case _UnrecognizedKeysUnionFallbackSecond() when second != null:
        return second(_that.a);
      case _UnrecognizedKeysUnionFallbackFallback() when fallback != null:
        return fallback(_that.a);
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
    required TResult Function(int a) first,
    required TResult Function(int a) second,
    required TResult Function(int a) fallback,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionFallbackFirst():
        return first(_that.a);
      case _UnrecognizedKeysUnionFallbackSecond():
        return second(_that.a);
      case _UnrecognizedKeysUnionFallbackFallback():
        return fallback(_that.a);
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
    TResult? Function(int a)? first,
    TResult? Function(int a)? second,
    TResult? Function(int a)? fallback,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionFallbackFirst() when first != null:
        return first(_that.a);
      case _UnrecognizedKeysUnionFallbackSecond() when second != null:
        return second(_that.a);
      case _UnrecognizedKeysUnionFallbackFallback() when fallback != null:
        return fallback(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(disallowUnrecognizedKeys: true)
class _UnrecognizedKeysUnionFallbackFirst
    implements UnrecognizedKeysUnionFallback {
  const _UnrecognizedKeysUnionFallbackFirst(this.a, {final String? $type})
      : $type = $type ?? 'first';
  factory _UnrecognizedKeysUnionFallbackFirst.fromJson(
          Map<String, dynamic> json) =>
      _$UnrecognizedKeysUnionFallbackFirstFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnrecognizedKeysUnionFallback
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnrecognizedKeysUnionFallbackFirstCopyWith<
          _UnrecognizedKeysUnionFallbackFirst>
      get copyWith => __$UnrecognizedKeysUnionFallbackFirstCopyWithImpl<
          _UnrecognizedKeysUnionFallbackFirst>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnrecognizedKeysUnionFallbackFirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnrecognizedKeysUnionFallbackFirst &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysUnionFallback.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnrecognizedKeysUnionFallbackFirstCopyWith<$Res>
    implements $UnrecognizedKeysUnionFallbackCopyWith<$Res> {
  factory _$UnrecognizedKeysUnionFallbackFirstCopyWith(
          _UnrecognizedKeysUnionFallbackFirst value,
          $Res Function(_UnrecognizedKeysUnionFallbackFirst) _then) =
      __$UnrecognizedKeysUnionFallbackFirstCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnrecognizedKeysUnionFallbackFirstCopyWithImpl<$Res>
    implements _$UnrecognizedKeysUnionFallbackFirstCopyWith<$Res> {
  __$UnrecognizedKeysUnionFallbackFirstCopyWithImpl(this._self, this._then);

  final _UnrecognizedKeysUnionFallbackFirst _self;
  final $Res Function(_UnrecognizedKeysUnionFallbackFirst) _then;

  /// Create a copy of UnrecognizedKeysUnionFallback
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnrecognizedKeysUnionFallbackFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(disallowUnrecognizedKeys: true)
class _UnrecognizedKeysUnionFallbackSecond
    implements UnrecognizedKeysUnionFallback {
  const _UnrecognizedKeysUnionFallbackSecond(this.a, {final String? $type})
      : $type = $type ?? 'second';
  factory _UnrecognizedKeysUnionFallbackSecond.fromJson(
          Map<String, dynamic> json) =>
      _$UnrecognizedKeysUnionFallbackSecondFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnrecognizedKeysUnionFallback
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnrecognizedKeysUnionFallbackSecondCopyWith<
          _UnrecognizedKeysUnionFallbackSecond>
      get copyWith => __$UnrecognizedKeysUnionFallbackSecondCopyWithImpl<
          _UnrecognizedKeysUnionFallbackSecond>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnrecognizedKeysUnionFallbackSecondToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnrecognizedKeysUnionFallbackSecond &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysUnionFallback.second(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnrecognizedKeysUnionFallbackSecondCopyWith<$Res>
    implements $UnrecognizedKeysUnionFallbackCopyWith<$Res> {
  factory _$UnrecognizedKeysUnionFallbackSecondCopyWith(
          _UnrecognizedKeysUnionFallbackSecond value,
          $Res Function(_UnrecognizedKeysUnionFallbackSecond) _then) =
      __$UnrecognizedKeysUnionFallbackSecondCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnrecognizedKeysUnionFallbackSecondCopyWithImpl<$Res>
    implements _$UnrecognizedKeysUnionFallbackSecondCopyWith<$Res> {
  __$UnrecognizedKeysUnionFallbackSecondCopyWithImpl(this._self, this._then);

  final _UnrecognizedKeysUnionFallbackSecond _self;
  final $Res Function(_UnrecognizedKeysUnionFallbackSecond) _then;

  /// Create a copy of UnrecognizedKeysUnionFallback
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnrecognizedKeysUnionFallbackSecond(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(disallowUnrecognizedKeys: true)
class _UnrecognizedKeysUnionFallbackFallback
    implements UnrecognizedKeysUnionFallback {
  const _UnrecognizedKeysUnionFallbackFallback(this.a, {final String? $type})
      : $type = $type ?? 'fallback';
  factory _UnrecognizedKeysUnionFallbackFallback.fromJson(
          Map<String, dynamic> json) =>
      _$UnrecognizedKeysUnionFallbackFallbackFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnrecognizedKeysUnionFallback
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnrecognizedKeysUnionFallbackFallbackCopyWith<
          _UnrecognizedKeysUnionFallbackFallback>
      get copyWith => __$UnrecognizedKeysUnionFallbackFallbackCopyWithImpl<
          _UnrecognizedKeysUnionFallbackFallback>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnrecognizedKeysUnionFallbackFallbackToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnrecognizedKeysUnionFallbackFallback &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysUnionFallback.fallback(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnrecognizedKeysUnionFallbackFallbackCopyWith<$Res>
    implements $UnrecognizedKeysUnionFallbackCopyWith<$Res> {
  factory _$UnrecognizedKeysUnionFallbackFallbackCopyWith(
          _UnrecognizedKeysUnionFallbackFallback value,
          $Res Function(_UnrecognizedKeysUnionFallbackFallback) _then) =
      __$UnrecognizedKeysUnionFallbackFallbackCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnrecognizedKeysUnionFallbackFallbackCopyWithImpl<$Res>
    implements _$UnrecognizedKeysUnionFallbackFallbackCopyWith<$Res> {
  __$UnrecognizedKeysUnionFallbackFallbackCopyWithImpl(this._self, this._then);

  final _UnrecognizedKeysUnionFallbackFallback _self;
  final $Res Function(_UnrecognizedKeysUnionFallbackFallback) _then;

  /// Create a copy of UnrecognizedKeysUnionFallback
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnrecognizedKeysUnionFallbackFallback(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

UnrecognizedKeysUnionFallbackWithDefault
    _$UnrecognizedKeysUnionFallbackWithDefaultFromJson(
        Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'first':
      return _UnrecognizedKeysUnionDefaultFallbackFirst.fromJson(json);
    case 'second':
      return _UnrecognizedKeysUnionDefaultFallbackSecond.fromJson(json);

    default:
      return _UnrecognizedKeysUnionDefaultFallback.fromJson(json);
  }
}

/// @nodoc
mixin _$UnrecognizedKeysUnionFallbackWithDefault {
  int get a;

  /// Create a copy of UnrecognizedKeysUnionFallbackWithDefault
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnrecognizedKeysUnionFallbackWithDefaultCopyWith<
          UnrecognizedKeysUnionFallbackWithDefault>
      get copyWith => _$UnrecognizedKeysUnionFallbackWithDefaultCopyWithImpl<
              UnrecognizedKeysUnionFallbackWithDefault>(
          this as UnrecognizedKeysUnionFallbackWithDefault, _$identity);

  /// Serializes this UnrecognizedKeysUnionFallbackWithDefault to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnrecognizedKeysUnionFallbackWithDefault &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysUnionFallbackWithDefault(a: $a)';
  }
}

/// @nodoc
abstract mixin class $UnrecognizedKeysUnionFallbackWithDefaultCopyWith<$Res> {
  factory $UnrecognizedKeysUnionFallbackWithDefaultCopyWith(
          UnrecognizedKeysUnionFallbackWithDefault value,
          $Res Function(UnrecognizedKeysUnionFallbackWithDefault) _then) =
      _$UnrecognizedKeysUnionFallbackWithDefaultCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$UnrecognizedKeysUnionFallbackWithDefaultCopyWithImpl<$Res>
    implements $UnrecognizedKeysUnionFallbackWithDefaultCopyWith<$Res> {
  _$UnrecognizedKeysUnionFallbackWithDefaultCopyWithImpl(
      this._self, this._then);

  final UnrecognizedKeysUnionFallbackWithDefault _self;
  final $Res Function(UnrecognizedKeysUnionFallbackWithDefault) _then;

  /// Create a copy of UnrecognizedKeysUnionFallbackWithDefault
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

/// Adds pattern-matching-related methods to [UnrecognizedKeysUnionFallbackWithDefault].
extension UnrecognizedKeysUnionFallbackWithDefaultPatterns
    on UnrecognizedKeysUnionFallbackWithDefault {
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
    TResult Function(_UnrecognizedKeysUnionDefaultFallback value)? $default, {
    TResult Function(_UnrecognizedKeysUnionDefaultFallbackFirst value)? first,
    TResult Function(_UnrecognizedKeysUnionDefaultFallbackSecond value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionDefaultFallback() when $default != null:
        return $default(_that);
      case _UnrecognizedKeysUnionDefaultFallbackFirst() when first != null:
        return first(_that);
      case _UnrecognizedKeysUnionDefaultFallbackSecond() when second != null:
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
    TResult Function(_UnrecognizedKeysUnionDefaultFallback value) $default, {
    required TResult Function(_UnrecognizedKeysUnionDefaultFallbackFirst value)
        first,
    required TResult Function(_UnrecognizedKeysUnionDefaultFallbackSecond value)
        second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionDefaultFallback():
        return $default(_that);
      case _UnrecognizedKeysUnionDefaultFallbackFirst():
        return first(_that);
      case _UnrecognizedKeysUnionDefaultFallbackSecond():
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
    TResult? Function(_UnrecognizedKeysUnionDefaultFallback value)? $default, {
    TResult? Function(_UnrecognizedKeysUnionDefaultFallbackFirst value)? first,
    TResult? Function(_UnrecognizedKeysUnionDefaultFallbackSecond value)?
        second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionDefaultFallback() when $default != null:
        return $default(_that);
      case _UnrecognizedKeysUnionDefaultFallbackFirst() when first != null:
        return first(_that);
      case _UnrecognizedKeysUnionDefaultFallbackSecond() when second != null:
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
    TResult Function(int a)? $default, {
    TResult Function(int a)? first,
    TResult Function(int a)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionDefaultFallback() when $default != null:
        return $default(_that.a);
      case _UnrecognizedKeysUnionDefaultFallbackFirst() when first != null:
        return first(_that.a);
      case _UnrecognizedKeysUnionDefaultFallbackSecond() when second != null:
        return second(_that.a);
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
    TResult Function(int a) $default, {
    required TResult Function(int a) first,
    required TResult Function(int a) second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionDefaultFallback():
        return $default(_that.a);
      case _UnrecognizedKeysUnionDefaultFallbackFirst():
        return first(_that.a);
      case _UnrecognizedKeysUnionDefaultFallbackSecond():
        return second(_that.a);
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
    TResult? Function(int a)? $default, {
    TResult? Function(int a)? first,
    TResult? Function(int a)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionDefaultFallback() when $default != null:
        return $default(_that.a);
      case _UnrecognizedKeysUnionDefaultFallbackFirst() when first != null:
        return first(_that.a);
      case _UnrecognizedKeysUnionDefaultFallbackSecond() when second != null:
        return second(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(disallowUnrecognizedKeys: true)
class _UnrecognizedKeysUnionDefaultFallback
    implements UnrecognizedKeysUnionFallbackWithDefault {
  const _UnrecognizedKeysUnionDefaultFallback(this.a, {final String? $type})
      : $type = $type ?? 'default';
  factory _UnrecognizedKeysUnionDefaultFallback.fromJson(
          Map<String, dynamic> json) =>
      _$UnrecognizedKeysUnionDefaultFallbackFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnrecognizedKeysUnionFallbackWithDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnrecognizedKeysUnionDefaultFallbackCopyWith<
          _UnrecognizedKeysUnionDefaultFallback>
      get copyWith => __$UnrecognizedKeysUnionDefaultFallbackCopyWithImpl<
          _UnrecognizedKeysUnionDefaultFallback>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnrecognizedKeysUnionDefaultFallbackToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnrecognizedKeysUnionDefaultFallback &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysUnionFallbackWithDefault(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnrecognizedKeysUnionDefaultFallbackCopyWith<$Res>
    implements $UnrecognizedKeysUnionFallbackWithDefaultCopyWith<$Res> {
  factory _$UnrecognizedKeysUnionDefaultFallbackCopyWith(
          _UnrecognizedKeysUnionDefaultFallback value,
          $Res Function(_UnrecognizedKeysUnionDefaultFallback) _then) =
      __$UnrecognizedKeysUnionDefaultFallbackCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnrecognizedKeysUnionDefaultFallbackCopyWithImpl<$Res>
    implements _$UnrecognizedKeysUnionDefaultFallbackCopyWith<$Res> {
  __$UnrecognizedKeysUnionDefaultFallbackCopyWithImpl(this._self, this._then);

  final _UnrecognizedKeysUnionDefaultFallback _self;
  final $Res Function(_UnrecognizedKeysUnionDefaultFallback) _then;

  /// Create a copy of UnrecognizedKeysUnionFallbackWithDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnrecognizedKeysUnionDefaultFallback(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(disallowUnrecognizedKeys: true)
class _UnrecognizedKeysUnionDefaultFallbackFirst
    implements UnrecognizedKeysUnionFallbackWithDefault {
  const _UnrecognizedKeysUnionDefaultFallbackFirst(this.a,
      {final String? $type})
      : $type = $type ?? 'first';
  factory _UnrecognizedKeysUnionDefaultFallbackFirst.fromJson(
          Map<String, dynamic> json) =>
      _$UnrecognizedKeysUnionDefaultFallbackFirstFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnrecognizedKeysUnionFallbackWithDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnrecognizedKeysUnionDefaultFallbackFirstCopyWith<
          _UnrecognizedKeysUnionDefaultFallbackFirst>
      get copyWith => __$UnrecognizedKeysUnionDefaultFallbackFirstCopyWithImpl<
          _UnrecognizedKeysUnionDefaultFallbackFirst>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnrecognizedKeysUnionDefaultFallbackFirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnrecognizedKeysUnionDefaultFallbackFirst &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysUnionFallbackWithDefault.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnrecognizedKeysUnionDefaultFallbackFirstCopyWith<$Res>
    implements $UnrecognizedKeysUnionFallbackWithDefaultCopyWith<$Res> {
  factory _$UnrecognizedKeysUnionDefaultFallbackFirstCopyWith(
          _UnrecognizedKeysUnionDefaultFallbackFirst value,
          $Res Function(_UnrecognizedKeysUnionDefaultFallbackFirst) _then) =
      __$UnrecognizedKeysUnionDefaultFallbackFirstCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnrecognizedKeysUnionDefaultFallbackFirstCopyWithImpl<$Res>
    implements _$UnrecognizedKeysUnionDefaultFallbackFirstCopyWith<$Res> {
  __$UnrecognizedKeysUnionDefaultFallbackFirstCopyWithImpl(
      this._self, this._then);

  final _UnrecognizedKeysUnionDefaultFallbackFirst _self;
  final $Res Function(_UnrecognizedKeysUnionDefaultFallbackFirst) _then;

  /// Create a copy of UnrecognizedKeysUnionFallbackWithDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnrecognizedKeysUnionDefaultFallbackFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(disallowUnrecognizedKeys: true)
class _UnrecognizedKeysUnionDefaultFallbackSecond
    implements UnrecognizedKeysUnionFallbackWithDefault {
  const _UnrecognizedKeysUnionDefaultFallbackSecond(this.a,
      {final String? $type})
      : $type = $type ?? 'second';
  factory _UnrecognizedKeysUnionDefaultFallbackSecond.fromJson(
          Map<String, dynamic> json) =>
      _$UnrecognizedKeysUnionDefaultFallbackSecondFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnrecognizedKeysUnionFallbackWithDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnrecognizedKeysUnionDefaultFallbackSecondCopyWith<
          _UnrecognizedKeysUnionDefaultFallbackSecond>
      get copyWith => __$UnrecognizedKeysUnionDefaultFallbackSecondCopyWithImpl<
          _UnrecognizedKeysUnionDefaultFallbackSecond>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnrecognizedKeysUnionDefaultFallbackSecondToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnrecognizedKeysUnionDefaultFallbackSecond &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysUnionFallbackWithDefault.second(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnrecognizedKeysUnionDefaultFallbackSecondCopyWith<$Res>
    implements $UnrecognizedKeysUnionFallbackWithDefaultCopyWith<$Res> {
  factory _$UnrecognizedKeysUnionDefaultFallbackSecondCopyWith(
          _UnrecognizedKeysUnionDefaultFallbackSecond value,
          $Res Function(_UnrecognizedKeysUnionDefaultFallbackSecond) _then) =
      __$UnrecognizedKeysUnionDefaultFallbackSecondCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnrecognizedKeysUnionDefaultFallbackSecondCopyWithImpl<$Res>
    implements _$UnrecognizedKeysUnionDefaultFallbackSecondCopyWith<$Res> {
  __$UnrecognizedKeysUnionDefaultFallbackSecondCopyWithImpl(
      this._self, this._then);

  final _UnrecognizedKeysUnionDefaultFallbackSecond _self;
  final $Res Function(_UnrecognizedKeysUnionDefaultFallbackSecond) _then;

  /// Create a copy of UnrecognizedKeysUnionFallbackWithDefault
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnrecognizedKeysUnionDefaultFallbackSecond(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

UnrecognizedKeysUnionValueCasePascal
    _$UnrecognizedKeysUnionValueCasePascalFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'First':
      return _UnrecognizedKeysUnionValueCasePascalFirst.fromJson(json);
    case 'SecondValue':
      return _UnrecognizedKeysUnionValueCasePascalSecondValue.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json,
          'runtimeType',
          'UnrecognizedKeysUnionValueCasePascal',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$UnrecognizedKeysUnionValueCasePascal {
  int get a;

  /// Create a copy of UnrecognizedKeysUnionValueCasePascal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnrecognizedKeysUnionValueCasePascalCopyWith<
          UnrecognizedKeysUnionValueCasePascal>
      get copyWith => _$UnrecognizedKeysUnionValueCasePascalCopyWithImpl<
              UnrecognizedKeysUnionValueCasePascal>(
          this as UnrecognizedKeysUnionValueCasePascal, _$identity);

  /// Serializes this UnrecognizedKeysUnionValueCasePascal to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnrecognizedKeysUnionValueCasePascal &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysUnionValueCasePascal(a: $a)';
  }
}

/// @nodoc
abstract mixin class $UnrecognizedKeysUnionValueCasePascalCopyWith<$Res> {
  factory $UnrecognizedKeysUnionValueCasePascalCopyWith(
          UnrecognizedKeysUnionValueCasePascal value,
          $Res Function(UnrecognizedKeysUnionValueCasePascal) _then) =
      _$UnrecognizedKeysUnionValueCasePascalCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$UnrecognizedKeysUnionValueCasePascalCopyWithImpl<$Res>
    implements $UnrecognizedKeysUnionValueCasePascalCopyWith<$Res> {
  _$UnrecognizedKeysUnionValueCasePascalCopyWithImpl(this._self, this._then);

  final UnrecognizedKeysUnionValueCasePascal _self;
  final $Res Function(UnrecognizedKeysUnionValueCasePascal) _then;

  /// Create a copy of UnrecognizedKeysUnionValueCasePascal
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

/// Adds pattern-matching-related methods to [UnrecognizedKeysUnionValueCasePascal].
extension UnrecognizedKeysUnionValueCasePascalPatterns
    on UnrecognizedKeysUnionValueCasePascal {
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
    TResult Function(_UnrecognizedKeysUnionValueCasePascalFirst value)? first,
    TResult Function(_UnrecognizedKeysUnionValueCasePascalSecondValue value)?
        secondValue,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionValueCasePascalFirst() when first != null:
        return first(_that);
      case _UnrecognizedKeysUnionValueCasePascalSecondValue()
          when secondValue != null:
        return secondValue(_that);
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
    required TResult Function(_UnrecognizedKeysUnionValueCasePascalFirst value)
        first,
    required TResult Function(
            _UnrecognizedKeysUnionValueCasePascalSecondValue value)
        secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionValueCasePascalFirst():
        return first(_that);
      case _UnrecognizedKeysUnionValueCasePascalSecondValue():
        return secondValue(_that);
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
    TResult? Function(_UnrecognizedKeysUnionValueCasePascalFirst value)? first,
    TResult? Function(_UnrecognizedKeysUnionValueCasePascalSecondValue value)?
        secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionValueCasePascalFirst() when first != null:
        return first(_that);
      case _UnrecognizedKeysUnionValueCasePascalSecondValue()
          when secondValue != null:
        return secondValue(_that);
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
    TResult Function(int a)? first,
    TResult Function(int a)? secondValue,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionValueCasePascalFirst() when first != null:
        return first(_that.a);
      case _UnrecognizedKeysUnionValueCasePascalSecondValue()
          when secondValue != null:
        return secondValue(_that.a);
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
    required TResult Function(int a) first,
    required TResult Function(int a) secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionValueCasePascalFirst():
        return first(_that.a);
      case _UnrecognizedKeysUnionValueCasePascalSecondValue():
        return secondValue(_that.a);
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
    TResult? Function(int a)? first,
    TResult? Function(int a)? secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionValueCasePascalFirst() when first != null:
        return first(_that.a);
      case _UnrecognizedKeysUnionValueCasePascalSecondValue()
          when secondValue != null:
        return secondValue(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(disallowUnrecognizedKeys: true)
class _UnrecognizedKeysUnionValueCasePascalFirst
    implements UnrecognizedKeysUnionValueCasePascal {
  const _UnrecognizedKeysUnionValueCasePascalFirst(this.a,
      {final String? $type})
      : $type = $type ?? 'First';
  factory _UnrecognizedKeysUnionValueCasePascalFirst.fromJson(
          Map<String, dynamic> json) =>
      _$UnrecognizedKeysUnionValueCasePascalFirstFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnrecognizedKeysUnionValueCasePascal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnrecognizedKeysUnionValueCasePascalFirstCopyWith<
          _UnrecognizedKeysUnionValueCasePascalFirst>
      get copyWith => __$UnrecognizedKeysUnionValueCasePascalFirstCopyWithImpl<
          _UnrecognizedKeysUnionValueCasePascalFirst>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnrecognizedKeysUnionValueCasePascalFirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnrecognizedKeysUnionValueCasePascalFirst &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysUnionValueCasePascal.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnrecognizedKeysUnionValueCasePascalFirstCopyWith<$Res>
    implements $UnrecognizedKeysUnionValueCasePascalCopyWith<$Res> {
  factory _$UnrecognizedKeysUnionValueCasePascalFirstCopyWith(
          _UnrecognizedKeysUnionValueCasePascalFirst value,
          $Res Function(_UnrecognizedKeysUnionValueCasePascalFirst) _then) =
      __$UnrecognizedKeysUnionValueCasePascalFirstCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnrecognizedKeysUnionValueCasePascalFirstCopyWithImpl<$Res>
    implements _$UnrecognizedKeysUnionValueCasePascalFirstCopyWith<$Res> {
  __$UnrecognizedKeysUnionValueCasePascalFirstCopyWithImpl(
      this._self, this._then);

  final _UnrecognizedKeysUnionValueCasePascalFirst _self;
  final $Res Function(_UnrecognizedKeysUnionValueCasePascalFirst) _then;

  /// Create a copy of UnrecognizedKeysUnionValueCasePascal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnrecognizedKeysUnionValueCasePascalFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(disallowUnrecognizedKeys: true)
class _UnrecognizedKeysUnionValueCasePascalSecondValue
    implements UnrecognizedKeysUnionValueCasePascal {
  const _UnrecognizedKeysUnionValueCasePascalSecondValue(this.a,
      {final String? $type})
      : $type = $type ?? 'SecondValue';
  factory _UnrecognizedKeysUnionValueCasePascalSecondValue.fromJson(
          Map<String, dynamic> json) =>
      _$UnrecognizedKeysUnionValueCasePascalSecondValueFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnrecognizedKeysUnionValueCasePascal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnrecognizedKeysUnionValueCasePascalSecondValueCopyWith<
          _UnrecognizedKeysUnionValueCasePascalSecondValue>
      get copyWith =>
          __$UnrecognizedKeysUnionValueCasePascalSecondValueCopyWithImpl<
                  _UnrecognizedKeysUnionValueCasePascalSecondValue>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnrecognizedKeysUnionValueCasePascalSecondValueToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnrecognizedKeysUnionValueCasePascalSecondValue &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysUnionValueCasePascal.secondValue(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnrecognizedKeysUnionValueCasePascalSecondValueCopyWith<
    $Res> implements $UnrecognizedKeysUnionValueCasePascalCopyWith<$Res> {
  factory _$UnrecognizedKeysUnionValueCasePascalSecondValueCopyWith(
          _UnrecognizedKeysUnionValueCasePascalSecondValue value,
          $Res Function(_UnrecognizedKeysUnionValueCasePascalSecondValue)
              _then) =
      __$UnrecognizedKeysUnionValueCasePascalSecondValueCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnrecognizedKeysUnionValueCasePascalSecondValueCopyWithImpl<$Res>
    implements _$UnrecognizedKeysUnionValueCasePascalSecondValueCopyWith<$Res> {
  __$UnrecognizedKeysUnionValueCasePascalSecondValueCopyWithImpl(
      this._self, this._then);

  final _UnrecognizedKeysUnionValueCasePascalSecondValue _self;
  final $Res Function(_UnrecognizedKeysUnionValueCasePascalSecondValue) _then;

  /// Create a copy of UnrecognizedKeysUnionValueCasePascal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnrecognizedKeysUnionValueCasePascalSecondValue(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

UnrecognizedKeysUnionValueCaseKebab
    _$UnrecognizedKeysUnionValueCaseKebabFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'first':
      return _UnrecognizedKeysUnionValueCaseKebabFirst.fromJson(json);
    case 'second-value':
      return _UnrecognizedKeysUnionValueCaseKebabSecondValue.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json,
          'runtimeType',
          'UnrecognizedKeysUnionValueCaseKebab',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$UnrecognizedKeysUnionValueCaseKebab {
  int get a;

  /// Create a copy of UnrecognizedKeysUnionValueCaseKebab
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnrecognizedKeysUnionValueCaseKebabCopyWith<
          UnrecognizedKeysUnionValueCaseKebab>
      get copyWith => _$UnrecognizedKeysUnionValueCaseKebabCopyWithImpl<
              UnrecognizedKeysUnionValueCaseKebab>(
          this as UnrecognizedKeysUnionValueCaseKebab, _$identity);

  /// Serializes this UnrecognizedKeysUnionValueCaseKebab to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnrecognizedKeysUnionValueCaseKebab &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysUnionValueCaseKebab(a: $a)';
  }
}

/// @nodoc
abstract mixin class $UnrecognizedKeysUnionValueCaseKebabCopyWith<$Res> {
  factory $UnrecognizedKeysUnionValueCaseKebabCopyWith(
          UnrecognizedKeysUnionValueCaseKebab value,
          $Res Function(UnrecognizedKeysUnionValueCaseKebab) _then) =
      _$UnrecognizedKeysUnionValueCaseKebabCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$UnrecognizedKeysUnionValueCaseKebabCopyWithImpl<$Res>
    implements $UnrecognizedKeysUnionValueCaseKebabCopyWith<$Res> {
  _$UnrecognizedKeysUnionValueCaseKebabCopyWithImpl(this._self, this._then);

  final UnrecognizedKeysUnionValueCaseKebab _self;
  final $Res Function(UnrecognizedKeysUnionValueCaseKebab) _then;

  /// Create a copy of UnrecognizedKeysUnionValueCaseKebab
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

/// Adds pattern-matching-related methods to [UnrecognizedKeysUnionValueCaseKebab].
extension UnrecognizedKeysUnionValueCaseKebabPatterns
    on UnrecognizedKeysUnionValueCaseKebab {
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
    TResult Function(_UnrecognizedKeysUnionValueCaseKebabFirst value)? first,
    TResult Function(_UnrecognizedKeysUnionValueCaseKebabSecondValue value)?
        secondValue,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionValueCaseKebabFirst() when first != null:
        return first(_that);
      case _UnrecognizedKeysUnionValueCaseKebabSecondValue()
          when secondValue != null:
        return secondValue(_that);
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
    required TResult Function(_UnrecognizedKeysUnionValueCaseKebabFirst value)
        first,
    required TResult Function(
            _UnrecognizedKeysUnionValueCaseKebabSecondValue value)
        secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionValueCaseKebabFirst():
        return first(_that);
      case _UnrecognizedKeysUnionValueCaseKebabSecondValue():
        return secondValue(_that);
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
    TResult? Function(_UnrecognizedKeysUnionValueCaseKebabFirst value)? first,
    TResult? Function(_UnrecognizedKeysUnionValueCaseKebabSecondValue value)?
        secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionValueCaseKebabFirst() when first != null:
        return first(_that);
      case _UnrecognizedKeysUnionValueCaseKebabSecondValue()
          when secondValue != null:
        return secondValue(_that);
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
    TResult Function(int a)? first,
    TResult Function(int a)? secondValue,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionValueCaseKebabFirst() when first != null:
        return first(_that.a);
      case _UnrecognizedKeysUnionValueCaseKebabSecondValue()
          when secondValue != null:
        return secondValue(_that.a);
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
    required TResult Function(int a) first,
    required TResult Function(int a) secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionValueCaseKebabFirst():
        return first(_that.a);
      case _UnrecognizedKeysUnionValueCaseKebabSecondValue():
        return secondValue(_that.a);
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
    TResult? Function(int a)? first,
    TResult? Function(int a)? secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionValueCaseKebabFirst() when first != null:
        return first(_that.a);
      case _UnrecognizedKeysUnionValueCaseKebabSecondValue()
          when secondValue != null:
        return secondValue(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(disallowUnrecognizedKeys: true)
class _UnrecognizedKeysUnionValueCaseKebabFirst
    implements UnrecognizedKeysUnionValueCaseKebab {
  const _UnrecognizedKeysUnionValueCaseKebabFirst(this.a, {final String? $type})
      : $type = $type ?? 'first';
  factory _UnrecognizedKeysUnionValueCaseKebabFirst.fromJson(
          Map<String, dynamic> json) =>
      _$UnrecognizedKeysUnionValueCaseKebabFirstFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnrecognizedKeysUnionValueCaseKebab
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnrecognizedKeysUnionValueCaseKebabFirstCopyWith<
          _UnrecognizedKeysUnionValueCaseKebabFirst>
      get copyWith => __$UnrecognizedKeysUnionValueCaseKebabFirstCopyWithImpl<
          _UnrecognizedKeysUnionValueCaseKebabFirst>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnrecognizedKeysUnionValueCaseKebabFirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnrecognizedKeysUnionValueCaseKebabFirst &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysUnionValueCaseKebab.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnrecognizedKeysUnionValueCaseKebabFirstCopyWith<$Res>
    implements $UnrecognizedKeysUnionValueCaseKebabCopyWith<$Res> {
  factory _$UnrecognizedKeysUnionValueCaseKebabFirstCopyWith(
          _UnrecognizedKeysUnionValueCaseKebabFirst value,
          $Res Function(_UnrecognizedKeysUnionValueCaseKebabFirst) _then) =
      __$UnrecognizedKeysUnionValueCaseKebabFirstCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnrecognizedKeysUnionValueCaseKebabFirstCopyWithImpl<$Res>
    implements _$UnrecognizedKeysUnionValueCaseKebabFirstCopyWith<$Res> {
  __$UnrecognizedKeysUnionValueCaseKebabFirstCopyWithImpl(
      this._self, this._then);

  final _UnrecognizedKeysUnionValueCaseKebabFirst _self;
  final $Res Function(_UnrecognizedKeysUnionValueCaseKebabFirst) _then;

  /// Create a copy of UnrecognizedKeysUnionValueCaseKebab
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnrecognizedKeysUnionValueCaseKebabFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(disallowUnrecognizedKeys: true)
class _UnrecognizedKeysUnionValueCaseKebabSecondValue
    implements UnrecognizedKeysUnionValueCaseKebab {
  const _UnrecognizedKeysUnionValueCaseKebabSecondValue(this.a,
      {final String? $type})
      : $type = $type ?? 'second-value';
  factory _UnrecognizedKeysUnionValueCaseKebabSecondValue.fromJson(
          Map<String, dynamic> json) =>
      _$UnrecognizedKeysUnionValueCaseKebabSecondValueFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnrecognizedKeysUnionValueCaseKebab
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnrecognizedKeysUnionValueCaseKebabSecondValueCopyWith<
          _UnrecognizedKeysUnionValueCaseKebabSecondValue>
      get copyWith =>
          __$UnrecognizedKeysUnionValueCaseKebabSecondValueCopyWithImpl<
                  _UnrecognizedKeysUnionValueCaseKebabSecondValue>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnrecognizedKeysUnionValueCaseKebabSecondValueToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnrecognizedKeysUnionValueCaseKebabSecondValue &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysUnionValueCaseKebab.secondValue(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnrecognizedKeysUnionValueCaseKebabSecondValueCopyWith<
    $Res> implements $UnrecognizedKeysUnionValueCaseKebabCopyWith<$Res> {
  factory _$UnrecognizedKeysUnionValueCaseKebabSecondValueCopyWith(
          _UnrecognizedKeysUnionValueCaseKebabSecondValue value,
          $Res Function(_UnrecognizedKeysUnionValueCaseKebabSecondValue)
              _then) =
      __$UnrecognizedKeysUnionValueCaseKebabSecondValueCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnrecognizedKeysUnionValueCaseKebabSecondValueCopyWithImpl<$Res>
    implements _$UnrecognizedKeysUnionValueCaseKebabSecondValueCopyWith<$Res> {
  __$UnrecognizedKeysUnionValueCaseKebabSecondValueCopyWithImpl(
      this._self, this._then);

  final _UnrecognizedKeysUnionValueCaseKebabSecondValue _self;
  final $Res Function(_UnrecognizedKeysUnionValueCaseKebabSecondValue) _then;

  /// Create a copy of UnrecognizedKeysUnionValueCaseKebab
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnrecognizedKeysUnionValueCaseKebabSecondValue(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

UnrecognizedKeysUnionValueCaseSnake
    _$UnrecognizedKeysUnionValueCaseSnakeFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'first':
      return _UnrecognizedKeysUnionValueCaseSnakeFirst.fromJson(json);
    case 'second_value':
      return _UnrecognizedKeysUnionValueCaseSnakeSecondValue.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json,
          'runtimeType',
          'UnrecognizedKeysUnionValueCaseSnake',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$UnrecognizedKeysUnionValueCaseSnake {
  int get a;

  /// Create a copy of UnrecognizedKeysUnionValueCaseSnake
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnrecognizedKeysUnionValueCaseSnakeCopyWith<
          UnrecognizedKeysUnionValueCaseSnake>
      get copyWith => _$UnrecognizedKeysUnionValueCaseSnakeCopyWithImpl<
              UnrecognizedKeysUnionValueCaseSnake>(
          this as UnrecognizedKeysUnionValueCaseSnake, _$identity);

  /// Serializes this UnrecognizedKeysUnionValueCaseSnake to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnrecognizedKeysUnionValueCaseSnake &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysUnionValueCaseSnake(a: $a)';
  }
}

/// @nodoc
abstract mixin class $UnrecognizedKeysUnionValueCaseSnakeCopyWith<$Res> {
  factory $UnrecognizedKeysUnionValueCaseSnakeCopyWith(
          UnrecognizedKeysUnionValueCaseSnake value,
          $Res Function(UnrecognizedKeysUnionValueCaseSnake) _then) =
      _$UnrecognizedKeysUnionValueCaseSnakeCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$UnrecognizedKeysUnionValueCaseSnakeCopyWithImpl<$Res>
    implements $UnrecognizedKeysUnionValueCaseSnakeCopyWith<$Res> {
  _$UnrecognizedKeysUnionValueCaseSnakeCopyWithImpl(this._self, this._then);

  final UnrecognizedKeysUnionValueCaseSnake _self;
  final $Res Function(UnrecognizedKeysUnionValueCaseSnake) _then;

  /// Create a copy of UnrecognizedKeysUnionValueCaseSnake
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

/// Adds pattern-matching-related methods to [UnrecognizedKeysUnionValueCaseSnake].
extension UnrecognizedKeysUnionValueCaseSnakePatterns
    on UnrecognizedKeysUnionValueCaseSnake {
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
    TResult Function(_UnrecognizedKeysUnionValueCaseSnakeFirst value)? first,
    TResult Function(_UnrecognizedKeysUnionValueCaseSnakeSecondValue value)?
        secondValue,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionValueCaseSnakeFirst() when first != null:
        return first(_that);
      case _UnrecognizedKeysUnionValueCaseSnakeSecondValue()
          when secondValue != null:
        return secondValue(_that);
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
    required TResult Function(_UnrecognizedKeysUnionValueCaseSnakeFirst value)
        first,
    required TResult Function(
            _UnrecognizedKeysUnionValueCaseSnakeSecondValue value)
        secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionValueCaseSnakeFirst():
        return first(_that);
      case _UnrecognizedKeysUnionValueCaseSnakeSecondValue():
        return secondValue(_that);
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
    TResult? Function(_UnrecognizedKeysUnionValueCaseSnakeFirst value)? first,
    TResult? Function(_UnrecognizedKeysUnionValueCaseSnakeSecondValue value)?
        secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionValueCaseSnakeFirst() when first != null:
        return first(_that);
      case _UnrecognizedKeysUnionValueCaseSnakeSecondValue()
          when secondValue != null:
        return secondValue(_that);
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
    TResult Function(int a)? first,
    TResult Function(int a)? secondValue,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionValueCaseSnakeFirst() when first != null:
        return first(_that.a);
      case _UnrecognizedKeysUnionValueCaseSnakeSecondValue()
          when secondValue != null:
        return secondValue(_that.a);
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
    required TResult Function(int a) first,
    required TResult Function(int a) secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionValueCaseSnakeFirst():
        return first(_that.a);
      case _UnrecognizedKeysUnionValueCaseSnakeSecondValue():
        return secondValue(_that.a);
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
    TResult? Function(int a)? first,
    TResult? Function(int a)? secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionValueCaseSnakeFirst() when first != null:
        return first(_that.a);
      case _UnrecognizedKeysUnionValueCaseSnakeSecondValue()
          when secondValue != null:
        return secondValue(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(disallowUnrecognizedKeys: true)
class _UnrecognizedKeysUnionValueCaseSnakeFirst
    implements UnrecognizedKeysUnionValueCaseSnake {
  const _UnrecognizedKeysUnionValueCaseSnakeFirst(this.a, {final String? $type})
      : $type = $type ?? 'first';
  factory _UnrecognizedKeysUnionValueCaseSnakeFirst.fromJson(
          Map<String, dynamic> json) =>
      _$UnrecognizedKeysUnionValueCaseSnakeFirstFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnrecognizedKeysUnionValueCaseSnake
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnrecognizedKeysUnionValueCaseSnakeFirstCopyWith<
          _UnrecognizedKeysUnionValueCaseSnakeFirst>
      get copyWith => __$UnrecognizedKeysUnionValueCaseSnakeFirstCopyWithImpl<
          _UnrecognizedKeysUnionValueCaseSnakeFirst>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnrecognizedKeysUnionValueCaseSnakeFirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnrecognizedKeysUnionValueCaseSnakeFirst &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysUnionValueCaseSnake.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnrecognizedKeysUnionValueCaseSnakeFirstCopyWith<$Res>
    implements $UnrecognizedKeysUnionValueCaseSnakeCopyWith<$Res> {
  factory _$UnrecognizedKeysUnionValueCaseSnakeFirstCopyWith(
          _UnrecognizedKeysUnionValueCaseSnakeFirst value,
          $Res Function(_UnrecognizedKeysUnionValueCaseSnakeFirst) _then) =
      __$UnrecognizedKeysUnionValueCaseSnakeFirstCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnrecognizedKeysUnionValueCaseSnakeFirstCopyWithImpl<$Res>
    implements _$UnrecognizedKeysUnionValueCaseSnakeFirstCopyWith<$Res> {
  __$UnrecognizedKeysUnionValueCaseSnakeFirstCopyWithImpl(
      this._self, this._then);

  final _UnrecognizedKeysUnionValueCaseSnakeFirst _self;
  final $Res Function(_UnrecognizedKeysUnionValueCaseSnakeFirst) _then;

  /// Create a copy of UnrecognizedKeysUnionValueCaseSnake
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnrecognizedKeysUnionValueCaseSnakeFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(disallowUnrecognizedKeys: true)
class _UnrecognizedKeysUnionValueCaseSnakeSecondValue
    implements UnrecognizedKeysUnionValueCaseSnake {
  const _UnrecognizedKeysUnionValueCaseSnakeSecondValue(this.a,
      {final String? $type})
      : $type = $type ?? 'second_value';
  factory _UnrecognizedKeysUnionValueCaseSnakeSecondValue.fromJson(
          Map<String, dynamic> json) =>
      _$UnrecognizedKeysUnionValueCaseSnakeSecondValueFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnrecognizedKeysUnionValueCaseSnake
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnrecognizedKeysUnionValueCaseSnakeSecondValueCopyWith<
          _UnrecognizedKeysUnionValueCaseSnakeSecondValue>
      get copyWith =>
          __$UnrecognizedKeysUnionValueCaseSnakeSecondValueCopyWithImpl<
                  _UnrecognizedKeysUnionValueCaseSnakeSecondValue>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnrecognizedKeysUnionValueCaseSnakeSecondValueToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnrecognizedKeysUnionValueCaseSnakeSecondValue &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysUnionValueCaseSnake.secondValue(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnrecognizedKeysUnionValueCaseSnakeSecondValueCopyWith<
    $Res> implements $UnrecognizedKeysUnionValueCaseSnakeCopyWith<$Res> {
  factory _$UnrecognizedKeysUnionValueCaseSnakeSecondValueCopyWith(
          _UnrecognizedKeysUnionValueCaseSnakeSecondValue value,
          $Res Function(_UnrecognizedKeysUnionValueCaseSnakeSecondValue)
              _then) =
      __$UnrecognizedKeysUnionValueCaseSnakeSecondValueCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnrecognizedKeysUnionValueCaseSnakeSecondValueCopyWithImpl<$Res>
    implements _$UnrecognizedKeysUnionValueCaseSnakeSecondValueCopyWith<$Res> {
  __$UnrecognizedKeysUnionValueCaseSnakeSecondValueCopyWithImpl(
      this._self, this._then);

  final _UnrecognizedKeysUnionValueCaseSnakeSecondValue _self;
  final $Res Function(_UnrecognizedKeysUnionValueCaseSnakeSecondValue) _then;

  /// Create a copy of UnrecognizedKeysUnionValueCaseSnake
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnrecognizedKeysUnionValueCaseSnakeSecondValue(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

UnrecognizedKeysUnionValueCaseScreamingSnake
    _$UnrecognizedKeysUnionValueCaseScreamingSnakeFromJson(
        Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'FIRST':
      return _UnrecognizedKeysUnionValueCaseScreamingSnakeFirst.fromJson(json);
    case 'SECOND_VALUE':
      return _UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValue.fromJson(
          json);

    default:
      throw CheckedFromJsonException(
          json,
          'runtimeType',
          'UnrecognizedKeysUnionValueCaseScreamingSnake',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$UnrecognizedKeysUnionValueCaseScreamingSnake {
  int get a;

  /// Create a copy of UnrecognizedKeysUnionValueCaseScreamingSnake
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnrecognizedKeysUnionValueCaseScreamingSnakeCopyWith<
          UnrecognizedKeysUnionValueCaseScreamingSnake>
      get copyWith =>
          _$UnrecognizedKeysUnionValueCaseScreamingSnakeCopyWithImpl<
                  UnrecognizedKeysUnionValueCaseScreamingSnake>(
              this as UnrecognizedKeysUnionValueCaseScreamingSnake, _$identity);

  /// Serializes this UnrecognizedKeysUnionValueCaseScreamingSnake to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnrecognizedKeysUnionValueCaseScreamingSnake &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysUnionValueCaseScreamingSnake(a: $a)';
  }
}

/// @nodoc
abstract mixin class $UnrecognizedKeysUnionValueCaseScreamingSnakeCopyWith<
    $Res> {
  factory $UnrecognizedKeysUnionValueCaseScreamingSnakeCopyWith(
          UnrecognizedKeysUnionValueCaseScreamingSnake value,
          $Res Function(UnrecognizedKeysUnionValueCaseScreamingSnake) _then) =
      _$UnrecognizedKeysUnionValueCaseScreamingSnakeCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$UnrecognizedKeysUnionValueCaseScreamingSnakeCopyWithImpl<$Res>
    implements $UnrecognizedKeysUnionValueCaseScreamingSnakeCopyWith<$Res> {
  _$UnrecognizedKeysUnionValueCaseScreamingSnakeCopyWithImpl(
      this._self, this._then);

  final UnrecognizedKeysUnionValueCaseScreamingSnake _self;
  final $Res Function(UnrecognizedKeysUnionValueCaseScreamingSnake) _then;

  /// Create a copy of UnrecognizedKeysUnionValueCaseScreamingSnake
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

/// Adds pattern-matching-related methods to [UnrecognizedKeysUnionValueCaseScreamingSnake].
extension UnrecognizedKeysUnionValueCaseScreamingSnakePatterns
    on UnrecognizedKeysUnionValueCaseScreamingSnake {
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
    TResult Function(_UnrecognizedKeysUnionValueCaseScreamingSnakeFirst value)?
        first,
    TResult Function(
            _UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValue value)?
        secondValue,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionValueCaseScreamingSnakeFirst()
          when first != null:
        return first(_that);
      case _UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValue()
          when secondValue != null:
        return secondValue(_that);
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
    required TResult Function(
            _UnrecognizedKeysUnionValueCaseScreamingSnakeFirst value)
        first,
    required TResult Function(
            _UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValue value)
        secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionValueCaseScreamingSnakeFirst():
        return first(_that);
      case _UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValue():
        return secondValue(_that);
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
    TResult? Function(_UnrecognizedKeysUnionValueCaseScreamingSnakeFirst value)?
        first,
    TResult? Function(
            _UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValue value)?
        secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionValueCaseScreamingSnakeFirst()
          when first != null:
        return first(_that);
      case _UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValue()
          when secondValue != null:
        return secondValue(_that);
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
    TResult Function(int a)? first,
    TResult Function(int a)? secondValue,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionValueCaseScreamingSnakeFirst()
          when first != null:
        return first(_that.a);
      case _UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValue()
          when secondValue != null:
        return secondValue(_that.a);
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
    required TResult Function(int a) first,
    required TResult Function(int a) secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionValueCaseScreamingSnakeFirst():
        return first(_that.a);
      case _UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValue():
        return secondValue(_that.a);
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
    TResult? Function(int a)? first,
    TResult? Function(int a)? secondValue,
  }) {
    final _that = this;
    switch (_that) {
      case _UnrecognizedKeysUnionValueCaseScreamingSnakeFirst()
          when first != null:
        return first(_that.a);
      case _UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValue()
          when secondValue != null:
        return secondValue(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(disallowUnrecognizedKeys: true)
class _UnrecognizedKeysUnionValueCaseScreamingSnakeFirst
    implements UnrecognizedKeysUnionValueCaseScreamingSnake {
  const _UnrecognizedKeysUnionValueCaseScreamingSnakeFirst(this.a,
      {final String? $type})
      : $type = $type ?? 'FIRST';
  factory _UnrecognizedKeysUnionValueCaseScreamingSnakeFirst.fromJson(
          Map<String, dynamic> json) =>
      _$UnrecognizedKeysUnionValueCaseScreamingSnakeFirstFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnrecognizedKeysUnionValueCaseScreamingSnake
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnrecognizedKeysUnionValueCaseScreamingSnakeFirstCopyWith<
          _UnrecognizedKeysUnionValueCaseScreamingSnakeFirst>
      get copyWith =>
          __$UnrecognizedKeysUnionValueCaseScreamingSnakeFirstCopyWithImpl<
                  _UnrecognizedKeysUnionValueCaseScreamingSnakeFirst>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnrecognizedKeysUnionValueCaseScreamingSnakeFirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnrecognizedKeysUnionValueCaseScreamingSnakeFirst &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysUnionValueCaseScreamingSnake.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnrecognizedKeysUnionValueCaseScreamingSnakeFirstCopyWith<
        $Res>
    implements $UnrecognizedKeysUnionValueCaseScreamingSnakeCopyWith<$Res> {
  factory _$UnrecognizedKeysUnionValueCaseScreamingSnakeFirstCopyWith(
          _UnrecognizedKeysUnionValueCaseScreamingSnakeFirst value,
          $Res Function(_UnrecognizedKeysUnionValueCaseScreamingSnakeFirst)
              _then) =
      __$UnrecognizedKeysUnionValueCaseScreamingSnakeFirstCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnrecognizedKeysUnionValueCaseScreamingSnakeFirstCopyWithImpl<$Res>
    implements
        _$UnrecognizedKeysUnionValueCaseScreamingSnakeFirstCopyWith<$Res> {
  __$UnrecognizedKeysUnionValueCaseScreamingSnakeFirstCopyWithImpl(
      this._self, this._then);

  final _UnrecognizedKeysUnionValueCaseScreamingSnakeFirst _self;
  final $Res Function(_UnrecognizedKeysUnionValueCaseScreamingSnakeFirst) _then;

  /// Create a copy of UnrecognizedKeysUnionValueCaseScreamingSnake
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnrecognizedKeysUnionValueCaseScreamingSnakeFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(disallowUnrecognizedKeys: true)
class _UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValue
    implements UnrecognizedKeysUnionValueCaseScreamingSnake {
  const _UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValue(this.a,
      {final String? $type})
      : $type = $type ?? 'SECOND_VALUE';
  factory _UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValue.fromJson(
          Map<String, dynamic> json) =>
      _$UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValueFromJson(json);

  @override
  final int a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of UnrecognizedKeysUnionValueCaseScreamingSnake
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValueCopyWith<
          _UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValue>
      get copyWith =>
          __$UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValueCopyWithImpl<
                  _UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValue>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValueToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValue &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'UnrecognizedKeysUnionValueCaseScreamingSnake.secondValue(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValueCopyWith<
        $Res>
    implements $UnrecognizedKeysUnionValueCaseScreamingSnakeCopyWith<$Res> {
  factory _$UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValueCopyWith(
          _UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValue value,
          $Res Function(
                  _UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValue)
              _then) =
      __$UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValueCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValueCopyWithImpl<
        $Res>
    implements
        _$UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValueCopyWith<
            $Res> {
  __$UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValueCopyWithImpl(
      this._self, this._then);

  final _UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValue _self;
  final $Res Function(_UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValue)
      _then;

  /// Create a copy of UnrecognizedKeysUnionValueCaseScreamingSnake
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_UnrecognizedKeysUnionValueCaseScreamingSnakeSecondValue(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$Single {
  int get a;

  /// Create a copy of Single
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SingleCopyWith<Single> get copyWith =>
      _$SingleCopyWithImpl<Single>(this as Single, _$identity);

  /// Serializes this Single to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Single &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'Single(a: $a)';
  }
}

/// @nodoc
abstract mixin class $SingleCopyWith<$Res> {
  factory $SingleCopyWith(Single value, $Res Function(Single) _then) =
      _$SingleCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$SingleCopyWithImpl<$Res> implements $SingleCopyWith<$Res> {
  _$SingleCopyWithImpl(this._self, this._then);

  final Single _self;
  final $Res Function(Single) _then;

  /// Create a copy of Single
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

/// Adds pattern-matching-related methods to [Single].
extension SinglePatterns on Single {
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
    TResult Function(_Single value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Single() when $default != null:
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
    TResult Function(_Single value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Single():
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
    TResult? Function(_Single value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Single() when $default != null:
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
      case _Single() when $default != null:
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
      case _Single():
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
      case _Single() when $default != null:
        return $default(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Single implements Single {
  const _Single(this.a);
  factory _Single.fromJson(Map<String, dynamic> json) => _$SingleFromJson(json);

  @override
  final int a;

  /// Create a copy of Single
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SingleCopyWith<_Single> get copyWith =>
      __$SingleCopyWithImpl<_Single>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SingleToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Single &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'Single(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$SingleCopyWith<$Res> implements $SingleCopyWith<$Res> {
  factory _$SingleCopyWith(_Single value, $Res Function(_Single) _then) =
      __$SingleCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$SingleCopyWithImpl<$Res> implements _$SingleCopyWith<$Res> {
  __$SingleCopyWithImpl(this._self, this._then);

  final _Single _self;
  final $Res Function(_Single) _then;

  /// Create a copy of Single
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_Single(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

Json _$JsonFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'default':
      return JsonDefault.fromJson(json);
    case 'first':
      return First.fromJson(json);
    case 'second':
      return Second.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'Json',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$Json {
  /// Serializes this Json to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Json);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Json()';
  }
}

/// @nodoc
class $JsonCopyWith<$Res> {
  $JsonCopyWith(Json _, $Res Function(Json) __);
}

/// Adds pattern-matching-related methods to [Json].
extension JsonPatterns on Json {
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
    TResult Function(JsonDefault value)? $default, {
    TResult Function(First value)? first,
    TResult Function(Second value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case JsonDefault() when $default != null:
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
    TResult Function(JsonDefault value) $default, {
    required TResult Function(First value) first,
    required TResult Function(Second value) second,
  }) {
    final _that = this;
    switch (_that) {
      case JsonDefault():
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
    TResult? Function(JsonDefault value)? $default, {
    TResult? Function(First value)? first,
    TResult? Function(Second value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case JsonDefault() when $default != null:
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
    TResult Function()? $default, {
    TResult Function(String a)? first,
    TResult Function(int b)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case JsonDefault() when $default != null:
        return $default();
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
    TResult Function() $default, {
    required TResult Function(String a) first,
    required TResult Function(int b) second,
  }) {
    final _that = this;
    switch (_that) {
      case JsonDefault():
        return $default();
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
    TResult? Function()? $default, {
    TResult? Function(String a)? first,
    TResult? Function(int b)? second,
  }) {
    final _that = this;
    switch (_that) {
      case JsonDefault() when $default != null:
        return $default();
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
@JsonSerializable()
class JsonDefault implements Json {
  const JsonDefault({final String? $type}) : $type = $type ?? 'default';
  factory JsonDefault.fromJson(Map<String, dynamic> json) =>
      _$JsonDefaultFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  Map<String, dynamic> toJson() {
    return _$JsonDefaultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is JsonDefault);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Json()';
  }
}

/// @nodoc
@JsonSerializable()
class First implements Json {
  const First(this.a, {final String? $type}) : $type = $type ?? 'first';
  factory First.fromJson(Map<String, dynamic> json) => _$FirstFromJson(json);

  final String a;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of Json
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FirstCopyWith<First> get copyWith =>
      _$FirstCopyWithImpl<First>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FirstToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is First &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'Json.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class $FirstCopyWith<$Res> implements $JsonCopyWith<$Res> {
  factory $FirstCopyWith(First value, $Res Function(First) _then) =
      _$FirstCopyWithImpl;
  @useResult
  $Res call({String a});
}

/// @nodoc
class _$FirstCopyWithImpl<$Res> implements $FirstCopyWith<$Res> {
  _$FirstCopyWithImpl(this._self, this._then);

  final First _self;
  final $Res Function(First) _then;

  /// Create a copy of Json
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(First(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class Second implements Json {
  const Second(this.b, {final String? $type}) : $type = $type ?? 'second';
  factory Second.fromJson(Map<String, dynamic> json) => _$SecondFromJson(json);

  final int b;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of Json
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SecondCopyWith<Second> get copyWith =>
      _$SecondCopyWithImpl<Second>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SecondToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Second &&
            (identical(other.b, b) || other.b == b));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, b);

  @override
  String toString() {
    return 'Json.second(b: $b)';
  }
}

/// @nodoc
abstract mixin class $SecondCopyWith<$Res> implements $JsonCopyWith<$Res> {
  factory $SecondCopyWith(Second value, $Res Function(Second) _then) =
      _$SecondCopyWithImpl;
  @useResult
  $Res call({int b});
}

/// @nodoc
class _$SecondCopyWithImpl<$Res> implements $SecondCopyWith<$Res> {
  _$SecondCopyWithImpl(this._self, this._then);

  final Second _self;
  final $Res Function(Second) _then;

  /// Create a copy of Json
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? b = null,
  }) {
    return _then(Second(
      null == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$NoJson {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is NoJson);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'NoJson()';
  }
}

/// @nodoc
class $NoJsonCopyWith<$Res> {
  $NoJsonCopyWith(NoJson _, $Res Function(NoJson) __);
}

/// Adds pattern-matching-related methods to [NoJson].
extension NoJsonPatterns on NoJson {
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
    TResult Function(NoDefault value)? $default, {
    TResult Function(NoFirst value)? first,
    TResult Function(NoSecond value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case NoDefault() when $default != null:
        return $default(_that);
      case NoFirst() when first != null:
        return first(_that);
      case NoSecond() when second != null:
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
    TResult Function(NoDefault value) $default, {
    required TResult Function(NoFirst value) first,
    required TResult Function(NoSecond value) second,
  }) {
    final _that = this;
    switch (_that) {
      case NoDefault():
        return $default(_that);
      case NoFirst():
        return first(_that);
      case NoSecond():
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
    TResult? Function(NoDefault value)? $default, {
    TResult? Function(NoFirst value)? first,
    TResult? Function(NoSecond value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case NoDefault() when $default != null:
        return $default(_that);
      case NoFirst() when first != null:
        return first(_that);
      case NoSecond() when second != null:
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
    TResult Function()? $default, {
    TResult Function(String a)? first,
    TResult Function(int b)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case NoDefault() when $default != null:
        return $default();
      case NoFirst() when first != null:
        return first(_that.a);
      case NoSecond() when second != null:
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
    TResult Function() $default, {
    required TResult Function(String a) first,
    required TResult Function(int b) second,
  }) {
    final _that = this;
    switch (_that) {
      case NoDefault():
        return $default();
      case NoFirst():
        return first(_that.a);
      case NoSecond():
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
    TResult? Function()? $default, {
    TResult? Function(String a)? first,
    TResult? Function(int b)? second,
  }) {
    final _that = this;
    switch (_that) {
      case NoDefault() when $default != null:
        return $default();
      case NoFirst() when first != null:
        return first(_that.a);
      case NoSecond() when second != null:
        return second(_that.b);
      case _:
        return null;
    }
  }
}

/// @nodoc

class NoDefault implements NoJson {
  const NoDefault();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is NoDefault);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'NoJson()';
  }
}

/// @nodoc

class NoFirst implements NoJson {
  const NoFirst(this.a);

  final String a;

  /// Create a copy of NoJson
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NoFirstCopyWith<NoFirst> get copyWith =>
      _$NoFirstCopyWithImpl<NoFirst>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NoFirst &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'NoJson.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class $NoFirstCopyWith<$Res> implements $NoJsonCopyWith<$Res> {
  factory $NoFirstCopyWith(NoFirst value, $Res Function(NoFirst) _then) =
      _$NoFirstCopyWithImpl;
  @useResult
  $Res call({String a});
}

/// @nodoc
class _$NoFirstCopyWithImpl<$Res> implements $NoFirstCopyWith<$Res> {
  _$NoFirstCopyWithImpl(this._self, this._then);

  final NoFirst _self;
  final $Res Function(NoFirst) _then;

  /// Create a copy of NoJson
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(NoFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class NoSecond implements NoJson {
  const NoSecond(this.b);

  final int b;

  /// Create a copy of NoJson
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NoSecondCopyWith<NoSecond> get copyWith =>
      _$NoSecondCopyWithImpl<NoSecond>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NoSecond &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, b);

  @override
  String toString() {
    return 'NoJson.second(b: $b)';
  }
}

/// @nodoc
abstract mixin class $NoSecondCopyWith<$Res> implements $NoJsonCopyWith<$Res> {
  factory $NoSecondCopyWith(NoSecond value, $Res Function(NoSecond) _then) =
      _$NoSecondCopyWithImpl;
  @useResult
  $Res call({int b});
}

/// @nodoc
class _$NoSecondCopyWithImpl<$Res> implements $NoSecondCopyWith<$Res> {
  _$NoSecondCopyWithImpl(this._self, this._then);

  final NoSecond _self;
  final $Res Function(NoSecond) _then;

  /// Create a copy of NoJson
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? b = null,
  }) {
    return _then(NoSecond(
      null == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$Decorator {
  @JsonKey(name: 'what')
  String get a;

  /// Create a copy of Decorator
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DecoratorCopyWith<Decorator> get copyWith =>
      _$DecoratorCopyWithImpl<Decorator>(this as Decorator, _$identity);

  /// Serializes this Decorator to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Decorator &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
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
  $Res call({@JsonKey(name: 'what') String a});
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
    Object? a = null,
  }) {
    return _then(_self.copyWith(
      a: null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
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
    TResult Function(_Decorator value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Decorator() when $default != null:
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
    TResult Function(_Decorator value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Decorator():
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
    TResult? Function(_Decorator value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Decorator() when $default != null:
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
    TResult Function(@JsonKey(name: 'what') String a)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Decorator() when $default != null:
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
    TResult Function(@JsonKey(name: 'what') String a) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Decorator():
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
    TResult? Function(@JsonKey(name: 'what') String a)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Decorator() when $default != null:
        return $default(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Decorator implements Decorator {
  _Decorator(@JsonKey(name: 'what') this.a);
  factory _Decorator.fromJson(Map<String, dynamic> json) =>
      _$DecoratorFromJson(json);

  @override
  @JsonKey(name: 'what')
  final String a;

  /// Create a copy of Decorator
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DecoratorCopyWith<_Decorator> get copyWith =>
      __$DecoratorCopyWithImpl<_Decorator>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DecoratorToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Decorator &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'Decorator(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$DecoratorCopyWith<$Res>
    implements $DecoratorCopyWith<$Res> {
  factory _$DecoratorCopyWith(
          _Decorator value, $Res Function(_Decorator) _then) =
      __$DecoratorCopyWithImpl;
  @override
  @useResult
  $Res call({@JsonKey(name: 'what') String a});
}

/// @nodoc
class __$DecoratorCopyWithImpl<$Res> implements _$DecoratorCopyWith<$Res> {
  __$DecoratorCopyWithImpl(this._self, this._then);

  final _Decorator _self;
  final $Res Function(_Decorator) _then;

  /// Create a copy of Decorator
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_Decorator(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$Generic<T> {
  @DataConverter()
  T get a;

  /// Create a copy of Generic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GenericCopyWith<T, Generic<T>> get copyWith =>
      _$GenericCopyWithImpl<T, Generic<T>>(this as Generic<T>, _$identity);

  /// Serializes this Generic to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Generic<T> &&
            const DeepCollectionEquality().equals(other.a, a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(a));

  @override
  String toString() {
    return 'Generic<$T>(a: $a)';
  }
}

/// @nodoc
abstract mixin class $GenericCopyWith<T, $Res> {
  factory $GenericCopyWith(Generic<T> value, $Res Function(Generic<T>) _then) =
      _$GenericCopyWithImpl;
  @useResult
  $Res call({@DataConverter() T a});
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
    Object? a = freezed,
  }) {
    return _then(_self.copyWith(
      a: freezed == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
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
    TResult Function(@DataConverter() T a)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Generic() when $default != null:
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
    TResult Function(@DataConverter() T a) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Generic():
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
    TResult? Function(@DataConverter() T a)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Generic() when $default != null:
        return $default(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Generic<T> implements Generic<T> {
  _Generic(@DataConverter() this.a);
  factory _Generic.fromJson(Map<String, dynamic> json) =>
      _$GenericFromJson(json);

  @override
  @DataConverter()
  final T a;

  /// Create a copy of Generic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GenericCopyWith<T, _Generic<T>> get copyWith =>
      __$GenericCopyWithImpl<T, _Generic<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GenericToJson<T>(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Generic<T> &&
            const DeepCollectionEquality().equals(other.a, a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(a));

  @override
  String toString() {
    return 'Generic<$T>(a: $a)';
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
  $Res call({@DataConverter() T a});
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
    Object? a = freezed,
  }) {
    return _then(_Generic<T>(
      freezed == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc
mixin _$DefaultValue {
  int get value;

  /// Create a copy of DefaultValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DefaultValueCopyWith<DefaultValue> get copyWith =>
      _$DefaultValueCopyWithImpl<DefaultValue>(
          this as DefaultValue, _$identity);

  /// Serializes this DefaultValue to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DefaultValue &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'DefaultValue(value: $value)';
  }
}

/// @nodoc
abstract mixin class $DefaultValueCopyWith<$Res> {
  factory $DefaultValueCopyWith(
          DefaultValue value, $Res Function(DefaultValue) _then) =
      _$DefaultValueCopyWithImpl;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$DefaultValueCopyWithImpl<$Res> implements $DefaultValueCopyWith<$Res> {
  _$DefaultValueCopyWithImpl(this._self, this._then);

  final DefaultValue _self;
  final $Res Function(DefaultValue) _then;

  /// Create a copy of DefaultValue
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

/// Adds pattern-matching-related methods to [DefaultValue].
extension DefaultValuePatterns on DefaultValue {
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
    TResult Function(_DefaultValue value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DefaultValue() when $default != null:
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
    TResult Function(_DefaultValue value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DefaultValue():
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
    TResult? Function(_DefaultValue value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DefaultValue() when $default != null:
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
      case _DefaultValue() when $default != null:
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
      case _DefaultValue():
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
      case _DefaultValue() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DefaultValue implements DefaultValue {
  _DefaultValue([this.value = 42]);
  factory _DefaultValue.fromJson(Map<String, dynamic> json) =>
      _$DefaultValueFromJson(json);

  @override
  @JsonKey()
  final int value;

  /// Create a copy of DefaultValue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DefaultValueCopyWith<_DefaultValue> get copyWith =>
      __$DefaultValueCopyWithImpl<_DefaultValue>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DefaultValueToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DefaultValue &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'DefaultValue(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$DefaultValueCopyWith<$Res>
    implements $DefaultValueCopyWith<$Res> {
  factory _$DefaultValueCopyWith(
          _DefaultValue value, $Res Function(_DefaultValue) _then) =
      __$DefaultValueCopyWithImpl;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$DefaultValueCopyWithImpl<$Res>
    implements _$DefaultValueCopyWith<$Res> {
  __$DefaultValueCopyWithImpl(this._self, this._then);

  final _DefaultValue _self;
  final $Res Function(_DefaultValue) _then;

  /// Create a copy of DefaultValue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_DefaultValue(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$DefaultValueJsonKey {
  @JsonKey(defaultValue: 21)
  int get value;

  /// Create a copy of DefaultValueJsonKey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DefaultValueJsonKeyCopyWith<DefaultValueJsonKey> get copyWith =>
      _$DefaultValueJsonKeyCopyWithImpl<DefaultValueJsonKey>(
          this as DefaultValueJsonKey, _$identity);

  /// Serializes this DefaultValueJsonKey to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DefaultValueJsonKey &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'DefaultValueJsonKey(value: $value)';
  }
}

/// @nodoc
abstract mixin class $DefaultValueJsonKeyCopyWith<$Res> {
  factory $DefaultValueJsonKeyCopyWith(
          DefaultValueJsonKey value, $Res Function(DefaultValueJsonKey) _then) =
      _$DefaultValueJsonKeyCopyWithImpl;
  @useResult
  $Res call({@JsonKey(defaultValue: 21) int value});
}

/// @nodoc
class _$DefaultValueJsonKeyCopyWithImpl<$Res>
    implements $DefaultValueJsonKeyCopyWith<$Res> {
  _$DefaultValueJsonKeyCopyWithImpl(this._self, this._then);

  final DefaultValueJsonKey _self;
  final $Res Function(DefaultValueJsonKey) _then;

  /// Create a copy of DefaultValueJsonKey
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

/// Adds pattern-matching-related methods to [DefaultValueJsonKey].
extension DefaultValueJsonKeyPatterns on DefaultValueJsonKey {
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
    TResult Function(_DefaultValueJsonKey value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DefaultValueJsonKey() when $default != null:
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
    TResult Function(_DefaultValueJsonKey value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DefaultValueJsonKey():
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
    TResult? Function(_DefaultValueJsonKey value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DefaultValueJsonKey() when $default != null:
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
    TResult Function(@JsonKey(defaultValue: 21) int value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DefaultValueJsonKey() when $default != null:
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
    TResult Function(@JsonKey(defaultValue: 21) int value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DefaultValueJsonKey():
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
    TResult? Function(@JsonKey(defaultValue: 21) int value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DefaultValueJsonKey() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DefaultValueJsonKey implements DefaultValueJsonKey {
  _DefaultValueJsonKey([@JsonKey(defaultValue: 21) this.value = 42]);
  factory _DefaultValueJsonKey.fromJson(Map<String, dynamic> json) =>
      _$DefaultValueJsonKeyFromJson(json);

  @override
  @JsonKey(defaultValue: 21)
  final int value;

  /// Create a copy of DefaultValueJsonKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DefaultValueJsonKeyCopyWith<_DefaultValueJsonKey> get copyWith =>
      __$DefaultValueJsonKeyCopyWithImpl<_DefaultValueJsonKey>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DefaultValueJsonKeyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DefaultValueJsonKey &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'DefaultValueJsonKey(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$DefaultValueJsonKeyCopyWith<$Res>
    implements $DefaultValueJsonKeyCopyWith<$Res> {
  factory _$DefaultValueJsonKeyCopyWith(_DefaultValueJsonKey value,
          $Res Function(_DefaultValueJsonKey) _then) =
      __$DefaultValueJsonKeyCopyWithImpl;
  @override
  @useResult
  $Res call({@JsonKey(defaultValue: 21) int value});
}

/// @nodoc
class __$DefaultValueJsonKeyCopyWithImpl<$Res>
    implements _$DefaultValueJsonKeyCopyWith<$Res> {
  __$DefaultValueJsonKeyCopyWithImpl(this._self, this._then);

  final _DefaultValueJsonKey _self;
  final $Res Function(_DefaultValueJsonKey) _then;

  /// Create a copy of DefaultValueJsonKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_DefaultValueJsonKey(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

ClassDecorator _$ClassDecoratorFromJson(Map<String, dynamic> json) {
  return ClassDecoratorDefault.fromJson(json);
}

/// @nodoc
mixin _$ClassDecorator {
  String get complexName;

  /// Create a copy of ClassDecorator
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ClassDecoratorCopyWith<ClassDecorator> get copyWith =>
      _$ClassDecoratorCopyWithImpl<ClassDecorator>(
          this as ClassDecorator, _$identity);

  /// Serializes this ClassDecorator to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ClassDecorator &&
            (identical(other.complexName, complexName) ||
                other.complexName == complexName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, complexName);

  @override
  String toString() {
    return 'ClassDecorator(complexName: $complexName)';
  }
}

/// @nodoc
abstract mixin class $ClassDecoratorCopyWith<$Res> {
  factory $ClassDecoratorCopyWith(
          ClassDecorator value, $Res Function(ClassDecorator) _then) =
      _$ClassDecoratorCopyWithImpl;
  @useResult
  $Res call({String complexName});
}

/// @nodoc
class _$ClassDecoratorCopyWithImpl<$Res>
    implements $ClassDecoratorCopyWith<$Res> {
  _$ClassDecoratorCopyWithImpl(this._self, this._then);

  final ClassDecorator _self;
  final $Res Function(ClassDecorator) _then;

  /// Create a copy of ClassDecorator
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? complexName = null,
  }) {
    return _then(_self.copyWith(
      complexName: null == complexName
          ? _self.complexName
          : complexName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ClassDecorator].
extension ClassDecoratorPatterns on ClassDecorator {
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
    TResult Function(ClassDecoratorDefault value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ClassDecoratorDefault() when $default != null:
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
    TResult Function(ClassDecoratorDefault value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case ClassDecoratorDefault():
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
    TResult? Function(ClassDecoratorDefault value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case ClassDecoratorDefault() when $default != null:
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
    TResult Function(String complexName)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ClassDecoratorDefault() when $default != null:
        return $default(_that.complexName);
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
    TResult Function(String complexName) $default,
  ) {
    final _that = this;
    switch (_that) {
      case ClassDecoratorDefault():
        return $default(_that.complexName);
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
    TResult? Function(String complexName)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case ClassDecoratorDefault() when $default != null:
        return $default(_that.complexName);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class ClassDecoratorDefault implements ClassDecorator {
  const ClassDecoratorDefault(this.complexName);
  factory ClassDecoratorDefault.fromJson(Map<String, dynamic> json) =>
      _$ClassDecoratorDefaultFromJson(json);

  @override
  final String complexName;

  /// Create a copy of ClassDecorator
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ClassDecoratorDefaultCopyWith<ClassDecoratorDefault> get copyWith =>
      _$ClassDecoratorDefaultCopyWithImpl<ClassDecoratorDefault>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ClassDecoratorDefaultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ClassDecoratorDefault &&
            (identical(other.complexName, complexName) ||
                other.complexName == complexName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, complexName);

  @override
  String toString() {
    return 'ClassDecorator(complexName: $complexName)';
  }
}

/// @nodoc
abstract mixin class $ClassDecoratorDefaultCopyWith<$Res>
    implements $ClassDecoratorCopyWith<$Res> {
  factory $ClassDecoratorDefaultCopyWith(ClassDecoratorDefault value,
          $Res Function(ClassDecoratorDefault) _then) =
      _$ClassDecoratorDefaultCopyWithImpl;
  @override
  @useResult
  $Res call({String complexName});
}

/// @nodoc
class _$ClassDecoratorDefaultCopyWithImpl<$Res>
    implements $ClassDecoratorDefaultCopyWith<$Res> {
  _$ClassDecoratorDefaultCopyWithImpl(this._self, this._then);

  final ClassDecoratorDefault _self;
  final $Res Function(ClassDecoratorDefault) _then;

  /// Create a copy of ClassDecorator
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? complexName = null,
  }) {
    return _then(ClassDecoratorDefault(
      null == complexName
          ? _self.complexName
          : complexName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

DurationValue _$DurationValueFromJson(Map<String, dynamic> json) {
  return DurationValueDefault.fromJson(json);
}

/// @nodoc
mixin _$DurationValue {
  Duration get complexName;

  /// Create a copy of DurationValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DurationValueCopyWith<DurationValue> get copyWith =>
      _$DurationValueCopyWithImpl<DurationValue>(
          this as DurationValue, _$identity);

  /// Serializes this DurationValue to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DurationValue &&
            (identical(other.complexName, complexName) ||
                other.complexName == complexName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, complexName);

  @override
  String toString() {
    return 'DurationValue(complexName: $complexName)';
  }
}

/// @nodoc
abstract mixin class $DurationValueCopyWith<$Res> {
  factory $DurationValueCopyWith(
          DurationValue value, $Res Function(DurationValue) _then) =
      _$DurationValueCopyWithImpl;
  @useResult
  $Res call({Duration complexName});
}

/// @nodoc
class _$DurationValueCopyWithImpl<$Res>
    implements $DurationValueCopyWith<$Res> {
  _$DurationValueCopyWithImpl(this._self, this._then);

  final DurationValue _self;
  final $Res Function(DurationValue) _then;

  /// Create a copy of DurationValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? complexName = null,
  }) {
    return _then(_self.copyWith(
      complexName: null == complexName
          ? _self.complexName
          : complexName // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// Adds pattern-matching-related methods to [DurationValue].
extension DurationValuePatterns on DurationValue {
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
    TResult Function(DurationValueDefault value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case DurationValueDefault() when $default != null:
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
    TResult Function(DurationValueDefault value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case DurationValueDefault():
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
    TResult? Function(DurationValueDefault value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case DurationValueDefault() when $default != null:
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
    TResult Function(Duration complexName)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case DurationValueDefault() when $default != null:
        return $default(_that.complexName);
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
    TResult Function(Duration complexName) $default,
  ) {
    final _that = this;
    switch (_that) {
      case DurationValueDefault():
        return $default(_that.complexName);
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
    TResult? Function(Duration complexName)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case DurationValueDefault() when $default != null:
        return $default(_that.complexName);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class DurationValueDefault implements DurationValue {
  const DurationValueDefault(this.complexName);
  factory DurationValueDefault.fromJson(Map<String, dynamic> json) =>
      _$DurationValueDefaultFromJson(json);

  @override
  final Duration complexName;

  /// Create a copy of DurationValue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DurationValueDefaultCopyWith<DurationValueDefault> get copyWith =>
      _$DurationValueDefaultCopyWithImpl<DurationValueDefault>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DurationValueDefaultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DurationValueDefault &&
            (identical(other.complexName, complexName) ||
                other.complexName == complexName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, complexName);

  @override
  String toString() {
    return 'DurationValue(complexName: $complexName)';
  }
}

/// @nodoc
abstract mixin class $DurationValueDefaultCopyWith<$Res>
    implements $DurationValueCopyWith<$Res> {
  factory $DurationValueDefaultCopyWith(DurationValueDefault value,
          $Res Function(DurationValueDefault) _then) =
      _$DurationValueDefaultCopyWithImpl;
  @override
  @useResult
  $Res call({Duration complexName});
}

/// @nodoc
class _$DurationValueDefaultCopyWithImpl<$Res>
    implements $DurationValueDefaultCopyWith<$Res> {
  _$DurationValueDefaultCopyWithImpl(this._self, this._then);

  final DurationValueDefault _self;
  final $Res Function(DurationValueDefault) _then;

  /// Create a copy of DurationValue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? complexName = null,
  }) {
    return _then(DurationValueDefault(
      null == complexName
          ? _self.complexName
          : complexName // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
mixin _$EnumJson {
  @JsonKey(
      disallowNullValue: true,
      required: true,
      unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
  Enum? get status;

  /// Create a copy of EnumJson
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EnumJsonCopyWith<EnumJson> get copyWith =>
      _$EnumJsonCopyWithImpl<EnumJson>(this as EnumJson, _$identity);

  /// Serializes this EnumJson to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EnumJson &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status);

  @override
  String toString() {
    return 'EnumJson(status: $status)';
  }
}

/// @nodoc
abstract mixin class $EnumJsonCopyWith<$Res> {
  factory $EnumJsonCopyWith(EnumJson value, $Res Function(EnumJson) _then) =
      _$EnumJsonCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(
          disallowNullValue: true,
          required: true,
          unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
      Enum? status});
}

/// @nodoc
class _$EnumJsonCopyWithImpl<$Res> implements $EnumJsonCopyWith<$Res> {
  _$EnumJsonCopyWithImpl(this._self, this._then);

  final EnumJson _self;
  final $Res Function(EnumJson) _then;

  /// Create a copy of EnumJson
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
  }) {
    return _then(_self.copyWith(
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as Enum?,
    ));
  }
}

/// Adds pattern-matching-related methods to [EnumJson].
extension EnumJsonPatterns on EnumJson {
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
    TResult Function(_EnumJson value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EnumJson() when $default != null:
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
    TResult Function(_EnumJson value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EnumJson():
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
    TResult? Function(_EnumJson value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EnumJson() when $default != null:
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
            @JsonKey(
                disallowNullValue: true,
                required: true,
                unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
            Enum? status)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EnumJson() when $default != null:
        return $default(_that.status);
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
            @JsonKey(
                disallowNullValue: true,
                required: true,
                unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
            Enum? status)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EnumJson():
        return $default(_that.status);
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
            @JsonKey(
                disallowNullValue: true,
                required: true,
                unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
            Enum? status)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EnumJson() when $default != null:
        return $default(_that.status);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _EnumJson implements EnumJson {
  _EnumJson(
      {@JsonKey(
          disallowNullValue: true,
          required: true,
          unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
      this.status});
  factory _EnumJson.fromJson(Map<String, dynamic> json) =>
      _$EnumJsonFromJson(json);

  @override
  @JsonKey(
      disallowNullValue: true,
      required: true,
      unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
  final Enum? status;

  /// Create a copy of EnumJson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EnumJsonCopyWith<_EnumJson> get copyWith =>
      __$EnumJsonCopyWithImpl<_EnumJson>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EnumJsonToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EnumJson &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status);

  @override
  String toString() {
    return 'EnumJson(status: $status)';
  }
}

/// @nodoc
abstract mixin class _$EnumJsonCopyWith<$Res>
    implements $EnumJsonCopyWith<$Res> {
  factory _$EnumJsonCopyWith(_EnumJson value, $Res Function(_EnumJson) _then) =
      __$EnumJsonCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(
          disallowNullValue: true,
          required: true,
          unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
      Enum? status});
}

/// @nodoc
class __$EnumJsonCopyWithImpl<$Res> implements _$EnumJsonCopyWith<$Res> {
  __$EnumJsonCopyWithImpl(this._self, this._then);

  final _EnumJson _self;
  final $Res Function(_EnumJson) _then;

  /// Create a copy of EnumJson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = freezed,
  }) {
    return _then(_EnumJson(
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as Enum?,
    ));
  }
}

/// @nodoc
mixin _$GenericWithArgumentFactories<T> {
  T get value;
  String get value2;

  /// Create a copy of GenericWithArgumentFactories
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GenericWithArgumentFactoriesCopyWith<T, GenericWithArgumentFactories<T>>
      get copyWith => _$GenericWithArgumentFactoriesCopyWithImpl<T,
              GenericWithArgumentFactories<T>>(
          this as GenericWithArgumentFactories<T>, _$identity);

  /// Serializes this GenericWithArgumentFactories to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GenericWithArgumentFactories<T> &&
            const DeepCollectionEquality().equals(other.value, value) &&
            (identical(other.value2, value2) || other.value2 == value2));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(value), value2);

  @override
  String toString() {
    return 'GenericWithArgumentFactories<$T>(value: $value, value2: $value2)';
  }
}

/// @nodoc
abstract mixin class $GenericWithArgumentFactoriesCopyWith<T, $Res> {
  factory $GenericWithArgumentFactoriesCopyWith(
          GenericWithArgumentFactories<T> value,
          $Res Function(GenericWithArgumentFactories<T>) _then) =
      _$GenericWithArgumentFactoriesCopyWithImpl;
  @useResult
  $Res call({T value, String value2});
}

/// @nodoc
class _$GenericWithArgumentFactoriesCopyWithImpl<T, $Res>
    implements $GenericWithArgumentFactoriesCopyWith<T, $Res> {
  _$GenericWithArgumentFactoriesCopyWithImpl(this._self, this._then);

  final GenericWithArgumentFactories<T> _self;
  final $Res Function(GenericWithArgumentFactories<T>) _then;

  /// Create a copy of GenericWithArgumentFactories
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? value2 = null,
  }) {
    return _then(_self.copyWith(
      value: freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
      value2: null == value2
          ? _self.value2
          : value2 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [GenericWithArgumentFactories].
extension GenericWithArgumentFactoriesPatterns<T>
    on GenericWithArgumentFactories<T> {
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
    TResult Function(_GenericWithArgumentFactories<T> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GenericWithArgumentFactories() when $default != null:
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
    TResult Function(_GenericWithArgumentFactories<T> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenericWithArgumentFactories():
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
    TResult? Function(_GenericWithArgumentFactories<T> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenericWithArgumentFactories() when $default != null:
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
    TResult Function(T value, String value2)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GenericWithArgumentFactories() when $default != null:
        return $default(_that.value, _that.value2);
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
    TResult Function(T value, String value2) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenericWithArgumentFactories():
        return $default(_that.value, _that.value2);
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
    TResult? Function(T value, String value2)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenericWithArgumentFactories() when $default != null:
        return $default(_that.value, _that.value2);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _GenericWithArgumentFactories<T>
    implements GenericWithArgumentFactories<T> {
  _GenericWithArgumentFactories(this.value, this.value2);
  factory _GenericWithArgumentFactories.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$GenericWithArgumentFactoriesFromJson(json, fromJsonT);

  @override
  final T value;
  @override
  final String value2;

  /// Create a copy of GenericWithArgumentFactories
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GenericWithArgumentFactoriesCopyWith<T, _GenericWithArgumentFactories<T>>
      get copyWith => __$GenericWithArgumentFactoriesCopyWithImpl<T,
          _GenericWithArgumentFactories<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$GenericWithArgumentFactoriesToJson<T>(this, toJsonT);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GenericWithArgumentFactories<T> &&
            const DeepCollectionEquality().equals(other.value, value) &&
            (identical(other.value2, value2) || other.value2 == value2));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(value), value2);

  @override
  String toString() {
    return 'GenericWithArgumentFactories<$T>(value: $value, value2: $value2)';
  }
}

/// @nodoc
abstract mixin class _$GenericWithArgumentFactoriesCopyWith<T, $Res>
    implements $GenericWithArgumentFactoriesCopyWith<T, $Res> {
  factory _$GenericWithArgumentFactoriesCopyWith(
          _GenericWithArgumentFactories<T> value,
          $Res Function(_GenericWithArgumentFactories<T>) _then) =
      __$GenericWithArgumentFactoriesCopyWithImpl;
  @override
  @useResult
  $Res call({T value, String value2});
}

/// @nodoc
class __$GenericWithArgumentFactoriesCopyWithImpl<T, $Res>
    implements _$GenericWithArgumentFactoriesCopyWith<T, $Res> {
  __$GenericWithArgumentFactoriesCopyWithImpl(this._self, this._then);

  final _GenericWithArgumentFactories<T> _self;
  final $Res Function(_GenericWithArgumentFactories<T>) _then;

  /// Create a copy of GenericWithArgumentFactories
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = freezed,
    Object? value2 = null,
  }) {
    return _then(_GenericWithArgumentFactories<T>(
      freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
      null == value2
          ? _self.value2
          : value2 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$GenericTupleWithArgumentFactories<T, S> {
  T get value1;
  S get value2;
  String get value3;

  /// Create a copy of GenericTupleWithArgumentFactories
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GenericTupleWithArgumentFactoriesCopyWith<T, S,
          GenericTupleWithArgumentFactories<T, S>>
      get copyWith => _$GenericTupleWithArgumentFactoriesCopyWithImpl<T, S,
              GenericTupleWithArgumentFactories<T, S>>(
          this as GenericTupleWithArgumentFactories<T, S>, _$identity);

  /// Serializes this GenericTupleWithArgumentFactories to a JSON map.
  Map<String, dynamic> toJson(
      Object? Function(T) toJsonT, Object? Function(S) toJsonS);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GenericTupleWithArgumentFactories<T, S> &&
            const DeepCollectionEquality().equals(other.value1, value1) &&
            const DeepCollectionEquality().equals(other.value2, value2) &&
            (identical(other.value3, value3) || other.value3 == value3));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(value1),
      const DeepCollectionEquality().hash(value2),
      value3);

  @override
  String toString() {
    return 'GenericTupleWithArgumentFactories<$T, $S>(value1: $value1, value2: $value2, value3: $value3)';
  }
}

/// @nodoc
abstract mixin class $GenericTupleWithArgumentFactoriesCopyWith<T, S, $Res> {
  factory $GenericTupleWithArgumentFactoriesCopyWith(
          GenericTupleWithArgumentFactories<T, S> value,
          $Res Function(GenericTupleWithArgumentFactories<T, S>) _then) =
      _$GenericTupleWithArgumentFactoriesCopyWithImpl;
  @useResult
  $Res call({T value1, S value2, String value3});
}

/// @nodoc
class _$GenericTupleWithArgumentFactoriesCopyWithImpl<T, S, $Res>
    implements $GenericTupleWithArgumentFactoriesCopyWith<T, S, $Res> {
  _$GenericTupleWithArgumentFactoriesCopyWithImpl(this._self, this._then);

  final GenericTupleWithArgumentFactories<T, S> _self;
  final $Res Function(GenericTupleWithArgumentFactories<T, S>) _then;

  /// Create a copy of GenericTupleWithArgumentFactories
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value1 = freezed,
    Object? value2 = freezed,
    Object? value3 = null,
  }) {
    return _then(_self.copyWith(
      value1: freezed == value1
          ? _self.value1
          : value1 // ignore: cast_nullable_to_non_nullable
              as T,
      value2: freezed == value2
          ? _self.value2
          : value2 // ignore: cast_nullable_to_non_nullable
              as S,
      value3: null == value3
          ? _self.value3
          : value3 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [GenericTupleWithArgumentFactories].
extension GenericTupleWithArgumentFactoriesPatterns<T, S>
    on GenericTupleWithArgumentFactories<T, S> {
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
    TResult Function(_GenericTupleWithArgumentFactories<T, S> value)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GenericTupleWithArgumentFactories() when $default != null:
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
    TResult Function(_GenericTupleWithArgumentFactories<T, S> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenericTupleWithArgumentFactories():
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
    TResult? Function(_GenericTupleWithArgumentFactories<T, S> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenericTupleWithArgumentFactories() when $default != null:
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
    TResult Function(T value1, S value2, String value3)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GenericTupleWithArgumentFactories() when $default != null:
        return $default(_that.value1, _that.value2, _that.value3);
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
    TResult Function(T value1, S value2, String value3) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenericTupleWithArgumentFactories():
        return $default(_that.value1, _that.value2, _that.value3);
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
    TResult? Function(T value1, S value2, String value3)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenericTupleWithArgumentFactories() when $default != null:
        return $default(_that.value1, _that.value2, _that.value3);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _GenericTupleWithArgumentFactories<T, S>
    implements GenericTupleWithArgumentFactories<T, S> {
  _GenericTupleWithArgumentFactories(this.value1, this.value2, this.value3);
  factory _GenericTupleWithArgumentFactories.fromJson(Map<String, dynamic> json,
          T Function(Object?) fromJsonT, S Function(Object?) fromJsonS) =>
      _$GenericTupleWithArgumentFactoriesFromJson(json, fromJsonT, fromJsonS);

  @override
  final T value1;
  @override
  final S value2;
  @override
  final String value3;

  /// Create a copy of GenericTupleWithArgumentFactories
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GenericTupleWithArgumentFactoriesCopyWith<T, S,
          _GenericTupleWithArgumentFactories<T, S>>
      get copyWith => __$GenericTupleWithArgumentFactoriesCopyWithImpl<T, S,
          _GenericTupleWithArgumentFactories<T, S>>(this, _$identity);

  @override
  Map<String, dynamic> toJson(
      Object? Function(T) toJsonT, Object? Function(S) toJsonS) {
    return _$GenericTupleWithArgumentFactoriesToJson<T, S>(
        this, toJsonT, toJsonS);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GenericTupleWithArgumentFactories<T, S> &&
            const DeepCollectionEquality().equals(other.value1, value1) &&
            const DeepCollectionEquality().equals(other.value2, value2) &&
            (identical(other.value3, value3) || other.value3 == value3));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(value1),
      const DeepCollectionEquality().hash(value2),
      value3);

  @override
  String toString() {
    return 'GenericTupleWithArgumentFactories<$T, $S>(value1: $value1, value2: $value2, value3: $value3)';
  }
}

/// @nodoc
abstract mixin class _$GenericTupleWithArgumentFactoriesCopyWith<T, S, $Res>
    implements $GenericTupleWithArgumentFactoriesCopyWith<T, S, $Res> {
  factory _$GenericTupleWithArgumentFactoriesCopyWith(
          _GenericTupleWithArgumentFactories<T, S> value,
          $Res Function(_GenericTupleWithArgumentFactories<T, S>) _then) =
      __$GenericTupleWithArgumentFactoriesCopyWithImpl;
  @override
  @useResult
  $Res call({T value1, S value2, String value3});
}

/// @nodoc
class __$GenericTupleWithArgumentFactoriesCopyWithImpl<T, S, $Res>
    implements _$GenericTupleWithArgumentFactoriesCopyWith<T, S, $Res> {
  __$GenericTupleWithArgumentFactoriesCopyWithImpl(this._self, this._then);

  final _GenericTupleWithArgumentFactories<T, S> _self;
  final $Res Function(_GenericTupleWithArgumentFactories<T, S>) _then;

  /// Create a copy of GenericTupleWithArgumentFactories
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value1 = freezed,
    Object? value2 = freezed,
    Object? value3 = null,
  }) {
    return _then(_GenericTupleWithArgumentFactories<T, S>(
      freezed == value1
          ? _self.value1
          : value1 // ignore: cast_nullable_to_non_nullable
              as T,
      freezed == value2
          ? _self.value2
          : value2 // ignore: cast_nullable_to_non_nullable
              as S,
      null == value3
          ? _self.value3
          : value3 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

GenericMultiCtorWithArgumentFactories<T, S>
    _$GenericMultiCtorWithArgumentFactoriesFromJson<T, S>(
        Map<String, dynamic> json,
        T Function(Object?) fromJsonT,
        S Function(Object?) fromJsonS) {
  switch (json['runtimeType']) {
    case 'default':
      return _GenericMultiCtorWithArgumentFactoriesDefault<T, S>.fromJson(
          json, fromJsonT, fromJsonS);
    case 'first':
      return _GenericMultiCtorWithArgumentFactoriesVal<T, S>.fromJson(
          json, fromJsonT, fromJsonS);
    case 'second':
      return _GenericMultiCtorWithArgumentFactoriesSec<T, S>.fromJson(
          json, fromJsonT, fromJsonS);
    case 'both':
      return _GenericMultiCtorWithArgumentFactoriesBoth<T, S>.fromJson(
          json, fromJsonT, fromJsonS);
    case 'none':
      return _GenericMultiCtorWithArgumentFactoriesNone<T, S>.fromJson(
          json, fromJsonT, fromJsonS);

    default:
      throw CheckedFromJsonException(
          json,
          'runtimeType',
          'GenericMultiCtorWithArgumentFactories',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$GenericMultiCtorWithArgumentFactories<T, S> {
  String get another;

  /// Create a copy of GenericMultiCtorWithArgumentFactories
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GenericMultiCtorWithArgumentFactoriesCopyWith<T, S,
          GenericMultiCtorWithArgumentFactories<T, S>>
      get copyWith => _$GenericMultiCtorWithArgumentFactoriesCopyWithImpl<T, S,
              GenericMultiCtorWithArgumentFactories<T, S>>(
          this as GenericMultiCtorWithArgumentFactories<T, S>, _$identity);

  /// Serializes this GenericMultiCtorWithArgumentFactories to a JSON map.
  Map<String, dynamic> toJson(
      Object? Function(T) toJsonT, Object? Function(S) toJsonS);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GenericMultiCtorWithArgumentFactories<T, S> &&
            (identical(other.another, another) || other.another == another));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, another);

  @override
  String toString() {
    return 'GenericMultiCtorWithArgumentFactories<$T, $S>(another: $another)';
  }
}

/// @nodoc
abstract mixin class $GenericMultiCtorWithArgumentFactoriesCopyWith<T, S,
    $Res> {
  factory $GenericMultiCtorWithArgumentFactoriesCopyWith(
          GenericMultiCtorWithArgumentFactories<T, S> value,
          $Res Function(GenericMultiCtorWithArgumentFactories<T, S>) _then) =
      _$GenericMultiCtorWithArgumentFactoriesCopyWithImpl;
  @useResult
  $Res call({String another});
}

/// @nodoc
class _$GenericMultiCtorWithArgumentFactoriesCopyWithImpl<T, S, $Res>
    implements $GenericMultiCtorWithArgumentFactoriesCopyWith<T, S, $Res> {
  _$GenericMultiCtorWithArgumentFactoriesCopyWithImpl(this._self, this._then);

  final GenericMultiCtorWithArgumentFactories<T, S> _self;
  final $Res Function(GenericMultiCtorWithArgumentFactories<T, S>) _then;

  /// Create a copy of GenericMultiCtorWithArgumentFactories
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? another = null,
  }) {
    return _then(_self.copyWith(
      another: null == another
          ? _self.another
          : another // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [GenericMultiCtorWithArgumentFactories].
extension GenericMultiCtorWithArgumentFactoriesPatterns<T, S>
    on GenericMultiCtorWithArgumentFactories<T, S> {
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
    TResult Function(_GenericMultiCtorWithArgumentFactoriesDefault<T, S> value)?
        $default, {
    TResult Function(_GenericMultiCtorWithArgumentFactoriesVal<T, S> value)?
        first,
    TResult Function(_GenericMultiCtorWithArgumentFactoriesSec<T, S> value)?
        second,
    TResult Function(_GenericMultiCtorWithArgumentFactoriesBoth<T, S> value)?
        both,
    TResult Function(_GenericMultiCtorWithArgumentFactoriesNone<T, S> value)?
        none,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GenericMultiCtorWithArgumentFactoriesDefault()
          when $default != null:
        return $default(_that);
      case _GenericMultiCtorWithArgumentFactoriesVal() when first != null:
        return first(_that);
      case _GenericMultiCtorWithArgumentFactoriesSec() when second != null:
        return second(_that);
      case _GenericMultiCtorWithArgumentFactoriesBoth() when both != null:
        return both(_that);
      case _GenericMultiCtorWithArgumentFactoriesNone() when none != null:
        return none(_that);
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
    TResult Function(_GenericMultiCtorWithArgumentFactoriesDefault<T, S> value)
        $default, {
    required TResult Function(
            _GenericMultiCtorWithArgumentFactoriesVal<T, S> value)
        first,
    required TResult Function(
            _GenericMultiCtorWithArgumentFactoriesSec<T, S> value)
        second,
    required TResult Function(
            _GenericMultiCtorWithArgumentFactoriesBoth<T, S> value)
        both,
    required TResult Function(
            _GenericMultiCtorWithArgumentFactoriesNone<T, S> value)
        none,
  }) {
    final _that = this;
    switch (_that) {
      case _GenericMultiCtorWithArgumentFactoriesDefault():
        return $default(_that);
      case _GenericMultiCtorWithArgumentFactoriesVal():
        return first(_that);
      case _GenericMultiCtorWithArgumentFactoriesSec():
        return second(_that);
      case _GenericMultiCtorWithArgumentFactoriesBoth():
        return both(_that);
      case _GenericMultiCtorWithArgumentFactoriesNone():
        return none(_that);
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
    TResult? Function(
            _GenericMultiCtorWithArgumentFactoriesDefault<T, S> value)?
        $default, {
    TResult? Function(_GenericMultiCtorWithArgumentFactoriesVal<T, S> value)?
        first,
    TResult? Function(_GenericMultiCtorWithArgumentFactoriesSec<T, S> value)?
        second,
    TResult? Function(_GenericMultiCtorWithArgumentFactoriesBoth<T, S> value)?
        both,
    TResult? Function(_GenericMultiCtorWithArgumentFactoriesNone<T, S> value)?
        none,
  }) {
    final _that = this;
    switch (_that) {
      case _GenericMultiCtorWithArgumentFactoriesDefault()
          when $default != null:
        return $default(_that);
      case _GenericMultiCtorWithArgumentFactoriesVal() when first != null:
        return first(_that);
      case _GenericMultiCtorWithArgumentFactoriesSec() when second != null:
        return second(_that);
      case _GenericMultiCtorWithArgumentFactoriesBoth() when both != null:
        return both(_that);
      case _GenericMultiCtorWithArgumentFactoriesNone() when none != null:
        return none(_that);
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
    TResult Function(T first, S second, String another)? $default, {
    TResult Function(T first, String another)? first,
    TResult Function(S second, String another)? second,
    TResult Function(T first, S second, String another)? both,
    TResult Function(String another)? none,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GenericMultiCtorWithArgumentFactoriesDefault()
          when $default != null:
        return $default(_that.first, _that.second, _that.another);
      case _GenericMultiCtorWithArgumentFactoriesVal() when first != null:
        return first(_that.first, _that.another);
      case _GenericMultiCtorWithArgumentFactoriesSec() when second != null:
        return second(_that.second, _that.another);
      case _GenericMultiCtorWithArgumentFactoriesBoth() when both != null:
        return both(_that.first, _that.second, _that.another);
      case _GenericMultiCtorWithArgumentFactoriesNone() when none != null:
        return none(_that.another);
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
    TResult Function(T first, S second, String another) $default, {
    required TResult Function(T first, String another) first,
    required TResult Function(S second, String another) second,
    required TResult Function(T first, S second, String another) both,
    required TResult Function(String another) none,
  }) {
    final _that = this;
    switch (_that) {
      case _GenericMultiCtorWithArgumentFactoriesDefault():
        return $default(_that.first, _that.second, _that.another);
      case _GenericMultiCtorWithArgumentFactoriesVal():
        return first(_that.first, _that.another);
      case _GenericMultiCtorWithArgumentFactoriesSec():
        return second(_that.second, _that.another);
      case _GenericMultiCtorWithArgumentFactoriesBoth():
        return both(_that.first, _that.second, _that.another);
      case _GenericMultiCtorWithArgumentFactoriesNone():
        return none(_that.another);
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
    TResult? Function(T first, S second, String another)? $default, {
    TResult? Function(T first, String another)? first,
    TResult? Function(S second, String another)? second,
    TResult? Function(T first, S second, String another)? both,
    TResult? Function(String another)? none,
  }) {
    final _that = this;
    switch (_that) {
      case _GenericMultiCtorWithArgumentFactoriesDefault()
          when $default != null:
        return $default(_that.first, _that.second, _that.another);
      case _GenericMultiCtorWithArgumentFactoriesVal() when first != null:
        return first(_that.first, _that.another);
      case _GenericMultiCtorWithArgumentFactoriesSec() when second != null:
        return second(_that.second, _that.another);
      case _GenericMultiCtorWithArgumentFactoriesBoth() when both != null:
        return both(_that.first, _that.second, _that.another);
      case _GenericMultiCtorWithArgumentFactoriesNone() when none != null:
        return none(_that.another);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _GenericMultiCtorWithArgumentFactoriesDefault<T, S>
    implements GenericMultiCtorWithArgumentFactories<T, S> {
  _GenericMultiCtorWithArgumentFactoriesDefault(
      this.first, this.second, this.another,
      {final String? $type})
      : $type = $type ?? 'default';
  factory _GenericMultiCtorWithArgumentFactoriesDefault.fromJson(
          Map<String, dynamic> json,
          T Function(Object?) fromJsonT,
          S Function(Object?) fromJsonS) =>
      _$GenericMultiCtorWithArgumentFactoriesDefaultFromJson(
          json, fromJsonT, fromJsonS);

  final T first;
  final S second;
  @override
  final String another;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of GenericMultiCtorWithArgumentFactories
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GenericMultiCtorWithArgumentFactoriesDefaultCopyWith<T, S,
          _GenericMultiCtorWithArgumentFactoriesDefault<T, S>>
      get copyWith =>
          __$GenericMultiCtorWithArgumentFactoriesDefaultCopyWithImpl<T, S,
                  _GenericMultiCtorWithArgumentFactoriesDefault<T, S>>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson(
      Object? Function(T) toJsonT, Object? Function(S) toJsonS) {
    return _$GenericMultiCtorWithArgumentFactoriesDefaultToJson<T, S>(
        this, toJsonT, toJsonS);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GenericMultiCtorWithArgumentFactoriesDefault<T, S> &&
            const DeepCollectionEquality().equals(other.first, first) &&
            const DeepCollectionEquality().equals(other.second, second) &&
            (identical(other.another, another) || other.another == another));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(first),
      const DeepCollectionEquality().hash(second),
      another);

  @override
  String toString() {
    return 'GenericMultiCtorWithArgumentFactories<$T, $S>(first: $first, second: $second, another: $another)';
  }
}

/// @nodoc
abstract mixin class _$GenericMultiCtorWithArgumentFactoriesDefaultCopyWith<T,
        S, $Res>
    implements $GenericMultiCtorWithArgumentFactoriesCopyWith<T, S, $Res> {
  factory _$GenericMultiCtorWithArgumentFactoriesDefaultCopyWith(
      _GenericMultiCtorWithArgumentFactoriesDefault<T, S> value,
      $Res Function(_GenericMultiCtorWithArgumentFactoriesDefault<T, S>)
          _then) = __$GenericMultiCtorWithArgumentFactoriesDefaultCopyWithImpl;
  @override
  @useResult
  $Res call({T first, S second, String another});
}

/// @nodoc
class __$GenericMultiCtorWithArgumentFactoriesDefaultCopyWithImpl<T, S, $Res>
    implements
        _$GenericMultiCtorWithArgumentFactoriesDefaultCopyWith<T, S, $Res> {
  __$GenericMultiCtorWithArgumentFactoriesDefaultCopyWithImpl(
      this._self, this._then);

  final _GenericMultiCtorWithArgumentFactoriesDefault<T, S> _self;
  final $Res Function(_GenericMultiCtorWithArgumentFactoriesDefault<T, S>)
      _then;

  /// Create a copy of GenericMultiCtorWithArgumentFactories
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? first = freezed,
    Object? second = freezed,
    Object? another = null,
  }) {
    return _then(_GenericMultiCtorWithArgumentFactoriesDefault<T, S>(
      freezed == first
          ? _self.first
          : first // ignore: cast_nullable_to_non_nullable
              as T,
      freezed == second
          ? _self.second
          : second // ignore: cast_nullable_to_non_nullable
              as S,
      null == another
          ? _self.another
          : another // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _GenericMultiCtorWithArgumentFactoriesVal<T, S>
    implements GenericMultiCtorWithArgumentFactories<T, S> {
  _GenericMultiCtorWithArgumentFactoriesVal(this.first, this.another,
      {final String? $type})
      : $type = $type ?? 'first';
  factory _GenericMultiCtorWithArgumentFactoriesVal.fromJson(
          Map<String, dynamic> json,
          T Function(Object?) fromJsonT,
          S Function(Object?) fromJsonS) =>
      _$GenericMultiCtorWithArgumentFactoriesValFromJson(
          json, fromJsonT, fromJsonS);

  final T first;
  @override
  final String another;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of GenericMultiCtorWithArgumentFactories
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GenericMultiCtorWithArgumentFactoriesValCopyWith<T, S,
          _GenericMultiCtorWithArgumentFactoriesVal<T, S>>
      get copyWith => __$GenericMultiCtorWithArgumentFactoriesValCopyWithImpl<T,
          S, _GenericMultiCtorWithArgumentFactoriesVal<T, S>>(this, _$identity);

  @override
  Map<String, dynamic> toJson(
      Object? Function(T) toJsonT, Object? Function(S) toJsonS) {
    return _$GenericMultiCtorWithArgumentFactoriesValToJson<T, S>(
        this, toJsonT, toJsonS);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GenericMultiCtorWithArgumentFactoriesVal<T, S> &&
            const DeepCollectionEquality().equals(other.first, first) &&
            (identical(other.another, another) || other.another == another));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(first), another);

  @override
  String toString() {
    return 'GenericMultiCtorWithArgumentFactories<$T, $S>.first(first: $first, another: $another)';
  }
}

/// @nodoc
abstract mixin class _$GenericMultiCtorWithArgumentFactoriesValCopyWith<T, S,
        $Res>
    implements $GenericMultiCtorWithArgumentFactoriesCopyWith<T, S, $Res> {
  factory _$GenericMultiCtorWithArgumentFactoriesValCopyWith(
      _GenericMultiCtorWithArgumentFactoriesVal<T, S> value,
      $Res Function(_GenericMultiCtorWithArgumentFactoriesVal<T, S>)
          _then) = __$GenericMultiCtorWithArgumentFactoriesValCopyWithImpl;
  @override
  @useResult
  $Res call({T first, String another});
}

/// @nodoc
class __$GenericMultiCtorWithArgumentFactoriesValCopyWithImpl<T, S, $Res>
    implements _$GenericMultiCtorWithArgumentFactoriesValCopyWith<T, S, $Res> {
  __$GenericMultiCtorWithArgumentFactoriesValCopyWithImpl(
      this._self, this._then);

  final _GenericMultiCtorWithArgumentFactoriesVal<T, S> _self;
  final $Res Function(_GenericMultiCtorWithArgumentFactoriesVal<T, S>) _then;

  /// Create a copy of GenericMultiCtorWithArgumentFactories
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? first = freezed,
    Object? another = null,
  }) {
    return _then(_GenericMultiCtorWithArgumentFactoriesVal<T, S>(
      freezed == first
          ? _self.first
          : first // ignore: cast_nullable_to_non_nullable
              as T,
      null == another
          ? _self.another
          : another // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _GenericMultiCtorWithArgumentFactoriesSec<T, S>
    implements GenericMultiCtorWithArgumentFactories<T, S> {
  _GenericMultiCtorWithArgumentFactoriesSec(this.second, this.another,
      {final String? $type})
      : $type = $type ?? 'second';
  factory _GenericMultiCtorWithArgumentFactoriesSec.fromJson(
          Map<String, dynamic> json,
          T Function(Object?) fromJsonT,
          S Function(Object?) fromJsonS) =>
      _$GenericMultiCtorWithArgumentFactoriesSecFromJson(
          json, fromJsonT, fromJsonS);

  final S second;
  @override
  final String another;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of GenericMultiCtorWithArgumentFactories
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GenericMultiCtorWithArgumentFactoriesSecCopyWith<T, S,
          _GenericMultiCtorWithArgumentFactoriesSec<T, S>>
      get copyWith => __$GenericMultiCtorWithArgumentFactoriesSecCopyWithImpl<T,
          S, _GenericMultiCtorWithArgumentFactoriesSec<T, S>>(this, _$identity);

  @override
  Map<String, dynamic> toJson(
      Object? Function(T) toJsonT, Object? Function(S) toJsonS) {
    return _$GenericMultiCtorWithArgumentFactoriesSecToJson<T, S>(
        this, toJsonT, toJsonS);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GenericMultiCtorWithArgumentFactoriesSec<T, S> &&
            const DeepCollectionEquality().equals(other.second, second) &&
            (identical(other.another, another) || other.another == another));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(second), another);

  @override
  String toString() {
    return 'GenericMultiCtorWithArgumentFactories<$T, $S>.second(second: $second, another: $another)';
  }
}

/// @nodoc
abstract mixin class _$GenericMultiCtorWithArgumentFactoriesSecCopyWith<T, S,
        $Res>
    implements $GenericMultiCtorWithArgumentFactoriesCopyWith<T, S, $Res> {
  factory _$GenericMultiCtorWithArgumentFactoriesSecCopyWith(
      _GenericMultiCtorWithArgumentFactoriesSec<T, S> value,
      $Res Function(_GenericMultiCtorWithArgumentFactoriesSec<T, S>)
          _then) = __$GenericMultiCtorWithArgumentFactoriesSecCopyWithImpl;
  @override
  @useResult
  $Res call({S second, String another});
}

/// @nodoc
class __$GenericMultiCtorWithArgumentFactoriesSecCopyWithImpl<T, S, $Res>
    implements _$GenericMultiCtorWithArgumentFactoriesSecCopyWith<T, S, $Res> {
  __$GenericMultiCtorWithArgumentFactoriesSecCopyWithImpl(
      this._self, this._then);

  final _GenericMultiCtorWithArgumentFactoriesSec<T, S> _self;
  final $Res Function(_GenericMultiCtorWithArgumentFactoriesSec<T, S>) _then;

  /// Create a copy of GenericMultiCtorWithArgumentFactories
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? second = freezed,
    Object? another = null,
  }) {
    return _then(_GenericMultiCtorWithArgumentFactoriesSec<T, S>(
      freezed == second
          ? _self.second
          : second // ignore: cast_nullable_to_non_nullable
              as S,
      null == another
          ? _self.another
          : another // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _GenericMultiCtorWithArgumentFactoriesBoth<T, S>
    implements GenericMultiCtorWithArgumentFactories<T, S> {
  _GenericMultiCtorWithArgumentFactoriesBoth(
      this.first, this.second, this.another,
      {final String? $type})
      : $type = $type ?? 'both';
  factory _GenericMultiCtorWithArgumentFactoriesBoth.fromJson(
          Map<String, dynamic> json,
          T Function(Object?) fromJsonT,
          S Function(Object?) fromJsonS) =>
      _$GenericMultiCtorWithArgumentFactoriesBothFromJson(
          json, fromJsonT, fromJsonS);

  final T first;
  final S second;
  @override
  final String another;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of GenericMultiCtorWithArgumentFactories
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GenericMultiCtorWithArgumentFactoriesBothCopyWith<T, S,
          _GenericMultiCtorWithArgumentFactoriesBoth<T, S>>
      get copyWith => __$GenericMultiCtorWithArgumentFactoriesBothCopyWithImpl<
          T,
          S,
          _GenericMultiCtorWithArgumentFactoriesBoth<T, S>>(this, _$identity);

  @override
  Map<String, dynamic> toJson(
      Object? Function(T) toJsonT, Object? Function(S) toJsonS) {
    return _$GenericMultiCtorWithArgumentFactoriesBothToJson<T, S>(
        this, toJsonT, toJsonS);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GenericMultiCtorWithArgumentFactoriesBoth<T, S> &&
            const DeepCollectionEquality().equals(other.first, first) &&
            const DeepCollectionEquality().equals(other.second, second) &&
            (identical(other.another, another) || other.another == another));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(first),
      const DeepCollectionEquality().hash(second),
      another);

  @override
  String toString() {
    return 'GenericMultiCtorWithArgumentFactories<$T, $S>.both(first: $first, second: $second, another: $another)';
  }
}

/// @nodoc
abstract mixin class _$GenericMultiCtorWithArgumentFactoriesBothCopyWith<T, S,
        $Res>
    implements $GenericMultiCtorWithArgumentFactoriesCopyWith<T, S, $Res> {
  factory _$GenericMultiCtorWithArgumentFactoriesBothCopyWith(
      _GenericMultiCtorWithArgumentFactoriesBoth<T, S> value,
      $Res Function(_GenericMultiCtorWithArgumentFactoriesBoth<T, S>)
          _then) = __$GenericMultiCtorWithArgumentFactoriesBothCopyWithImpl;
  @override
  @useResult
  $Res call({T first, S second, String another});
}

/// @nodoc
class __$GenericMultiCtorWithArgumentFactoriesBothCopyWithImpl<T, S, $Res>
    implements _$GenericMultiCtorWithArgumentFactoriesBothCopyWith<T, S, $Res> {
  __$GenericMultiCtorWithArgumentFactoriesBothCopyWithImpl(
      this._self, this._then);

  final _GenericMultiCtorWithArgumentFactoriesBoth<T, S> _self;
  final $Res Function(_GenericMultiCtorWithArgumentFactoriesBoth<T, S>) _then;

  /// Create a copy of GenericMultiCtorWithArgumentFactories
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? first = freezed,
    Object? second = freezed,
    Object? another = null,
  }) {
    return _then(_GenericMultiCtorWithArgumentFactoriesBoth<T, S>(
      freezed == first
          ? _self.first
          : first // ignore: cast_nullable_to_non_nullable
              as T,
      freezed == second
          ? _self.second
          : second // ignore: cast_nullable_to_non_nullable
              as S,
      null == another
          ? _self.another
          : another // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _GenericMultiCtorWithArgumentFactoriesNone<T, S>
    implements GenericMultiCtorWithArgumentFactories<T, S> {
  _GenericMultiCtorWithArgumentFactoriesNone(this.another,
      {final String? $type})
      : $type = $type ?? 'none';
  factory _GenericMultiCtorWithArgumentFactoriesNone.fromJson(
          Map<String, dynamic> json,
          T Function(Object?) fromJsonT,
          S Function(Object?) fromJsonS) =>
      _$GenericMultiCtorWithArgumentFactoriesNoneFromJson(
          json, fromJsonT, fromJsonS);

  @override
  final String another;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of GenericMultiCtorWithArgumentFactories
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GenericMultiCtorWithArgumentFactoriesNoneCopyWith<T, S,
          _GenericMultiCtorWithArgumentFactoriesNone<T, S>>
      get copyWith => __$GenericMultiCtorWithArgumentFactoriesNoneCopyWithImpl<
          T,
          S,
          _GenericMultiCtorWithArgumentFactoriesNone<T, S>>(this, _$identity);

  @override
  Map<String, dynamic> toJson(
      Object? Function(T) toJsonT, Object? Function(S) toJsonS) {
    return _$GenericMultiCtorWithArgumentFactoriesNoneToJson<T, S>(
        this, toJsonT, toJsonS);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GenericMultiCtorWithArgumentFactoriesNone<T, S> &&
            (identical(other.another, another) || other.another == another));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, another);

  @override
  String toString() {
    return 'GenericMultiCtorWithArgumentFactories<$T, $S>.none(another: $another)';
  }
}

/// @nodoc
abstract mixin class _$GenericMultiCtorWithArgumentFactoriesNoneCopyWith<T, S,
        $Res>
    implements $GenericMultiCtorWithArgumentFactoriesCopyWith<T, S, $Res> {
  factory _$GenericMultiCtorWithArgumentFactoriesNoneCopyWith(
      _GenericMultiCtorWithArgumentFactoriesNone<T, S> value,
      $Res Function(_GenericMultiCtorWithArgumentFactoriesNone<T, S>)
          _then) = __$GenericMultiCtorWithArgumentFactoriesNoneCopyWithImpl;
  @override
  @useResult
  $Res call({String another});
}

/// @nodoc
class __$GenericMultiCtorWithArgumentFactoriesNoneCopyWithImpl<T, S, $Res>
    implements _$GenericMultiCtorWithArgumentFactoriesNoneCopyWith<T, S, $Res> {
  __$GenericMultiCtorWithArgumentFactoriesNoneCopyWithImpl(
      this._self, this._then);

  final _GenericMultiCtorWithArgumentFactoriesNone<T, S> _self;
  final $Res Function(_GenericMultiCtorWithArgumentFactoriesNone<T, S>) _then;

  /// Create a copy of GenericMultiCtorWithArgumentFactories
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? another = null,
  }) {
    return _then(_GenericMultiCtorWithArgumentFactoriesNone<T, S>(
      null == another
          ? _self.another
          : another // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}
