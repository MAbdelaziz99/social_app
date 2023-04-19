import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../data/models/post_model.dart';
import '../../../../data/models/user_model.dart';

class UsersGetData{
  static UsersGetData instance = UsersGetData();
  static UsersGetData getInstance() => instance;

  getPostsUsers({
    required PostModel postModel,
  }) async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(postModel.userId)
        .snapshots()
        .listen((event) {
      UserModel userModel = UserModel.fromJson(event.data());
      postModel.userModel = userModel;
    });
  }

}