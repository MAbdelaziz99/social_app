import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/colors.dart';

defaultSuccessSnackBar({required String message, required context}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(milliseconds: 3 * 1000),
    content: Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 16.sp, color: Colors.white,),
    ),
    backgroundColor: greenColor,
  ));
}

defaultErrorSnackBar({required String message, required context}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(milliseconds: 3 * 1000),
    content: Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 16.sp, color: Colors.white,),
    ),
    backgroundColor: redColor,
  ));
}