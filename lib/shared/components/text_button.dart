import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/shared/style/colors.dart';

class DefaultTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? textColor;
  final double? size;
   const DefaultTextButton(
      {Key? key, required this.text, required this.onPressed, this.textColor,  this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: size ?? 14.sp,
          color: textColor??blueColor,
        ),
      ),
    );
  }
}
