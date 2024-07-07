import 'package:flutter/material.dart';

import 'package:dubai_app_studio/core/constants/app_constants.dart';

class RechargeNotesWidget extends StatelessWidget {
  const RechargeNotesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '''- A charge of 1 ${AppConfig.currency} will be applied for every transaction.
- Maximum monthly debit for verified beneficiaries is 1,000 ${AppConfig.currency}.
- Maximum monthly debit for non-verified beneficiaries is 500 ${AppConfig.currency}.
- You can top up a total of 3,000 ${AppConfig.currency} per month for all beneficiaries.''',
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: AppFontSizes.tiny,
      ),
    );
  }
}
