import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dubai_app_studio/features/history/domain/entities/history_item.dart';
import 'package:dubai_app_studio/features/history/presentation/widgets/history_item_card.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: dummyHistoryItems.length,
      separatorBuilder: (context, _) => SizedBox(height: 10.h),
      itemBuilder: (context, index) =>
          HistoryItemCard(historyItem: dummyHistoryItems[index]),
    );
  }
}
