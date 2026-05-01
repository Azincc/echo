// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mixed_test.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Mixed {
  num get common;
  num get value;

  /// Create a copy of Mixed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MixedCopyWith<Mixed> get copyWith =>
      _$MixedCopyWithImpl<Mixed>(this as Mixed, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Mixed &&
            (identical(other.common, common) || other.common == common) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, common, value);

  @override
  String toString() {
    return 'Mixed(common: $common, value: $value)';
  }
}

/// @nodoc
abstract mixin class $MixedCopyWith<$Res> {
  factory $MixedCopyWith(Mixed value, $Res Function(Mixed) _then) =
      _$MixedCopyWithImpl;
  @useResult
  $Res call({num common});
}

/// @nodoc
class _$MixedCopyWithImpl<$Res> implements $MixedCopyWith<$Res> {
  _$MixedCopyWithImpl(this._self, this._then);

  final Mixed _self;
  final $Res Function(Mixed) _then;

  /// Create a copy of Mixed
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? common = null,
  }) {
    return _then(_self.copyWith(
      common: null == common
          ? _self.common
          : common // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// Adds pattern-matching-related methods to [Mixed].
extension MixedPatterns on Mixed {
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
    TResult Function(MixedA value)? a,
    TResult Function(FreezedImplements value)? b,
    TResult Function(ManualClass value)? c,
    TResult Function(FreezedExtends value)? d,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case MixedA() when a != null:
        return a(_that);
      case FreezedImplements() when b != null:
        return b(_that);
      case ManualClass() when c != null:
        return c(_that);
      case FreezedExtends() when d != null:
        return d(_that);
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
    required TResult Function(MixedA value) a,
    required TResult Function(FreezedImplements value) b,
    required TResult Function(ManualClass value) c,
    required TResult Function(FreezedExtends value) d,
  }) {
    final _that = this;
    switch (_that) {
      case MixedA():
        return a(_that);
      case FreezedImplements():
        return b(_that);
      case ManualClass():
        return c(_that);
      case FreezedExtends():
        return d(_that);
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
    TResult? Function(MixedA value)? a,
    TResult? Function(FreezedImplements value)? b,
    TResult? Function(ManualClass value)? c,
    TResult? Function(FreezedExtends value)? d,
  }) {
    final _that = this;
    switch (_that) {
      case MixedA() when a != null:
        return a(_that);
      case FreezedImplements() when b != null:
        return b(_that);
      case ManualClass() when c != null:
        return c(_that);
      case FreezedExtends() when d != null:
        return d(_that);
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
    TResult Function(num common, int value, String a)? a,
    TResult Function(num common, double value, int b)? b,
    TResult Function(num common, double value, bool c)? c,
    TResult Function(num common, double value, int d)? d,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case MixedA() when a != null:
        return a(_that.common, _that.value, _that.a);
      case FreezedImplements() when b != null:
        return b(_that.common, _that.value, _that.b);
      case ManualClass() when c != null:
        return c(_that.common, _that.value, _that.c);
      case FreezedExtends() when d != null:
        return d(_that.common, _that.value, _that.d);
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
    required TResult Function(num common, int value, String a) a,
    required TResult Function(num common, double value, int b) b,
    required TResult Function(num common, double value, bool c) c,
    required TResult Function(num common, double value, int d) d,
  }) {
    final _that = this;
    switch (_that) {
      case MixedA():
        return a(_that.common, _that.value, _that.a);
      case FreezedImplements():
        return b(_that.common, _that.value, _that.b);
      case ManualClass():
        return c(_that.common, _that.value, _that.c);
      case FreezedExtends():
        return d(_that.common, _that.value, _that.d);
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
    TResult? Function(num common, int value, String a)? a,
    TResult? Function(num common, double value, int b)? b,
    TResult? Function(num common, double value, bool c)? c,
    TResult? Function(num common, double value, int d)? d,
  }) {
    final _that = this;
    switch (_that) {
      case MixedA() when a != null:
        return a(_that.common, _that.value, _that.a);
      case FreezedImplements() when b != null:
        return b(_that.common, _that.value, _that.b);
      case ManualClass() when c != null:
        return c(_that.common, _that.value, _that.c);
      case FreezedExtends() when d != null:
        return d(_that.common, _that.value, _that.d);
      case _:
        return null;
    }
  }
}

/// @nodoc

class MixedA extends Mixed {
  MixedA(this.common, this.value, this.a) : super._();

  @override
  final num common;
  @override
  final int value;
  final String a;

  /// Create a copy of Mixed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MixedACopyWith<MixedA> get copyWith =>
      _$MixedACopyWithImpl<MixedA>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MixedA &&
            (identical(other.common, common) || other.common == common) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, common, value, a);

  @override
  String toString() {
    return 'Mixed.a(common: $common, value: $value, a: $a)';
  }
}

/// @nodoc
abstract mixin class $MixedACopyWith<$Res> implements $MixedCopyWith<$Res> {
  factory $MixedACopyWith(MixedA value, $Res Function(MixedA) _then) =
      _$MixedACopyWithImpl;
  @override
  @useResult
  $Res call({num common, int value, String a});
}

/// @nodoc
class _$MixedACopyWithImpl<$Res> implements $MixedACopyWith<$Res> {
  _$MixedACopyWithImpl(this._self, this._then);

  final MixedA _self;
  final $Res Function(MixedA) _then;

  /// Create a copy of Mixed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? common = null,
    Object? value = null,
    Object? a = null,
  }) {
    return _then(MixedA(
      null == common
          ? _self.common
          : common // ignore: cast_nullable_to_non_nullable
              as num,
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$FreezedImplements {
  num get common;
  double get value;
  int get b;

  /// Create a copy of FreezedImplements
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FreezedImplementsCopyWith<FreezedImplements> get copyWith =>
      _$FreezedImplementsCopyWithImpl<FreezedImplements>(
          this as FreezedImplements, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FreezedImplements &&
            (identical(other.common, common) || other.common == common) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, common, value, b);

  @override
  String toString() {
    return 'FreezedImplements(common: $common, value: $value, b: $b)';
  }
}

/// @nodoc
abstract mixin class $FreezedImplementsCopyWith<$Res>
    implements $MixedCopyWith<$Res> {
  factory $FreezedImplementsCopyWith(
          FreezedImplements value, $Res Function(FreezedImplements) _then) =
      _$FreezedImplementsCopyWithImpl;
  @useResult
  $Res call({num common, double value, int b});
}

/// @nodoc
class _$FreezedImplementsCopyWithImpl<$Res>
    implements $FreezedImplementsCopyWith<$Res> {
  _$FreezedImplementsCopyWithImpl(this._self, this._then);

  final FreezedImplements _self;
  final $Res Function(FreezedImplements) _then;

  /// Create a copy of FreezedImplements
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? common = null,
    Object? value = null,
    Object? b = null,
  }) {
    return _then(FreezedImplements(
      null == common
          ? _self.common
          : common // ignore: cast_nullable_to_non_nullable
              as num,
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      null == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [FreezedImplements].
extension FreezedImplementsPatterns on FreezedImplements {
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
mixin _$FreezedExtends {
  num get common;
  double get value;
  int get d;

  /// Create a copy of FreezedExtends
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FreezedExtendsCopyWith<FreezedExtends> get copyWith =>
      _$FreezedExtendsCopyWithImpl<FreezedExtends>(
          this as FreezedExtends, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FreezedExtends &&
            (identical(other.common, common) || other.common == common) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.d, d) || other.d == d));
  }

  @override
  int get hashCode => Object.hash(runtimeType, common, value, d);

  @override
  String toString() {
    return 'FreezedExtends(common: $common, value: $value, d: $d)';
  }
}

/// @nodoc
abstract mixin class $FreezedExtendsCopyWith<$Res>
    implements $MixedCopyWith<$Res> {
  factory $FreezedExtendsCopyWith(
          FreezedExtends value, $Res Function(FreezedExtends) _then) =
      _$FreezedExtendsCopyWithImpl;
  @useResult
  $Res call({num common, double value, int d});
}

/// @nodoc
class _$FreezedExtendsCopyWithImpl<$Res>
    implements $FreezedExtendsCopyWith<$Res> {
  _$FreezedExtendsCopyWithImpl(this._self, this._then);

  final FreezedExtends _self;
  final $Res Function(FreezedExtends) _then;

  /// Create a copy of FreezedExtends
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? common = null,
    Object? value = null,
    Object? d = null,
  }) {
    return _then(FreezedExtends(
      null == common
          ? _self.common
          : common // ignore: cast_nullable_to_non_nullable
              as num,
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      null == d
          ? _self.d
          : d // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [FreezedExtends].
extension FreezedExtendsPatterns on FreezedExtends {
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
mixin _$DiamondA {
  int get common;

  /// Create a copy of DiamondA
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DiamondACopyWith<DiamondA> get copyWith =>
      _$DiamondACopyWithImpl<DiamondA>(this as DiamondA, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DiamondA &&
            (identical(other.common, common) || other.common == common));
  }

  @override
  int get hashCode => Object.hash(runtimeType, common);

  @override
  String toString() {
    return 'DiamondA(common: $common)';
  }
}

/// @nodoc
abstract mixin class $DiamondACopyWith<$Res> {
  factory $DiamondACopyWith(DiamondA value, $Res Function(DiamondA) _then) =
      _$DiamondACopyWithImpl;
  @useResult
  $Res call({int common});
}

/// @nodoc
class _$DiamondACopyWithImpl<$Res> implements $DiamondACopyWith<$Res> {
  _$DiamondACopyWithImpl(this._self, this._then);

  final DiamondA _self;
  final $Res Function(DiamondA) _then;

  /// Create a copy of DiamondA
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? common = null,
  }) {
    return _then(_self.copyWith(
      common: null == common
          ? _self.common
          : common // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [DiamondA].
extension DiamondAPatterns on DiamondA {
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
    TResult Function(DiamondLeaf value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case DiamondLeaf() when $default != null:
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
    TResult Function(DiamondLeaf value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case DiamondLeaf():
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
    TResult? Function(DiamondLeaf value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case DiamondLeaf() when $default != null:
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
    TResult Function(int common)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case DiamondLeaf() when $default != null:
        return $default(_that.common);
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
    TResult Function(int common) $default,
  ) {
    final _that = this;
    switch (_that) {
      case DiamondLeaf():
        return $default(_that.common);
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
    TResult? Function(int common)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case DiamondLeaf() when $default != null:
        return $default(_that.common);
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$DiamondB {
  int get common;

  /// Create a copy of DiamondB
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DiamondBCopyWith<DiamondB> get copyWith =>
      _$DiamondBCopyWithImpl<DiamondB>(this as DiamondB, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DiamondB &&
            (identical(other.common, common) || other.common == common));
  }

  @override
  int get hashCode => Object.hash(runtimeType, common);

  @override
  String toString() {
    return 'DiamondB(common: $common)';
  }
}

/// @nodoc
abstract mixin class $DiamondBCopyWith<$Res> {
  factory $DiamondBCopyWith(DiamondB value, $Res Function(DiamondB) _then) =
      _$DiamondBCopyWithImpl;
  @useResult
  $Res call({int common});
}

/// @nodoc
class _$DiamondBCopyWithImpl<$Res> implements $DiamondBCopyWith<$Res> {
  _$DiamondBCopyWithImpl(this._self, this._then);

  final DiamondB _self;
  final $Res Function(DiamondB) _then;

  /// Create a copy of DiamondB
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? common = null,
  }) {
    return _then(_self.copyWith(
      common: null == common
          ? _self.common
          : common // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [DiamondB].
extension DiamondBPatterns on DiamondB {
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
    TResult Function(DiamondLeaf value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case DiamondLeaf() when $default != null:
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
    TResult Function(DiamondLeaf value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case DiamondLeaf():
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
    TResult? Function(DiamondLeaf value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case DiamondLeaf() when $default != null:
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
    TResult Function(int common)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case DiamondLeaf() when $default != null:
        return $default(_that.common);
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
    TResult Function(int common) $default,
  ) {
    final _that = this;
    switch (_that) {
      case DiamondLeaf():
        return $default(_that.common);
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
    TResult? Function(int common)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case DiamondLeaf() when $default != null:
        return $default(_that.common);
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$DiamondLeaf {
  int get common;

  /// Create a copy of DiamondLeaf
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DiamondLeafCopyWith<DiamondLeaf> get copyWith =>
      _$DiamondLeafCopyWithImpl<DiamondLeaf>(this as DiamondLeaf, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DiamondLeaf &&
            (identical(other.common, common) || other.common == common));
  }

  @override
  int get hashCode => Object.hash(runtimeType, common);

  @override
  String toString() {
    return 'DiamondLeaf(common: $common)';
  }
}

/// @nodoc
abstract mixin class $DiamondLeafCopyWith<$Res>
    implements $DiamondACopyWith<$Res>, $DiamondBCopyWith<$Res> {
  factory $DiamondLeafCopyWith(
          DiamondLeaf value, $Res Function(DiamondLeaf) _then) =
      _$DiamondLeafCopyWithImpl;
  @useResult
  $Res call({int common});
}

/// @nodoc
class _$DiamondLeafCopyWithImpl<$Res> implements $DiamondLeafCopyWith<$Res> {
  _$DiamondLeafCopyWithImpl(this._self, this._then);

  final DiamondLeaf _self;
  final $Res Function(DiamondLeaf) _then;

  /// Create a copy of DiamondLeaf
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? common = null,
  }) {
    return _then(_self.copyWith(
      common: null == common
          ? _self.common
          : common // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [DiamondLeaf].
extension DiamondLeafPatterns on DiamondLeaf {
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
    TResult Function(_DiamondLeaf value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DiamondLeaf() when $default != null:
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
    TResult Function(_DiamondLeaf value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DiamondLeaf():
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
    TResult? Function(_DiamondLeaf value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DiamondLeaf() when $default != null:
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
    TResult Function(int common)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DiamondLeaf() when $default != null:
        return $default(_that.common);
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
    TResult Function(int common) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DiamondLeaf():
        return $default(_that.common);
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
    TResult? Function(int common)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DiamondLeaf() when $default != null:
        return $default(_that.common);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DiamondLeaf implements DiamondLeaf {
  _DiamondLeaf(this.common);

  @override
  final int common;

  /// Create a copy of DiamondLeaf
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DiamondLeafCopyWith<_DiamondLeaf> get copyWith =>
      __$DiamondLeafCopyWithImpl<_DiamondLeaf>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DiamondLeaf &&
            (identical(other.common, common) || other.common == common));
  }

  @override
  int get hashCode => Object.hash(runtimeType, common);

  @override
  String toString() {
    return 'DiamondLeaf(common: $common)';
  }
}

/// @nodoc
abstract mixin class _$DiamondLeafCopyWith<$Res>
    implements $DiamondLeafCopyWith<$Res> {
  factory _$DiamondLeafCopyWith(
          _DiamondLeaf value, $Res Function(_DiamondLeaf) _then) =
      __$DiamondLeafCopyWithImpl;
  @override
  @useResult
  $Res call({int common});
}

/// @nodoc
class __$DiamondLeafCopyWithImpl<$Res> implements _$DiamondLeafCopyWith<$Res> {
  __$DiamondLeafCopyWithImpl(this._self, this._then);

  final _DiamondLeaf _self;
  final $Res Function(_DiamondLeaf) _then;

  /// Create a copy of DiamondLeaf
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? common = null,
  }) {
    return _then(_DiamondLeaf(
      null == common
          ? _self.common
          : common // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}
