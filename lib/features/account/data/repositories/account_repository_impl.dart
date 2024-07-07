import 'package:dartz/dartz.dart';
import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/core/network/network_info.dart';
import 'package:dubai_app_studio/features/account/data/data_sources/account_data_source.dart';
import 'package:dubai_app_studio/features/account/domain/entities/account_info.dart';
import 'package:dubai_app_studio/features/account/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AccountRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, AccountInfo>> getAccountInfo() async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.getAccountInfo());
      } on Exception catch (e) {
        return Left(Failure.fromException(e));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }
}
