import 'dart:convert';

class SendAmountParams {
  final String phoneNumber;
  final double amount;

  SendAmountParams({required this.phoneNumber, required this.amount});

  String toJson() {
    return jsonEncode({
      'phoneNumber': phoneNumber,
      'amount': amount,
    });
  }
}
