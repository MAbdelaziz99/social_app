import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/colors.dart';

class DefaultDivider extends StatelessWidget {
  const DefaultDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 5.0.h,
      color: darkGreyColor,
    );
  }
}
