import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../style/colors.dart';

ProgressDialog defaultProgressDialog(
    {required context, required String message}) {
  ProgressDialog progressDialog = ProgressDialog(
    context,
    type: ProgressDialogType.normal,
    isDismissible: false,
    showLogs: true,
  );
  progressDialog.style(
      borderRadius: 10.0.r,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeIn,
      message: message,
      messageTextStyle: TextStyle(color: blueColor, fontSize: 16.0.sp),
      textAlign: TextAlign.right,
      progressWidget: Padding(
        padding: const EdgeInsets.all(8.0).w,
        child: CircularProgressIndicator(color: blueColor, strokeWidth: 3.w),
      ));

  return progressDialog;
}
