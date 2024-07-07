part of 'account_bloc.dart';

sealed class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

final class AccountInitial extends AccountState {}

final class AccountLoading extends AccountState {}

final class AccountFailed extends AccountState {
  final String errorMessage;
  const AccountFailed({required this.errorMessage});
}

final class AccountLoaded extends AccountState {
  final AccountInfo currentAccountInfo;
  const AccountLoaded({required this.currentAccountInfo});
}
