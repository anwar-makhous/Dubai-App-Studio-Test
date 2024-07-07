// ignore_for_file: overridden_fields

import 'dart:convert';

import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/entities/beneficiary.dart';

class BeneficiaryModel extends Beneficiary {
  @override
  final String name;
  @override
  final String phoneNumber;
  @override
  final bool isVerified;
  @override
  final double totalTransactions;

  const BeneficiaryModel({
    required this.name,
    required this.phoneNumber,
    required this.isVerified,
    required this.totalTransactions,
  }) : super(
          name: name,
          phoneNumber: phoneNumber,
          isVerified: isVerified,
          totalTransactions: totalTransactions,
        );

  factory BeneficiaryModel.fromJson(json) {
    try {
      return BeneficiaryModel(
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        isVerified: json['isVerified'] as bool,
        totalTransactions: json['totalTransactions'] as double,
      );
    } catch (_) {
      throw BadResponseException();
    }
  }

  String toJson() {
    return jsonEncode({
      'name': name,
      'phoneNumber': phoneNumber,
      'isVerified': isVerified,
      'totalTransactions': totalTransactions,
    });
  }

  @override
  BeneficiaryModel copyWith({
    String? name,
    String? phoneNumber,
    bool? isVerified,
    double? totalTransactions,
  }) {
    return BeneficiaryModel(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isVerified: isVerified ?? this.isVerified,
      totalTransactions: totalTransactions ?? this.totalTransactions,
    );
  }
}
