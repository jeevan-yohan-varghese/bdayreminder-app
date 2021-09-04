import 'package:bday_reminder_bloc/data/helpers/general_api_response.dart';
import 'package:bday_reminder_bloc/data/helpers/telegram_verification_response.dart';
import 'package:bday_reminder_bloc/data/repo/settings_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'channel_state.dart';

class ChannelCubit extends Cubit<ChannelState> {
  ChannelCubit() : super(ChannelWorkingState());


  void sendVerification(String channelId)async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String jwtToken = sharedPreferences.getString("jwtToken") ?? "";
    try {
      TelegramVerificationResponse sendVerRes =
          await SettingsRepo().sendVerificationCode(jwtToken, channelId);
          debugPrint(sendVerRes.toString());
      emit(ChannelWorkingState(isVerificationSent: true,verCode: sendVerRes.token));
    } catch (e) {
      emit(ChannelUpdateError(error: e.toString()));
    }
  }

  void verifyChannel(String channelId)async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String jwtToken = sharedPreferences.getString("jwtToken") ?? "";
    try {
      ApiResponse sendVerRes =
          await SettingsRepo().updateTelegramChannel(jwtToken, channelId);
      emit(ChannelUpdateSuccess());
    } catch (e) {
      emit(ChannelUpdateError(error: e.toString()));
    }
  }
}
