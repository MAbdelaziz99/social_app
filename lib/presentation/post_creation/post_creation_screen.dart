import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_app/presentation/post_creation/cubit/add_post_cubit.dart';
import 'package:social_app/presentation/post_creation/cubit/add_post_states.dart';
import 'package:social_app/shared/components/ErrorPhotoWidget.dart';
import 'package:social_app/shared/components/text_button.dart';
import 'package:social_app/shared/constatnts.dart';
import 'package:social_app/shared/style/colors.dart';

import '../../data/app_data/user_data.dart';

class PostCreationScreen extends StatelessWidget {
  final TextEditingController _postController = TextEditingController();

  PostCreationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddPostCubit>(
      create: (context) => AddPostCubit(),
      child: BlocConsumer<AddPostCubit, AddPostStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AddPostCubit cubit = AddPostCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text('Post Creation'),
              actions: [
                DefaultTextButton(
                  text: 'Post',
                  onPressed: () {
                    cubit.addPost(
                        context: context, postController: _postController);
                  },
                  size: 20.0.sp,
                ),
              ],
              leading: DefaultTextButton(
                text: 'Discard',
                onPressed: () {},
                size: 20.0.sp,
                textColor: redColor,
              ),
              leadingWidth: 100.0.w,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                height: cubit.images.isEmpty
                    ? getScreenHeightWithoutSafeArea(context)
                    : null,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0).r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (cubit.addPostStatus == FirebaseStatus.loading.name)
                        LinearProgressIndicator(minHeight: 1.3.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0).r,
                        child: Row(
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
                            SizedBox(
                              width: 10.0.w,
                            ),
                            Expanded(
                              child: Text(
                                userModel?.name ?? '',
                                style: TextStyle(
                                  fontSize: 16.0.sp,
                                  color: blueColor,
                                  overflow: TextOverflow.visible
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3.0.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
                        child: Divider(
                          height: 5.0.h,
                          color: darkGreyColor,
                        ),
                      ),
                      cubit.images.isEmpty
                          ? withoutImageWidget(context: context, cubit: cubit)
                          : withImageWidget(context: context, cubit: cubit),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget withoutImageWidget({required context, required AddPostCubit cubit}) =>
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: _postController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'What do you want to write ? ',
                  hintStyle: TextStyle(
                    color: darkGreyColor,
                    fontSize: 16.0.sp,
                  ),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            DefaultTextButton(
              text: 'Pick image',
              onPressed: () {
                cubit.showImagePickerDialogAndPickImage(context: context);
              },
              size: 16.0.sp,
            ),
          ],
        ),
      );

  Widget withImageWidget({required context, required AddPostCubit cubit}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _postController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'What do you want to write ? ',
              hintStyle: TextStyle(
                color: darkGreyColor,
                fontSize: 16.0.sp,
              ),
            ),
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
          SizedBox(
            height: 8.0.h,
          ),
          Stack(
            children: [
              Column(
                children: [
                  CarouselSlider.builder(
                      itemCount: cubit.images.length,
                      itemBuilder: (context, index, realIndex) => Image.file(
                            cubit.images[index]['image'],
                            height: cubit.imageHeights[index] / 2,
                            width: MediaQuery.of(context).size.width,
                          ),
                      options: CarouselOptions(
                        height: cubit.sliderHeight / 2,
                        enlargeCenterPage: true,
                        autoPlay: false,
                        enableInfiniteScroll: false,
                        viewportFraction: 1.0,
                        onPageChanged: (index, reason) =>
                            cubit.changeSliderIndex(currentIndex: index),
                      )),
                  SizedBox(
                    height: 8.0.h,
                  ),
                  AnimatedSmoothIndicator(
                    activeIndex: cubit.sliderIndex,
                    count: cubit.images.length,
                    effect: ExpandingDotsEffect(
                        dotColor: redColor,
                        activeDotColor: blueColor,
                        dotHeight: 16.0.h,
                        dotWidth: 16.0.w),
                  ),
                ],
              ),
              Positioned(
                  top: 1.0.h,
                  right: 1.0.w,
                  child: IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: darkGreyColor,
                      size: 30.0.r,
                    ),
                    onPressed: () {
                      cubit.removeImage();
                    },
                  ))
            ],
          ),
          SizedBox(
            height: 8.0.h,
          ),
        ],
      );
}
