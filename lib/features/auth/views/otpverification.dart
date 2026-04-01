import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task/features/home/views/homepage.dart';
import '../viewmodel/otp_cubit.dart';
import '../viewmodel/otp_state.dart';

class Otpverificationpage extends StatelessWidget {
  const Otpverificationpage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpCubit()..startTimer(),
      child: const OtpVerificationView(),
    );
  }
}

class OtpVerificationView extends StatelessWidget {
  const OtpVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController();

    return BlocListener<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is OtpVerified) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('OTP Verified!')),
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else if (state is OtpError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Center(
                  child: Image.asset(
                    'assets/image/verificationpageimage.png',
                    height: 250,
                    width: 200,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'OTP Verification',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 15),
                const Text(
                  'Enter the verification code we just sent to your number +91 *******21.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 30),
                Center(
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    obscureText: false,
                    obscuringCharacter: '*',
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    validator: (v) {
                      if (v!.length < 6) {
                        return "Please enter complete OTP";
                      }
                      return null;
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 60,
                      fieldWidth: 50,
                      activeFillColor: Colors.white,
                      activeColor: const Color(0xFFDDDDDD),
                      selectedFillColor: Colors.white,
                      selectedColor: Colors.black,
                      inactiveFillColor: Colors.white,
                      inactiveColor: const Color(0xFFDDDDDD),
                      errorBorderColor: Colors.red,
                    ),
                    controller: textEditingController,
                    onChanged: (value) {},
                    beforeTextPaste: (text) => true,
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<OtpCubit, OtpState>(
                  builder: (context, state) {
                    int secondsRemaining = 0;
                    bool isExpired = false;

                    if (state is OtpTimerRunning) {
                      secondsRemaining = state.secondsRemaining;
                    } else if (state is OtpExpired) {
                      isExpired = true;
                    }

                    return Column(
                      children: [
                        Center(
                          child: Text(
                            '${secondsRemaining.toString().padLeft(2, '0')} Sec',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFFFF6B6E),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't Get OTP? ",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              GestureDetector(
                                onTap: isExpired
                                    ? () {
                                        textEditingController.clear();
                                        context.read<OtpCubit>().resendOtp();
                                      }
                                    : null,
                                child: Text(
                                  'Resend',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isExpired ? Colors.blue : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 40),
                BlocBuilder<OtpCubit, OtpState>(
                  builder: (context, state) {
                    final isVerifying = state is OtpVerifying;

                    return SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: isVerifying
                            ? null
                            : () {
                                if (textEditingController.text.length == 6) {
                                  context
                                      .read<OtpCubit>()
                                      .verifyOtp(textEditingController.text);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Please enter valid OTP'),
                                    ),
                                  );
                                }
                              },
                        child: isVerifying
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Verify',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}