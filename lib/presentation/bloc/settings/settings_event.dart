part of 'settings_bloc.dart';

@freezed
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.getSettings() = _GetSettings;
  const factory SettingsEvent.update(SettingsUpdateRequestModel request) =
      _Update;
}
