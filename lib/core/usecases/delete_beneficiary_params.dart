import 'dart:convert';

class DeleteBeneficiaryParams {
  final String phoneNumber;

  DeleteBeneficiaryParams({required this.phoneNumber});

  String toJson() {
    return jsonEncode({
      'phoneNumber': phoneNumber,
    });
  }
}
