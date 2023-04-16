import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_app/data/data.dart';
import 'package:social_app/data/models/user_model.dart';
import 'package:social_app/shared/components/snackbar.dart';
import 'package:uuid/uuid.dart';

class AccountCreation {
  static AccountCreation registerAuth = AccountCreation();

  static AccountCreation getInstance() => registerAuth;

  registerAccount({required context,
    required email,
    required password,
    required UserModel userModel,
    required File profileImage,
    required Function(void) onSuccessAccountCreation,
    required Function onErrorListen}) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
          userModel.uid = value.user!.uid;
      uploadUserPhotoToFirebaseStorage(profileImage: profileImage, onSuccessAccountCreation: onSuccessAccountCreation);
    }).catchError((error) {
      isEmailAddressAlreadyExistToShowError(context: context, email: email);
      onErrorListen();
    });
  }

  isEmailAddressAlreadyExistToShowError({required context, required email}) {
    FirebaseFirestore.instance
        .collection('Users')
        .where('userEmail', isEqualTo: email)
        .snapshots()
        .listen((event) {
      if (event.docs.isEmpty) {
        defaultErrorSnackBar(
            message: "Please enter correct email address", context: context);
      } else {
        defaultErrorSnackBar(
            message: "Email address is already exist, enter another email",
            context: context);
      }
    });
  }

  uploadUserPhotoToFirebaseStorage({required File profileImage, required Function(void) onSuccessAccountCreation})
  {
    var uniqueId = const Uuid().v4();
    Reference ref = FirebaseStorage.instance
        .ref('profile_pictures/')
        .child('${FirebaseAuth.instance.currentUser?.uid}&$uniqueId');
    ref.putFile(profileImage).snapshotEvents.listen((TaskSnapshot event) {
      switch(event.state){

        case TaskState.paused:
          // TODO: Handle this case.
          break;
        case TaskState.running:
          // TODO: Handle this case.
          break;
        case TaskState.success:
          ref.getDownloadURL().then((photoUrl){
            userModel?.photo = photoUrl;
            insertUserDataToFirebase(onSuccessAccountCreation: onSuccessAccountCreation);
          });
          break;
        case TaskState.canceled:
          // TODO: Handle this case.
          break;
        case TaskState.error:
          // TODO: Handle this case.
          break;
      }
    });
  }

  insertUserDataToFirebase({required Function(void) onSuccessAccountCreation}) {
    FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser?.uid).set(userModel!.toMap()).then(onSuccessAccountCreation).catchError((error) {});
  }
}
