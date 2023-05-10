import 'package:firebase_auth/firebase_auth.dart' as login_user;
import 'package:social_app/presentation/home/firebase/get_user.dart';

class LoginUser {
  static LoginUser instance = LoginUser();

  static LoginUser getInstance() => instance;

  Future loginUser(
      {required email,
      required password,
      required Function onLoginSuccessListen,
      required Function(dynamic) onLoginErrorListen}) async {
    login_user.FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      GetUser getUser = GetUser.getInstance();
      getUser.getUser(onGetUserListen: onLoginSuccessListen);
    }).catchError(onLoginErrorListen);
  }
}
