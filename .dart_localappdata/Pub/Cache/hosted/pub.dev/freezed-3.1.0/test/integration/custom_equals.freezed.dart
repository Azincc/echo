// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_equals.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CustomEquals {
  String? get name;
  int? get id;

  /// Create a copy of CustomEquals
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomEqualsCopyWith<CustomEquals> get copyWith =>
      _$CustomEqualsCopyWithImpl<CustomEquals>(
          this as CustomEquals, _$identity);

  @override
  String toString() {
    return 'CustomEquals(name: $name, id: $id)';
  }
}

/// @nodoc
abstract mixin class $CustomEqualsCopyWith<$Res> {
  factory $CustomEqualsCopyWith(
          CustomEquals value, $Res Function(CustomEquals) _then) =
      _$CustomEqualsCopyWithImpl;
  @useResult
  $Res call({String? name, int? id});
}

/// @nodoc
class _$CustomEqualsCopyWithImpl<$Res> implements $CustomEqualsCopyWith<$Res> {
  _$CustomEqualsCopyWithImpl(this._self, this._then);

  final CustomEquals _self;
  final $Res Function(CustomEquals) _then;

  /// Create a copy of CustomEquals
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? id = freezed,
  }) {
    return _then(_self.copyWith(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CustomEquals].
extension CustomEqualsPatterns on CustomEquals {
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
    TResult Function(_CustomEquals value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CustomEquals() when $default != null:
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
    TResult Function(_CustomEquals value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomEquals():
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
    TResult? Function(_CustomEquals value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomEquals() when $default != null:
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
    TResult Function(String? name, int? id)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CustomEquals() when $default != null:
        return $default(_that.name, _that.id);
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
    TResult Function(String? name, int? id) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomEquals():
        return $default(_that.name, _that.id);
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
    TResult? Function(String? name, int? id)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomEquals() when $default != null:
        return $default(_that.name, _that.id);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CustomEquals extends CustomEquals {
  _CustomEquals({this.name, this.id}) : super._();

  @override
  final String? name;
  @override
  final int? id;

  /// Create a copy of CustomEquals
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CustomEqualsCopyWith<_CustomEquals> get copyWith =>
      __$CustomEqualsCopyWithImpl<_CustomEquals>(this, _$identity);

  @override
  String toString() {
    return 'CustomEquals(name: $name, id: $id)';
  }
}

/// @nodoc
abstract mixin class _$CustomEqualsCopyWith<$Res>
    implements $CustomEqualsCopyWith<$Res> {
  factory _$CustomEqualsCopyWith(
          _CustomEquals value, $Res Function(_CustomEquals) _then) =
      __$CustomEqualsCopyWithImpl;
  @override
  @useResult
  $Res call({String? name, int? id});
}

/// @nodoc
class __$CustomEqualsCopyWithImpl<$Res>
    implements _$CustomEqualsCopyWith<$Res> {
  __$CustomEqualsCopyWithImpl(this._self, this._then);

  final _CustomEquals _self;
  final $Res Function(_CustomEquals) _then;

  /// Create a copy of CustomEquals
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = freezed,
    Object? id = freezed,
  }) {
    return _then(_CustomEquals(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
mixin _$CustomEqualsWithUnion {
  String? get name;

  /// Create a copy of CustomEqualsWithUnion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomEqualsWithUnionCopyWith<CustomEqualsWithUnion> get copyWith =>
      _$CustomEqualsWithUnionCopyWithImpl<CustomEqualsWithUnion>(
          this as CustomEqualsWithUnion, _$identity);

  @override
  String toString() {
    return 'CustomEqualsWithUnion(name: $name)';
  }
}

/// @nodoc
abstract mixin class $CustomEqualsWithUnionCopyWith<$Res> {
  factory $CustomEqualsWithUnionCopyWith(CustomEqualsWithUnion value,
          $Res Function(CustomEqualsWithUnion) _then) =
      _$CustomEqualsWithUnionCopyWithImpl;
  @useResult
  $Res call({String? name});
}

/// @nodoc
class _$CustomEqualsWithUnionCopyWithImpl<$Res>
    implements $CustomEqualsWithUnionCopyWith<$Res> {
  _$CustomEqualsWithUnionCopyWithImpl(this._self, this._then);

  final CustomEqualsWithUnion _self;
  final $Res Function(CustomEqualsWithUnion) _then;

  /// Create a copy of CustomEqualsWithUnion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_self.copyWith(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CustomEqualsWithUnion].
extension CustomEqualsWithUnionPatterns on CustomEqualsWithUnion {
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
    TResult Function(CustomEqualsFirst value)? first,
    TResult Function(CustomEqualsSecond value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CustomEqualsFirst() when first != null:
        return first(_that);
      case CustomEqualsSecond() when second != null:
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
    required TResult Function(CustomEqualsFirst value) first,
    required TResult Function(CustomEqualsSecond value) second,
  }) {
    final _that = this;
    switch (_that) {
      case CustomEqualsFirst():
        return first(_that);
      case CustomEqualsSecond():
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
    TResult? Function(CustomEqualsFirst value)? first,
    TResult? Function(CustomEqualsSecond value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case CustomEqualsFirst() when first != null:
        return first(_that);
      case CustomEqualsSecond() when second != null:
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
    TResult Function(String? name, int? id)? first,
    TResult Function(String? name, bool? active)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CustomEqualsFirst() when first != null:
        return first(_that.name, _that.id);
      case CustomEqualsSecond() when second != null:
        return second(_that.name, _that.active);
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
    required TResult Function(String? name, int? id) first,
    required TResult Function(String? name, bool? active) second,
  }) {
    final _that = this;
    switch (_that) {
      case CustomEqualsFirst():
        return first(_that.name, _that.id);
      case CustomEqualsSecond():
        return second(_that.name, _that.active);
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
    TResult? Function(String? name, int? id)? first,
    TResult? Function(String? name, bool? active)? second,
  }) {
    final _that = this;
    switch (_that) {
      case CustomEqualsFirst() when first != null:
        return first(_that.name, _that.id);
      case CustomEqualsSecond() when second != null:
        return second(_that.name, _that.active);
      case _:
        return null;
    }
  }
}

/// @nodoc

class CustomEqualsFirst extends CustomEqualsWithUnion {
  CustomEqualsFirst({this.name, this.id}) : super._();

  @override
  final String? name;
  final int? id;

  /// Create a copy of CustomEqualsWithUnion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomEqualsFirstCopyWith<CustomEqualsFirst> get copyWith =>
      _$CustomEqualsFirstCopyWithImpl<CustomEqualsFirst>(this, _$identity);

  @override
  String toString() {
    return 'CustomEqualsWithUnion.first(name: $name, id: $id)';
  }
}

/// @nodoc
abstract mixin class $CustomEqualsFirstCopyWith<$Res>
    implements $CustomEqualsWithUnionCopyWith<$Res> {
  factory $CustomEqualsFirstCopyWith(
          CustomEqualsFirst value, $Res Function(CustomEqualsFirst) _then) =
      _$CustomEqualsFirstCopyWithImpl;
  @override
  @useResult
  $Res call({String? name, int? id});
}

/// @nodoc
class _$CustomEqualsFirstCopyWithImpl<$Res>
    implements $CustomEqualsFirstCopyWith<$Res> {
  _$CustomEqualsFirstCopyWithImpl(this._self, this._then);

  final CustomEqualsFirst _self;
  final $Res Function(CustomEqualsFirst) _then;

  /// Create a copy of CustomEqualsWithUnion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = freezed,
    Object? id = freezed,
  }) {
    return _then(CustomEqualsFirst(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class CustomEqualsSecond extends CustomEqualsWithUnion {
  CustomEqualsSecond({this.name, this.active}) : super._();

  @override
  final String? name;
  final bool? active;

  /// Create a copy of CustomEqualsWithUnion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomEqualsSecondCopyWith<CustomEqualsSecond> get copyWith =>
      _$CustomEqualsSecondCopyWithImpl<CustomEqualsSecond>(this, _$identity);

  @override
  String toString() {
    return 'CustomEqualsWithUnion.second(name: $name, active: $active)';
  }
}

/// @nodoc
abstract mixin class $CustomEqualsSecondCopyWith<$Res>
    implements $CustomEqualsWithUnionCopyWith<$Res> {
  factory $CustomEqualsSecondCopyWith(
          CustomEqualsSecond value, $Res Function(CustomEqualsSecond) _then) =
      _$CustomEqualsSecondCopyWithImpl;
  @override
  @useResult
  $Res call({String? name, bool? active});
}

/// @nodoc
class _$CustomEqualsSecondCopyWithImpl<$Res>
    implements $CustomEqualsSecondCopyWith<$Res> {
  _$CustomEqualsSecondCopyWithImpl(this._self, this._then);

  final CustomEqualsSecond _self;
  final $Res Function(CustomEqualsSecond) _then;

  /// Create a copy of CustomEqualsWithUnion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = freezed,
    Object? active = freezed,
  }) {
    return _then(CustomEqualsSecond(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      active: freezed == active
          ? _self.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
mixin _$EqualsWithUnionMixin {
  @override
  String toString() {
    return 'EqualsWithUnionMixin()';
  }
}

/// @nodoc
class $EqualsWithUnionMixinCopyWith<$Res> {
  $EqualsWithUnionMixinCopyWith(
      EqualsWithUnionMixin _, $Res Function(EqualsWithUnionMixin) __);
}

/// Adds pattern-matching-related methods to [EqualsWithUnionMixin].
extension EqualsWithUnionMixinPatterns on EqualsWithUnionMixin {
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
    TResult Function(UnionMixinFirst value)? first,
    TResult Function(UnionMixinSecond value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case UnionMixinFirst() when first != null:
        return first(_that);
      case UnionMixinSecond() when second != null:
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
    required TResult Function(UnionMixinFirst value) first,
    required TResult Function(UnionMixinSecond value) second,
  }) {
    final _that = this;
    switch (_that) {
      case UnionMixinFirst():
        return first(_that);
      case UnionMixinSecond():
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
    TResult? Function(UnionMixinFirst value)? first,
    TResult? Function(UnionMixinSecond value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case UnionMixinFirst() when first != null:
        return first(_that);
      case UnionMixinSecond() when second != null:
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
    TResult Function(String b)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case UnionMixinFirst() when first != null:
        return first(_that.a);
      case UnionMixinSecond() when second != null:
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
  TResult when<TResult extends Object?>({
    required TResult Function(int a) first,
    required TResult Function(String b) second,
  }) {
    final _that = this;
    switch (_that) {
      case UnionMixinFirst():
        return first(_that.a);
      case UnionMixinSecond():
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int a)? first,
    TResult? Function(String b)? second,
  }) {
    final _that = this;
    switch (_that) {
      case UnionMixinFirst() when first != null:
        return first(_that.a);
      case UnionMixinSecond() when second != null:
        return second(_that.b);
      case _:
        return null;
    }
  }
}

/// @nodoc

class UnionMixinFirst extends EqualsWithUnionMixin with MyClass {
  UnionMixinFirst(this.a) : super._();

  final int a;

  /// Create a copy of EqualsWithUnionMixin
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnionMixinFirstCopyWith<UnionMixinFirst> get copyWith =>
      _$UnionMixinFirstCopyWithImpl<UnionMixinFirst>(this, _$identity);

  @override
  String toString() {
    return 'EqualsWithUnionMixin.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class $UnionMixinFirstCopyWith<$Res>
    implements $EqualsWithUnionMixinCopyWith<$Res> {
  factory $UnionMixinFirstCopyWith(
          UnionMixinFirst value, $Res Function(UnionMixinFirst) _then) =
      _$UnionMixinFirstCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$UnionMixinFirstCopyWithImpl<$Res>
    implements $UnionMixinFirstCopyWith<$Res> {
  _$UnionMixinFirstCopyWithImpl(this._self, this._then);

  final UnionMixinFirst _self;
  final $Res Function(UnionMixinFirst) _then;

  /// Create a copy of EqualsWithUnionMixin
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(UnionMixinFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class UnionMixinSecond extends EqualsWithUnionMixin {
  UnionMixinSecond(this.b) : super._();

  final String b;

  /// Create a copy of EqualsWithUnionMixin
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnionMixinSecondCopyWith<UnionMixinSecond> get copyWith =>
      _$UnionMixinSecondCopyWithImpl<UnionMixinSecond>(this, _$identity);

  @override
  String toString() {
    return 'EqualsWithUnionMixin.second(b: $b)';
  }
}

/// @nodoc
abstract mixin class $UnionMixinSecondCopyWith<$Res>
    implements $EqualsWithUnionMixinCopyWith<$Res> {
  factory $UnionMixinSecondCopyWith(
          UnionMixinSecond value, $Res Function(UnionMixinSecond) _then) =
      _$UnionMixinSecondCopyWithImpl;
  @useResult
  $Res call({String b});
}

/// @nodoc
class _$UnionMixinSecondCopyWithImpl<$Res>
    implements $UnionMixinSecondCopyWith<$Res> {
  _$UnionMixinSecondCopyWithImpl(this._self, this._then);

  final UnionMixinSecond _self;
  final $Res Function(UnionMixinSecond) _then;

  /// Create a copy of EqualsWithUnionMixin
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? b = null,
  }) {
    return _then(UnionMixinSecond(
      null == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$EqualsWithUnionExtends {
  @override
  String toString() {
    return 'EqualsWithUnionExtends()';
  }
}

/// @nodoc
class $EqualsWithUnionExtendsCopyWith<$Res> {
  $EqualsWithUnionExtendsCopyWith(
      EqualsWithUnionExtends _, $Res Function(EqualsWithUnionExtends) __);
}

/// Adds pattern-matching-related methods to [EqualsWithUnionExtends].
extension EqualsWithUnionExtendsPatterns on EqualsWithUnionExtends {
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
    TResult Function(UnionExtendsFirst value)? first,
    TResult Function(UnionExtendsSecond value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case UnionExtendsFirst() when first != null:
        return first(_that);
      case UnionExtendsSecond() when second != null:
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
    required TResult Function(UnionExtendsFirst value) first,
    required TResult Function(UnionExtendsSecond value) second,
  }) {
    final _that = this;
    switch (_that) {
      case UnionExtendsFirst():
        return first(_that);
      case UnionExtendsSecond():
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
    TResult? Function(UnionExtendsFirst value)? first,
    TResult? Function(UnionExtendsSecond value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case UnionExtendsFirst() when first != null:
        return first(_that);
      case UnionExtendsSecond() when second != null:
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
    TResult Function(String b)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case UnionExtendsFirst() when first != null:
        return first(_that.a);
      case UnionExtendsSecond() when second != null:
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
  TResult when<TResult extends Object?>({
    required TResult Function(int a) first,
    required TResult Function(String b) second,
  }) {
    final _that = this;
    switch (_that) {
      case UnionExtendsFirst():
        return first(_that.a);
      case UnionExtendsSecond():
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int a)? first,
    TResult? Function(String b)? second,
  }) {
    final _that = this;
    switch (_that) {
      case UnionExtendsFirst() when first != null:
        return first(_that.a);
      case UnionExtendsSecond() when second != null:
        return second(_that.b);
      case _:
        return null;
    }
  }
}

/// @nodoc

class UnionExtendsFirst extends EqualsWithUnionExtends with MyClass {
  UnionExtendsFirst(this.a) : super._();

  final int a;

  /// Create a copy of EqualsWithUnionExtends
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnionExtendsFirstCopyWith<UnionExtendsFirst> get copyWith =>
      _$UnionExtendsFirstCopyWithImpl<UnionExtendsFirst>(this, _$identity);

  @override
  String toString() {
    return 'EqualsWithUnionExtends.first(a: $a)';
  }
}

/// @nodoc
abstract mixin class $UnionExtendsFirstCopyWith<$Res>
    implements $EqualsWithUnionExtendsCopyWith<$Res> {
  factory $UnionExtendsFirstCopyWith(
          UnionExtendsFirst value, $Res Function(UnionExtendsFirst) _then) =
      _$UnionExtendsFirstCopyWithImpl;
  @useResult
  $Res call({int a});
}

/// @nodoc
class _$UnionExtendsFirstCopyWithImpl<$Res>
    implements $UnionExtendsFirstCopyWith<$Res> {
  _$UnionExtendsFirstCopyWithImpl(this._self, this._then);

  final UnionExtendsFirst _self;
  final $Res Function(UnionExtendsFirst) _then;

  /// Create a copy of EqualsWithUnionExtends
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(UnionExtendsFirst(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class UnionExtendsSecond extends EqualsWithUnionExtends {
  UnionExtendsSecond(this.b) : super._();

  final String b;

  /// Create a copy of EqualsWithUnionExtends
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnionExtendsSecondCopyWith<UnionExtendsSecond> get copyWith =>
      _$UnionExtendsSecondCopyWithImpl<UnionExtendsSecond>(this, _$identity);

  @override
  String toString() {
    return 'EqualsWithUnionExtends.second(b: $b)';
  }
}

/// @nodoc
abstract mixin class $UnionExtendsSecondCopyWith<$Res>
    implements $EqualsWithUnionExtendsCopyWith<$Res> {
  factory $UnionExtendsSecondCopyWith(
          UnionExtendsSecond value, $Res Function(UnionExtendsSecond) _then) =
      _$UnionExtendsSecondCopyWithImpl;
  @useResult
  $Res call({String b});
}

/// @nodoc
class _$UnionExtendsSecondCopyWithImpl<$Res>
    implements $UnionExtendsSecondCopyWith<$Res> {
  _$UnionExtendsSecondCopyWithImpl(this._self, this._then);

  final UnionExtendsSecond _self;
  final $Res Function(UnionExtendsSecond) _then;

  /// Create a copy of EqualsWithUnionExtends
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? b = null,
  }) {
    return _then(UnionExtendsSecond(
      null == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}
