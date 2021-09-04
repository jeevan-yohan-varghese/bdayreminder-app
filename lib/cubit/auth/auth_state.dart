part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthLoadingState extends AuthState {}

class AlreadySignedInState extends AuthState {
  final String jwtToken;
  AlreadySignedInState({required this.jwtToken});
}

class NotLoggedInState extends AuthState {}

class NewlyLoggedInState extends AuthState {
  final String jwtToken;
  NewlyLoggedInState({required this.jwtToken});
}

class SignInFailedState extends AuthState {
  final String error;
  SignInFailedState({required this.error});
}

class SignOutState extends AuthState{
  
}
