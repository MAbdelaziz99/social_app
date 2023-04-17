import 'package:firebase_auth/firebase_auth.dart';

class PasswordFactory {
  static PasswordFactory instance = PasswordFactory();

  static PasswordFactory getInstance() => instance;

  Future resetPassword(
      {required email,
      required onResetPasswordSuccess,
      required onResetPasswordError}) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then(onResetPasswordSuccess)
        .catchError(onResetPasswordError);
  }
}
