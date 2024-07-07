import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:dubai_app_studio/core/usecases/usecase.dart';
import 'package:dubai_app_studio/features/account/domain/entities/account_info.dart';
import 'package:dubai_app_studio/features/account/domain/repositories/account_repository.dart';
import 'package:dubai_app_studio/features/account/domain/usecases/get_account_info.dart';

import 'get_account_info_test.mocks.dart';

@GenerateMocks([AccountRepository])
void main() {
  late GetAccountInfo usecase;
  late MockAccountRepository mockAccountRepository;

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    usecase = GetAccountInfo(repository: mockAccountRepository);
  });

  const tAccountInfo = AccountInfo(balance: 1000.00, totalTransactions: 25.00);

  test('should get account info from the repository', () async {
    // arrange
    when(mockAccountRepository.getAccountInfo())
        .thenAnswer((_) async => const Right(tAccountInfo));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, const Right(tAccountInfo));
    verify(mockAccountRepository.getAccountInfo());
    verifyNoMoreInteractions(mockAccountRepository);
  });
}
