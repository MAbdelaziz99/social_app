import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:social_app/data/data.dart';
import 'package:social_app/data/models/post_model.dart';
import 'package:social_app/presentation/posts/firebase/posts_data/comments_getting.dart';
import 'package:social_app/presentation/posts/firebase/posts_data/images_getting.dart';
import 'package:social_app/presentation/posts/firebase/posts_data/likes_getting.dart';
import 'package:social_app/presentation/posts/firebase/posts_data/times_getting.dart';
import 'package:social_app/presentation/posts/firebase/posts_data/users_getting.dart';

import '../../../../data/models/user_model.dart';
import '../../../../shared/time_ago.dart';

class PostsGetting {
  static PostsGetting instance = PostsGetting();

  static PostsGetting getInstance() => instance;

  Future getPosts(
      {required context,
      required Function onSuccessListen,
      required Function onErrorListen}) async {
    UsersGetting usersGetting = UsersGetting.getInstance();
    LikesGetting likesGetting = LikesGetting.getInstance();
    CommentsGetting commentsGetting = CommentsGetting.getInstance();
    TimesGetting timesGetting = TimesGetting.getInstance();
    ImagesGetting imagesGetting = ImagesGetting.getInstance();

    FirebaseFirestore.instance
        .collection('Posts')
        .snapshots()
        .listen((event) async {
      allPosts = [];
      likedMap = {};
      sliderHeights = [];
      sliderIndexes = [];
      allImageHeights = [];
      for (var element in event.docs) {
        sliderIndexes.add(0);

        PostModel postModel = PostModel.fromJson(element.data());
        await usersGetting.getPostsUsers(
            onSuccessListen: onSuccessListen,
            onErrorListen: onErrorListen,
            postModel: postModel);

        await likesGetting.getLikes(
            onSuccessListen: onSuccessListen,
            onErrorListen: onErrorListen,
            postModel: postModel);

        await commentsGetting.getComments(
            onSuccessListen: onSuccessListen,
            onErrorListen: onErrorListen,
            postModel: postModel);

        await timesGetting.getTimes(
            onSuccessListen: onSuccessListen, postModel: postModel);

        imagesGetting.getImages(context: context, postModel: postModel, onSuccessListen: onSuccessListen);

        allPosts.add(postModel);
      }
      onSuccessListen();
    }).onError(onErrorListen);
    onSuccessListen();
  }
}
