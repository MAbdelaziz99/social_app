import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_app/presentation/comments/cubit/comments_cubit.dart';
import 'package:social_app/presentation/comments/cubit/comments_states.dart';
import 'package:social_app/shared/components/default_sent_text.dart';
import 'package:social_app/shared/components/shimmer/comment_shimmer_item.dart';
import 'package:social_app/shared/components/snackbar.dart';
import '../../data/app_data/user_data.dart';
import '../../router/router_const.dart';
import '../../router/screen_arguments.dart';
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
        create: (context) => CommentsCubit()..getComments(postId: postId),
        child: BlocConsumer<CommentsCubit, CommentsStates>(
          listener: (context, state) {},
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
                    ConditionalBuilder(
                      condition: cubit.checkCommentsDataIsGot(cubit),
                      builder: (context) => Expanded(
                          child: Column(
                        children: [
                          Expanded(
                              child: commentsWidget(
                                  context: context, cubit: cubit)),
                          sentCommentWidget(context: context, cubit: cubit),
                        ],
                      )),
                      fallback: (context) =>
                          const Expanded(child: DefaultCommentShimmerItem()),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget commentsWidget({required context, required CommentsCubit cubit}) =>
      Padding(
        padding: const EdgeInsets.all(8.0).r,
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              int itemIndex = cubit.comments.length - 1 - index;
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.0.r),
                    child: CachedNetworkImage(
                      imageUrl:
                          cubit.comments[itemIndex].userModel?.photo ?? '',
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
                                cubit.comments[itemIndex].userModel?.name ?? '',
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
                                cubit.comments[itemIndex].commentText ?? '',
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
                              cubit.comments[itemIndex].commentTime ?? '',
                              style: TextStyle(
                                fontSize: 14.0.sp,
                                color: darkGreyColor,
                              ),
                            ),
                            SizedBox(
                              width: 10.0.w,
                            ),
                            InkWell(
                              onTap: () {
                                cubit.likeComment(
                                    postId: postId,
                                    commentModel: cubit.comments[itemIndex]);
                              },
                              child: Text(
                                'Like',
                                style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: cubit.likedMap[cubit
                                                    .comments[itemIndex]
                                                    .commentId ??
                                                ''] ??
                                            false
                                        ? blueColor
                                        : darkGreyColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 30.0.w,
                            ),
                            InkWell(
                              onTap: () {
                                ScreenArguments args = ScreenArguments.toLikes(
                                    likesRef: FirebaseFirestore.instance
                                        .collection('posts')
                                        .doc(postId)
                                        .collection('comments')
                                        .doc(
                                            cubit.comments[itemIndex].commentId)
                                        .collection('likes'));

                                Navigator.pushNamed(context, likesScreen,
                                    arguments: args);
                              },
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
                                    '${cubit.comments[itemIndex].commentLikes}',
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
            },
            separatorBuilder: (context, index) => SizedBox(
                  height: 20.0.h,
                ),
            itemCount: cubit.comments.length),
      );

  Widget sentCommentWidget({required context, required CommentsCubit cubit}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0).r,
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
              child: DefaultSentText(
                  controller: _commentController,
                  onPressedButton: () {
                    if (_commentController.text.isEmpty) {
                      defaultErrorSnackBar(
                          title: 'Add a comment',
                          message: 'Please enter your comment');
                    } else {
                      cubit.addComment(
                          context: context,
                          postId: postId,
                          commentController: _commentController);
                    }
                  },
                  hintText: 'Type your comment ...'),
            ),
          ],
        ),
      );
}
