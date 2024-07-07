// ignore_for_file: overridden_fields

import 'dart:convert';

import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/features/recharge/domain/entities/history_item.dart';

class HistoryItemModel extends HistoryItem {
  @override
  final String name;
  @override
  final String phoneNumber;
  @override
  final double amount;
  @override
  final DateTime date;

  const HistoryItemModel({
    required this.name,
    required this.phoneNumber,
    required this.amount,
    required this.date,
  }) : super(name: name, phoneNumber: phoneNumber, amount: amount, date: date);

  factory HistoryItemModel.fromJson(json) {
    try {
      return HistoryItemModel(
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        amount: json['amount'],
        date: DateTime.parse(json['date']),
      );
    } catch (_) {
      throw BadResponseException();
    }
  }

  String toJson() {
    return jsonEncode({
      'name': name,
      'phoneNumber': phoneNumber,
      'amount': amount,
      'date': date.toIso8601String(),
    });
  }
}
