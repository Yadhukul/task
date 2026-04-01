import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  Timer? _timer;
  static const int _initialSeconds = 59;

  OtpCubit() : super(const OtpInitial());

  void startTimer() {
    emit(OtpTimerRunning(_initialSeconds));
    _timer?.cancel();
    
    int secondsRemaining = _initialSeconds;
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      secondsRemaining--;
      
      if (secondsRemaining > 0) {
        emit(OtpTimerRunning(secondsRemaining));
      } else {
        emit(OtpExpired());
        timer.cancel();
      }
    });
  }

  void resendOtp() {
    startTimer();
  }

  Future<void> verifyOtp(String otp) async {
    emit(OtpVerifying());
    
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
    
    const String correctOtp = '123456';
    
    if (otp == correctOtp) {
      emit(OtpVerified());
    } else {
      emit(const OtpError('Invalid OTP. Please try again.'));
      // Return to timer state
      final currentState = state;
      if (currentState is OtpTimerRunning) {
        emit(OtpTimerRunning(currentState.secondsRemaining));
      } else {
        emit(OtpExpired());
      }
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
