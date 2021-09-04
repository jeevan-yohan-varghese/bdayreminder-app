part of 'add_person_cubit.dart';

abstract class AddPersonState extends Equatable {
  @override
  List<Object> get props => [];

  
}

class AddPersonInitial extends AddPersonState {}

class AddPersonDialogState extends AddPersonState {
  final bool isNew;
  final String date;
  
  AddPersonDialogState({required this.isNew,required this.date});


   AddPersonDialogState copyWith({bool? isNew, String? date}) => AddPersonDialogState(
        isNew: isNew ?? this.isNew,
        date: date ?? this.date,
        
      );
    @override
  List<Object> get props => [isNew,date];
}

class DialogDismissedState extends AddPersonState{}

class DateSelectedState extends AddPersonState {
  String date;
  DateSelectedState({required this.date});
}

class AddPersonLoading extends AddPersonState {}

class AddPersonSuccess extends AddPersonState {}

class AddPersonFailed extends AddPersonState {
  String error;
  AddPersonFailed({required this.error});
}

class EditPersonDialogState extends AddPersonState {
  String name;
  String id;
  String dob;
  EditPersonDialogState(
      {required this.name, required this.id, required this.dob});

       @override
  List<Object> get props => [name,id,dob];
}

class EditPersonLoading extends AddPersonState {}

class EditPersonSuccess extends AddPersonState {}

class EditPersonFailed extends AddPersonState {
  String error;
  EditPersonFailed({required this.error});
}
