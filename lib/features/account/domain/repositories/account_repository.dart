import 'package:dartz/dartz.dart';
import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/features/account/domain/entities/account_info.dart';

abstract class AccountRepository {
  Future<Either<Failure, AccountInfo>> getAccountInfo();
}
