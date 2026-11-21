part of 'enroll_bloc.dart';

@freezed
class EnrollEvent with _$EnrollEvent {
  const factory EnrollEvent.start() = _Start;
  const factory EnrollEvent.poll() = _Poll;
  const factory EnrollEvent.cancel() = _Cancel;
}
