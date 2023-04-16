import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/presentation/login/cubit/login_states.dart';
import 'package:social_app/presentation/login/firebase/account_logging.dart';
import 'package:social_app/router/router_const.dart';
import 'package:social_app/shared/components/navigator.dart';
import 'package:social_app/shared/components/snackbar.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPasswordShown = false;

  showPassword() {
    isPasswordShown = !isPasswordShown;
    emit(LoginShowPasswordState());
  }

  loginUser({required context, required email, required password}) {
    emit(LoginLoadingState());
    AccountLogging accountLogging = AccountLogging.getInstance();
    accountLogging.loginUser(
        email: email,
        password: password,
        onLoginSuccessListen: ()
        {
          defaultSuccessSnackBar(message: 'You are logged in successful', context: context);
          navigateToAndRemoveUntil(context: context, routeName: homeScreen);
          emit(LoginSuccessState());
        },
        onLoginErrorListen: (error) {
          defaultErrorSnackBar(message: 'Email or password not correct, try again', context: context);
          emit(LoginErrorState());
        });
  }
}
