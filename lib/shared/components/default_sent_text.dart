import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/colors.dart';

class DefaultSentText extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onPressedButton;
  final String hintText;

  const DefaultSentText(
      {Key? key,
      required this.controller,
      required this.onPressedButton,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!, width: 1.0.w),
        borderRadius: BorderRadius.circular(10.0.r),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0).r,
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Container(
            height: 40.0.h,
            color: blueColor,
            child: MaterialButton(
                onPressed: onPressedButton,
                minWidth: 1.0,
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 16.0.r,
                )),
          ),
        ],
      ),
    );
  }
}
