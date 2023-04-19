import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../data/models/post_model.dart';

class CommentsGetting{
  static CommentsGetting instance = CommentsGetting();
  static CommentsGetting getInstance() => instance;

  getComments(
      {required Function onSuccessListen,
        required PostModel postModel}) async {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postModel.postId)
        .collection('Comments')
        .snapshots()
        .listen((event) {
      postModel.postComments = event.docs.length;
      onSuccessListen();
    });
  }

}