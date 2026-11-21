// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettingsEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SettingsEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SettingsEvent()';
  }
}

/// @nodoc
class $SettingsEventCopyWith<$Res> {
  $SettingsEventCopyWith(SettingsEvent _, $Res Function(SettingsEvent) __);
}

/// Adds pattern-matching-related methods to [SettingsEvent].
extension SettingsEventPatterns on SettingsEvent {
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
    TResult Function(_GetSettings value)? getSettings,
    TResult Function(_Update value)? update,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GetSettings() when getSettings != null:
        return getSettings(_that);
      case _Update() when update != null:
        return update(_that);
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
    required TResult Function(_GetSettings value) getSettings,
    required TResult Function(_Update value) update,
  }) {
    final _that = this;
    switch (_that) {
      case _GetSettings():
        return getSettings(_that);
      case _Update():
        return update(_that);
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
    TResult? Function(_GetSettings value)? getSettings,
    TResult? Function(_Update value)? update,
  }) {
    final _that = this;
    switch (_that) {
      case _GetSettings() when getSettings != null:
        return getSettings(_that);
      case _Update() when update != null:
        return update(_that);
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
    TResult Function()? getSettings,
    TResult Function(SettingsUpdateRequestModel request)? update,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GetSettings() when getSettings != null:
        return getSettings();
      case _Update() when update != null:
        return update(_that.request);
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
    required TResult Function() getSettings,
    required TResult Function(SettingsUpdateRequestModel request) update,
  }) {
    final _that = this;
    switch (_that) {
      case _GetSettings():
        return getSettings();
      case _Update():
        return update(_that.request);
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
    TResult? Function()? getSettings,
    TResult? Function(SettingsUpdateRequestModel request)? update,
  }) {
    final _that = this;
    switch (_that) {
      case _GetSettings() when getSettings != null:
        return getSettings();
      case _Update() when update != null:
        return update(_that.request);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GetSettings implements SettingsEvent {
  const _GetSettings();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _GetSettings);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SettingsEvent.getSettings()';
  }
}

/// @nodoc

class _Update implements SettingsEvent {
  const _Update(this.request);

  final SettingsUpdateRequestModel request;

  /// Create a copy of SettingsEvent
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
            (identical(other.request, request) || other.request == request));
  }

  @override
  int get hashCode => Object.hash(runtimeType, request);

  @override
  String toString() {
    return 'SettingsEvent.update(request: $request)';
  }
}

/// @nodoc
abstract mixin class _$UpdateCopyWith<$Res>
    implements $SettingsEventCopyWith<$Res> {
  factory _$UpdateCopyWith(_Update value, $Res Function(_Update) _then) =
      __$UpdateCopyWithImpl;
  @useResult
  $Res call({SettingsUpdateRequestModel request});
}

/// @nodoc
class __$UpdateCopyWithImpl<$Res> implements _$UpdateCopyWith<$Res> {
  __$UpdateCopyWithImpl(this._self, this._then);

  final _Update _self;
  final $Res Function(_Update) _then;

  /// Create a copy of SettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? request = null,
  }) {
    return _then(_Update(
      null == request
          ? _self.request
          : request // ignore: cast_nullable_to_non_nullable
              as SettingsUpdateRequestModel,
    ));
  }
}

/// @nodoc
mixin _$SettingsState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SettingsState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SettingsState()';
  }
}

/// @nodoc
class $SettingsStateCopyWith<$Res> {
  $SettingsStateCopyWith(SettingsState _, $Res Function(SettingsState) __);
}

/// Adds pattern-matching-related methods to [SettingsState].
extension SettingsStatePatterns on SettingsState {
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
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Saving value)? saving,
    TResult Function(_Saved value)? saved,
    TResult Function(_SaveFailed value)? saveFailed,
    TResult Function(_LoadFailed value)? loadFailed,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial(_that);
      case _Loading() when loading != null:
        return loading(_that);
      case _Loaded() when loaded != null:
        return loaded(_that);
      case _Saving() when saving != null:
        return saving(_that);
      case _Saved() when saved != null:
        return saved(_that);
      case _SaveFailed() when saveFailed != null:
        return saveFailed(_that);
      case _LoadFailed() when loadFailed != null:
        return loadFailed(_that);
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
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Saving value) saving,
    required TResult Function(_Saved value) saved,
    required TResult Function(_SaveFailed value) saveFailed,
    required TResult Function(_LoadFailed value) loadFailed,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial():
        return initial(_that);
      case _Loading():
        return loading(_that);
      case _Loaded():
        return loaded(_that);
      case _Saving():
        return saving(_that);
      case _Saved():
        return saved(_that);
      case _SaveFailed():
        return saveFailed(_that);
      case _LoadFailed():
        return loadFailed(_that);
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
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Saving value)? saving,
    TResult? Function(_Saved value)? saved,
    TResult? Function(_SaveFailed value)? saveFailed,
    TResult? Function(_LoadFailed value)? loadFailed,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial(_that);
      case _Loading() when loading != null:
        return loading(_that);
      case _Loaded() when loaded != null:
        return loaded(_that);
      case _Saving() when saving != null:
        return saving(_that);
      case _Saved() when saved != null:
        return saved(_that);
      case _SaveFailed() when saveFailed != null:
        return saveFailed(_that);
      case _LoadFailed() when loadFailed != null:
        return loadFailed(_that);
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
    TResult Function()? loading,
    TResult Function(SettingsModel settings)? loaded,
    TResult Function(SettingsModel settings)? saving,
    TResult Function(SettingsModel settings, String message)? saved,
    TResult Function(SettingsModel settings, String message)? saveFailed,
    TResult Function(String message)? loadFailed,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial();
      case _Loading() when loading != null:
        return loading();
      case _Loaded() when loaded != null:
        return loaded(_that.settings);
      case _Saving() when saving != null:
        return saving(_that.settings);
      case _Saved() when saved != null:
        return saved(_that.settings, _that.message);
      case _SaveFailed() when saveFailed != null:
        return saveFailed(_that.settings, _that.message);
      case _LoadFailed() when loadFailed != null:
        return loadFailed(_that.message);
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
    required TResult Function() loading,
    required TResult Function(SettingsModel settings) loaded,
    required TResult Function(SettingsModel settings) saving,
    required TResult Function(SettingsModel settings, String message) saved,
    required TResult Function(SettingsModel settings, String message)
        saveFailed,
    required TResult Function(String message) loadFailed,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial():
        return initial();
      case _Loading():
        return loading();
      case _Loaded():
        return loaded(_that.settings);
      case _Saving():
        return saving(_that.settings);
      case _Saved():
        return saved(_that.settings, _that.message);
      case _SaveFailed():
        return saveFailed(_that.settings, _that.message);
      case _LoadFailed():
        return loadFailed(_that.message);
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
    TResult? Function()? loading,
    TResult? Function(SettingsModel settings)? loaded,
    TResult? Function(SettingsModel settings)? saving,
    TResult? Function(SettingsModel settings, String message)? saved,
    TResult? Function(SettingsModel settings, String message)? saveFailed,
    TResult? Function(String message)? loadFailed,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial();
      case _Loading() when loading != null:
        return loading();
      case _Loaded() when loaded != null:
        return loaded(_that.settings);
      case _Saving() when saving != null:
        return saving(_that.settings);
      case _Saved() when saved != null:
        return saved(_that.settings, _that.message);
      case _SaveFailed() when saveFailed != null:
        return saveFailed(_that.settings, _that.message);
      case _LoadFailed() when loadFailed != null:
        return loadFailed(_that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Initial implements SettingsState {
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
    return 'SettingsState.initial()';
  }
}

/// @nodoc

class _Loading implements SettingsState {
  const _Loading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SettingsState.loading()';
  }
}

/// @nodoc

class _Loaded implements SettingsState {
  const _Loaded(this.settings);

  final SettingsModel settings;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoadedCopyWith<_Loaded> get copyWith =>
      __$LoadedCopyWithImpl<_Loaded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Loaded &&
            (identical(other.settings, settings) ||
                other.settings == settings));
  }

  @override
  int get hashCode => Object.hash(runtimeType, settings);

  @override
  String toString() {
    return 'SettingsState.loaded(settings: $settings)';
  }
}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res>
    implements $SettingsStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) =
      __$LoadedCopyWithImpl;
  @useResult
  $Res call({SettingsModel settings});
}

/// @nodoc
class __$LoadedCopyWithImpl<$Res> implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? settings = null,
  }) {
    return _then(_Loaded(
      null == settings
          ? _self.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as SettingsModel,
    ));
  }
}

/// @nodoc

class _Saving implements SettingsState {
  const _Saving(this.settings);

  final SettingsModel settings;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SavingCopyWith<_Saving> get copyWith =>
      __$SavingCopyWithImpl<_Saving>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Saving &&
            (identical(other.settings, settings) ||
                other.settings == settings));
  }

  @override
  int get hashCode => Object.hash(runtimeType, settings);

  @override
  String toString() {
    return 'SettingsState.saving(settings: $settings)';
  }
}

/// @nodoc
abstract mixin class _$SavingCopyWith<$Res>
    implements $SettingsStateCopyWith<$Res> {
  factory _$SavingCopyWith(_Saving value, $Res Function(_Saving) _then) =
      __$SavingCopyWithImpl;
  @useResult
  $Res call({SettingsModel settings});
}

/// @nodoc
class __$SavingCopyWithImpl<$Res> implements _$SavingCopyWith<$Res> {
  __$SavingCopyWithImpl(this._self, this._then);

  final _Saving _self;
  final $Res Function(_Saving) _then;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? settings = null,
  }) {
    return _then(_Saving(
      null == settings
          ? _self.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as SettingsModel,
    ));
  }
}

/// @nodoc

class _Saved implements SettingsState {
  const _Saved(this.settings, this.message);

  final SettingsModel settings;
  final String message;

  /// Create a copy of SettingsState
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
            (identical(other.settings, settings) ||
                other.settings == settings) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, settings, message);

  @override
  String toString() {
    return 'SettingsState.saved(settings: $settings, message: $message)';
  }
}

/// @nodoc
abstract mixin class _$SavedCopyWith<$Res>
    implements $SettingsStateCopyWith<$Res> {
  factory _$SavedCopyWith(_Saved value, $Res Function(_Saved) _then) =
      __$SavedCopyWithImpl;
  @useResult
  $Res call({SettingsModel settings, String message});
}

/// @nodoc
class __$SavedCopyWithImpl<$Res> implements _$SavedCopyWith<$Res> {
  __$SavedCopyWithImpl(this._self, this._then);

  final _Saved _self;
  final $Res Function(_Saved) _then;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? settings = null,
    Object? message = null,
  }) {
    return _then(_Saved(
      null == settings
          ? _self.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as SettingsModel,
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _SaveFailed implements SettingsState {
  const _SaveFailed(this.settings, this.message);

  final SettingsModel settings;
  final String message;

  /// Create a copy of SettingsState
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
            (identical(other.settings, settings) ||
                other.settings == settings) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, settings, message);

  @override
  String toString() {
    return 'SettingsState.saveFailed(settings: $settings, message: $message)';
  }
}

/// @nodoc
abstract mixin class _$SaveFailedCopyWith<$Res>
    implements $SettingsStateCopyWith<$Res> {
  factory _$SaveFailedCopyWith(
          _SaveFailed value, $Res Function(_SaveFailed) _then) =
      __$SaveFailedCopyWithImpl;
  @useResult
  $Res call({SettingsModel settings, String message});
}

/// @nodoc
class __$SaveFailedCopyWithImpl<$Res> implements _$SaveFailedCopyWith<$Res> {
  __$SaveFailedCopyWithImpl(this._self, this._then);

  final _SaveFailed _self;
  final $Res Function(_SaveFailed) _then;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? settings = null,
    Object? message = null,
  }) {
    return _then(_SaveFailed(
      null == settings
          ? _self.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as SettingsModel,
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _LoadFailed implements SettingsState {
  const _LoadFailed(this.message);

  final String message;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoadFailedCopyWith<_LoadFailed> get copyWith =>
      __$LoadFailedCopyWithImpl<_LoadFailed>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoadFailed &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'SettingsState.loadFailed(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$LoadFailedCopyWith<$Res>
    implements $SettingsStateCopyWith<$Res> {
  factory _$LoadFailedCopyWith(
          _LoadFailed value, $Res Function(_LoadFailed) _then) =
      __$LoadFailedCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$LoadFailedCopyWithImpl<$Res> implements _$LoadFailedCopyWith<$Res> {
  __$LoadFailedCopyWithImpl(this._self, this._then);

  final _LoadFailed _self;
  final $Res Function(_LoadFailed) _then;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(_LoadFailed(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
