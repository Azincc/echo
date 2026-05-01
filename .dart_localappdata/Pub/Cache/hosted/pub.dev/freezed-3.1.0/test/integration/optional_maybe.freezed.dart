// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'optional_maybe.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OptionalMaybeMap {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OptionalMaybeMap);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OptionalMaybeMap()';
  }
}

/// @nodoc
class $OptionalMaybeMapCopyWith<$Res> {
  $OptionalMaybeMapCopyWith(
      OptionalMaybeMap _, $Res Function(OptionalMaybeMap) __);
}

/// Adds pattern-matching-related methods to [OptionalMaybeMap].
extension OptionalMaybeMapPatterns on OptionalMaybeMap {
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
    TResult Function()? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case OptionalMaybeMap1() when first != null:
        return first();
      case OptionalMaybeMap2() when second != null:
        return second();
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
    required TResult Function() second,
  }) {
    final _that = this;
    switch (_that) {
      case OptionalMaybeMap1():
        return first();
      case OptionalMaybeMap2():
        return second();
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
    TResult? Function()? second,
  }) {
    final _that = this;
    switch (_that) {
      case OptionalMaybeMap1() when first != null:
        return first();
      case OptionalMaybeMap2() when second != null:
        return second();
      case _:
        return null;
    }
  }
}

/// @nodoc

class OptionalMaybeMap1 implements OptionalMaybeMap {
  const OptionalMaybeMap1();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OptionalMaybeMap1);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OptionalMaybeMap.first()';
  }
}

/// @nodoc

class OptionalMaybeMap2 implements OptionalMaybeMap {
  const OptionalMaybeMap2();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OptionalMaybeMap2);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OptionalMaybeMap.second()';
  }
}

/// @nodoc
mixin _$OptionalMaybeWhen {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OptionalMaybeWhen);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OptionalMaybeWhen()';
  }
}

/// @nodoc
class $OptionalMaybeWhenCopyWith<$Res> {
  $OptionalMaybeWhenCopyWith(
      OptionalMaybeWhen _, $Res Function(OptionalMaybeWhen) __);
}

/// Adds pattern-matching-related methods to [OptionalMaybeWhen].
extension OptionalMaybeWhenPatterns on OptionalMaybeWhen {
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
    TResult Function(OptionalMaybeWhen1 value)? first,
    TResult Function(OptionalMaybeWhen2 value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case OptionalMaybeWhen1() when first != null:
        return first(_that);
      case OptionalMaybeWhen2() when second != null:
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
    required TResult Function(OptionalMaybeWhen1 value) first,
    required TResult Function(OptionalMaybeWhen2 value) second,
  }) {
    final _that = this;
    switch (_that) {
      case OptionalMaybeWhen1():
        return first(_that);
      case OptionalMaybeWhen2():
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
    TResult? Function(OptionalMaybeWhen1 value)? first,
    TResult? Function(OptionalMaybeWhen2 value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case OptionalMaybeWhen1() when first != null:
        return first(_that);
      case OptionalMaybeWhen2() when second != null:
        return second(_that);
      case _:
        return null;
    }
  }
}

/// @nodoc

class OptionalMaybeWhen1 implements OptionalMaybeWhen {
  const OptionalMaybeWhen1();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OptionalMaybeWhen1);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OptionalMaybeWhen.first()';
  }
}

/// @nodoc

class OptionalMaybeWhen2 implements OptionalMaybeWhen {
  const OptionalMaybeWhen2();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OptionalMaybeWhen2);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OptionalMaybeWhen.second()';
  }
}

/// @nodoc
mixin _$OptionalCopyWith {
  int? get a;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OptionalCopyWith &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'OptionalCopyWith(a: $a)';
  }
}

/// Adds pattern-matching-related methods to [OptionalCopyWith].
extension OptionalCopyWithPatterns on OptionalCopyWith {
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
    TResult Function(_OptionalCopyWith value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OptionalCopyWith() when $default != null:
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
    TResult Function(_OptionalCopyWith value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OptionalCopyWith():
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
    TResult? Function(_OptionalCopyWith value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OptionalCopyWith() when $default != null:
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
      case _OptionalCopyWith() when $default != null:
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
      case _OptionalCopyWith():
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
      case _OptionalCopyWith() when $default != null:
        return $default(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _OptionalCopyWith implements OptionalCopyWith {
  const _OptionalCopyWith([this.a]);

  @override
  final int? a;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OptionalCopyWith &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'OptionalCopyWith(a: $a)';
  }
}

/// @nodoc
mixin _$OptionalToString {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OptionalToString);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

/// @nodoc
class $OptionalToStringCopyWith<$Res> {
  $OptionalToStringCopyWith(
      OptionalToString _, $Res Function(OptionalToString) __);
}

/// Adds pattern-matching-related methods to [OptionalToString].
extension OptionalToStringPatterns on OptionalToString {
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
    TResult Function(_OptionalToString value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OptionalToString() when $default != null:
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
    TResult Function(_OptionalToString value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OptionalToString():
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
    TResult? Function(_OptionalToString value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OptionalToString() when $default != null:
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
      case _OptionalToString() when $default != null:
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
      case _OptionalToString():
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
      case _OptionalToString() when $default != null:
        return $default();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _OptionalToString implements OptionalToString {
  const _OptionalToString();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _OptionalToString);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

/// @nodoc
mixin _$OptionalEqual {
  @override
  String toString() {
    return 'OptionalEqual()';
  }
}

/// @nodoc
class $OptionalEqualCopyWith<$Res> {
  $OptionalEqualCopyWith(OptionalEqual _, $Res Function(OptionalEqual) __);
}

/// Adds pattern-matching-related methods to [OptionalEqual].
extension OptionalEqualPatterns on OptionalEqual {
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
    TResult Function(_OptionalEqual value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OptionalEqual() when $default != null:
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
    TResult Function(_OptionalEqual value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OptionalEqual():
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
    TResult? Function(_OptionalEqual value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OptionalEqual() when $default != null:
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
      case _OptionalEqual() when $default != null:
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
      case _OptionalEqual():
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
      case _OptionalEqual() when $default != null:
        return $default();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _OptionalEqual implements OptionalEqual {
  _OptionalEqual();

  @override
  String toString() {
    return 'OptionalEqual()';
  }
}

/// @nodoc
mixin _$ForceUnionMethod {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ForceUnionMethod);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ForceUnionMethod()';
  }
}

/// @nodoc
class $ForceUnionMethodCopyWith<$Res> {
  $ForceUnionMethodCopyWith(
      ForceUnionMethod _, $Res Function(ForceUnionMethod) __);
}

/// Adds pattern-matching-related methods to [ForceUnionMethod].
extension ForceUnionMethodPatterns on ForceUnionMethod {
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
    TResult Function(_ForceUnionMethod value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ForceUnionMethod() when $default != null:
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
    TResult Function(_ForceUnionMethod value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ForceUnionMethod():
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
    TResult? Function(_ForceUnionMethod value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ForceUnionMethod() when $default != null:
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
      case _ForceUnionMethod() when $default != null:
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
      case _ForceUnionMethod():
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
      case _ForceUnionMethod() when $default != null:
        return $default();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ForceUnionMethod implements ForceUnionMethod {
  _ForceUnionMethod();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ForceUnionMethod);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ForceUnionMethod()';
  }
}

/// @nodoc
mixin _$ForceUnionMethod2 {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ForceUnionMethod2);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ForceUnionMethod2()';
  }
}

/// @nodoc
class $ForceUnionMethod2CopyWith<$Res> {
  $ForceUnionMethod2CopyWith(
      ForceUnionMethod2 _, $Res Function(ForceUnionMethod2) __);
}

/// Adds pattern-matching-related methods to [ForceUnionMethod2].
extension ForceUnionMethod2Patterns on ForceUnionMethod2 {
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
    TResult Function(_ForceUnionMethod2 value)? two,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ForceUnionMethod2() when two != null:
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
    required TResult Function(_ForceUnionMethod2 value) two,
  }) {
    final _that = this;
    switch (_that) {
      case _ForceUnionMethod2():
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
    TResult? Function(_ForceUnionMethod2 value)? two,
  }) {
    final _that = this;
    switch (_that) {
      case _ForceUnionMethod2() when two != null:
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
    TResult Function()? two,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ForceUnionMethod2() when two != null:
        return two();
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
    required TResult Function() two,
  }) {
    final _that = this;
    switch (_that) {
      case _ForceUnionMethod2():
        return two();
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
    TResult? Function()? two,
  }) {
    final _that = this;
    switch (_that) {
      case _ForceUnionMethod2() when two != null:
        return two();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ForceUnionMethod2 implements ForceUnionMethod2 {
  _ForceUnionMethod2();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ForceUnionMethod2);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ForceUnionMethod2.two()';
  }
}

/// @nodoc
mixin _$OptionalToJson {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OptionalToJson);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OptionalToJson()';
  }
}

/// @nodoc
class $OptionalToJsonCopyWith<$Res> {
  $OptionalToJsonCopyWith(OptionalToJson _, $Res Function(OptionalToJson) __);
}

/// Adds pattern-matching-related methods to [OptionalToJson].
extension OptionalToJsonPatterns on OptionalToJson {
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
    TResult Function(_OptionalToJson value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OptionalToJson() when $default != null:
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
    TResult Function(_OptionalToJson value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OptionalToJson():
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
    TResult? Function(_OptionalToJson value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OptionalToJson() when $default != null:
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
      case _OptionalToJson() when $default != null:
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
      case _OptionalToJson():
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
      case _OptionalToJson() when $default != null:
        return $default();
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable(createToJson: false)
class _OptionalToJson implements OptionalToJson {
  _OptionalToJson();
  factory _OptionalToJson.fromJson(Map<String, dynamic> json) =>
      _$OptionalToJsonFromJson(json);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _OptionalToJson);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'OptionalToJson()';
  }
}

/// @nodoc
mixin _$ForceToJson {
  int get a;

  /// Create a copy of ForceToJson
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ForceToJsonCopyWith<ForceToJson> get copyWith =>
      _$ForceToJsonCopyWithImpl<ForceToJson>(this as ForceToJson, _$identity);

  /// Serializes this ForceToJson to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ForceToJson &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'ForceToJson(a: $a)';
  }
}

/// @nodoc
abstract mixin class $ForceToJsonCopyWith<$Res> {
  factory $ForceToJsonCopyWith(
          ForceToJson value, $Res Function(ForceToJson) _then) =
      _$ForceToJsonCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$ForceToJsonCopyWithImpl<$Res> implements $ForceToJsonCopyWith<$Res> {
  _$ForceToJsonCopyWithImpl(this._self, this._then);

  final ForceToJson _self;
  final $Res Function(ForceToJson) _then;

  /// Create a copy of ForceToJson
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

/// Adds pattern-matching-related methods to [ForceToJson].
extension ForceToJsonPatterns on ForceToJson {
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
    TResult Function(_ForceToJson value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ForceToJson() when $default != null:
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
    TResult Function(_ForceToJson value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ForceToJson():
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
    TResult? Function(_ForceToJson value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ForceToJson() when $default != null:
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
      case _ForceToJson() when $default != null:
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
      case _ForceToJson():
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
      case _ForceToJson() when $default != null:
        return $default(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable(createFactory: false)
class _ForceToJson implements ForceToJson {
  _ForceToJson(this.a);

  @override
  final int a;

  /// Create a copy of ForceToJson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ForceToJsonCopyWith<_ForceToJson> get copyWith =>
      __$ForceToJsonCopyWithImpl<_ForceToJson>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ForceToJsonToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ForceToJson &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'ForceToJson(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$ForceToJsonCopyWith<$Res>
    implements $ForceToJsonCopyWith<$Res> {
  factory _$ForceToJsonCopyWith(
          _ForceToJson value, $Res Function(_ForceToJson) _then) =
      __$ForceToJsonCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$ForceToJsonCopyWithImpl<$Res> implements _$ForceToJsonCopyWith<$Res> {
  __$ForceToJsonCopyWithImpl(this._self, this._then);

  final _ForceToJson _self;
  final $Res Function(_ForceToJson) _then;

  /// Create a copy of ForceToJson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_ForceToJson(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}
