part of 'class_bloc.dart';

@freezed
class ClassState with _$ClassState {
  const factory ClassState.initial() = _Initial;
  const factory ClassState.loading() = _Loading;
  const factory ClassState.loaded(List<ClassModel> items) = _Loaded;
  const factory ClassState.error(String message) = _Error;
}
