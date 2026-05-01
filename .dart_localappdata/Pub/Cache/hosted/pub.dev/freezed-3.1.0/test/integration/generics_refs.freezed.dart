// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generics_refs.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PageList {
  List<Page> get pages;

  /// Create a copy of PageList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PageListCopyWith<PageList> get copyWith =>
      _$PageListCopyWithImpl<PageList>(this as PageList, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PageList &&
            const DeepCollectionEquality().equals(other.pages, pages));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(pages));

  @override
  String toString() {
    return 'PageList(pages: $pages)';
  }
}

/// @nodoc
abstract mixin class $PageListCopyWith<$Res> {
  factory $PageListCopyWith(PageList value, $Res Function(PageList) _then) =
      _$PageListCopyWithImpl;
  @useResult
  $Res call({List<Page> pages});
}

/// @nodoc
class _$PageListCopyWithImpl<$Res> implements $PageListCopyWith<$Res> {
  _$PageListCopyWithImpl(this._self, this._then);

  final PageList _self;
  final $Res Function(PageList) _then;

  /// Create a copy of PageList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pages = null,
  }) {
    return _then(_self.copyWith(
      pages: null == pages
          ? _self.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<Page>,
    ));
  }
}

/// Adds pattern-matching-related methods to [PageList].
extension PageListPatterns on PageList {
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
    TResult Function(_PageList value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PageList() when $default != null:
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
    TResult Function(_PageList value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PageList():
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
    TResult? Function(_PageList value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PageList() when $default != null:
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
    TResult Function(List<Page> pages)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PageList() when $default != null:
        return $default(_that.pages);
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
    TResult Function(List<Page> pages) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PageList():
        return $default(_that.pages);
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
    TResult? Function(List<Page> pages)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PageList() when $default != null:
        return $default(_that.pages);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PageList implements PageList {
  _PageList(final List<Page> pages) : _pages = pages;

  final List<Page> _pages;
  @override
  List<Page> get pages {
    if (_pages is EqualUnmodifiableListView) return _pages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pages);
  }

  /// Create a copy of PageList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PageListCopyWith<_PageList> get copyWith =>
      __$PageListCopyWithImpl<_PageList>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PageList &&
            const DeepCollectionEquality().equals(other._pages, _pages));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_pages));

  @override
  String toString() {
    return 'PageList(pages: $pages)';
  }
}

/// @nodoc
abstract mixin class _$PageListCopyWith<$Res>
    implements $PageListCopyWith<$Res> {
  factory _$PageListCopyWith(_PageList value, $Res Function(_PageList) _then) =
      __$PageListCopyWithImpl;
  @override
  @useResult
  $Res call({List<Page> pages});
}

/// @nodoc
class __$PageListCopyWithImpl<$Res> implements _$PageListCopyWith<$Res> {
  __$PageListCopyWithImpl(this._self, this._then);

  final _PageList _self;
  final $Res Function(_PageList) _then;

  /// Create a copy of PageList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? pages = null,
  }) {
    return _then(_PageList(
      null == pages
          ? _self._pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<Page>,
    ));
  }
}

/// @nodoc
mixin _$PageMap {
  Map<String, Page> get pages;

  /// Create a copy of PageMap
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PageMapCopyWith<PageMap> get copyWith =>
      _$PageMapCopyWithImpl<PageMap>(this as PageMap, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PageMap &&
            const DeepCollectionEquality().equals(other.pages, pages));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(pages));

  @override
  String toString() {
    return 'PageMap(pages: $pages)';
  }
}

/// @nodoc
abstract mixin class $PageMapCopyWith<$Res> {
  factory $PageMapCopyWith(PageMap value, $Res Function(PageMap) _then) =
      _$PageMapCopyWithImpl;
  @useResult
  $Res call({Map<String, Page> pages});
}

/// @nodoc
class _$PageMapCopyWithImpl<$Res> implements $PageMapCopyWith<$Res> {
  _$PageMapCopyWithImpl(this._self, this._then);

  final PageMap _self;
  final $Res Function(PageMap) _then;

  /// Create a copy of PageMap
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pages = null,
  }) {
    return _then(_self.copyWith(
      pages: null == pages
          ? _self.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as Map<String, Page>,
    ));
  }
}

/// Adds pattern-matching-related methods to [PageMap].
extension PageMapPatterns on PageMap {
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
    TResult Function(_PageMap value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PageMap() when $default != null:
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
    TResult Function(_PageMap value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PageMap():
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
    TResult? Function(_PageMap value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PageMap() when $default != null:
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
    TResult Function(Map<String, Page> pages)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PageMap() when $default != null:
        return $default(_that.pages);
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
    TResult Function(Map<String, Page> pages) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PageMap():
        return $default(_that.pages);
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
    TResult? Function(Map<String, Page> pages)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PageMap() when $default != null:
        return $default(_that.pages);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PageMap implements PageMap {
  _PageMap(final Map<String, Page> pages) : _pages = pages;

  final Map<String, Page> _pages;
  @override
  Map<String, Page> get pages {
    if (_pages is EqualUnmodifiableMapView) return _pages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_pages);
  }

  /// Create a copy of PageMap
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PageMapCopyWith<_PageMap> get copyWith =>
      __$PageMapCopyWithImpl<_PageMap>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PageMap &&
            const DeepCollectionEquality().equals(other._pages, _pages));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_pages));

  @override
  String toString() {
    return 'PageMap(pages: $pages)';
  }
}

/// @nodoc
abstract mixin class _$PageMapCopyWith<$Res> implements $PageMapCopyWith<$Res> {
  factory _$PageMapCopyWith(_PageMap value, $Res Function(_PageMap) _then) =
      __$PageMapCopyWithImpl;
  @override
  @useResult
  $Res call({Map<String, Page> pages});
}

/// @nodoc
class __$PageMapCopyWithImpl<$Res> implements _$PageMapCopyWith<$Res> {
  __$PageMapCopyWithImpl(this._self, this._then);

  final _PageMap _self;
  final $Res Function(_PageMap) _then;

  /// Create a copy of PageMap
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? pages = null,
  }) {
    return _then(_PageMap(
      null == pages
          ? _self._pages
          : pages // ignore: cast_nullable_to_non_nullable
              as Map<String, Page>,
    ));
  }
}

/// @nodoc
mixin _$WidgetType {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is WidgetType);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'WidgetType()';
  }
}

/// @nodoc
class $WidgetTypeCopyWith<$Res> {
  $WidgetTypeCopyWith(WidgetType _, $Res Function(WidgetType) __);
}

/// Adds pattern-matching-related methods to [WidgetType].
extension WidgetTypePatterns on WidgetType {
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
    TResult Function(Page value)? page,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Page() when page != null:
        return page(_that);
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
    required TResult Function(Page value) page,
  }) {
    final _that = this;
    switch (_that) {
      case Page():
        return page(_that);
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
    TResult? Function(Page value)? page,
  }) {
    final _that = this;
    switch (_that) {
      case Page() when page != null:
        return page(_that);
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
    TResult Function()? page,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Page() when page != null:
        return page();
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
    required TResult Function() page,
  }) {
    final _that = this;
    switch (_that) {
      case Page():
        return page();
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
    TResult? Function()? page,
  }) {
    final _that = this;
    switch (_that) {
      case Page() when page != null:
        return page();
      case _:
        return null;
    }
  }
}

/// @nodoc

class Page implements WidgetType {
  const Page();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Page);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'WidgetType.page()';
  }
}
