import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:dubai_app_studio/core/usecases/usecase.dart';
import 'package:dubai_app_studio/features/recharge/domain/entities/history_item.dart';
import 'package:dubai_app_studio/features/recharge/domain/repositories/recharge_repository.dart';
import 'package:dubai_app_studio/features/recharge/domain/usecases/get_recharge_history.dart';

import 'get_recharge_history_test.mocks.dart';

@GenerateMocks([RechargeRepository])
void main() {
  late GetRechargeHistory usecase;
  late MockRechargeRepository mockRechargeRepository;

  setUp(() {
    mockRechargeRepository = MockRechargeRepository();
    usecase = GetRechargeHistory(repository: mockRechargeRepository);
  });

  final tHistoryItems = [
    HistoryItem(
      name: "Sarah",
      phoneNumber: "551231237",
      amount: 50.00,
      date: DateTime(24, 6, 15),
    ),
    HistoryItem(
      name: "James",
      phoneNumber: "557654321",
      amount: 25.00,
      date: DateTime(24, 6, 17),
    ),
    HistoryItem(
      name: "Sarah",
      phoneNumber: "551231237",
      amount: 100.00,
      date: DateTime(24, 6, 19),
    ),
  ];

  test('should get recharge history from the repository', () async {
    // arrange
    when(mockRechargeRepository.getRechargeHistory())
        .thenAnswer((_) async => Right(tHistoryItems));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, Right(tHistoryItems));
    verify(mockRechargeRepository.getRechargeHistory());
    verifyNoMoreInteractions(mockRechargeRepository);
  });
}
