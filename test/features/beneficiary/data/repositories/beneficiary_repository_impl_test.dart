import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/core/usecases/add_beneficiary_params.dart';
import 'package:dubai_app_studio/core/usecases/delete_beneficiary_params.dart';
import 'package:dubai_app_studio/core/usecases/send_otp_params.dart';
import 'package:dubai_app_studio/core/usecases/verify_otp_params.dart';
import 'package:dubai_app_studio/features/beneficiary/data/data_sources/beneficiary_data_source.dart';
import 'package:dubai_app_studio/features/beneficiary/data/models/beneficiary_model.dart';
import 'package:dubai_app_studio/features/beneficiary/data/repositories/beneficiary_repository_impl.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/entities/beneficiary.dart';

import '../../../../mocks/mock_network_info.dart';
import 'beneficiary_repository_impl_test.mocks.dart';

@GenerateMocks([BeneficiaryDataSource])
void main() {
  late BeneficiaryRepositoryImpl repository;
  late MockBeneficiaryDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  const BeneficiaryModel tBeneficiaryModel = BeneficiaryModel(
    name: "Ali",
    phoneNumber: "551234567",
    isVerified: true,
    totalTransactions: 75.00,
  );

  setUp(() {
    mockRemoteDataSource = MockBeneficiaryDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = BeneficiaryRepositoryImpl(
        networkInfo: mockNetworkInfo, remoteDataSource: mockRemoteDataSource);
  });

  group('addBeneficiary', () {
    final tParams = AddBeneficiaryParams(name: "Ali", phoneNumber: "551234567");
    test(
        'should return Right(true) when network is connected and remote data source returns true',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.addBeneficiary(params: tParams))
          .thenAnswer((_) async => true);
      final result = await repository.addBeneficiary(params: tParams);
      expect(result, equals(const Right(true)));
    });

    test('should return Left(NoInternetFailure) when network is not connected',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      final result = await repository.addBeneficiary(params: tParams);
      expect(result, equals(const Left(NoInternetFailure())));
    });

    test(
        'should return Left(Failure) when remote data source throws an exception',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.addBeneficiary(params: tParams))
          .thenThrow(Exception('Error'));
      final result = await repository.addBeneficiary(params: tParams);
      expect(result, isA<Left<Failure, bool>>());
    });
  });

  group('getBeneficiaries', () {
    test(
        'should return Right<Failure, List<Beneficiary>> when network is connected and remote data source returns List<Beneficiary>',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getBeneficiaries())
          .thenAnswer((_) async => [tBeneficiaryModel]);
      final result = await repository.getBeneficiaries();
      expect(result, isA<Right<Failure, List<Beneficiary>>>());
    });

    test('should return Left(NoInternetFailure) when network is not connected',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      final result = await repository.getBeneficiaries();
      expect(result, equals(const Left(NoInternetFailure())));
    });

    test(
        'should return Left(Failure) when remote data source throws an exception',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getBeneficiaries())
          .thenThrow(Exception('Error'));
      final result = await repository.getBeneficiaries();
      expect(result, isA<Left<Failure, List<Beneficiary>>>());
    });
  });

  group('sendOtp', () {
    final tParams = SendOtpParams(phoneNumber: "551234567");
    test(
        'should return Right(true) when network is connected and remote data source returns true',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.sendOtp(params: tParams))
          .thenAnswer((_) async => true);
      final result = await repository.sendOtp(params: tParams);
      expect(result, equals(const Right(true)));
    });

    test('should return Left(NoInternetFailure) when network is not connected',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      final result = await repository.sendOtp(params: tParams);
      expect(result, equals(const Left(NoInternetFailure())));
    });

    test(
        'should return Left(Failure) when remote data source throws an exception',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.sendOtp(params: tParams))
          .thenThrow(Exception('Error'));
      final result = await repository.sendOtp(params: tParams);
      expect(result, isA<Left<Failure, bool>>());
    });
  });

  group('verifyOtp', () {
    final tParams = VerifyOtpParams(
      phoneNumber: "551234567",
      otp: "0000",
    );

    test(
        'should return Right(true) when network is connected and remote data source returns true',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.verifyOtp(params: tParams))
          .thenAnswer((_) async => true);
      final result = await repository.verifyOtp(params: tParams);
      expect(result, equals(const Right(true)));
    });

    test('should return Left(NoInternetFailure) when network is not connected',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      final result = await repository.verifyOtp(params: tParams);
      expect(result, equals(const Left(NoInternetFailure())));
    });

    test(
        'should return Left(Failure) when remote data source throws an exception',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.verifyOtp(params: tParams))
          .thenThrow(Exception('Error'));
      final result = await repository.verifyOtp(params: tParams);
      expect(result, isA<Left<Failure, bool>>());
    });
  });

  group('deleteBeneficiary', () {
    final tParams = DeleteBeneficiaryParams(phoneNumber: "551234567");

    test(
        'should return Right(true) when network is connected and remote data source returns true',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.deleteBeneficiary(params: tParams))
          .thenAnswer((_) async => true);
      final result = await repository.deleteBeneficiary(params: tParams);
      expect(result, equals(const Right(true)));
    });

    test('should return Left(NoInternetFailure) when network is not connected',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      final result = await repository.deleteBeneficiary(params: tParams);
      expect(result, equals(const Left(NoInternetFailure())));
    });

    test(
        'should return Left(Failure) when remote data source throws an exception',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.deleteBeneficiary(params: tParams))
          .thenThrow(Exception('Error'));
      final result = await repository.deleteBeneficiary(params: tParams);
      expect(result, isA<Left<Failure, bool>>());
    });
  });
}
