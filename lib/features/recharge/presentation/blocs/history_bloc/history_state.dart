part of 'history_bloc.dart';

sealed class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

final class HistoryInitial extends HistoryState {}

final class HistoryLoading extends HistoryState {}

final class HistoryFailed extends HistoryState {
  final String errorMessage;
  const HistoryFailed({required this.errorMessage});
}

final class HistoryLoaded extends HistoryState {
  final List<HistoryItem> history;
  const HistoryLoaded({required this.history});
}
