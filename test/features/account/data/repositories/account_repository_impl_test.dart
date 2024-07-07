import 'package:dartz/dartz.dart';
import 'package:dubai_app_studio/features/account/data/models/account_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/features/account/data/data_sources/account_data_source.dart';
import 'package:dubai_app_studio/features/account/data/repositories/account_repository_impl.dart';
import 'package:dubai_app_studio/features/account/domain/entities/account_info.dart';

import '../../../../mocks/mock_network_info.dart';
import 'account_repository_impl_test.mocks.dart';

@GenerateMocks([AccountDataSource])
void main() {
  late AccountRepositoryImpl repository;
  late MockAccountDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockAccountDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = AccountRepositoryImpl(
        remoteDataSource: mockRemoteDataSource, networkInfo: mockNetworkInfo);
  });

  group('getAccountInfo', () {
    const tAccountInfoModel =
        AccountInfoModel(balance: 1000.00, totalTransactions: 50.00);
    test(
        'should return Right(AccountInfo) when network is connected and remote data source returns AccountInfo',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getAccountInfo())
          .thenAnswer((_) async => tAccountInfoModel);
      final result = await repository.getAccountInfo();
      expect(result, isA<Right<Failure, AccountInfo>>());
    });

    test('should return Left(NoInternetFailure) when network is not connected',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      final result = await repository.getAccountInfo();
      expect(result, equals(const Left(NoInternetFailure())));
    });

    test(
        'should return Left(Failure) when remote data source throws an exception',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getAccountInfo()).thenThrow(Exception('Error'));
      final result = await repository.getAccountInfo();
      expect(result, isA<Left<Failure, AccountInfo>>());
    });
  });
}
