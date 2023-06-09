import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../data/models/post_model.dart';
import '../../../../data/models/user_model.dart';

class GetPostUsers{
  static GetPostUsers instance = GetPostUsers();
  static GetPostUsers getInstance() => instance;

  getPostsUsers({
    required PostModel postModel,
  }) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(postModel.userId)
        .snapshots()
        .listen((event) {
      UserModel userModel = UserModel.fromJson(event.data());
      postModel.userModel = userModel;
    });
  }

}