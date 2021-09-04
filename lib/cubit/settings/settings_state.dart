part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  @override
  List<Object> get props => [];
}

class SettingsLoading extends SettingsState {}

class SettingsSuccess extends SettingsState {
  BdayUser currentUser;
  SettingsSuccess({required this.currentUser});
  @override
  List<Object> get props => [currentUser];
}

class SettingsError extends SettingsState {
  String error;
  SettingsError({required this.error});
}

class SettingsActionSuccess extends SettingsState {}

class SettingsActionError extends SettingsState {
  String error;
  SettingsActionError({required this.error});
}
