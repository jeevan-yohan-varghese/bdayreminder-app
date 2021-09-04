import 'package:bday_reminder_bloc/data/helpers/general_api_response.dart';
import 'package:bday_reminder_bloc/data/repo/people_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'add_person_state.dart';

class AddPersonCubit extends Cubit<AddPersonState> {
  AddPersonCubit() : super(AddPersonInitial());

  void showDialog({required bool isNew, String? id, String? name, String? dob}) {
    if (isNew) {
      emit(AddPersonDialogState(isNew: isNew, date: "Select date"));
    } else {
      //emit(EditPersonDialogState(id: id!, name: name!, dob: dob!));
      emit(AddPersonDialogState(isNew: isNew, date: dob!));
    }
  }

  void dismissDialog(){
    emit(DialogDismissedState());
  }

  void setSelectedDate(String date) {
    if (state is AddPersonDialogState) {
      AddPersonDialogState currState=state as AddPersonDialogState;
      emit(currState.copyWith(date: date));
    }
  }

  void addPerson(String name, String dob) async {
    //emit(AddPersonSuccess());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String jwtToken = sharedPreferences.getString("jwtToken") ?? "";
    try {
      ApiResponse loadPeopleResponse =
          await PeopleRepo().addNewPerson(jwtToken, name, dob);
      emit(AddPersonSuccess());
    } catch (e) {
      emit(AddPersonFailed(error: e.toString()));
    }
  }

  void editPerson(String id, String name, String dob) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String jwtToken = sharedPreferences.getString("jwtToken") ?? "";
    try {
      ApiResponse loadPeopleResponse =
          await PeopleRepo().editPerson(jwtToken, id, name, dob);
      emit(AddPersonSuccess());
    } catch (e) {
      emit(AddPersonFailed(error: e.toString()));
    }
  }
}
