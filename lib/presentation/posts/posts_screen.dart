import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_app/presentation/posts/cubit/posts_cubit.dart';
import 'package:social_app/presentation/posts/cubit/posts_states.dart';
import 'package:social_app/router/router_const.dart';
import 'package:social_app/shared/components/ErrorPhotoWidget.dart';
import 'package:social_app/shared/components/divider.dart';
import 'package:social_app/shared/components/navigator.dart';
import 'package:social_app/shared/constatnts.dart';
import 'package:social_app/shared/style/colors.dart';
import '../../data/data.dart';
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
              'Posts',
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
            condition: allPosts.isNotEmpty,
            builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: allPosts.length,
              itemBuilder: (context, index) {
                int itemIndex = allPosts.length - 1 - index;
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
                              child: CachedNetworkImage(
                                imageUrl:
                                    allPosts[itemIndex].userModel?.photo ?? '',
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
                            SizedBox(
                              width: 8.0.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  allPosts[itemIndex].userModel?.name ?? '',
                                  style: TextStyle(
                                    fontSize: 16.0.sp,
                                    color: blueColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  allPosts[itemIndex].postTime ?? '',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: darkGreyColor,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            if (myUid == allPosts[itemIndex].userId)
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
                        if (allPosts[itemIndex].postText != '')
                          Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: SelectableText.rich(TextSpan(
                                  children: extractText(
                                      allPosts[itemIndex].postText ?? '',
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
                        if (allPosts[itemIndex].images.isNotEmpty)
                          Column(
                            children: [
                              CarouselSlider.builder(
                                  itemCount: allImageHeights[itemIndex].length,
                                  itemBuilder: (context, sliderIndex,
                                          realIndex) =>
                                      Container(
                                        alignment: Alignment.topCenter,
                                        child: CachedNetworkImage(
                                          imageUrl: allPosts[itemIndex]
                                                      .images[sliderIndex]
                                                  ['image'] ??
                                              '',
                                          height: allImageHeights[itemIndex]
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
                                    height: sliderHeights[itemIndex] / 2,
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
                                activeIndex: sliderIndexes[itemIndex],
                                count: allPosts[itemIndex].images.length,
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
                                    context: context, index: itemIndex);
                              },
                              icon: SvgPicture.asset(
                                likedMap[allPosts[itemIndex].postId] ?? false
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
                            SvgPicture.asset(
                              'assets/images/like.svg',
                              width: 25.0.r,
                              height: 25.0.r,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              allPosts[itemIndex].postLikes.toString(),
                              style: TextStyle(
                                fontSize: 16.0.sp,
                                color: darkGreyColor,
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            SvgPicture.asset(
                              'assets/images/comments.svg',
                              width: 25.0.r,
                              height: 25.0.r,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              allPosts[itemIndex].postComments.toString(),
                              style: TextStyle(
                                fontSize: 16.0.sp,
                                color: darkGreyColor,
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
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  defaultPostDivider() => Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0.r, horizontal: 20.0.r),
        child: const DefaultDivider(),
      );
}
