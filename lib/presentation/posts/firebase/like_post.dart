import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/data/models/post_model.dart';

class LikePost {
  static LikePost instance = LikePost();

  static LikePost getInstance() => instance;

  likePost(
      {required PostModel postModel,
      required Function onLikeSuccessListen,
      required Function onLikeErrorListen}) {
    var postRef =
        FirebaseFirestore.instance.collection('posts').doc(postModel.postId);

    postRef.collection('likes').get().then((value) async {
      List<String> users = [];
      for (var element in value.docs) {
        users.add(element.id);
      }
      if (users.contains(FirebaseAuth.instance.currentUser?.uid)) {
        await postRef
            .collection('likes')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .delete();
        onLikeSuccessListen();
      } else {
        await postRef
            .collection('likes')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .set({'like': true}).then((value) {
          onLikeSuccessListen();
        });
      }
    }).catchError(onLikeErrorListen);
  }
}
