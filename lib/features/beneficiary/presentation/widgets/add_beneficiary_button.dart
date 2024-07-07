import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dubai_app_studio/core/constants/app_constants.dart';
import 'package:dubai_app_studio/features/beneficiary/presentation/widgets/add_beneficiary_dialog.dart';

class AddBeneficiaryButton extends StatelessWidget {
  const AddBeneficiaryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => const AddBeneficiaryDialog(),
        );
      },
      child: Container(
        height: 150.r,
        width: 145.r,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.add_circle_rounded,
                size: 36.r,
              ),
              Text(
                "New Beneficiary",
                style: TextStyle(
                  color: AppColors.deepBlue,
                  fontSize: AppFontSizes.small,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
