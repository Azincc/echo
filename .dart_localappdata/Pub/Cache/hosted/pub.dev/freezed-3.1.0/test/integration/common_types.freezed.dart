// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'common_types.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Union {
  int? get arg;

  /// Create a copy of Union
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnionCopyWith<Union> get copyWith =>
      _$UnionCopyWithImpl<Union>(this as Union, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Union &&
            (identical(other.arg, arg) || other.arg == arg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, arg);

  @override
  String toString() {
    return 'Union(arg: $arg)';
  }
}

/// @nodoc
abstract mixin class $UnionCopyWith<$Res> {
  factory $UnionCopyWith(Union value, $Res Function(Union) _then) =
      _$UnionCopyWithImpl;
  @useResult
  $Res call({int arg});
}

/// @nodoc
class _$UnionCopyWithImpl<$Res> implements $UnionCopyWith<$Res> {
  _$UnionCopyWithImpl(this._self, this._then);

  final Union _self;
  final $Res Function(Union) _then;

  /// Create a copy of Union
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? arg = null,
  }) {
    return _then(_self.copyWith(
      arg: null == arg
          ? _self.arg!
          : arg // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [Union].
extension UnionPatterns on Union {
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
    TResult Function(_UnionFoo value)? foo,
    TResult Function(_UnionBar value)? bar,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnionFoo() when foo != null:
        return foo(_that);
      case _UnionBar() when bar != null:
        return bar(_that);
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
    required TResult Function(_UnionFoo value) foo,
    required TResult Function(_UnionBar value) bar,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionFoo():
        return foo(_that);
      case _UnionBar():
        return bar(_that);
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
    TResult? Function(_UnionFoo value)? foo,
    TResult? Function(_UnionBar value)? bar,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionFoo() when foo != null:
        return foo(_that);
      case _UnionBar() when bar != null:
        return bar(_that);
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
    TResult Function(int? arg)? foo,
    TResult Function(int arg)? bar,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnionFoo() when foo != null:
        return foo(_that.arg);
      case _UnionBar() when bar != null:
        return bar(_that.arg);
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
    required TResult Function(int? arg) foo,
    required TResult Function(int arg) bar,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionFoo():
        return foo(_that.arg);
      case _UnionBar():
        return bar(_that.arg);
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
    TResult? Function(int? arg)? foo,
    TResult? Function(int arg)? bar,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionFoo() when foo != null:
        return foo(_that.arg);
      case _UnionBar() when bar != null:
        return bar(_that.arg);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _UnionFoo implements Union {
  _UnionFoo({this.arg});

  @override
  final int? arg;

  /// Create a copy of Union
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnionFooCopyWith<_UnionFoo> get copyWith =>
      __$UnionFooCopyWithImpl<_UnionFoo>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnionFoo &&
            (identical(other.arg, arg) || other.arg == arg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, arg);

  @override
  String toString() {
    return 'Union.foo(arg: $arg)';
  }
}

/// @nodoc
abstract mixin class _$UnionFooCopyWith<$Res> implements $UnionCopyWith<$Res> {
  factory _$UnionFooCopyWith(_UnionFoo value, $Res Function(_UnionFoo) _then) =
      __$UnionFooCopyWithImpl;
  @override
  @useResult
  $Res call({int? arg});
}

/// @nodoc
class __$UnionFooCopyWithImpl<$Res> implements _$UnionFooCopyWith<$Res> {
  __$UnionFooCopyWithImpl(this._self, this._then);

  final _UnionFoo _self;
  final $Res Function(_UnionFoo) _then;

  /// Create a copy of Union
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? arg = freezed,
  }) {
    return _then(_UnionFoo(
      arg: freezed == arg
          ? _self.arg
          : arg // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _UnionBar implements Union {
  _UnionBar({required this.arg});

  @override
  final int arg;

  /// Create a copy of Union
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnionBarCopyWith<_UnionBar> get copyWith =>
      __$UnionBarCopyWithImpl<_UnionBar>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnionBar &&
            (identical(other.arg, arg) || other.arg == arg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, arg);

  @override
  String toString() {
    return 'Union.bar(arg: $arg)';
  }
}

/// @nodoc
abstract mixin class _$UnionBarCopyWith<$Res> implements $UnionCopyWith<$Res> {
  factory _$UnionBarCopyWith(_UnionBar value, $Res Function(_UnionBar) _then) =
      __$UnionBarCopyWithImpl;
  @override
  @useResult
  $Res call({int arg});
}

/// @nodoc
class __$UnionBarCopyWithImpl<$Res> implements _$UnionBarCopyWith<$Res> {
  __$UnionBarCopyWithImpl(this._self, this._then);

  final _UnionBar _self;
  final $Res Function(_UnionBar) _then;

  /// Create a copy of Union
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? arg = null,
  }) {
    return _then(_UnionBar(
      arg: null == arg
          ? _self.arg
          : arg // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$Union2 {
  num? get arg;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Union2 &&
            (identical(other.arg, arg) || other.arg == arg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, arg);

  @override
  String toString() {
    return 'Union2(arg: $arg)';
  }
}

/// @nodoc
class $Union2CopyWith<$Res> {
  $Union2CopyWith(Union2 _, $Res Function(Union2) __);
}

/// Adds pattern-matching-related methods to [Union2].
extension Union2Patterns on Union2 {
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
    TResult Function(_Union2Foo value)? foo,
    TResult Function(_Union2Bar value)? bar,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Union2Foo() when foo != null:
        return foo(_that);
      case _Union2Bar() when bar != null:
        return bar(_that);
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
    required TResult Function(_Union2Foo value) foo,
    required TResult Function(_Union2Bar value) bar,
  }) {
    final _that = this;
    switch (_that) {
      case _Union2Foo():
        return foo(_that);
      case _Union2Bar():
        return bar(_that);
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
    TResult? Function(_Union2Foo value)? foo,
    TResult? Function(_Union2Bar value)? bar,
  }) {
    final _that = this;
    switch (_that) {
      case _Union2Foo() when foo != null:
        return foo(_that);
      case _Union2Bar() when bar != null:
        return bar(_that);
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
    TResult Function(int arg)? foo,
    TResult Function(double? arg)? bar,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Union2Foo() when foo != null:
        return foo(_that.arg);
      case _Union2Bar() when bar != null:
        return bar(_that.arg);
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
    required TResult Function(int arg) foo,
    required TResult Function(double? arg) bar,
  }) {
    final _that = this;
    switch (_that) {
      case _Union2Foo():
        return foo(_that.arg);
      case _Union2Bar():
        return bar(_that.arg);
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
    TResult? Function(int arg)? foo,
    TResult? Function(double? arg)? bar,
  }) {
    final _that = this;
    switch (_that) {
      case _Union2Foo() when foo != null:
        return foo(_that.arg);
      case _Union2Bar() when bar != null:
        return bar(_that.arg);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Union2Foo implements Union2 {
  _Union2Foo({required this.arg});

  @override
  final int arg;

  /// Create a copy of Union2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$Union2FooCopyWith<_Union2Foo> get copyWith =>
      __$Union2FooCopyWithImpl<_Union2Foo>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Union2Foo &&
            (identical(other.arg, arg) || other.arg == arg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, arg);

  @override
  String toString() {
    return 'Union2.foo(arg: $arg)';
  }
}

/// @nodoc
abstract mixin class _$Union2FooCopyWith<$Res>
    implements $Union2CopyWith<$Res> {
  factory _$Union2FooCopyWith(
          _Union2Foo value, $Res Function(_Union2Foo) _then) =
      __$Union2FooCopyWithImpl;
  @useResult
  $Res call({int arg});
}

/// @nodoc
class __$Union2FooCopyWithImpl<$Res> implements _$Union2FooCopyWith<$Res> {
  __$Union2FooCopyWithImpl(this._self, this._then);

  final _Union2Foo _self;
  final $Res Function(_Union2Foo) _then;

  /// Create a copy of Union2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? arg = null,
  }) {
    return _then(_Union2Foo(
      arg: null == arg
          ? _self.arg
          : arg // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _Union2Bar implements Union2 {
  _Union2Bar({this.arg});

  @override
  final double? arg;

  /// Create a copy of Union2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$Union2BarCopyWith<_Union2Bar> get copyWith =>
      __$Union2BarCopyWithImpl<_Union2Bar>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Union2Bar &&
            (identical(other.arg, arg) || other.arg == arg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, arg);

  @override
  String toString() {
    return 'Union2.bar(arg: $arg)';
  }
}

/// @nodoc
abstract mixin class _$Union2BarCopyWith<$Res>
    implements $Union2CopyWith<$Res> {
  factory _$Union2BarCopyWith(
          _Union2Bar value, $Res Function(_Union2Bar) _then) =
      __$Union2BarCopyWithImpl;
  @useResult
  $Res call({double? arg});
}

/// @nodoc
class __$Union2BarCopyWithImpl<$Res> implements _$Union2BarCopyWith<$Res> {
  __$Union2BarCopyWithImpl(this._self, this._then);

  final _Union2Bar _self;
  final $Res Function(_Union2Bar) _then;

  /// Create a copy of Union2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? arg = freezed,
  }) {
    return _then(_Union2Bar(
      arg: freezed == arg
          ? _self.arg
          : arg // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
mixin _$Union3 {
  num? get arg;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Union3 &&
            (identical(other.arg, arg) || other.arg == arg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, arg);

  @override
  String toString() {
    return 'Union3(arg: $arg)';
  }
}

/// @nodoc
class $Union3CopyWith<$Res> {
  $Union3CopyWith(Union3 _, $Res Function(Union3) __);
}

/// Adds pattern-matching-related methods to [Union3].
extension Union3Patterns on Union3 {
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
    TResult Function(_Union3Bar value)? bar,
    TResult Function(_Union3Foo value)? foo,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Union3Bar() when bar != null:
        return bar(_that);
      case _Union3Foo() when foo != null:
        return foo(_that);
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
    required TResult Function(_Union3Bar value) bar,
    required TResult Function(_Union3Foo value) foo,
  }) {
    final _that = this;
    switch (_that) {
      case _Union3Bar():
        return bar(_that);
      case _Union3Foo():
        return foo(_that);
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
    TResult? Function(_Union3Bar value)? bar,
    TResult? Function(_Union3Foo value)? foo,
  }) {
    final _that = this;
    switch (_that) {
      case _Union3Bar() when bar != null:
        return bar(_that);
      case _Union3Foo() when foo != null:
        return foo(_that);
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
    TResult Function(double? arg)? bar,
    TResult Function(int arg)? foo,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Union3Bar() when bar != null:
        return bar(_that.arg);
      case _Union3Foo() when foo != null:
        return foo(_that.arg);
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
    required TResult Function(double? arg) bar,
    required TResult Function(int arg) foo,
  }) {
    final _that = this;
    switch (_that) {
      case _Union3Bar():
        return bar(_that.arg);
      case _Union3Foo():
        return foo(_that.arg);
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
    TResult? Function(double? arg)? bar,
    TResult? Function(int arg)? foo,
  }) {
    final _that = this;
    switch (_that) {
      case _Union3Bar() when bar != null:
        return bar(_that.arg);
      case _Union3Foo() when foo != null:
        return foo(_that.arg);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Union3Bar implements Union3 {
  _Union3Bar({this.arg});

  @override
  final double? arg;

  /// Create a copy of Union3
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$Union3BarCopyWith<_Union3Bar> get copyWith =>
      __$Union3BarCopyWithImpl<_Union3Bar>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Union3Bar &&
            (identical(other.arg, arg) || other.arg == arg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, arg);

  @override
  String toString() {
    return 'Union3.bar(arg: $arg)';
  }
}

/// @nodoc
abstract mixin class _$Union3BarCopyWith<$Res>
    implements $Union3CopyWith<$Res> {
  factory _$Union3BarCopyWith(
          _Union3Bar value, $Res Function(_Union3Bar) _then) =
      __$Union3BarCopyWithImpl;
  @useResult
  $Res call({double? arg});
}

/// @nodoc
class __$Union3BarCopyWithImpl<$Res> implements _$Union3BarCopyWith<$Res> {
  __$Union3BarCopyWithImpl(this._self, this._then);

  final _Union3Bar _self;
  final $Res Function(_Union3Bar) _then;

  /// Create a copy of Union3
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? arg = freezed,
  }) {
    return _then(_Union3Bar(
      arg: freezed == arg
          ? _self.arg
          : arg // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _Union3Foo implements Union3 {
  _Union3Foo({required this.arg});

  @override
  final int arg;

  /// Create a copy of Union3
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$Union3FooCopyWith<_Union3Foo> get copyWith =>
      __$Union3FooCopyWithImpl<_Union3Foo>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Union3Foo &&
            (identical(other.arg, arg) || other.arg == arg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, arg);

  @override
  String toString() {
    return 'Union3.foo(arg: $arg)';
  }
}

/// @nodoc
abstract mixin class _$Union3FooCopyWith<$Res>
    implements $Union3CopyWith<$Res> {
  factory _$Union3FooCopyWith(
          _Union3Foo value, $Res Function(_Union3Foo) _then) =
      __$Union3FooCopyWithImpl;
  @useResult
  $Res call({int arg});
}

/// @nodoc
class __$Union3FooCopyWithImpl<$Res> implements _$Union3FooCopyWith<$Res> {
  __$Union3FooCopyWithImpl(this._self, this._then);

  final _Union3Foo _self;
  final $Res Function(_Union3Foo) _then;

  /// Create a copy of Union3
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? arg = null,
  }) {
    return _then(_Union3Foo(
      arg: null == arg
          ? _self.arg
          : arg // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$Union4 {
  int? get count;
  String? get id;
  String? get name;

  /// Create a copy of Union4
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Union4CopyWith<Union4> get copyWith =>
      _$Union4CopyWithImpl<Union4>(this as Union4, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Union4 &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, count, id, name);

  @override
  String toString() {
    return 'Union4(count: $count, id: $id, name: $name)';
  }
}

/// @nodoc
abstract mixin class $Union4CopyWith<$Res> {
  factory $Union4CopyWith(Union4 value, $Res Function(Union4) _then) =
      _$Union4CopyWithImpl;
  @useResult
  $Res call({int count, String id, String name});
}

/// @nodoc
class _$Union4CopyWithImpl<$Res> implements $Union4CopyWith<$Res> {
  _$Union4CopyWithImpl(this._self, this._then);

  final Union4 _self;
  final $Res Function(Union4) _then;

  /// Create a copy of Union4
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_self.copyWith(
      count: null == count
          ? _self.count!
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      id: null == id
          ? _self.id!
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name!
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [Union4].
extension Union4Patterns on Union4 {
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
    TResult Function(Union4One value)? eventOne,
    TResult Function(Union4Two value)? eventTwo,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Union4One() when eventOne != null:
        return eventOne(_that);
      case Union4Two() when eventTwo != null:
        return eventTwo(_that);
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
    required TResult Function(Union4One value) eventOne,
    required TResult Function(Union4Two value) eventTwo,
  }) {
    final _that = this;
    switch (_that) {
      case Union4One():
        return eventOne(_that);
      case Union4Two():
        return eventTwo(_that);
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
    TResult? Function(Union4One value)? eventOne,
    TResult? Function(Union4Two value)? eventTwo,
  }) {
    final _that = this;
    switch (_that) {
      case Union4One() when eventOne != null:
        return eventOne(_that);
      case Union4Two() when eventTwo != null:
        return eventTwo(_that);
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
    TResult Function(int count, String? id, String? name)? eventOne,
    TResult Function(int? count, String id, String name)? eventTwo,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Union4One() when eventOne != null:
        return eventOne(_that.count, _that.id, _that.name);
      case Union4Two() when eventTwo != null:
        return eventTwo(_that.count, _that.id, _that.name);
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
    required TResult Function(int count, String? id, String? name) eventOne,
    required TResult Function(int? count, String id, String name) eventTwo,
  }) {
    final _that = this;
    switch (_that) {
      case Union4One():
        return eventOne(_that.count, _that.id, _that.name);
      case Union4Two():
        return eventTwo(_that.count, _that.id, _that.name);
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
    TResult? Function(int count, String? id, String? name)? eventOne,
    TResult? Function(int? count, String id, String name)? eventTwo,
  }) {
    final _that = this;
    switch (_that) {
      case Union4One() when eventOne != null:
        return eventOne(_that.count, _that.id, _that.name);
      case Union4Two() when eventTwo != null:
        return eventTwo(_that.count, _that.id, _that.name);
      case _:
        return null;
    }
  }
}

/// @nodoc

class Union4One implements Union4 {
  Union4One({required this.count, required this.id, required this.name});

  @override
  final int count;
  @override
  final String? id;
  @override
  final String? name;

  /// Create a copy of Union4
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Union4OneCopyWith<Union4One> get copyWith =>
      _$Union4OneCopyWithImpl<Union4One>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Union4One &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, count, id, name);

  @override
  String toString() {
    return 'Union4.eventOne(count: $count, id: $id, name: $name)';
  }
}

/// @nodoc
abstract mixin class $Union4OneCopyWith<$Res> implements $Union4CopyWith<$Res> {
  factory $Union4OneCopyWith(Union4One value, $Res Function(Union4One) _then) =
      _$Union4OneCopyWithImpl;
  @override
  @useResult
  $Res call({int count, String? id, String? name});
}

/// @nodoc
class _$Union4OneCopyWithImpl<$Res> implements $Union4OneCopyWith<$Res> {
  _$Union4OneCopyWithImpl(this._self, this._then);

  final Union4One _self;
  final $Res Function(Union4One) _then;

  /// Create a copy of Union4
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? count = null,
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(Union4One(
      count: null == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class Union4Two implements Union4 {
  Union4Two({required this.count, required this.id, required this.name});

  @override
  final int? count;
  @override
  final String id;
  @override
  final String name;

  /// Create a copy of Union4
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Union4TwoCopyWith<Union4Two> get copyWith =>
      _$Union4TwoCopyWithImpl<Union4Two>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Union4Two &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, count, id, name);

  @override
  String toString() {
    return 'Union4.eventTwo(count: $count, id: $id, name: $name)';
  }
}

/// @nodoc
abstract mixin class $Union4TwoCopyWith<$Res> implements $Union4CopyWith<$Res> {
  factory $Union4TwoCopyWith(Union4Two value, $Res Function(Union4Two) _then) =
      _$Union4TwoCopyWithImpl;
  @override
  @useResult
  $Res call({int? count, String id, String name});
}

/// @nodoc
class _$Union4TwoCopyWithImpl<$Res> implements $Union4TwoCopyWith<$Res> {
  _$Union4TwoCopyWithImpl(this._self, this._then);

  final Union4Two _self;
  final $Res Function(Union4Two) _then;

  /// Create a copy of Union4
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? count = freezed,
    Object? id = null,
    Object? name = null,
  }) {
    return _then(Union4Two(
      count: freezed == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$Union5 {
  Object? get value;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Union5 &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'Union5(value: $value)';
  }
}

/// @nodoc
class $Union5CopyWith<$Res> {
  $Union5CopyWith(Union5 _, $Res Function(Union5) __);
}

/// Adds pattern-matching-related methods to [Union5].
extension Union5Patterns on Union5 {
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
    TResult Function(_Union5First value)? first,
    TResult Function(_Union5Second value)? second,
    TResult Function(_Union5Third value)? third,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Union5First() when first != null:
        return first(_that);
      case _Union5Second() when second != null:
        return second(_that);
      case _Union5Third() when third != null:
        return third(_that);
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
    required TResult Function(_Union5First value) first,
    required TResult Function(_Union5Second value) second,
    required TResult Function(_Union5Third value) third,
  }) {
    final _that = this;
    switch (_that) {
      case _Union5First():
        return first(_that);
      case _Union5Second():
        return second(_that);
      case _Union5Third():
        return third(_that);
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
    TResult? Function(_Union5First value)? first,
    TResult? Function(_Union5Second value)? second,
    TResult? Function(_Union5Third value)? third,
  }) {
    final _that = this;
    switch (_that) {
      case _Union5First() when first != null:
        return first(_that);
      case _Union5Second() when second != null:
        return second(_that);
      case _Union5Third() when third != null:
        return third(_that);
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
    TResult Function(int value)? first,
    TResult Function(double? value)? second,
    TResult Function(String value)? third,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Union5First() when first != null:
        return first(_that.value);
      case _Union5Second() when second != null:
        return second(_that.value);
      case _Union5Third() when third != null:
        return third(_that.value);
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
    required TResult Function(int value) first,
    required TResult Function(double? value) second,
    required TResult Function(String value) third,
  }) {
    final _that = this;
    switch (_that) {
      case _Union5First():
        return first(_that.value);
      case _Union5Second():
        return second(_that.value);
      case _Union5Third():
        return third(_that.value);
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
    TResult? Function(int value)? first,
    TResult? Function(double? value)? second,
    TResult? Function(String value)? third,
  }) {
    final _that = this;
    switch (_that) {
      case _Union5First() when first != null:
        return first(_that.value);
      case _Union5Second() when second != null:
        return second(_that.value);
      case _Union5Third() when third != null:
        return third(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Union5First implements Union5 {
  _Union5First(this.value);

  @override
  final int value;

  /// Create a copy of Union5
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$Union5FirstCopyWith<_Union5First> get copyWith =>
      __$Union5FirstCopyWithImpl<_Union5First>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Union5First &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'Union5.first(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$Union5FirstCopyWith<$Res>
    implements $Union5CopyWith<$Res> {
  factory _$Union5FirstCopyWith(
          _Union5First value, $Res Function(_Union5First) _then) =
      __$Union5FirstCopyWithImpl;
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$Union5FirstCopyWithImpl<$Res> implements _$Union5FirstCopyWith<$Res> {
  __$Union5FirstCopyWithImpl(this._self, this._then);

  final _Union5First _self;
  final $Res Function(_Union5First) _then;

  /// Create a copy of Union5
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_Union5First(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _Union5Second implements Union5 {
  _Union5Second(this.value);

  @override
  final double? value;

  /// Create a copy of Union5
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$Union5SecondCopyWith<_Union5Second> get copyWith =>
      __$Union5SecondCopyWithImpl<_Union5Second>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Union5Second &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'Union5.second(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$Union5SecondCopyWith<$Res>
    implements $Union5CopyWith<$Res> {
  factory _$Union5SecondCopyWith(
          _Union5Second value, $Res Function(_Union5Second) _then) =
      __$Union5SecondCopyWithImpl;
  @useResult
  $Res call({double? value});
}

/// @nodoc
class __$Union5SecondCopyWithImpl<$Res>
    implements _$Union5SecondCopyWith<$Res> {
  __$Union5SecondCopyWithImpl(this._self, this._then);

  final _Union5Second _self;
  final $Res Function(_Union5Second) _then;

  /// Create a copy of Union5
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_Union5Second(
      freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _Union5Third implements Union5 {
  _Union5Third(this.value);

  @override
  final String value;

  /// Create a copy of Union5
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$Union5ThirdCopyWith<_Union5Third> get copyWith =>
      __$Union5ThirdCopyWithImpl<_Union5Third>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Union5Third &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'Union5.third(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$Union5ThirdCopyWith<$Res>
    implements $Union5CopyWith<$Res> {
  factory _$Union5ThirdCopyWith(
          _Union5Third value, $Res Function(_Union5Third) _then) =
      __$Union5ThirdCopyWithImpl;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$Union5ThirdCopyWithImpl<$Res> implements _$Union5ThirdCopyWith<$Res> {
  __$Union5ThirdCopyWithImpl(this._self, this._then);

  final _Union5Third _self;
  final $Res Function(_Union5Third) _then;

  /// Create a copy of Union5
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_Union5Third(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$UnionDeepCopy {
  CommonSuperSubtype? get value42;

  /// Create a copy of UnionDeepCopy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnionDeepCopyCopyWith<UnionDeepCopy> get copyWith =>
      _$UnionDeepCopyCopyWithImpl<UnionDeepCopy>(
          this as UnionDeepCopy, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnionDeepCopy &&
            (identical(other.value42, value42) || other.value42 == value42));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value42);

  @override
  String toString() {
    return 'UnionDeepCopy(value42: $value42)';
  }
}

/// @nodoc
abstract mixin class $UnionDeepCopyCopyWith<$Res> {
  factory $UnionDeepCopyCopyWith(
          UnionDeepCopy value, $Res Function(UnionDeepCopy) _then) =
      _$UnionDeepCopyCopyWithImpl;
  @useResult
  $Res call({CommonSuperSubtype value42});

  $CommonSuperSubtypeCopyWith<$Res>? get value42;
}

/// @nodoc
class _$UnionDeepCopyCopyWithImpl<$Res>
    implements $UnionDeepCopyCopyWith<$Res> {
  _$UnionDeepCopyCopyWithImpl(this._self, this._then);

  final UnionDeepCopy _self;
  final $Res Function(UnionDeepCopy) _then;

  /// Create a copy of UnionDeepCopy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value42 = null,
  }) {
    return _then(_self.copyWith(
      value42: null == value42
          ? _self.value42!
          : value42 // ignore: cast_nullable_to_non_nullable
              as CommonSuperSubtype,
    ));
  }

  /// Create a copy of UnionDeepCopy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CommonSuperSubtypeCopyWith<$Res>? get value42 {
    if (_self.value42 == null) {
      return null;
    }

    return $CommonSuperSubtypeCopyWith<$Res>(_self.value42!, (value) {
      return _then(_self.copyWith(value42: value));
    });
  }
}

/// Adds pattern-matching-related methods to [UnionDeepCopy].
extension UnionDeepCopyPatterns on UnionDeepCopy {
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
    TResult Function(_UnionWrapperFirst value)? first,
    TResult Function(_UnionWrapperSecond value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnionWrapperFirst() when first != null:
        return first(_that);
      case _UnionWrapperSecond() when second != null:
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
    required TResult Function(_UnionWrapperFirst value) first,
    required TResult Function(_UnionWrapperSecond value) second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionWrapperFirst():
        return first(_that);
      case _UnionWrapperSecond():
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
    TResult? Function(_UnionWrapperFirst value)? first,
    TResult? Function(_UnionWrapperSecond value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionWrapperFirst() when first != null:
        return first(_that);
      case _UnionWrapperSecond() when second != null:
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
    TResult Function(CommonSuperSubtype value42)? first,
    TResult Function(CommonSuperSubtype? value42)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnionWrapperFirst() when first != null:
        return first(_that.value42);
      case _UnionWrapperSecond() when second != null:
        return second(_that.value42);
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
    required TResult Function(CommonSuperSubtype value42) first,
    required TResult Function(CommonSuperSubtype? value42) second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionWrapperFirst():
        return first(_that.value42);
      case _UnionWrapperSecond():
        return second(_that.value42);
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
    TResult? Function(CommonSuperSubtype value42)? first,
    TResult? Function(CommonSuperSubtype? value42)? second,
  }) {
    final _that = this;
    switch (_that) {
      case _UnionWrapperFirst() when first != null:
        return first(_that.value42);
      case _UnionWrapperSecond() when second != null:
        return second(_that.value42);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _UnionWrapperFirst implements UnionDeepCopy {
  _UnionWrapperFirst(this.value42);

  @override
  final CommonSuperSubtype value42;

  /// Create a copy of UnionDeepCopy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnionWrapperFirstCopyWith<_UnionWrapperFirst> get copyWith =>
      __$UnionWrapperFirstCopyWithImpl<_UnionWrapperFirst>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnionWrapperFirst &&
            (identical(other.value42, value42) || other.value42 == value42));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value42);

  @override
  String toString() {
    return 'UnionDeepCopy.first(value42: $value42)';
  }
}

/// @nodoc
abstract mixin class _$UnionWrapperFirstCopyWith<$Res>
    implements $UnionDeepCopyCopyWith<$Res> {
  factory _$UnionWrapperFirstCopyWith(
          _UnionWrapperFirst value, $Res Function(_UnionWrapperFirst) _then) =
      __$UnionWrapperFirstCopyWithImpl;
  @override
  @useResult
  $Res call({CommonSuperSubtype value42});

  @override
  $CommonSuperSubtypeCopyWith<$Res> get value42;
}

/// @nodoc
class __$UnionWrapperFirstCopyWithImpl<$Res>
    implements _$UnionWrapperFirstCopyWith<$Res> {
  __$UnionWrapperFirstCopyWithImpl(this._self, this._then);

  final _UnionWrapperFirst _self;
  final $Res Function(_UnionWrapperFirst) _then;

  /// Create a copy of UnionDeepCopy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value42 = null,
  }) {
    return _then(_UnionWrapperFirst(
      null == value42
          ? _self.value42
          : value42 // ignore: cast_nullable_to_non_nullable
              as CommonSuperSubtype,
    ));
  }

  /// Create a copy of UnionDeepCopy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CommonSuperSubtypeCopyWith<$Res> get value42 {
    return $CommonSuperSubtypeCopyWith<$Res>(_self.value42, (value) {
      return _then(_self.copyWith(value42: value));
    });
  }
}

/// @nodoc

class _UnionWrapperSecond implements UnionDeepCopy {
  _UnionWrapperSecond(this.value42);

  @override
  final CommonSuperSubtype? value42;

  /// Create a copy of UnionDeepCopy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnionWrapperSecondCopyWith<_UnionWrapperSecond> get copyWith =>
      __$UnionWrapperSecondCopyWithImpl<_UnionWrapperSecond>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnionWrapperSecond &&
            (identical(other.value42, value42) || other.value42 == value42));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value42);

  @override
  String toString() {
    return 'UnionDeepCopy.second(value42: $value42)';
  }
}

/// @nodoc
abstract mixin class _$UnionWrapperSecondCopyWith<$Res>
    implements $UnionDeepCopyCopyWith<$Res> {
  factory _$UnionWrapperSecondCopyWith(
          _UnionWrapperSecond value, $Res Function(_UnionWrapperSecond) _then) =
      __$UnionWrapperSecondCopyWithImpl;
  @override
  @useResult
  $Res call({CommonSuperSubtype? value42});

  @override
  $CommonSuperSubtypeCopyWith<$Res>? get value42;
}

/// @nodoc
class __$UnionWrapperSecondCopyWithImpl<$Res>
    implements _$UnionWrapperSecondCopyWith<$Res> {
  __$UnionWrapperSecondCopyWithImpl(this._self, this._then);

  final _UnionWrapperSecond _self;
  final $Res Function(_UnionWrapperSecond) _then;

  /// Create a copy of UnionDeepCopy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value42 = freezed,
  }) {
    return _then(_UnionWrapperSecond(
      freezed == value42
          ? _self.value42
          : value42 // ignore: cast_nullable_to_non_nullable
              as CommonSuperSubtype?,
    ));
  }

  /// Create a copy of UnionDeepCopy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CommonSuperSubtypeCopyWith<$Res>? get value42 {
    if (_self.value42 == null) {
      return null;
    }

    return $CommonSuperSubtypeCopyWith<$Res>(_self.value42!, (value) {
      return _then(_self.copyWith(value42: value));
    });
  }
}

/// @nodoc
mixin _$Check {
  dynamic get value;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Check &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'Check(value: $value)';
  }
}

/// @nodoc
class $CheckCopyWith<$Res> {
  $CheckCopyWith(Check _, $Res Function(Check) __);
}

/// Adds pattern-matching-related methods to [Check].
extension CheckPatterns on Check {
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
    TResult Function(_CheckFirst value)? first,
    TResult Function(_CheckSecond value)? second,
    TResult Function(_CheckThird value)? third,
    TResult Function(_CheckFourth value)? fourth,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CheckFirst() when first != null:
        return first(_that);
      case _CheckSecond() when second != null:
        return second(_that);
      case _CheckThird() when third != null:
        return third(_that);
      case _CheckFourth() when fourth != null:
        return fourth(_that);
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
    required TResult Function(_CheckFirst value) first,
    required TResult Function(_CheckSecond value) second,
    required TResult Function(_CheckThird value) third,
    required TResult Function(_CheckFourth value) fourth,
  }) {
    final _that = this;
    switch (_that) {
      case _CheckFirst():
        return first(_that);
      case _CheckSecond():
        return second(_that);
      case _CheckThird():
        return third(_that);
      case _CheckFourth():
        return fourth(_that);
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
    TResult? Function(_CheckFirst value)? first,
    TResult? Function(_CheckSecond value)? second,
    TResult? Function(_CheckThird value)? third,
    TResult? Function(_CheckFourth value)? fourth,
  }) {
    final _that = this;
    switch (_that) {
      case _CheckFirst() when first != null:
        return first(_that);
      case _CheckSecond() when second != null:
        return second(_that);
      case _CheckThird() when third != null:
        return third(_that);
      case _CheckFourth() when fourth != null:
        return fourth(_that);
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
    TResult Function(dynamic value)? first,
    TResult Function(int value)? second,
    TResult Function(double value)? third,
    TResult Function(dynamic value)? fourth,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CheckFirst() when first != null:
        return first(_that.value);
      case _CheckSecond() when second != null:
        return second(_that.value);
      case _CheckThird() when third != null:
        return third(_that.value);
      case _CheckFourth() when fourth != null:
        return fourth(_that.value);
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
    required TResult Function(dynamic value) first,
    required TResult Function(int value) second,
    required TResult Function(double value) third,
    required TResult Function(dynamic value) fourth,
  }) {
    final _that = this;
    switch (_that) {
      case _CheckFirst():
        return first(_that.value);
      case _CheckSecond():
        return second(_that.value);
      case _CheckThird():
        return third(_that.value);
      case _CheckFourth():
        return fourth(_that.value);
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
    TResult? Function(dynamic value)? first,
    TResult? Function(int value)? second,
    TResult? Function(double value)? third,
    TResult? Function(dynamic value)? fourth,
  }) {
    final _that = this;
    switch (_that) {
      case _CheckFirst() when first != null:
        return first(_that.value);
      case _CheckSecond() when second != null:
        return second(_that.value);
      case _CheckThird() when third != null:
        return third(_that.value);
      case _CheckFourth() when fourth != null:
        return fourth(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CheckFirst implements Check {
  _CheckFirst({required this.value});

  @override
  final dynamic value;

  /// Create a copy of Check
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CheckFirstCopyWith<_CheckFirst> get copyWith =>
      __$CheckFirstCopyWithImpl<_CheckFirst>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CheckFirst &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'Check.first(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$CheckFirstCopyWith<$Res>
    implements $CheckCopyWith<$Res> {
  factory _$CheckFirstCopyWith(
          _CheckFirst value, $Res Function(_CheckFirst) _then) =
      __$CheckFirstCopyWithImpl;
  @useResult
  $Res call({dynamic value});
}

/// @nodoc
class __$CheckFirstCopyWithImpl<$Res> implements _$CheckFirstCopyWith<$Res> {
  __$CheckFirstCopyWithImpl(this._self, this._then);

  final _CheckFirst _self;
  final $Res Function(_CheckFirst) _then;

  /// Create a copy of Check
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_CheckFirst(
      value: freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _CheckSecond implements Check {
  _CheckSecond({required this.value});

  @override
  final int value;

  /// Create a copy of Check
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CheckSecondCopyWith<_CheckSecond> get copyWith =>
      __$CheckSecondCopyWithImpl<_CheckSecond>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CheckSecond &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'Check.second(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$CheckSecondCopyWith<$Res>
    implements $CheckCopyWith<$Res> {
  factory _$CheckSecondCopyWith(
          _CheckSecond value, $Res Function(_CheckSecond) _then) =
      __$CheckSecondCopyWithImpl;
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$CheckSecondCopyWithImpl<$Res> implements _$CheckSecondCopyWith<$Res> {
  __$CheckSecondCopyWithImpl(this._self, this._then);

  final _CheckSecond _self;
  final $Res Function(_CheckSecond) _then;

  /// Create a copy of Check
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_CheckSecond(
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _CheckThird implements Check {
  _CheckThird({required this.value});

  @override
  final double value;

  /// Create a copy of Check
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CheckThirdCopyWith<_CheckThird> get copyWith =>
      __$CheckThirdCopyWithImpl<_CheckThird>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CheckThird &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'Check.third(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$CheckThirdCopyWith<$Res>
    implements $CheckCopyWith<$Res> {
  factory _$CheckThirdCopyWith(
          _CheckThird value, $Res Function(_CheckThird) _then) =
      __$CheckThirdCopyWithImpl;
  @useResult
  $Res call({double value});
}

/// @nodoc
class __$CheckThirdCopyWithImpl<$Res> implements _$CheckThirdCopyWith<$Res> {
  __$CheckThirdCopyWithImpl(this._self, this._then);

  final _CheckThird _self;
  final $Res Function(_CheckThird) _then;

  /// Create a copy of Check
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_CheckThird(
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _CheckFourth implements Check {
  _CheckFourth({required this.value});

  @override
  final dynamic value;

  /// Create a copy of Check
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CheckFourthCopyWith<_CheckFourth> get copyWith =>
      __$CheckFourthCopyWithImpl<_CheckFourth>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CheckFourth &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'Check.fourth(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$CheckFourthCopyWith<$Res>
    implements $CheckCopyWith<$Res> {
  factory _$CheckFourthCopyWith(
          _CheckFourth value, $Res Function(_CheckFourth) _then) =
      __$CheckFourthCopyWithImpl;
  @useResult
  $Res call({dynamic value});
}

/// @nodoc
class __$CheckFourthCopyWithImpl<$Res> implements _$CheckFourthCopyWith<$Res> {
  __$CheckFourthCopyWithImpl(this._self, this._then);

  final _CheckFourth _self;
  final $Res Function(_CheckFourth) _then;

  /// Create a copy of Check
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_CheckFourth(
      value: freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
mixin _$CommonSuperSubtype {
  int? get nullabilityDifference;
  num get typeDifference;

  /// Create a copy of CommonSuperSubtype
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CommonSuperSubtypeCopyWith<CommonSuperSubtype> get copyWith =>
      _$CommonSuperSubtypeCopyWithImpl<CommonSuperSubtype>(
          this as CommonSuperSubtype, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CommonSuperSubtype &&
            (identical(other.nullabilityDifference, nullabilityDifference) ||
                other.nullabilityDifference == nullabilityDifference) &&
            (identical(other.typeDifference, typeDifference) ||
                other.typeDifference == typeDifference));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, nullabilityDifference, typeDifference);

  @override
  String toString() {
    return 'CommonSuperSubtype(nullabilityDifference: $nullabilityDifference, typeDifference: $typeDifference)';
  }
}

/// @nodoc
abstract mixin class $CommonSuperSubtypeCopyWith<$Res> {
  factory $CommonSuperSubtypeCopyWith(
          CommonSuperSubtype value, $Res Function(CommonSuperSubtype) _then) =
      _$CommonSuperSubtypeCopyWithImpl;
  @useResult
  $Res call({int nullabilityDifference});
}

/// @nodoc
class _$CommonSuperSubtypeCopyWithImpl<$Res>
    implements $CommonSuperSubtypeCopyWith<$Res> {
  _$CommonSuperSubtypeCopyWithImpl(this._self, this._then);

  final CommonSuperSubtype _self;
  final $Res Function(CommonSuperSubtype) _then;

  /// Create a copy of CommonSuperSubtype
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nullabilityDifference = null,
  }) {
    return _then(_self.copyWith(
      nullabilityDifference: null == nullabilityDifference
          ? _self.nullabilityDifference!
          : nullabilityDifference // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [CommonSuperSubtype].
extension CommonSuperSubtypePatterns on CommonSuperSubtype {
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
    TResult Function(CommonSuperSubtype0 value)? $default, {
    TResult Function(CommonSuperSubtype1 value)? named,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CommonSuperSubtype0() when $default != null:
        return $default(_that);
      case CommonSuperSubtype1() when named != null:
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
  TResult map<TResult extends Object?>(
    TResult Function(CommonSuperSubtype0 value) $default, {
    required TResult Function(CommonSuperSubtype1 value) named,
  }) {
    final _that = this;
    switch (_that) {
      case CommonSuperSubtype0():
        return $default(_that);
      case CommonSuperSubtype1():
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
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(CommonSuperSubtype0 value)? $default, {
    TResult? Function(CommonSuperSubtype1 value)? named,
  }) {
    final _that = this;
    switch (_that) {
      case CommonSuperSubtype0() when $default != null:
        return $default(_that);
      case CommonSuperSubtype1() when named != null:
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            int nullabilityDifference, int typeDifference, String? unknown)?
        $default, {
    TResult Function(int? nullabilityDifference, double typeDifference)? named,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CommonSuperSubtype0() when $default != null:
        return $default(
            _that.nullabilityDifference, _that.typeDifference, _that.unknown);
      case CommonSuperSubtype1() when named != null:
        return named(_that.nullabilityDifference, _that.typeDifference);
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
            int nullabilityDifference, int typeDifference, String? unknown)
        $default, {
    required TResult Function(int? nullabilityDifference, double typeDifference)
        named,
  }) {
    final _that = this;
    switch (_that) {
      case CommonSuperSubtype0():
        return $default(
            _that.nullabilityDifference, _that.typeDifference, _that.unknown);
      case CommonSuperSubtype1():
        return named(_that.nullabilityDifference, _that.typeDifference);
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
            int nullabilityDifference, int typeDifference, String? unknown)?
        $default, {
    TResult? Function(int? nullabilityDifference, double typeDifference)? named,
  }) {
    final _that = this;
    switch (_that) {
      case CommonSuperSubtype0() when $default != null:
        return $default(
            _that.nullabilityDifference, _that.typeDifference, _that.unknown);
      case CommonSuperSubtype1() when named != null:
        return named(_that.nullabilityDifference, _that.typeDifference);
      case _:
        return null;
    }
  }
}

/// @nodoc

class CommonSuperSubtype0 implements CommonSuperSubtype {
  const CommonSuperSubtype0(
      {required this.nullabilityDifference,
      required this.typeDifference,
      this.unknown});

  @override
  final int nullabilityDifference;
  @override
  final int typeDifference;
  final String? unknown;

  /// Create a copy of CommonSuperSubtype
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CommonSuperSubtype0CopyWith<CommonSuperSubtype0> get copyWith =>
      _$CommonSuperSubtype0CopyWithImpl<CommonSuperSubtype0>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CommonSuperSubtype0 &&
            (identical(other.nullabilityDifference, nullabilityDifference) ||
                other.nullabilityDifference == nullabilityDifference) &&
            (identical(other.typeDifference, typeDifference) ||
                other.typeDifference == typeDifference) &&
            (identical(other.unknown, unknown) || other.unknown == unknown));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, nullabilityDifference, typeDifference, unknown);

  @override
  String toString() {
    return 'CommonSuperSubtype(nullabilityDifference: $nullabilityDifference, typeDifference: $typeDifference, unknown: $unknown)';
  }
}

/// @nodoc
abstract mixin class $CommonSuperSubtype0CopyWith<$Res>
    implements $CommonSuperSubtypeCopyWith<$Res> {
  factory $CommonSuperSubtype0CopyWith(
          CommonSuperSubtype0 value, $Res Function(CommonSuperSubtype0) _then) =
      _$CommonSuperSubtype0CopyWithImpl;
  @override
  @useResult
  $Res call({int nullabilityDifference, int typeDifference, String? unknown});
}

/// @nodoc
class _$CommonSuperSubtype0CopyWithImpl<$Res>
    implements $CommonSuperSubtype0CopyWith<$Res> {
  _$CommonSuperSubtype0CopyWithImpl(this._self, this._then);

  final CommonSuperSubtype0 _self;
  final $Res Function(CommonSuperSubtype0) _then;

  /// Create a copy of CommonSuperSubtype
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? nullabilityDifference = null,
    Object? typeDifference = null,
    Object? unknown = freezed,
  }) {
    return _then(CommonSuperSubtype0(
      nullabilityDifference: null == nullabilityDifference
          ? _self.nullabilityDifference
          : nullabilityDifference // ignore: cast_nullable_to_non_nullable
              as int,
      typeDifference: null == typeDifference
          ? _self.typeDifference
          : typeDifference // ignore: cast_nullable_to_non_nullable
              as int,
      unknown: freezed == unknown
          ? _self.unknown
          : unknown // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class CommonSuperSubtype1 implements CommonSuperSubtype {
  const CommonSuperSubtype1(
      {required this.nullabilityDifference, required this.typeDifference});

  @override
  final int? nullabilityDifference;
  @override
  final double typeDifference;

  /// Create a copy of CommonSuperSubtype
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CommonSuperSubtype1CopyWith<CommonSuperSubtype1> get copyWith =>
      _$CommonSuperSubtype1CopyWithImpl<CommonSuperSubtype1>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CommonSuperSubtype1 &&
            (identical(other.nullabilityDifference, nullabilityDifference) ||
                other.nullabilityDifference == nullabilityDifference) &&
            (identical(other.typeDifference, typeDifference) ||
                other.typeDifference == typeDifference));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, nullabilityDifference, typeDifference);

  @override
  String toString() {
    return 'CommonSuperSubtype.named(nullabilityDifference: $nullabilityDifference, typeDifference: $typeDifference)';
  }
}

/// @nodoc
abstract mixin class $CommonSuperSubtype1CopyWith<$Res>
    implements $CommonSuperSubtypeCopyWith<$Res> {
  factory $CommonSuperSubtype1CopyWith(
          CommonSuperSubtype1 value, $Res Function(CommonSuperSubtype1) _then) =
      _$CommonSuperSubtype1CopyWithImpl;
  @override
  @useResult
  $Res call({int? nullabilityDifference, double typeDifference});
}

/// @nodoc
class _$CommonSuperSubtype1CopyWithImpl<$Res>
    implements $CommonSuperSubtype1CopyWith<$Res> {
  _$CommonSuperSubtype1CopyWithImpl(this._self, this._then);

  final CommonSuperSubtype1 _self;
  final $Res Function(CommonSuperSubtype1) _then;

  /// Create a copy of CommonSuperSubtype
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? nullabilityDifference = freezed,
    Object? typeDifference = null,
  }) {
    return _then(CommonSuperSubtype1(
      nullabilityDifference: freezed == nullabilityDifference
          ? _self.nullabilityDifference
          : nullabilityDifference // ignore: cast_nullable_to_non_nullable
              as int?,
      typeDifference: null == typeDifference
          ? _self.typeDifference
          : typeDifference // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$DeepCopySharedProperties {
  CommonSuperSubtype get value;

  /// Create a copy of DeepCopySharedProperties
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DeepCopySharedPropertiesCopyWith<DeepCopySharedProperties> get copyWith =>
      _$DeepCopySharedPropertiesCopyWithImpl<DeepCopySharedProperties>(
          this as DeepCopySharedProperties, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DeepCopySharedProperties &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'DeepCopySharedProperties(value: $value)';
  }
}

/// @nodoc
abstract mixin class $DeepCopySharedPropertiesCopyWith<$Res> {
  factory $DeepCopySharedPropertiesCopyWith(DeepCopySharedProperties value,
          $Res Function(DeepCopySharedProperties) _then) =
      _$DeepCopySharedPropertiesCopyWithImpl;
  @useResult
  $Res call({CommonSuperSubtype value});

  $CommonSuperSubtypeCopyWith<$Res> get value;
}

/// @nodoc
class _$DeepCopySharedPropertiesCopyWithImpl<$Res>
    implements $DeepCopySharedPropertiesCopyWith<$Res> {
  _$DeepCopySharedPropertiesCopyWithImpl(this._self, this._then);

  final DeepCopySharedProperties _self;
  final $Res Function(DeepCopySharedProperties) _then;

  /// Create a copy of DeepCopySharedProperties
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
              as CommonSuperSubtype,
    ));
  }

  /// Create a copy of DeepCopySharedProperties
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CommonSuperSubtypeCopyWith<$Res> get value {
    return $CommonSuperSubtypeCopyWith<$Res>(_self.value, (value) {
      return _then(_self.copyWith(value: value));
    });
  }
}

/// Adds pattern-matching-related methods to [DeepCopySharedProperties].
extension DeepCopySharedPropertiesPatterns on DeepCopySharedProperties {
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
    TResult Function(_DeepCopySharedProperties value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DeepCopySharedProperties() when $default != null:
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
    TResult Function(_DeepCopySharedProperties value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DeepCopySharedProperties():
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
    TResult? Function(_DeepCopySharedProperties value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DeepCopySharedProperties() when $default != null:
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
    TResult Function(CommonSuperSubtype value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DeepCopySharedProperties() when $default != null:
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
    TResult Function(CommonSuperSubtype value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DeepCopySharedProperties():
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
    TResult? Function(CommonSuperSubtype value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DeepCopySharedProperties() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DeepCopySharedProperties implements DeepCopySharedProperties {
  const _DeepCopySharedProperties(this.value);

  @override
  final CommonSuperSubtype value;

  /// Create a copy of DeepCopySharedProperties
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DeepCopySharedPropertiesCopyWith<_DeepCopySharedProperties> get copyWith =>
      __$DeepCopySharedPropertiesCopyWithImpl<_DeepCopySharedProperties>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DeepCopySharedProperties &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'DeepCopySharedProperties(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$DeepCopySharedPropertiesCopyWith<$Res>
    implements $DeepCopySharedPropertiesCopyWith<$Res> {
  factory _$DeepCopySharedPropertiesCopyWith(_DeepCopySharedProperties value,
          $Res Function(_DeepCopySharedProperties) _then) =
      __$DeepCopySharedPropertiesCopyWithImpl;
  @override
  @useResult
  $Res call({CommonSuperSubtype value});

  @override
  $CommonSuperSubtypeCopyWith<$Res> get value;
}

/// @nodoc
class __$DeepCopySharedPropertiesCopyWithImpl<$Res>
    implements _$DeepCopySharedPropertiesCopyWith<$Res> {
  __$DeepCopySharedPropertiesCopyWithImpl(this._self, this._then);

  final _DeepCopySharedProperties _self;
  final $Res Function(_DeepCopySharedProperties) _then;

  /// Create a copy of DeepCopySharedProperties
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_DeepCopySharedProperties(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as CommonSuperSubtype,
    ));
  }

  /// Create a copy of DeepCopySharedProperties
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CommonSuperSubtypeCopyWith<$Res> get value {
    return $CommonSuperSubtypeCopyWith<$Res>(_self.value, (value) {
      return _then(_self.copyWith(value: value));
    });
  }
}

/// @nodoc
mixin _$CommonUnfreezed {
  num get a;
  double get b;
  set b(double value);

  /// Create a copy of CommonUnfreezed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CommonUnfreezedCopyWith<CommonUnfreezed> get copyWith =>
      _$CommonUnfreezedCopyWithImpl<CommonUnfreezed>(
          this as CommonUnfreezed, _$identity);

  @override
  String toString() {
    return 'CommonUnfreezed(a: $a, b: $b)';
  }
}

/// @nodoc
abstract mixin class $CommonUnfreezedCopyWith<$Res> {
  factory $CommonUnfreezedCopyWith(
          CommonUnfreezed value, $Res Function(CommonUnfreezed) _then) =
      _$CommonUnfreezedCopyWithImpl;
  @useResult
  $Res call({double b});
}

/// @nodoc
class _$CommonUnfreezedCopyWithImpl<$Res>
    implements $CommonUnfreezedCopyWith<$Res> {
  _$CommonUnfreezedCopyWithImpl(this._self, this._then);

  final CommonUnfreezed _self;
  final $Res Function(CommonUnfreezed) _then;

  /// Create a copy of CommonUnfreezed
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? b = null,
  }) {
    return _then(_self.copyWith(
      b: null == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [CommonUnfreezed].
extension CommonUnfreezedPatterns on CommonUnfreezed {
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
    TResult Function(CommonUnfreezedOne value)? one,
    TResult Function(CommonUnfreezedTwo value)? two,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CommonUnfreezedOne() when one != null:
        return one(_that);
      case CommonUnfreezedTwo() when two != null:
        return two(_that);
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
    required TResult Function(CommonUnfreezedOne value) one,
    required TResult Function(CommonUnfreezedTwo value) two,
  }) {
    final _that = this;
    switch (_that) {
      case CommonUnfreezedOne():
        return one(_that);
      case CommonUnfreezedTwo():
        return two(_that);
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
    TResult? Function(CommonUnfreezedOne value)? one,
    TResult? Function(CommonUnfreezedTwo value)? two,
  }) {
    final _that = this;
    switch (_that) {
      case CommonUnfreezedOne() when one != null:
        return one(_that);
      case CommonUnfreezedTwo() when two != null:
        return two(_that);
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
    TResult Function(int a, double b)? one,
    TResult Function(num a, double b)? two,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CommonUnfreezedOne() when one != null:
        return one(_that.a, _that.b);
      case CommonUnfreezedTwo() when two != null:
        return two(_that.a, _that.b);
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
    required TResult Function(int a, double b) one,
    required TResult Function(num a, double b) two,
  }) {
    final _that = this;
    switch (_that) {
      case CommonUnfreezedOne():
        return one(_that.a, _that.b);
      case CommonUnfreezedTwo():
        return two(_that.a, _that.b);
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
    TResult? Function(int a, double b)? one,
    TResult? Function(num a, double b)? two,
  }) {
    final _that = this;
    switch (_that) {
      case CommonUnfreezedOne() when one != null:
        return one(_that.a, _that.b);
      case CommonUnfreezedTwo() when two != null:
        return two(_that.a, _that.b);
      case _:
        return null;
    }
  }
}

/// @nodoc

class CommonUnfreezedOne implements CommonUnfreezed {
  CommonUnfreezedOne({required this.a, required this.b});

  @override
  int a;
  @override
  double b;

  /// Create a copy of CommonUnfreezed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CommonUnfreezedOneCopyWith<CommonUnfreezedOne> get copyWith =>
      _$CommonUnfreezedOneCopyWithImpl<CommonUnfreezedOne>(this, _$identity);

  @override
  String toString() {
    return 'CommonUnfreezed.one(a: $a, b: $b)';
  }
}

/// @nodoc
abstract mixin class $CommonUnfreezedOneCopyWith<$Res>
    implements $CommonUnfreezedCopyWith<$Res> {
  factory $CommonUnfreezedOneCopyWith(
          CommonUnfreezedOne value, $Res Function(CommonUnfreezedOne) _then) =
      _$CommonUnfreezedOneCopyWithImpl;
  @override
  @useResult
  $Res call({int a, double b});
}

/// @nodoc
class _$CommonUnfreezedOneCopyWithImpl<$Res>
    implements $CommonUnfreezedOneCopyWith<$Res> {
  _$CommonUnfreezedOneCopyWithImpl(this._self, this._then);

  final CommonUnfreezedOne _self;
  final $Res Function(CommonUnfreezedOne) _then;

  /// Create a copy of CommonUnfreezed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
    Object? b = null,
  }) {
    return _then(CommonUnfreezedOne(
      a: null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
      b: null == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class CommonUnfreezedTwo implements CommonUnfreezed {
  CommonUnfreezedTwo({required this.a, required this.b});

  @override
  num a;
  @override
  double b;

  /// Create a copy of CommonUnfreezed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CommonUnfreezedTwoCopyWith<CommonUnfreezedTwo> get copyWith =>
      _$CommonUnfreezedTwoCopyWithImpl<CommonUnfreezedTwo>(this, _$identity);

  @override
  String toString() {
    return 'CommonUnfreezed.two(a: $a, b: $b)';
  }
}

/// @nodoc
abstract mixin class $CommonUnfreezedTwoCopyWith<$Res>
    implements $CommonUnfreezedCopyWith<$Res> {
  factory $CommonUnfreezedTwoCopyWith(
          CommonUnfreezedTwo value, $Res Function(CommonUnfreezedTwo) _then) =
      _$CommonUnfreezedTwoCopyWithImpl;
  @override
  @useResult
  $Res call({num a, double b});
}

/// @nodoc
class _$CommonUnfreezedTwoCopyWithImpl<$Res>
    implements $CommonUnfreezedTwoCopyWith<$Res> {
  _$CommonUnfreezedTwoCopyWithImpl(this._self, this._then);

  final CommonUnfreezedTwo _self;
  final $Res Function(CommonUnfreezedTwo) _then;

  /// Create a copy of CommonUnfreezed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
    Object? b = null,
  }) {
    return _then(CommonUnfreezedTwo(
      a: null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as num,
      b: null == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$CommonUnfreezed2 {
  num get a;
  double get b;
  set b(double value);

  /// Create a copy of CommonUnfreezed2
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CommonUnfreezed2CopyWith<CommonUnfreezed2> get copyWith =>
      _$CommonUnfreezed2CopyWithImpl<CommonUnfreezed2>(
          this as CommonUnfreezed2, _$identity);

  @override
  String toString() {
    return 'CommonUnfreezed2(a: $a, b: $b)';
  }
}

/// @nodoc
abstract mixin class $CommonUnfreezed2CopyWith<$Res> {
  factory $CommonUnfreezed2CopyWith(
          CommonUnfreezed2 value, $Res Function(CommonUnfreezed2) _then) =
      _$CommonUnfreezed2CopyWithImpl;
  @useResult
  $Res call({double b});
}

/// @nodoc
class _$CommonUnfreezed2CopyWithImpl<$Res>
    implements $CommonUnfreezed2CopyWith<$Res> {
  _$CommonUnfreezed2CopyWithImpl(this._self, this._then);

  final CommonUnfreezed2 _self;
  final $Res Function(CommonUnfreezed2) _then;

  /// Create a copy of CommonUnfreezed2
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? b = null,
  }) {
    return _then(_self.copyWith(
      b: null == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [CommonUnfreezed2].
extension CommonUnfreezed2Patterns on CommonUnfreezed2 {
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
    TResult Function(CommonUnfreezedTwo2 value)? two,
    TResult Function(CommonUnfreezedOne2 value)? one,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CommonUnfreezedTwo2() when two != null:
        return two(_that);
      case CommonUnfreezedOne2() when one != null:
        return one(_that);
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
    required TResult Function(CommonUnfreezedTwo2 value) two,
    required TResult Function(CommonUnfreezedOne2 value) one,
  }) {
    final _that = this;
    switch (_that) {
      case CommonUnfreezedTwo2():
        return two(_that);
      case CommonUnfreezedOne2():
        return one(_that);
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
    TResult? Function(CommonUnfreezedTwo2 value)? two,
    TResult? Function(CommonUnfreezedOne2 value)? one,
  }) {
    final _that = this;
    switch (_that) {
      case CommonUnfreezedTwo2() when two != null:
        return two(_that);
      case CommonUnfreezedOne2() when one != null:
        return one(_that);
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
    TResult Function(num a, double b)? two,
    TResult Function(int a, double b)? one,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CommonUnfreezedTwo2() when two != null:
        return two(_that.a, _that.b);
      case CommonUnfreezedOne2() when one != null:
        return one(_that.a, _that.b);
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
    required TResult Function(num a, double b) two,
    required TResult Function(int a, double b) one,
  }) {
    final _that = this;
    switch (_that) {
      case CommonUnfreezedTwo2():
        return two(_that.a, _that.b);
      case CommonUnfreezedOne2():
        return one(_that.a, _that.b);
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
    TResult? Function(num a, double b)? two,
    TResult? Function(int a, double b)? one,
  }) {
    final _that = this;
    switch (_that) {
      case CommonUnfreezedTwo2() when two != null:
        return two(_that.a, _that.b);
      case CommonUnfreezedOne2() when one != null:
        return one(_that.a, _that.b);
      case _:
        return null;
    }
  }
}

/// @nodoc

class CommonUnfreezedTwo2 implements CommonUnfreezed2 {
  CommonUnfreezedTwo2({required this.a, required this.b});

  @override
  num a;
  @override
  double b;

  /// Create a copy of CommonUnfreezed2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CommonUnfreezedTwo2CopyWith<CommonUnfreezedTwo2> get copyWith =>
      _$CommonUnfreezedTwo2CopyWithImpl<CommonUnfreezedTwo2>(this, _$identity);

  @override
  String toString() {
    return 'CommonUnfreezed2.two(a: $a, b: $b)';
  }
}

/// @nodoc
abstract mixin class $CommonUnfreezedTwo2CopyWith<$Res>
    implements $CommonUnfreezed2CopyWith<$Res> {
  factory $CommonUnfreezedTwo2CopyWith(
          CommonUnfreezedTwo2 value, $Res Function(CommonUnfreezedTwo2) _then) =
      _$CommonUnfreezedTwo2CopyWithImpl;
  @override
  @useResult
  $Res call({num a, double b});
}

/// @nodoc
class _$CommonUnfreezedTwo2CopyWithImpl<$Res>
    implements $CommonUnfreezedTwo2CopyWith<$Res> {
  _$CommonUnfreezedTwo2CopyWithImpl(this._self, this._then);

  final CommonUnfreezedTwo2 _self;
  final $Res Function(CommonUnfreezedTwo2) _then;

  /// Create a copy of CommonUnfreezed2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
    Object? b = null,
  }) {
    return _then(CommonUnfreezedTwo2(
      a: null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as num,
      b: null == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class CommonUnfreezedOne2 implements CommonUnfreezed2 {
  CommonUnfreezedOne2({required this.a, required this.b});

  @override
  int a;
  @override
  double b;

  /// Create a copy of CommonUnfreezed2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CommonUnfreezedOne2CopyWith<CommonUnfreezedOne2> get copyWith =>
      _$CommonUnfreezedOne2CopyWithImpl<CommonUnfreezedOne2>(this, _$identity);

  @override
  String toString() {
    return 'CommonUnfreezed2.one(a: $a, b: $b)';
  }
}

/// @nodoc
abstract mixin class $CommonUnfreezedOne2CopyWith<$Res>
    implements $CommonUnfreezed2CopyWith<$Res> {
  factory $CommonUnfreezedOne2CopyWith(
          CommonUnfreezedOne2 value, $Res Function(CommonUnfreezedOne2) _then) =
      _$CommonUnfreezedOne2CopyWithImpl;
  @override
  @useResult
  $Res call({int a, double b});
}

/// @nodoc
class _$CommonUnfreezedOne2CopyWithImpl<$Res>
    implements $CommonUnfreezedOne2CopyWith<$Res> {
  _$CommonUnfreezedOne2CopyWithImpl(this._self, this._then);

  final CommonUnfreezedOne2 _self;
  final $Res Function(CommonUnfreezedOne2) _then;

  /// Create a copy of CommonUnfreezed2
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
    Object? b = null,
  }) {
    return _then(CommonUnfreezedOne2(
      a: null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
      b: null == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}
