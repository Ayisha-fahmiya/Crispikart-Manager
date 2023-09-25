// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/Screens/otp_verification.dart';

class ApiServices {
  Future<void> sendOTP(
      String phoneNumber, String apiKey, BuildContext context) async {
    final dio = Dio();
    const url = 'http://127.0.0.1:8000/api/send-otp/';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey', // Include your API key here
    };

    final data = {
      'phone_number': phoneNumber,
    };

    try {
      final response = await dio.post(
        url,
        data: data,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OtpVerificationScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Authentication failed"),
          ),
        );
      }
    } on DioException catch (e) {
      log(e.toString());
    }
  }
}
