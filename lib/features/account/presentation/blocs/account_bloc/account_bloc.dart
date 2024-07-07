import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dubai_app_studio/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

import 'package:dubai_app_studio/features/account/domain/entities/account_info.dart';
import 'package:dubai_app_studio/features/account/domain/usecases/get_account_info.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final GetAccountInfo getAccountInfo;

  AccountInfo currentAccountInfo =
      const AccountInfo(balance: 0, totalTransactions: 0);

  AccountBloc({required this.getAccountInfo}) : super(AccountInitial()) {
    on<GetAccountInfoEvent>(_onGetAccountInfoEvent);
  }

  FutureOr<void> _onGetAccountInfoEvent(
      GetAccountInfoEvent event, Emitter<AccountState> emit) async {
    emit(AccountLoading());

    final eitherResponse = await getAccountInfo.call(NoParams());

    emit(
      eitherResponse.fold(
        (failure) => AccountFailed(errorMessage: failure.errorMessage),
        (newBalance) {
          currentAccountInfo = newBalance;
          return AccountLoaded(currentAccountInfo: newBalance);
        },
      ),
    );
  }
}
