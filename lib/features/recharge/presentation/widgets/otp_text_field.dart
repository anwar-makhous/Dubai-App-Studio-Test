import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dubai_app_studio/core/constants/app_constants.dart';

class OtpTextField extends StatefulWidget {
  final void Function(String value) onCompleteTyping;
  final void Function(String value) onChanged;
  final void Function() onResend;
  final Duration timeOutDuration;

  const OtpTextField({
    super.key,
    required this.onCompleteTyping,
    required this.onChanged,
    required this.onResend,
    this.timeOutDuration = const Duration(minutes: 1),
  });

  @override
  State<OtpTextField> createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  ValueNotifier<bool> canResendNotifier = ValueNotifier<bool>(false);
  ValueNotifier<int> secondLeftNotifier = ValueNotifier<int>(0);
  late Timer _timer;
  late Timer _ticker;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _ticker.cancel();
    super.dispose();
  }

  void startTimer() {
    canResendNotifier.value = false;
    secondLeftNotifier.value = widget.timeOutDuration.inSeconds;
    _timer = Timer(
      widget.timeOutDuration,
      () {
        canResendNotifier.value = true;
      },
    );
    _ticker = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (secondLeftNotifier.value > 0) {
          --secondLeftNotifier.value;
        } else {
          _ticker.cancel();
        }
      },
    );
  }

  void onChanged() {
    String finalValue = controller1.text +
        controller2.text +
        controller3.text +
        controller4.text;
    widget.onChanged(finalValue);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          height: 50.h,
          width: .25.sh,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _OtpTextFieldDigit(
                  controller: controller1,
                  first: true,
                  last: false,
                  onChanged: onChanged),
              _OtpTextFieldDigit(
                  controller: controller2,
                  first: false,
                  last: false,
                  onChanged: onChanged),
              _OtpTextFieldDigit(
                  controller: controller3,
                  first: false,
                  last: false,
                  onChanged: onChanged),
              _OtpTextFieldDigit(
                controller: controller4,
                first: false,
                last: true,
                onChanged: onChanged,
                onCompleteTyping: () {
                  String finalOtp = controller1.text +
                      controller2.text +
                      controller3.text +
                      controller4.text;
                  if (finalOtp.length == 4) {
                    widget.onCompleteTyping(finalOtp);
                  }
                },
              ),
            ],
          ),
        ),
        const Spacer(),
        ValueListenableBuilder(
          valueListenable: canResendNotifier,
          builder: (context, canResend, _) {
            return IconButton(
              onPressed: canResend
                  ? () {
                      startTimer();
                      widget.onResend();
                    }
                  : null,
              icon: Icon(
                Icons.refresh,
                size: 36.r,
              ),
            );
          },
        ),
        ValueListenableBuilder(
            valueListenable: secondLeftNotifier,
            builder: (context, secondLeft, _) {
              return Text(
                "${(secondLeft ~/ 60).toString().padLeft(2, "0")}:${(secondLeft % 60).toString().padLeft(2, "0")}",
                style: TextStyle(fontSize: AppFontSizes.xLarge),
              );
            }),
      ],
    );
  }
}

class _OtpTextFieldDigit extends StatelessWidget {
  final bool last;
  final bool first;
  final void Function()? onCompleteTyping;
  final void Function() onChanged;

  const _OtpTextFieldDigit({
    required this.controller,
    required this.first,
    required this.last,
    required this.onChanged,
    this.onCompleteTyping,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: .055.sh,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        autofocus: true,
        onTap: () {
          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length));
        },
        onChanged: (value) {
          if (value.length > 1) {
            controller.text = value.characters.last;
            FocusScope.of(context).nextFocus();
          }
          if (value.length == 1 && last == false) {
            FocusScope.of(context).nextFocus();
          }
          if (value.length == 1 && last == true) {
            FocusScope.of(context).unfocus();
            if (onCompleteTyping != null) {
              onCompleteTyping!();
            }
          }
          if (value.isEmpty && first == false) {
            FocusScope.of(context).previousFocus();
          }
          onChanged();
        },
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.r))),
      ),
    );
  }
}
