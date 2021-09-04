part of 'channel_cubit.dart';

abstract class ChannelState extends Equatable {
  const ChannelState();
  @override
  List<Object> get props => [];
}

class ChannelWorkingState extends ChannelState {
  bool isVerificationSent;
  String verCode;

  ChannelWorkingState({this.isVerificationSent = false, this.verCode = ""});

  @override
  List<Object> get props => [];
}

class ChannelUpdateSuccess extends ChannelState {}

class ChannelUpdateError extends ChannelState {
  String error;
  ChannelUpdateError({required this.error});
}
