import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dubai_app_studio/core/constants/app_constants.dart';
import 'package:dubai_app_studio/features/recharge/domain/entities/history_item.dart';

class HistoryItemCard extends StatelessWidget {
  final HistoryItem historyItem;

  const HistoryItemCard({super.key, required this.historyItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                historyItem.name,
                style: TextStyle(
                  color: AppColors.deepBlue,
                  fontSize: AppFontSizes.small,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${historyItem.amount} ${AppConfig.currency}',
                style: TextStyle(
                  color: AppColors.deepBlue,
                  fontSize: AppFontSizes.small,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${AppConfig.countryCode}-${historyItem.phoneNumber}",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: AppFontSizes.tiny,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${historyItem.date.hour}:${historyItem.date.minute}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: AppFontSizes.tiny,
                    ),
                  ),
                  Text(
                    AppConfig.dateFormat.format(historyItem.date),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: AppFontSizes.tiny,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
