import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/data/data.dart';

class PostLiking {
  static PostLiking instance = PostLiking();

  static PostLiking getInstance() => instance;

  likePost(
      {required index,
      required Function onLikeSuccessListen,
      required Function onLikeErrorListen}) {
    var postRef = FirebaseFirestore.instance
        .collection('Posts')
        .doc(allPosts[index].postId);

    postRef.collection('Likes').get().then((value) async {
      List<String> users = [];
      for (var element in value.docs) {
        users.add(element.id);
      }
      if (users.contains(FirebaseAuth.instance.currentUser?.uid)) {
        await postRef
            .collection('Likes')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .delete();
        allPosts[index].isLiked = false;
      } else {
        await postRef
            .collection('Likes')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .set({'like': true}).then((value) {
          allPosts[index].isLiked = true;
          onLikeSuccessListen();
        });
      }
    }).catchError(onLikeErrorListen);
  }
}
