import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:social_app/data/data.dart';
import 'package:social_app/data/models/post_model.dart';

import '../../../data/models/user_model.dart';
import '../../../shared/time_ago.dart';

class PostsData {
  static PostsData instance = PostsData();

  static PostsData getInstance() => instance;

  Future getPosts(
      {required Function onSuccessListen,
      required Function onErrorListen}) async {
    FirebaseFirestore.instance
        .collection('Posts')
        .snapshots()
        .listen((event) async {
      allPosts = [];
      likedMap = {};
      for (var element in event.docs) {
        PostModel postModel = PostModel.fromJson(element.data());

        await getPostsUsers(
            onSuccessListen: onSuccessListen,
            onErrorListen: onErrorListen,
            postModel: postModel);

        await getLikes(
            onSuccessListen: onSuccessListen,
            onErrorListen: onErrorListen,
            postModel: postModel);

        await getComments(
            onSuccessListen: onSuccessListen,
            onErrorListen: onErrorListen,
            postModel: postModel);

        await getTimes(
            onSuccessListen: onSuccessListen,
            onErrorListen: onErrorListen,
            postModel: postModel);

        allPosts.add(postModel);
      }
      onSuccessListen();
    }).onError(onErrorListen);
    onSuccessListen();
  }

  getPostsUsers({
    required Function onSuccessListen,
    required Function onErrorListen,
    required PostModel postModel,
  }) async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(postModel.userId)
        .snapshots()
        .listen((event) {
      UserModel userModel = UserModel.fromJson(event.data());
      postModel.userModel = userModel;
      onSuccessListen();
    }).onError(onErrorListen);
  }

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

  getComments(
      {required Function onSuccessListen,
      required Function onErrorListen,
      required PostModel postModel}) async {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postModel.postId)
        .collection('Comments')
        .snapshots()
        .listen((event) {
      postModel.postComments = event.docs.length;
      onSuccessListen();
    }).onError(onErrorListen);
  }

  getTimes(
      {required Function onSuccessListen,
      required Function onErrorListen,
      required PostModel postModel}) {
    DateTime sdf = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        .parse(postModel.postTime ?? '');

    int millisecond = sdf.millisecondsSinceEpoch;
    String? time = TimeAgo.getTimeAgo(millisecond);
    postModel.postTime = time;
  }
}
