// ignore_for_file: overridden_fields

import 'package:dubai_app_studio/features/home/domain/entities/balance.dart';

class BalanceModel extends Balance {
  @override
  final double balance;

  const BalanceModel({required this.balance}) : super(balance: balance);

  factory BalanceModel.fromJson(json) {
    return BalanceModel(balance: json['balance']);
  }

  Map<String, dynamic> toJson() {
    return {
      'balance': balance,
    };
  }
}
