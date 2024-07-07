import 'dart:async';

import 'package:dubai_app_studio/core/constants/app_constants.dart';
import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/features/account/domain/entities/account_info.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dubai_app_studio/core/usecases/send_amount_params.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/entities/beneficiary.dart';
import 'package:dubai_app_studio/features/recharge/domain/usecases/send_amount.dart';

part 'recharge_event.dart';
part 'recharge_state.dart';

class RechargeBloc extends Bloc<RechargeEvent, RechargeState> {
  final SendAmount sendAmount;

  RechargeBloc({required this.sendAmount}) : super(RechargeInitial()) {
    on<SendAmountEvent>(_onSendAmountEvent);
  }

  Future<void> _onSendAmountEvent(
      SendAmountEvent event, Emitter<RechargeState> emit) async {
    emit(RechargeLoading());

    final eitherResponse = await sendAmount.call(event.params);

    emit(
      eitherResponse.fold(
        (failure) => RechargeFailed(errorMessage: failure.errorMessage),
        (success) => success
            ? RechargeSuccess(
                phoneNumber: event.params.phoneNumber,
                amount: event.params.amount)
            : RechargeFailed(
                errorMessage: 'Failed to recharge ${event.params.phoneNumber}'),
      ),
    );
  }

  /// returns ok if the user can recharge, and returns error message otherwise
  String checkReachability({
    required Beneficiary beneficiary,
    required AccountInfo currentAccountInfo,
    required double rechargeAmount,
  }) {
    String message = "ok";

    // constants
    const double extraCharges = 1.0;
    const double maxTotalPerMonth = 3000.0;
    const double maxForVerified = 1000.0;
    const double maxForNonVerified = 500.0;

    // calculations
    double allowedBalance =
        maxTotalPerMonth - currentAccountInfo.totalTransactions;
    if (allowedBalance.isNegative) {
      allowedBalance = 0.0;
    }
    double totalAmount = rechargeAmount + extraCharges;

    // conditions
    if (totalAmount > currentAccountInfo.balance) {
      message = FailureMessages.error402;
      return message;
    }
    if (rechargeAmount > allowedBalance) {
      message =
          "Sorry, you cannot exceed ${AppConfig.numberFormat.format(maxTotalPerMonth)} ${AppConfig.currency} per month transactions, your remaining allowed balance to use is $allowedBalance, so you cannot recharge ${beneficiary.name} with $rechargeAmount right now.";
      return message;
    }
    if (beneficiary.isVerified &&
        (beneficiary.totalTransactions + rechargeAmount > maxForVerified)) {
      message =
          "Maximum total transactions per month for a verified beneficiary is ${AppConfig.numberFormat.format(maxForVerified)} ${AppConfig.currency}, and the total transactions currently for ${beneficiary.name} worth ${AppConfig.numberFormat.format(beneficiary.totalTransactions)} ${AppConfig.currency}, so you cannot recharge ${beneficiary.name} with $rechargeAmount right now.";
      return message;
    }
    if (!beneficiary.isVerified &&
        (beneficiary.totalTransactions + rechargeAmount > maxForNonVerified)) {
      message =
          "Maximum total transactions per month for a non-verified beneficiary is ${AppConfig.numberFormat.format(maxForNonVerified)} ${AppConfig.currency}, and the total transactions currently for ${beneficiary.name} worth ${AppConfig.numberFormat.format(beneficiary.totalTransactions)} ${AppConfig.currency}, so you cannot recharge ${beneficiary.name} with $rechargeAmount right now.";
      return message;
    }

    // can recharge
    return message;
  }
}
