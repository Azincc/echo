// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'concrete.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EmptyExtends {
  int get value;

  /// Create a copy of EmptyExtends
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EmptyExtendsCopyWith<EmptyExtends> get copyWith =>
      _$EmptyExtendsCopyWithImpl<EmptyExtends>(
          this as EmptyExtends, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EmptyExtends &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'EmptyExtends(value: $value)';
  }
}

/// @nodoc
abstract mixin class $EmptyExtendsCopyWith<$Res> {
  factory $EmptyExtendsCopyWith(
          EmptyExtends value, $Res Function(EmptyExtends) _then) =
      _$EmptyExtendsCopyWithImpl;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$EmptyExtendsCopyWithImpl<$Res> implements $EmptyExtendsCopyWith<$Res> {
  _$EmptyExtendsCopyWithImpl(this._self, this._then);

  final EmptyExtends _self;
  final $Res Function(EmptyExtends) _then;

  /// Create a copy of EmptyExtends
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

/// Adds pattern-matching-related methods to [EmptyExtends].
extension EmptyExtendsPatterns on EmptyExtends {
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
    TResult Function(_EmptyExtends value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EmptyExtends() when $default != null:
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
    TResult Function(_EmptyExtends value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EmptyExtends():
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
    TResult? Function(_EmptyExtends value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EmptyExtends() when $default != null:
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
      case _EmptyExtends() when $default != null:
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
      case _EmptyExtends():
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
      case _EmptyExtends() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _EmptyExtends extends EmptyExtends {
  _EmptyExtends(this.value) : super._();

  @override
  final int value;

  /// Create a copy of EmptyExtends
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EmptyExtendsCopyWith<_EmptyExtends> get copyWith =>
      __$EmptyExtendsCopyWithImpl<_EmptyExtends>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EmptyExtends &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'EmptyExtends(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$EmptyExtendsCopyWith<$Res>
    implements $EmptyExtendsCopyWith<$Res> {
  factory _$EmptyExtendsCopyWith(
          _EmptyExtends value, $Res Function(_EmptyExtends) _then) =
      __$EmptyExtendsCopyWithImpl;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$EmptyExtendsCopyWithImpl<$Res>
    implements _$EmptyExtendsCopyWith<$Res> {
  __$EmptyExtendsCopyWithImpl(this._self, this._then);

  final _EmptyExtends _self;
  final $Res Function(_EmptyExtends) _then;

  /// Create a copy of EmptyExtends
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_EmptyExtends(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$Concrete {
  int get value;

  /// Create a copy of Concrete
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConcreteCopyWith<Concrete> get copyWith =>
      _$ConcreteCopyWithImpl<Concrete>(this as Concrete, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Concrete &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'Concrete(value: $value)';
  }
}

/// @nodoc
abstract mixin class $ConcreteCopyWith<$Res> {
  factory $ConcreteCopyWith(Concrete value, $Res Function(Concrete) _then) =
      _$ConcreteCopyWithImpl;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$ConcreteCopyWithImpl<$Res> implements $ConcreteCopyWith<$Res> {
  _$ConcreteCopyWithImpl(this._self, this._then);

  final Concrete _self;
  final $Res Function(Concrete) _then;

  /// Create a copy of Concrete
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

/// Adds pattern-matching-related methods to [Concrete].
extension ConcretePatterns on Concrete {
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
    TResult Function(_Concrete value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Concrete() when $default != null:
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
    TResult Function(_Concrete value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Concrete():
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
    TResult? Function(_Concrete value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Concrete() when $default != null:
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
      case _Concrete() when $default != null:
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
      case _Concrete():
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
      case _Concrete() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Concrete extends Concrete {
  _Concrete(this.value) : super._();

  @override
  final int value;

  /// Create a copy of Concrete
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConcreteCopyWith<_Concrete> get copyWith =>
      __$ConcreteCopyWithImpl<_Concrete>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Concrete &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'Concrete(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$ConcreteCopyWith<$Res>
    implements $ConcreteCopyWith<$Res> {
  factory _$ConcreteCopyWith(_Concrete value, $Res Function(_Concrete) _then) =
      __$ConcreteCopyWithImpl;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$ConcreteCopyWithImpl<$Res> implements _$ConcreteCopyWith<$Res> {
  __$ConcreteCopyWithImpl(this._self, this._then);

  final _Concrete _self;
  final $Res Function(_Concrete) _then;

  /// Create a copy of Concrete
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_Concrete(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$EmptyConcrete {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is EmptyConcrete);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EmptyConcrete()';
  }
}

/// @nodoc
class $EmptyConcreteCopyWith<$Res> {
  $EmptyConcreteCopyWith(EmptyConcrete _, $Res Function(EmptyConcrete) __);
}

/// Adds pattern-matching-related methods to [EmptyConcrete].
extension EmptyConcretePatterns on EmptyConcrete {
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
    TResult Function(_EmptyConcrete value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EmptyConcrete() when $default != null:
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
    TResult Function(_EmptyConcrete value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EmptyConcrete():
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
    TResult? Function(_EmptyConcrete value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EmptyConcrete() when $default != null:
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
      case _EmptyConcrete() when $default != null:
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
      case _EmptyConcrete():
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
      case _EmptyConcrete() when $default != null:
        return $default();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _EmptyConcrete extends EmptyConcrete {
  _EmptyConcrete() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _EmptyConcrete);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EmptyConcrete()';
  }
}

/// @nodoc
mixin _$ConstConcrete {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ConstConcrete);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ConstConcrete()';
  }
}

/// @nodoc
class $ConstConcreteCopyWith<$Res> {
  $ConstConcreteCopyWith(ConstConcrete _, $Res Function(ConstConcrete) __);
}

/// Adds pattern-matching-related methods to [ConstConcrete].
extension ConstConcretePatterns on ConstConcrete {
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
    TResult Function(_ConstConcrete value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConstConcrete() when $default != null:
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
    TResult Function(_ConstConcrete value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConstConcrete():
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
    TResult? Function(_ConstConcrete value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConstConcrete() when $default != null:
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
      case _ConstConcrete() when $default != null:
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
      case _ConstConcrete():
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
      case _ConstConcrete() when $default != null:
        return $default();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ConstConcrete extends ConstConcrete {
  const _ConstConcrete() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ConstConcrete);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ConstConcrete()';
  }
}

/// @nodoc
mixin _$MixedIn {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MixedIn);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MixedIn()';
  }
}

/// @nodoc
class $MixedInCopyWith<$Res> {
  $MixedInCopyWith(MixedIn _, $Res Function(MixedIn) __);
}

/// Adds pattern-matching-related methods to [MixedIn].
extension MixedInPatterns on MixedIn {
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
    TResult Function(_MixedIn value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MixedIn() when $default != null:
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
    TResult Function(_MixedIn value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MixedIn():
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
    TResult? Function(_MixedIn value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MixedIn() when $default != null:
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
      case _MixedIn() when $default != null:
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
      case _MixedIn():
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
      case _MixedIn() when $default != null:
        return $default();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _MixedIn extends MixedIn {
  _MixedIn() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _MixedIn);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MixedIn()';
  }
}

/// @nodoc
mixin _$ConcreteGetter {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ConcreteGetter);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ConcreteGetter()';
  }
}

/// @nodoc
class $ConcreteGetterCopyWith<$Res> {
  $ConcreteGetterCopyWith(ConcreteGetter _, $Res Function(ConcreteGetter) __);
}

/// Adds pattern-matching-related methods to [ConcreteGetter].
extension ConcreteGetterPatterns on ConcreteGetter {
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
    TResult Function(_ConcreteGetter value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConcreteGetter() when $default != null:
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
    TResult Function(_ConcreteGetter value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConcreteGetter():
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
    TResult? Function(_ConcreteGetter value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConcreteGetter() when $default != null:
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
      case _ConcreteGetter() when $default != null:
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
      case _ConcreteGetter():
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
      case _ConcreteGetter() when $default != null:
        return $default();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ConcreteGetter extends ConcreteGetter {
  const _ConcreteGetter() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ConcreteGetter);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ConcreteGetter()';
  }
}

/// @nodoc
mixin _$CustomToString {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CustomToString);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

/// @nodoc
class $CustomToStringCopyWith<$Res> {
  $CustomToStringCopyWith(CustomToString _, $Res Function(CustomToString) __);
}

/// Adds pattern-matching-related methods to [CustomToString].
extension CustomToStringPatterns on CustomToString {
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
    TResult Function(_CustomToString value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CustomToString() when $default != null:
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
    TResult Function(_CustomToString value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomToString():
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
    TResult? Function(_CustomToString value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomToString() when $default != null:
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
      case _CustomToString() when $default != null:
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
      case _CustomToString():
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
      case _CustomToString() when $default != null:
        return $default();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CustomToString extends CustomToString {
  _CustomToString() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _CustomToString);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

/// @nodoc
mixin _$MixedInToString {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MixedInToString);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

/// @nodoc
class $MixedInToStringCopyWith<$Res> {
  $MixedInToStringCopyWith(
      MixedInToString _, $Res Function(MixedInToString) __);
}

/// Adds pattern-matching-related methods to [MixedInToString].
extension MixedInToStringPatterns on MixedInToString {
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
    TResult Function(_MixedInToString value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MixedInToString() when $default != null:
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
    TResult Function(_MixedInToString value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MixedInToString():
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
    TResult? Function(_MixedInToString value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MixedInToString() when $default != null:
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
      case _MixedInToString() when $default != null:
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
      case _MixedInToString():
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
      case _MixedInToString() when $default != null:
        return $default();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _MixedInToString extends MixedInToString {
  _MixedInToString() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _MixedInToString);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

/// @nodoc
mixin _$BaseToString {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is BaseToString);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

/// @nodoc
class $BaseToStringCopyWith<$Res> {
  $BaseToStringCopyWith(BaseToString _, $Res Function(BaseToString) __);
}

/// Adds pattern-matching-related methods to [BaseToString].
extension BaseToStringPatterns on BaseToString {
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
    TResult Function(_BaseToString value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BaseToString() when $default != null:
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
    TResult Function(_BaseToString value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BaseToString():
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
    TResult? Function(_BaseToString value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BaseToString() when $default != null:
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
      case _BaseToString() when $default != null:
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
      case _BaseToString():
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
      case _BaseToString() when $default != null:
        return $default();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _BaseToString extends BaseToString {
  _BaseToString() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _BaseToString);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

/// @nodoc
mixin _$Const {
  int get a;

  /// Create a copy of Const
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConstCopyWith<Const> get copyWith =>
      _$ConstCopyWithImpl<Const>(this as Const, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Const &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'Const(a: $a)';
  }
}

/// @nodoc
abstract mixin class $ConstCopyWith<$Res> {
  factory $ConstCopyWith(Const value, $Res Function(Const) _then) =
      _$ConstCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$ConstCopyWithImpl<$Res> implements $ConstCopyWith<$Res> {
  _$ConstCopyWithImpl(this._self, this._then);

  final Const _self;
  final $Res Function(Const) _then;

  /// Create a copy of Const
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

/// Adds pattern-matching-related methods to [Const].
extension ConstPatterns on Const {
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
    TResult Function(_Const value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Const() when $default != null:
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
    TResult Function(_Const value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Const():
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
    TResult? Function(_Const value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Const() when $default != null:
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
      case _Const() when $default != null:
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
      case _Const():
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
      case _Const() when $default != null:
        return $default(_that.a);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Const extends Const {
  const _Const(this.a) : super._();

  @override
  final int a;

  /// Create a copy of Const
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConstCopyWith<_Const> get copyWith =>
      __$ConstCopyWithImpl<_Const>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Const &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'Const(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$ConstCopyWith<$Res> implements $ConstCopyWith<$Res> {
  factory _$ConstCopyWith(_Const value, $Res Function(_Const) _then) =
      __$ConstCopyWithImpl;
  @override
  @useResult
  $Res call({int a});
}

/// @nodoc
class __$ConstCopyWithImpl<$Res> implements _$ConstCopyWith<$Res> {
  __$ConstCopyWithImpl(this._self, this._then);

  final _Const _self;
  final $Res Function(_Const) _then;

  /// Create a copy of Const
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_Const(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$Dollar {
  String get $test;

  /// Create a copy of Dollar
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DollarCopyWith<Dollar> get copyWith =>
      _$DollarCopyWithImpl<Dollar>(this as Dollar, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Dollar &&
            (identical(other.$test, $test) || other.$test == $test));
  }

  @override
  int get hashCode => Object.hash(runtimeType, $test);

  @override
  String toString() {
    return 'Dollar(\$test: ${$test})';
  }
}

/// @nodoc
abstract mixin class $DollarCopyWith<$Res> {
  factory $DollarCopyWith(Dollar value, $Res Function(Dollar) _then) =
      _$DollarCopyWithImpl;
  @useResult
  $Res call({String $test});
}

/// @nodoc
class _$DollarCopyWithImpl<$Res> implements $DollarCopyWith<$Res> {
  _$DollarCopyWithImpl(this._self, this._then);

  final Dollar _self;
  final $Res Function(Dollar) _then;

  /// Create a copy of Dollar
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? $test = null,
  }) {
    return _then(_self.copyWith(
      $test: null == $test
          ? _self.$test
          : $test // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [Dollar].
extension DollarPatterns on Dollar {
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
    TResult Function(_DollarStartWithDollar value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DollarStartWithDollar() when $default != null:
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
    TResult Function(_DollarStartWithDollar value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DollarStartWithDollar():
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
    TResult? Function(_DollarStartWithDollar value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DollarStartWithDollar() when $default != null:
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
    TResult Function(String $test)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DollarStartWithDollar() when $default != null:
        return $default(_that.$test);
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
    TResult Function(String $test) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DollarStartWithDollar():
        return $default(_that.$test);
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
    TResult? Function(String $test)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DollarStartWithDollar() when $default != null:
        return $default(_that.$test);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DollarStartWithDollar implements Dollar {
  const _DollarStartWithDollar({required this.$test});

  @override
  final String $test;

  /// Create a copy of Dollar
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DollarStartWithDollarCopyWith<_DollarStartWithDollar> get copyWith =>
      __$DollarStartWithDollarCopyWithImpl<_DollarStartWithDollar>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DollarStartWithDollar &&
            (identical(other.$test, $test) || other.$test == $test));
  }

  @override
  int get hashCode => Object.hash(runtimeType, $test);

  @override
  String toString() {
    return 'Dollar(\$test: ${$test})';
  }
}

/// @nodoc
abstract mixin class _$DollarStartWithDollarCopyWith<$Res>
    implements $DollarCopyWith<$Res> {
  factory _$DollarStartWithDollarCopyWith(_DollarStartWithDollar value,
          $Res Function(_DollarStartWithDollar) _then) =
      __$DollarStartWithDollarCopyWithImpl;
  @override
  @useResult
  $Res call({String $test});
}

/// @nodoc
class __$DollarStartWithDollarCopyWithImpl<$Res>
    implements _$DollarStartWithDollarCopyWith<$Res> {
  __$DollarStartWithDollarCopyWithImpl(this._self, this._then);

  final _DollarStartWithDollar _self;
  final $Res Function(_DollarStartWithDollar) _then;

  /// Create a copy of Dollar
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? $test = null,
  }) {
    return _then(_DollarStartWithDollar(
      $test: null == $test
          ? _self.$test
          : $test // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$DollarMiddle {
  String get te$st;

  /// Create a copy of DollarMiddle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DollarMiddleCopyWith<DollarMiddle> get copyWith =>
      _$DollarMiddleCopyWithImpl<DollarMiddle>(
          this as DollarMiddle, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DollarMiddle &&
            (identical(other.te$st, te$st) || other.te$st == te$st));
  }

  @override
  int get hashCode => Object.hash(runtimeType, te$st);

  @override
  String toString() {
    return 'DollarMiddle(te\$st: ${te$st})';
  }
}

/// @nodoc
abstract mixin class $DollarMiddleCopyWith<$Res> {
  factory $DollarMiddleCopyWith(
          DollarMiddle value, $Res Function(DollarMiddle) _then) =
      _$DollarMiddleCopyWithImpl;
  @useResult
  $Res call({String te$st});
}

/// @nodoc
class _$DollarMiddleCopyWithImpl<$Res> implements $DollarMiddleCopyWith<$Res> {
  _$DollarMiddleCopyWithImpl(this._self, this._then);

  final DollarMiddle _self;
  final $Res Function(DollarMiddle) _then;

  /// Create a copy of DollarMiddle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? te$st = null,
  }) {
    return _then(_self.copyWith(
      te$st: null == te$st
          ? _self.te$st
          : te$st // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [DollarMiddle].
extension DollarMiddlePatterns on DollarMiddle {
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
    TResult Function(_DollarMiddleMiddleWithDollar value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DollarMiddleMiddleWithDollar() when $default != null:
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
    TResult Function(_DollarMiddleMiddleWithDollar value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DollarMiddleMiddleWithDollar():
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
    TResult? Function(_DollarMiddleMiddleWithDollar value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DollarMiddleMiddleWithDollar() when $default != null:
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
    TResult Function(String te$st)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DollarMiddleMiddleWithDollar() when $default != null:
        return $default(_that.te$st);
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
    TResult Function(String te$st) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DollarMiddleMiddleWithDollar():
        return $default(_that.te$st);
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
    TResult? Function(String te$st)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DollarMiddleMiddleWithDollar() when $default != null:
        return $default(_that.te$st);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DollarMiddleMiddleWithDollar implements DollarMiddle {
  const _DollarMiddleMiddleWithDollar({required this.te$st});

  @override
  final String te$st;

  /// Create a copy of DollarMiddle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DollarMiddleMiddleWithDollarCopyWith<_DollarMiddleMiddleWithDollar>
      get copyWith => __$DollarMiddleMiddleWithDollarCopyWithImpl<
          _DollarMiddleMiddleWithDollar>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DollarMiddleMiddleWithDollar &&
            (identical(other.te$st, te$st) || other.te$st == te$st));
  }

  @override
  int get hashCode => Object.hash(runtimeType, te$st);

  @override
  String toString() {
    return 'DollarMiddle(te\$st: ${te$st})';
  }
}

/// @nodoc
abstract mixin class _$DollarMiddleMiddleWithDollarCopyWith<$Res>
    implements $DollarMiddleCopyWith<$Res> {
  factory _$DollarMiddleMiddleWithDollarCopyWith(
          _DollarMiddleMiddleWithDollar value,
          $Res Function(_DollarMiddleMiddleWithDollar) _then) =
      __$DollarMiddleMiddleWithDollarCopyWithImpl;
  @override
  @useResult
  $Res call({String te$st});
}

/// @nodoc
class __$DollarMiddleMiddleWithDollarCopyWithImpl<$Res>
    implements _$DollarMiddleMiddleWithDollarCopyWith<$Res> {
  __$DollarMiddleMiddleWithDollarCopyWithImpl(this._self, this._then);

  final _DollarMiddleMiddleWithDollar _self;
  final $Res Function(_DollarMiddleMiddleWithDollar) _then;

  /// Create a copy of DollarMiddle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? te$st = null,
  }) {
    return _then(_DollarMiddleMiddleWithDollar(
      te$st: null == te$st
          ? _self.te$st
          : te$st // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$DollarEnd {
  String get test$;

  /// Create a copy of DollarEnd
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DollarEndCopyWith<DollarEnd> get copyWith =>
      _$DollarEndCopyWithImpl<DollarEnd>(this as DollarEnd, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DollarEnd &&
            (identical(other.test$, test$) || other.test$ == test$));
  }

  @override
  int get hashCode => Object.hash(runtimeType, test$);

  @override
  String toString() {
    return 'DollarEnd(test\$: ${test$})';
  }
}

/// @nodoc
abstract mixin class $DollarEndCopyWith<$Res> {
  factory $DollarEndCopyWith(DollarEnd value, $Res Function(DollarEnd) _then) =
      _$DollarEndCopyWithImpl;
  @useResult
  $Res call({String test$});
}

/// @nodoc
class _$DollarEndCopyWithImpl<$Res> implements $DollarEndCopyWith<$Res> {
  _$DollarEndCopyWithImpl(this._self, this._then);

  final DollarEnd _self;
  final $Res Function(DollarEnd) _then;

  /// Create a copy of DollarEnd
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? test$ = null,
  }) {
    return _then(_self.copyWith(
      test$: null == test$
          ? _self.test$
          : test$ // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [DollarEnd].
extension DollarEndPatterns on DollarEnd {
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
    TResult Function(_DollarEndEndWithDollar value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DollarEndEndWithDollar() when $default != null:
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
    TResult Function(_DollarEndEndWithDollar value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DollarEndEndWithDollar():
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
    TResult? Function(_DollarEndEndWithDollar value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DollarEndEndWithDollar() when $default != null:
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
    TResult Function(String test$)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DollarEndEndWithDollar() when $default != null:
        return $default(_that.test$);
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
    TResult Function(String test$) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DollarEndEndWithDollar():
        return $default(_that.test$);
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
    TResult? Function(String test$)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DollarEndEndWithDollar() when $default != null:
        return $default(_that.test$);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DollarEndEndWithDollar implements DollarEnd {
  const _DollarEndEndWithDollar({required this.test$});

  @override
  final String test$;

  /// Create a copy of DollarEnd
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DollarEndEndWithDollarCopyWith<_DollarEndEndWithDollar> get copyWith =>
      __$DollarEndEndWithDollarCopyWithImpl<_DollarEndEndWithDollar>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DollarEndEndWithDollar &&
            (identical(other.test$, test$) || other.test$ == test$));
  }

  @override
  int get hashCode => Object.hash(runtimeType, test$);

  @override
  String toString() {
    return 'DollarEnd(test\$: ${test$})';
  }
}

/// @nodoc
abstract mixin class _$DollarEndEndWithDollarCopyWith<$Res>
    implements $DollarEndCopyWith<$Res> {
  factory _$DollarEndEndWithDollarCopyWith(_DollarEndEndWithDollar value,
          $Res Function(_DollarEndEndWithDollar) _then) =
      __$DollarEndEndWithDollarCopyWithImpl;
  @override
  @useResult
  $Res call({String test$});
}

/// @nodoc
class __$DollarEndEndWithDollarCopyWithImpl<$Res>
    implements _$DollarEndEndWithDollarCopyWith<$Res> {
  __$DollarEndEndWithDollarCopyWithImpl(this._self, this._then);

  final _DollarEndEndWithDollar _self;
  final $Res Function(_DollarEndEndWithDollar) _then;

  /// Create a copy of DollarEnd
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? test$ = null,
  }) {
    return _then(_DollarEndEndWithDollar(
      test$: null == test$
          ? _self.test$
          : test$ // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$$DollarClass {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is $DollarClass);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return '\$DollarClass()';
  }
}

/// @nodoc
class $$DollarClassCopyWith<$Res> {
  $$DollarClassCopyWith($DollarClass _, $Res Function($DollarClass) __);
}

/// Adds pattern-matching-related methods to [$DollarClass].
extension $DollarClassPatterns on $DollarClass {
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
    TResult Function(_DollarClassWithDollar value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DollarClassWithDollar() when $default != null:
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
    TResult Function(_DollarClassWithDollar value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DollarClassWithDollar():
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
    TResult? Function(_DollarClassWithDollar value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DollarClassWithDollar() when $default != null:
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
      case _DollarClassWithDollar() when $default != null:
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
      case _DollarClassWithDollar():
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
      case _DollarClassWithDollar() when $default != null:
        return $default();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DollarClassWithDollar implements $DollarClass {
  const _DollarClassWithDollar();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _DollarClassWithDollar);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return '\$DollarClass()';
  }
}

/// @nodoc
mixin _$DollarFactory {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DollarFactory);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DollarFactory()';
  }
}

/// @nodoc
class $DollarFactoryCopyWith<$Res> {
  $DollarFactoryCopyWith(DollarFactory _, $Res Function(DollarFactory) __);
}

/// Adds pattern-matching-related methods to [DollarFactory].
extension DollarFactoryPatterns on DollarFactory {
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
    TResult Function(_DollarFactoryWithDollar value)? $,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DollarFactoryWithDollar() when $ != null:
        return $(_that);
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
    required TResult Function(_DollarFactoryWithDollar value) $,
  }) {
    final _that = this;
    switch (_that) {
      case _DollarFactoryWithDollar():
        return $(_that);
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
    TResult? Function(_DollarFactoryWithDollar value)? $,
  }) {
    final _that = this;
    switch (_that) {
      case _DollarFactoryWithDollar() when $ != null:
        return $(_that);
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
    TResult Function()? $,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DollarFactoryWithDollar() when $ != null:
        return $();
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
    required TResult Function() $,
  }) {
    final _that = this;
    switch (_that) {
      case _DollarFactoryWithDollar():
        return $();
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
    TResult? Function()? $,
  }) {
    final _that = this;
    switch (_that) {
      case _DollarFactoryWithDollar() when $ != null:
        return $();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DollarFactoryWithDollar implements DollarFactory {
  const _DollarFactoryWithDollar();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _DollarFactoryWithDollar);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DollarFactory.\$()';
  }
}
