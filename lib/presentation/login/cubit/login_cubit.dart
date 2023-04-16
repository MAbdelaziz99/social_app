import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/presentation/login/cubit/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPasswordShown = false;

  showPassword() {
    isPasswordShown = !isPasswordShown;
    emit(LoginShowPasswordState());
  }
}
