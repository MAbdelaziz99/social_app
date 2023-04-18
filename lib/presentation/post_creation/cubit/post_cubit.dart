import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/presentation/post_creation/cubit/post_states.dart';
import 'package:social_app/presentation/post_creation/image/post_image_picker.dart';

import '../../../shared/dialogs/image_picker_dialog.dart';

class PostCubit extends Cubit<PostStates> {
  PostCubit() : super(PostInitialState());

  static PostCubit get(context) => BlocProvider.of(context);

  List<Map<String, dynamic>> images = [];

  double sliderHeight = 0.0;
  List<double> imageHeight = [];

  pickImage({required context, required isCamera}) {
    PostImagePicker postImagePicker = PostImagePicker.getInstance();
    postImagePicker.pickImage(
        context: context,
        isCamera: isCamera,
        onImagePickedListen: (imageMaps) {
          images = imageMaps;
          for (var image in images) {
            double finalHeight = (int.parse(image['imageHeight']) *
                    MediaQuery.of(context).size.height.toInt()) /
                int.parse(image['imageWidth']).toInt();

            imageHeight.add(finalHeight);
            if (finalHeight > sliderHeight) {
              sliderHeight = finalHeight;
            }
          }
          emit(PostPickImageState());
        });
  }

  removeImage() {
    images = [];
    emit(PostRemoveImageState());
  }

  showImagePickerDialogAndPickImage({required context}) => showDialog(
        context: context,
        builder: (context) => ImagePickerDialog(
          onGalleryPressed: () {
            pickImage(context: context, isCamera: false);
          },
          onCameraPressed: () {
            pickImage(context: context, isCamera: true);
          },
        ),
      );

  int sliderIndex = 0;

  changeSliderIndex({required currentIndex}) {
    sliderIndex = currentIndex;
    emit(PostChangeSliderIndex());
  }
}
