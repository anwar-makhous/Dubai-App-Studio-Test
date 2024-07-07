import 'package:dartz/dartz.dart';
import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/core/usecases/usecase.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/entities/beneficiary.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/repositories/beneficiary_repository.dart';

class GetBeneficiaries extends UseCase<List<Beneficiary>, NoParams> {
  final BeneficiaryRepository repository;

  GetBeneficiaries({required this.repository});

  @override
  Future<Either<Failure, List<Beneficiary>>> call(NoParams params) async {
    return await repository.getBeneficiaries();
  }
}
