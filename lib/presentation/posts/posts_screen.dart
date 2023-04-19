import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_app/presentation/posts/cubit/posts_cubit.dart';
import 'package:social_app/presentation/posts/cubit/posts_states.dart';
import 'package:social_app/router/router_const.dart';
import 'package:social_app/router/screen_arguments.dart';
import 'package:social_app/shared/components/ErrorPhotoWidget.dart';
import 'package:social_app/shared/components/divider.dart';
import 'package:social_app/shared/components/navigator.dart';
import 'package:social_app/shared/components/shimmer/post_shimmer_item.dart';
import 'package:social_app/shared/constatnts.dart';
import 'package:social_app/shared/style/colors.dart';
import '../../shared/components/link_text_uri.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        PostsCubit cubit = PostsCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              'Posts ',
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0).r,
                child: IconButton(
                    onPressed: () {
                      navigateTo(
                          context: context, routeName: searchForUsersScreen);
                    },
                    icon: Icon(
                      Icons.search,
                      size: 30.0.r,
                    )),
              ),
            ],
          ),
          body: ConditionalBuilder(
            condition: checkPostDataHasReturned(cubit),
            builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: cubit.posts.length,
              itemBuilder: (context, index) {
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
                              borderRadius: BorderRadius.circular(30.0.r),
                              child: cubit.posts[itemIndex].userModel?.photo !=
                                      null
                                  ? CachedNetworkImage(
                                      imageUrl: cubit.posts[itemIndex].userModel
                                              ?.photo ??
                                          '',
                                      height: 50.0.r,
                                      width: 50.0.r,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          DefaultErrorPhotoWidget(
                                              size: 50.0.sp),
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                            ),
                            SizedBox(
                              width: 8.0.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cubit.posts[itemIndex].userModel?.name ?? '',
                                  style: TextStyle(
                                    fontSize: 16.0.sp,
                                    color: blueColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  cubit.posts[itemIndex].postTime ?? '',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: darkGreyColor,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            if (myUid == cubit.posts[itemIndex].userId)
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
                                      cubit.posts[itemIndex].postText ?? '',
                                      context),
                                  style: TextStyle(
                                      fontSize: 16.0.sp, color: darkGreyColor),
                                )),
                              ),
                              SizedBox(
                                height: 5.0.h,
                              ),
                            ],
                          ),
                        if (cubit.posts[itemIndex].images.isNotEmpty)
                          Column(
                            children: [
                              CarouselSlider.builder(
                                  itemCount:
                                      cubit.imageHeights[itemIndex].length,
                                  itemBuilder: (context, sliderIndex,
                                          realIndex) =>
                                      Container(
                                        alignment: Alignment.topCenter,
                                        child: CachedNetworkImage(
                                          imageUrl: cubit.posts[itemIndex]
                                                      .images[sliderIndex]
                                                  ['image'] ??
                                              '',
                                          height: cubit.imageHeights[itemIndex]
                                              [sliderIndex],
                                          width:
                                              MediaQuery.of(context).size.width,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                            child: CircularProgressIndicator(
                                              value: downloadProgress.progress,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                  options: CarouselOptions(
                                    enlargeCenterPage: false,
                                    autoPlay: false,
                                    height: cubit.sliderHeights[itemIndex] / 2,
                                    enableInfiniteScroll: false,
                                    viewportFraction: 1.0,
                                    onPageChanged: (sliderIndex, reason) {
                                      cubit.changeSliderIndex(
                                          itemIndex: itemIndex,
                                          sliderIndex: sliderIndex);
                                    },
                                  )),
                              SizedBox(
                                height: 5.0.h,
                              ),
                              AnimatedSmoothIndicator(
                                activeIndex: cubit.sliderIndexes[itemIndex],
                                count: cubit.posts[itemIndex].images.length,
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
                                    postModel: cubit.posts[itemIndex]);
                              },
                              icon: SvgPicture.asset(
                                cubit.likedMap[cubit.posts[itemIndex].postId] ??
                                        false
                                    ? 'assets/images/like.svg'
                                    : 'assets/images/no_like.svg',
                                width: 25.0.r,
                                height: 25.0.r,
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                'assets/images/comment.svg',
                                width: 25.0.r,
                                height: 25.0.r,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                ScreenArguments args = ScreenArguments.toLikes(
                                    likesRef: FirebaseFirestore.instance
                                        .collection('Posts')
                                        .doc(cubit.posts[itemIndex].postId)
                                        .collection('Likes'));

                                Navigator.pushNamed(context, likesScreen,
                                    arguments: args);
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/like.svg',
                                    width: 25.0.r,
                                    height: 25.0.r,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    cubit.posts[itemIndex].postLikes.toString(),
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
                              onTap: () {},
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/comments.svg',
                                    width: 25.0.r,
                                    height: 25.0.r,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    cubit.posts[itemIndex].postComments
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
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 5.0.h,
              ),
            ),
            fallback: (context) => const DefaultPostShimmerItem(),
          ),
        );
      },
    );
  }

  defaultPostDivider() => Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0.r, horizontal: 20.0.r),
        child: const DefaultDivider(),
      );

  checkPostDataHasReturned(PostsCubit cubit) =>
      cubit.posts.length == cubit.sliderHeights.length &&
      cubit.posts.length == cubit.sliderIndexes.length &&
      cubit.posts.length == cubit.likedMap.length &&
      cubit.posts.length == cubit.imageHeights.length;
}
