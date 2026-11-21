// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'enroll_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EnrollEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is EnrollEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EnrollEvent()';
  }
}

/// @nodoc
class $EnrollEventCopyWith<$Res> {
  $EnrollEventCopyWith(EnrollEvent _, $Res Function(EnrollEvent) __);
}

/// Adds pattern-matching-related methods to [EnrollEvent].
extension EnrollEventPatterns on EnrollEvent {
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
    TResult Function(_Start value)? start,
    TResult Function(_Poll value)? poll,
    TResult Function(_Cancel value)? cancel,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Start() when start != null:
        return start(_that);
      case _Poll() when poll != null:
        return poll(_that);
      case _Cancel() when cancel != null:
        return cancel(_that);
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
    required TResult Function(_Start value) start,
    required TResult Function(_Poll value) poll,
    required TResult Function(_Cancel value) cancel,
  }) {
    final _that = this;
    switch (_that) {
      case _Start():
        return start(_that);
      case _Poll():
        return poll(_that);
      case _Cancel():
        return cancel(_that);
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
    TResult? Function(_Start value)? start,
    TResult? Function(_Poll value)? poll,
    TResult? Function(_Cancel value)? cancel,
  }) {
    final _that = this;
    switch (_that) {
      case _Start() when start != null:
        return start(_that);
      case _Poll() when poll != null:
        return poll(_that);
      case _Cancel() when cancel != null:
        return cancel(_that);
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
    TResult Function()? start,
    TResult Function()? poll,
    TResult Function()? cancel,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Start() when start != null:
        return start();
      case _Poll() when poll != null:
        return poll();
      case _Cancel() when cancel != null:
        return cancel();
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
    required TResult Function() start,
    required TResult Function() poll,
    required TResult Function() cancel,
  }) {
    final _that = this;
    switch (_that) {
      case _Start():
        return start();
      case _Poll():
        return poll();
      case _Cancel():
        return cancel();
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
    TResult? Function()? start,
    TResult? Function()? poll,
    TResult? Function()? cancel,
  }) {
    final _that = this;
    switch (_that) {
      case _Start() when start != null:
        return start();
      case _Poll() when poll != null:
        return poll();
      case _Cancel() when cancel != null:
        return cancel();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Start implements EnrollEvent {
  const _Start();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Start);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EnrollEvent.start()';
  }
}

/// @nodoc

class _Poll implements EnrollEvent {
  const _Poll();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Poll);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EnrollEvent.poll()';
  }
}

/// @nodoc

class _Cancel implements EnrollEvent {
  const _Cancel();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Cancel);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EnrollEvent.cancel()';
  }
}

/// @nodoc
mixin _$EnrollState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is EnrollState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EnrollState()';
  }
}

/// @nodoc
class $EnrollStateCopyWith<$Res> {
  $EnrollStateCopyWith(EnrollState _, $Res Function(EnrollState) __);
}

/// Adds pattern-matching-related methods to [EnrollState].
extension EnrollStatePatterns on EnrollState {
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
    TResult Function(_Starting value)? starting,
    TResult Function(_Waiting value)? waiting,
    TResult Function(_Writing value)? writing,
    TResult Function(_Ready value)? ready,
    TResult Function(_AlreadyUsed value)? alreadyUsed,
    TResult Function(_Expired value)? expired,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial(_that);
      case _Starting() when starting != null:
        return starting(_that);
      case _Waiting() when waiting != null:
        return waiting(_that);
      case _Writing() when writing != null:
        return writing(_that);
      case _Ready() when ready != null:
        return ready(_that);
      case _AlreadyUsed() when alreadyUsed != null:
        return alreadyUsed(_that);
      case _Expired() when expired != null:
        return expired(_that);
      case _Failed() when failed != null:
        return failed(_that);
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
    required TResult Function(_Starting value) starting,
    required TResult Function(_Waiting value) waiting,
    required TResult Function(_Writing value) writing,
    required TResult Function(_Ready value) ready,
    required TResult Function(_AlreadyUsed value) alreadyUsed,
    required TResult Function(_Expired value) expired,
    required TResult Function(_Failed value) failed,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial():
        return initial(_that);
      case _Starting():
        return starting(_that);
      case _Waiting():
        return waiting(_that);
      case _Writing():
        return writing(_that);
      case _Ready():
        return ready(_that);
      case _AlreadyUsed():
        return alreadyUsed(_that);
      case _Expired():
        return expired(_that);
      case _Failed():
        return failed(_that);
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
    TResult? Function(_Starting value)? starting,
    TResult? Function(_Waiting value)? waiting,
    TResult? Function(_Writing value)? writing,
    TResult? Function(_Ready value)? ready,
    TResult? Function(_AlreadyUsed value)? alreadyUsed,
    TResult? Function(_Expired value)? expired,
    TResult? Function(_Failed value)? failed,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial(_that);
      case _Starting() when starting != null:
        return starting(_that);
      case _Waiting() when waiting != null:
        return waiting(_that);
      case _Writing() when writing != null:
        return writing(_that);
      case _Ready() when ready != null:
        return ready(_that);
      case _AlreadyUsed() when alreadyUsed != null:
        return alreadyUsed(_that);
      case _Expired() when expired != null:
        return expired(_that);
      case _Failed() when failed != null:
        return failed(_that);
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
    TResult Function()? starting,
    TResult Function(int expiresIn)? waiting,
    TResult Function(String uid)? writing,
    TResult Function(String uid)? ready,
    TResult Function(String uid, String? ownerName, String? ownerType)?
        alreadyUsed,
    TResult Function()? expired,
    TResult Function(String message)? failed,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial();
      case _Starting() when starting != null:
        return starting();
      case _Waiting() when waiting != null:
        return waiting(_that.expiresIn);
      case _Writing() when writing != null:
        return writing(_that.uid);
      case _Ready() when ready != null:
        return ready(_that.uid);
      case _AlreadyUsed() when alreadyUsed != null:
        return alreadyUsed(_that.uid, _that.ownerName, _that.ownerType);
      case _Expired() when expired != null:
        return expired();
      case _Failed() when failed != null:
        return failed(_that.message);
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
    required TResult Function() starting,
    required TResult Function(int expiresIn) waiting,
    required TResult Function(String uid) writing,
    required TResult Function(String uid) ready,
    required TResult Function(String uid, String? ownerName, String? ownerType)
        alreadyUsed,
    required TResult Function() expired,
    required TResult Function(String message) failed,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial():
        return initial();
      case _Starting():
        return starting();
      case _Waiting():
        return waiting(_that.expiresIn);
      case _Writing():
        return writing(_that.uid);
      case _Ready():
        return ready(_that.uid);
      case _AlreadyUsed():
        return alreadyUsed(_that.uid, _that.ownerName, _that.ownerType);
      case _Expired():
        return expired();
      case _Failed():
        return failed(_that.message);
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
    TResult? Function()? starting,
    TResult? Function(int expiresIn)? waiting,
    TResult? Function(String uid)? writing,
    TResult? Function(String uid)? ready,
    TResult? Function(String uid, String? ownerName, String? ownerType)?
        alreadyUsed,
    TResult? Function()? expired,
    TResult? Function(String message)? failed,
  }) {
    final _that = this;
    switch (_that) {
      case _Initial() when initial != null:
        return initial();
      case _Starting() when starting != null:
        return starting();
      case _Waiting() when waiting != null:
        return waiting(_that.expiresIn);
      case _Writing() when writing != null:
        return writing(_that.uid);
      case _Ready() when ready != null:
        return ready(_that.uid);
      case _AlreadyUsed() when alreadyUsed != null:
        return alreadyUsed(_that.uid, _that.ownerName, _that.ownerType);
      case _Expired() when expired != null:
        return expired();
      case _Failed() when failed != null:
        return failed(_that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Initial implements EnrollState {
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
    return 'EnrollState.initial()';
  }
}

/// @nodoc

class _Starting implements EnrollState {
  const _Starting();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Starting);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EnrollState.starting()';
  }
}

/// @nodoc

class _Waiting implements EnrollState {
  const _Waiting(this.expiresIn);

  final int expiresIn;

  /// Create a copy of EnrollState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WaitingCopyWith<_Waiting> get copyWith =>
      __$WaitingCopyWithImpl<_Waiting>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Waiting &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn));
  }

  @override
  int get hashCode => Object.hash(runtimeType, expiresIn);

  @override
  String toString() {
    return 'EnrollState.waiting(expiresIn: $expiresIn)';
  }
}

/// @nodoc
abstract mixin class _$WaitingCopyWith<$Res>
    implements $EnrollStateCopyWith<$Res> {
  factory _$WaitingCopyWith(_Waiting value, $Res Function(_Waiting) _then) =
      __$WaitingCopyWithImpl;
  @useResult
  $Res call({int expiresIn});
}

/// @nodoc
class __$WaitingCopyWithImpl<$Res> implements _$WaitingCopyWith<$Res> {
  __$WaitingCopyWithImpl(this._self, this._then);

  final _Waiting _self;
  final $Res Function(_Waiting) _then;

  /// Create a copy of EnrollState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? expiresIn = null,
  }) {
    return _then(_Waiting(
      null == expiresIn
          ? _self.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _Writing implements EnrollState {
  const _Writing(this.uid);

  final String uid;

  /// Create a copy of EnrollState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WritingCopyWith<_Writing> get copyWith =>
      __$WritingCopyWithImpl<_Writing>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Writing &&
            (identical(other.uid, uid) || other.uid == uid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uid);

  @override
  String toString() {
    return 'EnrollState.writing(uid: $uid)';
  }
}

/// @nodoc
abstract mixin class _$WritingCopyWith<$Res>
    implements $EnrollStateCopyWith<$Res> {
  factory _$WritingCopyWith(_Writing value, $Res Function(_Writing) _then) =
      __$WritingCopyWithImpl;
  @useResult
  $Res call({String uid});
}

/// @nodoc
class __$WritingCopyWithImpl<$Res> implements _$WritingCopyWith<$Res> {
  __$WritingCopyWithImpl(this._self, this._then);

  final _Writing _self;
  final $Res Function(_Writing) _then;

  /// Create a copy of EnrollState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uid = null,
  }) {
    return _then(_Writing(
      null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _Ready implements EnrollState {
  const _Ready(this.uid);

  final String uid;

  /// Create a copy of EnrollState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReadyCopyWith<_Ready> get copyWith =>
      __$ReadyCopyWithImpl<_Ready>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Ready &&
            (identical(other.uid, uid) || other.uid == uid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uid);

  @override
  String toString() {
    return 'EnrollState.ready(uid: $uid)';
  }
}

/// @nodoc
abstract mixin class _$ReadyCopyWith<$Res>
    implements $EnrollStateCopyWith<$Res> {
  factory _$ReadyCopyWith(_Ready value, $Res Function(_Ready) _then) =
      __$ReadyCopyWithImpl;
  @useResult
  $Res call({String uid});
}

/// @nodoc
class __$ReadyCopyWithImpl<$Res> implements _$ReadyCopyWith<$Res> {
  __$ReadyCopyWithImpl(this._self, this._then);

  final _Ready _self;
  final $Res Function(_Ready) _then;

  /// Create a copy of EnrollState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uid = null,
  }) {
    return _then(_Ready(
      null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _AlreadyUsed implements EnrollState {
  const _AlreadyUsed({required this.uid, this.ownerName, this.ownerType});

  final String uid;
  final String? ownerName;
  final String? ownerType;

  /// Create a copy of EnrollState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AlreadyUsedCopyWith<_AlreadyUsed> get copyWith =>
      __$AlreadyUsedCopyWithImpl<_AlreadyUsed>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AlreadyUsed &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.ownerName, ownerName) ||
                other.ownerName == ownerName) &&
            (identical(other.ownerType, ownerType) ||
                other.ownerType == ownerType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uid, ownerName, ownerType);

  @override
  String toString() {
    return 'EnrollState.alreadyUsed(uid: $uid, ownerName: $ownerName, ownerType: $ownerType)';
  }
}

/// @nodoc
abstract mixin class _$AlreadyUsedCopyWith<$Res>
    implements $EnrollStateCopyWith<$Res> {
  factory _$AlreadyUsedCopyWith(
          _AlreadyUsed value, $Res Function(_AlreadyUsed) _then) =
      __$AlreadyUsedCopyWithImpl;
  @useResult
  $Res call({String uid, String? ownerName, String? ownerType});
}

/// @nodoc
class __$AlreadyUsedCopyWithImpl<$Res> implements _$AlreadyUsedCopyWith<$Res> {
  __$AlreadyUsedCopyWithImpl(this._self, this._then);

  final _AlreadyUsed _self;
  final $Res Function(_AlreadyUsed) _then;

  /// Create a copy of EnrollState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uid = null,
    Object? ownerName = freezed,
    Object? ownerType = freezed,
  }) {
    return _then(_AlreadyUsed(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      ownerName: freezed == ownerName
          ? _self.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerType: freezed == ownerType
          ? _self.ownerType
          : ownerType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _Expired implements EnrollState {
  const _Expired();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Expired);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EnrollState.expired()';
  }
}

/// @nodoc

class _Failed implements EnrollState {
  const _Failed(this.message);

  final String message;

  /// Create a copy of EnrollState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FailedCopyWith<_Failed> get copyWith =>
      __$FailedCopyWithImpl<_Failed>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Failed &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'EnrollState.failed(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$FailedCopyWith<$Res>
    implements $EnrollStateCopyWith<$Res> {
  factory _$FailedCopyWith(_Failed value, $Res Function(_Failed) _then) =
      __$FailedCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$FailedCopyWithImpl<$Res> implements _$FailedCopyWith<$Res> {
  __$FailedCopyWithImpl(this._self, this._then);

  final _Failed _self;
  final $Res Function(_Failed) _then;

  /// Create a copy of EnrollState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(_Failed(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
