// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'typedef_parameter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClassWithTypedef {
  MyTypedef get myTypedef;
  MyTypedef? get maybeTypedef;
  ExternalTypedef get externalTypedef;
  two.ExternalTypedefTwo get externalTypedefTwo;
  GenericTypedef<int, bool> get genericTypedef;

  /// Create a copy of ClassWithTypedef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ClassWithTypedefCopyWith<ClassWithTypedef> get copyWith =>
      _$ClassWithTypedefCopyWithImpl<ClassWithTypedef>(
          this as ClassWithTypedef, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ClassWithTypedef &&
            (identical(other.myTypedef, myTypedef) ||
                other.myTypedef == myTypedef) &&
            (identical(other.maybeTypedef, maybeTypedef) ||
                other.maybeTypedef == maybeTypedef) &&
            (identical(other.externalTypedef, externalTypedef) ||
                other.externalTypedef == externalTypedef) &&
            (identical(other.externalTypedefTwo, externalTypedefTwo) ||
                other.externalTypedefTwo == externalTypedefTwo) &&
            (identical(other.genericTypedef, genericTypedef) ||
                other.genericTypedef == genericTypedef));
  }

  @override
  int get hashCode => Object.hash(runtimeType, myTypedef, maybeTypedef,
      externalTypedef, externalTypedefTwo, genericTypedef);

  @override
  String toString() {
    return 'ClassWithTypedef(myTypedef: $myTypedef, maybeTypedef: $maybeTypedef, externalTypedef: $externalTypedef, externalTypedefTwo: $externalTypedefTwo, genericTypedef: $genericTypedef)';
  }
}

/// @nodoc
abstract mixin class $ClassWithTypedefCopyWith<$Res> {
  factory $ClassWithTypedefCopyWith(
          ClassWithTypedef value, $Res Function(ClassWithTypedef) _then) =
      _$ClassWithTypedefCopyWithImpl;
  @useResult
  $Res call(
      {MyTypedef myTypedef,
      MyTypedef? maybeTypedef,
      ExternalTypedef externalTypedef,
      two.ExternalTypedefTwo externalTypedefTwo,
      GenericTypedef<int, bool> genericTypedef});
}

/// @nodoc
class _$ClassWithTypedefCopyWithImpl<$Res>
    implements $ClassWithTypedefCopyWith<$Res> {
  _$ClassWithTypedefCopyWithImpl(this._self, this._then);

  final ClassWithTypedef _self;
  final $Res Function(ClassWithTypedef) _then;

  /// Create a copy of ClassWithTypedef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? myTypedef = null,
    Object? maybeTypedef = freezed,
    Object? externalTypedef = null,
    Object? externalTypedefTwo = null,
    Object? genericTypedef = null,
  }) {
    return _then(_self.copyWith(
      myTypedef: null == myTypedef
          ? _self.myTypedef
          : myTypedef // ignore: cast_nullable_to_non_nullable
              as MyTypedef,
      maybeTypedef: freezed == maybeTypedef
          ? _self.maybeTypedef
          : maybeTypedef // ignore: cast_nullable_to_non_nullable
              as MyTypedef?,
      externalTypedef: null == externalTypedef
          ? _self.externalTypedef
          : externalTypedef // ignore: cast_nullable_to_non_nullable
              as ExternalTypedef,
      externalTypedefTwo: null == externalTypedefTwo
          ? _self.externalTypedefTwo
          : externalTypedefTwo // ignore: cast_nullable_to_non_nullable
              as two.ExternalTypedefTwo,
      genericTypedef: null == genericTypedef
          ? _self.genericTypedef
          : genericTypedef // ignore: cast_nullable_to_non_nullable
              as GenericTypedef<int, bool>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ClassWithTypedef].
extension ClassWithTypedefPatterns on ClassWithTypedef {
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
    TResult Function(_ClassWithTypedef value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClassWithTypedef() when $default != null:
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
    TResult Function(_ClassWithTypedef value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClassWithTypedef():
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
    TResult? Function(_ClassWithTypedef value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClassWithTypedef() when $default != null:
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
            MyTypedef myTypedef,
            MyTypedef? maybeTypedef,
            ExternalTypedef externalTypedef,
            two.ExternalTypedefTwo externalTypedefTwo,
            GenericTypedef<int, bool> genericTypedef)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClassWithTypedef() when $default != null:
        return $default(
            _that.myTypedef,
            _that.maybeTypedef,
            _that.externalTypedef,
            _that.externalTypedefTwo,
            _that.genericTypedef);
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
            MyTypedef myTypedef,
            MyTypedef? maybeTypedef,
            ExternalTypedef externalTypedef,
            two.ExternalTypedefTwo externalTypedefTwo,
            GenericTypedef<int, bool> genericTypedef)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClassWithTypedef():
        return $default(
            _that.myTypedef,
            _that.maybeTypedef,
            _that.externalTypedef,
            _that.externalTypedefTwo,
            _that.genericTypedef);
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
            MyTypedef myTypedef,
            MyTypedef? maybeTypedef,
            ExternalTypedef externalTypedef,
            two.ExternalTypedefTwo externalTypedefTwo,
            GenericTypedef<int, bool> genericTypedef)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClassWithTypedef() when $default != null:
        return $default(
            _that.myTypedef,
            _that.maybeTypedef,
            _that.externalTypedef,
            _that.externalTypedefTwo,
            _that.genericTypedef);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ClassWithTypedef extends ClassWithTypedef {
  _ClassWithTypedef(this.myTypedef, this.maybeTypedef, this.externalTypedef,
      this.externalTypedefTwo, this.genericTypedef)
      : super._();

  @override
  final MyTypedef myTypedef;
  @override
  final MyTypedef? maybeTypedef;
  @override
  final ExternalTypedef externalTypedef;
  @override
  final two.ExternalTypedefTwo externalTypedefTwo;
  @override
  final GenericTypedef<int, bool> genericTypedef;

  /// Create a copy of ClassWithTypedef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ClassWithTypedefCopyWith<_ClassWithTypedef> get copyWith =>
      __$ClassWithTypedefCopyWithImpl<_ClassWithTypedef>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ClassWithTypedef &&
            (identical(other.myTypedef, myTypedef) ||
                other.myTypedef == myTypedef) &&
            (identical(other.maybeTypedef, maybeTypedef) ||
                other.maybeTypedef == maybeTypedef) &&
            (identical(other.externalTypedef, externalTypedef) ||
                other.externalTypedef == externalTypedef) &&
            (identical(other.externalTypedefTwo, externalTypedefTwo) ||
                other.externalTypedefTwo == externalTypedefTwo) &&
            (identical(other.genericTypedef, genericTypedef) ||
                other.genericTypedef == genericTypedef));
  }

  @override
  int get hashCode => Object.hash(runtimeType, myTypedef, maybeTypedef,
      externalTypedef, externalTypedefTwo, genericTypedef);

  @override
  String toString() {
    return 'ClassWithTypedef(myTypedef: $myTypedef, maybeTypedef: $maybeTypedef, externalTypedef: $externalTypedef, externalTypedefTwo: $externalTypedefTwo, genericTypedef: $genericTypedef)';
  }
}

/// @nodoc
abstract mixin class _$ClassWithTypedefCopyWith<$Res>
    implements $ClassWithTypedefCopyWith<$Res> {
  factory _$ClassWithTypedefCopyWith(
          _ClassWithTypedef value, $Res Function(_ClassWithTypedef) _then) =
      __$ClassWithTypedefCopyWithImpl;
  @override
  @useResult
  $Res call(
      {MyTypedef myTypedef,
      MyTypedef? maybeTypedef,
      ExternalTypedef externalTypedef,
      two.ExternalTypedefTwo externalTypedefTwo,
      GenericTypedef<int, bool> genericTypedef});
}

/// @nodoc
class __$ClassWithTypedefCopyWithImpl<$Res>
    implements _$ClassWithTypedefCopyWith<$Res> {
  __$ClassWithTypedefCopyWithImpl(this._self, this._then);

  final _ClassWithTypedef _self;
  final $Res Function(_ClassWithTypedef) _then;

  /// Create a copy of ClassWithTypedef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? myTypedef = null,
    Object? maybeTypedef = freezed,
    Object? externalTypedef = null,
    Object? externalTypedefTwo = null,
    Object? genericTypedef = null,
  }) {
    return _then(_ClassWithTypedef(
      null == myTypedef
          ? _self.myTypedef
          : myTypedef // ignore: cast_nullable_to_non_nullable
              as MyTypedef,
      freezed == maybeTypedef
          ? _self.maybeTypedef
          : maybeTypedef // ignore: cast_nullable_to_non_nullable
              as MyTypedef?,
      null == externalTypedef
          ? _self.externalTypedef
          : externalTypedef // ignore: cast_nullable_to_non_nullable
              as ExternalTypedef,
      null == externalTypedefTwo
          ? _self.externalTypedefTwo
          : externalTypedefTwo // ignore: cast_nullable_to_non_nullable
              as two.ExternalTypedefTwo,
      null == genericTypedef
          ? _self.genericTypedef
          : genericTypedef // ignore: cast_nullable_to_non_nullable
              as GenericTypedef<int, bool>,
    ));
  }
}
