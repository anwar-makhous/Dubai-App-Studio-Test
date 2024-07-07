part of 'recharge_bloc.dart';

sealed class RechargeEvent extends Equatable {
  const RechargeEvent();

  @override
  List<Object> get props => [];
}

final class SendAmountEvent extends RechargeEvent {
  final SendAmountParams params;
  const SendAmountEvent({required this.params});
}
