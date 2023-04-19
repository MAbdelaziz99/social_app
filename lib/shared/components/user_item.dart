import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/data/models/user_model.dart';

import '../style/colors.dart';
import 'ErrorPhotoWidget.dart';

class DefaultUserItem extends StatelessWidget {

  final UserModel userModel;
  const DefaultUserItem({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(10.0.r),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0.r),
              child: CachedNetworkImage(
                imageUrl: userModel.photo??'',
                width: 50.0.r,
                height: 50.0.r,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) =>
                    DefaultErrorPhotoWidget(size: 30.0.r),
              ),
            ),
            SizedBox(
              width: 7.0.w,
            ),
            Text(
              userModel.name??'',
              style: TextStyle(
                  fontSize: 16.0.sp,
                  color: darkGreyColor,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
