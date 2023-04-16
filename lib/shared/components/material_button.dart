import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const DefaultButton({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(10.0).r),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 18.0.sp, color: Colors.white),
        ),
      ),
    );
  }
}
