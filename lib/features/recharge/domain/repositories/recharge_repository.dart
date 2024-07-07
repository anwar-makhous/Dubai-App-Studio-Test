import 'package:dartz/dartz.dart';
import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/core/usecases/send_amount_params.dart';
import 'package:dubai_app_studio/features/recharge/domain/entities/history_item.dart';

abstract class RechargeRepository {
  Future<Either<Failure, List<HistoryItem>>> getRechargeHistory();
  Future<Either<Failure, bool>> sendAmount({required SendAmountParams params});
}
