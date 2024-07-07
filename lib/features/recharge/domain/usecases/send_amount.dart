import 'package:dartz/dartz.dart';
import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/core/usecases/send_amount_params.dart';
import 'package:dubai_app_studio/core/usecases/usecase.dart';
import 'package:dubai_app_studio/features/recharge/domain/repositories/recharge_repository.dart';

class SendAmount extends UseCase<bool, SendAmountParams> {
  final RechargeRepository repository;

  SendAmount({required this.repository});

  @override
  Future<Either<Failure, bool>> call(SendAmountParams params) async {
    return await repository.sendAmount(params: params);
  }
}
