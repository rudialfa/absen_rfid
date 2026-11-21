part of 'settings_bloc.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState.initial() = _Initial;
  const factory SettingsState.loading() = _Loading;
  const factory SettingsState.loaded(SettingsModel settings) = _Loaded;
  const factory SettingsState.saving(SettingsModel settings) = _Saving;
  const factory SettingsState.saved(SettingsModel settings, String message) =
      _Saved;
  const factory SettingsState.saveFailed(
    SettingsModel settings,
    String message,
  ) = _SaveFailed;
  const factory SettingsState.loadFailed(String message) = _LoadFailed;
}
