// ignore_for_file: overridden_fields

import 'dart:convert';

import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/features/account/domain/entities/account_info.dart';

class AccountInfoModel extends AccountInfo {
  @override
  final double balance;
  @override
  final double totalTransactions;

  const AccountInfoModel(
      {required this.balance, required this.totalTransactions})
      : super(balance: balance, totalTransactions: totalTransactions);

  factory AccountInfoModel.fromJson(json) {
    try {
      return AccountInfoModel(
        balance: json['balance'],
        totalTransactions: json['totalTransactions'],
      );
    } catch (_) {
      throw BadResponseException();
    }
  }

  String toJson() {
    return jsonEncode({
      'balance': balance,
      'totalTransactions': totalTransactions,
    });
  }
}
