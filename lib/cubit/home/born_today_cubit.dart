import 'package:bday_reminder_bloc/data/helpers/born_today_response.dart';
import 'package:bday_reminder_bloc/data/models/person.dart';
import 'package:bday_reminder_bloc/data/repo/home_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'born_today_state.dart';

class BornTodayCubit extends Cubit<BornTodayState> {
  BornTodayCubit() : super(BornTodayLoading()) {
    _getBornTodayList();
  }

  void _getBornTodayList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String jwtToken = sharedPreferences.getString("jwtToken") ?? "";
    try {
      BornToday bornTodayResponse = await HomeRepo().getBornToday(jwtToken);
      emit(BornTodaySuccess(peopleList: bornTodayResponse.bornTodayList));
    } catch (e) {
      emit(BornTodayFailure(error: e.toString()));
    }
  }
}
