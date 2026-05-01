// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deep_copy2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Country {
  String? get name;
  Company? get company;
  Director? get president;

  /// Create a copy of Country
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CountryCopyWith<Country> get copyWith =>
      _$CountryCopyWithImpl<Country>(this as Country, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Country &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.president, president) ||
                other.president == president));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, company, president);

  @override
  String toString() {
    return 'Country(name: $name, company: $company, president: $president)';
  }
}

/// @nodoc
abstract mixin class $CountryCopyWith<$Res> {
  factory $CountryCopyWith(Country value, $Res Function(Country) _then) =
      _$CountryCopyWithImpl;
  @useResult
  $Res call({String? name, Company? company, Director? president});

  $CompanyCopyWith<$Res>? get company;
  $DirectorCopyWith<$Res>? get president;
}

/// @nodoc
class _$CountryCopyWithImpl<$Res> implements $CountryCopyWith<$Res> {
  _$CountryCopyWithImpl(this._self, this._then);

  final Country _self;
  final $Res Function(Country) _then;

  /// Create a copy of Country
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? company = freezed,
    Object? president = freezed,
  }) {
    return _then(_self.copyWith(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      company: freezed == company
          ? _self.company
          : company // ignore: cast_nullable_to_non_nullable
              as Company?,
      president: freezed == president
          ? _self.president
          : president // ignore: cast_nullable_to_non_nullable
              as Director?,
    ));
  }

  /// Create a copy of Country
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CompanyCopyWith<$Res>? get company {
    if (_self.company == null) {
      return null;
    }

    return $CompanyCopyWith<$Res>(_self.company!, (value) {
      return _then(_self.copyWith(company: value));
    });
  }

  /// Create a copy of Country
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DirectorCopyWith<$Res>? get president {
    if (_self.president == null) {
      return null;
    }

    return $DirectorCopyWith<$Res>(_self.president!, (value) {
      return _then(_self.copyWith(president: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Country].
extension CountryPatterns on Country {
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
    TResult Function(_Country value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Country() when $default != null:
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
    TResult Function(_Country value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Country():
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
    TResult? Function(_Country value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Country() when $default != null:
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
    TResult Function(String? name, Company? company, Director? president)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Country() when $default != null:
        return $default(_that.name, _that.company, _that.president);
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
    TResult Function(String? name, Company? company, Director? president)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Country():
        return $default(_that.name, _that.company, _that.president);
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
    TResult? Function(String? name, Company? company, Director? president)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Country() when $default != null:
        return $default(_that.name, _that.company, _that.president);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Country implements Country {
  _Country({this.name, this.company, this.president});

  @override
  final String? name;
  @override
  final Company? company;
  @override
  final Director? president;

  /// Create a copy of Country
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CountryCopyWith<_Country> get copyWith =>
      __$CountryCopyWithImpl<_Country>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Country &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.president, president) ||
                other.president == president));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, company, president);

  @override
  String toString() {
    return 'Country(name: $name, company: $company, president: $president)';
  }
}

/// @nodoc
abstract mixin class _$CountryCopyWith<$Res> implements $CountryCopyWith<$Res> {
  factory _$CountryCopyWith(_Country value, $Res Function(_Country) _then) =
      __$CountryCopyWithImpl;
  @override
  @useResult
  $Res call({String? name, Company? company, Director? president});

  @override
  $CompanyCopyWith<$Res>? get company;
  @override
  $DirectorCopyWith<$Res>? get president;
}

/// @nodoc
class __$CountryCopyWithImpl<$Res> implements _$CountryCopyWith<$Res> {
  __$CountryCopyWithImpl(this._self, this._then);

  final _Country _self;
  final $Res Function(_Country) _then;

  /// Create a copy of Country
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = freezed,
    Object? company = freezed,
    Object? president = freezed,
  }) {
    return _then(_Country(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      company: freezed == company
          ? _self.company
          : company // ignore: cast_nullable_to_non_nullable
              as Company?,
      president: freezed == president
          ? _self.president
          : president // ignore: cast_nullable_to_non_nullable
              as Director?,
    ));
  }

  /// Create a copy of Country
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CompanyCopyWith<$Res>? get company {
    if (_self.company == null) {
      return null;
    }

    return $CompanyCopyWith<$Res>(_self.company!, (value) {
      return _then(_self.copyWith(company: value));
    });
  }

  /// Create a copy of Country
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DirectorCopyWith<$Res>? get president {
    if (_self.president == null) {
      return null;
    }

    return $DirectorCopyWith<$Res>(_self.president!, (value) {
      return _then(_self.copyWith(president: value));
    });
  }
}
