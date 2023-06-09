import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../style/colors.dart';

defaultSuccessSnackBar({required String title, required String message}) {
  Get.snackbar(
    title,
    message,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(milliseconds: 1500),
    backgroundColor: greenColor,
  );
}

defaultErrorSnackBar({required String title, required String message}) {
  Get.snackbar(
    title,
    message,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(milliseconds: 1500),
    backgroundColor: redColor,
  );
}
