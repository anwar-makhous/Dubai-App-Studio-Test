import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:dubai_app_studio/core/usecases/verify_otp_params.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/repositories/beneficiary_repository.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/usecases/verify_otp.dart';

import 'verify_otp_test.mocks.dart';

@GenerateMocks([BeneficiaryRepository])
void main() {
  late VerifyOtp usecase;
  late MockBeneficiaryRepository mockBeneficiaryRepository;

  setUp(() {
    mockBeneficiaryRepository = MockBeneficiaryRepository();
    usecase = VerifyOtp(repository: mockBeneficiaryRepository);
  });

  final tParams = VerifyOtpParams(phoneNumber: "551231237", otp: "0000");
  const tResult = true;

  test('should verify otp with the repository', () async {
    // arrange
    when(mockBeneficiaryRepository.verifyOtp(params: tParams))
        .thenAnswer((_) async => const Right(tResult));
    // act
    final result = await usecase(tParams);
    // assert
    expect(result, const Right(tResult));
    verify(mockBeneficiaryRepository.verifyOtp(params: tParams));
    verifyNoMoreInteractions(mockBeneficiaryRepository);
  });
}
