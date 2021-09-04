part of 'born_today_cubit.dart';

@immutable
abstract class BornTodayState {}

class BornTodayLoading extends BornTodayState {}

class BornTodaySuccess extends BornTodayState {
  final List<Person> peopleList;
  BornTodaySuccess({required this.peopleList});
}

class BornTodayFailure extends BornTodayState {
  final String error;
  BornTodayFailure({required this.error});
}
