import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../data/models/post_model.dart';

class GetPostComments{
  static GetPostComments instance = GetPostComments();
  static GetPostComments getInstance() => instance;

  getComments(
      {required Function onSuccessListen,
        required PostModel postModel}) async {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postModel.postId)
        .collection('comments')
        .snapshots()
        .listen((event) {
      postModel.postComments = event.docs.length;
      onSuccessListen();
    });
  }

}