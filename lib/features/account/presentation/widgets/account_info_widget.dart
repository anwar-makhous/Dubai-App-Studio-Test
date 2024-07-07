import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dubai_app_studio/core/constants/app_constants.dart';
import 'package:dubai_app_studio/features/account/domain/entities/account_info.dart';

class AccountInfoWidget extends StatelessWidget {
  final AccountInfo accountInfo;

  const AccountInfoWidget({super.key, required this.accountInfo});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 470.h,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            Text(
              'Your current balance',
              style: TextStyle(fontSize: AppFontSizes.small),
            ),
            Text(
              '${AppConfig.numberFormat.format(accountInfo.balance)} ${AppConfig.currency}',
              style: TextStyle(fontSize: AppFontSizes.xLarge),
            ),
            const Spacer(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              alignment: AlignmentDirectional.bottomStart,
              child: Text(
                'Your total transactions this month: ${AppConfig.numberFormat.format(accountInfo.totalTransactions)} ${AppConfig.currency}',
                style: TextStyle(fontSize: AppFontSizes.small),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
