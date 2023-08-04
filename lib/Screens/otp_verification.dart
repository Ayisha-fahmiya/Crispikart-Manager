import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/Screens/restaurant_profile.dart';
import 'package:restaurant_app/Widgets/easy_widgets.dart';
import 'package:restaurant_app/utilities/app_theme.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  OtpVerificationScreenState createState() => OtpVerificationScreenState();
}

class OtpVerificationScreenState extends State<OtpVerificationScreen> {
  TextEditingController otpController = TextEditingController();
  bool _isError = false;
  int _resendTimer = 60;
  Timer? _timer;
  // bool _isSuccess = false;

  final ButtonStyle style = ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(20),
    backgroundColor: appTheme.colorScheme.primary,
    foregroundColor: appTheme.colorScheme.onPrimary,
  );

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_resendTimer > 0) {
          _resendTimer--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void _verifyOTP() {
    String otp = otpController.text;
    if (otp.length == 6) {
      // Perform OTP verification logic here
      setState(() {
        _isError = false;
      });
      // Show success dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text(
              'Success',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            content: const Text('OTP Verified'),
            actions: [
              ElevatedButton(
                style: style,
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RestaurantProfile()),
                  );
                },
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                        child: Text(
                      'OK',
                      style: TextStyle(fontSize: 18),
                    ))),
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        _isError = true;
      });
    }
  }

  void _resendOTP() {
    if (_resendTimer == 0) {
      setState(() {
        _resendTimer = 60;
      });
      _startResendTimer();
      // Perform OTP resend logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: const Text(
          'OTP Verification',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                "We have sent a verification code to\nphone number",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          width: otpController.text.length == 6 ? 2 : 1,
                          color: otpController.text.length == 6
                              ? Colors.green
                              : Colors.grey)),
                  errorText: _isError ? 'Invalid OTP' : null,
                  hintText: 'Enter the 6-Digit OTP',
                  labelText: 'OTP',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey)),
                ),
              ),
              const SizedBox(height: 20.0),
              MyElevatedButton(buttonName: 'Verify OTP', onPressed: _verifyOTP),
              const SizedBox(height: 20.0),
              _resendTimer > 0
                  ? Text(
                      'Resend OTP in $_resendTimer seconds',
                      style: const TextStyle(color: Colors.grey),
                    )
                  : TextButton(
                      onPressed: _resendOTP,
                      child: const Text('Resend OTP'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
