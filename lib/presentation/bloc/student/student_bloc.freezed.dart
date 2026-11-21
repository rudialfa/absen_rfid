// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StudentEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is StudentEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'StudentEvent()';
  }
}

/// @nodoc
class $StudentEventCopyWith<$Res> {
  $StudentEventCopyWith(StudentEvent _, $Res Function(StudentEvent) __);
}

/// Adds pattern-matching-related methods to [StudentEvent].
extension StudentEventPatterns on StudentEvent {
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
    TResult Function(_GetList value)? getList,
    TResult Function(_Create value)? create,
    TResult Function(_Update value)? update,
    TResult Function(_ReplaceCard value)? replaceCard,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GetList() when getList != null:
        return getList(_that);
      case _Create() when create != null:
        return create(_that);
      case _Update() when update != null:
        return update(_that);
      case _ReplaceCard() when replaceCard != null:
        return replaceCard(_that);
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
    required TResult Function(_GetList value) getList,
    required TResult Function(_Create value) create,
    required TResult Function(_Update value) update,
    required TResult Function(_ReplaceCard value) replaceCard,
  }) {
    final _that = this;
    switch (_that) {
      case _GetList():
        return getList(_that);
      case _Create():
        return create(_that);
      case _Update():
        return update(_that);
      case _ReplaceCard():
        return replaceCard(_that);
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
    TResult? Function(_GetList value)? getList,
    TResult? Function(_Create value)? create,
    TResult? Function(_Update value)? update,
    TResult? Function(_ReplaceCard value)? replaceCard,
  }) {
    final _that = this;
    switch (_that) {
      case _GetList() when getList != null:
        return getList(_that);
      case _Create() when create != null:
        return create(_that);
      case _Update() when update != null:
        return update(_that);
      case _ReplaceCard() when replaceCard != null:
        return replaceCard(_that);
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
    TResult Function(String? q, bool? active)? getList,
    TResult Function(StudentCreateRequestModel request)? create,
    TResult Function(int id, StudentUpdateRequestModel request)? update,
    TResult Function(int id)? replaceCard,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GetList() when getList != null:
        return getList(_that.q, _that.active);
      case _Create() when create != null:
        return create(_that.request);
      case _Update() when update != null:
        return update(_that.id, _that.request);
      case _ReplaceCard() when replaceCard != null:
        return replaceCard(_that.id);
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
    required TResult Function(String? q, bool? active) getList,
    required TResult Function(StudentCreateRequestModel request) create,
    required TResult Function(int id, StudentUpdateRequestModel request) update,
    required TResult Function(int id) replaceCard,
  }) {
    final _that = this;
    switch (_that) {
      case _GetList():
        return getList(_that.q, _that.active);
      case _Create():
        return create(_that.request);
      case _Update():
        return update(_that.id, _that.request);
      case _ReplaceCard():
        return replaceCard(_that.id);
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
    TResult? Function(String? q, bool? active)? getList,
    TResult? Function(StudentCreateRequestModel request)? create,
    TResult? Function(int id, StudentUpdateRequestModel request)? update,
    TResult? Function(int id)? replaceCard,
  }) {
    final _that = this;
    switch (_that) {
      case _GetList() when getList != null:
        return getList(_that.q, _that.active);
      case _Create() when create != null:
        return create(_that.request);
      case _Update() when update != null:
        return update(_that.id, _that.request);
      case _ReplaceCard() when replaceCard != null:
        return replaceCard(_that.id);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GetList implements StudentEvent {
  const _GetList({this.q, this.active});

  final String? q;
  final bool? active;

  /// Create a copy of StudentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GetListCopyWith<_GetList> get copyWith =>
      __$GetListCopyWithImpl<_GetList>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GetList &&
            (identical(other.q, q) || other.q == q) &&
            (identical(other.active, active) || other.active == active));
  }

  @override
  int get hashCode => Object.hash(runtimeType, q, active);

  @override
  String toString() {
    return 'StudentEvent.getList(q: $q, active: $active)';
  }
}

/// @nodoc
abstract mixin class _$GetListCopyWith<$Res>
    implements $StudentEventCopyWith<$Res> {
  factory _$GetListCopyWith(_GetList value, $Res Function(_GetList) _then) =
      __$GetListCopyWithImpl;
  @useResult
  $Res call({String? q, bool? active});
}

/// @nodoc
class __$GetListCopyWithImpl<$Res> implements _$GetListCopyWith<$Res> {
  __$GetListCopyWithImpl(this._self, this._then);

  final _GetList _self;
  final $Res Function(_GetList) _then;

  /// Create a copy of StudentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? q = freezed,
    Object? active = freezed,
  }) {
    return _then(_GetList(
      q: freezed == q
          ? _self.q
          : q // ignore: cast_nullable_to_non_nullable
              as String?,
      active: freezed == active
          ? _self.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _Create implements StudentEvent {
  const _Create(this.request);

  final StudentCreateRequestModel request;

  /// Create a copy of StudentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CreateCopyWith<_Create> get copyWith =>
      __$CreateCopyWithImpl<_Create>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Create &&
            (identical(other.request, request) || other.request == request));
  }

  @override
  int get hashCode => Object.hash(runtimeType, request);

  @override
  String toString() {
    return 'StudentEvent.create(request: $request)';
  }
}

/// @nodoc
abstract mixin class _$CreateCopyWith<$Res>
    implements $StudentEventCopyWith<$Res> {
  factory _$CreateCopyWith(_Create value, $Res Function(_Create) _then) =
      __$CreateCopyWithImpl;
  @useResult
  $Res call({StudentCreateRequestModel request});
}

/// @nodoc
class __$CreateCopyWithImpl<$Res> implements _$CreateCopyWith<$Res> {
  __$CreateCopyWithImpl(this._self, this._then);

  final _Create _self;
  final $Res Function(_Create) _then;

  /// Create a copy of StudentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? request = null,
  }) {
    return _then(_Create(
      null == request
          ? _self.request
          : request // ignore: cast_nullable_to_non_nullable
              as StudentCreateRequestModel,
    ));
  }
}

/// @nodoc

class _Update implements StudentEvent {
  const _Update(this.id, this.request);

  final int id;
  final StudentUpdateRequestModel request;

  /// Create a copy of StudentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UpdateCopyWith<_Update> get copyWith =>
      __$UpdateCopyWithImpl<_Update>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Update &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.request, request) || other.request == request));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, request);

  @override
  String toString() {
    return 'StudentEvent.update(id: $id, request: $request)';
  }
}

/// @nodoc
abstract mixin class _$UpdateCopyWith<$Res>
    implements $StudentEventCopyWith<$Res> {
  factory _$UpdateCopyWith(_Update value, $Res Function(_Update) _then) =
      __$UpdateCopyWithImpl;
  @useResult
  $Res call({int id, StudentUpdateRequestModel request});
}

/// @nodoc
class __$UpdateCopyWithImpl<$Res> implements _$UpdateCopyWith<$Res> {
  __$UpdateCopyWithImpl(this._self, this._then);

  final _Update _self;
  final $Res Function(_Update) _then;

  /// Create a copy of StudentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? request = null,
  }) {
    return _then(_Update(
      null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      null == request
          ? _self.request
          : request // ignore: cast_nullable_to_non_nullable
              as StudentUpdateRequestModel,
    ));
  }
}

/// @nodoc

class _ReplaceCard implements StudentEvent {
  const _ReplaceCard(this.id);

  final int id;

  /// Create a copy of StudentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReplaceCardCopyWith<_ReplaceCard> get copyWith =>
      __$ReplaceCardCopyWithImpl<_ReplaceCard>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReplaceCard &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @override
  String toString() {
    return 'StudentEvent.replaceCard(id: $id)';
  }
}

/// @nodoc
abstract mixin class _$ReplaceCardCopyWith<$Res>
    implements $StudentEventCopyWith<$Res> {
  factory _$ReplaceCardCopyWith(
          _ReplaceCard value, $Res Function(_ReplaceCard) _then) =
      __$ReplaceCardCopyWithImpl;
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$ReplaceCardCopyWithImpl<$Res> implements _$ReplaceCardCopyWith<$Res> {
  __$ReplaceCardCopyWithImpl(this._self, this._then);

  final _ReplaceCard _self;
  final $Res Function(_ReplaceCard) _then;

  /// Create a copy of StudentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
  }) {
    return _then(_ReplaceCard(
      null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$StudentState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is StudentState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'StudentState()';
  }
}

/// @nodoc
class $StudentStateCopyWith<$Res> {
  $StudentStateCopyWith(StudentState _, $Res Function(StudentState) __);
}

/// Adds pattern-matching-related methods to [StudentState].
extension StudentStatePatterns on StudentState {
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
    TResult Function(_Initial value)? initial,
    TResult Function(_ListLoading value)? listLoading,
    TResult Function(_ListLoaded value)? listLoaded,
    TResult Function(_ListFailed value)? listFailed,
    TResult Function(_Saving value)? saving,
    TResult Function(_Saved value)? saved,
    TResult Function(_SaveFailed value)? saveFailed,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial(_that);
      case _ListLoading() when listLoading != null:
        return listLoading(_that);
      case _ListLoaded() when listLoaded != null:
        return listLoaded(_that);
      case _ListFailed() when listFailed != null:
        return listFailed(_that);
      case _Saving() when saving != null:
        return saving(_that);
      case _Saved() when saved != null:
        return saved(_that);
      case _SaveFailed() when saveFailed != null:
        return saveFailed(_that);
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_ListLoading value) listLoading,
    required TResult Function(_ListLoaded value) listLoaded,
    required TResult Function(_ListFailed value) listFailed,
    required TResult Function(_Saving value) saving,
    required TResult Function(_Saved value) saved,
    required TResult Function(_SaveFailed value) saveFailed,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial():
        return initial(_that);
      case _ListLoading():
        return listLoading(_that);
      case _ListLoaded():
        return listLoaded(_that);
      case _ListFailed():
        return listFailed(_that);
      case _Saving():
        return saving(_that);
      case _Saved():
        return saved(_that);
      case _SaveFailed():
        return saveFailed(_that);
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
    TResult? Function(_Initial value)? initial,
    TResult? Function(_ListLoading value)? listLoading,
    TResult? Function(_ListLoaded value)? listLoaded,
    TResult? Function(_ListFailed value)? listFailed,
    TResult? Function(_Saving value)? saving,
    TResult? Function(_Saved value)? saved,
    TResult? Function(_SaveFailed value)? saveFailed,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial(_that);
      case _ListLoading() when listLoading != null:
        return listLoading(_that);
      case _ListLoaded() when listLoaded != null:
        return listLoaded(_that);
      case _ListFailed() when listFailed != null:
        return listFailed(_that);
      case _Saving() when saving != null:
        return saving(_that);
      case _Saved() when saved != null:
        return saved(_that);
      case _SaveFailed() when saveFailed != null:
        return saveFailed(_that);
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
    TResult Function()? initial,
    TResult Function()? listLoading,
    TResult Function(List<StudentModel> items)? listLoaded,
    TResult Function(String message)? listFailed,
    TResult Function()? saving,
    TResult Function(String message)? saved,
    TResult Function(String message)? saveFailed,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial();
      case _ListLoading() when listLoading != null:
        return listLoading();
      case _ListLoaded() when listLoaded != null:
        return listLoaded(_that.items);
      case _ListFailed() when listFailed != null:
        return listFailed(_that.message);
      case _Saving() when saving != null:
        return saving();
      case _Saved() when saved != null:
        return saved(_that.message);
      case _SaveFailed() when saveFailed != null:
        return saveFailed(_that.message);
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
    required TResult Function() initial,
    required TResult Function() listLoading,
    required TResult Function(List<StudentModel> items) listLoaded,
    required TResult Function(String message) listFailed,
    required TResult Function() saving,
    required TResult Function(String message) saved,
    required TResult Function(String message) saveFailed,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial():
        return initial();
      case _ListLoading():
        return listLoading();
      case _ListLoaded():
        return listLoaded(_that.items);
      case _ListFailed():
        return listFailed(_that.message);
      case _Saving():
        return saving();
      case _Saved():
        return saved(_that.message);
      case _SaveFailed():
        return saveFailed(_that.message);
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
    TResult? Function()? initial,
    TResult? Function()? listLoading,
    TResult? Function(List<StudentModel> items)? listLoaded,
    TResult? Function(String message)? listFailed,
    TResult? Function()? saving,
    TResult? Function(String message)? saved,
    TResult? Function(String message)? saveFailed,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial();
      case _ListLoading() when listLoading != null:
        return listLoading();
      case _ListLoaded() when listLoaded != null:
        return listLoaded(_that.items);
      case _ListFailed() when listFailed != null:
        return listFailed(_that.message);
      case _Saving() when saving != null:
        return saving();
      case _Saved() when saved != null:
        return saved(_that.message);
      case _SaveFailed() when saveFailed != null:
        return saveFailed(_that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Initial implements StudentState {
  const _Initial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'StudentState.initial()';
  }
}

/// @nodoc

class _ListLoading implements StudentState {
  const _ListLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ListLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'StudentState.listLoading()';
  }
}

/// @nodoc

class _ListLoaded implements StudentState {
  const _ListLoaded(final List<StudentModel> items) : _items = items;

  final List<StudentModel> _items;
  List<StudentModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// Create a copy of StudentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ListLoadedCopyWith<_ListLoaded> get copyWith =>
      __$ListLoadedCopyWithImpl<_ListLoaded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ListLoaded &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  @override
  String toString() {
    return 'StudentState.listLoaded(items: $items)';
  }
}

/// @nodoc
abstract mixin class _$ListLoadedCopyWith<$Res>
    implements $StudentStateCopyWith<$Res> {
  factory _$ListLoadedCopyWith(
          _ListLoaded value, $Res Function(_ListLoaded) _then) =
      __$ListLoadedCopyWithImpl;
  @useResult
  $Res call({List<StudentModel> items});
}

/// @nodoc
class __$ListLoadedCopyWithImpl<$Res> implements _$ListLoadedCopyWith<$Res> {
  __$ListLoadedCopyWithImpl(this._self, this._then);

  final _ListLoaded _self;
  final $Res Function(_ListLoaded) _then;

  /// Create a copy of StudentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? items = null,
  }) {
    return _then(_ListLoaded(
      null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<StudentModel>,
    ));
  }
}

/// @nodoc

class _ListFailed implements StudentState {
  const _ListFailed(this.message);

  final String message;

  /// Create a copy of StudentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ListFailedCopyWith<_ListFailed> get copyWith =>
      __$ListFailedCopyWithImpl<_ListFailed>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ListFailed &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'StudentState.listFailed(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$ListFailedCopyWith<$Res>
    implements $StudentStateCopyWith<$Res> {
  factory _$ListFailedCopyWith(
          _ListFailed value, $Res Function(_ListFailed) _then) =
      __$ListFailedCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$ListFailedCopyWithImpl<$Res> implements _$ListFailedCopyWith<$Res> {
  __$ListFailedCopyWithImpl(this._self, this._then);

  final _ListFailed _self;
  final $Res Function(_ListFailed) _then;

  /// Create a copy of StudentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(_ListFailed(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _Saving implements StudentState {
  const _Saving();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Saving);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'StudentState.saving()';
  }
}

/// @nodoc

class _Saved implements StudentState {
  const _Saved(this.message);

  final String message;

  /// Create a copy of StudentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SavedCopyWith<_Saved> get copyWith =>
      __$SavedCopyWithImpl<_Saved>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Saved &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'StudentState.saved(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$SavedCopyWith<$Res>
    implements $StudentStateCopyWith<$Res> {
  factory _$SavedCopyWith(_Saved value, $Res Function(_Saved) _then) =
      __$SavedCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$SavedCopyWithImpl<$Res> implements _$SavedCopyWith<$Res> {
  __$SavedCopyWithImpl(this._self, this._then);

  final _Saved _self;
  final $Res Function(_Saved) _then;

  /// Create a copy of StudentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(_Saved(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _SaveFailed implements StudentState {
  const _SaveFailed(this.message);

  final String message;

  /// Create a copy of StudentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SaveFailedCopyWith<_SaveFailed> get copyWith =>
      __$SaveFailedCopyWithImpl<_SaveFailed>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SaveFailed &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'StudentState.saveFailed(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$SaveFailedCopyWith<$Res>
    implements $StudentStateCopyWith<$Res> {
  factory _$SaveFailedCopyWith(
          _SaveFailed value, $Res Function(_SaveFailed) _then) =
      __$SaveFailedCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$SaveFailedCopyWithImpl<$Res> implements _$SaveFailedCopyWith<$Res> {
  __$SaveFailedCopyWithImpl(this._self, this._then);

  final _SaveFailed _self;
  final $Res Function(_SaveFailed) _then;

  /// Create a copy of StudentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(_SaveFailed(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
