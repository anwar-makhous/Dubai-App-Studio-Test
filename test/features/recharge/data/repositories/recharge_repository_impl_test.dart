import 'package:dartz/dartz.dart';
import 'package:dubai_app_studio/features/recharge/data/models/history_item_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/core/usecases/send_amount_params.dart';
import 'package:dubai_app_studio/features/recharge/data/data_sources/recharge_data_source.dart';
import 'package:dubai_app_studio/features/recharge/data/repositories/recharge_repository_impl.dart';
import 'package:dubai_app_studio/features/recharge/domain/entities/history_item.dart';

import '../../../../mocks/mock_network_info.dart';
import 'recharge_repository_impl_test.mocks.dart';

@GenerateMocks([RechargeDataSource])
void main() {
  late RechargeRepositoryImpl repository;
  late MockRechargeDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  final tHistoryItemModel = HistoryItemModel(
    name: "Ali",
    phoneNumber: "551234567",
    amount: 50.00,
    date: DateTime(2024, 7, 1),
  );

  setUp(() {
    mockRemoteDataSource = MockRechargeDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = RechargeRepositoryImpl(
        remoteDataSource: mockRemoteDataSource, networkInfo: mockNetworkInfo);
  });

  group('getRechargeHistory', () {
    test(
        'should return Right<Failure, List<HistoryItem>> when network is connected and remote data source returns List<HistoryItem>',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getRechargeHistory())
          .thenAnswer((_) async => [tHistoryItemModel]);
      final result = await repository.getRechargeHistory();
      expect(result, isA<Right<Failure, List<HistoryItem>>>());
    });

    test('should return Left(NoInternetFailure) when network is not connected',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      final result = await repository.getRechargeHistory();
      expect(result, equals(const Left(NoInternetFailure())));
    });

    test(
        'should return Left(Failure) when remote data source throws an exception',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getRechargeHistory())
          .thenThrow(Exception('Error'));
      final result = await repository.getRechargeHistory();
      expect(result, isA<Left<Failure, List<HistoryItem>>>());
    });
  });

  group('sendAmount', () {
    final tParams = SendAmountParams(amount: 10.0, phoneNumber: '551234567');
    test(
        'should return Right(true) when network is connected and remote data source returns true',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.sendAmount(params: tParams))
          .thenAnswer((_) async => true);
      final result = await repository.sendAmount(params: tParams);
      expect(result, equals(const Right(true)));
    });

    test('should return Left(NoInternetFailure) when network is not connected',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      final result = await repository.sendAmount(params: tParams);
      expect(result, equals(const Left(NoInternetFailure())));
    });

    test(
        'should return Left(Failure) when remote data source throws an exception',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.sendAmount(params: tParams))
          .thenThrow(Exception('Error'));
      final result = await repository.sendAmount(params: tParams);
      expect(result, isA<Left<Failure, bool>>());
    });
  });
}
