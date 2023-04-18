import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:social_app/data/models/post_model.dart';

class PostUploading {
  static PostUploading instance = PostUploading();

  static PostUploading getInstance() => instance;

  uploadPostWithImagesToDB(
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
      Reference? ref;

      for (Map<String, dynamic> imageMap in images) {
        File image = imageMap['image'];
        ref =
            FirebaseStorage.instance.ref().child('Posts/post_${i - 1}_$postId');

        await ref.putFile(image).whenComplete(() async {
          await ref?.getDownloadURL().then((value) {
            imageMaps.add({
              'image': value.toString(),
              'imageHeight': imageMap['imageHeight'].toString(),
              'imageWidth': imageMap['imageWidth'].toString(),
            });
            if (i == images.length - 1) {
              uploadPostToDB(
                  postId: postId,
                  postText: postText,
                  images: imageMaps,
                  onSuccessListen: onSuccessListen,
                  onErrorListen: onErrorListen);
            }
          });
        });
        i++;
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
        .collection('Posts')
        .doc(postId)
        .set(postModel.toMap())
        .then(onSuccessListen)
        .catchError(onErrorListen);
  }
}
