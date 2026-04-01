import 'package:equatable/equatable.dart';

abstract class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object?> get props => [];
}

class OtpInitial extends OtpState {
  final int secondsRemaining;
  final bool isExpired;

  const OtpInitial({
    this.secondsRemaining = 59,
    this.isExpired = false,
  });

  @override
  List<Object?> get props => [secondsRemaining, isExpired];
}

class OtpTimerRunning extends OtpState {
  final int secondsRemaining;

  const OtpTimerRunning(this.secondsRemaining);

  @override
  List<Object?> get props => [secondsRemaining];
}

class OtpExpired extends OtpState {}

class OtpVerifying extends OtpState {}

class OtpVerified extends OtpState {}

class OtpError extends OtpState {
  final String message;

  const OtpError(this.message);

  @override
  List<Object?> get props => [message];
}
