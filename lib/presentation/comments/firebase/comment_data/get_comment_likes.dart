import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/data/models/comment_model.dart';

class GetCommentLikes {
  static final GetCommentLikes _instance = GetCommentLikes();

  static GetCommentLikes getInstance() => _instance;

  getLikes(
      {required Map<String, bool> likedMap,
      required Function(Map<String, bool> likedMap) getLikedMap,
      required CommentModel commentModel}) async {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(commentModel.postId)
        .collection('comments')
        .doc(commentModel.commentId)
        .collection('likes')
        .snapshots()
        .listen((event) {
      commentModel.commentLikes = event.docs.length;
      List<String> userIds = [];
      for (var element in event.docs) {
        userIds.add(element.id);
      }
      if (userIds.contains(FirebaseAuth.instance.currentUser?.uid)) {
        likedMap.addAll({commentModel.commentId ?? '': true});
      } else {
        likedMap.addAll({commentModel.commentId ?? '': false});
      }
      getLikedMap(likedMap);
    });
  }
}
