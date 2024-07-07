import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/core/usecases/send_amount_params.dart';
import 'package:dubai_app_studio/features/account/domain/entities/account_info.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/entities/beneficiary.dart';
import 'package:dubai_app_studio/features/recharge/domain/usecases/send_amount.dart';
import 'package:dubai_app_studio/features/recharge/presentation/blocs/recharge_bloc/recharge_bloc.dart';

import 'recharge_bloc_test.mocks.dart';

@GenerateMocks([
  SendAmount,
])
void main() {
  late RechargeBloc bloc;
  late MockSendAmount mockSendAmount;

  setUp(() {
    mockSendAmount = MockSendAmount();
    bloc = RechargeBloc(sendAmount: mockSendAmount);
  });

  blocTest<RechargeBloc, RechargeState>(
    'emits [RechargeLoading, RechargeSuccess] when SendAmountEvent is added and SendAmount succeeds.',
    build: () => bloc,
    act: (bloc) {
      when(mockSendAmount.call(any)).thenAnswer((_) async => const Right(true));
      bloc.add(SendAmountEvent(
        params: SendAmountParams(phoneNumber: "556677123", amount: 10.00),
      ));
    },
    expect: () => <RechargeState>[
      RechargeLoading(),
      const RechargeSuccess(phoneNumber: "556677123", amount: 10.00),
    ],
  );

  blocTest<RechargeBloc, RechargeState>(
    'emits [RechargeLoading, RechargeFailed] when SendAmountEvent is added and SendAmount fails.',
    build: () => bloc,
    act: (bloc) {
      when(mockSendAmount.call(any))
          .thenAnswer((_) async => const Left(UnknownFailure()));
      bloc.add(SendAmountEvent(
        params: SendAmountParams(
          phoneNumber: '1234567890',
          amount: 100.0,
        ),
      ));
    },
    expect: () => <RechargeState>[
      RechargeLoading(),
      const RechargeFailed(errorMessage: FailureMessages.unknown),
    ],
  );

  group(
    'checkReachability',
    () {
      test(
          'checkReachability returns ok when recharge is allowed for verified beneficiary',
          () {
        const beneficiary = Beneficiary(
          name: 'John Doe',
          phoneNumber: '1234567890',
          isVerified: true,
          totalTransactions: 600.0,
        );
        const currentAccountInfo = AccountInfo(
          balance: 2000.0,
          totalTransactions: 2000.0,
        );
        const rechargeAmount = 100.0;

        final result = bloc.checkReachability(
          beneficiary: beneficiary,
          currentAccountInfo: currentAccountInfo,
          rechargeAmount: rechargeAmount,
        );

        expect(result, 'ok');
      });

      test(
          'checkReachability returns error when recharge exceeds limit for verified beneficiary',
          () {
        const beneficiary = Beneficiary(
          name: 'John Doe',
          phoneNumber: '1234567890',
          isVerified: true,
          totalTransactions: 950.0,
        );
        const currentAccountInfo = AccountInfo(
          balance: 2000.0,
          totalTransactions: 50.0,
        );
        const rechargeAmount = 75.0;

        final result = bloc.checkReachability(
          beneficiary: beneficiary,
          currentAccountInfo: currentAccountInfo,
          rechargeAmount: rechargeAmount,
        );

        expect(result, isNot('ok'));
      });

      test(
          'checkReachability returns ok when recharge is allowed for non-verified beneficiary',
          () {
        const beneficiary = Beneficiary(
          name: 'John Doe',
          phoneNumber: '1234567890',
          isVerified: false,
          totalTransactions: 450.0,
        );
        const currentAccountInfo = AccountInfo(
          balance: 1000.0,
          totalTransactions: 2000.0,
        );
        const rechargeAmount = 10.0;

        final result = bloc.checkReachability(
          beneficiary: beneficiary,
          currentAccountInfo: currentAccountInfo,
          rechargeAmount: rechargeAmount,
        );

        expect(result, 'ok');
      });

      test(
          'checkReachability returns error when recharge exceeds limit for non-verified beneficiary',
          () {
        const beneficiary = Beneficiary(
          name: 'John Doe',
          phoneNumber: '1234567890',
          isVerified: false,
          totalTransactions: 450.0,
        );
        const currentAccountInfo = AccountInfo(
          balance: 1000.0,
          totalTransactions: 2000.0,
        );
        const rechargeAmount = 75.0;

        final result = bloc.checkReachability(
          beneficiary: beneficiary,
          currentAccountInfo: currentAccountInfo,
          rechargeAmount: rechargeAmount,
        );

        expect(result, isNot('ok'));
      });

      test(
          'checkReachability returns error when total transactions exceed monthly limit',
          () {
        const beneficiary = Beneficiary(
          name: 'John Doe',
          phoneNumber: '1234567890',
          isVerified: true,
          totalTransactions: 0.0,
        );
        const currentAccountInfo = AccountInfo(
          balance: 1000.0,
          totalTransactions: 2995.0,
        );
        const rechargeAmount = 10.0;

        final result = bloc.checkReachability(
          beneficiary: beneficiary,
          currentAccountInfo: currentAccountInfo,
          rechargeAmount: rechargeAmount,
        );

        expect(result, isNot('ok'));
      });

      test(
          'checkReachability returns error when recharge amount exceeds balance',
          () {
        const beneficiary = Beneficiary(
          name: 'John Doe',
          phoneNumber: '1234567890',
          isVerified: true,
          totalTransactions: 620.0,
        );
        const currentAccountInfo = AccountInfo(
          balance: 20.0,
          totalTransactions: 8000.0,
        );
        const rechargeAmount = 30.0;

        final result = bloc.checkReachability(
          beneficiary: beneficiary,
          currentAccountInfo: currentAccountInfo,
          rechargeAmount: rechargeAmount,
        );

        expect(result, isNot('ok'));
      });
    },
  );
}
