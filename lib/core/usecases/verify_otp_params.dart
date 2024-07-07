import 'dart:convert';

class VerifyOtpParams {
  final String phoneNumber;
  final String otp;

  VerifyOtpParams({required this.phoneNumber, required this.otp});

  String toJson() {
    return jsonEncode({
      'otp': otp,
      'phoneNumber': phoneNumber,
    });
  }
}
