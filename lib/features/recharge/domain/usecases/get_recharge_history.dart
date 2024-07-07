import 'package:dartz/dartz.dart';
import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/core/usecases/usecase.dart';
import 'package:dubai_app_studio/features/recharge/domain/entities/history_item.dart';
import 'package:dubai_app_studio/features/recharge/domain/repositories/recharge_repository.dart';

class GetRechargeHistory extends UseCase<List<HistoryItem>, NoParams> {
  final RechargeRepository repository;

  GetRechargeHistory({required this.repository});

  @override
  Future<Either<Failure, List<HistoryItem>>> call(NoParams params) async {
    return await repository.getRechargeHistory();
  }
}
