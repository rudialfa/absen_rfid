part of 'student_bloc.dart';

@freezed
class StudentState with _$StudentState {
  const factory StudentState.initial() = _Initial;
  const factory StudentState.listLoading() = _ListLoading;
  const factory StudentState.listLoaded(List<StudentModel> items) = _ListLoaded;
  const factory StudentState.listFailed(String message) = _ListFailed;

  const factory StudentState.saving() = _Saving;
  const factory StudentState.saved(String message) = _Saved;
  const factory StudentState.saveFailed(String message) = _SaveFailed;
}
