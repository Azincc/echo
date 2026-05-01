// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slow_1.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Root {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Root);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Root()';
  }
}

/// @nodoc
class $RootCopyWith<$Res> {
  $RootCopyWith(Root _, $Res Function(Root) __);
}

/// Adds pattern-matching-related methods to [Root].
extension RootPatterns on Root {
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
    TResult Function(_A value)? a,
    TResult Function(_B value)? b,
    TResult Function(_C value)? c,
    TResult Function(_D value)? d,
    TResult Function(_E value)? e,
    TResult Function(_F value)? f,
    TResult Function(_G value)? g,
    TResult Function(_H value)? h,
    TResult Function(_I value)? i,
    TResult Function(_J value)? j,
    TResult Function(_K value)? k,
    TResult Function(_L value)? l,
    TResult Function(_M value)? m,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _A() when a != null:
        return a(_that);
      case _B() when b != null:
        return b(_that);
      case _C() when c != null:
        return c(_that);
      case _D() when d != null:
        return d(_that);
      case _E() when e != null:
        return e(_that);
      case _F() when f != null:
        return f(_that);
      case _G() when g != null:
        return g(_that);
      case _H() when h != null:
        return h(_that);
      case _I() when i != null:
        return i(_that);
      case _J() when j != null:
        return j(_that);
      case _K() when k != null:
        return k(_that);
      case _L() when l != null:
        return l(_that);
      case _M() when m != null:
        return m(_that);
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
    required TResult Function(_A value) a,
    required TResult Function(_B value) b,
    required TResult Function(_C value) c,
    required TResult Function(_D value) d,
    required TResult Function(_E value) e,
    required TResult Function(_F value) f,
    required TResult Function(_G value) g,
    required TResult Function(_H value) h,
    required TResult Function(_I value) i,
    required TResult Function(_J value) j,
    required TResult Function(_K value) k,
    required TResult Function(_L value) l,
    required TResult Function(_M value) m,
  }) {
    final _that = this;
    switch (_that) {
      case _A():
        return a(_that);
      case _B():
        return b(_that);
      case _C():
        return c(_that);
      case _D():
        return d(_that);
      case _E():
        return e(_that);
      case _F():
        return f(_that);
      case _G():
        return g(_that);
      case _H():
        return h(_that);
      case _I():
        return i(_that);
      case _J():
        return j(_that);
      case _K():
        return k(_that);
      case _L():
        return l(_that);
      case _M():
        return m(_that);
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
    TResult? Function(_A value)? a,
    TResult? Function(_B value)? b,
    TResult? Function(_C value)? c,
    TResult? Function(_D value)? d,
    TResult? Function(_E value)? e,
    TResult? Function(_F value)? f,
    TResult? Function(_G value)? g,
    TResult? Function(_H value)? h,
    TResult? Function(_I value)? i,
    TResult? Function(_J value)? j,
    TResult? Function(_K value)? k,
    TResult? Function(_L value)? l,
    TResult? Function(_M value)? m,
  }) {
    final _that = this;
    switch (_that) {
      case _A() when a != null:
        return a(_that);
      case _B() when b != null:
        return b(_that);
      case _C() when c != null:
        return c(_that);
      case _D() when d != null:
        return d(_that);
      case _E() when e != null:
        return e(_that);
      case _F() when f != null:
        return f(_that);
      case _G() when g != null:
        return g(_that);
      case _H() when h != null:
        return h(_that);
      case _I() when i != null:
        return i(_that);
      case _J() when j != null:
        return j(_that);
      case _K() when k != null:
        return k(_that);
      case _L() when l != null:
        return l(_that);
      case _M() when m != null:
        return m(_that);
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
    TResult Function(A a)? a,
    TResult Function(B b)? b,
    TResult Function(A a)? c,
    TResult Function(B b)? d,
    TResult Function(A a)? e,
    TResult Function(A a)? f,
    TResult Function(B b)? g,
    TResult Function(A a)? h,
    TResult Function(B b)? i,
    TResult Function(A a)? j,
    TResult Function(B b)? k,
    TResult Function(A a)? l,
    TResult Function(B b)? m,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _A() when a != null:
        return a(_that.a);
      case _B() when b != null:
        return b(_that.b);
      case _C() when c != null:
        return c(_that.a);
      case _D() when d != null:
        return d(_that.b);
      case _E() when e != null:
        return e(_that.a);
      case _F() when f != null:
        return f(_that.a);
      case _G() when g != null:
        return g(_that.b);
      case _H() when h != null:
        return h(_that.a);
      case _I() when i != null:
        return i(_that.b);
      case _J() when j != null:
        return j(_that.a);
      case _K() when k != null:
        return k(_that.b);
      case _L() when l != null:
        return l(_that.a);
      case _M() when m != null:
        return m(_that.b);
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
    required TResult Function(A a) a,
    required TResult Function(B b) b,
    required TResult Function(A a) c,
    required TResult Function(B b) d,
    required TResult Function(A a) e,
    required TResult Function(A a) f,
    required TResult Function(B b) g,
    required TResult Function(A a) h,
    required TResult Function(B b) i,
    required TResult Function(A a) j,
    required TResult Function(B b) k,
    required TResult Function(A a) l,
    required TResult Function(B b) m,
  }) {
    final _that = this;
    switch (_that) {
      case _A():
        return a(_that.a);
      case _B():
        return b(_that.b);
      case _C():
        return c(_that.a);
      case _D():
        return d(_that.b);
      case _E():
        return e(_that.a);
      case _F():
        return f(_that.a);
      case _G():
        return g(_that.b);
      case _H():
        return h(_that.a);
      case _I():
        return i(_that.b);
      case _J():
        return j(_that.a);
      case _K():
        return k(_that.b);
      case _L():
        return l(_that.a);
      case _M():
        return m(_that.b);
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
    TResult? Function(A a)? a,
    TResult? Function(B b)? b,
    TResult? Function(A a)? c,
    TResult? Function(B b)? d,
    TResult? Function(A a)? e,
    TResult? Function(A a)? f,
    TResult? Function(B b)? g,
    TResult? Function(A a)? h,
    TResult? Function(B b)? i,
    TResult? Function(A a)? j,
    TResult? Function(B b)? k,
    TResult? Function(A a)? l,
    TResult? Function(B b)? m,
  }) {
    final _that = this;
    switch (_that) {
      case _A() when a != null:
        return a(_that.a);
      case _B() when b != null:
        return b(_that.b);
      case _C() when c != null:
        return c(_that.a);
      case _D() when d != null:
        return d(_that.b);
      case _E() when e != null:
        return e(_that.a);
      case _F() when f != null:
        return f(_that.a);
      case _G() when g != null:
        return g(_that.b);
      case _H() when h != null:
        return h(_that.a);
      case _I() when i != null:
        return i(_that.b);
      case _J() when j != null:
        return j(_that.a);
      case _K() when k != null:
        return k(_that.b);
      case _L() when l != null:
        return l(_that.a);
      case _M() when m != null:
        return m(_that.b);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _A implements Root {
  const _A(this.a);

  final A a;

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ACopyWith<_A> get copyWith => __$ACopyWithImpl<_A>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _A &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'Root.a(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$ACopyWith<$Res> implements $RootCopyWith<$Res> {
  factory _$ACopyWith(_A value, $Res Function(_A) _then) = __$ACopyWithImpl;
  @useResult
  $Res call({A a});

  $ACopyWith<$Res> get a;
}

/// @nodoc
class __$ACopyWithImpl<$Res> implements _$ACopyWith<$Res> {
  __$ACopyWithImpl(this._self, this._then);

  final _A _self;
  final $Res Function(_A) _then;

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_A(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as A,
    ));
  }

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ACopyWith<$Res> get a {
    return $ACopyWith<$Res>(_self.a, (value) {
      return _then(_self.copyWith(a: value));
    });
  }
}

/// @nodoc

class _B implements Root {
  const _B(this.b);

  final B b;

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BCopyWith<_B> get copyWith => __$BCopyWithImpl<_B>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _B &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, b);

  @override
  String toString() {
    return 'Root.b(b: $b)';
  }
}

/// @nodoc
abstract mixin class _$BCopyWith<$Res> implements $RootCopyWith<$Res> {
  factory _$BCopyWith(_B value, $Res Function(_B) _then) = __$BCopyWithImpl;
  @useResult
  $Res call({B b});

  $BCopyWith<$Res> get b;
}

/// @nodoc
class __$BCopyWithImpl<$Res> implements _$BCopyWith<$Res> {
  __$BCopyWithImpl(this._self, this._then);

  final _B _self;
  final $Res Function(_B) _then;

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? b = null,
  }) {
    return _then(_B(
      null == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as B,
    ));
  }

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BCopyWith<$Res> get b {
    return $BCopyWith<$Res>(_self.b, (value) {
      return _then(_self.copyWith(b: value));
    });
  }
}

/// @nodoc

class _C implements Root {
  const _C(this.a);

  final A a;

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CCopyWith<_C> get copyWith => __$CCopyWithImpl<_C>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _C &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'Root.c(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$CCopyWith<$Res> implements $RootCopyWith<$Res> {
  factory _$CCopyWith(_C value, $Res Function(_C) _then) = __$CCopyWithImpl;
  @useResult
  $Res call({A a});

  $ACopyWith<$Res> get a;
}

/// @nodoc
class __$CCopyWithImpl<$Res> implements _$CCopyWith<$Res> {
  __$CCopyWithImpl(this._self, this._then);

  final _C _self;
  final $Res Function(_C) _then;

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_C(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as A,
    ));
  }

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ACopyWith<$Res> get a {
    return $ACopyWith<$Res>(_self.a, (value) {
      return _then(_self.copyWith(a: value));
    });
  }
}

/// @nodoc

class _D implements Root {
  const _D(this.b);

  final B b;

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DCopyWith<_D> get copyWith => __$DCopyWithImpl<_D>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _D &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, b);

  @override
  String toString() {
    return 'Root.d(b: $b)';
  }
}

/// @nodoc
abstract mixin class _$DCopyWith<$Res> implements $RootCopyWith<$Res> {
  factory _$DCopyWith(_D value, $Res Function(_D) _then) = __$DCopyWithImpl;
  @useResult
  $Res call({B b});

  $BCopyWith<$Res> get b;
}

/// @nodoc
class __$DCopyWithImpl<$Res> implements _$DCopyWith<$Res> {
  __$DCopyWithImpl(this._self, this._then);

  final _D _self;
  final $Res Function(_D) _then;

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? b = null,
  }) {
    return _then(_D(
      null == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as B,
    ));
  }

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BCopyWith<$Res> get b {
    return $BCopyWith<$Res>(_self.b, (value) {
      return _then(_self.copyWith(b: value));
    });
  }
}

/// @nodoc

class _E implements Root {
  const _E(this.a);

  final A a;

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ECopyWith<_E> get copyWith => __$ECopyWithImpl<_E>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _E &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'Root.e(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$ECopyWith<$Res> implements $RootCopyWith<$Res> {
  factory _$ECopyWith(_E value, $Res Function(_E) _then) = __$ECopyWithImpl;
  @useResult
  $Res call({A a});

  $ACopyWith<$Res> get a;
}

/// @nodoc
class __$ECopyWithImpl<$Res> implements _$ECopyWith<$Res> {
  __$ECopyWithImpl(this._self, this._then);

  final _E _self;
  final $Res Function(_E) _then;

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_E(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as A,
    ));
  }

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ACopyWith<$Res> get a {
    return $ACopyWith<$Res>(_self.a, (value) {
      return _then(_self.copyWith(a: value));
    });
  }
}

/// @nodoc

class _F implements Root {
  const _F(this.a);

  final A a;

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FCopyWith<_F> get copyWith => __$FCopyWithImpl<_F>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _F &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'Root.f(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$FCopyWith<$Res> implements $RootCopyWith<$Res> {
  factory _$FCopyWith(_F value, $Res Function(_F) _then) = __$FCopyWithImpl;
  @useResult
  $Res call({A a});

  $ACopyWith<$Res> get a;
}

/// @nodoc
class __$FCopyWithImpl<$Res> implements _$FCopyWith<$Res> {
  __$FCopyWithImpl(this._self, this._then);

  final _F _self;
  final $Res Function(_F) _then;

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_F(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as A,
    ));
  }

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ACopyWith<$Res> get a {
    return $ACopyWith<$Res>(_self.a, (value) {
      return _then(_self.copyWith(a: value));
    });
  }
}

/// @nodoc

class _G implements Root {
  const _G(this.b);

  final B b;

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GCopyWith<_G> get copyWith => __$GCopyWithImpl<_G>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _G &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, b);

  @override
  String toString() {
    return 'Root.g(b: $b)';
  }
}

/// @nodoc
abstract mixin class _$GCopyWith<$Res> implements $RootCopyWith<$Res> {
  factory _$GCopyWith(_G value, $Res Function(_G) _then) = __$GCopyWithImpl;
  @useResult
  $Res call({B b});

  $BCopyWith<$Res> get b;
}

/// @nodoc
class __$GCopyWithImpl<$Res> implements _$GCopyWith<$Res> {
  __$GCopyWithImpl(this._self, this._then);

  final _G _self;
  final $Res Function(_G) _then;

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? b = null,
  }) {
    return _then(_G(
      null == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as B,
    ));
  }

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BCopyWith<$Res> get b {
    return $BCopyWith<$Res>(_self.b, (value) {
      return _then(_self.copyWith(b: value));
    });
  }
}

/// @nodoc

class _H implements Root {
  const _H(this.a);

  final A a;

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HCopyWith<_H> get copyWith => __$HCopyWithImpl<_H>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _H &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'Root.h(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$HCopyWith<$Res> implements $RootCopyWith<$Res> {
  factory _$HCopyWith(_H value, $Res Function(_H) _then) = __$HCopyWithImpl;
  @useResult
  $Res call({A a});

  $ACopyWith<$Res> get a;
}

/// @nodoc
class __$HCopyWithImpl<$Res> implements _$HCopyWith<$Res> {
  __$HCopyWithImpl(this._self, this._then);

  final _H _self;
  final $Res Function(_H) _then;

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_H(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as A,
    ));
  }

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ACopyWith<$Res> get a {
    return $ACopyWith<$Res>(_self.a, (value) {
      return _then(_self.copyWith(a: value));
    });
  }
}

/// @nodoc

class _I implements Root {
  const _I(this.b);

  final B b;

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ICopyWith<_I> get copyWith => __$ICopyWithImpl<_I>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _I &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, b);

  @override
  String toString() {
    return 'Root.i(b: $b)';
  }
}

/// @nodoc
abstract mixin class _$ICopyWith<$Res> implements $RootCopyWith<$Res> {
  factory _$ICopyWith(_I value, $Res Function(_I) _then) = __$ICopyWithImpl;
  @useResult
  $Res call({B b});

  $BCopyWith<$Res> get b;
}

/// @nodoc
class __$ICopyWithImpl<$Res> implements _$ICopyWith<$Res> {
  __$ICopyWithImpl(this._self, this._then);

  final _I _self;
  final $Res Function(_I) _then;

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? b = null,
  }) {
    return _then(_I(
      null == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as B,
    ));
  }

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BCopyWith<$Res> get b {
    return $BCopyWith<$Res>(_self.b, (value) {
      return _then(_self.copyWith(b: value));
    });
  }
}

/// @nodoc

class _J implements Root {
  const _J(this.a);

  final A a;

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$JCopyWith<_J> get copyWith => __$JCopyWithImpl<_J>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _J &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'Root.j(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$JCopyWith<$Res> implements $RootCopyWith<$Res> {
  factory _$JCopyWith(_J value, $Res Function(_J) _then) = __$JCopyWithImpl;
  @useResult
  $Res call({A a});

  $ACopyWith<$Res> get a;
}

/// @nodoc
class __$JCopyWithImpl<$Res> implements _$JCopyWith<$Res> {
  __$JCopyWithImpl(this._self, this._then);

  final _J _self;
  final $Res Function(_J) _then;

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_J(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as A,
    ));
  }

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ACopyWith<$Res> get a {
    return $ACopyWith<$Res>(_self.a, (value) {
      return _then(_self.copyWith(a: value));
    });
  }
}

/// @nodoc

class _K implements Root {
  const _K(this.b);

  final B b;

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$KCopyWith<_K> get copyWith => __$KCopyWithImpl<_K>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _K &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, b);

  @override
  String toString() {
    return 'Root.k(b: $b)';
  }
}

/// @nodoc
abstract mixin class _$KCopyWith<$Res> implements $RootCopyWith<$Res> {
  factory _$KCopyWith(_K value, $Res Function(_K) _then) = __$KCopyWithImpl;
  @useResult
  $Res call({B b});

  $BCopyWith<$Res> get b;
}

/// @nodoc
class __$KCopyWithImpl<$Res> implements _$KCopyWith<$Res> {
  __$KCopyWithImpl(this._self, this._then);

  final _K _self;
  final $Res Function(_K) _then;

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? b = null,
  }) {
    return _then(_K(
      null == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as B,
    ));
  }

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BCopyWith<$Res> get b {
    return $BCopyWith<$Res>(_self.b, (value) {
      return _then(_self.copyWith(b: value));
    });
  }
}

/// @nodoc

class _L implements Root {
  const _L(this.a);

  final A a;

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LCopyWith<_L> get copyWith => __$LCopyWithImpl<_L>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _L &&
            (identical(other.a, a) || other.a == a));
  }

  @override
  int get hashCode => Object.hash(runtimeType, a);

  @override
  String toString() {
    return 'Root.l(a: $a)';
  }
}

/// @nodoc
abstract mixin class _$LCopyWith<$Res> implements $RootCopyWith<$Res> {
  factory _$LCopyWith(_L value, $Res Function(_L) _then) = __$LCopyWithImpl;
  @useResult
  $Res call({A a});

  $ACopyWith<$Res> get a;
}

/// @nodoc
class __$LCopyWithImpl<$Res> implements _$LCopyWith<$Res> {
  __$LCopyWithImpl(this._self, this._then);

  final _L _self;
  final $Res Function(_L) _then;

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? a = null,
  }) {
    return _then(_L(
      null == a
          ? _self.a
          : a // ignore: cast_nullable_to_non_nullable
              as A,
    ));
  }

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ACopyWith<$Res> get a {
    return $ACopyWith<$Res>(_self.a, (value) {
      return _then(_self.copyWith(a: value));
    });
  }
}

/// @nodoc

class _M implements Root {
  const _M(this.b);

  final B b;

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MCopyWith<_M> get copyWith => __$MCopyWithImpl<_M>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _M &&
            (identical(other.b, b) || other.b == b));
  }

  @override
  int get hashCode => Object.hash(runtimeType, b);

  @override
  String toString() {
    return 'Root.m(b: $b)';
  }
}

/// @nodoc
abstract mixin class _$MCopyWith<$Res> implements $RootCopyWith<$Res> {
  factory _$MCopyWith(_M value, $Res Function(_M) _then) = __$MCopyWithImpl;
  @useResult
  $Res call({B b});

  $BCopyWith<$Res> get b;
}

/// @nodoc
class __$MCopyWithImpl<$Res> implements _$MCopyWith<$Res> {
  __$MCopyWithImpl(this._self, this._then);

  final _M _self;
  final $Res Function(_M) _then;

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? b = null,
  }) {
    return _then(_M(
      null == b
          ? _self.b
          : b // ignore: cast_nullable_to_non_nullable
              as B,
    ));
  }

  /// Create a copy of Root
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BCopyWith<$Res> get b {
    return $BCopyWith<$Res>(_self.b, (value) {
      return _then(_self.copyWith(b: value));
    });
  }
}
