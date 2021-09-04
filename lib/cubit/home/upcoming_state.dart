part of 'upcoming_cubit.dart';

@immutable
abstract class UpcomingState{}

class UpcomingLoading extends UpcomingState {}

class UpcomingSucces extends UpcomingState{
  final List<Person>upcomingList;
  UpcomingSucces({required this.upcomingList});
  
}
class UpcomingFailed extends UpcomingState{
  final String error;
  UpcomingFailed({required this.error});
  
}

