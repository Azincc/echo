// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'implements_decorator.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SimpleImplements {
  String get name;

  /// Create a copy of SimpleImplements
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SimpleImplementsCopyWith<SimpleImplements> get copyWith =>
      _$SimpleImplementsCopyWithImpl<SimpleImplements>(
          this as SimpleImplements, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SimpleImplements &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  @override
  String toString() {
    return 'SimpleImplements(name: $name)';
  }
}

/// @nodoc
abstract mixin class $SimpleImplementsCopyWith<$Res> {
  factory $SimpleImplementsCopyWith(
          SimpleImplements value, $Res Function(SimpleImplements) _then) =
      _$SimpleImplementsCopyWithImpl;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$SimpleImplementsCopyWithImpl<$Res>
    implements $SimpleImplementsCopyWith<$Res> {
  _$SimpleImplementsCopyWithImpl(this._self, this._then);

  final SimpleImplements _self;
  final $Res Function(SimpleImplements) _then;

  /// Create a copy of SimpleImplements
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [SimpleImplements].
extension SimpleImplementsPatterns on SimpleImplements {
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
    TResult Function(SimplePerson value)? person,
    TResult Function(SimpleStreet value)? street,
    TResult Function(SimpleCity value)? city,
    TResult Function(SimpleCountry value)? country,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SimplePerson() when person != null:
        return person(_that);
      case SimpleStreet() when street != null:
        return street(_that);
      case SimpleCity() when city != null:
        return city(_that);
      case SimpleCountry() when country != null:
        return country(_that);
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
    required TResult Function(SimplePerson value) person,
    required TResult Function(SimpleStreet value) street,
    required TResult Function(SimpleCity value) city,
    required TResult Function(SimpleCountry value) country,
  }) {
    final _that = this;
    switch (_that) {
      case SimplePerson():
        return person(_that);
      case SimpleStreet():
        return street(_that);
      case SimpleCity():
        return city(_that);
      case SimpleCountry():
        return country(_that);
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
    TResult? Function(SimplePerson value)? person,
    TResult? Function(SimpleStreet value)? street,
    TResult? Function(SimpleCity value)? city,
    TResult? Function(SimpleCountry value)? country,
  }) {
    final _that = this;
    switch (_that) {
      case SimplePerson() when person != null:
        return person(_that);
      case SimpleStreet() when street != null:
        return street(_that);
      case SimpleCity() when city != null:
        return city(_that);
      case SimpleCountry() when country != null:
        return country(_that);
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
    TResult Function(String name, int age)? person,
    TResult Function(String name)? street,
    TResult Function(String name, int population)? city,
    TResult Function(String name, int population)? country,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SimplePerson() when person != null:
        return person(_that.name, _that.age);
      case SimpleStreet() when street != null:
        return street(_that.name);
      case SimpleCity() when city != null:
        return city(_that.name, _that.population);
      case SimpleCountry() when country != null:
        return country(_that.name, _that.population);
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
    required TResult Function(String name, int age) person,
    required TResult Function(String name) street,
    required TResult Function(String name, int population) city,
    required TResult Function(String name, int population) country,
  }) {
    final _that = this;
    switch (_that) {
      case SimplePerson():
        return person(_that.name, _that.age);
      case SimpleStreet():
        return street(_that.name);
      case SimpleCity():
        return city(_that.name, _that.population);
      case SimpleCountry():
        return country(_that.name, _that.population);
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
    TResult? Function(String name, int age)? person,
    TResult? Function(String name)? street,
    TResult? Function(String name, int population)? city,
    TResult? Function(String name, int population)? country,
  }) {
    final _that = this;
    switch (_that) {
      case SimplePerson() when person != null:
        return person(_that.name, _that.age);
      case SimpleStreet() when street != null:
        return street(_that.name);
      case SimpleCity() when city != null:
        return city(_that.name, _that.population);
      case SimpleCountry() when country != null:
        return country(_that.name, _that.population);
      case _:
        return null;
    }
  }
}

/// @nodoc

class SimplePerson implements SimpleImplements {
  const SimplePerson(this.name, this.age);

  @override
  final String name;
  final int age;

  /// Create a copy of SimpleImplements
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SimplePersonCopyWith<SimplePerson> get copyWith =>
      _$SimplePersonCopyWithImpl<SimplePerson>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SimplePerson &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, age);

  @override
  String toString() {
    return 'SimpleImplements.person(name: $name, age: $age)';
  }
}

/// @nodoc
abstract mixin class $SimplePersonCopyWith<$Res>
    implements $SimpleImplementsCopyWith<$Res> {
  factory $SimplePersonCopyWith(
          SimplePerson value, $Res Function(SimplePerson) _then) =
      _$SimplePersonCopyWithImpl;
  @override
  @useResult
  $Res call({String name, int age});
}

/// @nodoc
class _$SimplePersonCopyWithImpl<$Res> implements $SimplePersonCopyWith<$Res> {
  _$SimplePersonCopyWithImpl(this._self, this._then);

  final SimplePerson _self;
  final $Res Function(SimplePerson) _then;

  /// Create a copy of SimpleImplements
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? age = null,
  }) {
    return _then(SimplePerson(
      null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == age
          ? _self.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class SimpleStreet with AdministrativeArea<House> implements SimpleImplements {
  const SimpleStreet(this.name);

  @override
  final String name;

  /// Create a copy of SimpleImplements
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SimpleStreetCopyWith<SimpleStreet> get copyWith =>
      _$SimpleStreetCopyWithImpl<SimpleStreet>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SimpleStreet &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  @override
  String toString() {
    return 'SimpleImplements.street(name: $name)';
  }
}

/// @nodoc
abstract mixin class $SimpleStreetCopyWith<$Res>
    implements $SimpleImplementsCopyWith<$Res> {
  factory $SimpleStreetCopyWith(
          SimpleStreet value, $Res Function(SimpleStreet) _then) =
      _$SimpleStreetCopyWithImpl;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$SimpleStreetCopyWithImpl<$Res> implements $SimpleStreetCopyWith<$Res> {
  _$SimpleStreetCopyWithImpl(this._self, this._then);

  final SimpleStreet _self;
  final $Res Function(SimpleStreet) _then;

  /// Create a copy of SimpleImplements
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
  }) {
    return _then(SimpleStreet(
      null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class SimpleCity with House implements SimpleImplements {
  const SimpleCity(this.name, this.population);

  @override
  final String name;
  final int population;

  /// Create a copy of SimpleImplements
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SimpleCityCopyWith<SimpleCity> get copyWith =>
      _$SimpleCityCopyWithImpl<SimpleCity>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SimpleCity &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.population, population) ||
                other.population == population));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, population);

  @override
  String toString() {
    return 'SimpleImplements.city(name: $name, population: $population)';
  }
}

/// @nodoc
abstract mixin class $SimpleCityCopyWith<$Res>
    implements $SimpleImplementsCopyWith<$Res> {
  factory $SimpleCityCopyWith(
          SimpleCity value, $Res Function(SimpleCity) _then) =
      _$SimpleCityCopyWithImpl;
  @override
  @useResult
  $Res call({String name, int population});
}

/// @nodoc
class _$SimpleCityCopyWithImpl<$Res> implements $SimpleCityCopyWith<$Res> {
  _$SimpleCityCopyWithImpl(this._self, this._then);

  final SimpleCity _self;
  final $Res Function(SimpleCity) _then;

  /// Create a copy of SimpleImplements
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? population = null,
  }) {
    return _then(SimpleCity(
      null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == population
          ? _self.population
          : population // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class SimpleCountry with House implements SimpleImplements, GeographicArea {
  const SimpleCountry(this.name, this.population);

  @override
  final String name;
  final int population;

  /// Create a copy of SimpleImplements
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SimpleCountryCopyWith<SimpleCountry> get copyWith =>
      _$SimpleCountryCopyWithImpl<SimpleCountry>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SimpleCountry &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.population, population) ||
                other.population == population));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, population);

  @override
  String toString() {
    return 'SimpleImplements.country(name: $name, population: $population)';
  }
}

/// @nodoc
abstract mixin class $SimpleCountryCopyWith<$Res>
    implements $SimpleImplementsCopyWith<$Res> {
  factory $SimpleCountryCopyWith(
          SimpleCountry value, $Res Function(SimpleCountry) _then) =
      _$SimpleCountryCopyWithImpl;
  @override
  @useResult
  $Res call({String name, int population});
}

/// @nodoc
class _$SimpleCountryCopyWithImpl<$Res>
    implements $SimpleCountryCopyWith<$Res> {
  _$SimpleCountryCopyWithImpl(this._self, this._then);

  final SimpleCountry _self;
  final $Res Function(SimpleCountry) _then;

  /// Create a copy of SimpleImplements
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? population = null,
  }) {
    return _then(SimpleCountry(
      null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == population
          ? _self.population
          : population // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$CustomMethodImplements {
  String get name;

  /// Create a copy of CustomMethodImplements
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomMethodImplementsCopyWith<CustomMethodImplements> get copyWith =>
      _$CustomMethodImplementsCopyWithImpl<CustomMethodImplements>(
          this as CustomMethodImplements, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomMethodImplements &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  @override
  String toString() {
    return 'CustomMethodImplements(name: $name)';
  }
}

/// @nodoc
abstract mixin class $CustomMethodImplementsCopyWith<$Res> {
  factory $CustomMethodImplementsCopyWith(CustomMethodImplements value,
          $Res Function(CustomMethodImplements) _then) =
      _$CustomMethodImplementsCopyWithImpl;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$CustomMethodImplementsCopyWithImpl<$Res>
    implements $CustomMethodImplementsCopyWith<$Res> {
  _$CustomMethodImplementsCopyWithImpl(this._self, this._then);

  final CustomMethodImplements _self;
  final $Res Function(CustomMethodImplements) _then;

  /// Create a copy of CustomMethodImplements
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [CustomMethodImplements].
extension CustomMethodImplementsPatterns on CustomMethodImplements {
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
    TResult Function(PersonCustomMethod value)? person,
    TResult Function(StreetCustomMethod value)? street,
    TResult Function(CityCustomMethod value)? city,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case PersonCustomMethod() when person != null:
        return person(_that);
      case StreetCustomMethod() when street != null:
        return street(_that);
      case CityCustomMethod() when city != null:
        return city(_that);
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
    required TResult Function(PersonCustomMethod value) person,
    required TResult Function(StreetCustomMethod value) street,
    required TResult Function(CityCustomMethod value) city,
  }) {
    final _that = this;
    switch (_that) {
      case PersonCustomMethod():
        return person(_that);
      case StreetCustomMethod():
        return street(_that);
      case CityCustomMethod():
        return city(_that);
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
    TResult? Function(PersonCustomMethod value)? person,
    TResult? Function(StreetCustomMethod value)? street,
    TResult? Function(CityCustomMethod value)? city,
  }) {
    final _that = this;
    switch (_that) {
      case PersonCustomMethod() when person != null:
        return person(_that);
      case StreetCustomMethod() when street != null:
        return street(_that);
      case CityCustomMethod() when city != null:
        return city(_that);
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
    TResult Function(String name, int age)? person,
    TResult Function(String name)? street,
    TResult Function(String name, int population)? city,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case PersonCustomMethod() when person != null:
        return person(_that.name, _that.age);
      case StreetCustomMethod() when street != null:
        return street(_that.name);
      case CityCustomMethod() when city != null:
        return city(_that.name, _that.population);
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
    required TResult Function(String name, int age) person,
    required TResult Function(String name) street,
    required TResult Function(String name, int population) city,
  }) {
    final _that = this;
    switch (_that) {
      case PersonCustomMethod():
        return person(_that.name, _that.age);
      case StreetCustomMethod():
        return street(_that.name);
      case CityCustomMethod():
        return city(_that.name, _that.population);
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
    TResult? Function(String name, int age)? person,
    TResult? Function(String name)? street,
    TResult? Function(String name, int population)? city,
  }) {
    final _that = this;
    switch (_that) {
      case PersonCustomMethod() when person != null:
        return person(_that.name, _that.age);
      case StreetCustomMethod() when street != null:
        return street(_that.name);
      case CityCustomMethod() when city != null:
        return city(_that.name, _that.population);
      case _:
        return null;
    }
  }
}

/// @nodoc

class PersonCustomMethod extends CustomMethodImplements {
  const PersonCustomMethod(this.name, this.age) : super._();

  @override
  final String name;
  final int age;

  /// Create a copy of CustomMethodImplements
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PersonCustomMethodCopyWith<PersonCustomMethod> get copyWith =>
      _$PersonCustomMethodCopyWithImpl<PersonCustomMethod>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PersonCustomMethod &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, age);

  @override
  String toString() {
    return 'CustomMethodImplements.person(name: $name, age: $age)';
  }
}

/// @nodoc
abstract mixin class $PersonCustomMethodCopyWith<$Res>
    implements $CustomMethodImplementsCopyWith<$Res> {
  factory $PersonCustomMethodCopyWith(
          PersonCustomMethod value, $Res Function(PersonCustomMethod) _then) =
      _$PersonCustomMethodCopyWithImpl;
  @override
  @useResult
  $Res call({String name, int age});
}

/// @nodoc
class _$PersonCustomMethodCopyWithImpl<$Res>
    implements $PersonCustomMethodCopyWith<$Res> {
  _$PersonCustomMethodCopyWithImpl(this._self, this._then);

  final PersonCustomMethod _self;
  final $Res Function(PersonCustomMethod) _then;

  /// Create a copy of CustomMethodImplements
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? age = null,
  }) {
    return _then(PersonCustomMethod(
      null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == age
          ? _self.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class StreetCustomMethod extends CustomMethodImplements
    with Shop, AdministrativeArea<House> {
  const StreetCustomMethod(this.name) : super._();

  @override
  final String name;

  /// Create a copy of CustomMethodImplements
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StreetCustomMethodCopyWith<StreetCustomMethod> get copyWith =>
      _$StreetCustomMethodCopyWithImpl<StreetCustomMethod>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StreetCustomMethod &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  @override
  String toString() {
    return 'CustomMethodImplements.street(name: $name)';
  }
}

/// @nodoc
abstract mixin class $StreetCustomMethodCopyWith<$Res>
    implements $CustomMethodImplementsCopyWith<$Res> {
  factory $StreetCustomMethodCopyWith(
          StreetCustomMethod value, $Res Function(StreetCustomMethod) _then) =
      _$StreetCustomMethodCopyWithImpl;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$StreetCustomMethodCopyWithImpl<$Res>
    implements $StreetCustomMethodCopyWith<$Res> {
  _$StreetCustomMethodCopyWithImpl(this._self, this._then);

  final StreetCustomMethod _self;
  final $Res Function(StreetCustomMethod) _then;

  /// Create a copy of CustomMethodImplements
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
  }) {
    return _then(StreetCustomMethod(
      null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class CityCustomMethod extends CustomMethodImplements
    with House
    implements Named, GeographicArea {
  const CityCustomMethod(this.name, this.population) : super._();

  @override
  final String name;
  final int population;

  /// Create a copy of CustomMethodImplements
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CityCustomMethodCopyWith<CityCustomMethod> get copyWith =>
      _$CityCustomMethodCopyWithImpl<CityCustomMethod>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CityCustomMethod &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.population, population) ||
                other.population == population));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, population);

  @override
  String toString() {
    return 'CustomMethodImplements.city(name: $name, population: $population)';
  }
}

/// @nodoc
abstract mixin class $CityCustomMethodCopyWith<$Res>
    implements $CustomMethodImplementsCopyWith<$Res> {
  factory $CityCustomMethodCopyWith(
          CityCustomMethod value, $Res Function(CityCustomMethod) _then) =
      _$CityCustomMethodCopyWithImpl;
  @override
  @useResult
  $Res call({String name, int population});
}

/// @nodoc
class _$CityCustomMethodCopyWithImpl<$Res>
    implements $CityCustomMethodCopyWith<$Res> {
  _$CityCustomMethodCopyWithImpl(this._self, this._then);

  final CityCustomMethod _self;
  final $Res Function(CityCustomMethod) _then;

  /// Create a copy of CustomMethodImplements
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? population = null,
  }) {
    return _then(CityCustomMethod(
      null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == population
          ? _self.population
          : population // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$GenericImplements<T> {
  String get name;

  /// Create a copy of GenericImplements
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GenericImplementsCopyWith<T, GenericImplements<T>> get copyWith =>
      _$GenericImplementsCopyWithImpl<T, GenericImplements<T>>(
          this as GenericImplements<T>, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GenericImplements<T> &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  @override
  String toString() {
    return 'GenericImplements<$T>(name: $name)';
  }
}

/// @nodoc
abstract mixin class $GenericImplementsCopyWith<T, $Res> {
  factory $GenericImplementsCopyWith(GenericImplements<T> value,
          $Res Function(GenericImplements<T>) _then) =
      _$GenericImplementsCopyWithImpl;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$GenericImplementsCopyWithImpl<T, $Res>
    implements $GenericImplementsCopyWith<T, $Res> {
  _$GenericImplementsCopyWithImpl(this._self, this._then);

  final GenericImplements<T> _self;
  final $Res Function(GenericImplements<T>) _then;

  /// Create a copy of GenericImplements
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [GenericImplements].
extension GenericImplementsPatterns<T> on GenericImplements<T> {
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
    TResult Function(GenericPerson<T> value)? person,
    TResult Function(GenericStreet<T> value)? street,
    TResult Function(GenericCity<T> value)? city,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case GenericPerson() when person != null:
        return person(_that);
      case GenericStreet() when street != null:
        return street(_that);
      case GenericCity() when city != null:
        return city(_that);
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
    required TResult Function(GenericPerson<T> value) person,
    required TResult Function(GenericStreet<T> value) street,
    required TResult Function(GenericCity<T> value) city,
  }) {
    final _that = this;
    switch (_that) {
      case GenericPerson():
        return person(_that);
      case GenericStreet():
        return street(_that);
      case GenericCity():
        return city(_that);
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
    TResult? Function(GenericPerson<T> value)? person,
    TResult? Function(GenericStreet<T> value)? street,
    TResult? Function(GenericCity<T> value)? city,
  }) {
    final _that = this;
    switch (_that) {
      case GenericPerson() when person != null:
        return person(_that);
      case GenericStreet() when street != null:
        return street(_that);
      case GenericCity() when city != null:
        return city(_that);
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
    TResult Function(String name, int age)? person,
    TResult Function(String name, T value)? street,
    TResult Function(String name, int population)? city,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case GenericPerson() when person != null:
        return person(_that.name, _that.age);
      case GenericStreet() when street != null:
        return street(_that.name, _that.value);
      case GenericCity() when city != null:
        return city(_that.name, _that.population);
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
    required TResult Function(String name, int age) person,
    required TResult Function(String name, T value) street,
    required TResult Function(String name, int population) city,
  }) {
    final _that = this;
    switch (_that) {
      case GenericPerson():
        return person(_that.name, _that.age);
      case GenericStreet():
        return street(_that.name, _that.value);
      case GenericCity():
        return city(_that.name, _that.population);
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
    TResult? Function(String name, int age)? person,
    TResult? Function(String name, T value)? street,
    TResult? Function(String name, int population)? city,
  }) {
    final _that = this;
    switch (_that) {
      case GenericPerson() when person != null:
        return person(_that.name, _that.age);
      case GenericStreet() when street != null:
        return street(_that.name, _that.value);
      case GenericCity() when city != null:
        return city(_that.name, _that.population);
      case _:
        return null;
    }
  }
}

/// @nodoc

class GenericPerson<T> implements GenericImplements<T> {
  const GenericPerson(this.name, this.age);

  @override
  final String name;
  final int age;

  /// Create a copy of GenericImplements
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GenericPersonCopyWith<T, GenericPerson<T>> get copyWith =>
      _$GenericPersonCopyWithImpl<T, GenericPerson<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GenericPerson<T> &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, age);

  @override
  String toString() {
    return 'GenericImplements<$T>.person(name: $name, age: $age)';
  }
}

/// @nodoc
abstract mixin class $GenericPersonCopyWith<T, $Res>
    implements $GenericImplementsCopyWith<T, $Res> {
  factory $GenericPersonCopyWith(
          GenericPerson<T> value, $Res Function(GenericPerson<T>) _then) =
      _$GenericPersonCopyWithImpl;
  @override
  @useResult
  $Res call({String name, int age});
}

/// @nodoc
class _$GenericPersonCopyWithImpl<T, $Res>
    implements $GenericPersonCopyWith<T, $Res> {
  _$GenericPersonCopyWithImpl(this._self, this._then);

  final GenericPerson<T> _self;
  final $Res Function(GenericPerson<T>) _then;

  /// Create a copy of GenericImplements
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? age = null,
  }) {
    return _then(GenericPerson<T>(
      null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == age
          ? _self.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class GenericStreet<T>
    with AdministrativeArea<T>
    implements GenericImplements<T>, Generic<T> {
  const GenericStreet(this.name, this.value);

  @override
  final String name;
  final T value;

  /// Create a copy of GenericImplements
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GenericStreetCopyWith<T, GenericStreet<T>> get copyWith =>
      _$GenericStreetCopyWithImpl<T, GenericStreet<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GenericStreet<T> &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'GenericImplements<$T>.street(name: $name, value: $value)';
  }
}

/// @nodoc
abstract mixin class $GenericStreetCopyWith<T, $Res>
    implements $GenericImplementsCopyWith<T, $Res> {
  factory $GenericStreetCopyWith(
          GenericStreet<T> value, $Res Function(GenericStreet<T>) _then) =
      _$GenericStreetCopyWithImpl;
  @override
  @useResult
  $Res call({String name, T value});
}

/// @nodoc
class _$GenericStreetCopyWithImpl<T, $Res>
    implements $GenericStreetCopyWith<T, $Res> {
  _$GenericStreetCopyWithImpl(this._self, this._then);

  final GenericStreet<T> _self;
  final $Res Function(GenericStreet<T>) _then;

  /// Create a copy of GenericImplements
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? value = freezed,
  }) {
    return _then(GenericStreet<T>(
      null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class GenericCity<T>
    with House
    implements GenericImplements<T>, GeographicArea {
  const GenericCity(this.name, this.population);

  @override
  final String name;
  final int population;

  /// Create a copy of GenericImplements
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GenericCityCopyWith<T, GenericCity<T>> get copyWith =>
      _$GenericCityCopyWithImpl<T, GenericCity<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GenericCity<T> &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.population, population) ||
                other.population == population));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, population);

  @override
  String toString() {
    return 'GenericImplements<$T>.city(name: $name, population: $population)';
  }
}

/// @nodoc
abstract mixin class $GenericCityCopyWith<T, $Res>
    implements $GenericImplementsCopyWith<T, $Res> {
  factory $GenericCityCopyWith(
          GenericCity<T> value, $Res Function(GenericCity<T>) _then) =
      _$GenericCityCopyWithImpl;
  @override
  @useResult
  $Res call({String name, int population});
}

/// @nodoc
class _$GenericCityCopyWithImpl<T, $Res>
    implements $GenericCityCopyWith<T, $Res> {
  _$GenericCityCopyWithImpl(this._self, this._then);

  final GenericCity<T> _self;
  final $Res Function(GenericCity<T>) _then;

  /// Create a copy of GenericImplements
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? population = null,
  }) {
    return _then(GenericCity<T>(
      null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == population
          ? _self.population
          : population // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}
