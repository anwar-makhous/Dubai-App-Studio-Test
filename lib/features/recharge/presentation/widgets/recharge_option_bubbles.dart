import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dubai_app_studio/core/constants/app_constants.dart';

class RechargeOptionBubbles extends StatefulWidget {
  final void Function(int value) onSetOption;
  const RechargeOptionBubbles({super.key, required this.onSetOption});

  @override
  State<RechargeOptionBubbles> createState() => _RechargeOptionBubblesState();
}

class _RechargeOptionBubblesState extends State<RechargeOptionBubbles> {
  ValueNotifier<int> selectedOptionNotifier = ValueNotifier<int>(0);

  void setRechargeOption(int value) {
    widget.onSetOption(value);
    selectedOptionNotifier.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedOptionNotifier,
      builder: (context, selectedOption, _) {
        return Wrap(
          spacing: 15.r,
          runSpacing: 15.r,
          children: AppConfig.rechargeOptions
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    setRechargeOption(e);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: e == selectedOption
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).disabledColor,
                      borderRadius: BorderRadius.circular(30.w),
                    ),
                    child: Text(
                      "${AppConfig.numberFormat.format(e)} ${AppConfig.currency}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: AppFontSizes.tiny,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
