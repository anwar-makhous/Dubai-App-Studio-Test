import 'package:dartz/dartz.dart';
import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/core/usecases/delete_beneficiary_params.dart';
import 'package:dubai_app_studio/core/usecases/usecase.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/repositories/beneficiary_repository.dart';

class DeleteBeneficiary extends UseCase<bool, DeleteBeneficiaryParams> {
  final BeneficiaryRepository repository;

  DeleteBeneficiary({required this.repository});

  @override
  Future<Either<Failure, bool>> call(DeleteBeneficiaryParams params) async {
    return await repository.deleteBeneficiary(params: params);
  }
}
