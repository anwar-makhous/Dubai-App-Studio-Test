import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:dubai_app_studio/core/usecases/usecase.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/entities/beneficiary.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/repositories/beneficiary_repository.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/usecases/get_beneficiaries.dart';

import 'get_beneficiaries_test.mocks.dart';

@GenerateMocks([BeneficiaryRepository])
void main() {
  late GetBeneficiaries usecase;
  late MockBeneficiaryRepository mockBeneficiaryRepository;

  setUp(() {
    mockBeneficiaryRepository = MockBeneficiaryRepository();
    usecase = GetBeneficiaries(repository: mockBeneficiaryRepository);
  });

  const tBeneficiaries = [
    Beneficiary(
      name: "Sarah",
      phoneNumber: "557777777",
      isVerified: true,
      totalTransactions: 75.00,
    ),
    Beneficiary(
      name: "James",
      phoneNumber: "551234567",
      isVerified: true,
      totalTransactions: 75.00,
    ),
  ];

  test('should get beneficiaries from the repository', () async {
    // arrange
    when(mockBeneficiaryRepository.getBeneficiaries())
        .thenAnswer((_) async => const Right(tBeneficiaries));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, const Right(tBeneficiaries));
    verify(mockBeneficiaryRepository.getBeneficiaries());
    verifyNoMoreInteractions(mockBeneficiaryRepository);
  });
}
