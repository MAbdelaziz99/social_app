import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/components/snackbar.dart';

class PhotoPicker {
  final ImagePicker imagePicker = ImagePicker();

  static PhotoPicker instance = PhotoPicker();

  static PhotoPicker getInstance() => instance;

  Future<File?> pickPhoto({required context, required bool isCamera}) async {
    File? image;
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
      Navigator.pop(context);
      image = null;
      defaultErrorSnackBar(message: 'No image selected', context: context);
    }
    return image;
  }
}
