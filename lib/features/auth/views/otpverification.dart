import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'dart:async';

import 'package:task/features/home/views/homepage.dart';

class Otpverificationpage extends StatefulWidget {
  const Otpverificationpage({super.key});

  @override
  State<Otpverificationpage> createState() => _OtpverificationpageState();
}

class _OtpverificationpageState extends State<Otpverificationpage> {
  late TextEditingController textEditingController;
  late Timer _timer;
  int _secondsRemaining = 59;
  bool _isExpired = false;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _isExpired = true;
        });
        _timer.cancel();
      }
    });
  }

  void _resendOtp() {
    setState(() {
      _secondsRemaining = 59;
      _isExpired = false;
      textEditingController.clear();
    });
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // Image
              Center(
                child: Image.asset(
                  'assets/image/verificationpageimage.png',
                  height: 250,
                  width: 200,
                ),
              ),
              const SizedBox(height: 30),
              // Title
              Text(
                'OTP Verification',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 15),
              // Description
              Text(
                'Enter the verification code we just sent to your number +91 *******21.',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 30),
              // PIN Code Fields
              Center(
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  obscureText: false,
                  obscuringCharacter: '*',
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  validator: (v) {
                    if (v!.length < 3) {
                      return "I'm from validator";
                    } else {
                      return null;
                    }
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
                  onChanged: (value) {
                    setState(() {});
                  },
                  beforeTextPaste: (text) {
                    return true;
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Timer
              Center(
                child: Text(
                  '${_secondsRemaining.toString().padLeft(2, '0')} Sec',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFFFF6B6E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Resend Link
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
                      onTap: _isExpired ? _resendOtp : null,
                      child: Text(
                        'Resend',
                        style: TextStyle(
                          fontSize: 14,
                          color: _isExpired ? Colors.blue : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Verify Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    if (textEditingController.text.length == 6) {
                      // Hardcoded OTP for verification
                      const String correctOtp = '123456';
                      
                      if (textEditingController.text == correctOtp) {
                        // Verify OTP logic here
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('OTP Verified!')),
                        );

                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  HomePage(
                          
                        )));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invalid OTP. Please try again.')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter valid OTP')),
                      );
                    }
                  },
                  child: const Text(
                    'Verify',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}