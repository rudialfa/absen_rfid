part of 'enroll_bloc.dart';

@freezed
class EnrollState with _$EnrollState {
  const factory EnrollState.initial() = _Initial;
  const factory EnrollState.starting() = _Starting;

  /// Mode daftar aktif, menunggu kartu ditempel
  const factory EnrollState.waiting(int expiresIn) = _Waiting;

  /// Kartu baru tertangkap, perangkat sedang menulis token
  const factory EnrollState.writing(String uid) = _Writing;

  /// Token sudah tertulis, kartu siap dipakai
  const factory EnrollState.ready(String uid) = _Ready;

  /// Kartu sudah dipakai murid atau guru lain
  const factory EnrollState.alreadyUsed({
    required String uid,
    String? ownerName,
    String? ownerType,
  }) = _AlreadyUsed;

  const factory EnrollState.expired() = _Expired;
  const factory EnrollState.failed(String message) = _Failed;
}
