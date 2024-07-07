import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TapTwiceToExit extends StatefulWidget {
  final Widget child;

  /// default value is [Duration(seconds: 2)]
  final Duration waitingDuration;
  const TapTwiceToExit({
    super.key,
    required this.child,
    this.waitingDuration = const Duration(seconds: 2),
  });

  @override
  State<TapTwiceToExit> createState() => _TapTwiceToExitState();
}

class _TapTwiceToExitState extends State<TapTwiceToExit> {
  ValueNotifier<bool> canPopNotifier = ValueNotifier<bool>(false);
  late Timer popScopeTimer;

  @override
  void initState() {
    popScopeTimer = Timer(
      widget.waitingDuration,
      () {
        canPopNotifier.value = false;
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    popScopeTimer.cancel();
    super.dispose();
  }

  void _showMessage() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.white,
      width: .5.sw,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      content: Text("Tap again to exit",
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).hintColor)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: canPopNotifier,
      builder: (context, canPop, child) {
        return PopScope(
          canPop: canPop,
          onPopInvoked: (didPop) {
            if (!canPop) {
              canPopNotifier.value = true;
              _showMessage();
            }
            popScopeTimer.cancel();
            popScopeTimer = Timer(
              widget.waitingDuration,
              () {
                canPopNotifier.value = false;
              },
            );
          },
          child: widget.child,
        );
      },
    );
  }
}
