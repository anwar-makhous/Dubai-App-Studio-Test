import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dubai_app_studio/core/constants/app_constants.dart';
import 'package:dubai_app_studio/features/beneficiary/presentation/widgets/beneficiaries_tab.dart';
import 'package:dubai_app_studio/features/account/presentation/widgets/history_tab.dart';

class HomeTabBar extends StatefulWidget {
  final Function() onSwitchToHistoryTab;
  final Function() onSwitchToRechargeTab;
  const HomeTabBar({
    super.key,
    required this.onSwitchToHistoryTab,
    required this.onSwitchToRechargeTab,
  });

  @override
  State<HomeTabBar> createState() => _HomeTabBarState();
}

class _HomeTabBarState extends State<HomeTabBar> {
  ValueNotifier<double> tabBarViewHeightNotifier = ValueNotifier<double>(150.r);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              "Mobile Recharge",
              style: TextStyle(
                color: AppColors.deepBlue,
                fontWeight: FontWeight.bold,
                fontSize: AppFontSizes.xLarge,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              height: 50.h,
              padding: EdgeInsets.all(5.r),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(30.w),
              ),
              child: TabBar(
                dividerColor: Colors.transparent,
                tabAlignment: TabAlignment.fill,
                labelColor: AppColors.deepBlue,
                indicatorSize: TabBarIndicatorSize.tab,
                labelPadding: EdgeInsets.symmetric(horizontal: 5.w),
                indicator: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.w),
                  ),
                ),
                onTap: (index) {
                  if (index == 0) {
                    tabBarViewHeightNotifier.value = 150.h;
                    widget.onSwitchToRechargeTab();
                  } else {
                    tabBarViewHeightNotifier.value = 600.h;
                    widget.onSwitchToHistoryTab();
                  }
                },
                tabs: const [
                  Tab(text: "Recharge"),
                  Tab(text: "History"),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.h),
          ValueListenableBuilder(
            valueListenable: tabBarViewHeightNotifier,
            builder: (context, tabBarViewHeight, _) {
              return AnimatedContainer(
                duration: AppAnimation.duration,
                curve: AppAnimation.curve,
                height: tabBarViewHeight,
                child: const TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    BeneficiariesTab(),
                    HistoryTab(),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
