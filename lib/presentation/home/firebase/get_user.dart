import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/data/models/user_model.dart';

import '../../../data/app_data/user_data.dart';

class GetUser {
  static GetUser instance = GetUser();

  static GetUser getInstance() => instance;

  getUser({required Function onGetUserListen}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .listen((event) {
      if (event.data() != null) {
        userModel = UserModel.fromJson(event.data());
      }
      onGetUserListen();
    });
  }
}
