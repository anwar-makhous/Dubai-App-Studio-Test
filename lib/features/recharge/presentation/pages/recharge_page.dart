import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dubai_app_studio/core/constants/app_constants.dart';
import 'package:dubai_app_studio/core/usecases/delete_beneficiary_params.dart';
import 'package:dubai_app_studio/core/usecases/send_amount_params.dart';
import 'package:dubai_app_studio/core/usecases/send_otp_params.dart';
import 'package:dubai_app_studio/core/usecases/verify_otp_params.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/entities/beneficiary.dart';
import 'package:dubai_app_studio/features/beneficiary/presentation/blocs/beneficiaries_bloc/beneficiaries_bloc.dart';
import 'package:dubai_app_studio/features/account/presentation/blocs/account_bloc/account_bloc.dart';
import 'package:dubai_app_studio/features/recharge/presentation/blocs/history_bloc/history_bloc.dart';
import 'package:dubai_app_studio/features/recharge/presentation/blocs/recharge_bloc/recharge_bloc.dart';
import 'package:dubai_app_studio/features/recharge/presentation/widgets/cannot_recharge_dialog.dart';
import 'package:dubai_app_studio/features/recharge/presentation/widgets/confirm_recharge_dialog.dart';
import 'package:dubai_app_studio/features/recharge/presentation/widgets/delete_beneficiary_dialog.dart';
import 'package:dubai_app_studio/features/recharge/presentation/widgets/otp_button.dart';
import 'package:dubai_app_studio/features/recharge/presentation/widgets/otp_text_field.dart';
import 'package:dubai_app_studio/features/recharge/presentation/widgets/recharge_notes_widget.dart';
import 'package:dubai_app_studio/features/recharge/presentation/widgets/recharge_option_bubbles.dart';

class RechargePage extends StatefulWidget {
  final Beneficiary beneficiary;
  const RechargePage({super.key, required this.beneficiary});

  @override
  State<RechargePage> createState() => _RechargePageState();
}

class _RechargePageState extends State<RechargePage> {
  ValueNotifier<int> selectedOptionNotifier = ValueNotifier<int>(0);
  ValueNotifier<bool> showOtpTextFieldNotifier = ValueNotifier<bool>(false);
  String currentOtp = "";

  void setRechargeOption(int value) {
    selectedOptionNotifier.value = value;
  }

  void recharge() {
    String canRechargeMessage = context.read<RechargeBloc>().checkReachability(
        beneficiary: widget.beneficiary,
        currentAccountInfo: context.read<AccountBloc>().currentAccountInfo,
        rechargeAmount: selectedOptionNotifier.value.toDouble());
    if (canRechargeMessage == "ok") {
      openRechargeDialog();
    } else {
      showDialog(
          context: context,
          builder: (context) =>
              CannotRechargeDialog(messsage: canRechargeMessage));
    }
  }

  void openRechargeDialog() {
    showDialog(
      context: context,
      builder: (context) => ConfirmRechargeDialog(
        beneficiary: widget.beneficiary,
        amount: selectedOptionNotifier.value.toDouble(),
        onConfirm: () {
          context.read<RechargeBloc>().add(SendAmountEvent(
              params: SendAmountParams(
                  phoneNumber: widget.beneficiary.phoneNumber,
                  amount: selectedOptionNotifier.value.toDouble())));
        },
      ),
    );
  }

  void openDeleteBeneficiaryDialog() {
    showDialog(
      context: context,
      builder: (context) => DeleteBeneficiaryDialog(
        beneficiaryName: widget.beneficiary.name,
        onConfirm: () {
          context.read<BeneficiariesBloc>().add(DeleteBeneficiaryEvent(
              params: DeleteBeneficiaryParams(
                  phoneNumber: widget.beneficiary.phoneNumber)));
        },
      ),
    );
  }

  void sendOtp() {
    context.read<BeneficiariesBloc>().add(SendOtpEvent(
        params: SendOtpParams(phoneNumber: widget.beneficiary.phoneNumber)));
  }

  void verifyOtp(String otp) {
    context.read<BeneficiariesBloc>().add(VerifyOtpEvent(
        params: VerifyOtpParams(
            phoneNumber: widget.beneficiary.phoneNumber, otp: otp)));
  }

  void beneficiariesBlocListener(_, BeneficiariesState state) {
    if (state is DeleteBeneficiaryCompleted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("${widget.beneficiary.name} Deleted Successfully")));
    }
    if (state is DeleteBeneficiaryFailed) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(state.errorMessage)));
    }
    if (state is SendOtpCompleted) {
      showOtpTextFieldNotifier.value = true;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Otp Sent Successfully")));
    }
    if (state is SendOtpFailed) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(state.errorMessage)));
    }
    if (state is VerifyOtpCompleted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "${AppConfig.countryCode}-${widget.beneficiary.phoneNumber} Verified Successfully")));
      context
          .read<BeneficiariesBloc>()
          .add(const GetBeneficiariesEvent(refresh: true));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => RechargePage(
                  beneficiary: widget.beneficiary.copyWith(isVerified: true))));
    }
    if (state is VerifyOtpFailed) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(state.errorMessage)));
    }
  }

  void rechargeBlocListener(_, RechargeState state) {
    if (state is RechargeFailed) {
      showDialog(
          context: context,
          builder: (context) =>
              CannotRechargeDialog(messsage: state.errorMessage));
    }
    if (state is RechargeSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("${widget.beneficiary.name} Recharged Successfully")));
      context.read<AccountBloc>().add(GetAccountInfoEvent());
      context
          .read<BeneficiariesBloc>()
          .add(const GetBeneficiariesEvent(refresh: true));
      context
          .read<HistoryBloc>()
          .add(const GetRechargeHistoryEvent(refresh: true));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Recharge Page"),
      ),
      body: BlocConsumer<RechargeBloc, RechargeState>(
        listener: rechargeBlocListener,
        builder: (context, state) {
          if (state is RechargeLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return BlocConsumer<BeneficiariesBloc, BeneficiariesState>(
            listener: beneficiariesBlocListener,
            builder: (context, state) {
              if (state is DeletingBeneficiary) {
                return const Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      'Your current balance: ${AppConfig.numberFormat.format(context.watch<AccountBloc>().currentAccountInfo.balance)} ${AppConfig.currency}',
                      style: TextStyle(fontSize: AppFontSizes.small),
                    ),
                    Text(
                      'Your total transactions this month: ${AppConfig.numberFormat.format(context.watch<AccountBloc>().currentAccountInfo.totalTransactions)} ${AppConfig.currency}',
                      style: TextStyle(fontSize: AppFontSizes.small),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            widget.beneficiary.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: AppFontSizes.large),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: openDeleteBeneficiaryDialog,
                          child: Text(
                            "Delete",
                            style: TextStyle(
                                fontSize: AppFontSizes.small,
                                color: Colors.red),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${AppConfig.countryCode}-${widget.beneficiary.phoneNumber}",
                          style: TextStyle(fontSize: AppFontSizes.medium),
                        ),
                        BlocBuilder<BeneficiariesBloc, BeneficiariesState>(
                          builder: (context, state) {
                            if (state is SendingOtp || state is VerifyingOtp) {
                              return SizedBox(
                                width: 80.w,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            return OtpButton(
                              beneficiary: widget.beneficiary,
                              showOtpTextFieldNotifier:
                                  showOtpTextFieldNotifier,
                              currentOtp: currentOtp,
                              verifyOtp: verifyOtp,
                              sendOtp: sendOtp,
                            );
                          },
                        ),
                      ],
                    ),
                    ValueListenableBuilder(
                      valueListenable: showOtpTextFieldNotifier,
                      builder: (context, showOtpTextField, _) {
                        return Visibility(
                          visible: showOtpTextField,
                          child: OtpTextField(
                            timeOutDuration: const Duration(seconds: 60),
                            onResend: sendOtp,
                            onCompleteTyping: verifyOtp,
                            onChanged: (value) {
                              currentOtp = value;
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 40.h),
                    const RechargeNotesWidget(),
                    SizedBox(height: 30.h),
                    Text(
                      '${widget.beneficiary.name} total transactions this month: ${AppConfig.numberFormat.format(widget.beneficiary.totalTransactions)} ${AppConfig.currency}',
                      style: TextStyle(fontSize: AppFontSizes.small),
                    ),
                    SizedBox(height: 20.h),
                    RechargeOptionBubbles(onSetOption: setRechargeOption),
                    const Spacer(),
                    ValueListenableBuilder(
                      valueListenable: selectedOptionNotifier,
                      builder: (context, selectedOption, _) {
                        if (selectedOption == 0) {
                          return const SizedBox.shrink();
                        }
                        return Center(
                          child: FilledButton(
                            onPressed: recharge,
                            style: FilledButton.styleFrom(
                              fixedSize: Size(.75.sw, 80.h),
                            ),
                            child: Text(
                              "Recharge",
                              style: TextStyle(fontSize: AppFontSizes.medium),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
