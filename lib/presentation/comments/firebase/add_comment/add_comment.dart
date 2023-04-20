import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:social_app/data/app_data/user_data.dart';
import 'package:social_app/data/models/comment_model.dart';

class AddComment {
  static final AddComment _instance = AddComment();

  static AddComment getInstance() => _instance;

  addComment(
      {required postId,
      required TextEditingController commentController,
      required Function(void) onSuccessListen,
      required Function(dynamic) onErrorListen}) {
    String commentId = DateTime.now().millisecondsSinceEpoch.toString();

    var sdf = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    final String commentTime = sdf.format(DateTime.now());

    CommentModel commentModel = CommentModel(
        commentId: commentId,
        postId: postId,
        commentText: commentController.text,
        commentTime: commentTime,
        commentLikes: 0,
        userId: userModel?.uid);

    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Comments')
        .doc(commentId)
        .set(commentModel.toMap())
        .then(onSuccessListen)
        .catchError(onErrorListen);
  }
}
