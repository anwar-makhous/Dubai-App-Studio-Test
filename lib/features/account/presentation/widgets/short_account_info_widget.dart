import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dubai_app_studio/core/constants/app_constants.dart';
import 'package:dubai_app_studio/features/account/domain/entities/account_info.dart';

class ShortAccountInfoWidget extends StatelessWidget {
  final AccountInfo accountInfo;

  const ShortAccountInfoWidget({super.key, required this.accountInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        'Your current balance: ${AppConfig.numberFormat.format(accountInfo.balance)} ${AppConfig.currency}',
        style: TextStyle(fontSize: AppFontSizes.small),
      ),
    );
  }
}
