part of 'device_bloc.dart';

@freezed
class DeviceEvent with _$DeviceEvent {
  const factory DeviceEvent.getList() = _GetList;
  const factory DeviceEvent.create(DeviceNameRequestModel request) = _Create;
  const factory DeviceEvent.rename(int id, DeviceNameRequestModel request) =
      _Rename;
  const factory DeviceEvent.rotateKey(int id) = _RotateKey;
  const factory DeviceEvent.delete(int id) = _Delete;
}
