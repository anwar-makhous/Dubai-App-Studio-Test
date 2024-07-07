import 'package:flutter/material.dart';

import 'package:dubai_app_studio/core/constants/app_constants.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/entities/beneficiary.dart';

class ConfirmRechargeDialog extends StatelessWidget {
  final void Function() onConfirm;
  final Beneficiary beneficiary;
  final double amount;

  const ConfirmRechargeDialog(
      {super.key,
      required this.onConfirm,
      required this.beneficiary,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
          "Send $amount ${AppConfig.currency} to ${AppConfig.countryCode}-${beneficiary.phoneNumber} ?"),
      actions: [
        FilledButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          child: const Text("Yes"),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("No"),
        ),
      ],
    );
  }
}
