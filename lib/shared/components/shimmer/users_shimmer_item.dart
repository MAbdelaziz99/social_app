import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/shared/components/shimmer/shimmer.dart';

import '../divider.dart';

class DefaultUsersShimmerItem extends StatelessWidget {
  const DefaultUsersShimmerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10.0.r),
        child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultShimmerItem(
                        childWidget: Container(
                      color: Colors.white,
                      height: 50.0.h,
                      width: 50.0.h,
                    )),
                    SizedBox(
                      width: 7.0.w,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DefaultShimmerItem(
                              childWidget: Container(
                            color: Colors.white,
                            height: 10.0.h,
                          )),
                          SizedBox(
                            height: 5.0.h,
                          ),
                          DefaultShimmerItem(
                              childWidget: Container(
                            color: Colors.white,
                            height: 10.0.h,
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
            separatorBuilder: (context, index) => SizedBox(height: 5.0.h,),
            itemCount: 20));
  }
}
