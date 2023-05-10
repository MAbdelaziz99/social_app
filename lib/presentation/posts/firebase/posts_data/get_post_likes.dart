import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../data/models/post_model.dart';

class GetPostLikes {
  static GetPostLikes instance = GetPostLikes();

  static GetPostLikes getInstance() => instance;

  getLikes(
      {required Map<String, bool> likedMap,
      required Function(Map<String, bool> likedMap) getLikedMap,
      required PostModel postModel}) async {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postModel.postId)
        .collection('likes')
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
      getLikedMap(likedMap);
    });
  }
}
