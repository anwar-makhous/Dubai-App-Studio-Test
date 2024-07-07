import 'package:equatable/equatable.dart';

class AccountInfo extends Equatable {
  final double balance;
  final double totalTransactions;

  const AccountInfo({required this.balance, required this.totalTransactions});

  @override
  String toString() =>
      'AccountInfo(balance: $balance, totalTransactions: $totalTransactions)';

  @override
  List<Object?> get props => [balance, totalTransactions];
}
