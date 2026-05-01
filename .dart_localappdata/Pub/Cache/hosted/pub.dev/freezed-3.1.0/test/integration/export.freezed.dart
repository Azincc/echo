// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'export.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Export {
  int get a;

  /// Create a copy of Export
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExportCopyWith<Export> get copyWith =>
      _$ExportCopyWithImpl<Export>(this as Export, _$identity);

  /// Serializes this Export to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Export &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'Export(a: $a)';
  }
}

/// @nodoc
abstract mixin class $ExportCopyWith<$Res> {
  factory $ExportCopyWith(Export value, $Res Function(Export) _then) =
      _$ExportCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$ExportCopyWithImpl<$Res> implements $ExportCopyWith<$Res> {
  _$ExportCopyWithImpl(this._self, this._then);

  final Export _self;
  final $Res Function(Export) _then;

  /// Create a copy of Export
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

/// Adds pattern-matching-related methods to [Export].
extension ExportPatterns on Export {
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
    TResult Function(_Export value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Export() when $default != null:
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
    TResult Function(_Export value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Export():
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
    TResult? Function(_Export value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Export() when $default != null:
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
      case _Export() when $default != null:
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
      case _Export():
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
      case _Export() when $default != null:
        return $default(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Export implements Export {
  const _Export(this.a);
  factory _Export.fromJson(Map<String, dynamic> json) => _$ExportFromJson(json);

  @override
  final int a;

  /// Create a copy of Export
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExportCopyWith<_Export> get copyWith =>
      __$ExportCopyWithImpl<_Export>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExportToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Export &&
            (identical(other.a, a) || other.a == a));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'Export(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$ExportCopyWith<$Res> implements $ExportCopyWith<$Res> {
  factory _$ExportCopyWith(_Export value, $Res Function(_Export) _then) =
      __$ExportCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$ExportCopyWithImpl<$Res> implements _$ExportCopyWith<$Res> {
  __$ExportCopyWithImpl(this._self, this._then);

  final _Export _self;
  final $Res Function(_Export) _then;

  /// Create a copy of Export
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_Export(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}
