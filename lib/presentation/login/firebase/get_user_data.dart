import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/app_data/user_data.dart';
import '../../../data/models/user_model.dart';

class GetUserData {
  static GetUserData getInstance() => GetUserData();

  getUser({required Function onGetUserListen}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((event) {
      if (event.data() != null) {
        userModel = UserModel.fromJson(event.data());
      }
      onGetUserListen();
    });
  }
}
