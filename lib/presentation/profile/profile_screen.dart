import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_app/data/app_data/user_data.dart';
import 'package:social_app/presentation/profile/cubit/profile_cubit.dart';
import 'package:social_app/presentation/profile/cubit/profile_states.dart';
import 'package:social_app/shared/components/ErrorPhotoWidget.dart';

import '../../router/router_const.dart';
import '../../router/screen_arguments.dart';
import '../../shared/components/divider.dart';
import '../../shared/components/link_text_uri.dart';
import '../../shared/components/shimmer/post_shimmer_item.dart';
import '../../shared/style/colors.dart';
import '../comments/comments_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getPosts(context: context),
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ProfileCubit cubit = ProfileCubit.get(context);
          double screenHeight = MediaQuery.of(context).size.height -
              MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .padding
                  .top;

          return Scaffold(
              appBar: AppBar(
                title: const Text('Profile'),
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(
                            width: double.infinity,
                            height: 0.20.h * MediaQuery.of(context).size.height,
                            child: Image.network(
                              userModel?.coverPhoto ?? '',
                              fit: BoxFit.cover,
                            )),
                        Positioned(
                          bottom: 5.h,
                          right: 5.w,
                          child: InkWell(
                            onTap: () {
                              // TODO: Change cover photo
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              radius: 20.0.r,
                              child: Icon(
                                Icons.camera_alt,
                                size: 25.0.r,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 8.0.w,
                          bottom: -30.h,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              CircleAvatar(
                                radius: 63.0.r,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 60.0.r,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(60.0.r),
                                    child: CachedNetworkImage(
                                      imageUrl: userModel?.photo ?? '',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          DefaultErrorPhotoWidget(size: 60.0.r),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: -3.0.h,
                                right: -3.0.w,
                                child: InkWell(
                                  onTap: () {
                                    // TODO: Change profile photo
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey[300],
                                    radius: 18.0.r,
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 20.0.r,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 35.0.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0).r,
                      child: Text(
                        userModel?.name ?? '',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0.h,
                    ),
                    ConditionalBuilder(
                      condition: checkPostDataHasReturned(cubit),
                      builder: (context) => ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cubit.posts.length,
                        itemBuilder: (context, index) {
                          if (cubit.posts.isNotEmpty) {
                            int itemIndex = cubit.posts.length - 1 - index;
                            return Card(
                              color: Colors.grey[80],
                              elevation: 3.0,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0.r, vertical: 5.0.r),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30.0.r),
                                          child: userModel?.photo != null
                                              ? CachedNetworkImage(
                                                  imageUrl:
                                                      userModel?.photo ?? '',
                                                  height: 50.0.r,
                                                  width: 50.0.r,
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                  fit: BoxFit.cover,
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      DefaultErrorPhotoWidget(
                                                          size: 50.0.sp),
                                                )
                                              : const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                        ),
                                        SizedBox(
                                          width: 8.0.w,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                userModel?.name ?? '',
                                                style: TextStyle(
                                                  fontSize: 16.0.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                              ),
                                              Text(
                                                cubit.posts[itemIndex]
                                                        .postTime ??
                                                    '',
                                                style: TextStyle(
                                                  fontSize: 14.0.sp,
                                                  color: darkGreyColor,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.more_horiz,
                                              color: darkGreyColor,
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15.0.h,
                                    ),
                                    if (cubit.posts[itemIndex].postText != '')
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            child: SelectableText.rich(TextSpan(
                                              children: extractText(
                                                  cubit.posts[itemIndex]
                                                          .postText ??
                                                      '',
                                                  context),
                                              style: TextStyle(
                                                  fontSize: 16.0.sp,
                                                  color: darkGreyColor),
                                            )),
                                          ),
                                          SizedBox(
                                            height: 5.0.h,
                                          ),
                                        ],
                                      ),
                                    if (cubit
                                        .posts[itemIndex].images.isNotEmpty)
                                      Column(
                                        children: [
                                          CarouselSlider.builder(
                                              itemCount: cubit
                                                  .imageHeights[itemIndex]
                                                  .length,
                                              itemBuilder: (context,
                                                      sliderIndex, realIndex) =>
                                                  Container(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          cubit.posts[itemIndex]
                                                                          .images[
                                                                      sliderIndex]
                                                                  ['image'] ??
                                                              '',
                                                      height:
                                                          cubit.imageHeights[
                                                                  itemIndex]
                                                              [sliderIndex],
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  downloadProgress) =>
                                                              Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress,
                                                        ),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                    ),
                                                  ),
                                              options: CarouselOptions(
                                                enlargeCenterPage: false,
                                                autoPlay: false,
                                                height: cubit.sliderHeights[
                                                        itemIndex] /
                                                    2,
                                                enableInfiniteScroll: false,
                                                viewportFraction: 1.0,
                                                onPageChanged:
                                                    (sliderIndex, reason) {
                                                  cubit.changeSliderIndex(
                                                      itemIndex: itemIndex,
                                                      sliderIndex: sliderIndex);
                                                },
                                              )),
                                          SizedBox(
                                            height: 5.0.h,
                                          ),
                                          AnimatedSmoothIndicator(
                                            activeIndex:
                                                cubit.sliderIndexes[itemIndex],
                                            count: cubit
                                                .posts[itemIndex].images.length,
                                            effect: ExpandingDotsEffect(
                                                dotColor: redColor,
                                                activeDotColor: blueColor,
                                                dotHeight: 16.0.h,
                                                dotWidth: 16.0.w),
                                          ),
                                        ],
                                      ),
                                    defaultPostDivider(),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            cubit.likePost(
                                                context: context,
                                                postModel:
                                                    cubit.posts[itemIndex]);
                                          },
                                          icon: SvgPicture.asset(
                                            cubit.likedMap[cubit
                                                        .posts[itemIndex]
                                                        .postId] ??
                                                    false
                                                ? 'assets/images/liked.svg'
                                                : 'assets/images/no_like.svg',
                                            width: 25.0.r,
                                            height: 25.0.r,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                              isScrollControlled: true,
                                              context: context,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20.0.r),
                                                    topRight: Radius.circular(
                                                        20.0.r)),
                                              ),
                                              builder: (context) =>
                                                  CommentsScreen(
                                                screenHeight: screenHeight,
                                                postId: cubit.posts[itemIndex]
                                                        .postId ??
                                                    '',
                                              ),
                                            );
                                          },
                                          icon: SvgPicture.asset(
                                            'assets/images/comment.svg',
                                            width: 25.0.r,
                                            height: 25.0.r,
                                          ),
                                        ),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {
                                            ScreenArguments args =
                                                ScreenArguments.toLikes(
                                                    likesRef: FirebaseFirestore
                                                        .instance
                                                        .collection('posts')
                                                        .doc(cubit
                                                            .posts[itemIndex]
                                                            .postId)
                                                        .collection('likes'));

                                            Navigator.pushNamed(
                                                context, likesScreen,
                                                arguments: args);
                                          },
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/images/like.svg',
                                                width: 30.0.r,
                                                height: 30.0.r,
                                              ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              Text(
                                                cubit.posts[itemIndex].postLikes
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 16.0.sp,
                                                  color: darkGreyColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                              isScrollControlled: true,
                                              context: context,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20.0.r),
                                                    topRight: Radius.circular(
                                                        20.0.r)),
                                              ),
                                              builder: (context) =>
                                                  CommentsScreen(
                                                screenHeight: screenHeight,
                                                postId: cubit.posts[itemIndex]
                                                        .postId ??
                                                    '',
                                              ),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/images/comments.svg',
                                                width: 30.0.r,
                                                height: 30.0.r,
                                              ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              Text(
                                                cubit.posts[itemIndex]
                                                    .postComments
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 16.0.sp,
                                                  color: darkGreyColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                'No posts yet',
                                style: TextStyle(
                                    fontSize: 24.0.sp,
                                    color: darkGreyColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 5.0.h,
                        ),
                      ),
                      fallback: (context) => const DefaultPostShimmerItem(),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }

  defaultPostDivider() => Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0.r, horizontal: 20.0.r),
        child: const DefaultDivider(),
      );

  checkPostDataHasReturned(ProfileCubit cubit) =>
      cubit.posts.length == cubit.sliderHeights.length &&
      cubit.posts.length == cubit.sliderIndexes.length &&
      cubit.posts.length == cubit.likedMap.length &&
      cubit.posts.length == cubit.imageHeights.length;
}
