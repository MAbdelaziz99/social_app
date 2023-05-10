import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/data/models/user_model.dart';

class GetLikesUsers {
  static final GetLikesUsers _instance = GetLikesUsers();

  static GetLikesUsers getInstance() => _instance;

  getUsers(
      {required Function(List<UserModel>) onSuccessListen,
      required Function(dynamic error) onErrorListen,
      required CollectionReference<Map<String, dynamic>> likeRef}) {
    likeRef.snapshots().listen((likeEvent) {
      List<UserModel> users = [];
      for (var element in likeEvent.docs) {
        String userId = element.id;
        FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .snapshots()
            .listen((event) {
          UserModel userModel = UserModel.fromJson(event.data());
          users.add(userModel);
          onSuccessListen(users);
        }).onError(onErrorListen);
      }
      onSuccessListen(users);
    }).onError(onErrorListen);
  }
}
