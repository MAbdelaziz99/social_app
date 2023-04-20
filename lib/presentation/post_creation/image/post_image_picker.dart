import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/components/snackbar.dart';

class PostImagePicker {
  static PostImagePicker instance = PostImagePicker();

  static PostImagePicker getInstance() => instance;

  Future<List<Map<String, dynamic>>> pickImage(
      {required context,
      required isCamera,
      required Function(List<Map<String, dynamic>> imageMaps)
          onImagePickedListen}) async {
    List<Map<String, dynamic>> imageMaps = [];
    getImagePicker(isCamera: isCamera).then((imagesPicked) async {
      if (imagesPicked.isNotEmpty) {
        for (var element in imagesPicked) {
          File imageFile = File(element.path);
          var decodedImage =
              await decodeImageFromList(imageFile.readAsBytesSync());

          int imageHeight = decodedImage.height;
          int imageWidth = decodedImage.width;

          print('original height :: $imageHeight');

          Map<String, dynamic> imageMap = {
            'image': imageFile,
            'imageHeight': imageHeight.toString(),
            'imageWidth': imageWidth.toString(),
          };
          imageMaps.add(imageMap);
        }
      } else {
        imageMaps = [];
        defaultErrorSnackBar(
            message: 'No image selected', title: 'Pick an image');
      }
      Navigator.pop(context);
      onImagePickedListen(imageMaps);
    });
    return imageMaps;
  }

  Future<List<XFile>> getImagePicker({required isCamera}) async {
    XFile? imagePicker;
    List<XFile> imagesPicker = [];
    if (isCamera) {
      imagePicker = await ImagePicker().pickImage(source: ImageSource.camera);
      imagesPicker.add(imagePicker!);
    } else {
      imagesPicker = await ImagePicker().pickMultiImage();
    }
    return imagesPicker;
  }
}
