// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diagnostics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DiagnosticsExample implements DiagnosticableTreeMixin {
  int? get value;

  /// Create a copy of DiagnosticsExample
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DiagnosticsExampleCopyWith<DiagnosticsExample> get copyWith =>
      _$DiagnosticsExampleCopyWithImpl<DiagnosticsExample>(
          this as DiagnosticsExample, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'DiagnosticsExample'))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DiagnosticsExample &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DiagnosticsExample(value: $value)';
  }
}

/// @nodoc
abstract mixin class $DiagnosticsExampleCopyWith<$Res> {
  factory $DiagnosticsExampleCopyWith(
          DiagnosticsExample value, $Res Function(DiagnosticsExample) _then) =
      _$DiagnosticsExampleCopyWithImpl;
  @useResult
  $Res call({int? value});
}

/// @nodoc
class _$DiagnosticsExampleCopyWithImpl<$Res>
    implements $DiagnosticsExampleCopyWith<$Res> {
  _$DiagnosticsExampleCopyWithImpl(this._self, this._then);

  final DiagnosticsExample _self;
  final $Res Function(DiagnosticsExample) _then;

  /// Create a copy of DiagnosticsExample
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
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [DiagnosticsExample].
extension DiagnosticsExamplePatterns on DiagnosticsExample {
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
    TResult Function(_DiagnosticsExample value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DiagnosticsExample() when $default != null:
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
    TResult Function(_DiagnosticsExample value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DiagnosticsExample():
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
    TResult? Function(_DiagnosticsExample value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DiagnosticsExample() when $default != null:
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
    TResult Function(int? value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DiagnosticsExample() when $default != null:
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
    TResult Function(int? value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DiagnosticsExample():
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
    TResult? Function(int? value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DiagnosticsExample() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DiagnosticsExample
    with DiagnosticableTreeMixin
    implements DiagnosticsExample {
  const _DiagnosticsExample({this.value});

  @override
  final int? value;

  /// Create a copy of DiagnosticsExample
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DiagnosticsExampleCopyWith<_DiagnosticsExample> get copyWith =>
      __$DiagnosticsExampleCopyWithImpl<_DiagnosticsExample>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'DiagnosticsExample'))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DiagnosticsExample &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DiagnosticsExample(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$DiagnosticsExampleCopyWith<$Res>
    implements $DiagnosticsExampleCopyWith<$Res> {
  factory _$DiagnosticsExampleCopyWith(
          _DiagnosticsExample value, $Res Function(_DiagnosticsExample) _then) =
      __$DiagnosticsExampleCopyWithImpl;
  @override
  @useResult
  $Res call({int? value});
}

/// @nodoc
class __$DiagnosticsExampleCopyWithImpl<$Res>
    implements _$DiagnosticsExampleCopyWith<$Res> {
  __$DiagnosticsExampleCopyWithImpl(this._self, this._then);

  final _DiagnosticsExample _self;
  final $Res Function(_DiagnosticsExample) _then;

  /// Create a copy of DiagnosticsExample
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_DiagnosticsExample(
      value: freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}
