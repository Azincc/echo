// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slow_2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$A {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is A);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'A()';
  }
}

/// @nodoc
class $ACopyWith<$Res> {
  $ACopyWith(A _, $Res Function(A) __);
}

/// Adds pattern-matching-related methods to [A].
extension APatterns on A {
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
    TResult Function(_N value)? n,
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
      case _N() when n != null:
        return n(_that);
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
    required TResult Function(_N value) n,
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
      case _N():
        return n(_that);
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
    TResult? Function(_N value)? n,
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
      case _N() when n != null:
        return n(_that);
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
    TResult Function()? a,
    TResult Function()? b,
    TResult Function()? c,
    TResult Function()? d,
    TResult Function()? e,
    TResult Function()? f,
    TResult Function()? g,
    TResult Function()? h,
    TResult Function()? i,
    TResult Function()? j,
    TResult Function()? k,
    TResult Function()? l,
    TResult Function()? m,
    TResult Function()? n,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _A() when a != null:
        return a();
      case _B() when b != null:
        return b();
      case _C() when c != null:
        return c();
      case _D() when d != null:
        return d();
      case _E() when e != null:
        return e();
      case _F() when f != null:
        return f();
      case _G() when g != null:
        return g();
      case _H() when h != null:
        return h();
      case _I() when i != null:
        return i();
      case _J() when j != null:
        return j();
      case _K() when k != null:
        return k();
      case _L() when l != null:
        return l();
      case _M() when m != null:
        return m();
      case _N() when n != null:
        return n();
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
    required TResult Function() a,
    required TResult Function() b,
    required TResult Function() c,
    required TResult Function() d,
    required TResult Function() e,
    required TResult Function() f,
    required TResult Function() g,
    required TResult Function() h,
    required TResult Function() i,
    required TResult Function() j,
    required TResult Function() k,
    required TResult Function() l,
    required TResult Function() m,
    required TResult Function() n,
  }) {
    final _that = this;
    switch (_that) {
      case _A():
        return a();
      case _B():
        return b();
      case _C():
        return c();
      case _D():
        return d();
      case _E():
        return e();
      case _F():
        return f();
      case _G():
        return g();
      case _H():
        return h();
      case _I():
        return i();
      case _J():
        return j();
      case _K():
        return k();
      case _L():
        return l();
      case _M():
        return m();
      case _N():
        return n();
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
    TResult? Function()? a,
    TResult? Function()? b,
    TResult? Function()? c,
    TResult? Function()? d,
    TResult? Function()? e,
    TResult? Function()? f,
    TResult? Function()? g,
    TResult? Function()? h,
    TResult? Function()? i,
    TResult? Function()? j,
    TResult? Function()? k,
    TResult? Function()? l,
    TResult? Function()? m,
    TResult? Function()? n,
  }) {
    final _that = this;
    switch (_that) {
      case _A() when a != null:
        return a();
      case _B() when b != null:
        return b();
      case _C() when c != null:
        return c();
      case _D() when d != null:
        return d();
      case _E() when e != null:
        return e();
      case _F() when f != null:
        return f();
      case _G() when g != null:
        return g();
      case _H() when h != null:
        return h();
      case _I() when i != null:
        return i();
      case _J() when j != null:
        return j();
      case _K() when k != null:
        return k();
      case _L() when l != null:
        return l();
      case _M() when m != null:
        return m();
      case _N() when n != null:
        return n();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _A implements A {
  const _A();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _A);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'A.a()';
  }
}

/// @nodoc

class _B implements A {
  const _B();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _B);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'A.b()';
  }
}

/// @nodoc

class _C implements A {
  const _C();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _C);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'A.c()';
  }
}

/// @nodoc

class _D implements A {
  const _D();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _D);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'A.d()';
  }
}

/// @nodoc

class _E implements A {
  const _E();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _E);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'A.e()';
  }
}

/// @nodoc

class _F implements A {
  const _F();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _F);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'A.f()';
  }
}

/// @nodoc

class _G implements A {
  const _G();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _G);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'A.g()';
  }
}

/// @nodoc

class _H implements A {
  const _H();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _H);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'A.h()';
  }
}

/// @nodoc

class _I implements A {
  const _I();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _I);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'A.i()';
  }
}

/// @nodoc

class _J implements A {
  const _J();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _J);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'A.j()';
  }
}

/// @nodoc

class _K implements A {
  const _K();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _K);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'A.k()';
  }
}

/// @nodoc

class _L implements A {
  const _L();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _L);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'A.l()';
  }
}

/// @nodoc

class _M implements A {
  const _M();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _M);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'A.m()';
  }
}

/// @nodoc

class _N implements A {
  const _N();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _N);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'A.n()';
  }
}
