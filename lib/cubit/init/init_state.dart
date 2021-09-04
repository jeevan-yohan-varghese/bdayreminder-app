part of 'init_cubit.dart';

@immutable
abstract class InitState {
 
}

class InitLoading extends InitState {}

class InitSuccess extends InitState{
  final String fcmDeviceId;
  InitSuccess({required this.fcmDeviceId});
}

class InitFailed extends InitState{
  final String error;
  InitFailed({required this.error});
}


