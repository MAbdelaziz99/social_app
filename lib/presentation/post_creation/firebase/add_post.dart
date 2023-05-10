import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:social_app/data/models/post_model.dart';
import 'package:social_app/shared/firebase/upload_image.dart';

class AddPost {
  static AddPost instance = AddPost();

  static AddPost getInstance() => instance;

  addPost(
      {required postText,
      required List<Map<String, dynamic>> images,
      required Function(dynamic) onSuccessListen,
      required Function onErrorListen}) async {
    String postId = DateTime.now().millisecondsSinceEpoch.toString();
    List<Map<String, dynamic>> imageMaps = [];
    if (images.isEmpty) {
      uploadPostToDB(
          postId: postId,
          postText: postText,
          images: images,
          onSuccessListen: onSuccessListen,
          onErrorListen: onErrorListen);
    } else {
      int i = 0;
      for (Map<String, dynamic> imageMap in images) {
        i++;
        File image = imageMap['image'];
        UploadImage.getInstance.uploadImage(
            imageFile: image,
            imagePath: 'posts/post_${i - 1}_$postId',
            onErrorUploadImage: onErrorListen,
            onSuccessUploadImage: (imageUrl) {
              imageMaps.add({
                'image': imageUrl.toString(),
                'imageHeight': imageMap['imageHeight'].toString(),
                'imageWidth': imageMap['imageWidth'].toString(),
              });
              if (i == images.length-1) {
                uploadPostToDB(
                    postId: postId,
                    postText: postText,
                    images: imageMaps,
                    onSuccessListen: onSuccessListen,
                    onErrorListen: onErrorListen);
              }
            });
      }
    }
  }

  uploadPostToDB(
      {required postId,
      required postText,
      required List<Map<String, dynamic>> images,
      required Function(dynamic) onSuccessListen,
      required Function onErrorListen}) {
    var sdf = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    final String postTime = sdf.format(DateTime.now());

    PostModel postModel = PostModel(
        postId: postId,
        postText: postText,
        postTime: postTime,
        userId: FirebaseAuth.instance.currentUser?.uid,
        images: images);

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .set(postModel.toMap())
        .then(onSuccessListen)
        .catchError(onErrorListen);
  }
}
