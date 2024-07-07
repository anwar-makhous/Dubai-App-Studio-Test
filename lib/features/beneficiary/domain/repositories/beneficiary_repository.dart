import 'package:dartz/dartz.dart';
import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/core/usecases/add_beneficiary_params.dart';
import 'package:dubai_app_studio/core/usecases/delete_beneficiary_params.dart';
import 'package:dubai_app_studio/core/usecases/send_otp_params.dart';
import 'package:dubai_app_studio/core/usecases/verify_otp_params.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/entities/beneficiary.dart';

abstract class BeneficiaryRepository {
  Future<Either<Failure, bool>> addBeneficiary(
      {required AddBeneficiaryParams params});
  Future<Either<Failure, bool>> deleteBeneficiary(
      {required DeleteBeneficiaryParams params});
  Future<Either<Failure, List<Beneficiary>>> getBeneficiaries();
  Future<Either<Failure, bool>> sendOtp({required SendOtpParams params});
  Future<Either<Failure, bool>> verifyOtp({required VerifyOtpParams params});
}
