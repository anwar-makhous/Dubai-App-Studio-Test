import 'package:dartz/dartz.dart';
import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/core/usecases/usecase.dart';
import 'package:dubai_app_studio/features/account/domain/entities/account_info.dart';
import 'package:dubai_app_studio/features/account/domain/repositories/account_repository.dart';

class GetAccountInfo extends UseCase<AccountInfo, NoParams> {
  final AccountRepository repository;

  GetAccountInfo({required this.repository});

  @override
  Future<Either<Failure, AccountInfo>> call(NoParams params) async {
    return await repository.getAccountInfo();
  }
}
