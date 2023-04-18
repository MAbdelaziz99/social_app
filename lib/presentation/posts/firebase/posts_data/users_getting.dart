import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../data/models/post_model.dart';
import '../../../../data/models/user_model.dart';

class UsersGetting{
  static UsersGetting instance = UsersGetting();
  static UsersGetting getInstance() => instance;

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

}