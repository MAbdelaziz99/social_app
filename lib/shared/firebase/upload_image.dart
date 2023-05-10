import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class UploadImage {
  static UploadImage getInstance = UploadImage();

  uploadImage({
    required File imageFile,
    required String imagePath,
    required Function onErrorUploadImage,
    required Function(String) onSuccessUploadImage,
  }) {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child(imagePath);
    ref.putFile(imageFile).snapshotEvents.listen((TaskSnapshot event) {
      switch (event.state) {
        case TaskState.paused:
          break;
        case TaskState.running:
          break;
        case TaskState.success:
          ref.getDownloadURL().then(onSuccessUploadImage);
          break;
        case TaskState.canceled:
          onErrorUploadImage();
          break;
        case TaskState.error:
          onErrorUploadImage();
          break;
      }
    });
  }
}
