import 'dart:convert';

class AddBeneficiaryParams {
  final String name;
  final String phoneNumber;

  AddBeneficiaryParams({required this.name, required this.phoneNumber});

  String toJson() {
    return jsonEncode({
      'name': name,
      'phoneNumber': phoneNumber,
    });
  }
}
