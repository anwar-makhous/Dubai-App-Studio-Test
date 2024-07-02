import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dubai_app_studio/core/app_constants.dart';
import 'package:dubai_app_studio/features/recharge/domain/entities/history_item.dart';

class HistoryItemCard extends StatelessWidget {
  final HistoryItem historyItem;

  const HistoryItemCard({super.key, required this.historyItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                historyItem.name,
                style: TextStyle(
                  color: AppColors.deepBlue,
                  fontSize: AppFontSizes.smallLabel,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${historyItem.amount} AED',
                style: TextStyle(
                  color: AppColors.deepBlue,
                  fontSize: AppFontSizes.smallLabel,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              historyItem.number,
              style: TextStyle(
                color: Colors.grey,
                fontSize: AppFontSizes.tinyLabel,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
