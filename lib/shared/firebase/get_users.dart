import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/data/models/user_model.dart';

class GetUsers {
  static GetUsers getInstance = GetUsers();

  getUsers(
      {required Function(List<UserModel> users) onSuccessListen,
      required Function(dynamic) onErrorListen}) {
    FirebaseFirestore.instance.collection('users').snapshots().listen((event) {
      List<UserModel> users = [];
      for (var element in event.docs) {
        UserModel userModel = UserModel.fromJson(element.data());
        if (userModel.uid != FirebaseAuth.instance.currentUser?.uid) {
          users.add(userModel);
        }
      }
      onSuccessListen(users);
    }).onError(onErrorListen);
  }
}
