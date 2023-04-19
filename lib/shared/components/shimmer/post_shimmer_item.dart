import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/shared/components/shimmer/shimmer.dart';

class DefaultPostShimmerItem extends StatelessWidget {
  const DefaultPostShimmerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.r, vertical: 5.0.r),
              child: Column(
                children: [
                  Row(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            SizedBox(
                              height: 5.0.h,
                            ),
                            DefaultShimmerItem(
                                childWidget: Container(
                              color: Colors.white,
                              width: 100.0.w,
                              height: 7.0.h,
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0).r,
                    child: Column(
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
            ),
        separatorBuilder: (context, index) => SizedBox(
              height: 10.0.h,
            ),
        itemCount: 20);
  }
}
