import 'package:dartz/dartz.dart';
import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/core/usecases/send_otp_params.dart';
import 'package:dubai_app_studio/core/usecases/usecase.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/repositories/beneficiary_repository.dart';

class SendOtp extends UseCase<bool, SendOtpParams> {
  final BeneficiaryRepository repository;

  SendOtp({required this.repository});

  @override
  Future<Either<Failure, bool>> call(SendOtpParams params) async {
    return await repository.sendOtp(params: params);
  }
}
