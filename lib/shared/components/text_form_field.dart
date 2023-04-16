import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final bool? obscureText;
  final String? Function(String? value) validator;

  const DefaultTextFormField({Key? key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText,
    required this.validator,
    this.suffixIcon,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0.h,
      child: TextFormField(
        controller: controller,
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
          suffixIcon: Icon(suffixIcon),
        ),
        maxLines: 1,
        obscureText: obscureText??false,
        validator: validator,
      ),
    );
  }
}
