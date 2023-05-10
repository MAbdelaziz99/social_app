import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/app_data/user_data.dart';

class UploadUserData {
  static UploadUserData getInstance = UploadUserData();

  uploadUser(
      {required Function(void) onSuccessAccountCreation,
      required Function onErrorAccountCreation}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(userModel!.toMap())
        .then(onSuccessAccountCreation)
        .catchError(onErrorAccountCreation);
  }
}
