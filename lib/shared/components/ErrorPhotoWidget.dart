import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/colors.dart';

class DefaultErrorPhotoWidget extends StatelessWidget {
  double size;

  DefaultErrorPhotoWidget({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.person,
      color: darkGreyColor,
      size: size,
    );
  }
}
