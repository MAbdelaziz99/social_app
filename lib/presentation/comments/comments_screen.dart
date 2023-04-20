import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_app/presentation/comments/cubit/comments_cubit.dart';
import 'package:social_app/presentation/comments/cubit/comments_states.dart';
import 'package:social_app/shared/constatnts.dart';

import '../../data/app_data/user_data.dart';
import '../../shared/components/ErrorPhotoWidget.dart';
import '../../shared/components/divider.dart';
import '../../shared/style/colors.dart';

class CommentsScreen extends StatelessWidget {
  final double screenHeight;
  final String postId;
  final TextEditingController _commentController = TextEditingController();

  CommentsScreen({
    Key? key,
    required this.screenHeight,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CommentsCubit(),
        child: BlocConsumer<CommentsCubit, CommentsStates>(
          listener: (context, state) {
            if (CommentsCubit.get(context).commentAddingStatus ==
                FirebaseStatus.loading.name) {
              AlertDialog alert = AlertDialog(
                content: Row(
                  children: [
                    const CircularProgressIndicator(),
                    Container(
                        padding: const EdgeInsets.only(left: 7),
                        child: Text(
                          "Add a comment",
                          style: TextStyle(
                              fontSize: 16.0.sp, color: darkGreyColor),
                        )),
                  ],
                ),
              );
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            }
          },
          builder: (context, state) {
            CommentsCubit cubit = CommentsCubit.get(context);
            return SizedBox(
              height: screenHeight,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_outlined,
                              color: darkGreyColor,
                            )),
                        Expanded(
                            child: Align(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            'Comments',
                            style: TextStyle(
                              fontSize: 20.0.sp,
                              color: darkGreyColor,
                            ),
                          ),
                        )),
                      ],
                    ),
                    const DefaultDivider(),
                    Expanded(
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => _commentsWidget(),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 20.0.h,
                                ),
                            itemCount: 30)),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 5.0)
                          .r,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30.0.r),
                            child: CachedNetworkImage(
                              imageUrl: userModel?.photo ?? '',
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              width: 40.0.r,
                              height: 40.0.r,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => Center(
                                child: DefaultErrorPhotoWidget(
                                  size: 30.0.r,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.0.w,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _commentController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(24.0).r),
                                hintText: 'Write a comment',
                                hintStyle: TextStyle(
                                  fontSize: 16.0.sp,
                                ),
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              onChanged: (value) {
                                cubit.checkCommentTextIsEmptyOrNot(value);
                              },
                            ),
                          ),
                          IconButton(
                              onPressed: !cubit.isCommentEmpty
                                  ? () {
                                      cubit.addComment(
                                          context: context,
                                          postId: postId,
                                          commentController:
                                              _commentController);
                                    }
                                  : null,
                              icon: SvgPicture.asset(
                                'assets/images/add_comment.svg',
                                width: 25.0.r,
                                height: 25.0.r,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget _commentsWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0.r),
            child: CachedNetworkImage(
              imageUrl: userModel?.photo ?? '',
              fit: BoxFit.cover,
              height: 35.0.r,
              width: 35.0.r,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Center(
                child: DefaultErrorPhotoWidget(
                  size: 30.0.r,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10.0.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0).r,
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0).r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userModel?.name ?? '',
                        style: TextStyle(
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 5.0.h,
                      ),
                      Text(
                        'Welocme Hello llloasdgs',
                        style: TextStyle(
                          fontSize: 16.0.sp,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 8.0).r,
                child: Row(
                  children: [
                    Text(
                      'Just now',
                      style: TextStyle(
                        fontSize: 14.0.sp,
                        color: darkGreyColor,
                      ),
                    ),
                    SizedBox(
                      width: 10.0.w,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'Like',
                        style: TextStyle(
                            fontSize: 14.0.sp,
                            color: blueColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 30.0.w,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/like.svg',
                            width: 20.0.r,
                            height: 20.0.r,
                          ),
                          SizedBox(
                            width: 5.0.w,
                          ),
                          Text(
                            '0',
                            style: TextStyle(
                              fontSize: 14.0.sp,
                              color: darkGreyColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      );
}
