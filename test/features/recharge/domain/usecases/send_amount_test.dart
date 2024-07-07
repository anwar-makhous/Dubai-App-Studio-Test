import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:dubai_app_studio/core/usecases/send_amount_params.dart';
import 'package:dubai_app_studio/features/recharge/domain/repositories/recharge_repository.dart';
import 'package:dubai_app_studio/features/recharge/domain/usecases/send_amount.dart';

import 'send_amount_test.mocks.dart';

@GenerateMocks([RechargeRepository])
void main() {
  late SendAmount usecase;
  late MockRechargeRepository mockRechargeRepository;

  setUp(() {
    mockRechargeRepository = MockRechargeRepository();
    usecase = SendAmount(repository: mockRechargeRepository);
  });

  final tParams = SendAmountParams(phoneNumber: "551231237", amount: 30.00);
  const tResult = true;

  test('should send amount to the repository', () async {
    // arrange
    when(mockRechargeRepository.sendAmount(params: tParams))
        .thenAnswer((_) async => const Right(tResult));
    // act
    final result = await usecase(tParams);
    // assert
    expect(result, const Right(tResult));
    verify(mockRechargeRepository.sendAmount(params: tParams));
    verifyNoMoreInteractions(mockRechargeRepository);
  });
}
