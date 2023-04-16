import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/presentation/register/cubit/register_states.dart';
import 'package:social_app/shared/components/image_picker_dialog.dart';
import 'package:social_app/shared/components/snackbar.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isPasswordShown = false;

  showPassword() {
    isPasswordShown = !isPasswordShown;
    emit(RegisterShowPasswordState());
  }

  bool isPasswordConfirmationShown = false;

  showPasswordConfirmation() {
    isPasswordConfirmationShown = !isPasswordConfirmationShown;
    emit(RegisterShowPasswordState());
  }

  showImagePickerDialog({required context}) {
    showDialog(
        context: context, builder: (context) => const PhotoPickerDialog());
  }

  final ImagePicker imagePicker = ImagePicker();
  File? image;

  pickPhoto({required bool isCamera, required context}) async {
    XFile? pickedFile;
    if (isCamera) {
      pickedFile = await imagePicker.pickImage(
        source: ImageSource.camera,
      );
    } else {
      pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
      );
    }
    if (pickedFile != null) {
      image = File(pickedFile.path);
      Navigator.pop(context);
    } else {
      defaultErrorSnackBar(message: 'No image selected', context: context);
    }
    emit(RegisterPickImageState());
  }
}
