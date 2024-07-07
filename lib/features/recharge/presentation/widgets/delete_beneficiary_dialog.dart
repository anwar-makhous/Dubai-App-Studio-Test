import 'package:flutter/material.dart';

class DeleteBeneficiaryDialog extends StatelessWidget {
  final void Function() onConfirm;
  final String beneficiaryName;

  const DeleteBeneficiaryDialog(
      {super.key, required this.onConfirm, required this.beneficiaryName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure you want to delete $beneficiaryName ?"),
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
