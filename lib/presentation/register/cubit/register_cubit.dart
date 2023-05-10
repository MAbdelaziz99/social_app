import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/data/models/user_model.dart';
import 'package:social_app/presentation/register/cubit/register_states.dart';
import 'package:social_app/presentation/register/firebase/register_user.dart';
import 'package:social_app/presentation/register/photo_picker.dart';
import 'package:social_app/router/router_const.dart';
import 'package:social_app/shared/dialogs/image_picker_dialog.dart';
import 'package:social_app/shared/components/navigator.dart';
import 'package:social_app/shared/components/snackbar.dart';

import '../../../data/app_data/user_data.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isPasswordShown = false;

  showPassword() {
    isPasswordShown = !isPasswordShown;
    emit(RegisterShowPasswordState());
  }

  showImagePickerDialog({required context}) {
    showDialog(
        context: context,
        builder: (context) => ImagePickerDialog(
              onGalleryPressed: () {
                pickPhoto(isCamera: false, context: context);
              },
              onCameraPressed: () {
                pickPhoto(isCamera: true, context: context);
              },
            ));
  }

  File? image;

  pickPhoto({required bool isCamera, required context}) async {
    PhotoPicker photoPicker = PhotoPicker.getInstance();
    photoPicker
        .pickPhoto(
      context: context,
      isCamera: isCamera,
    )
        .then((value) {
      image = value;
      emit(RegisterPickImageState());
    });
  }

  String gender = 'Male';

  changeGender({required gender}) {
    this.gender = gender;
    emit(RegisterChangeGenderState());
  }

  registerAccount(
      {required context,
      required email,
      required password,
      required userName,
      required phone}) {
    emit(RegisterLoadingState());
    RegisterUser accountCreation = RegisterUser.getInstance();
    userModel = UserModel(
        uid: '',
        name: userName,
        email: email,
        phone: phone,
        gender: gender,
        photo: '',
        coverPhoto: '');
    accountCreation.registerAccount(
        context: context,
        email: email,
        password: password,
        userModel: userModel!,
        profileImage: image,
        onSuccessAccountCreation: (value) {
          defaultSuccessSnackBar(
              message: 'Account created successfully', title: 'Register an email');
          navigateToAndRemoveUntil(context: context, routeName: homeScreen);
          emit(RegisterSuccessState());
        },
        onErrorAuthListen: (error) {
          emit(RegisterErrorState());
        },
        onErrorAccountCreation: (error, user) {
          defaultErrorSnackBar(
              message: 'Failed to registering account', title: 'Register an email');
          user?.delete();
          emit(RegisterErrorState());
        });
  }
}
