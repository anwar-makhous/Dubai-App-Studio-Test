import 'package:dubai_app_studio/core/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dubai_app_studio/features/home/presentation/widgets/recharge_tab_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _currentBalance = 5000;
  ValueNotifier<bool> showBalanceNotifier = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Home Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: showBalanceNotifier,
              builder: (context, showBalance, _) {
                return AnimatedCrossFade(
                  crossFadeState: showBalance
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: AppAnimation.duration,
                  reverseDuration: AppAnimation.duration,
                  firstCurve: AppAnimation.curve,
                  secondCurve: AppAnimation.curve,
                  sizeCurve: AppAnimation.curve,
                  firstChild: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Your current balance: $_currentBalance AED',
                      style: TextStyle(fontSize: AppFontSizes.smallLabel),
                    ),
                  ),
                  secondChild: SizedBox(
                    height: 500.h,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Your current balance',
                            style: TextStyle(fontSize: AppFontSizes.smallLabel),
                          ),
                          Text(
                            '$_currentBalance AED',
                            style:
                                TextStyle(fontSize: AppFontSizes.mediumLabel),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            RechargeTabBar(
              onTapOnHistoryTab: () {
                showBalanceNotifier.value = false;
              },
              onTapOnRechargeTab: () {
                showBalanceNotifier.value = true;
              },
            ),
          ],
        ),
      ),
    );
  }
}
