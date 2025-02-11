import 'package:dubai_app_studio/features/recharge/presentation/pages/recharge_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dubai_app_studio/features/beneficiary/domain/entities/beneficiary.dart';
import 'package:dubai_app_studio/core/constants/app_constants.dart';

class BeneficiaryCard extends StatelessWidget {
  final Beneficiary beneficiary;

  const BeneficiaryCard({super.key, required this.beneficiary});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.r,
      width: 145.r,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            beneficiary.name,
            style: TextStyle(
              color: AppColors.deepBlue,
              fontSize: AppFontSizes.small,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "${AppConfig.countryCode}-${beneficiary.phoneNumber}",
            style: TextStyle(
              color: Colors.grey,
              fontSize: AppFontSizes.tiny,
            ),
          ),
          FilledButton.tonal(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RechargePage(beneficiary: beneficiary)));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              fixedSize: Size(130.w, 20.h),
            ),
            child: Text(
              "Recharge now",
              style: TextStyle(
                color: Colors.white,
                fontSize: AppFontSizes.tiny,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
