import 'package:dartz/dartz.dart';
import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/features/home/domain/entities/balance.dart';
import 'package:dubai_app_studio/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<Either<Failure, Balance>> getBalance() {
    // TODO: implement getBalance
    throw UnimplementedError();
  }
}
