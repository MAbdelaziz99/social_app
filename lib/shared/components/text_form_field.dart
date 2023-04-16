import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIcon;
  final bool? obscureText;
  final String errorMsg;
  final TextInputType keyboardType;

  const DefaultTextFormField({Key? key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText,
    required this.errorMsg,
    required this.keyboardType,
    this.onSuffixIcon,
    this.suffixIcon,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0.h,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType ,
        decoration: InputDecoration(
          border:
          OutlineInputBorder(borderRadius: BorderRadius
              .circular(10.0)
              .r),
          label: Text(
            hintText,
            style: TextStyle(
              fontSize: 16.0.sp,
            ),
          ),
          prefixIcon: Icon(prefixIcon),
          suffixIcon: IconButton(icon: Icon(suffixIcon), onPressed: onSuffixIcon,),
        ),
        maxLines: 1,
        obscureText: obscureText??false,
        validator: (value) {
          if(value == null || value.isEmpty){
            return errorMsg;
          }
          return null;
        },
      ),
    );
  }
}
