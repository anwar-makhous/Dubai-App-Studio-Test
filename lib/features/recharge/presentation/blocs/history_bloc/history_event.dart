part of 'history_bloc.dart';

sealed class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

final class GetRechargeHistoryEvent extends HistoryEvent {
  final bool refresh;
  const GetRechargeHistoryEvent({this.refresh = false});
}
