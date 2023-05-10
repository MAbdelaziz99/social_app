import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/data/models/comment_model.dart';
import '../../../../data/models/user_model.dart';

class GetCommentsUsers {
  static final GetCommentsUsers _instance = GetCommentsUsers();

  static GetCommentsUsers getInstance() => _instance;

  getUsers(
      {required CommentModel commentModel,
      required Function onGetUsersSuccessListen}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(commentModel.userId)
        .snapshots()
        .listen((event) {
      UserModel userModel = UserModel.fromJson(event.data());
      commentModel.userModel = userModel;
      onGetUsersSuccessListen();
    });
  }
}
