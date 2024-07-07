import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dubai_app_studio/core/constants/app_constants.dart';
import 'package:dubai_app_studio/core/constants/app_validation.dart';
import 'package:dubai_app_studio/core/usecases/add_beneficiary_params.dart';
import 'package:dubai_app_studio/features/beneficiary/presentation/blocs/beneficiaries_bloc/beneficiaries_bloc.dart';

class AddBeneficiaryDialog extends StatefulWidget {
  const AddBeneficiaryDialog({
    super.key,
  });

  @override
  State<AddBeneficiaryDialog> createState() => _AddBeneficiaryDialogState();
}

class _AddBeneficiaryDialogState extends State<AddBeneficiaryDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ValueNotifier<String> errorMessageNotifier = ValueNotifier<String>("");

  void _addBeneficiary() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      FocusManager.instance.primaryFocus?.unfocus();
      context.read<BeneficiariesBloc>().add(AddBeneficiaryEvent(
          params: AddBeneficiaryParams(
              name: nameController.text,
              phoneNumber: phoneNumberController.text)));
    }
  }

  void _showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Beneficiary added successfully")));
  }

  void _showFailureMessage(String errorMessage) {
    errorMessageNotifier.value = errorMessage;
  }

  void _clearFailureMessage() {
    if (errorMessageNotifier.value.isNotEmpty) {
      errorMessageNotifier.value = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BeneficiariesBloc, BeneficiariesState>(
      listener: (context, state) {
        if (state is AddBeneficiaryCompleted) {
          _showSuccessSnackBar();
          Navigator.pop(context);
        }
        if (state is AddBeneficiaryFailed) {
          _showFailureMessage(state.errorMessage);
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: Text(
            "New Beneficiary",
            style: TextStyle(
              fontSize: AppFontSizes.xLarge,
            ),
          ),
          content: SizedBox(
            height: .3.sh,
            child: (state is AddingBeneficiary)
                ? const Center(child: CircularProgressIndicator())
                : Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          controller: nameController,
                          validator: AppValidation.nameValidation,
                          maxLength: 20,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: 'John Smith',
                            labelText: 'Name',
                            errorMaxLines: 5,
                            prefixIcon: Icon(Icons.person),
                          ),
                          onChanged: (_) {
                            _clearFailureMessage();
                          },
                        ),
                        TextFormField(
                          controller: phoneNumberController,
                          validator: AppValidation.phoneNumberValidation,
                          maxLength: 9,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) {
                            if (nameController.text.isNotEmpty &&
                                phoneNumberController.text.isNotEmpty) {
                              _addBeneficiary();
                            }
                          },
                          onChanged: (_) {
                            _clearFailureMessage();
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            hintText: 'XX1234567',
                            labelText: 'Phone Number',
                            errorMaxLines: 5,
                            prefix: Text("${AppConfig.countryCode}-"),
                            prefixIcon: Icon(Icons.phone),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: ValueListenableBuilder(
                            valueListenable: errorMessageNotifier,
                            builder: (context, errorMessage, _) {
                              return Text(
                                errorMessage,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: AppFontSizes.tiny,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          actions: [
            (state is AddingBeneficiary)
                ? const SizedBox.shrink()
                : FilledButton.tonal(
                    onPressed: _addBeneficiary,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      fixedSize: Size(130.w, 20.h),
                    ),
                    child: Text(
                      "Add",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: AppFontSizes.small,
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }
}
