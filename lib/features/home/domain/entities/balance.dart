import 'package:equatable/equatable.dart';

class Balance extends Equatable {
  final double balance;

  const Balance({required this.balance});

  @override
  String toString() => 'Balance(balance: $balance)';

  @override
  List<Object?> get props => [balance];
}
