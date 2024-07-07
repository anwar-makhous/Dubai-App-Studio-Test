import 'package:dartz/dartz.dart';
import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/core/network/network_info.dart';
import 'package:dubai_app_studio/core/usecases/add_beneficiary_params.dart';
import 'package:dubai_app_studio/core/usecases/delete_beneficiary_params.dart';
import 'package:dubai_app_studio/core/usecases/send_otp_params.dart';
import 'package:dubai_app_studio/core/usecases/verify_otp_params.dart';
import 'package:dubai_app_studio/features/beneficiary/data/data_sources/beneficiary_data_source.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/entities/beneficiary.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/repositories/beneficiary_repository.dart';

class BeneficiaryRepositoryImpl implements BeneficiaryRepository {
  final NetworkInfo networkInfo;
  final BeneficiaryDataSource remoteDataSource;

  BeneficiaryRepositoryImpl(
      {required this.networkInfo, required this.remoteDataSource});

  @override
  Future<Either<Failure, bool>> addBeneficiary(
      {required AddBeneficiaryParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.addBeneficiary(params: params));
      } on Exception catch (e) {
        return Left(Failure.fromException(e));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, List<Beneficiary>>> getBeneficiaries() async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.getBeneficiaries());
      } on Exception catch (e) {
        return Left(Failure.fromException(e));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> sendOtp({required SendOtpParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.sendOtp(params: params));
      } on Exception catch (e) {
        return Left(Failure.fromException(e));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> verifyOtp(
      {required VerifyOtpParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.verifyOtp(params: params));
      } on Exception catch (e) {
        return Left(Failure.fromException(e));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteBeneficiary(
      {required DeleteBeneficiaryParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.deleteBeneficiary(params: params));
      } on Exception catch (e) {
        return Left(Failure.fromException(e));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }
}
