import 'package:bday_reminder_bloc/data/helpers/general_api_response.dart';
import 'package:bday_reminder_bloc/data/models/user_model.dart';
import 'package:bday_reminder_bloc/data/repo/settings_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsLoading());

  void loadSettings() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String jwtToken = sharedPreferences.getString("jwtToken") ?? "";
    try {
      BdayUser settingsResponse = await SettingsRepo().getUserInfo(jwtToken);
      emit(SettingsSuccess(currentUser: settingsResponse));
    } catch (e) {
      emit(SettingsError(error: e.toString()));
    }
  }

  void toggleTelegram(bool isTurnedOn) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String jwtToken = sharedPreferences.getString("jwtToken") ?? "";
    try {
      ApiResponse settingsResponse =
          await SettingsRepo().updateTelegramSettings(jwtToken, isTurnedOn);
      emit(SettingsActionSuccess());
    } catch (e) {
      emit(SettingsActionError(error: e.toString()));
    }
  }

  void togglePush(bool isTurnedOn) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String jwtToken = sharedPreferences.getString("jwtToken") ?? "";
    try {
      ApiResponse settingsResponse =
          await SettingsRepo().updatePushSettings(jwtToken, isTurnedOn);
      emit(SettingsActionSuccess());
    } catch (e) {
      emit(SettingsActionError(error: e.toString()));
    }
  }
}
