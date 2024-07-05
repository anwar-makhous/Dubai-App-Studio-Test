import 'package:dartz/dartz.dart';
import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/features/home/domain/entities/balance.dart';

abstract class HomeRepository {
  Future<Either<Failure, Balance>> getBalance();
}
