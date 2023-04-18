class PostModel {
  String? postId, postText, postTime, userId;
  List<dynamic> images = [];

  PostModel({
    required this.postId,
    required this.postText,
    required this.postTime,
    required this.userId,
    required this.images,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    postText = json['postText'];
    postTime = json['postTime'];
    userId = json['userId'];
    images = json['images'] as List<dynamic>;
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'postText': postText,
      'postTime': postTime,
      'userId': userId,
      'images': images,
    };
  }
}
