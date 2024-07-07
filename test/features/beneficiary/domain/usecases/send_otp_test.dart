import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:dubai_app_studio/core/usecases/send_otp_params.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/repositories/beneficiary_repository.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/usecases/send_otp.dart';

import 'send_otp_test.mocks.dart';

@GenerateMocks([BeneficiaryRepository])
void main() {
  late SendOtp usecase;
  late MockBeneficiaryRepository mockBeneficiaryRepository;

  setUp(() {
    mockBeneficiaryRepository = MockBeneficiaryRepository();
    usecase = SendOtp(repository: mockBeneficiaryRepository);
  });

  final tParams = SendOtpParams(phoneNumber: "557676767");
  const tResult = true;

  test('should send otp to the repository', () async {
    // arrange
    when(mockBeneficiaryRepository.sendOtp(params: tParams))
        .thenAnswer((_) async => const Right(tResult));
    // act
    final result = await usecase(tParams);
    // assert
    expect(result, const Right(tResult));
    verify(mockBeneficiaryRepository.sendOtp(params: tParams));
    verifyNoMoreInteractions(mockBeneficiaryRepository);
  });
}
