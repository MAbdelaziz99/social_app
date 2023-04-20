import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/data/models/user_model.dart';
import 'package:social_app/shared/components/shimmer/users_shimmer_item.dart';
import 'package:social_app/shared/constatnts.dart';

import '../style/colors.dart';
import 'ErrorPhotoWidget.dart';
import 'divider.dart';

class DefaultUserItem extends StatelessWidget {
  final List<UserModel> users;
  final String usersStatus;

  const DefaultUserItem(
      {Key? key, required this.users, required this.usersStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: usersStatus == FirebaseStatus.success.name,
      builder: (context) => users.isNotEmpty
          ? ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.all(10.0.r),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30.0.r),
                          child: users[index].photo != null ||
                                  users[index].photo != ''
                              ? CachedNetworkImage(
                                  imageUrl: users[index].photo ?? '',
                                  width: 50.0.r,
                                  height: 50.0.r,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      DefaultErrorPhotoWidget(size: 30.0.r),
                                )
                              : const Center(
                                  child: CircularProgressIndicator(),
                                ),
                        ),
                        SizedBox(
                          width: 7.0.w,
                        ),
                        Text(
                          users[index].name ?? '',
                          style: TextStyle(
                              fontSize: 16.0.sp,
                              color: darkGreyColor,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                if (users.length < 2) {
                  return Container();
                }
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0.r,
                  ),
                  child: const DefaultDivider(),
                );
              },
              itemCount: users.length)
          : SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: Text(
                  'No users yet',
                  style: TextStyle(
                    fontSize: 24.0.sp,
                    fontWeight: FontWeight.normal,
                    color: darkGreyColor,
                  ),
                ),
              ),
            ),
      fallback: (context) => const DefaultUsersShimmerItem(),
    );
  }
}
