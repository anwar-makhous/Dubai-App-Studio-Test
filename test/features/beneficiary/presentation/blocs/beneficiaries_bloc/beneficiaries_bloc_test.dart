import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/core/usecases/add_beneficiary_params.dart';
import 'package:dubai_app_studio/core/usecases/delete_beneficiary_params.dart';
import 'package:dubai_app_studio/core/usecases/send_otp_params.dart';
import 'package:dubai_app_studio/core/usecases/verify_otp_params.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/entities/beneficiary.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/usecases/add_beneficiary.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/usecases/delete_beneficiary.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/usecases/get_beneficiaries.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/usecases/send_otp.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/usecases/verify_otp.dart';
import 'package:dubai_app_studio/features/beneficiary/presentation/blocs/beneficiaries_bloc/beneficiaries_bloc.dart';

import 'beneficiaries_bloc_test.mocks.dart';

@GenerateMocks([
  AddBeneficiary,
  DeleteBeneficiary,
  SendOtp,
  VerifyOtp,
  GetBeneficiaries,
])
void main() {
  late BeneficiariesBloc bloc;
  late MockAddBeneficiary mockAddBeneficiary;
  late MockDeleteBeneficiary mockDeleteBeneficiary;
  late MockSendOtp mockSendOtp;
  late MockVerifyOtp mockVerifyOtp;
  late MockGetBeneficiaries mockGetBeneficiaries;

  const tBeneficiaries = [
    Beneficiary(
      name: 'John Doe',
      phoneNumber: '1234567890',
      isVerified: true,
      totalTransactions: 75.0,
    ),
    Beneficiary(
      name: 'Sarah Johnson',
      phoneNumber: '551231237',
      isVerified: true,
      totalTransactions: 100.0,
    ),
  ];

  setUp(() {
    mockAddBeneficiary = MockAddBeneficiary();
    mockDeleteBeneficiary = MockDeleteBeneficiary();
    mockSendOtp = MockSendOtp();
    mockVerifyOtp = MockVerifyOtp();
    mockGetBeneficiaries = MockGetBeneficiaries();
    bloc = BeneficiariesBloc(
      addBeneficiary: mockAddBeneficiary,
      deleteBeneficiary: mockDeleteBeneficiary,
      sendOtp: mockSendOtp,
      verifyOtp: mockVerifyOtp,
      getBeneficiaries: mockGetBeneficiaries,
    );
  });

  blocTest<BeneficiariesBloc, BeneficiariesState>(
    'emits [AddingBeneficiary, AddBeneficiaryCompleted, BeneficiariesLoading, BeneficiariesLoaded] when AddBeneficiaryEvent is added.',
    build: () => bloc,
    act: (bloc) {
      when(mockAddBeneficiary.call(any))
          .thenAnswer((_) async => const Right(true));
      when(mockGetBeneficiaries.call(any))
          .thenAnswer((_) async => const Right(tBeneficiaries));
      bloc.add(AddBeneficiaryEvent(
        params: AddBeneficiaryParams(
          name: 'John Doe',
          phoneNumber: '1234567890',
        ),
      ));
    },
    expect: () => <BeneficiariesState>[
      AddingBeneficiary(),
      AddBeneficiaryCompleted(),
      BeneficiariesLoading(),
      const BeneficiariesLoaded(beneficiaries: tBeneficiaries),
    ],
  );

  blocTest<BeneficiariesBloc, BeneficiariesState>(
    'emits [AddingBeneficiary, AddBeneficiaryFailed, BeneficiariesLoaded] when AddBeneficiaryEvent is added and AddBeneficiary fails.',
    build: () => bloc,
    act: (bloc) {
      when(mockAddBeneficiary(any))
          .thenAnswer((_) async => const Left(UnknownFailure()));
      bloc.add(AddBeneficiaryEvent(
        params: AddBeneficiaryParams(
          name: 'John Doe',
          phoneNumber: '1234567890',
        ),
      ));
    },
    expect: () => <BeneficiariesState>[
      AddingBeneficiary(),
      const AddBeneficiaryFailed(errorMessage: FailureMessages.unknown),
      const BeneficiariesLoaded(beneficiaries: tBeneficiaries),
    ],
  );

  blocTest<BeneficiariesBloc, BeneficiariesState>(
    'emits [DeletingBeneficiary, DeleteBeneficiaryCompleted, BeneficiariesLoading, BeneficiariesLoaded] when DeleteBeneficiaryEvent is added.',
    build: () => bloc,
    act: (bloc) {
      when(mockDeleteBeneficiary(any))
          .thenAnswer((_) async => const Right(true));
      when(mockGetBeneficiaries.call(any))
          .thenAnswer((_) async => const Right(tBeneficiaries));
      bloc.add(DeleteBeneficiaryEvent(
        params: DeleteBeneficiaryParams(phoneNumber: "551234567"),
      ));
    },
    expect: () => <BeneficiariesState>[
      DeletingBeneficiary(),
      DeleteBeneficiaryCompleted(),
      BeneficiariesLoading(),
      const BeneficiariesLoaded(beneficiaries: tBeneficiaries),
    ],
  );

  blocTest<BeneficiariesBloc, BeneficiariesState>(
    'emits [SendingOtp, SendOtpCompleted, BeneficiariesLoaded] when SendOtpEvent is added.',
    build: () => bloc,
    act: (bloc) {
      when(mockSendOtp(any)).thenAnswer((_) async => const Right(true));
      bloc.add(SendOtpEvent(
        params: SendOtpParams(
          phoneNumber: '1234567890',
        ),
      ));
    },
    expect: () => <BeneficiariesState>[
      SendingOtp(),
      SendOtpCompleted(),
      const BeneficiariesLoaded(beneficiaries: tBeneficiaries),
    ],
  );

  blocTest<BeneficiariesBloc, BeneficiariesState>(
    'emits [VerifyingOtp, VerifyOtpCompleted, BeneficiariesLoaded] when VerifyOtpEvent is added.',
    build: () => bloc,
    act: (bloc) {
      when(mockVerifyOtp(any)).thenAnswer((_) async => const Right(true));
      bloc.add(VerifyOtpEvent(
        params: VerifyOtpParams(phoneNumber: '551234567', otp: '0000'),
      ));
    },
    expect: () => <BeneficiariesState>[
      VerifyingOtp(),
      VerifyOtpCompleted(),
      const BeneficiariesLoaded(beneficiaries: tBeneficiaries),
    ],
  );

  blocTest<BeneficiariesBloc, BeneficiariesState>(
    'emits [BeneficiariesLoading, BeneficiariesLoaded] when GetBeneficiariesEvent is added.',
    build: () => bloc,
    act: (bloc) {
      when(mockGetBeneficiaries(any))
          .thenAnswer((_) async => const Right(tBeneficiaries));
      bloc.add(const GetBeneficiariesEvent(refresh: true));
    },
    expect: () => <BeneficiariesState>[
      BeneficiariesLoading(),
      const BeneficiariesLoaded(beneficiaries: tBeneficiaries),
    ],
  );
}
