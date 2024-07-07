import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:dubai_app_studio/core/usecases/delete_beneficiary_params.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/repositories/beneficiary_repository.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/usecases/delete_beneficiary.dart';

import 'delete_beneficiary_test.mocks.dart';

@GenerateMocks([BeneficiaryRepository])
void main() {
  late DeleteBeneficiary usecase;
  late MockBeneficiaryRepository mockBeneficiaryRepository;

  setUp(() {
    mockBeneficiaryRepository = MockBeneficiaryRepository();
    usecase = DeleteBeneficiary(repository: mockBeneficiaryRepository);
  });

  final tParams = DeleteBeneficiaryParams(phoneNumber: "551234567");
  const tResult = true;

  test('should delete beneficiary from the repository', () async {
    // arrange
    when(mockBeneficiaryRepository.deleteBeneficiary(params: tParams))
        .thenAnswer((_) async => const Right(tResult));
    // act
    final result = await usecase(tParams);
    // assert
    expect(result, const Right(tResult));
    verify(mockBeneficiaryRepository.deleteBeneficiary(params: tParams));
    verifyNoMoreInteractions(mockBeneficiaryRepository);
  });
}
