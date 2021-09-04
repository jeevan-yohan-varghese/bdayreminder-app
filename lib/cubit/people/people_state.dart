part of 'people_cubit.dart';

abstract class PeopleState extends Equatable{
  
}

class PeopleLoading extends PeopleState {
  @override
  List<Object?> get props => [];
}

class PeopleSuccess extends PeopleState{
  List<Person> peopleList;
  List<Person>filteredList=[];
  bool isSearching=false;
  PeopleSuccess({required this.peopleList,List<Person>?mFilteredList,required this.isSearching}){
    filteredList=mFilteredList??peopleList;
  }
    @override
  List<Object?> get props => [peopleList,filteredList];

}


class PeopleFailed extends PeopleState{
  String error;
  PeopleFailed({required this.error});
    @override
  List<Object?> get props => [error];

}
