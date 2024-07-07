import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:dubai_app_studio/core/usecases/add_beneficiary_params.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/repositories/beneficiary_repository.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/usecases/add_beneficiary.dart';

import 'add_beneficiary_test.mocks.dart';

@GenerateMocks([BeneficiaryRepository])
void main() {
  late AddBeneficiary usecase;
  late MockBeneficiaryRepository mockBeneficiaryRepository;

  setUp(() {
    mockBeneficiaryRepository = MockBeneficiaryRepository();
    usecase = AddBeneficiary(repository: mockBeneficiaryRepository);
  });

  final tParams = AddBeneficiaryParams(name: "James", phoneNumber: "551234567");
  const tResult = true;

  test('should add beneficiary to the repository', () async {
    // arrange
    when(mockBeneficiaryRepository.addBeneficiary(params: tParams))
        .thenAnswer((_) async => const Right(tResult));
    // act
    final result = await usecase(tParams);
    // assert
    expect(result, const Right(tResult));
    verify(mockBeneficiaryRepository.addBeneficiary(params: tParams));
    verifyNoMoreInteractions(mockBeneficiaryRepository);
  });
}
