import 'package:flutter/material.dart';

class CannotRechargeDialog extends StatelessWidget {
  final String messsage;

  const CannotRechargeDialog({super.key, required this.messsage});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Cannot recharge"),
      content: Text(messsage),
      actions: [
        FilledButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Ok"),
        ),
      ],
    );
  }
}
