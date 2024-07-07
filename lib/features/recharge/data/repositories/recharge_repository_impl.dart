import 'package:dartz/dartz.dart';
import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/core/network/network_info.dart';
import 'package:dubai_app_studio/core/usecases/send_amount_params.dart';
import 'package:dubai_app_studio/features/recharge/data/data_sources/recharge_data_source.dart';
import 'package:dubai_app_studio/features/recharge/domain/entities/history_item.dart';
import 'package:dubai_app_studio/features/recharge/domain/repositories/recharge_repository.dart';

class RechargeRepositoryImpl implements RechargeRepository {
  final RechargeDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RechargeRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<HistoryItem>>> getRechargeHistory() async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.getRechargeHistory());
      } on Exception catch (e) {
        return Left(Failure.fromException(e));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> sendAmount(
      {required SendAmountParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.sendAmount(params: params));
      } on Exception catch (e) {
        return Left(Failure.fromException(e));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }
}
