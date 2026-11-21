import 'package:absensi/data/datasources/settings_remote_datasource.dart';
import 'package:absensi/data/model/request/settings/settings_update_request_model.dart';
import 'package:absensi/data/model/response/settings/settings_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_event.dart';
part 'settings_state.dart';
part 'settings_bloc.freezed.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRemoteDatasource remoteDatasource;

  /// Setelan terakhir yang diterima dari server
  SettingsModel? _current;

  SettingsBloc(this.remoteDatasource) : super(const _Initial()) {
    on<_GetSettings>(_onGetSettings);
    on<_Update>(_onUpdate);
  }

  Future<void> _onGetSettings(
    _GetSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsState.loading());

    final res = await remoteDatasource.get();
    res.fold(
      (l) => emit(SettingsState.loadFailed(l)),
      (r) {
        _current = r.data;
        emit(SettingsState.loaded(r.data));
      },
    );
  }

  Future<void> _onUpdate(
    _Update event,
    Emitter<SettingsState> emit,
  ) async {
    final current = _current;
    if (current == null) return; // belum ada data dari server

    final busy = state.maybeWhen(saving: (_) => true, orElse: () => false);
    if (busy) return; // cegah dobel tekan

    emit(SettingsState.saving(current));

    final res = await remoteDatasource.update(event.request);
    res.fold(
      (l) => emit(SettingsState.saveFailed(current, l)),
      (r) {
        _current = r.data;
        emit(SettingsState.saved(r.data, 'Setelan tersimpan'));
      },
    );
  }
}
