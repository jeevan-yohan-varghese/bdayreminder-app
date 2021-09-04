import 'package:bday_reminder_bloc/data/helpers/general_api_response.dart';
import 'package:bday_reminder_bloc/data/helpers/people_list_response.dart';
import 'package:bday_reminder_bloc/data/models/person.dart';
import 'package:bday_reminder_bloc/data/repo/people_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'people_state.dart';

class PeopleCubit extends Cubit<PeopleState> {
  PeopleCubit() : super(PeopleLoading()){
    getPeople();
  }

  void getPeople() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String jwtToken = sharedPreferences.getString("jwtToken") ?? "";
    try {
      PeopleList loadPeopleResponse =
          await PeopleRepo().getPeopleList(jwtToken);
      emit(PeopleSuccess(
          peopleList: loadPeopleResponse.peopleList,
          mFilteredList: null,
          isSearching: false));
    } catch (e) {
      emit(PeopleFailed(error: e.toString()));
    }
  }

  void filterList(String query) {
    if (state is PeopleSuccess) {
      PeopleSuccess currState = state as PeopleSuccess;
      List<Person> actualList = currState.peopleList;
      List<Person> filteredList = [];
      if (query == "") {
        filteredList = actualList;
      } else {
        for (var element in actualList) {
          if (element.name.toLowerCase().contains(query.toLowerCase())) {
            filteredList.add(element);
          }
        }
      }

      emit(PeopleSuccess(
          peopleList: actualList,
          mFilteredList: filteredList,
          isSearching: true));
    }
  }

  void editPerson() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String jwtToken = sharedPreferences.getString("jwtToken") ?? "";
    try {
      PeopleList loadPeopleResponse =
          await PeopleRepo().getPeopleList(jwtToken);
      emit(PeopleSuccess(
          peopleList: loadPeopleResponse.peopleList,
          mFilteredList: null,
          isSearching: false));
    } catch (e) {
      emit(PeopleFailed(error: e.toString()));
    }
  }

  void deletePerson(String personId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String jwtToken = sharedPreferences.getString("jwtToken") ?? "";
    try {
      ApiResponse deletePersonResponse =
          await PeopleRepo().deletePerson(jwtToken, personId);
           PeopleList loadPeopleResponse =
          await PeopleRepo().getPeopleList(jwtToken);
      emit(PeopleSuccess(
          peopleList: loadPeopleResponse.peopleList,
          mFilteredList: null,
          isSearching: false));
    } catch (e) {
      emit(PeopleFailed(error: e.toString()));
    }
  }
}
