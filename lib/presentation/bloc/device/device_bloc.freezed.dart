// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeviceEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DeviceEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DeviceEvent()';
  }
}

/// @nodoc
class $DeviceEventCopyWith<$Res> {
  $DeviceEventCopyWith(DeviceEvent _, $Res Function(DeviceEvent) __);
}

/// Adds pattern-matching-related methods to [DeviceEvent].
extension DeviceEventPatterns on DeviceEvent {
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
    TResult Function(_Rename value)? rename,
    TResult Function(_RotateKey value)? rotateKey,
    TResult Function(_Delete value)? delete,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GetList() when getList != null:
        return getList(_that);
      case _Create() when create != null:
        return create(_that);
      case _Rename() when rename != null:
        return rename(_that);
      case _RotateKey() when rotateKey != null:
        return rotateKey(_that);
      case _Delete() when delete != null:
        return delete(_that);
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
    required TResult Function(_Rename value) rename,
    required TResult Function(_RotateKey value) rotateKey,
    required TResult Function(_Delete value) delete,
  }) {
    final _that = this;
    switch (_that) {
      case _GetList():
        return getList(_that);
      case _Create():
        return create(_that);
      case _Rename():
        return rename(_that);
      case _RotateKey():
        return rotateKey(_that);
      case _Delete():
        return delete(_that);
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
    TResult? Function(_Rename value)? rename,
    TResult? Function(_RotateKey value)? rotateKey,
    TResult? Function(_Delete value)? delete,
  }) {
    final _that = this;
    switch (_that) {
      case _GetList() when getList != null:
        return getList(_that);
      case _Create() when create != null:
        return create(_that);
      case _Rename() when rename != null:
        return rename(_that);
      case _RotateKey() when rotateKey != null:
        return rotateKey(_that);
      case _Delete() when delete != null:
        return delete(_that);
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
    TResult Function()? getList,
    TResult Function(DeviceNameRequestModel request)? create,
    TResult Function(int id, DeviceNameRequestModel request)? rename,
    TResult Function(int id)? rotateKey,
    TResult Function(int id)? delete,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GetList() when getList != null:
        return getList();
      case _Create() when create != null:
        return create(_that.request);
      case _Rename() when rename != null:
        return rename(_that.id, _that.request);
      case _RotateKey() when rotateKey != null:
        return rotateKey(_that.id);
      case _Delete() when delete != null:
        return delete(_that.id);
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
    required TResult Function() getList,
    required TResult Function(DeviceNameRequestModel request) create,
    required TResult Function(int id, DeviceNameRequestModel request) rename,
    required TResult Function(int id) rotateKey,
    required TResult Function(int id) delete,
  }) {
    final _that = this;
    switch (_that) {
      case _GetList():
        return getList();
      case _Create():
        return create(_that.request);
      case _Rename():
        return rename(_that.id, _that.request);
      case _RotateKey():
        return rotateKey(_that.id);
      case _Delete():
        return delete(_that.id);
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
    TResult? Function()? getList,
    TResult? Function(DeviceNameRequestModel request)? create,
    TResult? Function(int id, DeviceNameRequestModel request)? rename,
    TResult? Function(int id)? rotateKey,
    TResult? Function(int id)? delete,
  }) {
    final _that = this;
    switch (_that) {
      case _GetList() when getList != null:
        return getList();
      case _Create() when create != null:
        return create(_that.request);
      case _Rename() when rename != null:
        return rename(_that.id, _that.request);
      case _RotateKey() when rotateKey != null:
        return rotateKey(_that.id);
      case _Delete() when delete != null:
        return delete(_that.id);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GetList implements DeviceEvent {
  const _GetList();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _GetList);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DeviceEvent.getList()';
  }
}

/// @nodoc

class _Create implements DeviceEvent {
  const _Create(this.request);

  final DeviceNameRequestModel request;

  /// Create a copy of DeviceEvent
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
    return 'DeviceEvent.create(request: $request)';
  }
}

/// @nodoc
abstract mixin class _$CreateCopyWith<$Res>
    implements $DeviceEventCopyWith<$Res> {
  factory _$CreateCopyWith(_Create value, $Res Function(_Create) _then) =
      __$CreateCopyWithImpl;
  @useResult
  $Res call({DeviceNameRequestModel request});
}

/// @nodoc
class __$CreateCopyWithImpl<$Res> implements _$CreateCopyWith<$Res> {
  __$CreateCopyWithImpl(this._self, this._then);

  final _Create _self;
  final $Res Function(_Create) _then;

  /// Create a copy of DeviceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? request = null,
  }) {
    return _then(_Create(
      null == request
          ? _self.request
          : request // ignore: cast_nullable_to_non_nullable
              as DeviceNameRequestModel,
    ));
  }
}

/// @nodoc

class _Rename implements DeviceEvent {
  const _Rename(this.id, this.request);

  final int id;
  final DeviceNameRequestModel request;

  /// Create a copy of DeviceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RenameCopyWith<_Rename> get copyWith =>
      __$RenameCopyWithImpl<_Rename>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Rename &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.request, request) || other.request == request));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, request);

  @override
  String toString() {
    return 'DeviceEvent.rename(id: $id, request: $request)';
  }
}

/// @nodoc
abstract mixin class _$RenameCopyWith<$Res>
    implements $DeviceEventCopyWith<$Res> {
  factory _$RenameCopyWith(_Rename value, $Res Function(_Rename) _then) =
      __$RenameCopyWithImpl;
  @useResult
  $Res call({int id, DeviceNameRequestModel request});
}

/// @nodoc
class __$RenameCopyWithImpl<$Res> implements _$RenameCopyWith<$Res> {
  __$RenameCopyWithImpl(this._self, this._then);

  final _Rename _self;
  final $Res Function(_Rename) _then;

  /// Create a copy of DeviceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? request = null,
  }) {
    return _then(_Rename(
      null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      null == request
          ? _self.request
          : request // ignore: cast_nullable_to_non_nullable
              as DeviceNameRequestModel,
    ));
  }
}

/// @nodoc

class _RotateKey implements DeviceEvent {
  const _RotateKey(this.id);

  final int id;

  /// Create a copy of DeviceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RotateKeyCopyWith<_RotateKey> get copyWith =>
      __$RotateKeyCopyWithImpl<_RotateKey>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RotateKey &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @override
  String toString() {
    return 'DeviceEvent.rotateKey(id: $id)';
  }
}

/// @nodoc
abstract mixin class _$RotateKeyCopyWith<$Res>
    implements $DeviceEventCopyWith<$Res> {
  factory _$RotateKeyCopyWith(
          _RotateKey value, $Res Function(_RotateKey) _then) =
      __$RotateKeyCopyWithImpl;
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$RotateKeyCopyWithImpl<$Res> implements _$RotateKeyCopyWith<$Res> {
  __$RotateKeyCopyWithImpl(this._self, this._then);

  final _RotateKey _self;
  final $Res Function(_RotateKey) _then;

  /// Create a copy of DeviceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
  }) {
    return _then(_RotateKey(
      null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _Delete implements DeviceEvent {
  const _Delete(this.id);

  final int id;

  /// Create a copy of DeviceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DeleteCopyWith<_Delete> get copyWith =>
      __$DeleteCopyWithImpl<_Delete>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Delete &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @override
  String toString() {
    return 'DeviceEvent.delete(id: $id)';
  }
}

/// @nodoc
abstract mixin class _$DeleteCopyWith<$Res>
    implements $DeviceEventCopyWith<$Res> {
  factory _$DeleteCopyWith(_Delete value, $Res Function(_Delete) _then) =
      __$DeleteCopyWithImpl;
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$DeleteCopyWithImpl<$Res> implements _$DeleteCopyWith<$Res> {
  __$DeleteCopyWithImpl(this._self, this._then);

  final _Delete _self;
  final $Res Function(_Delete) _then;

  /// Create a copy of DeviceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
  }) {
    return _then(_Delete(
      null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$DeviceState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DeviceState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DeviceState()';
  }
}

/// @nodoc
class $DeviceStateCopyWith<$Res> {
  $DeviceStateCopyWith(DeviceState _, $Res Function(DeviceState) __);
}

/// Adds pattern-matching-related methods to [DeviceState].
extension DeviceStatePatterns on DeviceState {
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
    TResult Function(_KeyIssued value)? keyIssued,
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
      case _KeyIssued() when keyIssued != null:
        return keyIssued(_that);
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
    required TResult Function(_KeyIssued value) keyIssued,
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
      case _KeyIssued():
        return keyIssued(_that);
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
    TResult? Function(_KeyIssued value)? keyIssued,
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
      case _KeyIssued() when keyIssued != null:
        return keyIssued(_that);
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
    TResult Function(List<DeviceModel> items)? listLoaded,
    TResult Function(String message)? listFailed,
    TResult Function()? saving,
    TResult Function(String message)? saved,
    TResult Function(String message)? saveFailed,
    TResult Function(DeviceModel device, String key, bool rotated)? keyIssued,
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
      case _KeyIssued() when keyIssued != null:
        return keyIssued(_that.device, _that.key, _that.rotated);
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
    required TResult Function(List<DeviceModel> items) listLoaded,
    required TResult Function(String message) listFailed,
    required TResult Function() saving,
    required TResult Function(String message) saved,
    required TResult Function(String message) saveFailed,
    required TResult Function(DeviceModel device, String key, bool rotated)
        keyIssued,
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
      case _KeyIssued():
        return keyIssued(_that.device, _that.key, _that.rotated);
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
    TResult? Function(List<DeviceModel> items)? listLoaded,
    TResult? Function(String message)? listFailed,
    TResult? Function()? saving,
    TResult? Function(String message)? saved,
    TResult? Function(String message)? saveFailed,
    TResult? Function(DeviceModel device, String key, bool rotated)? keyIssued,
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
      case _KeyIssued() when keyIssued != null:
        return keyIssued(_that.device, _that.key, _that.rotated);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Initial implements DeviceState {
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
    return 'DeviceState.initial()';
  }
}

/// @nodoc

class _ListLoading implements DeviceState {
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
    return 'DeviceState.listLoading()';
  }
}

/// @nodoc

class _ListLoaded implements DeviceState {
  const _ListLoaded(final List<DeviceModel> items) : _items = items;

  final List<DeviceModel> _items;
  List<DeviceModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// Create a copy of DeviceState
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
    return 'DeviceState.listLoaded(items: $items)';
  }
}

/// @nodoc
abstract mixin class _$ListLoadedCopyWith<$Res>
    implements $DeviceStateCopyWith<$Res> {
  factory _$ListLoadedCopyWith(
          _ListLoaded value, $Res Function(_ListLoaded) _then) =
      __$ListLoadedCopyWithImpl;
  @useResult
  $Res call({List<DeviceModel> items});
}

/// @nodoc
class __$ListLoadedCopyWithImpl<$Res> implements _$ListLoadedCopyWith<$Res> {
  __$ListLoadedCopyWithImpl(this._self, this._then);

  final _ListLoaded _self;
  final $Res Function(_ListLoaded) _then;

  /// Create a copy of DeviceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? items = null,
  }) {
    return _then(_ListLoaded(
      null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<DeviceModel>,
    ));
  }
}

/// @nodoc

class _ListFailed implements DeviceState {
  const _ListFailed(this.message);

  final String message;

  /// Create a copy of DeviceState
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
    return 'DeviceState.listFailed(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$ListFailedCopyWith<$Res>
    implements $DeviceStateCopyWith<$Res> {
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

  /// Create a copy of DeviceState
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

class _Saving implements DeviceState {
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
    return 'DeviceState.saving()';
  }
}

/// @nodoc

class _Saved implements DeviceState {
  const _Saved(this.message);

  final String message;

  /// Create a copy of DeviceState
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
    return 'DeviceState.saved(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$SavedCopyWith<$Res>
    implements $DeviceStateCopyWith<$Res> {
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

  /// Create a copy of DeviceState
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

class _SaveFailed implements DeviceState {
  const _SaveFailed(this.message);

  final String message;

  /// Create a copy of DeviceState
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
    return 'DeviceState.saveFailed(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$SaveFailedCopyWith<$Res>
    implements $DeviceStateCopyWith<$Res> {
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

  /// Create a copy of DeviceState
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

/// @nodoc

class _KeyIssued implements DeviceState {
  const _KeyIssued(this.device, this.key, this.rotated);

  final DeviceModel device;
  final String key;
  final bool rotated;

  /// Create a copy of DeviceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$KeyIssuedCopyWith<_KeyIssued> get copyWith =>
      __$KeyIssuedCopyWithImpl<_KeyIssued>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _KeyIssued &&
            (identical(other.device, device) || other.device == device) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.rotated, rotated) || other.rotated == rotated));
  }

  @override
  int get hashCode => Object.hash(runtimeType, device, key, rotated);

  @override
  String toString() {
    return 'DeviceState.keyIssued(device: $device, key: $key, rotated: $rotated)';
  }
}

/// @nodoc
abstract mixin class _$KeyIssuedCopyWith<$Res>
    implements $DeviceStateCopyWith<$Res> {
  factory _$KeyIssuedCopyWith(
          _KeyIssued value, $Res Function(_KeyIssued) _then) =
      __$KeyIssuedCopyWithImpl;
  @useResult
  $Res call({DeviceModel device, String key, bool rotated});
}

/// @nodoc
class __$KeyIssuedCopyWithImpl<$Res> implements _$KeyIssuedCopyWith<$Res> {
  __$KeyIssuedCopyWithImpl(this._self, this._then);

  final _KeyIssued _self;
  final $Res Function(_KeyIssued) _then;

  /// Create a copy of DeviceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? device = null,
    Object? key = null,
    Object? rotated = null,
  }) {
    return _then(_KeyIssued(
      null == device
          ? _self.device
          : device // ignore: cast_nullable_to_non_nullable
              as DeviceModel,
      null == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      null == rotated
          ? _self.rotated
          : rotated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
