import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/presentation/comments/firebase/comment_data/get_comment_likes.dart';
import 'package:social_app/presentation/comments/firebase/comment_data/get_comments_times.dart';
import 'package:social_app/presentation/comments/firebase/comment_data/get_comments_users.dart';

import '../../../../data/models/comment_model.dart';

class GetComments {
  static final GetComments _instance = GetComments();

  static GetComments getInstance() => _instance;

  getComments(
      {required postId,
      required Function(List<CommentModel> commentModels)
          onGetCommentsSuccessListen,
      required Function(Map<String, bool> likedMap) getLikedMap,
      required Function onGetAllCommentsSuccessListen,
      required Function(dynamic error) onErrorListen}) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Comments')
        .snapshots()
        .listen((event) {
      List<CommentModel> commentModels = [];
      Map<String, bool> likedMap = {};
      for (var element in event.docs) {
        CommentModel commentModel = CommentModel.fromJson(element.data());

        GetCommentsUsers.getInstance().getUsers(
            commentModel: commentModel,
            onGetUsersSuccessListen: onGetAllCommentsSuccessListen);

        GetCommentsTimes.getInstance().getTimes(commentModel: commentModel);

        GetCommentLikes.getInstance().getLikes(
            likedMap: likedMap,
            getLikedMap: getLikedMap,
            commentModel: commentModel);
        commentModels.add(commentModel);


        onGetCommentsSuccessListen(commentModels);
      }
      onGetAllCommentsSuccessListen();
    }).onError(onErrorListen);
  }
}
