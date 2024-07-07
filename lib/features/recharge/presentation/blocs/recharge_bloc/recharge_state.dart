part of 'recharge_bloc.dart';

sealed class RechargeState extends Equatable {
  const RechargeState();

  @override
  List<Object> get props => [];
}

final class RechargeInitial extends RechargeState {}

final class RechargeLoading extends RechargeState {}

final class RechargeFailed extends RechargeState {
  final String errorMessage;
  const RechargeFailed({required this.errorMessage});
}

final class RechargeSuccess extends RechargeState {
  final String phoneNumber;
  final double amount;
  const RechargeSuccess({required this.phoneNumber, required this.amount});
}
