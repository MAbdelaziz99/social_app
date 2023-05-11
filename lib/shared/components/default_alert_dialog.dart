import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/colors.dart';

class DefaultAlertDialog extends StatelessWidget {
  final String titleText;
  final String messageText;
  final String button1Text;
  final String button2Text;
  final VoidCallback onPressed1;
  final VoidCallback onPressed2;

  const DefaultAlertDialog(
      {Key? key,
      required this.titleText,
      required this.messageText,
      required this.button1Text,
      required this.button2Text,
      required this.onPressed1,
      required this.onPressed2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 10.0.r, vertical: 5.0.r),
      buttonPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.all(5.0.r),
      iconPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      title: Container(
        color: Colors.blue,
        padding: EdgeInsets.symmetric(horizontal: 5.0.r),
        height: 20.0.h,
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            titleText,
            style: TextStyle(
              fontSize: 16.0.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            messageText,
            style: TextStyle(
                fontSize: 14.0.sp,
                color: blueColor,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.visible),
          ),
          SizedBox(
            height: 10.0.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 30.0.h,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8.0.r),
                  ),
                  child: MaterialButton(
                    onPressed: onPressed1,
                    child: Text(
                      button1Text,
                      style: TextStyle(
                        fontSize: 16.0.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10.0.w,
              ),
              Expanded(
                child: Container(
                  height: 30.0.h,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8.0.r),
                  ),
                  child: MaterialButton(
                    onPressed: onPressed2,
                    child: Text(
                      button2Text,
                      style: TextStyle(
                        fontSize: 16.0.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
