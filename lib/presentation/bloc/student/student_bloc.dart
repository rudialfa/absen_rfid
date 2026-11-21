import 'package:absensi/data/datasources/student_remote_datasource.dart';
import 'package:absensi/data/model/request/student/student_request_model.dart';
import 'package:absensi/data/model/response/student/student_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'student_event.dart';
part 'student_state.dart';
part 'student_bloc.freezed.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentRemoteDatasource remoteDatasource;

  /// Penanda permintaan daftar terakhir, jawaban yang lebih lama diabaikan
  int _listSeq = 0;

  StudentBloc(this.remoteDatasource) : super(const _Initial()) {
    on<_GetList>(_onGetList);
    on<_Create>(_onCreate);
    on<_Update>(_onUpdate);
    on<_ReplaceCard>(_onReplaceCard);
  }

  bool get _busy => state.maybeWhen(saving: () => true, orElse: () => false);

  Future<void> _onGetList(
    _GetList event,
    Emitter<StudentState> emit,
  ) async {
    final seq = ++_listSeq;
    emit(const StudentState.listLoading());

    final res = await remoteDatasource.list(q: event.q, active: event.active);
    if (seq != _listSeq) return;

    res.fold(
      (l) => emit(StudentState.listFailed(l)),
      (r) => emit(StudentState.listLoaded(r.data)),
    );
  }

  Future<void> _onCreate(
    _Create event,
    Emitter<StudentState> emit,
  ) async {
    if (_busy) return; // cegah dobel tekan

    emit(const StudentState.saving());

    final res = await remoteDatasource.create(event.request);
    res.fold(
      (l) => emit(StudentState.saveFailed(l)),
      (r) => emit(StudentState.saved(
        r.data.hasToken
            ? 'Murid tersimpan'
            : 'Murid tersimpan, tetapi kartu belum bertoken (anti kartu clone '
                'belum aktif). Pakai "Ganti kartu" untuk mendaftarkan ulang.',
      )),
    );
  }

  Future<void> _onUpdate(
    _Update event,
    Emitter<StudentState> emit,
  ) async {
    if (_busy) return;

    emit(const StudentState.saving());

    final res = await remoteDatasource.update(event.id, event.request);
    res.fold(
      (l) => emit(StudentState.saveFailed(l)),
      (r) => emit(const StudentState.saved('Perubahan tersimpan')),
    );
  }

  Future<void> _onReplaceCard(
    _ReplaceCard event,
    Emitter<StudentState> emit,
  ) async {
    if (_busy) return;

    emit(const StudentState.saving());

    final res = await remoteDatasource.replaceCard(event.id);
    res.fold(
      (l) => emit(StudentState.saveFailed(l)),
      (r) => emit(StudentState.saved(
        r.data.hasToken
            ? 'Kartu berhasil diganti'
            : 'Kartu diganti, tetapi belum bertoken (anti kartu clone belum '
                'aktif untuk kartu ini).',
      )),
    );
  }
}
