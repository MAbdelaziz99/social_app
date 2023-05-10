import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/data/models/user_model.dart';
import 'package:social_app/presentation/register/firebase/upload_user_data.dart';
import 'package:social_app/shared/components/snackbar.dart';
import 'package:social_app/shared/firebase/upload_image.dart';
import 'package:uuid/uuid.dart';

class RegisterUser {
  static RegisterUser instance = RegisterUser();

  static RegisterUser getInstance() => instance;

  registerAccount(
      {required context,
      required email,
      required password,
      required UserModel userModel,
      required File? profileImage,
      required Function(void) onSuccessAccountCreation,
      required Function(void, User? user) onErrorAccountCreation,
      required Function(dynamic) onErrorAuthListen}) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userModel.uid = value.user?.uid;
      if (profileImage == null) {
        UploadUserData.getInstance.uploadUser(
            onSuccessAccountCreation: onSuccessAccountCreation,
            onErrorAccountCreation: (error) =>
                onErrorAccountCreation(error, value.user));
      } else {
        var uniqueId = const Uuid().v4();

        UploadImage.getInstance.uploadImage(
            imageFile: profileImage,
            imagePath:
                'profile_pictures/${FirebaseAuth.instance.currentUser?.uid}&$uniqueId',
            onErrorUploadImage: onErrorAccountCreation,
            onSuccessUploadImage: (profileUrl) {
              userModel.photo = profileUrl;
              UploadUserData.getInstance.uploadUser(
                  onSuccessAccountCreation: onSuccessAccountCreation,
                  onErrorAccountCreation: (error) =>
                      onErrorAccountCreation(error, value.user));
            });
      }
    }).catchError((error) {
      isEmailAddressAlreadyExistToShowError(context: context, email: email);
      onErrorAuthListen(error);
    });
  }

  isEmailAddressAlreadyExistToShowError({required context, required email}) {
    FirebaseFirestore.instance
        .collection('users')
        .where('userEmail', isEqualTo: email)
        .get()
        .then((event) {
      if (event.docs.isEmpty) {
        defaultErrorSnackBar(
            message: "Please enter correct email address",
            title: 'Register an email');
      } else {
        defaultErrorSnackBar(
            message: "Email address is already exist, enter another email",
            title: 'Register an email');
      }
    });
  }
}
