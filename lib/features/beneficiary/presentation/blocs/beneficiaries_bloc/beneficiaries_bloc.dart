import 'dart:async';

import 'package:dubai_app_studio/core/constants/app_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dubai_app_studio/core/usecases/add_beneficiary_params.dart';
import 'package:dubai_app_studio/core/usecases/delete_beneficiary_params.dart';
import 'package:dubai_app_studio/core/usecases/send_otp_params.dart';
import 'package:dubai_app_studio/core/usecases/usecase.dart';
import 'package:dubai_app_studio/core/usecases/verify_otp_params.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/entities/beneficiary.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/usecases/add_beneficiary.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/usecases/delete_beneficiary.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/usecases/get_beneficiaries.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/usecases/send_otp.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/usecases/verify_otp.dart';

part 'beneficiaries_event.dart';
part 'beneficiaries_state.dart';

class BeneficiariesBloc extends Bloc<BeneficiariesEvent, BeneficiariesState> {
  final AddBeneficiary addBeneficiary;
  final DeleteBeneficiary deleteBeneficiary;
  final SendOtp sendOtp;
  final VerifyOtp verifyOtp;
  final GetBeneficiaries getBeneficiaries;

  List<Beneficiary> currentBeneficiaries = [];

  BeneficiariesBloc({
    required this.addBeneficiary,
    required this.deleteBeneficiary,
    required this.sendOtp,
    required this.verifyOtp,
    required this.getBeneficiaries,
  }) : super(BeneficiariesInitial()) {
    on<AddBeneficiaryEvent>(_onAddBeneficiaryEvent);
    on<DeleteBeneficiaryEvent>(_onDeleteBeneficiaryEvent);
    on<SendOtpEvent>(_onSendOtpEvent);
    on<VerifyOtpEvent>(_onVerifyOtpEvent);
    on<GetBeneficiariesEvent>(_onGetBeneficiariesEvent);
  }

  Future<void> _onAddBeneficiaryEvent(
      AddBeneficiaryEvent event, Emitter<BeneficiariesState> emit) async {
    if (currentBeneficiaries.length < AppConfig.maxBeneficiariesCount) {
      if (state is! BeneficiariesLoading) {
        emit(AddingBeneficiary());

        final eitherResponse = await addBeneficiary.call(event.params);

        emit(
          eitherResponse.fold(
            (failure) =>
                AddBeneficiaryFailed(errorMessage: failure.errorMessage),
            (success) => success
                ? AddBeneficiaryCompleted()
                : AddBeneficiaryFailed(
                    errorMessage:
                        "Failed to add ${event.params.name}, try again."),
          ),
        );

        if (state is AddBeneficiaryCompleted) {
          add(const GetBeneficiariesEvent(refresh: true));
        } else {
          emit(BeneficiariesLoaded(beneficiaries: currentBeneficiaries));
        }
      }
    } else {
      emit(const AddBeneficiaryFailed(
          errorMessage: "You have reached maximum number of beneficiaries"));
    }
  }

  Future<void> _onDeleteBeneficiaryEvent(
      DeleteBeneficiaryEvent event, Emitter<BeneficiariesState> emit) async {
    emit(DeletingBeneficiary());

    final eitherResponse = await deleteBeneficiary.call(event.params);

    emit(
      eitherResponse.fold(
        (failure) =>
            DeleteBeneficiaryFailed(errorMessage: failure.errorMessage),
        (success) => success
            ? DeleteBeneficiaryCompleted()
            : const DeleteBeneficiaryFailed(
                errorMessage: "Failed to delete beneficiary, try again."),
      ),
    );

    if (state is DeleteBeneficiaryCompleted) {
      add(const GetBeneficiariesEvent(refresh: true));
    } else {
      emit(BeneficiariesLoaded(beneficiaries: currentBeneficiaries));
    }
  }

  Future<void> _onSendOtpEvent(
      SendOtpEvent event, Emitter<BeneficiariesState> emit) async {
    emit(SendingOtp());

    final eitherResponse = await sendOtp.call(event.params);

    emit(
      eitherResponse.fold(
        (failure) => SendOtpFailed(errorMessage: failure.errorMessage),
        (success) => success
            ? SendOtpCompleted()
            : SendOtpFailed(
                errorMessage:
                    "Failed to send otp to ${event.params.phoneNumber}"),
      ),
    );
    emit(BeneficiariesLoaded(beneficiaries: currentBeneficiaries));
  }

  Future<void> _onVerifyOtpEvent(
      VerifyOtpEvent event, Emitter<BeneficiariesState> emit) async {
    emit(VerifyingOtp());

    final eitherResponse = await verifyOtp.call(event.params);

    emit(
      eitherResponse.fold(
        (failure) => VerifyOtpFailed(errorMessage: failure.errorMessage),
        (success) => success
            ? VerifyOtpCompleted()
            : const VerifyOtpFailed(errorMessage: 'invalid otp'),
      ),
    );
    emit(BeneficiariesLoaded(beneficiaries: currentBeneficiaries));
  }

  Future<void> _onGetBeneficiariesEvent(
      GetBeneficiariesEvent event, Emitter<BeneficiariesState> emit) async {
    if (event.refresh || currentBeneficiaries.isEmpty) {
      emit(BeneficiariesLoading());

      final eitherResponse = await getBeneficiaries.call(NoParams());

      emit(
        eitherResponse.fold(
          (failure) => BeneficiariesFailed(errorMessage: failure.errorMessage),
          (fetchedBeneficiaries) {
            currentBeneficiaries
              ..clear()
              ..addAll(fetchedBeneficiaries);
            return BeneficiariesLoaded(beneficiaries: fetchedBeneficiaries);
          },
        ),
      );
    } else {
      emit(BeneficiariesLoaded(beneficiaries: currentBeneficiaries));
    }
  }
}
