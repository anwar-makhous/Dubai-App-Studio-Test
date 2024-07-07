import 'package:equatable/equatable.dart';

class Beneficiary extends Equatable {
  final String name;
  final String phoneNumber;
  final bool isVerified;
  final double totalTransactions;

  const Beneficiary(
      {required this.name,
      required this.phoneNumber,
      required this.isVerified,
      required this.totalTransactions});

  @override
  String toString() {
    return 'Beneficiary(name: $name, phoneNumber: $phoneNumber, isVerified: $isVerified, totalTransactions: $totalTransactions)';
  }

  @override
  List<Object?> get props => [name, phoneNumber, isVerified, totalTransactions];

  Beneficiary copyWith({
    String? name,
    String? phoneNumber,
    bool? isVerified,
    double? totalTransactions,
  }) {
    return Beneficiary(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isVerified: isVerified ?? this.isVerified,
      totalTransactions: totalTransactions ?? this.totalTransactions,
    );
  }
}
