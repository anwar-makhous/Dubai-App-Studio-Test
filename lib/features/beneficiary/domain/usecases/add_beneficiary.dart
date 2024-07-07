import 'package:dartz/dartz.dart';
import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/core/usecases/add_beneficiary_params.dart';
import 'package:dubai_app_studio/core/usecases/usecase.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/repositories/beneficiary_repository.dart';

class AddBeneficiary extends UseCase<bool, AddBeneficiaryParams> {
  final BeneficiaryRepository repository;

  AddBeneficiary({required this.repository});

  @override
  Future<Either<Failure, bool>> call(AddBeneficiaryParams params) async {
    return await repository.addBeneficiary(params: params);
  }
}
