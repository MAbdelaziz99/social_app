import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/data/models/user_model.dart';

class LikesUsersGetting {
  static final LikesUsersGetting _instance = LikesUsersGetting();

  static LikesUsersGetting getInstance() => _instance;

  getUsers(
      {required Function(List<UserModel>) onSuccessListen,
      required CollectionReference<Map<String, dynamic>> likeRef}) {
    likeRef.snapshots().listen((likeEvent) {
      List<UserModel> users = [];
      for (var element in likeEvent.docs) {
        String userId = element.id;
        FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .snapshots()
            .listen((event) {
          UserModel userModel = UserModel.fromJson(event.data());
          users.add(userModel);
          onSuccessListen(users);
        });
      }
    });
  }
}
