import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/data/data.dart';
import 'package:social_app/data/models/user_model.dart';

class HomeUserGetting {
  static HomeUserGetting instance = HomeUserGetting();

  static HomeUserGetting getInstance() => instance;

  getUser({required Function onGetUserListen}) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .listen((event) {
          if(event.data() != null) {
            userModel = UserModel.fromJson(event.data());
          }
          onGetUserListen();
    });
  }
}
