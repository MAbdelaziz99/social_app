import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../data/models/post_model.dart';

class LikesGetData {
  static LikesGetData instance = LikesGetData();

  static LikesGetData getInstance() => instance;

  getLikes(
      {required Map<String, bool> likedMap,
      required Function(Map<String, bool> likedMap) getLikedMap,
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
      getLikedMap(likedMap);
    });
  }
}
