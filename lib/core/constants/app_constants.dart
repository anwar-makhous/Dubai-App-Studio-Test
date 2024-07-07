import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AppColors {
  AppColors._();
  static const deepBlue = Color(0xFF040273);
  static const lightGrey = Color(0xFFDDDDDD);
}

class AppFontSizes {
  AppFontSizes._();
  static final xLarge = 28.sp;
  static final large = 24.sp;
  static final medium = 20.sp;
  static final small = 16.sp;
  static final tiny = 12.sp;
}

class AppAnimation {
  AppAnimation._();
  static const Duration duration = Duration(milliseconds: 400);
  static const Curve curve = Curves.easeInToLinear;
}

class AppConfig {
  AppConfig._();
  static const int maxBeneficiariesCount = 5;
  static const List<int> rechargeOptions = [5, 10, 20, 30, 50, 75, 100];
  static const String apiBaseUrl = "https://api.anwar-makhous.com";
  static const String countryCode = "+971";
  static const String currency = "AED";
  static final NumberFormat numberFormat =
      NumberFormat.decimalPatternDigits(decimalDigits: 2);
  static final DateFormat dateFormat = DateFormat.yMMMMEEEEd();
}
