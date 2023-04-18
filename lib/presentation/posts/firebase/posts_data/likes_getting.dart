import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../data/data.dart';
import '../../../../data/models/post_model.dart';

class LikesGetting {
  static LikesGetting instance = LikesGetting();

  static LikesGetting getInstance() => instance;

  getLikes(
      {required Function onSuccessListen,
      required Function onErrorListen,
      required PostModel postModel}) async {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postModel.postId)
        .collection('Likes')
        .snapshots()
        .listen((event) {
      postModel.postLikes = event.docs.length;
      List<String> userIds = [];

      for (var element in event.docs) {
        userIds.add(element.id);
      }
      if (userIds.contains(FirebaseAuth.instance.currentUser?.uid)) {
        likedMap.addAll({postModel.postId ?? '': true});
      } else {
        likedMap.addAll({postModel.postId ?? '': false});
      }
      onSuccessListen();
    }).onError(onErrorListen);
  }
}
