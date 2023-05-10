import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/presentation/post_creation/cubit/add_post_states.dart';
import 'package:social_app/presentation/post_creation/firebase/add_post.dart';
import 'package:social_app/presentation/post_creation/image/post_image_picker.dart';
import 'package:social_app/shared/components/snackbar.dart';
import 'package:social_app/shared/constatnts.dart';

import '../../../shared/dialogs/image_picker_dialog.dart';

class AddPostCubit extends Cubit<AddPostStates> {
  AddPostCubit() : super(PostCreationInitialState());

  static AddPostCubit get(context) => BlocProvider.of(context);

  List<Map<String, dynamic>> images = [];

  double sliderHeight = 0.0;
  List<double> imageHeights = [];

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

            imageHeights.add(finalHeight);
            if (finalHeight > sliderHeight) {
              sliderHeight = finalHeight;
            }
          }
          emit(PostCreationPickImageState());
        });
  }

  removeImage() {
    images = [];
    emit(PostCreationRemoveImageState());
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
    emit(PostCreationChangeSliderIndex());
  }

  String addPostStatus = '';

  addPost({required context, required TextEditingController postController}) {
    addPostStatus = FirebaseStatus.loading.name;
    emit(PostCreationLoadingState());
    FocusManager.instance.primaryFocus?.unfocus();
    AddPost postUploading = AddPost.getInstance();
    postUploading.addPost(
        postText: postController.text,
        images: images,
        onSuccessListen: (value) {
          postController.text = '';
          images = [];
          defaultSuccessSnackBar(
              message: 'Post uploaded successfully', title: 'Add a post');
          addPostStatus = FirebaseStatus.success.name;
          emit(PostCreationSuccessState());
        },
        onErrorListen: (error) {
          defaultErrorSnackBar(
              message: 'Failed to upload post, try again', title: 'Add a post');
          addPostStatus = FirebaseStatus.error.name;
          emit(PostCreationErrorState());
        });
  }
}
