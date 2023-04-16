import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/data/data.dart';
import 'package:social_app/data/models/user_model.dart';

class LoginUserInfoGetting {
  static LoginUserInfoGetting instance = LoginUserInfoGetting();

  static LoginUserInfoGetting getInstance() => instance;

  getUser({required Function onLoginSuccessListen}) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .listen((event) {
          if(event.data() != null) {
            userModel = UserModel.fromJson(event.data());
          }
          onLoginSuccessListen();
    });
  }
}
