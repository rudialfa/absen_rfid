import 'package:absensi/data/datasources/device_remote_datasource.dart';
import 'package:absensi/data/model/request/device/device_request_model.dart';
import 'package:absensi/data/model/response/device/device_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_event.dart';
part 'device_state.dart';
part 'device_bloc.freezed.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final DeviceRemoteDatasource remoteDatasource;

  /// Penanda permintaan daftar terakhir, jawaban yang lebih lama diabaikan
  int _listSeq = 0;

  DeviceBloc(this.remoteDatasource) : super(const _Initial()) {
    on<_GetList>(_onGetList);
    on<_Create>(_onCreate);
    on<_Rename>(_onRename);
    on<_RotateKey>(_onRotateKey);
    on<_Delete>(_onDelete);
  }

  bool get _busy => state.maybeWhen(saving: () => true, orElse: () => false);

  Future<void> _onGetList(
    _GetList event,
    Emitter<DeviceState> emit,
  ) async {
    final seq = ++_listSeq;
    emit(const DeviceState.listLoading());

    final res = await remoteDatasource.list();
    if (seq != _listSeq) return;

    res.fold(
      (l) => emit(DeviceState.listFailed(l)),
      (r) => emit(DeviceState.listLoaded(r.data)),
    );
  }

  Future<void> _onCreate(
    _Create event,
    Emitter<DeviceState> emit,
  ) async {
    if (_busy) return; // cegah dobel tekan

    emit(const DeviceState.saving());

    final res = await remoteDatasource.create(event.request);
    res.fold(
      (l) => emit(DeviceState.saveFailed(l)),
      // Key dijamin ada oleh datasource (jawaban tanpa key dianggap rusak)
      (r) => emit(DeviceState.keyIssued(r.data, r.deviceKey!, false)),
    );
  }

  Future<void> _onRename(
    _Rename event,
    Emitter<DeviceState> emit,
  ) async {
    if (_busy) return;

    emit(const DeviceState.saving());

    final res = await remoteDatasource.rename(event.id, event.request);
    res.fold(
      (l) => emit(DeviceState.saveFailed(l)),
      (r) => emit(const DeviceState.saved('Nama perangkat diperbarui')),
    );
  }

  Future<void> _onRotateKey(
    _RotateKey event,
    Emitter<DeviceState> emit,
  ) async {
    if (_busy) return;

    emit(const DeviceState.saving());

    final res = await remoteDatasource.rotateKey(event.id);
    res.fold(
      (l) => emit(DeviceState.saveFailed(l)),
      (r) => emit(DeviceState.keyIssued(r.data, r.deviceKey!, true)),
    );
  }

  Future<void> _onDelete(
    _Delete event,
    Emitter<DeviceState> emit,
  ) async {
    if (_busy) return;

    emit(const DeviceState.saving());

    final res = await remoteDatasource.delete(event.id);
    res.fold(
      (l) => emit(DeviceState.saveFailed(l)),
      (r) => emit(const DeviceState.saved('Perangkat dihapus')),
    );
  }
}
