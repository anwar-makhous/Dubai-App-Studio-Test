import 'package:equatable/equatable.dart';

class HistoryItem extends Equatable {
  final String name;
  final String phoneNumber;
  final double amount;
  final DateTime date;

  const HistoryItem({
    required this.name,
    required this.phoneNumber,
    required this.amount,
    required this.date,
  });

  @override
  List<Object?> get props => [name, phoneNumber, amount, date];

  @override
  String toString() {
    return 'HistoryItem(name: $name, phoneNumber: $phoneNumber, amount: $amount, date: $date)';
  }
}
