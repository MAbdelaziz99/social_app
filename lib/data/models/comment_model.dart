import 'package:social_app/data/models/user_model.dart';

class CommentModel {
  String? commentId, postId, commentText, commentTime, userId;
  int? commentLikes;
  UserModel? userModel;

  CommentModel(
      {required this.commentId,
      required this.postId,
      required this.commentText,
      required this.commentTime,
      required this.commentLikes,
      required this.userId});

  CommentModel.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    postId = json['postId'];
    commentText = json['commentText'];
    commentTime = json['commentTime'];
    userId = json['userId'];
    commentLikes = json['commentLikes'];
  }

  Map<String, dynamic> toMap() => {
        'commentId': commentId,
        'postId': postId,
        'commentText': commentText,
        'commentTime': commentTime,
        'userId': userId,
        'commentLikes': commentLikes,
      };
}
