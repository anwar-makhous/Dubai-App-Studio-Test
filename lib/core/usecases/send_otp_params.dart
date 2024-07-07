import 'dart:convert';

class SendOtpParams {
  final String phoneNumber;

  SendOtpParams({required this.phoneNumber});

  String toJson() {
    return jsonEncode({
      'phoneNumber': phoneNumber,
    });
  }
}
