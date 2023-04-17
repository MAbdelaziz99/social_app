import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/data/data.dart';
import 'package:social_app/shared/components/ErrorPhotoWidget.dart';
import 'package:social_app/shared/style/colors.dart';

class PostCreationScreen extends StatelessWidget {
  const PostCreationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Post Creation'),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                'Post',
                style: TextStyle(
                  color: blueColor,
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.0).r,
                  child: CachedNetworkImage(
                    imageUrl: userModel?.photo ?? '',
                    height: 50.0.r,
                    width: 50.0.r,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        DefaultErrorPhotoWidget(size: 50.0.sp),
                  ),
                ),

                SizedBox(width: 10.0.w,),

                Text(
                  userModel?.name??'',
                  style: TextStyle(
                    fontSize: 18.0.sp,
                    color: blueColor,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
