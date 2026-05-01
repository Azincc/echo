// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deep_copy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeepWithManualField {
  ManualField get manual;

  /// Create a copy of DeepWithManualField
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DeepWithManualFieldCopyWith<DeepWithManualField> get copyWith =>
      _$DeepWithManualFieldCopyWithImpl<DeepWithManualField>(
          this as DeepWithManualField, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DeepWithManualField &&
            (identical(other.manual, manual) || other.manual == manual));
  }

  @override
  int get hashCode => Object.hash(runtimeType, manual);

  @override
  String toString() {
    return 'DeepWithManualField(manual: $manual)';
  }
}

/// @nodoc
abstract mixin class $DeepWithManualFieldCopyWith<$Res> {
  factory $DeepWithManualFieldCopyWith(
          DeepWithManualField value, $Res Function(DeepWithManualField) _then) =
      _$DeepWithManualFieldCopyWithImpl;
  @useResult
  $Res call({ManualField manual});

  $ManualFieldCopyWith<$Res> get manual;
}

/// @nodoc
class _$DeepWithManualFieldCopyWithImpl<$Res>
    implements $DeepWithManualFieldCopyWith<$Res> {
  _$DeepWithManualFieldCopyWithImpl(this._self, this._then);

  final DeepWithManualField _self;
  final $Res Function(DeepWithManualField) _then;

  /// Create a copy of DeepWithManualField
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? manual = null,
  }) {
    return _then(_self.copyWith(
      manual: null == manual
          ? _self.manual
          : manual // ignore: cast_nullable_to_non_nullable
              as ManualField,
    ));
  }

  /// Create a copy of DeepWithManualField
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ManualFieldCopyWith<$Res> get manual {
    return $ManualFieldCopyWith<$Res>(_self.manual, (value) {
      return _then(_self.copyWith(manual: value));
    });
  }
}

/// Adds pattern-matching-related methods to [DeepWithManualField].
extension DeepWithManualFieldPatterns on DeepWithManualField {
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
    TResult Function(_DeepWithManualField value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DeepWithManualField() when $default != null:
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
    TResult Function(_DeepWithManualField value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DeepWithManualField():
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
    TResult? Function(_DeepWithManualField value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DeepWithManualField() when $default != null:
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
    TResult Function(ManualField manual)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DeepWithManualField() when $default != null:
        return $default(_that.manual);
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
    TResult Function(ManualField manual) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DeepWithManualField():
        return $default(_that.manual);
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
    TResult? Function(ManualField manual)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DeepWithManualField() when $default != null:
        return $default(_that.manual);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DeepWithManualField implements DeepWithManualField {
  const _DeepWithManualField(this.manual);

  @override
  final ManualField manual;

  /// Create a copy of DeepWithManualField
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DeepWithManualFieldCopyWith<_DeepWithManualField> get copyWith =>
      __$DeepWithManualFieldCopyWithImpl<_DeepWithManualField>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DeepWithManualField &&
            (identical(other.manual, manual) || other.manual == manual));
  }

  @override
  int get hashCode => Object.hash(runtimeType, manual);

  @override
  String toString() {
    return 'DeepWithManualField(manual: $manual)';
  }
}

/// @nodoc
abstract mixin class _$DeepWithManualFieldCopyWith<$Res>
    implements $DeepWithManualFieldCopyWith<$Res> {
  factory _$DeepWithManualFieldCopyWith(_DeepWithManualField value,
          $Res Function(_DeepWithManualField) _then) =
      __$DeepWithManualFieldCopyWithImpl;
  @override
  @useResult
  $Res call({ManualField manual});

  @override
  $ManualFieldCopyWith<$Res> get manual;
}

/// @nodoc
class __$DeepWithManualFieldCopyWithImpl<$Res>
    implements _$DeepWithManualFieldCopyWith<$Res> {
  __$DeepWithManualFieldCopyWithImpl(this._self, this._then);

  final _DeepWithManualField _self;
  final $Res Function(_DeepWithManualField) _then;

  /// Create a copy of DeepWithManualField
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? manual = null,
  }) {
    return _then(_DeepWithManualField(
      null == manual
          ? _self.manual
          : manual // ignore: cast_nullable_to_non_nullable
              as ManualField,
    ));
  }

  /// Create a copy of DeepWithManualField
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ManualFieldCopyWith<$Res> get manual {
    return $ManualFieldCopyWith<$Res>(_self.manual, (value) {
      return _then(_self.copyWith(manual: value));
    });
  }
}

/// @nodoc
mixin _$ManualField {
  int get value;

  /// Create a copy of ManualField
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ManualFieldCopyWith<ManualField> get copyWith =>
      _$ManualFieldCopyWithImpl<ManualField>(this as ManualField, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ManualField &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'ManualField(value: $value)';
  }
}

/// @nodoc
abstract mixin class $ManualFieldCopyWith<$Res> {
  factory $ManualFieldCopyWith(
          ManualField value, $Res Function(ManualField) _then) =
      _$ManualFieldCopyWithImpl;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$ManualFieldCopyWithImpl<$Res> implements $ManualFieldCopyWith<$Res> {
  _$ManualFieldCopyWithImpl(this._self, this._then);

  final ManualField _self;
  final $Res Function(ManualField) _then;

  /// Create a copy of ManualField
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

/// Adds pattern-matching-related methods to [ManualField].
extension ManualFieldPatterns on ManualField {
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
    TResult Function(_ManualField value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ManualField() when $default != null:
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
    TResult Function(_ManualField value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ManualField():
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
    TResult? Function(_ManualField value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ManualField() when $default != null:
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
      case _ManualField() when $default != null:
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
      case _ManualField():
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
      case _ManualField() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ManualField extends ManualField {
  const _ManualField(final int value) : super._(value: value);

  /// Create a copy of ManualField
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ManualFieldCopyWith<_ManualField> get copyWith =>
      __$ManualFieldCopyWithImpl<_ManualField>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ManualField &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'ManualField(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$ManualFieldCopyWith<$Res>
    implements $ManualFieldCopyWith<$Res> {
  factory _$ManualFieldCopyWith(
          _ManualField value, $Res Function(_ManualField) _then) =
      __$ManualFieldCopyWithImpl;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$ManualFieldCopyWithImpl<$Res> implements _$ManualFieldCopyWith<$Res> {
  __$ManualFieldCopyWithImpl(this._self, this._then);

  final _ManualField _self;
  final $Res Function(_ManualField) _then;

  /// Create a copy of ManualField
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(_ManualField(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$Company {
  String? get name;
  Director? get director;

  /// Create a copy of Company
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CompanyCopyWith<Company> get copyWith =>
      _$CompanyCopyWithImpl<Company>(this as Company, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Company &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.director, director) ||
                other.director == director));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, director);

  @override
  String toString() {
    return 'Company(name: $name, director: $director)';
  }
}

/// @nodoc
abstract mixin class $CompanyCopyWith<$Res> {
  factory $CompanyCopyWith(Company value, $Res Function(Company) _then) =
      _$CompanyCopyWithImpl;
  @useResult
  $Res call({String? name, Director? director});

  $DirectorCopyWith<$Res>? get director;
}

/// @nodoc
class _$CompanyCopyWithImpl<$Res> implements $CompanyCopyWith<$Res> {
  _$CompanyCopyWithImpl(this._self, this._then);

  final Company _self;
  final $Res Function(Company) _then;

  /// Create a copy of Company
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? director = freezed,
  }) {
    return _then(_self.copyWith(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      director: freezed == director
          ? _self.director
          : director // ignore: cast_nullable_to_non_nullable
              as Director?,
    ));
  }

  /// Create a copy of Company
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DirectorCopyWith<$Res>? get director {
    if (_self.director == null) {
      return null;
    }

    return $DirectorCopyWith<$Res>(_self.director!, (value) {
      return _then(_self.copyWith(director: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Company].
extension CompanyPatterns on Company {
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
    TResult Function(CompanySubclass value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CompanySubclass() when $default != null:
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
    TResult Function(CompanySubclass value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case CompanySubclass():
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
    TResult? Function(CompanySubclass value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case CompanySubclass() when $default != null:
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
    TResult Function(String? name, Director? director)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CompanySubclass() when $default != null:
        return $default(_that.name, _that.director);
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
    TResult Function(String? name, Director? director) $default,
  ) {
    final _that = this;
    switch (_that) {
      case CompanySubclass():
        return $default(_that.name, _that.director);
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
    TResult? Function(String? name, Director? director)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case CompanySubclass() when $default != null:
        return $default(_that.name, _that.director);
      case _:
        return null;
    }
  }
}

/// @nodoc

class CompanySubclass implements Company {
  CompanySubclass({this.name, this.director});

  @override
  final String? name;
  @override
  final Director? director;

  /// Create a copy of Company
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CompanySubclassCopyWith<CompanySubclass> get copyWith =>
      _$CompanySubclassCopyWithImpl<CompanySubclass>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CompanySubclass &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.director, director) ||
                other.director == director));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, director);

  @override
  String toString() {
    return 'Company(name: $name, director: $director)';
  }
}

/// @nodoc
abstract mixin class $CompanySubclassCopyWith<$Res>
    implements $CompanyCopyWith<$Res> {
  factory $CompanySubclassCopyWith(
          CompanySubclass value, $Res Function(CompanySubclass) _then) =
      _$CompanySubclassCopyWithImpl;
  @override
  @useResult
  $Res call({String? name, Director? director});

  @override
  $DirectorCopyWith<$Res>? get director;
}

/// @nodoc
class _$CompanySubclassCopyWithImpl<$Res>
    implements $CompanySubclassCopyWith<$Res> {
  _$CompanySubclassCopyWithImpl(this._self, this._then);

  final CompanySubclass _self;
  final $Res Function(CompanySubclass) _then;

  /// Create a copy of Company
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = freezed,
    Object? director = freezed,
  }) {
    return _then(CompanySubclass(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      director: freezed == director
          ? _self.director
          : director // ignore: cast_nullable_to_non_nullable
              as Director?,
    ));
  }

  /// Create a copy of Company
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DirectorCopyWith<$Res>? get director {
    if (_self.director == null) {
      return null;
    }

    return $DirectorCopyWith<$Res>(_self.director!, (value) {
      return _then(_self.copyWith(director: value));
    });
  }
}

/// @nodoc
mixin _$Director {
  String? get name;
  Assistant? get assistant;

  /// Create a copy of Director
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DirectorCopyWith<Director> get copyWith =>
      _$DirectorCopyWithImpl<Director>(this as Director, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Director &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.assistant, assistant) ||
                other.assistant == assistant));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, assistant);

  @override
  String toString() {
    return 'Director(name: $name, assistant: $assistant)';
  }
}

/// @nodoc
abstract mixin class $DirectorCopyWith<$Res> {
  factory $DirectorCopyWith(Director value, $Res Function(Director) _then) =
      _$DirectorCopyWithImpl;
  @useResult
  $Res call({String? name, Assistant? assistant});

  $AssistantCopyWith<$Res>? get assistant;
}

/// @nodoc
class _$DirectorCopyWithImpl<$Res> implements $DirectorCopyWith<$Res> {
  _$DirectorCopyWithImpl(this._self, this._then);

  final Director _self;
  final $Res Function(Director) _then;

  /// Create a copy of Director
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? assistant = freezed,
  }) {
    return _then(_self.copyWith(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      assistant: freezed == assistant
          ? _self.assistant
          : assistant // ignore: cast_nullable_to_non_nullable
              as Assistant?,
    ));
  }

  /// Create a copy of Director
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AssistantCopyWith<$Res>? get assistant {
    if (_self.assistant == null) {
      return null;
    }

    return $AssistantCopyWith<$Res>(_self.assistant!, (value) {
      return _then(_self.copyWith(assistant: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Director].
extension DirectorPatterns on Director {
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
    TResult Function(_Director value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Director() when $default != null:
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
    TResult Function(_Director value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Director():
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
    TResult? Function(_Director value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Director() when $default != null:
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
    TResult Function(String? name, Assistant? assistant)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Director() when $default != null:
        return $default(_that.name, _that.assistant);
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
    TResult Function(String? name, Assistant? assistant) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Director():
        return $default(_that.name, _that.assistant);
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
    TResult? Function(String? name, Assistant? assistant)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Director() when $default != null:
        return $default(_that.name, _that.assistant);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Director implements Director {
  _Director({this.name, this.assistant});

  @override
  final String? name;
  @override
  final Assistant? assistant;

  /// Create a copy of Director
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DirectorCopyWith<_Director> get copyWith =>
      __$DirectorCopyWithImpl<_Director>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Director &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.assistant, assistant) ||
                other.assistant == assistant));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, assistant);

  @override
  String toString() {
    return 'Director(name: $name, assistant: $assistant)';
  }
}

/// @nodoc
abstract mixin class _$DirectorCopyWith<$Res>
    implements $DirectorCopyWith<$Res> {
  factory _$DirectorCopyWith(_Director value, $Res Function(_Director) _then) =
      __$DirectorCopyWithImpl;
  @override
  @useResult
  $Res call({String? name, Assistant? assistant});

  @override
  $AssistantCopyWith<$Res>? get assistant;
}

/// @nodoc
class __$DirectorCopyWithImpl<$Res> implements _$DirectorCopyWith<$Res> {
  __$DirectorCopyWithImpl(this._self, this._then);

  final _Director _self;
  final $Res Function(_Director) _then;

  /// Create a copy of Director
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = freezed,
    Object? assistant = freezed,
  }) {
    return _then(_Director(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      assistant: freezed == assistant
          ? _self.assistant
          : assistant // ignore: cast_nullable_to_non_nullable
              as Assistant?,
    ));
  }

  /// Create a copy of Director
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AssistantCopyWith<$Res>? get assistant {
    if (_self.assistant == null) {
      return null;
    }

    return $AssistantCopyWith<$Res>(_self.assistant!, (value) {
      return _then(_self.copyWith(assistant: value));
    });
  }
}

/// @nodoc
mixin _$Assistant {
  String? get name;
  int? get age;

  /// Create a copy of Assistant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AssistantCopyWith<Assistant> get copyWith =>
      _$AssistantCopyWithImpl<Assistant>(this as Assistant, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Assistant &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, age);

  @override
  String toString() {
    return 'Assistant(name: $name, age: $age)';
  }
}

/// @nodoc
abstract mixin class $AssistantCopyWith<$Res> {
  factory $AssistantCopyWith(Assistant value, $Res Function(Assistant) _then) =
      _$AssistantCopyWithImpl;
  @useResult
  $Res call({String? name, int? age});
}

/// @nodoc
class _$AssistantCopyWithImpl<$Res> implements $AssistantCopyWith<$Res> {
  _$AssistantCopyWithImpl(this._self, this._then);

  final Assistant _self;
  final $Res Function(Assistant) _then;

  /// Create a copy of Assistant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? age = freezed,
  }) {
    return _then(_self.copyWith(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      age: freezed == age
          ? _self.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Assistant].
extension AssistantPatterns on Assistant {
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
    TResult Function(_Assistant value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Assistant() when $default != null:
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
    TResult Function(_Assistant value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Assistant():
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
    TResult? Function(_Assistant value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Assistant() when $default != null:
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
    TResult Function(String? name, int? age)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Assistant() when $default != null:
        return $default(_that.name, _that.age);
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
    TResult Function(String? name, int? age) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Assistant():
        return $default(_that.name, _that.age);
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
    TResult? Function(String? name, int? age)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Assistant() when $default != null:
        return $default(_that.name, _that.age);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Assistant implements Assistant {
  _Assistant({this.name, this.age});

  @override
  final String? name;
  @override
  final int? age;

  /// Create a copy of Assistant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AssistantCopyWith<_Assistant> get copyWith =>
      __$AssistantCopyWithImpl<_Assistant>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Assistant &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, age);

  @override
  String toString() {
    return 'Assistant(name: $name, age: $age)';
  }
}

/// @nodoc
abstract mixin class _$AssistantCopyWith<$Res>
    implements $AssistantCopyWith<$Res> {
  factory _$AssistantCopyWith(
          _Assistant value, $Res Function(_Assistant) _then) =
      __$AssistantCopyWithImpl;
  @override
  @useResult
  $Res call({String? name, int? age});
}

/// @nodoc
class __$AssistantCopyWithImpl<$Res> implements _$AssistantCopyWith<$Res> {
  __$AssistantCopyWithImpl(this._self, this._then);

  final _Assistant _self;
  final $Res Function(_Assistant) _then;

  /// Create a copy of Assistant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = freezed,
    Object? age = freezed,
  }) {
    return _then(_Assistant(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      age: freezed == age
          ? _self.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
mixin _$NoCommonProperty {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is NoCommonProperty);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'NoCommonProperty()';
  }
}

/// @nodoc
class $NoCommonPropertyCopyWith<$Res> {
  $NoCommonPropertyCopyWith(
      NoCommonProperty _, $Res Function(NoCommonProperty) __);
}

/// Adds pattern-matching-related methods to [NoCommonProperty].
extension NoCommonPropertyPatterns on NoCommonProperty {
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
    TResult Function(NoCommonPropertyEmpty value)? $default, {
    TResult Function(NoCommonPropertyAssistant value)? assistant,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case NoCommonPropertyEmpty() when $default != null:
        return $default(_that);
      case NoCommonPropertyAssistant() when assistant != null:
        return assistant(_that);
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
    TResult Function(NoCommonPropertyEmpty value) $default, {
    required TResult Function(NoCommonPropertyAssistant value) assistant,
  }) {
    final _that = this;
    switch (_that) {
      case NoCommonPropertyEmpty():
        return $default(_that);
      case NoCommonPropertyAssistant():
        return assistant(_that);
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
    TResult? Function(NoCommonPropertyEmpty value)? $default, {
    TResult? Function(NoCommonPropertyAssistant value)? assistant,
  }) {
    final _that = this;
    switch (_that) {
      case NoCommonPropertyEmpty() when $default != null:
        return $default(_that);
      case NoCommonPropertyAssistant() when assistant != null:
        return assistant(_that);
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
    TResult Function(Assistant assistant)? assistant,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case NoCommonPropertyEmpty() when $default != null:
        return $default();
      case NoCommonPropertyAssistant() when assistant != null:
        return assistant(_that.assistant);
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
    required TResult Function(Assistant assistant) assistant,
  }) {
    final _that = this;
    switch (_that) {
      case NoCommonPropertyEmpty():
        return $default();
      case NoCommonPropertyAssistant():
        return assistant(_that.assistant);
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
    TResult? Function(Assistant assistant)? assistant,
  }) {
    final _that = this;
    switch (_that) {
      case NoCommonPropertyEmpty() when $default != null:
        return $default();
      case NoCommonPropertyAssistant() when assistant != null:
        return assistant(_that.assistant);
      case _:
        return null;
    }
  }
}

/// @nodoc

class NoCommonPropertyEmpty implements NoCommonProperty {
  NoCommonPropertyEmpty();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is NoCommonPropertyEmpty);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'NoCommonProperty()';
  }
}

/// @nodoc

class NoCommonPropertyAssistant implements NoCommonProperty {
  NoCommonPropertyAssistant(this.assistant);

  final Assistant assistant;

  /// Create a copy of NoCommonProperty
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NoCommonPropertyAssistantCopyWith<NoCommonPropertyAssistant> get copyWith =>
      _$NoCommonPropertyAssistantCopyWithImpl<NoCommonPropertyAssistant>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NoCommonPropertyAssistant &&
            (identical(other.assistant, assistant) ||
                other.assistant == assistant));
  }

  @override
  int get hashCode => Object.hash(runtimeType, assistant);

  @override
  String toString() {
    return 'NoCommonProperty.assistant(assistant: $assistant)';
  }
}

/// @nodoc
abstract mixin class $NoCommonPropertyAssistantCopyWith<$Res>
    implements $NoCommonPropertyCopyWith<$Res> {
  factory $NoCommonPropertyAssistantCopyWith(NoCommonPropertyAssistant value,
          $Res Function(NoCommonPropertyAssistant) _then) =
      _$NoCommonPropertyAssistantCopyWithImpl;
  @useResult
  $Res call({Assistant assistant});

  $AssistantCopyWith<$Res> get assistant;
}

/// @nodoc
class _$NoCommonPropertyAssistantCopyWithImpl<$Res>
    implements $NoCommonPropertyAssistantCopyWith<$Res> {
  _$NoCommonPropertyAssistantCopyWithImpl(this._self, this._then);

  final NoCommonPropertyAssistant _self;
  final $Res Function(NoCommonPropertyAssistant) _then;

  /// Create a copy of NoCommonProperty
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? assistant = null,
  }) {
    return _then(NoCommonPropertyAssistant(
      null == assistant
          ? _self.assistant
          : assistant // ignore: cast_nullable_to_non_nullable
              as Assistant,
    ));
  }

  /// Create a copy of NoCommonProperty
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AssistantCopyWith<$Res> get assistant {
    return $AssistantCopyWith<$Res>(_self.assistant, (value) {
      return _then(_self.copyWith(assistant: value));
    });
  }
}

/// @nodoc
mixin _$Union {
  Assistant get shared;

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
            (identical(other.shared, shared) || other.shared == shared));
  }

  @override
  int get hashCode => Object.hash(runtimeType, shared);

  @override
  String toString() {
    return 'Union(shared: $shared)';
  }
}

/// @nodoc
abstract mixin class $UnionCopyWith<$Res> {
  factory $UnionCopyWith(Union value, $Res Function(Union) _then) =
      _$UnionCopyWithImpl;
  @useResult
  $Res call({Assistant shared});

  $AssistantCopyWith<$Res> get shared;
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
    Object? shared = null,
  }) {
    return _then(_self.copyWith(
      shared: null == shared
          ? _self.shared
          : shared // ignore: cast_nullable_to_non_nullable
              as Assistant,
    ));
  }

  /// Create a copy of Union
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AssistantCopyWith<$Res> get shared {
    return $AssistantCopyWith<$Res>(_self.shared, (value) {
      return _then(_self.copyWith(shared: value));
    });
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
    TResult Function(UnionFirst value)? first,
    TResult Function(UnionSecond value)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case UnionFirst() when first != null:
        return first(_that);
      case UnionSecond() when second != null:
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
    required TResult Function(UnionFirst value) first,
    required TResult Function(UnionSecond value) second,
  }) {
    final _that = this;
    switch (_that) {
      case UnionFirst():
        return first(_that);
      case UnionSecond():
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
    TResult? Function(UnionFirst value)? first,
    TResult? Function(UnionSecond value)? second,
  }) {
    final _that = this;
    switch (_that) {
      case UnionFirst() when first != null:
        return first(_that);
      case UnionSecond() when second != null:
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
    TResult Function(Assistant shared, Assistant first)? first,
    TResult Function(Assistant shared, Assistant second)? second,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case UnionFirst() when first != null:
        return first(_that.shared, _that.first);
      case UnionSecond() when second != null:
        return second(_that.shared, _that.second);
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
    required TResult Function(Assistant shared, Assistant first) first,
    required TResult Function(Assistant shared, Assistant second) second,
  }) {
    final _that = this;
    switch (_that) {
      case UnionFirst():
        return first(_that.shared, _that.first);
      case UnionSecond():
        return second(_that.shared, _that.second);
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
    TResult? Function(Assistant shared, Assistant first)? first,
    TResult? Function(Assistant shared, Assistant second)? second,
  }) {
    final _that = this;
    switch (_that) {
      case UnionFirst() when first != null:
        return first(_that.shared, _that.first);
      case UnionSecond() when second != null:
        return second(_that.shared, _that.second);
      case _:
        return null;
    }
  }
}

/// @nodoc

class UnionFirst implements Union {
  UnionFirst(this.shared, this.first);

  @override
  final Assistant shared;
  final Assistant first;

  /// Create a copy of Union
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnionFirstCopyWith<UnionFirst> get copyWith =>
      _$UnionFirstCopyWithImpl<UnionFirst>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnionFirst &&
            (identical(other.shared, shared) || other.shared == shared) &&
            (identical(other.first, first) || other.first == first));
  }

  @override
  int get hashCode => Object.hash(runtimeType, shared, first);

  @override
  String toString() {
    return 'Union.first(shared: $shared, first: $first)';
  }
}

/// @nodoc
abstract mixin class $UnionFirstCopyWith<$Res> implements $UnionCopyWith<$Res> {
  factory $UnionFirstCopyWith(
          UnionFirst value, $Res Function(UnionFirst) _then) =
      _$UnionFirstCopyWithImpl;
  @override
  @useResult
  $Res call({Assistant shared, Assistant first});

  @override
  $AssistantCopyWith<$Res> get shared;
  $AssistantCopyWith<$Res> get first;
}

/// @nodoc
class _$UnionFirstCopyWithImpl<$Res> implements $UnionFirstCopyWith<$Res> {
  _$UnionFirstCopyWithImpl(this._self, this._then);

  final UnionFirst _self;
  final $Res Function(UnionFirst) _then;

  /// Create a copy of Union
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? shared = null,
    Object? first = null,
  }) {
    return _then(UnionFirst(
      null == shared
          ? _self.shared
          : shared // ignore: cast_nullable_to_non_nullable
              as Assistant,
      null == first
          ? _self.first
          : first // ignore: cast_nullable_to_non_nullable
              as Assistant,
    ));
  }

  /// Create a copy of Union
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AssistantCopyWith<$Res> get shared {
    return $AssistantCopyWith<$Res>(_self.shared, (value) {
      return _then(_self.copyWith(shared: value));
    });
  }

  /// Create a copy of Union
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AssistantCopyWith<$Res> get first {
    return $AssistantCopyWith<$Res>(_self.first, (value) {
      return _then(_self.copyWith(first: value));
    });
  }
}

/// @nodoc

class UnionSecond implements Union {
  UnionSecond(this.shared, this.second);

  @override
  final Assistant shared;
  final Assistant second;

  /// Create a copy of Union
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnionSecondCopyWith<UnionSecond> get copyWith =>
      _$UnionSecondCopyWithImpl<UnionSecond>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnionSecond &&
            (identical(other.shared, shared) || other.shared == shared) &&
            (identical(other.second, second) || other.second == second));
  }

  @override
  int get hashCode => Object.hash(runtimeType, shared, second);

  @override
  String toString() {
    return 'Union.second(shared: $shared, second: $second)';
  }
}

/// @nodoc
abstract mixin class $UnionSecondCopyWith<$Res>
    implements $UnionCopyWith<$Res> {
  factory $UnionSecondCopyWith(
          UnionSecond value, $Res Function(UnionSecond) _then) =
      _$UnionSecondCopyWithImpl;
  @override
  @useResult
  $Res call({Assistant shared, Assistant second});

  @override
  $AssistantCopyWith<$Res> get shared;
  $AssistantCopyWith<$Res> get second;
}

/// @nodoc
class _$UnionSecondCopyWithImpl<$Res> implements $UnionSecondCopyWith<$Res> {
  _$UnionSecondCopyWithImpl(this._self, this._then);

  final UnionSecond _self;
  final $Res Function(UnionSecond) _then;

  /// Create a copy of Union
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? shared = null,
    Object? second = null,
  }) {
    return _then(UnionSecond(
      null == shared
          ? _self.shared
          : shared // ignore: cast_nullable_to_non_nullable
              as Assistant,
      null == second
          ? _self.second
          : second // ignore: cast_nullable_to_non_nullable
              as Assistant,
    ));
  }

  /// Create a copy of Union
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AssistantCopyWith<$Res> get shared {
    return $AssistantCopyWith<$Res>(_self.shared, (value) {
      return _then(_self.copyWith(shared: value));
    });
  }

  /// Create a copy of Union
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AssistantCopyWith<$Res> get second {
    return $AssistantCopyWith<$Res>(_self.second, (value) {
      return _then(_self.copyWith(second: value));
    });
  }
}

/// @nodoc
mixin _$Private {
  Assistant get assistant;

  /// Create a copy of _Private
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PrivateCopyWith<_Private> get copyWith =>
      __$PrivateCopyWithImpl<_Private>(this as _Private, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Private &&
            (identical(other.assistant, assistant) ||
                other.assistant == assistant));
  }

  @override
  int get hashCode => Object.hash(runtimeType, assistant);

  @override
  String toString() {
    return '_Private(assistant: $assistant)';
  }
}

/// @nodoc
abstract mixin class _$PrivateCopyWith<$Res> {
  factory _$PrivateCopyWith(_Private value, $Res Function(_Private) _then) =
      __$PrivateCopyWithImpl;
  @useResult
  $Res call({Assistant assistant});

  $AssistantCopyWith<$Res> get assistant;
}

/// @nodoc
class __$PrivateCopyWithImpl<$Res> implements _$PrivateCopyWith<$Res> {
  __$PrivateCopyWithImpl(this._self, this._then);

  final _Private _self;
  final $Res Function(_Private) _then;

  /// Create a copy of _Private
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assistant = null,
  }) {
    return _then(_self.copyWith(
      assistant: null == assistant
          ? _self.assistant
          : assistant // ignore: cast_nullable_to_non_nullable
              as Assistant,
    ));
  }

  /// Create a copy of _Private
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AssistantCopyWith<$Res> get assistant {
    return $AssistantCopyWith<$Res>(_self.assistant, (value) {
      return _then(_self.copyWith(assistant: value));
    });
  }
}

/// Adds pattern-matching-related methods to [_Private].
extension _PrivatePatterns on _Private {
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
    TResult Function(__Private value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case __Private() when $default != null:
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
    TResult Function(__Private value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case __Private():
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
    TResult? Function(__Private value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case __Private() when $default != null:
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
    TResult Function(Assistant assistant)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case __Private() when $default != null:
        return $default(_that.assistant);
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
    TResult Function(Assistant assistant) $default,
  ) {
    final _that = this;
    switch (_that) {
      case __Private():
        return $default(_that.assistant);
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
    TResult? Function(Assistant assistant)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case __Private() when $default != null:
        return $default(_that.assistant);
      case _:
        return null;
    }
  }
}

/// @nodoc

class __Private implements _Private {
  __Private(this.assistant);

  @override
  final Assistant assistant;

  /// Create a copy of _Private
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$_PrivateCopyWith<__Private> get copyWith =>
      __$_PrivateCopyWithImpl<__Private>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is __Private &&
            (identical(other.assistant, assistant) ||
                other.assistant == assistant));
  }

  @override
  int get hashCode => Object.hash(runtimeType, assistant);

  @override
  String toString() {
    return '_Private(assistant: $assistant)';
  }
}

/// @nodoc
abstract mixin class _$_PrivateCopyWith<$Res>
    implements _$PrivateCopyWith<$Res> {
  factory _$_PrivateCopyWith(__Private value, $Res Function(__Private) _then) =
      __$_PrivateCopyWithImpl;
  @override
  @useResult
  $Res call({Assistant assistant});

  @override
  $AssistantCopyWith<$Res> get assistant;
}

/// @nodoc
class __$_PrivateCopyWithImpl<$Res> implements _$_PrivateCopyWith<$Res> {
  __$_PrivateCopyWithImpl(this._self, this._then);

  final __Private _self;
  final $Res Function(__Private) _then;

  /// Create a copy of _Private
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? assistant = null,
  }) {
    return _then(__Private(
      null == assistant
          ? _self.assistant
          : assistant // ignore: cast_nullable_to_non_nullable
              as Assistant,
    ));
  }

  /// Create a copy of _Private
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AssistantCopyWith<$Res> get assistant {
    return $AssistantCopyWith<$Res>(_self.assistant, (value) {
      return _then(_self.copyWith(assistant: value));
    });
  }
}

/// @nodoc
mixin _$DeepGeneric<T> {
  Generic<T> get value;
  T get second;

  /// Create a copy of DeepGeneric
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DeepGenericCopyWith<T, DeepGeneric<T>> get copyWith =>
      _$DeepGenericCopyWithImpl<T, DeepGeneric<T>>(
          this as DeepGeneric<T>, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DeepGeneric<T> &&
            (identical(other.value, value) || other.value == value) &&
            const DeepCollectionEquality().equals(other.second, second));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, value, const DeepCollectionEquality().hash(second));

  @override
  String toString() {
    return 'DeepGeneric<$T>(value: $value, second: $second)';
  }
}

/// @nodoc
abstract mixin class $DeepGenericCopyWith<T, $Res> {
  factory $DeepGenericCopyWith(
          DeepGeneric<T> value, $Res Function(DeepGeneric<T>) _then) =
      _$DeepGenericCopyWithImpl;
  @useResult
  $Res call({Generic<T> value, T second});

  $GenericCopyWith<T, $Res> get value;
}

/// @nodoc
class _$DeepGenericCopyWithImpl<T, $Res>
    implements $DeepGenericCopyWith<T, $Res> {
  _$DeepGenericCopyWithImpl(this._self, this._then);

  final DeepGeneric<T> _self;
  final $Res Function(DeepGeneric<T>) _then;

  /// Create a copy of DeepGeneric
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? second = freezed,
  }) {
    return _then(_self.copyWith(
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as Generic<T>,
      second: freezed == second
          ? _self.second
          : second // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }

  /// Create a copy of DeepGeneric
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GenericCopyWith<T, $Res> get value {
    return $GenericCopyWith<T, $Res>(_self.value, (value) {
      return _then(_self.copyWith(value: value));
    });
  }
}

/// Adds pattern-matching-related methods to [DeepGeneric].
extension DeepGenericPatterns<T> on DeepGeneric<T> {
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
    TResult Function(_DeepGeneric<T> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DeepGeneric() when $default != null:
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
    TResult Function(_DeepGeneric<T> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DeepGeneric():
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
    TResult? Function(_DeepGeneric<T> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DeepGeneric() when $default != null:
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
    TResult Function(Generic<T> value, T second)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DeepGeneric() when $default != null:
        return $default(_that.value, _that.second);
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
    TResult Function(Generic<T> value, T second) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DeepGeneric():
        return $default(_that.value, _that.second);
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
    TResult? Function(Generic<T> value, T second)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DeepGeneric() when $default != null:
        return $default(_that.value, _that.second);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DeepGeneric<T> implements DeepGeneric<T> {
  _DeepGeneric(this.value, this.second);

  @override
  final Generic<T> value;
  @override
  final T second;

  /// Create a copy of DeepGeneric
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DeepGenericCopyWith<T, _DeepGeneric<T>> get copyWith =>
      __$DeepGenericCopyWithImpl<T, _DeepGeneric<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DeepGeneric<T> &&
            (identical(other.value, value) || other.value == value) &&
            const DeepCollectionEquality().equals(other.second, second));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, value, const DeepCollectionEquality().hash(second));

  @override
  String toString() {
    return 'DeepGeneric<$T>(value: $value, second: $second)';
  }
}

/// @nodoc
abstract mixin class _$DeepGenericCopyWith<T, $Res>
    implements $DeepGenericCopyWith<T, $Res> {
  factory _$DeepGenericCopyWith(
          _DeepGeneric<T> value, $Res Function(_DeepGeneric<T>) _then) =
      __$DeepGenericCopyWithImpl;
  @override
  @useResult
  $Res call({Generic<T> value, T second});

  @override
  $GenericCopyWith<T, $Res> get value;
}

/// @nodoc
class __$DeepGenericCopyWithImpl<T, $Res>
    implements _$DeepGenericCopyWith<T, $Res> {
  __$DeepGenericCopyWithImpl(this._self, this._then);

  final _DeepGeneric<T> _self;
  final $Res Function(_DeepGeneric<T>) _then;

  /// Create a copy of DeepGeneric
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
    Object? second = freezed,
  }) {
    return _then(_DeepGeneric<T>(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as Generic<T>,
      freezed == second
          ? _self.second
          : second // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }

  /// Create a copy of DeepGeneric
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GenericCopyWith<T, $Res> get value {
    return $GenericCopyWith<T, $Res>(_self.value, (value) {
      return _then(_self.copyWith(value: value));
    });
  }
}

/// @nodoc
mixin _$Generic<T> {
  T get value;
  T get value2;

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
            const DeepCollectionEquality().equals(other.value, value) &&
            const DeepCollectionEquality().equals(other.value2, value2));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(value),
      const DeepCollectionEquality().hash(value2));

  @override
  String toString() {
    return 'Generic<$T>(value: $value, value2: $value2)';
  }
}

/// @nodoc
abstract mixin class $GenericCopyWith<T, $Res> {
  factory $GenericCopyWith(Generic<T> value, $Res Function(Generic<T>) _then) =
      _$GenericCopyWithImpl;
  @useResult
  $Res call({T value, T value2});
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
    Object? value2 = freezed,
  }) {
    return _then(_self.copyWith(
      value: freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
      value2: freezed == value2
          ? _self.value2
          : value2 // ignore: cast_nullable_to_non_nullable
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
    TResult Function(T value, T value2)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Generic() when $default != null:
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
    TResult Function(T value, T value2) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Generic():
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
    TResult? Function(T value, T value2)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Generic() when $default != null:
        return $default(_that.value, _that.value2);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Generic<T> implements Generic<T> {
  _Generic(this.value, this.value2);

  @override
  final T value;
  @override
  final T value2;

  /// Create a copy of Generic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GenericCopyWith<T, _Generic<T>> get copyWith =>
      __$GenericCopyWithImpl<T, _Generic<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Generic<T> &&
            const DeepCollectionEquality().equals(other.value, value) &&
            const DeepCollectionEquality().equals(other.value2, value2));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(value),
      const DeepCollectionEquality().hash(value2));

  @override
  String toString() {
    return 'Generic<$T>(value: $value, value2: $value2)';
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
  $Res call({T value, T value2});
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
    Object? value = freezed,
    Object? value2 = freezed,
  }) {
    return _then(_Generic<T>(
      freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
      freezed == value2
          ? _self.value2
          : value2 // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc
mixin _$Recursive {
  Recursive? get value;

  /// Create a copy of Recursive
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RecursiveCopyWith<Recursive> get copyWith =>
      _$RecursiveCopyWithImpl<Recursive>(this as Recursive, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Recursive &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'Recursive(value: $value)';
  }
}

/// @nodoc
abstract mixin class $RecursiveCopyWith<$Res> {
  factory $RecursiveCopyWith(Recursive value, $Res Function(Recursive) _then) =
      _$RecursiveCopyWithImpl;
  @useResult
  $Res call({Recursive? value});

  $RecursiveCopyWith<$Res>? get value;
}

/// @nodoc
class _$RecursiveCopyWithImpl<$Res> implements $RecursiveCopyWith<$Res> {
  _$RecursiveCopyWithImpl(this._self, this._then);

  final Recursive _self;
  final $Res Function(Recursive) _then;

  /// Create a copy of Recursive
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
              as Recursive?,
    ));
  }

  /// Create a copy of Recursive
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecursiveCopyWith<$Res>? get value {
    if (_self.value == null) {
      return null;
    }

    return $RecursiveCopyWith<$Res>(_self.value!, (value) {
      return _then(_self.copyWith(value: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Recursive].
extension RecursivePatterns on Recursive {
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
    TResult Function(_Recursive value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Recursive() when $default != null:
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
    TResult Function(_Recursive value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Recursive():
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
    TResult? Function(_Recursive value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Recursive() when $default != null:
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
    TResult Function(Recursive? value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Recursive() when $default != null:
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
    TResult Function(Recursive? value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Recursive():
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
    TResult? Function(Recursive? value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Recursive() when $default != null:
        return $default(_that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Recursive implements Recursive {
  _Recursive([this.value]);

  @override
  final Recursive? value;

  /// Create a copy of Recursive
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RecursiveCopyWith<_Recursive> get copyWith =>
      __$RecursiveCopyWithImpl<_Recursive>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Recursive &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'Recursive(value: $value)';
  }
}

/// @nodoc
abstract mixin class _$RecursiveCopyWith<$Res>
    implements $RecursiveCopyWith<$Res> {
  factory _$RecursiveCopyWith(
          _Recursive value, $Res Function(_Recursive) _then) =
      __$RecursiveCopyWithImpl;
  @override
  @useResult
  $Res call({Recursive? value});

  @override
  $RecursiveCopyWith<$Res>? get value;
}

/// @nodoc
class __$RecursiveCopyWithImpl<$Res> implements _$RecursiveCopyWith<$Res> {
  __$RecursiveCopyWithImpl(this._self, this._then);

  final _Recursive _self;
  final $Res Function(_Recursive) _then;

  /// Create a copy of Recursive
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_Recursive(
      freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as Recursive?,
    ));
  }

  /// Create a copy of Recursive
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecursiveCopyWith<$Res>? get value {
    if (_self.value == null) {
      return null;
    }

    return $RecursiveCopyWith<$Res>(_self.value!, (value) {
      return _then(_self.copyWith(value: value));
    });
  }
}

/// @nodoc
mixin _$DisabledDeepCopyWith {
  DisabledCopy get disabled;

  /// Create a copy of DisabledDeepCopyWith
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DisabledDeepCopyWithCopyWith<DisabledDeepCopyWith> get copyWith =>
      _$DisabledDeepCopyWithCopyWithImpl<DisabledDeepCopyWith>(
          this as DisabledDeepCopyWith, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DisabledDeepCopyWith &&
            (identical(other.disabled, disabled) ||
                other.disabled == disabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, disabled);

  @override
  String toString() {
    return 'DisabledDeepCopyWith(disabled: $disabled)';
  }
}

/// @nodoc
abstract mixin class $DisabledDeepCopyWithCopyWith<$Res> {
  factory $DisabledDeepCopyWithCopyWith(DisabledDeepCopyWith value,
          $Res Function(DisabledDeepCopyWith) _then) =
      _$DisabledDeepCopyWithCopyWithImpl;
  @useResult
  $Res call({DisabledCopy disabled});
}

/// @nodoc
class _$DisabledDeepCopyWithCopyWithImpl<$Res>
    implements $DisabledDeepCopyWithCopyWith<$Res> {
  _$DisabledDeepCopyWithCopyWithImpl(this._self, this._then);

  final DisabledDeepCopyWith _self;
  final $Res Function(DisabledDeepCopyWith) _then;

  /// Create a copy of DisabledDeepCopyWith
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? disabled = null,
  }) {
    return _then(_self.copyWith(
      disabled: null == disabled
          ? _self.disabled
          : disabled // ignore: cast_nullable_to_non_nullable
              as DisabledCopy,
    ));
  }
}

/// Adds pattern-matching-related methods to [DisabledDeepCopyWith].
extension DisabledDeepCopyWithPatterns on DisabledDeepCopyWith {
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
    TResult Function(_DisabledDeepCopyWith value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DisabledDeepCopyWith() when $default != null:
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
    TResult Function(_DisabledDeepCopyWith value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DisabledDeepCopyWith():
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
    TResult? Function(_DisabledDeepCopyWith value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DisabledDeepCopyWith() when $default != null:
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
    TResult Function(DisabledCopy disabled)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DisabledDeepCopyWith() when $default != null:
        return $default(_that.disabled);
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
    TResult Function(DisabledCopy disabled) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DisabledDeepCopyWith():
        return $default(_that.disabled);
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
    TResult? Function(DisabledCopy disabled)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DisabledDeepCopyWith() when $default != null:
        return $default(_that.disabled);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DisabledDeepCopyWith implements DisabledDeepCopyWith {
  _DisabledDeepCopyWith(this.disabled);

  @override
  final DisabledCopy disabled;

  /// Create a copy of DisabledDeepCopyWith
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DisabledDeepCopyWithCopyWith<_DisabledDeepCopyWith> get copyWith =>
      __$DisabledDeepCopyWithCopyWithImpl<_DisabledDeepCopyWith>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DisabledDeepCopyWith &&
            (identical(other.disabled, disabled) ||
                other.disabled == disabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, disabled);

  @override
  String toString() {
    return 'DisabledDeepCopyWith(disabled: $disabled)';
  }
}

/// @nodoc
abstract mixin class _$DisabledDeepCopyWithCopyWith<$Res>
    implements $DisabledDeepCopyWithCopyWith<$Res> {
  factory _$DisabledDeepCopyWithCopyWith(_DisabledDeepCopyWith value,
          $Res Function(_DisabledDeepCopyWith) _then) =
      __$DisabledDeepCopyWithCopyWithImpl;
  @override
  @useResult
  $Res call({DisabledCopy disabled});
}

/// @nodoc
class __$DisabledDeepCopyWithCopyWithImpl<$Res>
    implements _$DisabledDeepCopyWithCopyWith<$Res> {
  __$DisabledDeepCopyWithCopyWithImpl(this._self, this._then);

  final _DisabledDeepCopyWith _self;
  final $Res Function(_DisabledDeepCopyWith) _then;

  /// Create a copy of DisabledDeepCopyWith
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? disabled = null,
  }) {
    return _then(_DisabledDeepCopyWith(
      null == disabled
          ? _self.disabled
          : disabled // ignore: cast_nullable_to_non_nullable
              as DisabledCopy,
    ));
  }
}

/// @nodoc
mixin _$DisabledCopy {
  DisabledCopy get disabled;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DisabledCopy &&
            (identical(other.disabled, disabled) ||
                other.disabled == disabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, disabled);

  @override
  String toString() {
    return 'DisabledCopy(disabled: $disabled)';
  }
}

/// Adds pattern-matching-related methods to [DisabledCopy].
extension DisabledCopyPatterns on DisabledCopy {
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
    TResult Function(_DisabledCopy value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DisabledCopy() when $default != null:
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
    TResult Function(_DisabledCopy value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DisabledCopy():
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
    TResult? Function(_DisabledCopy value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DisabledCopy() when $default != null:
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
    TResult Function(DisabledCopy disabled)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DisabledCopy() when $default != null:
        return $default(_that.disabled);
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
    TResult Function(DisabledCopy disabled) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DisabledCopy():
        return $default(_that.disabled);
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
    TResult? Function(DisabledCopy disabled)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DisabledCopy() when $default != null:
        return $default(_that.disabled);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DisabledCopy implements DisabledCopy {
  _DisabledCopy(this.disabled);

  @override
  final DisabledCopy disabled;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DisabledCopy &&
            (identical(other.disabled, disabled) ||
                other.disabled == disabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, disabled);

  @override
  String toString() {
    return 'DisabledCopy(disabled: $disabled)';
  }
}
