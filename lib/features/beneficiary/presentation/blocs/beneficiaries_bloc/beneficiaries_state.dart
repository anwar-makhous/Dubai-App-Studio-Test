part of 'beneficiaries_bloc.dart';

sealed class BeneficiariesState extends Equatable {
  const BeneficiariesState();

  @override
  List<Object> get props => [];
}

final class BeneficiariesInitial extends BeneficiariesState {}

final class BeneficiariesLoading extends BeneficiariesState {}

final class BeneficiariesFailed extends BeneficiariesState {
  final String errorMessage;
  const BeneficiariesFailed({required this.errorMessage});
}

final class BeneficiariesLoaded extends BeneficiariesState {
  final List<Beneficiary> beneficiaries;
  const BeneficiariesLoaded({required this.beneficiaries});
}

final class AddingBeneficiary extends BeneficiariesState {}

final class AddBeneficiaryFailed extends BeneficiariesState {
  final String errorMessage;
  const AddBeneficiaryFailed({required this.errorMessage});
}

final class AddBeneficiaryCompleted extends BeneficiariesState {}

final class DeletingBeneficiary extends BeneficiariesState {}

final class DeleteBeneficiaryFailed extends BeneficiariesState {
  final String errorMessage;
  const DeleteBeneficiaryFailed({required this.errorMessage});
}

final class DeleteBeneficiaryCompleted extends BeneficiariesState {}

final class SendingOtp extends BeneficiariesState {}

final class SendOtpFailed extends BeneficiariesState {
  final String errorMessage;
  const SendOtpFailed({required this.errorMessage});
}

final class SendOtpCompleted extends BeneficiariesState {}

final class VerifyingOtp extends BeneficiariesState {}

final class VerifyOtpFailed extends BeneficiariesState {
  final String errorMessage;
  const VerifyOtpFailed({required this.errorMessage});
}

final class VerifyOtpCompleted extends BeneficiariesState {}
