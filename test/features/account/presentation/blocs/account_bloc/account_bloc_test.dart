import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/features/account/domain/entities/account_info.dart';
import 'package:dubai_app_studio/features/account/domain/usecases/get_account_info.dart';
import 'package:dubai_app_studio/features/account/presentation/blocs/account_bloc/account_bloc.dart';

import 'account_bloc_test.mocks.dart';

@GenerateMocks([GetAccountInfo])
void main() {
  late AccountBloc bloc;
  late MockGetAccountInfo mockGetAccountInfo;

  setUp(() {
    mockGetAccountInfo = MockGetAccountInfo();
    bloc = AccountBloc(getAccountInfo: mockGetAccountInfo);
  });

  blocTest<AccountBloc, AccountState>(
    'emits [AccountLoading, AccountLoaded] when GetAccountInfoEvent is added.',
    build: () => bloc,
    act: (bloc) {
      when(mockGetAccountInfo.call(any)).thenAnswer((_) async =>
          const Right(AccountInfo(balance: 10, totalTransactions: 5)));
      bloc.add(GetAccountInfoEvent());
    },
    expect: () => <AccountState>[
      AccountLoading(),
      const AccountLoaded(
          currentAccountInfo: AccountInfo(balance: 10, totalTransactions: 5)),
    ],
  );

  blocTest<AccountBloc, AccountState>(
    'emits [AccountLoading, AccountFailed] when GetAccountInfoEvent is added and GetAccountInfo fails.',
    build: () => bloc,
    act: (bloc) {
      when(mockGetAccountInfo.call(any))
          .thenAnswer((_) async => const Left(UnknownFailure()));
      bloc.add(GetAccountInfoEvent());
    },
    expect: () => <AccountState>[
      AccountLoading(),
      const AccountFailed(errorMessage: FailureMessages.unknown),
    ],
  );
}
