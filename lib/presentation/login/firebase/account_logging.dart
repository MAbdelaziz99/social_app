import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/presentation/login/firebase/login_user_info_getting.dart';

class AccountLogging {
  static AccountLogging instance = AccountLogging();
  static AccountLogging getInstance()=> instance;

  Future loginUser({required email, required password, required Function onLoginSuccessListen, required Function(dynamic) onLoginErrorListen}) async
  {
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value)
    {
      LoginUserInfoGetting loginUserInfoGetting = LoginUserInfoGetting.getInstance();
      loginUserInfoGetting.getUser(onLoginSuccessListen: onLoginSuccessListen);
    })
    .catchError(onLoginErrorListen);
  }


}