import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/data/models/comment_model.dart';

class LikeComment {
  static final LikeComment _instance = LikeComment();

  static LikeComment getInstance() => _instance;

  likeComment(
      {required CommentModel commentModel,
      required postId,
      required Function onLikeSuccessListen,
      required Function onLikeErrorListen}) {
    var commentRef = FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentModel.commentId);

    commentRef.collection('likes').get().then((value) async {
      List<String> users = [];
      for (var element in value.docs) {
        users.add(element.id);
      }
      if (users.contains(FirebaseAuth.instance.currentUser?.uid)) {
        await commentRef
            .collection('likes')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .delete();
        onLikeSuccessListen();
      } else {
        await commentRef
            .collection('likes')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .set({'like': true}).then((value) {
          onLikeSuccessListen();
        });
      }
    }).catchError(onLikeErrorListen);
  }
}
