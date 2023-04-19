import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class SearchUsersGetting {
  static final SearchUsersGetting _instance = SearchUsersGetting();

  static SearchUsersGetting getInstance() => _instance;
  getUsers(
      {required Function(QuerySnapshot<Map<String, dynamic>>)
          onSuccessListen}) async {
    return FirebaseFirestore.instance
        .collection('Users')
        .snapshots()
        .listen(onSuccessListen);
  }
}
