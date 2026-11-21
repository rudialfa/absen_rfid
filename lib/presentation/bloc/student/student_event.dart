part of 'student_bloc.dart';

@freezed
class StudentEvent with _$StudentEvent {
  const factory StudentEvent.getList({String? q, bool? active}) = _GetList;
  const factory StudentEvent.create(StudentCreateRequestModel request) =
      _Create;
  const factory StudentEvent.update(
    int id,
    StudentUpdateRequestModel request,
  ) = _Update;
  const factory StudentEvent.replaceCard(int id) = _ReplaceCard;
}
