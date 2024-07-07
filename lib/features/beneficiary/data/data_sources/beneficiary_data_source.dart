import 'package:dubai_app_studio/core/usecases/add_beneficiary_params.dart';
import 'package:dubai_app_studio/core/usecases/delete_beneficiary_params.dart';
import 'package:dubai_app_studio/core/usecases/send_otp_params.dart';
import 'package:dubai_app_studio/core/usecases/verify_otp_params.dart';
import 'package:dubai_app_studio/features/beneficiary/data/models/beneficiary_model.dart';

abstract class BeneficiaryDataSource {
  Future<bool> addBeneficiary({required AddBeneficiaryParams params});
  Future<bool> deleteBeneficiary({required DeleteBeneficiaryParams params});
  Future<List<BeneficiaryModel>> getBeneficiaries();
  Future<bool> sendOtp({required SendOtpParams params});
  Future<bool> verifyOtp({required VerifyOtpParams params});
}
