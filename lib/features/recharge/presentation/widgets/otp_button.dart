import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dubai_app_studio/core/constants/app_constants.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/entities/beneficiary.dart';

class OtpButton extends StatelessWidget {
  final Beneficiary beneficiary;
  final ValueNotifier<bool> showOtpTextFieldNotifier;
  final String currentOtp;
  final Function(String currentOtp) verifyOtp;
  final Function() sendOtp;

  const OtpButton({
    super.key,
    required this.beneficiary,
    required this.showOtpTextFieldNotifier,
    required this.currentOtp,
    required this.verifyOtp,
    required this.sendOtp,
  });

  @override
  Widget build(BuildContext context) {
    return beneficiary.isVerified
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Verified",
                style: TextStyle(
                  fontSize: AppFontSizes.small,
                  color: Colors.green,
                ),
              ),
              SizedBox(width: 10.w),
              Icon(
                Icons.check,
                size: 24.r,
                color: Colors.green,
              ),
            ],
          )
        : ValueListenableBuilder(
            valueListenable: showOtpTextFieldNotifier,
            builder: (context, showOtpTextField, _) {
              return ElevatedButton(
                onPressed: () {
                  if (showOtpTextField) {
                    if (currentOtp.length == 4) {
                      verifyOtp(currentOtp);
                    }
                  } else {
                    sendOtp();
                  }
                },
                child: Text(
                  showOtpTextField ? "Verify" : "Send Otp",
                  style: TextStyle(fontSize: AppFontSizes.small),
                ),
              );
            },
          );
  }
}
