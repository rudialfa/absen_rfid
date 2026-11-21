part of 'device_bloc.dart';

@freezed
class DeviceState with _$DeviceState {
  const factory DeviceState.initial() = _Initial;
  const factory DeviceState.listLoading() = _ListLoading;
  const factory DeviceState.listLoaded(List<DeviceModel> items) = _ListLoaded;
  const factory DeviceState.listFailed(String message) = _ListFailed;

  const factory DeviceState.saving() = _Saving;
  const factory DeviceState.saved(String message) = _Saved;
  const factory DeviceState.saveFailed(String message) = _SaveFailed;

  /// Perangkat baru dibuat (rotated = false) atau key diganti (rotated = true).
  /// Key hanya ada di state ini dan tidak disimpan di tempat lain.
  const factory DeviceState.keyIssued(
    DeviceModel device,
    String key,
    bool rotated,
  ) = _KeyIssued;
}
