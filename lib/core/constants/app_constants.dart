import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColors {
  static const deepBlue = Color(0xFF040273);
  static const lightGrey = Color(0xFFDDDDDD);
}

class AppFontSizes {
  static final mediumLabel = 28.sp;
  static final smallLabel = 16.sp;
  static final tinyLabel = 12.sp;
}

class AppAnimation {
  static const Duration duration = Duration(milliseconds: 400);
  static const Curve curve = Curves.easeInToLinear;
}

class AppMessages {
  static const String noInternet = 'Please check your connection!';
  static const String error401 = "Unauthorized!";
  static const String error404 = "Page Not Found!";
  static const String error500 = "Server Error!";
  static const String unknown = "Something went wrong!";
  static const String badResponse = "Bad response format!";
}
