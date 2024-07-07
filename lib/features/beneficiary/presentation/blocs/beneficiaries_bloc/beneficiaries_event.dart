part of 'beneficiaries_bloc.dart';

sealed class BeneficiariesEvent extends Equatable {
  const BeneficiariesEvent();

  @override
  List<Object> get props => [];
}

final class AddBeneficiaryEvent extends BeneficiariesEvent {
  final AddBeneficiaryParams params;
  const AddBeneficiaryEvent({required this.params});
}

final class DeleteBeneficiaryEvent extends BeneficiariesEvent {
  final DeleteBeneficiaryParams params;
  const DeleteBeneficiaryEvent({required this.params});
}

final class SendOtpEvent extends BeneficiariesEvent {
  final SendOtpParams params;
  const SendOtpEvent({required this.params});
}

final class VerifyOtpEvent extends BeneficiariesEvent {
  final VerifyOtpParams params;
  const VerifyOtpEvent({required this.params});
}

final class GetBeneficiariesEvent extends BeneficiariesEvent {
  final bool refresh;
  const GetBeneficiariesEvent({this.refresh = false});
}
