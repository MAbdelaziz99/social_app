import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/colors.dart';

class DefaultTitleDialog extends StatelessWidget {
  final String title;
  const DefaultTitleDialog({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: blueColor,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(12.0).r,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0.sp,
          ),
        ),
      ),
    );;
  }
}
