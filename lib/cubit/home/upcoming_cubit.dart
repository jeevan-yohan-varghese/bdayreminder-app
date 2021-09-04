import 'package:bday_reminder_bloc/data/helpers/people_list_response.dart';
import 'package:bday_reminder_bloc/data/models/person.dart';
import 'package:bday_reminder_bloc/data/repo/home_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'upcoming_state.dart';

class UpcomingCubit extends Cubit<UpcomingState> {
  UpcomingCubit() : super(UpcomingLoading());

  void loadUpcomingList() async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String jwtToken=sharedPreferences.getString("jwtToken")??"";
    try {
      PeopleList peopleListResponse =
          await HomeRepo().getUpcomingList(jwtToken);
          emit(UpcomingSucces(upcomingList: peopleListResponse.peopleList));
    } catch (e) {
      emit(UpcomingFailed(error: e.toString()));
    }
  }
}
