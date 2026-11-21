import 'package:absensi/data/datasources/class_remote_datasource.dart';
import 'package:absensi/data/model/response/class/class_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'class_event.dart';
part 'class_state.dart';
part 'class_bloc.freezed.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  final ClassRemoteDatasource remoteDatasource;

  ClassBloc(this.remoteDatasource) : super(const _Initial()) {
    on<_GetList>(_onGetList);
  }

  Future<void> _onGetList(
    _GetList event,
    Emitter<ClassState> emit,
  ) async {
    emit(const ClassState.loading());

    final res = await remoteDatasource.list();
    res.fold(
      (l) => emit(ClassState.error(l)),
      (r) => emit(ClassState.loaded(r.data)),
    );
  }
}
